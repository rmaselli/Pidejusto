import { createDb } from "@pidejusto/db";
import { config } from "./config.js";
import { createApp } from "./app.js";
import { createSapProvider } from "./sap/index.js";

async function main() {
  const db = createDb(config.databaseUrl);
  const sap = createSapProvider(db);
  const app = createApp(db, sap);
  app.listen(config.port, () => {
    console.log(`Pide Justo API on :${config.port}`);
    console.log(`Auth mode: ${config.authMode} · SAP: ${sap.kind} (${sap.label})`);
  });
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
