CREATE TABLE IF NOT EXISTS "aprobador_solicitantes" (
  "aprobador_id" varchar(64) NOT NULL,
  "solicitante_id" varchar(64) NOT NULL,
  CONSTRAINT "aprobador_solicitantes_pkey" PRIMARY KEY ("aprobador_id", "solicitante_id")
);

UPDATE "niveles_aprobacion"
SET "activo" = false
WHERE "codigo" IN ('N2', 'N3');

UPDATE "matriz_aprobacion"
SET "niveles_requeridos" = 'N1'
WHERE "niveles_requeridos" <> 'AUTO'
  AND "niveles_requeridos" <> 'N1';

UPDATE "solicitudes"
SET "estado" = 'Aprobada',
    "approved_at" = COALESCE("approved_at", now())
WHERE "estado" IN ('Pendiente N2', 'Pendiente N3');
