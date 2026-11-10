import type {
  Alerta,
  BudgetEval,
  ContableImputacion,
  LineaSolicitud,
  MatrizRegla,
  MinMax,
  Params,
  RutaAprobacion,
  NivelAprobacion,
  NivelCodigo,
  SolicitudEstado,
  SolicitudPostRow,
  UserInfo,
} from "./types.js";
import { ABIERTOS, COMPROMETEN } from "./types.js";

export const fQ = (n: number) =>
  "Q " +
  Number(n || 0).toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

export const fN = (n: number) =>
  Number(n || 0).toLocaleString("en-US", { maximumFractionDigits: 0 });

export const pad = (n: number, w: number) => String(n).padStart(w, "0");

export const roundUp = (x: number) =>
  Math.ceil(Number((+x).toPrecision(12)));

export function calcMinMax(
  c: number[],
  lt: number,
  p: number,
  P: Params,
): MinMax {
  const n = c.length;
  const pos = c.filter((v) => v > 0).length;
  const clase =
    pos >= 3 ? "Regular" : pos === 2 ? "Intermitente" : "Esporádico";
  const avg = c.reduce((a, b) => a + b, 0) / n;
  const sd =
    n > 1
      ? Math.sqrt(c.reduce((a, b) => a + (b - avg) ** 2, 0) / (n - 1))
      : 0;
  const L = lt || P.ltStd;
  const spor = clase === "Esporádico";
  const dd = avg / P.dias;
  const ss = spor ? 0 : P.Z * sd * Math.sqrt(L / P.dias);
  const min = spor ? 0 : roundUp(dd * L + ss);
  const max = spor ? 0 : roundUp(min + (avg * P.meses) / 3);
  return {
    clase,
    avg,
    sd,
    min,
    max,
    lt: L,
    presup: avg * p * (1 + P.ajuste / 100),
  };
}

export function disponible(stock: {
  ex: number;
  ped: number;
  com: number;
}): number {
  return stock.ex + stock.ped - stock.com;
}

export function abiertasQty(
  reqs: { estado: SolicitudEstado; lines: { emp: string; code: string; qty: number }[] }[],
  key: string,
): number {
  let q = 0;
  for (const r of reqs) {
    if (!ABIERTOS.includes(r.estado)) continue;
    for (const l of r.lines) {
      if (`${l.emp}|${l.code}` === key) q += l.qty;
    }
  }
  return q;
}

export function baseProy(
  disp: number,
  abiertas: number,
  enCarrito = 0,
): number {
  return disp + abiertas + enCarrito;
}

export function sugerida(
  base: number,
  min: number,
  max: number,
  mult = 1,
): number {
  if (max <= 0) return 0;
  let s = Math.max(0, Math.floor((max - base) / mult) * mult);
  if (s === 0 && base < min) s = mult;
  return s;
}

export function alerta(base: number, qty: number, mm: MinMax): Alerta {
  const sug = sugerida(base, mm.min, mm.max);
  if (mm.clase === "Esporádico") {
    return {
      tipo: "Contra pedido",
      sug,
      exige: true,
      msg: "Material de consumo esporádico: no tiene mínimo ni máximo. Indica para qué lo necesitas.",
    };
  }
  const fin = base + qty;
  if (fin > mm.max || (sug === 0 && qty > 0)) {
    return {
      tipo: "Sobre máximo",
      sug,
      exige: true,
      msg: `Quedarías con ${fN(fin)} y el máximo es ${fN(mm.max)}. Usa la sugerida (${fN(sug)}) o justifica.`,
    };
  }
  if (fin < mm.min) {
    return {
      tipo: "Cantidad corta",
      sug,
      exige: false,
      msg: `Quedarías con ${fN(fin)}, por debajo del mínimo (${fN(mm.min)}).`,
    };
  }
  return {
    tipo: "En rango",
    sug,
    exige: false,
    msg: `Quedarías con ${fN(fin)}, dentro del rango ${fN(mm.min)}–${fN(mm.max)}.`,
  };
}

