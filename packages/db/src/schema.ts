import {
  boolean,
  doublePrecision,
  integer,
  jsonb,
  pgTable,
  serial,
  text,
  timestamp,
  uniqueIndex,
  varchar,
} from "drizzle-orm/pg-core";

export const empresas = pgTable("empresas", {
  codigo: varchar("codigo", { length: 64 }).primaryKey(),
  nombreAnexo: text("nombre_anexo").notNull(),
  /** Nombre de base de datos SAP B1 (CompanyDB) para el login del Service Layer. */
  companyDb: varchar("company_db", { length: 128 }).notNull().default(""),
  activo: boolean("activo").notNull().default(true),
});

export const bodegas = pgTable(
  "bodegas",
  {
    id: serial("id").primaryKey(),
    empresa: varchar("empresa", { length: 64 }).notNull(),
    codigo: varchar("codigo", { length: 32 }).notNull(),
    nombre: text("nombre").notNull(),
    warehouseCode: varchar("warehouse_code", { length: 32 }).notNull(),
    activo: boolean("activo").notNull().default(true),
  },
  (t) => [uniqueIndex("bodegas_emp_codigo").on(t.empresa, t.codigo)],
);

export const tiposDocumento = pgTable("tipos_documento", {
  codigo: varchar("codigo", { length: 32 }).primaryKey(),
  nombre: text("nombre").notNull(),
  objetoSap: varchar("objeto_sap", { length: 64 }).notNull().default("PurchaseRequests"),
  activo: boolean("activo").notNull().default(true),
});

export const seriesDocumento = pgTable(
  "series_documento",
  {
    id: serial("id").primaryKey(),
    empresa: varchar("empresa", { length: 64 }).notNull(),
    tipoCodigo: varchar("tipo_codigo", { length: 32 }).notNull(),
    bodegaCodigo: varchar("bodega_codigo", { length: 32 }).notNull().default(""),
    prefijo: varchar("prefijo", { length: 32 }).notNull().default(""),
    siguiente: integer("siguiente").notNull().default(1),
    digitos: integer("digitos").notNull().default(5),
    activo: boolean("activo").notNull().default(true),
  },
  (t) => [
    uniqueIndex("series_emp_tipo_bod").on(t.empresa, t.tipoCodigo, t.bodegaCodigo),
  ],
);

export const parametros = pgTable("parametros", {
  id: serial("id").primaryKey(),
  z: doublePrecision("z").notNull(),
  meses: doublePrecision("meses").notNull(),
  ltStd: doublePrecision("lt_std").notNull(),
  ajuste: doublePrecision("ajuste").notNull().default(0),
  margen: doublePrecision("margen").notNull().default(0),
  periodo: varchar("periodo", { length: 32 }).notNull(),
  dias: doublePrecision("dias").notNull(),
});

export const articulos = pgTable(
  "articulos",
  {
    id: serial("id").primaryKey(),
    empresa: varchar("empresa", { length: 64 }).notNull(),
    itemCode: varchar("item_code", { length: 64 }).notNull(),
    itemName: text("item_name").notNull(),
    categoria: text("categoria").notNull(),
    area: text("area"),
    abc: varchar("abc", { length: 8 }),
    precioProm: doublePrecision("precio_prom").notNull().default(0),
    leadTimeDias: integer("lead_time_dias").notNull().default(15),
    codigoCorporativo: varchar("codigo_corporativo", { length: 64 }),
  },
  (t) => [uniqueIndex("articulos_emp_code").on(t.empresa, t.itemCode)],
);

export const existencias = pgTable(
  "existencias",
  {
    id: serial("id").primaryKey(),
    empresa: varchar("empresa", { length: 64 }).notNull(),
    itemCode: varchar("item_code", { length: 64 }).notNull(),
    existencia: doublePrecision("existencia").notNull().default(0),
    enPedido: doublePrecision("en_pedido").notNull().default(0),
    comprometido: doublePrecision("comprometido").notNull().default(0),
  },
  (t) => [uniqueIndex("existencias_emp_code").on(t.empresa, t.itemCode)],
);

