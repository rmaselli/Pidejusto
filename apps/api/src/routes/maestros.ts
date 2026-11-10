import { Router } from "express";
import { and, eq } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import { bodegas, empresas, seriesDocumento, tiposDocumento } from "@pidejusto/db";
import { requireAuth, requireRole } from "../auth/middleware.js";
import {
  listBodegas,
  listSeries,
  listTiposDocumento,
} from "../services/maestros.js";

function asyncHandler(
  fn: (req: import("express").Request, res: import("express").Response) => Promise<unknown>,
) {
  return (
    req: import("express").Request,
    res: import("express").Response,
    next: import("express").NextFunction,
  ) => {
    fn(req, res).catch(next);
  };
}

function flag(value: unknown, fallback: boolean) {
  if (typeof value === "boolean") return value;
  return fallback;
}

export function maestrosRoutes(db: Db) {
  const r = Router();

  r.get(
    "/bodegas",
    requireAuth,
    asyncHandler(async (req, res) => {
      const empresa = req.query.empresa ? String(req.query.empresa) : undefined;
      res.json({ bodegas: await listBodegas(db, empresa) });
    }),
  );

  r.get(
    "/tipos-documento",
    requireAuth,
    asyncHandler(async (_req, res) => {
      res.json({ tipos: await listTiposDocumento(db) });
    }),
  );

  r.get(
    "/series-documento",
    requireAuth,
    asyncHandler(async (req, res) => {
      const empresa = req.query.empresa ? String(req.query.empresa) : undefined;
      res.json({ series: await listSeries(db, empresa) });
    }),
  );

  r.post(
    "/admin/empresas",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const codigo = String(req.body.codigo || "").trim();
      const nombreAnexo = String(req.body.nombreAnexo || req.body.nombre || "").trim();
      const companyDb = String(req.body.companyDb || "").trim();
      if (!codigo || !nombreAnexo) {
        return res.status(400).json({ error: "Código y nombre son obligatorios" });
      }
      const [row] = await db
        .insert(empresas)
        .values({
          codigo,
          nombreAnexo,
          companyDb,
          activo: flag(req.body.activo, true),
        })
        .returning();
      res.status(201).json({ empresa: row });
    }),
  );

  r.patch(
    "/admin/empresas/:codigo",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const patch: Partial<{
        nombreAnexo: string;
        companyDb: string;
        activo: boolean;
      }> = {};
      if (req.body.nombreAnexo || req.body.nombre) {
        patch.nombreAnexo = String(req.body.nombreAnexo || req.body.nombre);
      }
      if (typeof req.body.companyDb === "string") patch.companyDb = req.body.companyDb.trim();
      if (typeof req.body.activo === "boolean") patch.activo = req.body.activo;
      const [row] = await db
        .update(empresas)
        .set(patch)
        .where(eq(empresas.codigo, req.params.codigo))
        .returning();
      if (!row) return res.status(404).json({ error: "Empresa no encontrada" });
      res.json({ empresa: row });
    }),
  );

  r.post(
    "/admin/bodegas",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const empresa = String(req.body.empresa || "").trim();
      const codigo = String(req.body.codigo || "").trim();
      const nombre = String(req.body.nombre || "").trim();
      const warehouseCode = String(req.body.warehouseCode || codigo).trim();
      if (!empresa || !codigo || !nombre || !warehouseCode) {
        return res.status(400).json({ error: "Empresa, código, nombre y almacén SAP son obligatorios" });
      }
      const [emp] = await db.select().from(empresas).where(eq(empresas.codigo, empresa)).limit(1);
      if (!emp) return res.status(400).json({ error: "La empresa no está registrada" });
      const [row] = await db
        .insert(bodegas)
        .values({
          empresa,
          codigo,
          nombre,
          warehouseCode,
          activo: flag(req.body.activo, true),
        })
        .returning();
      res.status(201).json({ bodega: row });
    }),
  );

  r.patch(
    "/admin/bodegas/:id",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const id = Number(req.params.id);
      const patch: Partial<{
        nombre: string;
        warehouseCode: string;
        activo: boolean;
      }> = {};
      if (req.body.nombre) patch.nombre = String(req.body.nombre);
      if (req.body.warehouseCode) patch.warehouseCode = String(req.body.warehouseCode).trim();
      if (typeof req.body.activo === "boolean") patch.activo = req.body.activo;
      const [row] = await db.update(bodegas).set(patch).where(eq(bodegas.id, id)).returning();
      if (!row) return res.status(404).json({ error: "Bodega no encontrada" });
      res.json({ bodega: row });
    }),
  );

  r.post(
    "/admin/tipos-documento",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const codigo = String(req.body.codigo || "").trim();
      const nombre = String(req.body.nombre || "").trim();
      const objetoSap = String(req.body.objetoSap || "PurchaseRequests").trim();
      if (!codigo || !nombre) {
        return res.status(400).json({ error: "Código y nombre son obligatorios" });
      }
      const [row] = await db
        .insert(tiposDocumento)
        .values({
          codigo,
          nombre,
          objetoSap,
          activo: flag(req.body.activo, true),
        })
        .returning();
      res.status(201).json({ tipo: row });
    }),
  );

  r.patch(
    "/admin/tipos-documento/:codigo",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const patch: Partial<{ nombre: string; objetoSap: string; activo: boolean }> = {};
      if (req.body.nombre) patch.nombre = String(req.body.nombre);
      if (req.body.objetoSap) patch.objetoSap = String(req.body.objetoSap).trim();
      if (typeof req.body.activo === "boolean") patch.activo = req.body.activo;
      const [row] = await db
        .update(tiposDocumento)
        .set(patch)
        .where(eq(tiposDocumento.codigo, req.params.codigo))
        .returning();
      if (!row) return res.status(404).json({ error: "Tipo de documento no encontrado" });
      res.json({ tipo: row });
    }),
  );

  r.post(
    "/admin/series-documento",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const empresa = String(req.body.empresa || "").trim();
      const tipoCodigo = String(req.body.tipoCodigo || "").trim();
      const bodegaCodigo = String(req.body.bodegaCodigo || "").trim();
      const prefijo = String(req.body.prefijo || "");
      const siguiente = Number(req.body.siguiente ?? 1);
      const digitos = Number(req.body.digitos ?? 5);
      if (!empresa || !tipoCodigo || !Number.isFinite(siguiente) || siguiente < 1) {
        return res.status(400).json({ error: "Empresa, tipo y siguiente número son obligatorios" });
      }
      if (bodegaCodigo) {
        const [bod] = await db
          .select()
          .from(bodegas)
          .where(and(eq(bodegas.empresa, empresa), eq(bodegas.codigo, bodegaCodigo)))
          .limit(1);
        if (!bod) return res.status(400).json({ error: "La bodega no está registrada en esa empresa" });
      }
      const [tipo] = await db
        .select()
        .from(tiposDocumento)
        .where(eq(tiposDocumento.codigo, tipoCodigo))
        .limit(1);
      if (!tipo) return res.status(400).json({ error: "El tipo de documento no está registrado" });
      const [row] = await db
        .insert(seriesDocumento)
        .values({
          empresa,
          tipoCodigo,
          bodegaCodigo,
          prefijo,
          siguiente,
          digitos: Number.isFinite(digitos) && digitos > 0 ? digitos : 5,
          activo: flag(req.body.activo, true),
        })
        .returning();
      res.status(201).json({ serie: row });
    }),
  );

  r.patch(
    "/admin/series-documento/:id",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const id = Number(req.params.id);
      const patch: Partial<{
        prefijo: string;
        siguiente: number;
        digitos: number;
        activo: boolean;
      }> = {};
      if (typeof req.body.prefijo === "string") patch.prefijo = req.body.prefijo;
      if (req.body.siguiente != null) {
        const n = Number(req.body.siguiente);
        if (!Number.isFinite(n) || n < 1) {
          return res.status(400).json({ error: "El siguiente número debe ser mayor a cero" });
        }
        patch.siguiente = n;
      }
      if (req.body.digitos != null) patch.digitos = Number(req.body.digitos);
      if (typeof req.body.activo === "boolean") patch.activo = req.body.activo;
      const [row] = await db
        .update(seriesDocumento)
        .set(patch)
        .where(eq(seriesDocumento.id, id))
        .returning();
      if (!row) return res.status(404).json({ error: "Serie no encontrada" });
      res.json({ serie: row });
    }),
  );

  return r;
}