export function cobertura(base: number, mm: MinMax): number | null {
  return mm.avg > 0 ? base / (mm.avg / 3) : null;
}

export function budgetInfo(
  presup: number,
  ejec: number,
  comprometidoApp: number,
): { presup: number; ejec: number; comp: number; disp: number } {
  return {
    presup,
    ejec,
    comp: comprometidoApp,
    disp: presup - ejec - comprometidoApp,
  };
}

export function comprometidoCategoria(
  reqs: {
    estado: SolicitudEstado;
    emp: string;
    lines: { cat: string; total: number }[];
  }[],
  emp: string,
  cat: string,
): number {
  let t = 0;
  for (const r of reqs) {
    if (!COMPROMETEN.includes(r.estado) || r.emp !== emp) continue;
    for (const l of r.lines) if (l.cat === cat) t += l.total;
  }
  return t;
}

export function evalBudget(
  emp: string,
  lines: { cat: string; total: number }[],
  getDisp: (emp: string, cat: string) => number,
): BudgetEval {
  const byCat = new Map<string, number>();
  for (const l of lines) byCat.set(l.cat, (byCat.get(l.cat) || 0) + l.total);
  const cats = [...byCat.entries()].map(([cat, monto]) => {
    const disp = getDisp(emp, cat);
    return { cat, monto, disp, dentro: monto <= disp + 1e-6 };
  });
  const total = lines.reduce((a, l) => a + l.total, 0);
  return { total, dentro: cats.every((c) => c.dentro), cats };
}

export function rutaDe(
  matriz: MatrizRegla[],
  total: number,
  dentro: boolean,
): RutaAprobacion {
  if (dentro) {
    const r =
      matriz.find((m) => m.dentro === "SI" || m.regla === "R1") || matriz[0];
    return {
      regla: r?.regla || "R1",
      niveles: r?.niveles || "AUTO",
      desc: r?.desc || "Dentro de presupuesto: aprobación automática",
    };
  }
  const fuera = matriz.filter(
    (m) => m.dentro === "NO" || m.dentro === "CUALQUIERA",
  );
  const match =
    fuera.find((m) => total >= m.desde && total <= m.hasta) ||
    fuera.find((m) => total > 10000) ||
    fuera[fuera.length - 1];
  if (total > 10000) {
    const r3 = fuera.find((m) => m.regla === "R3") || match;
    return {
      regla: r3?.regla || "R3",
      niveles: r3?.niveles || "N1+N2+N3",
      desc: r3?.desc || "Excede presupuesto y supera Q 10,000",
    };
  }
  const r2 = fuera.find((m) => m.regla === "R2") || match;
  return {
    regla: r2?.regla || "R2",
    niveles: r2?.niveles || "N1",
    desc: r2?.desc || "Excede presupuesto hasta Q 10,000",
  };
}

export function cadenaNiveles(niveles: string): NivelCodigo[] {
  if (!niveles || niveles === "AUTO") return [];
  return niveles
    .split("+")
    .map((s) => s.trim())
    .filter((s): s is NivelCodigo => s === "N1" || s === "N2" || s === "N3");
}

export function nivelDeEstado(estado: string): NivelCodigo | null {
  if (estado === "Pendiente N1") return "N1";
  if (estado === "Pendiente N2") return "N2";
  if (estado === "Pendiente N3") return "N3";
  return null;
}

export function codigoDeRol(rol: string): NivelCodigo | null {
  if (rol === "Aprobador N1") return "N1";
  if (rol === "Aprobador N2") return "N2";
  if (rol === "Aprobador N3") return "N3";
  return null;
}

export function estadoPendiente(codigo: NivelCodigo): SolicitudEstado {
  if (codigo === "N1") return "Pendiente N1";
  if (codigo === "N2") return "Pendiente N2";
  return "Pendiente N3";
}

