import type { SapPostedDocument, SolicitudPostRow } from "@pidejusto/shared";

export interface SapPostOptions {
  companyDbByEmpresa?: Record<string, string>;
}

export interface SapProvider {
  kind: "mock" | "http";
  label: string;
  articulos(): Promise<unknown[]>;
  existencias(): Promise<unknown[]>;
  consumo(): Promise<unknown[]>;
  presupuesto(): Promise<unknown>;
  contable(): Promise<unknown>;
  matriz(): Promise<unknown[]>;
  postSolicitudCompra(
    rows: SolicitudPostRow[],
    opts?: SapPostOptions,
  ): Promise<{
    ok: boolean;
    docNums: Record<string, string>;
    documents: SapPostedDocument[];
  }>;
  ping?(): Promise<{ ok: boolean; detail: string }>;
}

export class SapUpstreamUnavailable extends Error {
  status = 503;
  constructor(message: string) {
    super(message);
    this.name = "SapUpstreamUnavailable";
  }
}
