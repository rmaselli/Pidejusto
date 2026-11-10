import { and, desc, eq, inArray, sql } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import {
  bitacora,
  bodegas,
  solicitudLineas,
  solicitudes,
  sequences,
  articulos,
  empresas,
  existencias,
  consumoTrimestral,
  tiposDocumento,
} from "@pidejusto/db";
import {
  abiertasQty,
  alerta,
  baseProy,
  calcMinMax,
  canApprove,
  cadenaNiveles,
  codigoDeRol,
  COMPROMETEN,
  consolidar,
  contableFrom,
  disponible,
  estadoPendiente,
  evalBudget,
  filasPost,
  nextEstadoAfterApprove,
  nivelDeEstado,
  pad,
  rutaConNivelesActivos,
  rutaDe,
  sugerida,
  type ContableImputacion,
  type LineaSolicitud,
  type SolicitudEstado,
  type UserInfo,
} from "@pidejusto/shared";
import {
  getContableContext,
  getMatriz,
  getParams,
  listNiveles,
  presupuestoBase,
} from "./catalog.js";
import { resolveTransaccion, allocateDocumentNumber } from "./maestros.js";
import type { SapProvider } from "../sap/index.js";
import { config } from "../config.js";

async function nextSeq(db: Db, name: "req" | "doc") {
  const [seq] = await db
    .update(sequences)
    .set({ value: sql`${sequences.value} + 1` })
    .where(eq(sequences.name, name))
    .returning();
  return seq.value;
}

async function loadOpenReqs(db: Db) {
  const reqs = await db.select().from(solicitudes);
  const ids = reqs.map((r) => r.id);
  const lines =
    ids.length === 0
      ? []
      : await db
          .select()
          .from(solicitudLineas)
          .where(inArray(solicitudLineas.solicitudId, ids));
  const byReq = new Map<string, typeof lines>();
  for (const l of lines) {
    const arr = byReq.get(l.solicitudId) || [];
    arr.push(l);
    byReq.set(l.solicitudId, arr);
  }
  return reqs.map((r) => ({
    id: r.id,
    emp: r.empresa,
    estado: r.estado as SolicitudEstado,
    requiredDate: r.requiredDate,
    lines: (byReq.get(r.id) || []).map((l) => ({
      emp: l.empresa,
      code: l.itemCode,
      name: l.itemName,
      cat: l.categoria,
      qty: l.qty,
      price: l.price,
      total: l.total,
      sug: l.sug,
      alerta: l.alerta,
      just: l.justificacion || "",
      disp: l.disp || 0,
      min: l.min || 0,
      max: l.max || 0,
      ct: l.contable as ContableImputacion,
    })),
  }));
}

export async function previewLine(
  db: Db,
  input: {
    empresa: string;
    itemCode: string;
    qty: number;
    contable?: Partial<ContableImputacion>;
    justificacion?: string;
  },
) {
  const params = await getParams(db);
  const [art] = await db
    .select()
    .from(articulos)
    .where(
      and(
        eq(articulos.empresa, input.empresa),
        eq(articulos.itemCode, input.itemCode),
      ),
    )
    .limit(1);
  if (!art) throw new Error("Artículo no encontrado");

  const [ex] = await db
    .select()
    .from(existencias)
    .where(
      and(
        eq(existencias.empresa, input.empresa),
        eq(existencias.itemCode, input.itemCode),
      ),
    )
    .limit(1);
  const [con] = await db
    .select()
    .from(consumoTrimestral)
    .where(
      and(
        eq(consumoTrimestral.empresa, input.empresa),
        eq(consumoTrimestral.itemCode, input.itemCode),
      ),
    )
    .limit(1);

  const stock = {
    ex: ex?.existencia || 0,
    ped: ex?.enPedido || 0,
    com: ex?.comprometido || 0,
  };
  const consumo = con ? [con.t0, con.t1, con.t2, con.t3] : [0, 0, 0, 0];
  const mm = calcMinMax(consumo, art.leadTimeDias, art.precioProm, params);
  const open = await loadOpenReqs(db);
  const key = `${input.empresa}|${input.itemCode}`;
  const base = baseProy(disponible(stock), abiertasQty(open, key));
  const sug = sugerida(base, mm.min, mm.max);
  const al = alerta(base, input.qty, mm);

  const ctx = await getContableContext(db, input.empresa);
  const cat = ctx.catcta.find((c) => c.categoria === art.categoria);
  const prefer6 = ctx.mcx.some((r) => r[1] === "6");
  const defaultCta =
    input.contable?.cta ||
    (prefer6 ? cat?.cuenta6 : cat?.cuenta7) ||
    cat?.cuenta6 ||
    cat?.cuenta7 ||
    "";
  const centers = ctx.mcx.filter((r) => r[1] === String(defaultCta)[0]);
  const row = centers[0] || null;
  const requirePlaca = !!cat?.requierePlaca;
  const ct = contableFrom(
    defaultCta,
    row,
    input.contable || {},
    ctx.keys,
    ctx.anexo,
    requirePlaca,
    !!cat?.requiereObra || String(defaultCta).startsWith("1210"),
  );

  const line: LineaSolicitud = {
    emp: input.empresa,
    code: art.itemCode,
    name: art.itemName,
    cat: art.categoria,
    qty: input.qty,
    price: art.precioProm,
    total: +(input.qty * art.precioProm).toFixed(2),
    sug,
    alerta: al.tipo,
    just: input.justificacion || "",
    disp: disponible(stock),
    min: mm.min,
    max: mm.max,
    corp: art.codigoCorporativo || undefined,
    ct,
  };

  return { line, alerta: al, mm, base, consumo, stock, centros: centers, ctaName: ctx.cta };
}

