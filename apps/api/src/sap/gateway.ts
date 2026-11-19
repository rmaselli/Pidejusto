import { randomUUID } from "node:crypto";
import { config } from "../config.js";

export class GatewayError extends Error {
  status: number;
  code: string;
  requestId?: string;
  constructor(message: string, status: number, code: string, requestId?: string) {
    super(message);
    this.name = "GatewayError";
    this.status = status;
    this.code = code;
    this.requestId = requestId;
  }
}

export type SapItemHit = {
  ItemCode: string;
  ItemName: string;
  ForeignName: string;
};

/**
 * Búsqueda de artículos en la pasarela OData.
 * La referencia de Service Layer documenta:
 * GET Items?$select=ItemCode,ItemName,ForeignName&$filter=startswith(...)&$orderby=ItemCode&$top=
 * El gateway reenvía eso a la empresa de X-Company y devuelve el JSON de SAP en `data`.
 */
export async function searchItemsGateway(
  company: string,
  q: string,
  top = 40,
): Promise<SapItemHit[]> {
  if (!config.gateway.apiKey) {
    throw new GatewayError("Pasarela SAP sin API key", 503, "NOT_CONFIGURED");
  }
  const companyCode = company.trim();
  if (!companyCode) {
    throw new GatewayError("Indique la empresa SAP (X-Company)", 400, "COMPANY_REQUIRED");
  }

  const params = [
    "$select=ItemCode,ItemName,ForeignName",
    "$orderby=ItemCode",
    `$top=${Math.min(Math.max(top, 1), 100)}`,
  ];
  const term = q.trim().toLocaleUpperCase("es").replace(/'/g, "''").slice(0, 40);
  if (term) {
    // substringof es el "contiene" de OData 3, el protocolo que cita la referencia.
    // startswith es el ejemplo publicado para Items.
    params.push(
      `$filter=${encodeURIComponent(
        `startswith(ItemCode,'${term}') or substringof('${term}',ItemCode) or substringof('${term}',ItemName) or substringof('${term}',ForeignName)`,
      )}`,
    );
  }

  const path = `/api/v1/odata/Items?${params.join("&")}`;
  let data: unknown;
  try {
    data = await gatewayGet(path, companyCode);
  } catch (e) {
    if (!(e instanceof GatewayError) || e.code !== "BAD_REQUEST" || !term) throw e;
    const simple = [
      "$select=ItemCode,ItemName,ForeignName",
      "$orderby=ItemCode",
      `$top=${Math.min(Math.max(top, 1), 100)}`,
      `$filter=${encodeURIComponent(`startswith(ItemCode,'${term}') or startswith(ItemName,'${term}')`)}`,
    ];
    data = await gatewayGet(`/api/v1/odata/Items?${simple.join("&")}`, companyCode);
  }
  const value = readValue(data);
  return value
    .map((row) => ({
      ItemCode: String(row.ItemCode || "").trim(),
      ItemName: String(row.ItemName || "").trim(),
      ForeignName: String(row.ForeignName || "").trim(),
    }))
    .filter((row) => row.ItemCode);
}

/** Busca cuentas activas por código o nombre. Una sola página: no recorre el catálogo. */
export async function searchCuentasGateway(company: string, q: string): Promise<SapOpcion[]> {
  if (!config.gateway.apiKey) {
    throw new GatewayError("Pasarela SAP sin API key", 503, "NOT_CONFIGURED");
  }
  const companyCode = company.trim();
  if (!companyCode) {
    throw new GatewayError("Indique la empresa SAP (X-Company)", 400, "COMPANY_REQUIRED");
  }
  const term = q.trim().toLocaleUpperCase("es").replace(/'/g, "''").slice(0, 40);
  if (term.length < 2) return [];

  const top = 30;
  const attempts = [
    {
      select: "Code,Name,ActiveAccount,FatherAccountKey,FormatCode",
      filter: `ActiveAccount eq 'tYES' and (startswith(Code,'${term}') or substringof('${term}',Name) or startswith(FormatCode,'${term}'))`,
    },
    {
      select: "Code,Name,FatherAccountKey",
      filter: `startswith(Code,'${term}') or substringof('${term}',Name)`,
    },
  ];
  let rows: Record<string, unknown>[] = [];
  let last: GatewayError | null = null;
  for (const attempt of attempts) {
    try {
      const data = await gatewayGet(
        `/api/v1/odata/ChartOfAccounts?$select=${attempt.select}&$orderby=Code&$top=${top}&$filter=${encodeURIComponent(attempt.filter)}`,
        companyCode,
      );
      rows = readValue(data);
      last = null;
      break;
    } catch (e) {
      if (!(e instanceof GatewayError) || e.code !== "BAD_REQUEST") throw e;
      last = e;
    }
  }
  if (last) throw last;

  const padres = new Set(
    rows.map((r) => String(r.FatherAccountKey || "").trim()).filter(Boolean),
  );
  return rows
    .filter((r) => isYes(r.ActiveAccount))
    .map((r) => ({
      code: String(r.Code || "").trim(),
      name: String(r.Name || "").trim(),
      formato: String(r.FormatCode || "").trim() || undefined,
    }))
    .filter((r) => r.code && !padres.has(r.code));
}

const serviceCache = new Map<string, { at: number; rows: Record<string, unknown>[] }>();
const SERVICE_CACHE_MS = 5 * 60 * 1000;

/** La lista de un servicio no acepta $filter. Se pide una vez y se filtra en memoria. */
async function serviceList(company: string, action: string) {
  const key = `${company}|${action}`;
  const hit = serviceCache.get(key);
  if (hit && Date.now() - hit.at < SERVICE_CACHE_MS) return hit.rows;
  const data = await gatewayPost(`/api/v1/odata/${action}`, company);
  const rows = readRows(data);
  serviceCache.set(key, { at: Date.now(), rows });
  return rows;
}

function textoBusqueda(q: string) {
  const raw = q.trim().toLocaleUpperCase("es").slice(0, 40);
  return { raw, odata: raw.replace(/'/g, "''") };
}

function contiene(term: string, ...parts: unknown[]) {
  return parts.some((part) => String(part || "").toLocaleUpperCase("es").includes(term));
}

export async function searchProyectosGateway(company: string, q: string): Promise<SapOpcion[]> {
  const companyCode = company.trim();
  const { odata } = textoBusqueda(q);
  if (!companyCode) throw new GatewayError("Indique la empresa SAP (X-Company)", 400, "COMPANY_REQUIRED");
  if (odata.length < 2) return [];
  const text = `startswith(Code,'${odata}') or substringof('${odata}',Name)`;
  const attempts = [
    { select: "Code,Name,ValidFrom,ValidTo", filter: text },
    { select: "Code,Name", filter: text },
  ];
  const today = new Date().toISOString().slice(0, 10);
  let last: GatewayError | null = null;
  for (const attempt of attempts) {
    try {
      const data = await gatewayGet(
        `/api/v1/odata/Projects?$select=${attempt.select}&$orderby=Code&$top=30&$filter=${encodeURIComponent(attempt.filter)}`,
        companyCode,
      );
      return readValue(data)
        .filter((r) => vigente(r.ValidFrom, r.ValidTo, today))
        .map((r) => ({
          code: String(r.Code || "").trim(),
          name: String(r.Name || "").trim() || String(r.Code || "").trim(),
        }))
        .filter((r) => r.code);
    } catch (e) {
      if (!(e instanceof GatewayError) || e.code !== "BAD_REQUEST") throw e;
      last = e;
    }
  }
  throw last || new GatewayError("SAP rechazó la consulta de proyectos", 400, "BAD_REQUEST");
}

export async function searchDimensionGateway(
  company: string,
  n: number,
  q: string,
): Promise<{ items: SapOpcion[]; nombre: string }> {
  const companyCode = company.trim();
  const { raw, odata } = textoBusqueda(q);
  if (!companyCode) throw new GatewayError("Indique la empresa SAP (X-Company)", 400, "COMPANY_REQUIRED");
  if (!(n >= 1 && n <= 5)) throw new GatewayError("Dimensión inválida", 400, "BAD_REQUEST");
  const nombre = await nombreDimension(companyCode, n);
  if (raw.length < 2) return { items: [], nombre };

  let centros: SapOpcion[] = [];
  let centrosError: GatewayError | null = null;
  try {
    centros = await searchCentros(companyCode, n, odata);
  } catch (e) {
    if (!(e instanceof GatewayError)) throw e;
    if (!esFalta(e)) throw e;
    centrosError = e;
  }

  let reglas: SapOpcion[] = [];
  let reglasError: GatewayError | null = null;
  try {
    const rows = await serviceList(companyCode, "DistributionRulesService_GetDistributionRuleList");
    reglas = rows
      .filter((r) => Number(r.InWhichDimension) === n && isYes(r.Active))
      .filter((r) => contiene(raw, r.FactorCode, r.FactorDescription))
      .map((r) => ({
        code: String(r.FactorCode || "").trim(),
        name: String(r.FactorDescription || "").trim() || String(r.FactorCode || "").trim(),
      }))
      .filter((r) => r.code);
  } catch (e) {
    if (!(e instanceof GatewayError)) throw e;
    if (!esFalta(e)) throw e;
    reglasError = e;
  }

  if (centrosError && reglasError) throw centrosError;
  const vistos = new Set<string>();
  const items: SapOpcion[] = [];
  for (const item of [...centros, ...reglas]) {
    if (vistos.has(item.code)) continue;
    vistos.add(item.code);
    items.push(item);
    if (items.length >= 30) break;
  }
  return { items, nombre };
}

async function searchCentros(company: string, n: number, odata: string) {
  const text = `startswith(CenterCode,'${odata}') or substringof('${odata}',CenterName)`;
  const attempts = [
    {
      select: "CenterCode,CenterName,InWhichDimension,Active",
      filter: `InWhichDimension eq ${n} and Active eq 'tYES' and (${text})`,
    },
    {
      select: "CenterCode,CenterName,InWhichDimension",
      filter: `InWhichDimension eq ${n} and (${text})`,
    },
  ];
  let last: GatewayError | null = null;
  for (const attempt of attempts) {
    try {
      const data = await gatewayGet(
        `/api/v1/odata/ProfitCenters?$select=${attempt.select}&$orderby=CenterCode&$top=30&$filter=${encodeURIComponent(attempt.filter)}`,
        company,
      );
      return readValue(data)
        .filter((r) => isYes(r.Active))
        .map((r) => ({
          code: String(r.CenterCode || "").trim(),
          name: String(r.CenterName || "").trim() || String(r.CenterCode || "").trim(),
        }))
        .filter((r) => r.code);
    } catch (e) {
      if (!(e instanceof GatewayError) || e.code !== "BAD_REQUEST") throw e;
      last = e;
    }
  }
  throw last || new GatewayError("SAP rechazó la consulta de centros", 400, "BAD_REQUEST");
}

async function nombreDimension(company: string, n: number) {
  try {
    const rows = await serviceList(company, "DimensionsService_GetDimensionList");
    const row = rows.find((r) => Number(r.DimensionCode) === n);
    const nombre = String(row?.DimensionName || row?.DimensionDescription || "").trim();
    if (nombre) return nombre;
  } catch (e) {
    if (!(e instanceof GatewayError) || !esFalta(e)) throw e;
  }
  return DIM_ESPERADA[n - 1] || "Dimensión";
}

function esFalta(e: GatewayError) {
  return (
    e.code === "ENDPOINT_NOT_FOUND" ||
    e.code === "ENDPOINT_DISABLED" ||
    e.code === "FORBIDDEN" ||
    e.code === "BAD_REQUEST"
  );
}

export function gatewayCompanyFor(empresaCodigo: string) {
  const code = empresaCodigo.trim().toUpperCase();
  return config.gateway.companies[code] || config.gateway.company || empresaCodigo.trim();
}

async function gatewayPost(
  path: string,
  company: string,
  idempotencyKey = randomUUID(),
  attempt = 0,
): Promise<unknown> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), Math.max(config.sap.timeoutMs, 30000));
  try {
    const res = await fetch(`${config.gateway.baseUrl}${path}`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-API-KEY": config.gateway.apiKey,
        "X-Company": company,
        "Idempotency-Key": idempotencyKey,
      },
      body: "{}",
      signal: controller.signal,
    });
    const body = (await res.json().catch(() => ({}))) as {
      success?: boolean;
      data?: unknown;
      error?: string;
      message?: string;
      requestId?: string;
    };
    if (res.ok && body.success !== false) return body.data ?? body;

    if (attempt < 1 && [429, 502, 504].includes(res.status)) {
      const wait = Number(res.headers.get("Retry-After")) || 1;
      await delay(Math.min(wait, 5) * 1000);
      return gatewayPost(path, company, idempotencyKey, attempt + 1);
    }

    const code = body.error || `HTTP_${res.status}`;
    const message = body.message || "La pasarela SAP no respondió";
    console.error(`gateway ${code} company=${company} requestId=${body.requestId || "-"}`);
    throw new GatewayError(`SAP ${company}: ${message}`, res.status || 502, code, body.requestId);
  } catch (e) {
    if (e instanceof GatewayError) throw e;
    const aborted = (e as Error).name === "AbortError";
    throw new GatewayError(
      aborted ? "SAP no respondió a tiempo" : `SAP no disponible: ${(e as Error).message}`,
      504,
      aborted ? "SAP_TIMEOUT" : "SAP_UNAVAILABLE",
    );
  } finally {
    clearTimeout(timeout);
  }
}

