import { config as loadEnv } from "dotenv";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { drizzle } from "drizzle-orm/postgres-js";
import { migrate } from "drizzle-orm/postgres-js/migrator";
import postgres from "postgres";

const __dirname = dirname(fileURLToPath(import.meta.url));
loadEnv({ path: resolve(__dirname, "../../../.env") });
loadEnv();

async function main() {
  const url = process.env.DATABASE_URL;
  if (!url) throw new Error("DATABASE_URL is required");
  const client = postgres(url, { max: 1 });
  const db = drizzle(client);
  const migrationsFolder = resolve(__dirname, "..", "drizzle");
  console.log("Running migrations from", migrationsFolder);
  await migrate(db, { migrationsFolder });
  await client.end();
  console.log("Migrations complete");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
