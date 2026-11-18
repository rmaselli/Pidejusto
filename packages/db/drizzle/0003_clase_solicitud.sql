ALTER TABLE "solicitudes" ADD COLUMN IF NOT EXISTS "clase" varchar(16) DEFAULT 'articulo' NOT NULL;