export async function createSolicitud(
  db: Db,
  user: UserInfo,
  body: {
    lines: {
      itemCode: string;
      qty: number;
      justificacion?: string;
      contable?: Partial<ContableImputacion>;
    }[];
    requiredDate: string;
    comentario?: string;
    empresa?: string;
    bodegaCodigo?: string;
    tipoDocumento?: string;
  },
) {
  if (user.rol !== "Solicitante" && user.rol !== "Admin") {
    throw Object.assign(new Error("Solo solicitantes pueden crear"), { status: 403 });
  }
  if (!body.lines?.length) throw Object.assign(new Error("Sin líneas"), { status: 400 });

  const empresa =
    user.emp === "TODAS" ? String(body.empresa || "").trim() : user.emp;
  if (!empresa || empresa === "TODAS") {
    throw Object.assign(new Error("Indique la empresa de la solicitud"), {
      status: 400,
    });
  }
  const docMeta = await resolveTransaccion(
    db,
    empresa,
    body.bodegaCodigo,
    body.tipoDocumento,
  );
  const built: LineaSolicitud[] = [];
  for (const l of body.lines) {
    const prev = await previewLine(db, {
      empresa,
      itemCode: l.itemCode,
      qty: l.qty,
      justificacion: l.justificacion,
      contable: l.contable,
    });
    if (prev.alerta.exige && !String(l.justificacion || "").trim() && l.qty !== prev.line.sug) {
      throw Object.assign(
        new Error(`Línea ${l.itemCode}: ${prev.alerta.msg}`),
        { status: 400 },
      );
    }
    if (!prev.line.ct.ok) {
      throw Object.assign(
        new Error(`Línea ${l.itemCode}: imputación contable inválida`),
        { status: 400 },
      );
    }
    built.push({ ...prev.line, just: l.justificacion || prev.line.just });
  }

  const open = await loadOpenReqs(db);
  const { rows: presupRows } = await presupuestoBase(db, empresa);
  const getDisp = (emp: string, cat: string) => {
    const base = presupRows.find((r) => r.empresa === emp && r.categoria === cat);
    const presup = base?.presup || 0;
    const ejec = base?.ejec || 0;
    let comp = 0;
    for (const r of open) {
      if (r.emp !== emp) continue;
      if (!COMPROMETEN.includes(r.estado as SolicitudEstado)) continue;
      for (const ln of r.lines) if (ln.cat === cat) comp += ln.total;
    }
    return presup - ejec - comp;
  };

  const bud = evalBudget(empresa, built, getDisp);
  const matriz = await getMatriz(db);
  const rutaBase = rutaDe(matriz, bud.total, bud.dentro);
  const defs = await listNiveles(db);
  const activos = new Set(defs.filter((d) => d.activo).map((d) => d.codigo));
  const ruta = {
    ...rutaBase,
    niveles: rutaConNivelesActivos(rutaBase.niveles, activos),
  };
  const steps = cadenaNiveles(ruta.niveles);
  const docNum = await allocateDocumentNumber(
    db,
    empresa,
    docMeta.tipo,
    docMeta.bodega,
  );
  const doc = { ...docMeta, docNum };

  const n = await nextSeq(db, "req");
  const id = `SC-${new Date().getFullYear()}-${pad(n, 4)}`;
  let estado: SolicitudEstado = steps[0] ? estadoPendiente(steps[0]) : "Aprobada";
  const logs: { user: string; accion: string; detalle: string }[] = [
    {
      user: "Sistema",
      accion: "Validación presupuesto",
      detalle: bud.dentro
        ? "Dentro de presupuesto"
        : `Fuera de presupuesto · ${ruta.regla}`,
    },
  ];

  if (!steps.length) {
    estado = "Aprobada";
    logs.push({
      user: "Sistema",
      accion: "Aprobación automática",
      detalle: "Dentro de presupuesto: pasa directo a Bodega",
    });
  } else {
    const primero = defs.find((d) => d.codigo === steps[0]);
    logs.push({
      user: "Sistema",
      accion: estado,
      detalle: primero?.descripcion || `Enviada a ${primero?.nombre || steps[0]}`,
    });
  }

  await db.insert(solicitudes).values({
    id,
    empresa,
    solicitanteId: user.id,
    solicitanteNombre: user.nombre,
    estado,
    total: +bud.total.toFixed(2),
    dentroPresupuesto: bud.dentro,
    ruta,
    bud,
    requiredDate: body.requiredDate,
    comentario: body.comentario || "",
    bodegaCodigo: doc.bodega,
    tipoDocumento: doc.tipo,
    docNum: doc.docNum,
    companyDb: doc.companyDb,
    approvedAt: estado === "Aprobada" ? new Date() : null,
  });

  await db.insert(solicitudLineas).values(
    built.map((l) => ({
      solicitudId: id,
      empresa: l.emp,
      itemCode: l.code,
      itemName: l.name,
      categoria: l.cat,
      qty: l.qty,
      price: l.price,
      total: l.total,
      sug: l.sug,
      alerta: l.alerta,
      justificacion: l.just,
      disp: l.disp,
      min: l.min,
      max: l.max,
      contable: l.ct,
    })),
  );

  await db.insert(bitacora).values(
    logs.map((l) => ({
      solicitudId: id,
      userName: l.user,
      accion: l.accion,
      detalle: l.detalle,
    })),
  );

  await db.insert(bitacora).values({
    solicitudId: id,
    userName: user.nombre,
    accion: "Creó solicitud",
    detalle: `${built.length} línea(s) · ${ruta.regla} · ${doc.tipo} ${doc.docNum} · bodega ${doc.bodega}`,
  });

  return getSolicitud(db, id);
}