export const consumoTrimestral = pgTable(
  "consumo_trimestral",
  {
    id: serial("id").primaryKey(),
    empresa: varchar("empresa", { length: 64 }).notNull(),
    itemCode: varchar("item_code", { length: 64 }).notNull(),
    t0: doublePrecision("t0").notNull().default(0),
    t1: doublePrecision("t1").notNull().default(0),
    t2: doublePrecision("t2").notNull().default(0),
    t3: doublePrecision("t3").notNull().default(0),
  },
  (t) => [uniqueIndex("consumo_emp_code").on(t.empresa, t.itemCode)],
);

export const ejecucionPresupuesto = pgTable("ejecucion_presupuesto", {
  id: serial("id").primaryKey(),
  empresa: varchar("empresa", { length: 64 }).notNull(),
  categoria: text("categoria").notNull(),
  periodo: varchar("periodo", { length: 32 }),
  ejecutado: doublePrecision("ejecutado").notNull().default(0),
});

export const matrizAprobacion = pgTable("matriz_aprobacion", {
  id: serial("id").primaryKey(),
  regla: varchar("regla", { length: 16 }).notNull(),
  montoDesde: doublePrecision("monto_desde").notNull().default(0),
  montoHasta: doublePrecision("monto_hasta").notNull().default(0),
  dentroPresupuesto: varchar("dentro_presupuesto", { length: 16 }).notNull(),
  nivelesRequeridos: varchar("niveles_requeridos", { length: 32 }).notNull(),
  descripcion: text("descripcion"),
});

/** Catálogo fijo de los tres niveles. El orden N1 → N2 → N3 no cambia. */
export const nivelesAprobacion = pgTable("niveles_aprobacion", {
  codigo: varchar("codigo", { length: 8 }).primaryKey(),
  nombre: text("nombre").notNull(),
  orden: integer("orden").notNull(),
  alcance: varchar("alcance", { length: 16 }).notNull().default("empresa"),
  descripcion: text("descripcion").notNull().default(""),
  activo: boolean("activo").notNull().default(true),
});

export const cuentasContables = pgTable("cuentas_contables", {
  codigo: varchar("codigo", { length: 32 }).primaryKey(),
  nombre: text("nombre").notNull(),
});

export const matrizContable = pgTable("matriz_contable", {
  id: serial("id").primaryKey(),
  empresa: text("empresa").notNull(),
  cta: varchar("cta", { length: 8 }).notNull(),
  dim1: text("dim1").notNull().default(""),
  dim2: text("dim2").notNull().default(""),
  dim3: text("dim3").notNull().default(""),
  dim4: text("dim4").notNull().default(""),
  dim5: text("dim5").notNull().default(""),
  proyecto: text("proyecto").notNull().default(""),
  departamento: text("departamento").notNull().default(""),
  subdepartamento: text("subdepartamento").notNull().default(""),
  ubicacion: text("ubicacion").notNull().default(""),
  lineaProducto: text("linea_producto").notNull().default(""),
  producto: text("producto").notNull().default(""),
  nombreProyecto: text("nombre_proyecto").notNull().default(""),
});

export const categoriaCuenta = pgTable("categoria_cuenta", {
  categoria: text("categoria").primaryKey(),
  cuenta6: varchar("cuenta6", { length: 32 }),
  cuenta7: varchar("cuenta7", { length: 32 }),
  requierePlaca: boolean("requiere_placa").notNull().default(false),
  requiereObra: boolean("requiere_obra").notNull().default(false),
  nota: text("nota"),
});

export const homologacion = pgTable("homologacion", {
  id: serial("id").primaryKey(),
  codigoCorporativo: varchar("codigo_corporativo", { length: 64 }).notNull(),
  empresa: varchar("empresa", { length: 64 }).notNull(),
  codigoLocal: varchar("codigo_local", { length: 64 }).notNull(),
  descripcionLocal: text("descripcion_local"),
  precioProm: doublePrecision("precio_prom").default(0),
});