/** Cadenas que un administrador puede asignar: AUTO o un prefijo en orden. */
export function cadenasPermitidas(codigosEnOrden: string[]): string[] {
  const codigos = codigosEnOrden.filter(
    (c): c is NivelCodigo => c === "N1" || c === "N2" || c === "N3",
  );
  const out = ["AUTO"];
  for (let i = 0; i < codigos.length; i++) out.push(codigos.slice(0, i + 1).join("+"));
  return out;
}

export function rutaConNivelesActivos(niveles: string, activos: Set<string>): string {
  if (!niveles || niveles === "AUTO") return "AUTO";
  if (activos.size === 0) return niveles;
  const steps = cadenaNiveles(niveles).filter((s) => activos.has(s));
  return steps.length ? steps.join("+") : "AUTO";
}

export const nivelTxt = (n: string) => {
  if (n === "AUTO") return "Aprobación automática";
  const steps = cadenaNiveles(n);
  if (!steps.length) return n;
  return steps.map((s) => `Aprobador ${s}`).join(" + ");
};

/** Matriz contable row: [empresa, ctaDigit, d1, d2, d3, d4, d5, proy, depN, subN, ubiN, linN, prodN, proyN] */
export type MatrizContableRow = string[];

export function buildContableKey(
  cta: string,
  d1: string,
  d2: string,
  d4: string,
  d5: string,
  proy: string,
  empresaAnexo: string,
): string {
  return `${cta[0] || ""}${d1}${d2}${d4}${d5}${proy}${empresaAnexo}`;
}

export function validarImputacion(
  keys: Set<string>,
  cta: string,
  d1: string,
  d2: string,
  d4: string,
  d5: string,
  proy: string,
  empresaAnexo: string,
  requirePlaca: boolean,
  placa: string,
  requireObra: boolean,
  obraProc: string,
  obraEsp: string,
): { ok: boolean; validacion: string } {
  const llave = buildContableKey(cta, d1, d2, d4, d5, proy, empresaAnexo);
  if (!cta || !keys.has(llave)) {
    return { ok: false, validacion: "Información incorrecta" };
  }
  if (requirePlaca && !String(placa || "").trim()) {
    return { ok: false, validacion: "Información incorrecta (placa)" };
  }
  if (requireObra && (!String(obraProc || "").trim() || !String(obraEsp || "").trim())) {
    return { ok: false, validacion: "Información incorrecta (obra)" };
  }
  return { ok: true, validacion: "Correctamente" };
}

export function contableFrom(
  cta: string,
  row: MatrizContableRow | null,
  extra: Partial<ContableImputacion> = {},
  keys: Set<string>,
  empresaAnexo: string,
  requirePlaca = false,
  requireObra = false,
): ContableImputacion {
  const d1 = row?.[2] || "";
  const d2 = row?.[3] || "";
  const d3 = row?.[4] || "";
  const d4 = row?.[5] || "";
  const d5 = row?.[6] || "";
  const proy = row?.[7] || "";
  const placa = extra.placa || "";
  const obraProc = extra.obraProc || "";
  const obraEsp = extra.obraEsp || "";
  const v = validarImputacion(
    keys,
    cta,
    d1,
    d2,
    d4,
    d5,
    proy,
    empresaAnexo,
    requirePlaca || !!extra.placa,
    placa,
    requireObra || (cta || "").startsWith("1210"),
    obraProc,
    obraEsp,
  );
  return {
    cta,
    d1,
    d2,
    d3,
    d4,
    d5,
    proy,
    depN: row?.[8] || "",
    subN: row?.[9] || "",
    ubiN: row?.[10] || "",
    linN: row?.[11] || "",
    prodN: row?.[12] || "",
    proyN: row?.[13] || "",
    detalle: extra.detalle || "",
    placa,
    obraProc,
    obraEsp,
    tipoDoc: extra.tipoDoc || "",
    ok: v.ok,
    validacion: v.validacion,
  };
}