export async function getSolicitud(db: Db, id: string) {
  const [req] = await db.select().from(solicitudes).where(eq(solicitudes.id, id)).limit(1);
  if (!req) return null;
  const lines = await db
    .select()
    .from(solicitudLineas)
    .where(eq(solicitudLineas.solicitudId, id));
  const bit = await db
    .select()
    .from(bitacora)
    .where(eq(bitacora.solicitudId, id))
    .orderBy(bitacora.ts);
  return {
    ...req,
    lines: lines.map((l) => ({
      emp: l.empresa,
      code: l.itemCode,
      name: l.itemName,
      cat: l.categoria,
      qty: l.qty,
      price: l.price,
      total: l.total,
      sug: l.sug,
      alerta: l.alerta,
      just: l.justificacion || "",
      disp: l.disp || 0,
      min: l.min || 0,
      max: l.max || 0,
      ct: l.contable as ContableImputacion,
    })),
    bit: bit.map((b) => ({
      ts: b.ts?.toISOString() || "",
      user: b.userName,
      accion: b.accion,
      detalle: b.detalle || "",
    })),
  };
}

export async function listSolicitudes(
  db: Db,
  user: UserInfo,
  filter?: { mine?: boolean; estado?: string },
) {
  let rows = await db.select().from(solicitudes).orderBy(desc(solicitudes.createdAt));
  if (filter?.mine) rows = rows.filter((r) => r.solicitanteId === user.id);
  if (filter?.estado) rows = rows.filter((r) => r.estado === filter.estado);

  const codigoRol = codigoDeRol(user.rol);
  if (codigoRol) {
    const defs = await listNiveles(db);
    const cfg = defs.find((d) => d.codigo === codigoRol);
    const alcance = cfg?.alcance ?? (codigoRol === "N1" ? "empresa" : "todas");
    if (alcance === "empresa" && user.emp !== "TODAS") {
      rows = rows.filter((r) => r.empresa === user.emp);
    }
  }
  if (user.rol === "Solicitante") {
    rows = rows.filter((r) => r.solicitanteId === user.id || r.empresa === user.emp);
  }
  return rows;
}

