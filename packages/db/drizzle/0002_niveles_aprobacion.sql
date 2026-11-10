CREATE TABLE IF NOT EXISTS "niveles_aprobacion" (
  "codigo" varchar(8) PRIMARY KEY NOT NULL,
  "nombre" text NOT NULL,
  "orden" integer NOT NULL,
  "alcance" varchar(16) DEFAULT 'empresa' NOT NULL,
  "descripcion" text DEFAULT '' NOT NULL,
  "activo" boolean DEFAULT true NOT NULL
);

INSERT INTO "niveles_aprobacion" ("codigo", "nombre", "orden", "alcance", "descripcion", "activo")
VALUES
  ('N1', 'Aprobador de la empresa', 1, 'empresa', 'Primera autorización. Solo ve solicitudes de su empresa.', true),
  ('N2', 'Aprobador de operaciones', 2, 'todas', 'Segunda autorización. Ve solicitudes de todas las empresas.', true),
  ('N3', 'Dirección', 3, 'todas', 'Tercera autorización para montos que superan el tope.', true)
ON CONFLICT ("codigo") DO NOTHING;

UPDATE "matriz_aprobacion"
SET
  "niveles_requeridos" = 'N1+N2+N3',
  "descripcion" = 'Excede presupuesto y supera Q 10,000: N1, N2 y N3'
WHERE "regla" = 'R3'
  AND "niveles_requeridos" = 'N1+N2';

INSERT INTO "users" ("id", "email", "nombre", "rol", "empresa", "puesto", "activo")
SELECT
  'DIR',
  'direccion@grupo-meme.demo',
  'Dirección de Operaciones',
  'Aprobador N3',
  'TODAS',
  'Dirección',
  true
WHERE NOT EXISTS (
  SELECT 1 FROM "users"
  WHERE "id" = 'DIR' OR "email" = 'direccion@grupo-meme.demo'
);
