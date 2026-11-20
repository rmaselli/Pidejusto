ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "sap_doc_entry" integer;
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "sap_doc_date" varchar(16);
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "sap_doc_time" varchar(16);
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "orden_compra_num" varchar(64);
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "orden_compra_fecha" varchar(16);
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "orden_compra_hora" varchar(16);
ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "sap_idempotency_key" varchar(64);