async function gatewayGet(path: string, company: string, attempt = 0): Promise<unknown> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), Math.max(config.sap.timeoutMs, 30000));
  try {
    const res = await fetch(`${config.gateway.baseUrl}${path}`, {
      headers: {
        Accept: "application/json",
        "X-API-KEY": config.gateway.apiKey,
        "X-Company": company,
      },
      signal: controller.signal,
    });
    const body = (await res.json().catch(() => ({}))) as {
      success?: boolean;
      data?: unknown;
      error?: string;
      message?: string;
      requestId?: string;
    };
    if (res.ok && body.success !== false) return body.data ?? body;

    if (attempt < 1 && [429, 502, 504].includes(res.status)) {
      const wait = Number(res.headers.get("Retry-After")) || 1;
      await delay(Math.min(wait, 5) * 1000);
      return gatewayGet(path, company, attempt + 1);
    }

    const code = body.error || `HTTP_${res.status}`;
    const message = body.message || "La pasarela SAP no respondió";
    console.error(
      `gateway ${code} company=${company} requestId=${body.requestId || "-"}`,
    );
    throw new GatewayError(`SAP ${company}: ${message}`, res.status || 502, code, body.requestId);
  } catch (e) {
    if (e instanceof GatewayError) throw e;
    const aborted = (e as Error).name === "AbortError";
    throw new GatewayError(
      aborted ? "SAP no respondió a tiempo" : `SAP no disponible: ${(e as Error).message}`,
      504,
      aborted ? "SAP_TIMEOUT" : "SAP_UNAVAILABLE",
    );
  } finally {
    clearTimeout(timeout);
  }
}

