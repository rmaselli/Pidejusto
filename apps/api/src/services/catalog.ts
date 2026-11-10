import { and, asc, eq, ilike, or, sql } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import {
  articulos,
  categoriaCuenta,
  consumoTrimestral,
  cuentasContables,
  empresas,
  existencias,
  ejecucionPresupuesto,
  matrizAprobacion,
  matrizContable,
  nivelesAprobacion,
  parametros,
} from "@pidejusto/db";
import {
  calcMinMax,
  disponible,
  type NivelCodigo,
  type Params,
  type MatrizRegla,
} from "@pidejusto/shared";

export async function getParams(db: Db): Promise<Params> {
  const [p] = await db.select().from(parametros).limit(1);
  if (!p) throw new Error("Parámetros no sembrados");
  return {
    Z: p.z,
    meses: p.meses,
    ltStd: p.ltStd,
    ajuste: p.ajuste,
    margen: p.margen,
    periodo: p.periodo,
    dias: p.dias,
  };
}

export async function listEmpresas(db: Db) {
  return db.select().from(empresas);
}

export async function searchArticulos(
  db: Db,
  opts: { empresa: string; q?: string; limit?: number },
) {
  const limit = opts.limit ?? 40;
  const conditions = [eq(articulos.empresa, opts.empresa)];
  if (opts.q?.trim()) {
    const like = `%${opts.q.trim()}%`;
    conditions.push(
      or(
        ilike(articulos.itemCode, like),
        ilike(articulos.itemName, like),
        ilike(articulos.categoria, like),
      )!,
    );
  }
  return db
    .select()
    .from(articulos)
    .where(and(...conditions))
    .limit(limit);
}

export async function getArticuloDetalle(
  db: Db,
  empresa: string,
  itemCode: string,
) {
  const [art] = await db
    .select()
    .from(articulos)
    .where(and(eq(articulos.empresa, empresa), eq(articulos.itemCode, itemCode)))
    .limit(1);
  if (!art) return null;

  const [ex] = await db
    .select()
    .from(existencias)
    .where(
      and(eq(existencias.empresa, empresa), eq(existencias.itemCode, itemCode)),
    )
    .limit(1);
  const [con] = await db
    .select()
    .from(consumoTrimestral)
    .where(
      and(
        eq(consumoTrimestral.empresa, empresa),
        eq(consumoTrimestral.itemCode, itemCode),
      ),
    )
    .limit(1);

  const params = await getParams(db);
  const consumo = con ? [con.t0, con.t1, con.t2, con.t3] : [0, 0, 0, 0];
  const stock = {
    ex: ex?.existencia || 0,
    ped: ex?.enPedido || 0,
    com: ex?.comprometido || 0,
  };
  const mm = calcMinMax(consumo, art.leadTimeDias, art.precioProm, params);

  return {
    art,
    stock,
    consumo,
    mm,
    disponible: disponible(stock),
    params,
  };
}

export async function getMatriz(db: Db): Promise<MatrizRegla[]> {
  const rows = await db.select().from(matrizAprobacion);
  return rows.map((r) => ({
    regla: r.regla,
    desde: r.montoDesde,
    hasta: r.montoHasta,
    dentro: r.dentroPresupuesto,
    niveles: r.nivelesRequeridos,
    desc: r.descripcion || "",
  }));
}

export async function listNiveles(db: Db) {
  const rows = await db
    .select()
    .from(nivelesAprobacion)
    .orderBy(asc(nivelesAprobacion.orden));
  return rows.flatMap((r) => {
    if (r.codigo !== "N1" && r.codigo !== "N2" && r.codigo !== "N3") return [];
    const codigo: NivelCodigo = r.codigo;
    return [
      {
        codigo,
        nombre: r.nombre,
        orden: r.orden,
        alcance: r.alcance === "todas" ? ("todas" as const) : ("empresa" as const),
        descripcion: r.descripcion,
        activo: r.activo,
      },
    ];
  });
}

export async function listReglasAprobacion(db: Db) {
  const rows = await db.select().from(matrizAprobacion).orderBy(asc(matrizAprobacion.id));
  return rows.map((r) => ({
    id: r.id,
    regla: r.regla,
    desde: r.montoDesde,
    hasta: r.montoHasta,
    dentro: r.dentroPresupuesto,
    niveles: r.nivelesRequeridos,
    desc: r.descripcion || "",
  }));
}

export async function getContableContext(db: Db, empresa: string) {
  const empRows = await db.select().from(empresas);
  const anexo =
    empRows.find((e) => e.codigo === empresa)?.nombreAnexo || empresa;
  const cta = await db.select().from(cuentasContables);
  const catcta = await db.select().from(categoriaCuenta);
  const mcx = await db
    .select()
    .from(matrizContable)
    .where(eq(matrizContable.empresa, anexo));

  const keys = new Set(
    mcx.map(
      (r) =>
        `${r.cta}${r.dim1}${r.dim2}${r.dim4}${r.dim5}${r.proyecto}${r.empresa}`,
    ),
  );

  return {
    anexo,
    cta: Object.fromEntries(cta.map((c) => [c.codigo, c.nombre])),
    ctaList: cta,
    catcta,
    mcx: mcx.map((r) => [
      r.empresa,
      r.cta,
      r.dim1,
      r.dim2,
      r.dim3,
      r.dim4,
      r.dim5,
      r.proyecto,
      r.departamento,
      r.subdepartamento,
      r.ubicacion,
      r.lineaProducto,
      r.producto,
      r.nombreProyecto,
    ]),
    keys,
  };
}

export async function presupuestoBase(db: Db, empresa?: string) {
  const params = await getParams(db);
  const arts = empresa
    ? await db.select().from(articulos).where(eq(articulos.empresa, empresa))
    : await db.select().from(articulos);

  const consRows = empresa
    ? await db
        .select()
        .from(consumoTrimestral)
        .where(eq(consumoTrimestral.empresa, empresa))
    : await db.select().from(consumoTrimestral);
  const consMap = new Map(
    consRows.map((c) => [`${c.empresa}|${c.itemCode}`, c] as const),
  );

  const eje = await db.select().from(ejecucionPresupuesto);
  const map = new Map<
    string,
    { empresa: string; categoria: string; presup: number; ejec: number }
  >();

  for (const a of arts) {
    const key = `${a.empresa}|${a.categoria}`;
    const con = consMap.get(`${a.empresa}|${a.itemCode}`);
    const consumo = con ? [con.t0, con.t1, con.t2, con.t3] : [0, 0, 0, 0];
    const mm = calcMinMax(consumo, a.leadTimeDias, a.precioProm, params);
    const cur = map.get(key) || {
      empresa: a.empresa,
      categoria: a.categoria,
      presup: 0,
      ejec: 0,
    };
    cur.presup += mm.presup;
    map.set(key, cur);
  }

  for (const e of eje) {
    if (e.periodo && e.periodo !== params.periodo) continue;
    const key = `${e.empresa}|${e.categoria}`;
    const cur = map.get(key);
    if (cur) cur.ejec += e.ejecutado;
  }

  return { params, rows: [...map.values()] };
}

export async function countArticulos(db: Db) {
  const [{ a }] = await db.select({ a: sql<number>`count(*)` }).from(articulos);
  return { articulos: Number(a) };
}
