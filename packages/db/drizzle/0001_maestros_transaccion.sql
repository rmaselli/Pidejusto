ALTER TABLE "empresas" ADD COLUMN IF NOT EXISTS "company_db" varchar(128) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "empresas" ADD COLUMN IF NOT EXISTS "activo" boolean DEFAULT true NOT NULL;--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bodegas" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "codigo" varchar(32) NOT NULL,
  "nombre" text NOT NULL,
  "warehouse_code" varchar(32) NOT NULL,
  "activo" boolean DEFAULT true NOT NULL
);--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "bodegas_emp_codigo" ON "bodegas" ("empresa","codigo");--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tipos_documento" (
  "codigo" varchar(32) PRIMARY KEY NOT NULL,
  "nombre" text NOT NULL,
  "objeto_sap" varchar(64) DEFAULT 'PurchaseRequests' NOT NULL,
  "activo" boolean DEFAULT true NOT NULL
);--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "series_documento" (
  "id" serial PRIMARY KEY NOT NULL,
  "empresa" varchar(64) NOT NULL,
  "tipo_codigo" varchar(32) NOT NULL,
  "bodega_codigo" varchar(32) DEFAULT '' NOT NULL,
  "prefijo" varchar(32) DEFAULT '' NOT NULL,
  "siguiente" integer DEFAULT 1 NOT NULL,
  "digitos" integer DEFAULT 5 NOT NULL,
  "activo" boolean DEFAULT true NOT NULL
);--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "series_emp_tipo_bod" ON "series_documento" ("empresa","tipo_codigo","bodega_codigo");--> statement-breakpoint
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "bodega_codigo" varchar(32) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "tipo_documento" varchar(32) DEFAULT 'SC' NOT NULL;--> statement-breakpoint
ALTER TABLE "solicitudes" ALTER COLUMN "doc_num" TYPE varchar(64);--> statement-breakpoint
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "sap_doc_num" varchar(64);--> statement-breakpoint
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "company_db" varchar(128) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "sap_post_lines" ALTER COLUMN "doc_num" TYPE varchar(64);--> statement-breakpoint
ALTER TABLE "sap_post_lines" ADD COLUMN IF NOT EXISTS "empresa" varchar(64) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "sap_post_lines" ADD COLUMN IF NOT EXISTS "bodega_codigo" varchar(32) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "sap_post_lines" ADD COLUMN IF NOT EXISTS "tipo_documento" varchar(32) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "sap_post_lines" ADD COLUMN IF NOT EXISTS "numero_documento" varchar(64) DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE "sap_post_lines" ADD COLUMN IF NOT EXISTS "company_db" varchar(128) DEFAULT '' NOT NULL;--> statement-breakpoint
INSERT INTO "tipos_documento" ("codigo", "nombre", "objeto_sap", "activo")
VALUES ('SC', 'Solicitud de compra', 'PurchaseRequests', true)
ON CONFLICT ("codigo") DO NOTHING;--> statement-breakpoint
UPDATE "empresas"
SET "company_db" = 'SBO_' || upper(regexp_replace("codigo", '[^A-Za-z0-9]+', '_', 'g'))
WHERE coalesce("company_db", '') = '';--> statement-breakpoint
INSERT INTO "bodegas" ("empresa", "codigo", "nombre", "warehouse_code", "activo")
SELECT "codigo", '01', 'Bodega principal', '01', true FROM "empresas"
ON CONFLICT ("empresa", "codigo") DO NOTHING;--> statement-breakpoint
INSERT INTO "series_documento" ("empresa", "tipo_codigo", "bodega_codigo", "prefijo", "siguiente", "digitos", "activo")
SELECT "codigo", 'SC', '', regexp_replace("codigo", '\s+', '', 'g') || '-SC-', 1, 5, true FROM "empresas"
ON CONFLICT ("empresa", "tipo_codigo", "bodega_codigo") DO NOTHING;
