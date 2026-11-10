export type Role =
  | "Solicitante"
  | "Aprobador N1"
  | "Aprobador N2"
  | "Aprobador N3"
  | "Bodega"
  | "Compras"
  | "Admin";

export const ROLES: Role[] = [
  "Solicitante",
  "Aprobador N1",
  "Aprobador N2",
  "Aprobador N3",
  "Bodega",
  "Compras",
  "Admin",
];

export type NivelCodigo = "N1" | "N2" | "N3";

export type SolicitudEstado =
  | "Pendiente N1"
  | "Pendiente N2"
  | "Pendiente N3"
  | "Aprobada"
  | "Enviada a SAP"
  | "Rechazada";

export const ABIERTOS: SolicitudEstado[] = [
  "Pendiente N1",
  "Pendiente N2",
  "Pendiente N3",
  "Aprobada",
];

export const COMPROMETEN: SolicitudEstado[] = [
  "Pendiente N1",
  "Pendiente N2",
  "Pendiente N3",
  "Aprobada",
  "Enviada a SAP",
];

export interface NivelAprobacion {
  codigo: NivelCodigo;
  nombre: string;
  orden: number;
  alcance: "empresa" | "todas";
  descripcion: string;
  activo: boolean;
}

export interface Params {
  Z: number;
  meses: number;
  ltStd: number;
  ajuste: number;
  margen: number;
  periodo: string;
  dias: number;
}

export interface MinMax {
  clase: "Regular" | "Intermitente" | "Esporádico";
  avg: number;
  sd: number;
  min: number;
  max: number;
  lt: number;
  presup: number;
}

export interface Alerta {
  tipo: "Sobre máximo" | "Cantidad corta" | "En rango" | "Contra pedido";
  sug: number;
  exige: boolean;
  msg: string;
}

export interface MatrizRegla {
  regla: string;
  desde: number;
  hasta: number;
  dentro: string;
  niveles: string;
  desc: string;
}

export interface RutaAprobacion {
  regla: string;
  niveles: string;
  desc: string;
}

export interface ContableImputacion {
  cta: string;
  d1: string;
  d2: string;
  d3: string;
  d4: string;
  d5: string;
  proy: string;
  depN: string;
  subN: string;
  ubiN: string;
  linN: string;
  prodN: string;
  proyN: string;
  detalle: string;
  placa: string;
  obraProc: string;
  obraEsp: string;
  tipoDoc: string;
  ok: boolean;
  validacion: string;
}

export interface LineaSolicitud {
  emp: string;
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
  um?: string;
  corp?: string;
  paraVeh?: boolean;
  ct: ContableImputacion;
}

export interface BudgetCat {
  cat: string;
  monto: number;
  disp: number;
  dentro: boolean;
}

export interface BudgetEval {
  total: number;
  dentro: boolean;
  cats: BudgetCat[];
}

export interface BitacoraEntry {
  ts: string;
  user: string;
  accion: string;
  detalle: string;
}

export interface UserInfo {
  id: string;
  email?: string;
  nombre: string;
  rol: Role;
  emp: string;
  puesto: string;
}

export interface SolicitudPostRow {
  DocNum?: string;
  DocDate: string;
  RequiredDate: string;
  Requester: string;
  Empresa: string;
  ItemCode: string;
  ItemDescription: string;
  Quantity: number;
  WarehouseCode: string;
  Bodega?: string;
  TipoDocumento?: string;
  CompanyDB?: string;
  ObjetoSap?: string;
  AccountCode: string;
  NombreCuenta: string;
  CostingCode: string;
  CostingCode2: string;
  CostingCode3: string;
  CostingCode4: string;
  CostingCode5: string;
  ProjectCode: string;
  UnitPrice_Q: number;
  LineTotal_Q: number;
  TipoDocRespaldo: string;
  DetalleCompra: string;
  PlacaVehiculo: string;
  ObraEnProceso: string;
  NoObraEspecifica: string;
  Validacion: string;
  SolicitudesOrigen: string;
  Comments: string;
}

export interface SapProvider {
  articulos(): Promise<unknown[]>;
  existencias(): Promise<unknown[]>;
  consumo(): Promise<unknown[]>;
  presupuesto(): Promise<unknown>;
  contable(): Promise<unknown>;
  matriz(): Promise<unknown[]>;
  usuarios?(): Promise<unknown[]>;
  postSolicitudCompra(
    rows: SolicitudPostRow[],
    opts?: { companyDbByEmpresa?: Record<string, string> },
  ): Promise<{
    ok: boolean;
    docNums: Record<string, string>;
    documents: SapPostedDocument[];
  }>;
}

export interface SapPostedDocument {
  empresa: string;
  bodega: string;
  tipoDocumento: string;
  docNum: string;
  sapDocNum: string;
  companyDb: string;
  origenes: string[];
}

export const POST_COLS = [
  "DocNum",
  "DocDate",
  "RequiredDate",
  "Requester",
  "Empresa",
  "ItemCode",
  "ItemDescription",
  "Quantity",
  "WarehouseCode",
  "AccountCode",
  "NombreCuenta",
  "CostingCode",
  "CostingCode2",
  "CostingCode3",
  "CostingCode4",
  "CostingCode5",
  "ProjectCode",
  "UnitPrice_Q",
  "LineTotal_Q",
  "TipoDocRespaldo",
  "DetalleCompra",
  "PlacaVehiculo",
  "ObraEnProceso",
  "NoObraEspecifica",
  "Validacion",
  "SolicitudesOrigen",
  "Comments",
] as const;
