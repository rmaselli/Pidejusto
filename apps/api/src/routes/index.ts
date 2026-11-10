import { Router } from "express";
import { asc, eq } from "drizzle-orm";
import type { Db } from "@pidejusto/db";
import { articulos, matrizAprobacion, nivelesAprobacion, sapPostLines, users } from "@pidejusto/db";
import {
  cadenasPermitidas,
  codigoDeRol,
  COMPROMETEN,
  ROLES,
  type NivelCodigo,
  type Role,
} from "@pidejusto/shared";
import { requireAuth, requireRole } from "../auth/middleware.js";
import type { SapProvider } from "../sap/index.js";
import { SapUpstreamUnavailable } from "../sap/index.js";
import { config } from "../config.js";
import {
  getArticuloDetalle,
  getContableContext,
  listEmpresas,
  listNiveles,
  listReglasAprobacion,
  presupuestoBase,
  searchArticulos,
} from "../services/catalog.js";
import {
  aprobarSolicitud,
  createSolicitud,
  enviarASAP,
  getSolicitud,
  historialAprobador,
  listAprobadas,
  listSolicitudes,
  metricas,
  pendientes,
  previewLine,
  rechazarSolicitud,
} from "../services/solicitudes.js";
import { aiMrp, aiResumen, aiSearch } from "../services/ai.js";
import { maestrosRoutes } from "./maestros.js";

function asyncHandler(
  fn: (req: import("express").Request, res: import("express").Response) => Promise<unknown>,
) {
  return (req: import("express").Request, res: import("express").Response, next: import("express").NextFunction) => {
    fn(req, res).catch(next);
  };
}

