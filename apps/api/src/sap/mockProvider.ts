import { eq, sql } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import {
  articulos,
  consumoTrimestral,
  cuentasContables,
  empresas,
  existencias,
  matrizAprobacion,
  matrizContable,
  categoriaCuenta,
  ejecucionPresupuesto,
  parametros,
  sapPostLines,
  sequences,
} from "@pidejusto/db";
import type { SapPostedDocument, SolicitudPostRow } from "@pidejusto/shared";
import { pad } from "@pidejusto/shared";
import type { SapPostOptions, SapProvider } from "./types.js";

export function createMockProvider(db: Db): SapProvider {
  return {
    kind: "mock",
    label: "PostgreSQL seed (Excel v3 simulado)",

    async articulos() {
      return db.select().from(articulos);
    },
    async existencias() {
      return db.select().from(existencias);
    },
    async consumo() {
      return db.select().from(consumoTrimestral);
    },
    async presupuesto() {
      const [params] = await db.select().from(parametros).limit(1);
      const eje = await db.select().from(ejecucionPresupuesto);
      return { params, eje };
    },
    async contable() {
      const cta = await db.select().from(cuentasContables);
      const mcx = await db.select().from(matrizContable);
      const catcta = await db.select().from(categoriaCuenta);
      const emp = await db.select().from(empresas);
      return { cta, mcx, catcta, emp };
    },
    async matriz() {
      return db.select().from(matrizAprobacion);
    },
    async postSolicitudCompra(rows: SolicitudPostRow[], opts?: SapPostOptions) {
      const year = new Date().getFullYear();
      const docNums: Record<string, string> = {};
      const documents: SapPostedDocument[] = [];
      const groups = new Map<string, SolicitudPostRow[]>();
      for (const row of rows) {
        const key = [
          row.Empresa,
          row.Bodega || row.WarehouseCode,
          row.TipoDocumento || "",
          row.DocNum || "",
        ].join("|");
        const list = groups.get(key) || [];
        list.push(row);
        groups.set(key, list);
      }
      for (const group of groups.values()) {
        const head = group[0];
        let docNum = head.DocNum || "";
        if (!docNum) {
          const [seq] = await db
            .update(sequences)
            .set({ value: sql`${sequences.value} + 1` })
            .where(eq(sequences.name, "doc"))
            .returning();
          docNum = `SC-${year}-${pad(seq?.value ?? 1, 4)}`;
        }
        const companyDb =
          head.CompanyDB || opts?.companyDbByEmpresa?.[head.Empresa] || "";
        for (const row of group) {
          row.DocNum = docNum;
          row.CompanyDB = companyDb;
          await db.insert(sapPostLines).values({
            docNum,
            empresa: row.Empresa,
            bodegaCodigo: row.Bodega || row.WarehouseCode,
            tipoDocumento: row.TipoDocumento || "",
            numeroDocumento: docNum,
            companyDb,
            payload: row,
          });
        }
        docNums[head.Empresa] = docNums[head.Empresa]
          ? `${docNums[head.Empresa]}, ${docNum}`
          : docNum;
        documents.push({
          empresa: head.Empresa,
          bodega: head.Bodega || head.WarehouseCode,
          tipoDocumento: head.TipoDocumento || "",
          docNum,
          sapDocNum: docNum,
          companyDb,
          origenes: [
            ...new Set(
              group.flatMap((r) =>
                r.SolicitudesOrigen.split(",")
                  .map((s) => s.trim())
                  .filter(Boolean),
              ),
            ),
          ],
        });
      }
      return { ok: true, docNums, documents };
    },
    async ping() {
      const [{ count }] = await db
        .select({ count: sql<number>`count(*)` })
        .from(articulos);
      return { ok: true, detail: `mock ok · ${count} artículos` };
    },
  };
}