export const users = pgTable("users", {
  id: varchar("id", { length: 64 }).primaryKey(),
  email: varchar("email", { length: 256 }).notNull().unique(),
  nombre: text("nombre").notNull(),
  rol: varchar("rol", { length: 32 }).notNull(),
  empresa: varchar("empresa", { length: 64 }).notNull(),
  puesto: text("puesto"),
  azureOid: varchar("azure_oid", { length: 128 }),
  activo: boolean("activo").notNull().default(true),
  createdAt: timestamp("created_at", { withTimezone: true }).defaultNow(),
});

export const solicitudes = pgTable("solicitudes", {
  id: varchar("id", { length: 32 }).primaryKey(),
  empresa: varchar("empresa", { length: 64 }).notNull(),
  solicitanteId: varchar("solicitante_id", { length: 64 }).notNull(),
  solicitanteNombre: text("solicitante_nombre").notNull(),
  estado: varchar("estado", { length: 32 }).notNull(),
  total: doublePrecision("total").notNull().default(0),
  dentroPresupuesto: boolean("dentro_presupuesto").notNull().default(true),
  ruta: jsonb("ruta").notNull(),
  bud: jsonb("bud").notNull(),
  requiredDate: varchar("required_date", { length: 16 }).notNull(),
  comentario: text("comentario").default(""),
  bodegaCodigo: varchar("bodega_codigo", { length: 32 }).notNull().default(""),
  tipoDocumento: varchar("tipo_documento", { length: 32 }).notNull().default("SC"),
  docNum: varchar("doc_num", { length: 64 }),
  sapDocNum: varchar("sap_doc_num", { length: 64 }),
  companyDb: varchar("company_db", { length: 128 }).notNull().default(""),
  createdAt: timestamp("created_at", { withTimezone: true }).defaultNow(),
  approvedAt: timestamp("approved_at", { withTimezone: true }),
  sentAt: timestamp("sent_at", { withTimezone: true }),
});

export const solicitudLineas = pgTable("solicitud_lineas", {
  id: serial("id").primaryKey(),
  solicitudId: varchar("solicitud_id", { length: 32 }).notNull(),
  empresa: varchar("empresa", { length: 64 }).notNull(),
  itemCode: varchar("item_code", { length: 64 }).notNull(),
  itemName: text("item_name").notNull(),
  categoria: text("categoria").notNull(),
  qty: doublePrecision("qty").notNull(),
  price: doublePrecision("price").notNull(),
  total: doublePrecision("total").notNull(),
  sug: doublePrecision("sug").notNull().default(0),
  alerta: varchar("alerta", { length: 32 }).notNull(),
  justificacion: text("justificacion").default(""),
  disp: doublePrecision("disp").default(0),
  min: doublePrecision("min").default(0),
  max: doublePrecision("max").default(0),
  contable: jsonb("contable").notNull(),
});

export const bitacora = pgTable("bitacora", {
  id: serial("id").primaryKey(),
  solicitudId: varchar("solicitud_id", { length: 32 }).notNull(),
  ts: timestamp("ts", { withTimezone: true }).defaultNow().notNull(),
  userName: text("user_name").notNull(),
  accion: text("accion").notNull(),
  detalle: text("detalle").default(""),
});

export const sapPostLines = pgTable("sap_post_lines", {
  id: serial("id").primaryKey(),
  docNum: varchar("doc_num", { length: 64 }).notNull(),
  empresa: varchar("empresa", { length: 64 }).notNull().default(""),
  bodegaCodigo: varchar("bodega_codigo", { length: 32 }).notNull().default(""),
  tipoDocumento: varchar("tipo_documento", { length: 32 }).notNull().default(""),
  numeroDocumento: varchar("numero_documento", { length: 64 }).notNull().default(""),
  companyDb: varchar("company_db", { length: 128 }).notNull().default(""),
  payload: jsonb("payload").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true }).defaultNow(),
});

export const sequences = pgTable("sequences", {
  name: varchar("name", { length: 32 }).primaryKey(),
  value: integer("value").notNull().default(0),
});