export function apiRoutes(db: Db, sap: SapProvider) {
  const r = Router();
  r.use(maestrosRoutes(db));

  r.get("/health", (_req, res) => {
    res.json({ ok: true, service: "pidejusto-api" });
  });

  r.get(
    "/sap/status",
    requireAuth,
    asyncHandler(async (_req, res) => {
      const ping = sap.ping ? await sap.ping() : { ok: true, detail: sap.label };
      res.json({
        provider: sap.kind,
        label: sap.label,
        baseUrl: config.sap.baseUrl || null,
        ...ping,
      });
    }),
  );

  r.get(
    "/empresas",
    requireAuth,
    asyncHandler(async (_req, res) => {
      res.json({ empresas: await listEmpresas(db) });
    }),
  );

  r.get(
    "/catalog/articulos",
    requireAuth,
    asyncHandler(async (req, res) => {
      const empresa = String(req.query.empresa || req.user!.emp);
      const q = req.query.q ? String(req.query.q) : undefined;
      const items = await searchArticulos(db, { empresa, q });
      res.json({ items });
    }),
  );

  r.get(
    "/catalog/articulos/:empresa/:code",
    requireAuth,
    asyncHandler(async (req, res) => {
      const detail = await getArticuloDetalle(
        db,
        req.params.empresa,
        req.params.code,
      );
      if (!detail) return res.status(404).json({ error: "No encontrado" });
      res.json(detail);
    }),
  );

  r.get(
    "/catalog/contable/:empresa",
    requireAuth,
    asyncHandler(async (req, res) => {
      const ctx = await getContableContext(db, req.params.empresa);
      res.json({
        anexo: ctx.anexo,
        cta: ctx.ctaList,
        catcta: ctx.catcta,
        centros: ctx.mcx,
      });
    }),
  );

  r.post(
    "/solicitudes/preview-line",
    requireRole("Solicitante"),
    asyncHandler(async (req, res) => {
      const empresa =
        req.user!.emp === "TODAS"
          ? String(req.body.empresa || "").trim()
          : req.user!.emp;
      if (!empresa) return res.status(400).json({ error: "Indique la empresa" });
      const preview = await previewLine(db, {
        empresa,
        itemCode: String(req.body.itemCode),
        qty: Number(req.body.qty || 0),
        justificacion: req.body.justificacion,
        contable: req.body.contable,
      });
      res.json(preview);
    }),
  );

  r.post(
    "/solicitudes",
    requireRole("Solicitante"),
    asyncHandler(async (req, res) => {
      const created = await createSolicitud(db, req.user!, req.body);
      res.status(201).json(created);
    }),
  );

  r.get(
    "/solicitudes",
    requireAuth,
    asyncHandler(async (req, res) => {
      const list = await listSolicitudes(db, req.user!, {
        mine: req.query.mine === "1",
        estado: req.query.estado ? String(req.query.estado) : undefined,
      });
      res.json({ items: list });
    }),
  );

  r.get(
    "/solicitudes/:id",
    requireAuth,
    asyncHandler(async (req, res) => {
      const item = await getSolicitud(db, req.params.id);
      if (!item) return res.status(404).json({ error: "No encontrada" });
      res.json(item);
    }),
  );

  r.get(
    "/aprobaciones/pendientes",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3"),
    asyncHandler(async (req, res) => {
      res.json({ items: await pendientes(db, req.user!) });
    }),
  );

  r.get(
    "/aprobaciones/historial",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3"),
    asyncHandler(async (req, res) => {
      res.json({ items: await historialAprobador(db, req.user!) });
    }),
  );

  r.post(
    "/solicitudes/:id/aprobar",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3"),
    asyncHandler(async (req, res) => {
      const item = await aprobarSolicitud(
        db,
        req.user!,
        req.params.id,
        req.body?.comentario,
      );
      res.json(item);
    }),
  );

  r.post(
    "/solicitudes/:id/rechazar",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3"),
    asyncHandler(async (req, res) => {
      const item = await rechazarSolicitud(
        db,
        req.user!,
        req.params.id,
        String(req.body?.comentario || ""),
      );
      res.json(item);
    }),
  );

  r.get(
    "/bodega/aprobadas",
    requireRole("Bodega"),
    asyncHandler(async (_req, res) => {
      res.json({ items: await listAprobadas(db) });
    }),
  );

  r.post(
    "/bodega/enviar-sap",
    requireRole("Bodega"),
    asyncHandler(async (req, res) => {
      const ids = (req.body?.ids || []) as string[];
      try {
        const result = await enviarASAP(db, sap, req.user!, ids);
        res.json(result);
      } catch (e) {
        if (e instanceof SapUpstreamUnavailable) {
          return res.status(503).json({ error: e.message, code: "SapUpstreamUnavailable" });
        }
        throw e;
      }
    }),
  );

  r.get(
    "/bodega/post-lines",
    requireRole("Bodega", "Admin"),
    asyncHandler(async (_req, res) => {
      const rows = await db.select().from(sapPostLines);
      res.json({ items: rows });
    }),
  );

  r.get(
    "/presupuesto/dashboard",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3", "Admin"),
    asyncHandler(async (req, res) => {
      const defs = await listNiveles(db);
      const codigo = codigoDeRol(req.user!.rol);
      const alcance =
        defs.find((n) => n.codigo === codigo)?.alcance ??
        (codigo === "N1" ? "empresa" : "todas");
      const emp =
        codigo && alcance === "empresa" && req.user!.emp !== "TODAS"
          ? req.user!.emp
          : req.query.empresa
            ? String(req.query.empresa)
            : undefined;
      const base = await presupuestoBase(db, emp);
      const open = await listSolicitudes(db, req.user!);
      const rows = base.rows.map((row) => {
        let comprometido = 0;
        for (const s of open) {
          if (s.empresa !== row.empresa) continue;
          if (!COMPROMETEN.includes(s.estado as (typeof COMPROMETEN)[number])) continue;
          // approximate from total if same category unknown at list level — load lines would be heavy;
          // use bud.cats when available
          const bud = s.bud as { cats?: { cat: string; monto: number }[] };
          for (const c of bud?.cats || []) {
            if (c.cat === row.categoria) comprometido += c.monto;
          }
        }
        const disponible = row.presup - row.ejec - comprometido;
        const uso = row.presup > 0 ? (row.ejec + comprometido) / row.presup : 0;
        return {
          ...row,
          comprometido,
          disponible,
          uso,
          estado:
            uso >= 1 ? "excedida" : uso >= 0.9 ? "critica" : uso >= 0.7 ? "atencion" : "sana",
        };
      });
      res.json({ params: base.params, rows });
    }),
  );

  r.get(
    "/metricas",
    requireAuth,
    asyncHandler(async (_req, res) => {
      res.json(await metricas(db));
    }),
  );

  r.post(
    "/ai/search",
    requireRole("Solicitante"),
    asyncHandler(async (req, res) => {
      const empresa = req.user!.emp;
      const items = await db
        .select({
          code: articulos.itemCode,
          name: articulos.itemName,
          cat: articulos.categoria,
        })
        .from(articulos)
        .where(eq(articulos.empresa, empresa));
      res.json(await aiSearch(items, String(req.body?.text || "")));
    }),
  );

  r.post(
    "/ai/mrp",
    requireRole("Solicitante"),
    asyncHandler(async (req, res) => {
      res.json(await aiMrp(req.body));
    }),
  );

  r.post(
    "/ai/resumen",
    requireRole("Aprobador N1", "Aprobador N2", "Aprobador N3"),
    asyncHandler(async (req, res) => {
      const item = await getSolicitud(db, String(req.body?.id || ""));
      if (!item) return res.status(404).json({ error: "No encontrada" });
      res.json(
        await aiResumen({
          id: item.id,
          solicitante: item.solicitanteNombre,
          emp: item.empresa,
          total: item.total,
          comentario: item.comentario || "",
          bud: item.bud as never,
          lines: item.lines,
          ruta: item.ruta as never,
        }),
      );
    }),
  );

  r.get(
    "/niveles-aprobacion",
    requireAuth,
    asyncHandler(async (_req, res) => {
      const [niveles, reglas] = await Promise.all([
        listNiveles(db),
        listReglasAprobacion(db),
      ]);
      const cadenas = cadenasPermitidas(niveles.map((n) => n.codigo));
      res.json({ niveles, reglas, cadenas });
    }),
  );

  r.patch(
    "/admin/niveles-aprobacion/:codigo",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const codigo = String(req.params.codigo || "").toUpperCase();
      if (codigo !== "N1" && codigo !== "N2" && codigo !== "N3") {
        return res.status(400).json({ error: "Solo existen los niveles N1, N2 y N3" });
      }
      const nombre = String(req.body?.nombre || "").trim();
      const descripcion = String(req.body?.descripcion || "").trim();
      const alcance = String(req.body?.alcance || "");
      if (!nombre) return res.status(400).json({ error: "El nombre es obligatorio" });
      if (alcance !== "empresa" && alcance !== "todas") {
        return res.status(400).json({ error: "El alcance debe ser empresa o todas" });
      }
      const [row] = await db
        .update(nivelesAprobacion)
        .set({
          nombre,
          descripcion,
          alcance,
          activo: req.body?.activo !== false,
        })
        .where(eq(nivelesAprobacion.codigo, codigo))
        .returning();
      if (!row) return res.status(404).json({ error: "Nivel no encontrado" });
      res.json({
        nivel: {
          codigo: row.codigo as NivelCodigo,
          nombre: row.nombre,
          orden: row.orden,
          alcance: row.alcance,
          descripcion: row.descripcion,
          activo: row.activo,
        },
      });
    }),
  );

  r.patch(
    "/admin/matriz-aprobacion/:id",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const id = Number(req.params.id);
      const niveles = String(req.body?.niveles || "").trim();
      const defs = await listNiveles(db);
      const permitidas = cadenasPermitidas(defs.map((n) => n.codigo));
      if (!permitidas.includes(niveles)) {
        return res.status(400).json({ error: "Cadena de niveles no válida" });
      }
      const [row] = await db
        .update(matrizAprobacion)
        .set({ nivelesRequeridos: niveles })
        .where(eq(matrizAprobacion.id, id))
        .returning();
      if (!row) return res.status(404).json({ error: "Regla no encontrada" });
      res.json({
        regla: {
          id: row.id,
          regla: row.regla,
          desde: row.montoDesde,
          hasta: row.montoHasta,
          dentro: row.dentroPresupuesto,
          niveles: row.nivelesRequeridos,
          desc: row.descripcion || "",
        },
      });
    }),
  );

  r.get(
    "/admin/users",
    requireRole("Admin"),
    asyncHandler(async (_req, res) => {
      const list = await db.select().from(users).orderBy(asc(users.nombre));
      res.json({
        users: list.map((u) => ({
          id: u.id,
          email: u.email,
          nombre: u.nombre,
          rol: u.rol,
          emp: u.empresa,
          empresa: u.empresa,
          puesto: u.puesto || "",
          activo: u.activo,
        })),
      });
    }),
  );

  r.post(
    "/admin/users",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const email = String(req.body.email || "").trim().toLowerCase();
      const nombre = String(req.body.nombre || "").trim();
      const rol = String(req.body.rol || "Solicitante");
      const empresa = String(req.body.empresa || req.body.emp || "").trim();
      const puesto = String(req.body.puesto || "");
      const id = String(req.body.id || email.split("@")[0] || "")
        .trim()
        .toUpperCase()
        .replace(/[^A-Z0-9_-]/g, "");
      if (!id || !email || !nombre || !empresa) {
        return res.status(400).json({ error: "Id, correo, nombre y empresa son obligatorios" });
      }
      if (!ROLES.includes(rol as Role)) return res.status(400).json({ error: "Rol no válido" });
      try {
        const [u] = await db
          .insert(users)
          .values({ id, email, nombre, rol, empresa, puesto, activo: true })
          .returning();
        res.status(201).json({
          user: {
            id: u.id,
            email: u.email,
            nombre: u.nombre,
            rol: u.rol,
            emp: u.empresa,
            puesto: u.puesto || "",
            activo: u.activo,
          },
        });
      } catch {
        res.status(409).json({ error: "Ya existe un usuario con ese id o correo" });
      }
    }),
  );

  r.patch(
    "/admin/users/:id",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      const patch: Partial<{
        rol: string;
        empresa: string;
        activo: boolean;
        nombre: string;
        email: string;
        puesto: string;
      }> = {};
      if (req.body.rol) {
        const rol = String(req.body.rol) as Role;
        if (!ROLES.includes(rol)) return res.status(400).json({ error: "Rol no válido" });
        patch.rol = rol;
      }
      const empresa = req.body.empresa || req.body.emp;
      if (empresa) patch.empresa = String(empresa);
      if (typeof req.body.activo === "boolean") patch.activo = req.body.activo;
      if (typeof req.body.nombre === "string" && req.body.nombre.trim()) {
        patch.nombre = req.body.nombre.trim();
      }
      if (typeof req.body.puesto === "string") patch.puesto = req.body.puesto;
      if (typeof req.body.email === "string") {
        const email = req.body.email.trim().toLowerCase();
        if (!email.includes("@")) {
          return res.status(400).json({ error: "Correo no válido" });
        }
        patch.email = email;
      }
      try {
        const [u] = await db
          .update(users)
          .set(patch)
          .where(eq(users.id, req.params.id))
          .returning();
        if (!u) return res.status(404).json({ error: "No encontrado" });
        res.json({
          user: {
            id: u.id,
            email: u.email,
            nombre: u.nombre,
            rol: u.rol,
            emp: u.empresa,
            puesto: u.puesto || "",
            activo: u.activo,
          },
        });
      } catch {
        res.status(409).json({ error: "Ya existe un usuario con ese correo" });
      }
    }),
  );

  r.delete(
    "/admin/users/:id",
    requireRole("Admin"),
    asyncHandler(async (req, res) => {
      if (req.user?.id === req.params.id) {
        return res.status(400).json({ error: "No puede eliminar su propio usuario" });
      }
      const [u] = await db
        .delete(users)
        .where(eq(users.id, req.params.id))
        .returning();
      if (!u) return res.status(404).json({ error: "No encontrado" });
      res.json({ ok: true });
    }),
  );

  return r;
}
