import { and, eq, sql } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import {
  bodegas,
  empresas,
  seriesDocumento,
  tiposDocumento,
} from "@pidejusto/db";

function httpError(message: string, status: number) {
  return Object.assign(new Error(message), { status });
}

export function formatNumero(prefijo: string, n: number, digitos: number) {
  return `${prefijo}${String(n).padStart(Math.max(digitos, 1), "0")}`;
}

export async function listBodegas(db: Db, empresa?: string) {
  if (!empresa) return db.select().from(bodegas);
  return db.select().from(bodegas).where(eq(bodegas.empresa, empresa));
}

export async function listTiposDocumento(db: Db) {
  return db.select().from(tiposDocumento);
}

export async function listSeries(db: Db, empresa?: string) {
  if (!empresa) return db.select().from(seriesDocumento);
  return db
    .select()
    .from(seriesDocumento)
    .where(eq(seriesDocumento.empresa, empresa));
}

export async function allocateDocumentNumber(
  db: Db,
  empresa: string,
  tipoCodigo: string,
  bodegaCodigo: string,
) {
  const series = await db
    .select()
    .from(seriesDocumento)
    .where(
      and(
        eq(seriesDocumento.empresa, empresa),
        eq(seriesDocumento.tipoCodigo, tipoCodigo),
        eq(seriesDocumento.activo, true),
      ),
    );
  const serie =
    series.find((s) => s.bodegaCodigo === bodegaCodigo) ||
    series.find((s) => s.bodegaCodigo === "");
  if (!serie) {
    throw httpError(
      `No hay numeración registrada para ${empresa}, tipo ${tipoCodigo} y bodega ${bodegaCodigo}. Regístrela en Documentos.`,
      400,
    );
  }
  const [updated] = await db
    .update(seriesDocumento)
    .set({ siguiente: sql`${seriesDocumento.siguiente} + 1` })
    .where(eq(seriesDocumento.id, serie.id))
    .returning();
  return formatNumero(updated.prefijo, updated.siguiente - 1, updated.digitos);
}

export async function resolveTransaccion(
  db: Db,
  empresa: string,
  bodegaCodigo?: string,
  tipoCodigo?: string,
) {
  const tipo = (tipoCodigo || "SC").trim();
  const [tipoRow] = await db
    .select()
    .from(tiposDocumento)
    .where(eq(tiposDocumento.codigo, tipo))
    .limit(1);
  if (!tipoRow || !tipoRow.activo) {
    throw httpError(`Tipo de documento ${tipo} no está registrado`, 400);
  }

  const bodegasEmp = await db
    .select()
    .from(bodegas)
    .where(and(eq(bodegas.empresa, empresa), eq(bodegas.activo, true)));
  const codigo = (bodegaCodigo || "").trim() || bodegasEmp[0]?.codigo || "";
  const bod = bodegasEmp.find((b) => b.codigo === codigo);
  if (!bod) {
    throw httpError(
      `Bodega ${codigo || "(vacía)"} no está registrada para ${empresa}`,
      400,
    );
  }

  const [emp] = await db
    .select()
    .from(empresas)
    .where(eq(empresas.codigo, empresa))
    .limit(1);
  if (!emp || !emp.activo) {
    throw httpError(`Empresa ${empresa} no está registrada`, 400);
  }

  return {
    tipo,
    bodega: bod.codigo,
    warehouseCode: bod.warehouseCode,
    companyDb: emp.companyDb,
    objetoSap: tipoRow.objetoSap,
  };
}