export function canApprove(
  req: { estado: SolicitudEstado; emp: string },
  user: UserInfo,
  niveles?: Pick<NivelAprobacion, "codigo" | "alcance" | "activo">[],
): boolean {
  const codigo = nivelDeEstado(req.estado);
  if (!codigo) return false;
  if (user.rol !== `Aprobador ${codigo}`) return false;
  const cfg = niveles?.find((n) => n.codigo === codigo);
  if (cfg && cfg.activo === false) return false;
  const alcance = cfg?.alcance ?? (codigo === "N1" ? "empresa" : "todas");
  if (alcance === "empresa" && user.emp !== "TODAS" && user.emp !== req.emp) return false;
  return true;
}

export function nextEstadoAfterApprove(
  estado: SolicitudEstado,
  niveles: string,
): SolicitudEstado {
  const steps = cadenaNiveles(niveles);
  const current = nivelDeEstado(estado);
  const idx = current ? steps.indexOf(current) : -1;
  if (idx >= 0 && idx < steps.length - 1) return estadoPendiente(steps[idx + 1]);
  return "Aprobada";
}

export interface ConsolidaLine {
  emp: string;
  bodega: string;
  warehouseCode: string;
  tipoDocumento: string;
  docNum: string;
  companyDb: string;
  objetoSap: string;
  code: string;
  name: string;
  qty: number;
  price: number;
  total: number;
  ct: ContableImputacion;
  requiredDate: string;
  origenes: string[];
}

export function consolidar(
  reqs: {
    id: string;
    emp: string;
    bodega?: string;
    warehouseCode?: string;
    tipoDocumento?: string;
    docNum?: string;
    companyDb?: string;
    objetoSap?: string;
    requiredDate: string;
    lines: LineaSolicitud[];
  }[],
): ConsolidaLine[] {
  const map = new Map<string, ConsolidaLine>();
  for (const r of reqs) {
    for (const l of r.lines) {
      const key = [
        r.emp,
        r.bodega || "",
        r.tipoDocumento || "",
        r.docNum || "",
        l.code,
        l.ct.cta,
        l.ct.d1,
        l.ct.d2,
        l.ct.d3,
        l.ct.d4,
        l.ct.d5,
        l.ct.proy,
      ].join("|");
      const cur = map.get(key);
      if (!cur) {
        map.set(key, {
          emp: r.emp,
          bodega: r.bodega || "",
          warehouseCode: r.warehouseCode || r.bodega || r.emp,
          tipoDocumento: r.tipoDocumento || "",
          docNum: r.docNum || "",
          companyDb: r.companyDb || "",
          objetoSap: r.objetoSap || "PurchaseRequests",
          code: l.code,
          name: l.name,
          qty: l.qty,
          price: l.price,
          total: l.total,
          ct: l.ct,
          requiredDate: r.requiredDate,
          origenes: [r.id],
        });
      } else {
        cur.qty += l.qty;
        cur.total += l.total;
        if (r.requiredDate < cur.requiredDate) cur.requiredDate = r.requiredDate;
        if (!cur.origenes.includes(r.id)) cur.origenes.push(r.id);
      }
    }
  }
  return [...map.values()];
}