export async function pendientes(db: Db, user: UserInfo) {
  const rows = await db.select().from(solicitudes).orderBy(desc(solicitudes.createdAt));
  const defs = await listNiveles(db);
  const filtered = rows.filter((r) => {
    if (user.rol === "Admin") return nivelDeEstado(r.estado) !== null;
    return canApprove(
      { estado: r.estado as SolicitudEstado, emp: r.empresa },
      user,
      defs,
    );
  });
  const out = [];
  for (const r of filtered) {
    const full = await getSolicitud(db, r.id);
    if (full) out.push(full);
  }
  return out;
}

export async function historialAprobador(db: Db, user: UserInfo) {
  const tag = codigoDeRol(user.rol);
  const bits = await db.select().from(bitacora);
  const ids = new Set(
    bits
      .filter(
        (b) =>
          b.userName === user.nombre &&
          /^(Aprobó|Rechazó)/.test(b.accion) &&
          (tag ? b.accion.includes(tag) : user.rol === "Admin"),
      )
      .map((b) => b.solicitudId),
  );
  const out = [];
  for (const id of ids) {
    const full = await getSolicitud(db, id);
    if (full) out.push(full);
  }
  return out;
}

export async function aprobarSolicitud(
  db: Db,
  user: UserInfo,
  id: string,
  comentario?: string,
) {
  const req = await getSolicitud(db, id);
  if (!req) throw Object.assign(new Error("No encontrada"), { status: 404 });
  const nivel = nivelDeEstado(req.estado);
  if (!nivel) {
    throw Object.assign(new Error("La solicitud no está pendiente de aprobación"), {
      status: 400,
    });
  }
  const defs = await listNiveles(db);
  const mini = { estado: req.estado as SolicitudEstado, emp: req.empresa };
  if (!canApprove(mini, user, defs) && user.rol !== "Admin") {
    throw Object.assign(new Error("No puede aprobar esta solicitud"), { status: 403 });
  }
  const ruta = req.ruta as { niveles: string; regla: string };
  const next = nextEstadoAfterApprove(req.estado as SolicitudEstado, ruta.niveles);

  await db
    .update(solicitudes)
    .set({
      estado: next,
      approvedAt: next === "Aprobada" ? new Date() : req.approvedAt,
    })
    .where(eq(solicitudes.id, id));

  await db.insert(bitacora).values({
    solicitudId: id,
    userName: user.nombre,
    accion: `Aprobó ${nivel}`,
    detalle: comentario || "",
  });

  const siguiente = nivelDeEstado(next);
  if (siguiente) {
    const nombre = defs.find((d) => d.codigo === siguiente)?.nombre || siguiente;
    await db.insert(bitacora).values({
      solicitudId: id,
      userName: "Sistema",
      accion: `Escalamiento a ${siguiente}`,
      detalle: `Pasa a ${nombre}`,
    });
  }

  return getSolicitud(db, id);
}

export async function rechazarSolicitud(
  db: Db,
  user: UserInfo,
  id: string,
  comentario: string,
) {
  if (!String(comentario || "").trim()) {
    throw Object.assign(new Error("Rechazar exige un comentario"), { status: 400 });
  }
  const req = await getSolicitud(db, id);
  if (!req) throw Object.assign(new Error("No encontrada"), { status: 404 });
  const nivel = nivelDeEstado(req.estado);
  if (!nivel) {
    throw Object.assign(new Error("La solicitud no está pendiente de aprobación"), {
      status: 400,
    });
  }
  const defs = await listNiveles(db);
  const mini = { estado: req.estado as SolicitudEstado, emp: req.empresa };
  if (!canApprove(mini, user, defs) && user.rol !== "Admin") {
    throw Object.assign(new Error("No puede rechazar esta solicitud"), { status: 403 });
  }
  await db
    .update(solicitudes)
    .set({ estado: "Rechazada" })
    .where(eq(solicitudes.id, id));
  await db.insert(bitacora).values({
    solicitudId: id,
    userName: user.nombre,
    accion: `Rechazó ${nivel}`,
    detalle: comentario,
  });
  return getSolicitud(db, id);
}