function readRows(data: unknown): Record<string, unknown>[] {
  const rows = readValue(data);
  if (rows.length) return rows;
  if (!data || typeof data !== "object" || Array.isArray(data)) return rows;
  for (const value of Object.values(data as Record<string, unknown>)) {
    if (Array.isArray(value)) {
      const list = value.filter(
        (row): row is Record<string, unknown> => !!row && typeof row === "object",
      );
      if (list.length) return list;
    } else if (value && typeof value === "object") {
      const nested = readValue(value);
      if (nested.length) return nested;
    }
  }
  return [];
}

function readValue(data: unknown): Record<string, unknown>[] {
  if (!data || typeof data !== "object") return [];
  const record = data as { value?: unknown };
  const value = Array.isArray(record.value) ? record.value : Array.isArray(data) ? data : [];
  return value.filter((row): row is Record<string, unknown> => !!row && typeof row === "object");
}

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export type SapOpcion = { code: string; name: string; formato?: string };

export type ServicioMaestrosSap = {
  company: string;
  cuentas: SapOpcion[];
  proyectos: SapOpcion[];
  dimensiones: {
    n: number;
    nombre: string;
    esperado: string;
    origen: "centros" | "reglas" | "ambos" | "sin-datos";
    opciones: SapOpcion[];
  }[];
  faltantes: { entidad: string; code: string; message: string }[];
  avisos: string[];
};