export function filasPost(
  cons: ConsolidaLine[],
  requester: string,
  comments: string,
  ctaName: Map<string, string>,
): SolicitudPostRow[] {
  const today = new Date().toISOString().slice(0, 10);
  return cons.map((c) => ({
    DocNum: c.docNum || undefined,
    DocDate: today,
    RequiredDate: c.requiredDate,
    Requester: requester,
    Empresa: c.emp,
    ItemCode: c.code,
    ItemDescription: c.name,
    Quantity: c.qty,
    WarehouseCode: c.warehouseCode || c.bodega || c.emp,
    Bodega: c.bodega,
    TipoDocumento: c.tipoDocumento,
    CompanyDB: c.companyDb,
    ObjetoSap: c.objetoSap,
    AccountCode: c.ct.cta,
    NombreCuenta: ctaName.get(c.ct.cta) || "",
    CostingCode: c.ct.d1,
    CostingCode2: c.ct.d2,
    CostingCode3: c.ct.d3,
    CostingCode4: c.ct.d4,
    CostingCode5: c.ct.d5,
    ProjectCode: c.ct.proy,
    UnitPrice_Q: c.price,
    LineTotal_Q: +c.total.toFixed(2),
    TipoDocRespaldo: c.ct.tipoDoc || "",
    DetalleCompra: c.ct.detalle || "",
    PlacaVehiculo: c.ct.placa || "",
    ObraEnProceso: c.ct.obraProc || "",
    NoObraEspecifica: c.ct.obraEsp || "",
    Validacion: c.ct.validacion,
    SolicitudesOrigen: c.origenes.join(", "),
    Comments: comments || "",
  }));
}

export function localSearch(
  items: { code: string; name: string; cat: string }[],
  text: string,
): { itemCode: string; cantidad: number | null; motivo: string }[] {
  const q = text
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .split(/\s+/)
    .filter(Boolean);
  const scored = items
    .map((a) => {
      const hay = `${a.code} ${a.name} ${a.cat}`
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "");
      const score = q.reduce((s, w) => s + (hay.includes(w) ? 1 : 0), 0);
      return { a, score };
    })
    .filter((x) => x.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5);
  return scored.map(({ a }) => ({
    itemCode: a.code,
    cantidad: null,
    motivo: `Coincidencia local en ${a.cat}`,
  }));
}

export function localMRP(ctx: {
  sug: number;
  min: number;
  max: number;
  base: number;
  avg: number;
}): { cantidad: number; explicacion: string } {
  return {
    cantidad: ctx.sug,
    explicacion: `Con base ${fN(ctx.base)} (disp+abiertas), mín ${fN(ctx.min)} y máx ${fN(ctx.max)}, la fórmula sugiere ${fN(ctx.sug)} unidades para acercarse al máximo sin sobrepedirlo.`,
  };
}

export function localResumen(req: {
  total: number;
  bud: BudgetEval;
  lines: LineaSolicitud[];
  ruta: RutaAprobacion;
}): string {
  const fuera = req.bud.cats.filter((c) => !c.dentro);
  const sobre = req.lines.filter((l) => l.alerta === "Sobre máximo");
  const invalidas = req.lines.filter((l) => !l.ct.ok).length;
  const riesgo =
    (fuera.length ? 2 : 0) + (sobre.length ? 1 : 0) + (invalidas ? 1 : 0);
  const rec =
    riesgo === 0 ? "Aprobar" : riesgo <= 2 ? "Aprobar con ajuste" : "Rechazar";
  return [
    `• **Presupuesto:** ${
      fuera.length
        ? fuera
            .map(
              (c) =>
                `${c.cat}: pide ${fQ(c.monto)} y solo hay ${fQ(Math.max(c.disp, 0))} disponibles`,
            )
            .join("; ")
        : "todas las categorías caben en su presupuesto disponible"
    }.`,
    `• **Inventario:** ${
      sobre.length
        ? `${sobre.length} línea(s) sobre máximo (${sobre.map((l) => l.code).join(", ")})`
        : "sin alertas de sobrepedido"
    }.`,
    `• **Contabilidad:** ${
      invalidas
        ? invalidas + " línea(s) con imputación inválida"
        : "todas las líneas cumplen la matriz contable"
    }.`,
    `• **Ruta:** ${req.ruta.regla} · ${nivelTxt(req.ruta.niveles)} · total ${fQ(req.total)}.`,
    `Recomendación: ${rec}`,
  ].join("\n");
}
