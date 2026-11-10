const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:4000";

export type NivelAprobacion = {
  codigo: string;
  nombre: string;
  orden: number;
  alcance: "empresa" | "todas";
  descripcion: string;
  activo: boolean;
};

export type ReglaAprobacion = {
  id: number;
  regla: string;
  desde: number;
  hasta: number;
  dentro: string;
  niveles: string;
  desc: string;
};

export type User = {
  id: string;
  email?: string;
  nombre: string;
  rol: string;
  emp: string;
  puesto: string;
};

async function request<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(`${API_URL}${path}`, {
    ...init,
    credentials: "include",
    headers: {
      "Content-Type": "application/json",
      ...(init?.headers || {}),
    },
  });
  if (!res.ok) {
    const body = await res.json().catch(() => ({ error: res.statusText }));
    throw new Error(body.error || `HTTP ${res.status}`);
  }
  return res.json() as Promise<T>;
}

export const api = {
  url: API_URL,
  me: () => request<{ user: User | null; authMode?: string }>("/auth/me"),
  demoUsers: () => request<{ users: User[] }>("/auth/users-demo"),
  demoLogin: (userId: string) =>
    request<{ user: User }>("/auth/demo-login", {
      method: "POST",
      body: JSON.stringify({ userId }),
    }),
  logout: () => request<{ ok: boolean }>("/auth/logout", { method: "POST" }),
  articulos: (empresa: string, q?: string) =>
    request<{ items: Articulo[] }>(
      `/api/catalog/articulos?empresa=${encodeURIComponent(empresa)}${q ? `&q=${encodeURIComponent(q)}` : ""}`,
    ),
  articulo: (empresa: string, code: string) =>
    request<ArticuloDetalle>(
      `/api/catalog/articulos/${encodeURIComponent(empresa)}/${encodeURIComponent(code)}`,
    ),
  contable: (empresa: string) =>
    request<{
      anexo: string;
      cta: { codigo: string; nombre: string }[];
      catcta: unknown[];
      centros: string[][];
    }>(`/api/catalog/contable/${encodeURIComponent(empresa)}`),
  previewLine: (body: unknown) =>
    request<PreviewLine>("/api/solicitudes/preview-line", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  createSolicitud: (body: unknown) =>
    request<Solicitud>("/api/solicitudes", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  solicitudes: (qs = "") =>
    request<{ items: SolicitudListItem[] }>(`/api/solicitudes${qs}`),
  solicitud: (id: string) => request<Solicitud>(`/api/solicitudes/${id}`),
  pendientes: () =>
    request<{ items: Solicitud[] }>("/api/aprobaciones/pendientes"),
  historial: () =>
    request<{ items: Solicitud[] }>("/api/aprobaciones/historial"),
  aprobar: (id: string, comentario?: string) =>
    request<Solicitud>(`/api/solicitudes/${id}/aprobar`, {
      method: "POST",
      body: JSON.stringify({ comentario }),
    }),
  rechazar: (id: string, comentario: string) =>
    request<Solicitud>(`/api/solicitudes/${id}/rechazar`, {
      method: "POST",
      body: JSON.stringify({ comentario }),
    }),
  aprobadas: () => request<{ items: Solicitud[] }>("/api/bodega/aprobadas"),
  enviarSap: (ids: string[]) =>
    request<{
      ok: boolean;
      docNums: Record<string, string>;
      documents?: {
        empresa: string;
        bodega: string;
        tipoDocumento: string;
        docNum: string;
        sapDocNum: string;
        companyDb: string;
      }[];
    }>("/api/bodega/enviar-sap", { method: "POST", body: JSON.stringify({ ids }) }),
  postLines: () =>
    request<{ items: { id: number; docNum: string; payload: unknown }[] }>(
      "/api/bodega/post-lines",
    ),
  presupuesto: (empresa?: string) =>
    request<{ rows: PresupuestoRow[] }>(
      `/api/presupuesto/dashboard${empresa ? `?empresa=${encodeURIComponent(empresa)}` : ""}`,
    ),
  metricas: () => request<Metricas>("/api/metricas"),
  sapStatus: () =>
    request<{ provider: string; label: string; ok: boolean; detail: string }>(
      "/api/sap/status",
    ),
  aiSearch: (text: string) =>
    request<{ source: string; items: { itemCode: string; motivo: string }[] }>(
      "/api/ai/search",
      { method: "POST", body: JSON.stringify({ text }) },
    ),
  aiResumen: (id: string) =>
    request<{ source: string; text: string }>("/api/ai/resumen", {
      method: "POST",
      body: JSON.stringify({ id }),
    }),
  adminUsers: () => request<{ users: User[] }>("/api/admin/users"),
  patchUser: (id: string, body: Partial<User & { activo: boolean; empresa?: string }>) =>
    request<{ user: User }>(`/api/admin/users/${id}`, {
      method: "PATCH",
      body: JSON.stringify(body),
    }),
  createUser: (body: {
    email: string;
    nombre: string;
    rol: string;
    empresa: string;
    puesto?: string;
  }) =>
    request<{ user: User }>("/api/admin/users", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  deleteUser: (id: string) =>
    request<{ ok: boolean }>(`/api/admin/users/${encodeURIComponent(id)}`, {
      method: "DELETE",
    }),
  nivelesAprobacion: () =>
    request<{
      niveles: NivelAprobacion[];
      reglas: ReglaAprobacion[];
      cadenas: string[];
    }>("/api/niveles-aprobacion"),
  saveNivel: (
    codigo: string,
    body: Pick<NivelAprobacion, "nombre" | "descripcion" | "alcance" | "activo">,
  ) =>
    request<{ nivel: NivelAprobacion }>(
      `/api/admin/niveles-aprobacion/${encodeURIComponent(codigo)}`,
      { method: "PATCH", body: JSON.stringify(body) },
    ),
  saveReglaNiveles: (id: number, niveles: string) =>
    request<{ regla: ReglaAprobacion }>(`/api/admin/matriz-aprobacion/${id}`, {
      method: "PATCH",
      body: JSON.stringify({ niveles }),
    }),
  empresas: () => request<{ empresas: Empresa[] }>("/api/empresas"),
  saveEmpresa: (codigo: string, body: Partial<Empresa>) =>
    request<{ empresa: Empresa }>(`/api/admin/empresas/${encodeURIComponent(codigo)}`, {
      method: "PATCH",
      body: JSON.stringify(body),
    }),
  createEmpresa: (body: { codigo: string; nombreAnexo: string; companyDb: string }) =>
    request<{ empresa: Empresa }>("/api/admin/empresas", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  bodegas: (empresa?: string) =>
    request<{ bodegas: Bodega[] }>(
      `/api/bodegas${empresa ? `?empresa=${encodeURIComponent(empresa)}` : ""}`,
    ),
  createBodega: (body: {
    empresa: string;
    codigo: string;
    nombre: string;
    warehouseCode: string;
  }) =>
    request<{ bodega: Bodega }>("/api/admin/bodegas", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  saveBodega: (id: number, body: Partial<Bodega>) =>
    request<{ bodega: Bodega }>(`/api/admin/bodegas/${id}`, {
      method: "PATCH",
      body: JSON.stringify(body),
    }),
  tiposDocumento: () => request<{ tipos: TipoDocumento[] }>("/api/tipos-documento"),
  createTipo: (body: { codigo: string; nombre: string; objetoSap: string }) =>
    request<{ tipo: TipoDocumento }>("/api/admin/tipos-documento", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  saveTipo: (codigo: string, body: Partial<TipoDocumento>) =>
    request<{ tipo: TipoDocumento }>(
      `/api/admin/tipos-documento/${encodeURIComponent(codigo)}`,
      { method: "PATCH", body: JSON.stringify(body) },
    ),
  seriesDocumento: (empresa?: string) =>
    request<{ series: SerieDocumento[] }>(
      `/api/series-documento${empresa ? `?empresa=${encodeURIComponent(empresa)}` : ""}`,
    ),
  createSerie: (body: {
    empresa: string;
    tipoCodigo: string;
    bodegaCodigo?: string;
    prefijo: string;
    siguiente: number;
    digitos: number;
  }) =>
    request<{ serie: SerieDocumento }>("/api/admin/series-documento", {
      method: "POST",
      body: JSON.stringify(body),
    }),
  saveSerie: (id: number, body: Partial<SerieDocumento>) =>
    request<{ serie: SerieDocumento }>(`/api/admin/series-documento/${id}`, {
      method: "PATCH",
      body: JSON.stringify(body),
    }),
};

export type Empresa = {
  codigo: string;
  nombreAnexo: string;
  companyDb: string;
  activo: boolean;
};

export type Bodega = {
  id: number;
  empresa: string;
  codigo: string;
  nombre: string;
  warehouseCode: string;
  activo: boolean;
};

export type TipoDocumento = {
  codigo: string;
  nombre: string;
  objetoSap: string;
  activo: boolean;
};

export type SerieDocumento = {
  id: number;
  empresa: string;
  tipoCodigo: string;
  bodegaCodigo: string;
  prefijo: string;
  siguiente: number;
  digitos: number;
  activo: boolean;
};

export type Articulo = {
  empresa: string;
  itemCode: string;
  itemName: string;
  categoria: string;
  precioProm: number;
};

export type ArticuloDetalle = {
  art: Articulo & { leadTimeDias: number; codigoCorporativo?: string };
  stock: { ex: number; ped: number; com: number };
  consumo: number[];
  mm: { min: number; max: number; clase: string; avg: number };
  disponible: number;
};

export type PreviewLine = {
  line: {
    code: string;
    name: string;
    cat: string;
    qty: number;
    price: number;
    total: number;
    sug: number;
    alerta: string;
    just: string;
    disp: number;
    min: number;
    max: number;
    ct: { cta: string; ok: boolean; validacion: string; [k: string]: unknown };
  };
  alerta: { tipo: string; sug: number; exige: boolean; msg: string };
  mm: { min: number; max: number };
  centros: string[][];
};

export type SolicitudListItem = {
  id: string;
  empresa: string;
  bodegaCodigo?: string;
  tipoDocumento?: string;
  docNum?: string;
  sapDocNum?: string;
  companyDb?: string;
  solicitanteNombre: string;
  estado: string;
  total: number;
  dentroPresupuesto: boolean;
  requiredDate: string;
  createdAt?: string;
};

export type Solicitud = SolicitudListItem & {
  lines: {
    code: string;
    name: string;
    cat: string;
    qty: number;
    sug: number;
    alerta: string;
    total: number;
    just: string;
    ct: { cta: string; ok: boolean; validacion: string; depN?: string; subN?: string };
  }[];
  bit: { ts: string; user: string; accion: string; detalle: string }[];
  ruta: { regla: string; niveles: string; desc: string };
  bud: { dentro: boolean; cats: { cat: string; monto: number; disp: number; dentro: boolean }[] };
  comentario?: string;
  docNum?: string;
};

export type PresupuestoRow = {
  empresa: string;
  categoria: string;
  presup: number;
  ejec: number;
  comprometido: number;
  disponible: number;
  uso: number;
  estado: string;
};

export type Metricas = {
  byEstado: Record<string, number>;
  pctPresupuesto: number;
  tiempoPromedioMs: number | null;
  total: number;
};