const DIM_ESPERADA = [
  "Departamento",
  "Sub departamento",
  "Localidad",
  "Línea de producto",
  "Producto",
];

type ODataAttempt = { select: string; filter?: string; orderby?: string };

/**
 * Maestros de la línea de servicio, según la referencia de Service Layer:
 * ProfitCenters sigue en OData. Las cuentas de mayor se buscan aparte, por texto.
 * Projects se consulta con GET /odata/Projects.
 * DimensionsService_GetDimensionList y DistributionRulesService_GetDistributionRuleList siguen en servicio.
 * Cada llamada va aparte: si IT no la tiene en la lista blanca, las demás siguen.
 */
export async function loadServicioMaestros(company: string): Promise<ServicioMaestrosSap> {
  const companyCode = company.trim();
  if (!config.gateway.apiKey) {
    throw new GatewayError("Pasarela SAP sin API key", 503, "NOT_CONFIGURED");
  }
  if (!companyCode) {
    throw new GatewayError("Indique la empresa SAP (X-Company)", 400, "COMPANY_REQUIRED");
  }

  const faltantes: ServicioMaestrosSap["faltantes"] = [];
  const avisos: string[] = [];

  const proyectosRaw = await readEntity(
    "Projects",
    [
      { select: "Code,Name,ValidFrom,ValidTo", orderby: "Code" },
      { select: "Code,Name", orderby: "Code" },
    ],
    companyCode,
    faltantes,
  );
  const dimensionesRaw = await readService(
    "DimensionsService",
    "DimensionsService_GetDimensionList",
    companyCode,
    faltantes,
  );
  const centrosRaw = await readEntity(
    "ProfitCenters",
    [
      { select: "CenterCode,CenterName,InWhichDimension,Active", orderby: "CenterCode" },
      { select: "CenterCode,CenterName,InWhichDimension", orderby: "CenterCode" },
      { select: "CenterCode,CenterName,GroupCode", orderby: "CenterCode" },
    ],
    companyCode,
    faltantes,
  );
  const reglasRaw = await readService(
    "DistributionRulesService",
    "DistributionRulesService_GetDistributionRuleList",
    companyCode,
    faltantes,
  );

  const today = new Date().toISOString().slice(0, 10);
  const proyectos = proyectosRaw
    .filter((r) => vigente(r.ValidFrom, r.ValidTo, today))
    .map((r) => ({
      code: String(r.Code || "").trim(),
      name: String(r.Name || "").trim() || String(r.Code || "").trim(),
    }))
    .filter((r) => r.code)
    .sort((a, b) => a.name.localeCompare(b.name, "es"));

  const nombresSap = new Map<number, string>();
  for (const r of dimensionesRaw) {
    const n = Number(r.DimensionCode);
    if (!(n >= 1 && n <= 5)) continue;
    const nombre = String(r.DimensionName || r.DimensionDescription || "").trim();
    if (nombre) nombresSap.set(n, nombre);
    if (r.IsActive != null && !isYes(r.IsActive)) {
      avisos.push(`La dimensión ${n} (${nombre || DIM_ESPERADA[n - 1]}) está inactiva en SAP.`);
    }
  }

  const centros = bucket(centrosRaw, "CenterCode", "CenterName", "Active");
  const reglas = bucket(reglasRaw, "FactorCode", "FactorDescription", "Active");
  if (centrosRaw.length && centros.sinDimension === centrosRaw.length) {
    avisos.push(
      "ProfitCenters no trae InWhichDimension: no se puede saber qué centro es departamento, localidad o producto.",
    );
  }
  if (reglasRaw.length && reglas.sinDimension === reglasRaw.length) {
    avisos.push(
      "DistributionRulesService no trae InWhichDimension: no se puede asignar cada regla a una dimensión.",
    );
  }
  if (!nombresSap.size && !faltantes.some((f) => f.entidad === "DimensionsService")) {
    avisos.push(
      "DimensionsService no devolvió nombres: las etiquetas quedan como Departamento, Sub departamento, Localidad, Línea de producto y Producto, en las dimensiones 1 a 5.",
    );
  }

  const dimensiones = DIM_ESPERADA.map((esperado, i) => {
    const n = i + 1;
    const nombre = nombresSap.get(n) || esperado;
    if (nombresSap.has(n) && norm(nombre) !== norm(esperado)) {
      avisos.push(
        `La dimensión ${n} en SAP se llama «${nombre}». En la pantalla estaba como ${esperado}.`,
      );
    }
    const deCentros = centros.porDimension.get(n) || [];
    const deReglas = reglas.porDimension.get(n) || [];
    let origen: ServicioMaestrosSap["dimensiones"][number]["origen"] = "sin-datos";
    let opciones: SapOpcion[] = [];
    if (deCentros.length && deReglas.length) {
      origen = "ambos";
      opciones = [...deCentros, ...deReglas.filter((r) => !deCentros.some((c) => c.code === r.code))];
      avisos.push(
        `La dimensión ${n} (${nombre}) tiene centros de beneficio y reglas de distribución. La lista incluye ambos.`,
      );
    } else if (deCentros.length) {
      origen = "centros";
      opciones = deCentros;
    } else if (deReglas.length) {
      origen = "reglas";
      opciones = deReglas;
    } else if (!faltantes.some((f) => f.entidad === "ProfitCenters" || f.entidad === "DistributionRulesService")) {
      avisos.push(`La dimensión ${n} (${nombre}) no tiene centros ni reglas activas en SAP.`);
    }
    return { n, nombre, esperado, origen, opciones };
  });

  return { company: companyCode, cuentas: [], proyectos, dimensiones, faltantes, avisos };
}

