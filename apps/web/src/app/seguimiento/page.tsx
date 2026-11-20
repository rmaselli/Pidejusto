"use client";

import { useEffect, useState } from "react";
import { api, type Solicitud, type SolicitudListItem } from "@/lib/api";
import { Badge, Card } from "@/components/ui/card";
import { dimsLinea, fFecha, fQ } from "@/lib/utils";

const STEPS = ["Pendiente N1", "Aprobada", "Enviada a SAP"];

function fSap(fecha?: string | null, hora?: string | null) {
  const dia = String(fecha || "").slice(0, 10);
  const [y, m, d] = dia.split("-");
  const texto = y && m && d ? `${d}/${m}/${y.slice(2)}` : "";
  return [texto, hora || ""].filter(Boolean).join(" ");
}

export default function SeguimientoPage() {
  const [items, setItems] = useState<SolicitudListItem[]>([]);
  const [sel, setSel] = useState<Solicitud | null>(null);
  const [sapMsg, setSapMsg] = useState("");

  useEffect(() => {
    void api.solicitudes().then((r) => setItems(r.items));
  }, []);

  async function open(id: string) {
    setSapMsg("");
    const item = await api.solicitud(id);
    setSel(item);
    if (!item.sapDocNum && !item.sapDocEntry) return;
    try {
      setSel(await api.seguimientoSap(id));
    } catch (e) {
      setSapMsg((e as Error).message);
    }
  }

  return (
    <div className="grid gap-6 lg:grid-cols-[1fr_1fr]">
      <div className="space-y-3">
        <h1 className="font-display text-2xl font-bold">Seguimiento</h1>
        {items.map((r) => (
          <button key={r.id} className="w-full text-left" onClick={() => void open(r.id)}>
            <Card>
              <div className="flex justify-between">
                <div>
                  <div className="font-bold">
                    {r.id}{" "}
                    <Badge>{r.clase === "servicio" ? "Servicio" : "Artículo"}</Badge>
                  </div>
                  <div className="text-sm text-muted">
                    {r.empresa}
                    {r.bodegaCodigo ? ` · bod ${r.bodegaCodigo}` : ""}
                    {r.docNum ? ` · ${r.tipoDocumento || ""} ${r.docNum}` : ""} · {r.solicitanteNombre}
                  </div>
                </div>
                <div className="text-right">
                  <div className="font-display font-bold">{fQ(r.total)}</div>
                  <Badge tone="dark">{r.estado}</Badge>
                </div>
              </div>
            </Card>
          </button>
        ))}
      </div>
      {sel && (
        <Card>
          <h2 className="font-display text-xl font-bold">{sel.id}</h2>
          <p className="mt-1 text-sm text-muted">
            {sel.empresa}
            {sel.bodegaCodigo ? ` · bodega ${sel.bodegaCodigo}` : ""}
            {sel.tipoDocumento ? ` · ${sel.tipoDocumento}` : ""}
            {sel.docNum ? ` ${sel.docNum}` : ""}
            {sel.companyDb ? ` · ${sel.companyDb}` : ""}
            {sel.sapDocNum ? ` · solicitud de pedido ${sel.sapDocNum}` : ""}
          </p>
          <div className="mt-3 rounded-xl border border-line p-3 text-sm">
            <div className="text-xs font-bold uppercase text-muted">SAP</div>
            {sel.sapDocNum ? (
              <div className="mt-2 space-y-1">
                <div>
                  Solicitud de pedido <b>{sel.sapDocNum}</b>
                  {fSap(sel.sapDocDate, sel.sapDocTime)
                    ? ` · creada ${fSap(sel.sapDocDate, sel.sapDocTime)}`
                    : ""}
                </div>
                <div>
                  {sel.ordenCompraNum ? (
                    <>
                      Orden de compra <b>{sel.ordenCompraNum}</b>
                      {fSap(sel.ordenCompraFecha, sel.ordenCompraHora)
                        ? ` · creada ${fSap(sel.ordenCompraFecha, sel.ordenCompraHora)}`
                        : ""}
                    </>
                  ) : (
                    "Aún no se convierte en orden de compra"
                  )}
                </div>
              </div>
            ) : (
              <p className="mt-2 text-muted">Todavía no se envía a SAP.</p>
            )}
            {sapMsg && <p className="mt-2 text-muted">{sapMsg}</p>}
          </div>
          <div className="mt-3 flex flex-wrap items-center gap-1">
            {STEPS.map((s, i) => {
              const idx = STEPS.indexOf(sel.estado);
              const rejected = sel.estado === "Rechazada";
              const done = !rejected && idx >= i;
              const now = sel.estado === s;
              return (
                <div key={s} className="flex items-center gap-1 text-xs font-semibold">
                  <span
                    className={`grid h-6 w-6 place-items-center rounded-full border-2 ${
                      rejected && i === 0
                        ? "border-danger bg-danger text-white"
                        : done || now
                          ? "border-lima bg-lima text-brand-900"
                          : "border-line bg-soft text-muted"
                    }`}
                  >
                    {i + 1}
                  </span>
                  <span className="mr-2">{s.replace("Pendiente ", "")}</span>
                </div>
              );
            })}
          </div>
          <div className="mt-4 space-y-2">
            {sel.lines.map((l, i) => (
              <div key={i} className="rounded-xl border border-line p-3 text-sm">
                <div className="font-semibold">{l.name}</div>
                {l.code && <div className="text-xs text-muted">{l.code}</div>}
                <div className="text-muted">
                  {l.qty} × {fQ(l.price || 0)} = {fQ(l.total)}
                </div>
                {l.cat === "Servicio" && (
                  <div className="mt-1 text-xs text-muted">{dimsLinea(l.ct)}</div>
                )}
              </div>
            ))}
          </div>
          <div className="mt-4 border-l-2 border-line pl-3 text-sm">
            {sel.bit.map((b, i) => (
              <div key={i} className="py-1">
                <div className="text-xs text-muted">{fFecha(b.ts)}</div>
                <b>{b.user}</b> · {b.accion}
                {b.detalle && <div className="text-muted">{b.detalle}</div>}
              </div>
            ))}
          </div>
        </Card>
      )}
    </div>
  );
}
