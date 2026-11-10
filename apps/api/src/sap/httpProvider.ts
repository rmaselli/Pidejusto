import type { SapPostedDocument, SolicitudPostRow } from "@pidejusto/shared";
import { config } from "../config.js";
import {
  SapUpstreamUnavailable,
  type SapPostOptions,
  type SapProvider,
} from "./types.js";

/**
 * SAP B1 Service Layer client.
 * Endpoints mirror the hakathon ServiceLayerApi skeleton.
 * SAP_BASE_URL may still be under construction — failures surface as 503.
 */
export function createHttpProvider(): SapProvider {
  const base = config.sap.baseUrl.replace(/\/$/, "");
  const sessions = new Map<string, string>();

  function resolveCompanyDb(companyDb?: string) {
    const name = (companyDb || config.sap.companyDb || "").trim();
    if (!name) {
      throw new SapUpstreamUnavailable(
        "CompanyDB no configurada: indique la base de datos en el mantenimiento de empresas",
      );
    }
    return name;
  }

  async function login(companyDb?: string) {
    if (!base) throw new SapUpstreamUnavailable("SAP_BASE_URL no configurada");
    const dbName = resolveCompanyDb(companyDb);
    const controller = new AbortController();
    const t = setTimeout(() => controller.abort(), config.sap.timeoutMs);
    try {
      const res = await fetch(`${base}/b1s/v2/Login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          CompanyDB: dbName,
          UserName: config.sap.username,
          Password: config.sap.password,
        }),
        signal: controller.signal,
      });
      if (!res.ok) {
        throw new SapUpstreamUnavailable(
          `SAP Login ${res.status} (CompanyDB ${dbName})`,
        );
      }
      const setCookie = res.headers.get("set-cookie");
      if (setCookie) sessions.set(dbName, setCookie.split(";")[0]);
      return dbName;
    } catch (e) {
      if (e instanceof SapUpstreamUnavailable) throw e;
      throw new SapUpstreamUnavailable(
        `SAP no disponible en ${base}: ${(e as Error).message}`,
      );
    } finally {
      clearTimeout(t);
    }
  }

  async function slFetch(
    path: string,
    init: RequestInit = {},
    companyDb?: string,
    retried = false,
  ) {
    const dbName = resolveCompanyDb(companyDb);
    if (!sessions.get(dbName)) await login(dbName);
    const controller = new AbortController();
    const t = setTimeout(() => controller.abort(), config.sap.timeoutMs);
    try {
      const res = await fetch(`${base}/b1s/v2/${path.replace(/^\//, "")}`, {
        ...init,
        headers: {
          "Content-Type": "application/json",
          ...(sessions.get(dbName) ? { Cookie: sessions.get(dbName)! } : {}),
          ...(init.headers || {}),
        },
        signal: controller.signal,
      });
      if (res.status === 401 && !retried) {
        sessions.delete(dbName);
        return slFetch(path, init, dbName, true);
      }
      if (!res.ok) {
        const body = await res.text().catch(() => "");
        throw new SapUpstreamUnavailable(
          `SAP ${res.status} (${dbName}): ${body.slice(0, 200)}`,
        );
      }
      return res.json();
    } catch (e) {
      if (e instanceof SapUpstreamUnavailable) throw e;
      throw new SapUpstreamUnavailable(
        `SAP request failed: ${(e as Error).message}`,
      );
    } finally {
      clearTimeout(t);
    }
  }

  return {
    kind: "http",
    label: `SAP B1 Service Layer → ${base || "(sin URL)"}`,

    async articulos() {
      const j = (await slFetch(
        "Items?$select=ItemCode,ItemName,ItemsGroupCode,AvgStdPrice",
      )) as { value?: unknown[] };
      return j.value ?? (j as unknown as unknown[]);
    },
    async existencias() {
      const j = (await slFetch(
        "Items?$select=ItemCode,ItemWarehouseInfoCollection",
      )) as { value?: unknown[] };
      return j.value ?? (j as unknown as unknown[]);
    },
    async consumo() {
      const j = (await slFetch(
        "SQLQueries('ConsumoTrimestral')/List",
      )) as { value?: unknown[] };
      return j.value ?? (j as unknown as unknown[]);
    },
    async presupuesto() {
      return slFetch("BudgetScenarios");
    },
    async contable() {
      return slFetch("ChartOfAccounts?$select=Code,Name");
    },
    async matriz() {
      const j = (await slFetch("ApprovalTemplates")) as { value?: unknown[] };
      return j.value ?? (j as unknown as unknown[]);
    },
    async postSolicitudCompra(rows: SolicitudPostRow[], opts?: SapPostOptions) {
      const groups = new Map<string, SolicitudPostRow[]>();
      for (const row of rows) {
        const key = [
          row.Empresa,
          row.WarehouseCode,
          row.DocNum || "",
          row.ObjetoSap || "PurchaseRequests",
        ].join("|");
        const list = groups.get(key) || [];
        list.push(row);
        groups.set(key, list);
      }
      const docNums: Record<string, string> = {};
      const documents: SapPostedDocument[] = [];
      for (const empRows of groups.values()) {
        const head = empRows[0];
        const companyDb =
          head.CompanyDB ||
          opts?.companyDbByEmpresa?.[head.Empresa] ||
          config.sap.companyDb;
        const objeto = head.ObjetoSap || "PurchaseRequests";
        const body = {
          DocDate: head.DocDate,
          RequriedDate: head.RequiredDate,
          Comments: head.Comments,
          DocumentLines: empRows.map((x) => ({
            ItemCode: x.ItemCode,
            Quantity: x.Quantity,
            WarehouseCode: x.WarehouseCode,
            AccountCode: x.AccountCode,
            CostingCode: x.CostingCode,
            CostingCode2: x.CostingCode2,
            CostingCode3: x.CostingCode3,
            CostingCode4: x.CostingCode4,
            CostingCode5: x.CostingCode5,
            ProjectCode: x.ProjectCode,
          })),
        };
        const j = (await slFetch(
          objeto,
          { method: "POST", body: JSON.stringify(body) },
          companyDb,
        )) as { DocNum?: string | number; docNum?: string | number };
        const sapDocNum = String(j.DocNum ?? j.docNum ?? "");
        const docNum = head.DocNum || sapDocNum;
        for (const row of empRows) row.DocNum = docNum;
        docNums[head.Empresa] = docNums[head.Empresa]
          ? `${docNums[head.Empresa]}, ${docNum}`
          : docNum;
        const origenes = [
          ...new Set(
            empRows.flatMap((r) =>
              r.SolicitudesOrigen.split(",")
                .map((s) => s.trim())
                .filter(Boolean),
            ),
          ),
        ];
        documents.push({
          empresa: head.Empresa,
          bodega: head.Bodega || head.WarehouseCode,
          tipoDocumento: head.TipoDocumento || "",
          docNum,
          sapDocNum,
          companyDb: resolveCompanyDb(companyDb),
          origenes,
        });
      }
      return { ok: true, docNums, documents };
    },
    async ping() {
      try {
        const dbName = await login();
        return { ok: true, detail: `connected to ${base} · ${dbName}` };
      } catch (e) {
        return { ok: false, detail: (e as Error).message };
      }
    },
  };
}