/** POST sin cuerpo, como lo documenta Service Layer para estos servicios. */
async function readService(
  entity: string,
  action: string,
  company: string,
  faltantes: ServicioMaestrosSap["faltantes"],
) {
  try {
    const data = await gatewayPost(`/api/v1/odata/${action}`, company);
    return readRows(data);
  } catch (e) {
    if (!(e instanceof GatewayError)) throw e;
    if (
      e.code === "ENDPOINT_NOT_FOUND" ||
      e.code === "ENDPOINT_DISABLED" ||
      e.code === "FORBIDDEN" ||
      e.code === "BAD_REQUEST"
    ) {
      faltantes.push({ entidad: entity, code: e.code, message: e.message });
      return [];
    }
    throw e;
  }
}

async function readEntity(
  entity: string,
  attempts: ODataAttempt[],
  company: string,
  faltantes: ServicioMaestrosSap["faltantes"],
) {
  let last: GatewayError | null = null;
  for (const attempt of attempts) {
    try {
      return await odataAll(entity, attempt, company);
    } catch (e) {
      if (!(e instanceof GatewayError)) throw e;
      if (e.code === "BAD_REQUEST") {
        last = e;
        continue;
      }
      if (e.code === "ENDPOINT_NOT_FOUND" || e.code === "ENDPOINT_DISABLED" || e.code === "FORBIDDEN") {
        faltantes.push({ entidad: entity, code: e.code, message: e.message });
        return [];
      }
      throw e;
    }
  }
  faltantes.push({
    entidad: entity,
    code: last?.code || "BAD_REQUEST",
    message: last?.message || "SAP rechazó la consulta",
  });
  return [];
}

