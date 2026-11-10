import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { config as loadEnv } from "dotenv";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

loadEnv({ path: path.resolve(__dirname, "../../../.env") });
loadEnv();

function companyDbName(codigo: string) {
  const slug = codigo
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^A-Za-z0-9]+/g, "_")
    .replace(/^_|_$/g, "")
    .toUpperCase();
  return `SBO_${slug}`;
}

type PjData = {
  params: {
    Z: number;
    meses: number;
    ltStd: number;
    ajuste: number;
    margen: number;
    periodo: string;
    dias: number;
  };
  emp: [string, string][];
  art: [string, string, string, string, string, string, number, number, string][];
  exi: [string, string, number, number, number][];
  con: [string, string, number, number, number, number][];
  eje: [string, string, string, number][];
  usr: [string, string, string, string, string][];
  mat: [string, number, number, string, string, string][];
  cta: [string, string][];
  mcx: string[][];
  catcta: [string, string, string, string, string, string][];
  hom?: Record<string, [string, string, string, number][]>;
};

async function main() {
  const url = process.env.DATABASE_URL;
  if (!url) throw new Error("DATABASE_URL is required");

  const dataPath = path.join(__dirname, "..", "seed", "pj-data.json");
  const data = JSON.parse(fs.readFileSync(dataPath, "utf8")) as PjData;

  const client = postgres(url, { max: 1 });
  const db = drizzle(client, { schema });

  console.log("Clearing tables...");
  await client`
    TRUNCATE
      bitacora, solicitud_lineas, solicitudes, sap_post_lines, sequences,
      series_documento, bodegas, tipos_documento,
      users, homologacion, categoria_cuenta, matriz_contable, cuentas_contables,
      niveles_aprobacion, matriz_aprobacion, ejecucion_presupuesto, consumo_trimestral, existencias,
      articulos, parametros, empresas
    RESTART IDENTITY CASCADE
  `;

  console.log("Seeding empresas...", data.emp.length);
  await db.insert(schema.empresas).values(
    data.emp.map(([codigo, nombreAnexo]) => ({
      codigo,
      nombreAnexo,
      companyDb: companyDbName(codigo),
      activo: true,
    })),
  );

  await db.insert(schema.tiposDocumento).values({
    codigo: "SC",
    nombre: "Solicitud de compra",
    objetoSap: "PurchaseRequests",
    activo: true,
  });

  await db.insert(schema.bodegas).values(
    data.emp.map(([codigo]) => ({
      empresa: codigo,
      codigo: "01",
      nombre: "Bodega principal",
      warehouseCode: "01",
      activo: true,
    })),
  );

  await db.insert(schema.seriesDocumento).values(
    data.emp.map(([codigo]) => ({
      empresa: codigo,
      tipoCodigo: "SC",
      bodegaCodigo: "",
      prefijo: `${codigo.replace(/\s+/g, "")}-SC-`,
      siguiente: 1,
      digitos: 5,
      activo: true,
    })),
  );

  await db.insert(schema.parametros).values({
    z: data.params.Z,
    meses: data.params.meses,
    ltStd: data.params.ltStd,
    ajuste: data.params.ajuste,
    margen: data.params.margen,
    periodo: data.params.periodo,
    dias: data.params.dias,
  });

  console.log("Seeding articulos...", data.art.length);
  const artChunk = 500;
  for (let i = 0; i < data.art.length; i += artChunk) {
    const slice = data.art.slice(i, i + artChunk);
    await db.insert(schema.articulos).values(
      slice.map((r) => ({
        empresa: r[0],
        itemCode: String(r[1]),
        itemName: r[2],
        categoria: r[3],
        area: r[4],
        abc: r[5],
        precioProm: r[6] || 0,
        leadTimeDias: r[7] || 15,
        codigoCorporativo: r[8],
      })),
    );
  }

  console.log("Seeding existencias...", data.exi.length);
  for (let i = 0; i < data.exi.length; i += artChunk) {
    const slice = data.exi.slice(i, i + artChunk);
    await db.insert(schema.existencias).values(
      slice.map((r) => ({
        empresa: r[0],
        itemCode: String(r[1]),
        existencia: r[2] || 0,
        enPedido: r[3] || 0,
        comprometido: r[4] || 0,
      })),
    );
  }

  console.log("Seeding consumo...", data.con.length);
  for (let i = 0; i < data.con.length; i += artChunk) {
    const slice = data.con.slice(i, i + artChunk);
    await db.insert(schema.consumoTrimestral).values(
      slice.map((r) => ({
        empresa: r[0],
        itemCode: String(r[1]),
        t0: r[2] || 0,
        t1: r[3] || 0,
        t2: r[4] || 0,
        t3: r[5] || 0,
      })),
    );
  }

  if (data.eje.length) {
    await db.insert(schema.ejecucionPresupuesto).values(
      data.eje.map((r) => ({
        empresa: r[0],
        categoria: r[1],
        periodo: r[2],
        ejecutado: r[3] || 0,
      })),
    );
  }

  await db.insert(schema.matrizAprobacion).values(
    data.mat.map((r) => ({
      regla: r[0],
      montoDesde: r[1],
      montoHasta: r[2],
      dentroPresupuesto: r[3],
      nivelesRequeridos: r[0] === "R3" ? "N1+N2+N3" : r[4],
      descripcion:
        r[0] === "R3"
          ? "Excede presupuesto y supera Q 10,000: N1, N2 y N3"
          : r[5],
    })),
  );

  await db.insert(schema.nivelesAprobacion).values([
    {
      codigo: "N1",
      nombre: "Aprobador de la empresa",
      orden: 1,
      alcance: "empresa",
      descripcion: "Primera autorización. Solo ve solicitudes de su empresa.",
      activo: true,
    },
    {
      codigo: "N2",
      nombre: "Aprobador de operaciones",
      orden: 2,
      alcance: "todas",
      descripcion: "Segunda autorización. Ve solicitudes de todas las empresas.",
      activo: true,
    },
    {
      codigo: "N3",
      nombre: "Dirección",
      orden: 3,
      alcance: "todas",
      descripcion: "Tercera autorización para montos que superan el tope.",
      activo: true,
    },
  ]);

  console.log("Seeding cuentas...", data.cta.length);
  await db.insert(schema.cuentasContables).values(
    data.cta.map((r) => ({ codigo: String(r[0]), nombre: r[1] })),
  );

  console.log("Seeding matriz contable...", data.mcx.length);
  for (let i = 0; i < data.mcx.length; i += artChunk) {
    const slice = data.mcx.slice(i, i + artChunk);
    await db.insert(schema.matrizContable).values(
      slice.map((r) => ({
        empresa: String(r[0]).trim(),
        cta: String(r[1]),
        dim1: String(r[2] || ""),
        dim2: String(r[3] || ""),
        dim3: String(r[4] || ""),
        dim4: String(r[5] || ""),
        dim5: String(r[6] || ""),
        proyecto: String(r[7] || ""),
        departamento: String(r[8] || ""),
        subdepartamento: String(r[9] || ""),
        ubicacion: String(r[10] || ""),
        lineaProducto: String(r[11] || ""),
        producto: String(r[12] || ""),
        nombreProyecto: String(r[13] || ""),
      })),
    );
  }

  await db.insert(schema.categoriaCuenta).values(
    data.catcta.map((r) => ({
      categoria: r[0],
      cuenta6: r[1] || null,
      cuenta7: r[2] || null,
      requierePlaca: r[3] === "SI",
      requiereObra: r[4] === "SI",
      nota: r[5] || null,
    })),
  );

  if (data.hom) {
    const rows: {
      codigoCorporativo: string;
      empresa: string;
      codigoLocal: string;
      descripcionLocal: string;
      precioProm: number;
    }[] = [];
    for (const [corp, list] of Object.entries(data.hom)) {
      for (const h of list) {
        rows.push({
          codigoCorporativo: corp,
          empresa: h[0],
          codigoLocal: String(h[1]),
          descripcionLocal: h[2],
          precioProm: h[3] || 0,
        });
      }
    }
    if (rows.length) await db.insert(schema.homologacion).values(rows);
  }

  console.log("Seeding users...", data.usr.length);
  await db.insert(schema.users).values(
    data.usr.map((r) => ({
      id: r[0],
      email: `${r[0].toLowerCase()}@grupo-meme.demo`,
      nombre: r[1],
      rol: r[2],
      empresa: r[3],
      puesto: r[4],
      activo: true,
    })),
  );

  // Demo admin
  await db.insert(schema.users).values([
    {
      id: "ADMIN",
      email: "admin@grupo-meme.demo",
      nombre: "Admin Pide Justo",
      rol: "Admin",
      empresa: "TODAS",
      puesto: "Administrador del sistema",
      activo: true,
    },
    {
      id: "DIR",
      email: "direccion@grupo-meme.demo",
      nombre: "Dirección de Operaciones",
      rol: "Aprobador N3",
      empresa: "TODAS",
      puesto: "Dirección",
      activo: true,
    },
  ]);

  await db.insert(schema.sequences).values([
    { name: "req", value: 0 },
    { name: "doc", value: 0 },
  ]);

  await client.end();
  console.log("Seed complete");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
