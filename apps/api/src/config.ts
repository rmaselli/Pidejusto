import { config as loadEnv } from "dotenv";
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "../../..");
loadEnv({ path: resolve(root, ".env") });
loadEnv();

export const config = {
  port: Number(process.env.API_PORT || 4000),
  webUrl: process.env.WEB_URL || "http://localhost:3000",
  apiUrl: process.env.API_URL || "http://localhost:4000",
  databaseUrl:
    process.env.DATABASE_URL ||
    "postgresql://pidejusto:pidejusto@localhost:5432/pidejusto",
  sessionSecret: process.env.SESSION_SECRET || "dev-secret-change-me",
  authMode: (process.env.AUTH_MODE || "demo") as "demo" | "azure",
  azure: {
    clientId: process.env.AZURE_AD_CLIENT_ID || "",
    clientSecret: process.env.AZURE_AD_CLIENT_SECRET || "",
    tenantId: process.env.AZURE_AD_TENANT_ID || "",
    redirectUri:
      process.env.AZURE_AD_REDIRECT_URI ||
      "http://localhost:4000/auth/callback",
  },
  sap: {
    provider: (process.env.SAP_PROVIDER || "mock") as "mock" | "http",
    baseUrl: process.env.SAP_BASE_URL || "",
    companyDb: process.env.SAP_COMPANY_DB || "",
    username: process.env.SAP_USERNAME || "",
    password: process.env.SAP_PASSWORD || "",
    timeoutMs: Number(process.env.SAP_TIMEOUT_MS || 15000),
  },
  anthropicApiKey: process.env.ANTHROPIC_API_KEY || "",
  nodeEnv: process.env.NODE_ENV || "development",
};