async function odataAll(entity: string, attempt: ODataAttempt, company: string) {
  const rows: Record<string, unknown>[] = [];
  const page = 1000;
  for (let skip = 0; skip < 3000; skip += page) {
    const params = [`$select=${attempt.select}`, `$top=${page}`, `$skip=${skip}`];
    if (attempt.orderby) params.push(`$orderby=${attempt.orderby}`);
    if (attempt.filter) params.push(`$filter=${encodeURIComponent(attempt.filter)}`);
    const data = await gatewayGet(`/api/v1/odata/${entity}?${params.join("&")}`, company);
    const value = readValue(data);
    rows.push(...value);
    if (value.length < page) break;
  }
  return rows;
}

function bucket(
  rows: Record<string, unknown>[],
  codeKey: string,
  nameKey: string,
  activeKey: string,
) {
  const porDimension = new Map<number, SapOpcion[]>();
  let sinDimension = 0;
  for (const row of rows) {
    if (row[activeKey] != null && String(row[activeKey]) !== "" && !isYes(row[activeKey])) continue;
    const code = String(row[codeKey] || "").trim();
    if (!code) continue;
    const n = Number(row.InWhichDimension);
    if (!(n >= 1 && n <= 5)) {
      sinDimension += 1;
      continue;
    }
    const list = porDimension.get(n) || [];
    if (!list.some((item) => item.code === code)) {
      list.push({ code, name: String(row[nameKey] || "").trim() || code });
    }
    porDimension.set(n, list);
  }
  for (const list of porDimension.values()) {
    list.sort((a, b) => a.name.localeCompare(b.name, "es"));
  }
  return { porDimension, sinDimension };
}

function isYes(value: unknown) {
  const s = String(value ?? "").trim().toUpperCase();
  return s === "" || s === "TYES" || s === "Y" || s === "TRUE";
}

function vigente(from: unknown, to: unknown, today: string) {
  const inicio = String(from || "").slice(0, 10);
  const fin = String(to || "").slice(0, 10);
  if (inicio && inicio > today) return false;
  if (fin && fin < today) return false;
  return true;
}

function norm(value: string) {
  return value
    .normalize("NFD")
    .replace(/\p{M}/gu, "")
    .toLowerCase()
    .replace(/[^a-z0-9]/g, "");
}
