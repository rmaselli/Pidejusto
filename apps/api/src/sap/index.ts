import type { Db } from "@pidejusto/db";
import { config } from "../config.js";
import { createHttpProvider } from "./httpProvider.js";
import { createMockProvider } from "./mockProvider.js";
import type { SapProvider } from "./types.js";

export * from "./types.js";

export function createSapProvider(db: Db): SapProvider {
  if (config.sap.provider === "http") return createHttpProvider();
  return createMockProvider(db);
}