export async function listAprobadas(db: Db) {
  const rows = await db
    .select()
    .from(solicitudes)
    .where(eq(solicitudes.estado, "Aprobada"))
    .orderBy(desc(solicitudes.createdAt));
  const out = [];
  for (const r of rows) {
    const full = await getSolicitud(db, r.id);
    if (full) out.push(full);
  }
  return out;
}

export async function enviarASAP(
  db: Db,
  sap: SapProvider,
  user: UserInfo,
  ids: string[],
) {
  if (!ids.length) throw Object.assign(new Error("Sin solicitudes"), { status: 400 });
  const reqs = [];
  for (const id of ids) {
    const r = await getSolicitud(db, id);
    if (!r || r.estado !== "Aprobada") {
      throw Object.assign(new Error(`Solicitud ${id} no está Aprobada`), {
        status: 400,
      });
    }
    reqs.push({
      id: r.id,
      emp: r.empresa,
      bodega: r.bodegaCodigo,
      tipoDocumento: r.tipoDocumento,
      docNum: r.docNum || "",
      companyDb: r.companyDb || "",
      requiredDate: r.requiredDate,
      lines: r.lines,
    });
  }

  const empRows = await db.select().from(empresas);
  const bodRows = await db.select().from(bodegas);
  const tipoRows = await db.select().from(tiposDocumento);
  const companyDbByEmpresa: Record<string, string> = {};
  for (const e of empRows) {
    companyDbByEmpresa[e.codigo] = e.companyDb || config.sap.companyDb;
  }

  const cons = consolidar(
    reqs.map((r) => {
      const bod = bodRows.find(
        (b) => b.empresa === r.emp && b.codigo === r.bodega && b.activo,
      );
      const tipo = tipoRows.find((t) => t.codigo === r.tipoDocumento);
      return {
        ...r,
        warehouseCode: bod?.warehouseCode || r.bodega || r.emp,
        companyDb: r.companyDb || companyDbByEmpresa[r.emp] || "",
        objetoSap: tipo?.objetoSap || "PurchaseRequests",
      };
    }),
  );
  const ctx = await getContableContext(db, reqs[0].emp);
  const ctaName = new Map(Object.entries(ctx.cta));
  const rows = filasPost(cons, user.nombre, "Consolidado bodega", ctaName);
  const result = await sap.postSolicitudCompra(rows, { companyDbByEmpresa });

  for (const r of reqs) {
    const posted = result.documents.find((d) => d.origenes.includes(r.id));
    const sapDoc = posted?.sapDocNum || result.docNums[r.emp] || "";
    await db
      .update(solicitudes)
      .set({
        estado: "Enviada a SAP",
        docNum: r.docNum || posted?.docNum || sapDoc,
        sapDocNum: sapDoc,
        companyDb: posted?.companyDb || companyDbByEmpresa[r.emp] || "",
        sentAt: new Date(),
      })
      .where(eq(solicitudes.id, r.id));
    await db.insert(bitacora).values({
      solicitudId: r.id,
      userName: user.nombre,
      accion: "Enviada a SAP",
      detalle: [
        r.tipoDocumento,
        r.docNum || posted?.docNum,
        r.bodega ? `bodega ${r.bodega}` : "",
        posted?.companyDb ? `CompanyDB ${posted.companyDb}` : "",
        sapDoc && sapDoc !== r.docNum ? `SAP ${sapDoc}` : "",
      ]
        .filter(Boolean)
        .join(" · "),
    });
  }

  return { ...result, rows, consolidado: cons };
}

export async function metricas(db: Db) {
  const all = await db.select().from(solicitudes);
  const byEstado: Record<string, number> = {};
  let tiempoSum = 0;
  let tiempoN = 0;
  let sobreEv = 0;
  let conPres = 0;
  for (const r of all) {
    byEstado[r.estado] = (byEstado[r.estado] || 0) + 1;
    if (r.dentroPresupuesto) conPres++;
    if (r.sentAt && r.createdAt) {
      tiempoSum += r.sentAt.getTime() - r.createdAt.getTime();
      tiempoN++;
    }
  }
  void sobreEv;
  return {
    byEstado,
    pctPresupuesto: all.length ? (conPres / all.length) * 100 : 100,
    tiempoPromedioMs: tiempoN ? tiempoSum / tiempoN : null,
    total: all.length,
  };
}
