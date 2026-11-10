CREATE TABLE IF NOT EXISTS "empresas" (
  "codigo" varchar(64) PRIMARY KEY NOT NULL,
  "nombre_anexo" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "parametros" (
  "id" serial PRIMARY KEY NOT NULL,
  "z" double precision NOT NULL,
  "meses" double precision NOT NULL,
  "lt_std" double precision NOT NULL,
  "ajuste" double precision DEFAULT 0 NOT NULL,
  "margen" double precision DEFAULT 0 NOT NULL,
  "periodo" varchar(32) NOT NULL,
  "dias" double precision NOT NULL
);

CREATE TABLE IF NOT EXISTS "articulos" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "item_code" varchar(64) NOT NULL,
  "item_name" text NOT NULL,
  "categoria" text NOT NULL,
  "area" text,
  "abc" varchar(8),
  "precio_prom" double precision DEFAULT 0 NOT NULL,
  "lead_time_dias" integer DEFAULT 15 NOT NULL,
  "codigo_corporativo" varchar(64)
);
CREATE UNIQUE INDEX IF NOT EXISTS "articulos_emp_code" ON "articulos" ("empresa","item_code");

CREATE TABLE IF NOT EXISTS "existencias" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "item_code" varchar(64) NOT NULL,
  "existencia" double precision DEFAULT 0 NOT NULL,
  "en_pedido" double precision DEFAULT 0 NOT NULL,
  "comprometido" double precision DEFAULT 0 NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS "existencias_emp_code" ON "existencias" ("empresa","item_code");

CREATE TABLE IF NOT EXISTS "consumo_trimestral" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "item_code" varchar(64) NOT NULL,
  "t0" double precision DEFAULT 0 NOT NULL,
  "t1" double precision DEFAULT 0 NOT NULL,
  "t2" double precision DEFAULT 0 NOT NULL,
  "t3" double precision DEFAULT 0 NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS "consumo_emp_code" ON "consumo_trimestral" ("empresa","item_code");

CREATE TABLE IF NOT EXISTS "ejecucion_presupuesto" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "categoria" text NOT NULL,
  "periodo" varchar(32),
  "ejecutado" double precision DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS "matriz_aprobacion" (
  "id" serial PRIMARY KEY NOT NULL,
  "regla" varchar(16) NOT NULL,
  "monto_desde" double precision DEFAULT 0 NOT NULL,
  "monto_hasta" double precision DEFAULT 0 NOT NULL,
  "dentro_presupuesto" varchar(16) NOT NULL,
  "niveles_requeridos" varchar(32) NOT NULL,
  "descripcion" text
);

CREATE TABLE IF NOT EXISTS "cuentas_contables" (
  "codigo" varchar(32) PRIMARY KEY NOT NULL,
  "nombre" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "matriz_contable" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" text NOT NULL,
  "cta" varchar(8) NOT NULL,
  "dim1" text DEFAULT '' NOT NULL,
  "dim2" text DEFAULT '' NOT NULL,
  "dim3" text DEFAULT '' NOT NULL,
  "dim4" text DEFAULT '' NOT NULL,
  "dim5" text DEFAULT '' NOT NULL,
  "proyecto" text DEFAULT '' NOT NULL,
  "departamento" text DEFAULT '' NOT NULL,
  "subdepartamento" text DEFAULT '' NOT NULL,
  "ubicacion" text DEFAULT '' NOT NULL,
  "linea_producto" text DEFAULT '' NOT NULL,
  "producto" text DEFAULT '' NOT NULL,
  "nombre_proyecto" text DEFAULT '' NOT NULL
);

CREATE TABLE IF NOT EXISTS "categoria_cuenta" (
  "categoria" text PRIMARY KEY NOT NULL,
  "cuenta6" varchar(32),
  "cuenta7" varchar(32),
  "requiere_placa" boolean DEFAULT false NOT NULL,
  "requiere_obra" boolean DEFAULT false NOT NULL,
  "nota" text
);

CREATE TABLE IF NOT EXISTS "homologacion" (
  "id" serial PRIMARY KEY NOT NULL,
  "codigo_corporativo" varchar(64) NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "codigo_local" varchar(64) NOT NULL,
  "descripcion_local" text,
  "precio_prom" double precision DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "users" (
  "id" varchar(64) PRIMARY KEY NOT NULL,
  "email" varchar(256) NOT NULL UNIQUE,
  "nombre" text NOT NULL,
  "rol" varchar(32) NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "puesto" text,
  "azure_oid" varchar(128),
  "activo" boolean DEFAULT true NOT NULL,
  "created_at" timestamp with time zone DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "solicitudes" (
  "id" varchar(32) PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "solicitante_id" varchar(64) NOT NULL,
  "solicitante_nombre" text NOT NULL,
  "estado" varchar(32) NOT NULL,
  "total" double precision DEFAULT 0 NOT NULL,
  "dentro_presupuesto" boolean DEFAULT true NOT NULL,
  "ruta" jsonb NOT NULL,
  "bud" jsonb NOT NULL,
  "required_date" varchar(16) NOT NULL,
  "comentario" text DEFAULT '',
  "doc_num" varchar(32),
  "created_at" timestamp with time zone DEFAULT now(),
  "approved_at" timestamp with time zone,
  "sent_at" timestamp with time zone
);

CREATE TABLE IF NOT EXISTS "solicitud_lineas" (
  "id" serial PRIMARY KEY NOT NULL,
  "solicitud_id" varchar(32) NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "item_code" varchar(64) NOT NULL,
  "item_name" text NOT NULL,
  "categoria" text NOT NULL,
  "qty" double precision NOT NULL,
  "price" double precision NOT NULL,
  "total" double precision NOT NULL,
  "sug" double precision DEFAULT 0 NOT NULL,
  "alerta" varchar(32) NOT NULL,
  "justificacion" text DEFAULT '',
  "disp" double precision DEFAULT 0,
  "min" double precision DEFAULT 0,
  "max" double precision DEFAULT 0,
  "contable" jsonb NOT NULL
);

CREATE TABLE IF NOT EXISTS "bitacora" (
  "id" serial PRIMARY KEY NOT NULL,
  "solicitud_id" varchar(32) NOT NULL,
  "ts" timestamp with time zone DEFAULT now() NOT NULL,
  "user_name" text NOT NULL,
  "accion" text NOT NULL,
  "detalle" text DEFAULT ''
);

CREATE TABLE IF NOT EXISTS "sap_post_lines" (
  "id" serial PRIMARY KEY NOT NULL,
  "doc_num" varchar(32) NOT NULL,
  "payload" jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now()
);

CREATE TABLE IF NOT EXISTS "sequences" (
  "name" varchar(32) PRIMARY KEY NOT NULL,
  "value" integer DEFAULT 0 NOT NULL
);
