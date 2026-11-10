"use client";

import { useEffect, useState } from "react";
import { api, type Solicitud } from "@/lib/api";
import { Badge, Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { fQ } from "@/lib/utils";

export default function BodegaPage() {
  const [items, setItems] = useState<Solicitud[]>([]);
  const [sel, setSel] = useState<Set<string>>(new Set());
  const [msg, setMsg] = useState("");
  const [post, setPost] = useState<{ id: number; docNum: string; payload: unknown }[]>([]);

  async function load() {
    const [a, p] = await Promise.all([api.aprobadas(), api.postLines()]);
    setItems(a.items);
    setPost(p.items);
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  function toggle(id: string) {
    setSel((prev) => {
      const n = new Set(prev);
      if (n.has(id)) n.delete(id);
      else n.add(id);
      return n;
    });
  }

  async function enviar() {
    try {
      const r = await api.enviarSap([...sel]);
      setMsg(
        `Enviado · ${
          (r.documents || [])
            .map((d) => `${d.tipoDocumento} ${d.docNum} · ${d.companyDb || d.empresa}`)
            .join(" · ") || Object.values(r.docNums).join(", ")
        }`,
      );
      setSel(new Set());
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold">Bodega → SAP</h1>
        <p className="text-sm text-muted">
          Consolida solicitudes aprobadas y genera PurchaseRequests (mock o Service Layer).
        </p>
      </div>
      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <h2 className="font-bold">Aprobadas pendientes de envío</h2>
          <div className="mt-3 space-y-2">
            {items.map((r) => (
              <label
                key={r.id}
                className="flex cursor-pointer items-start gap-3 rounded-xl border border-line p-3"
              >
                <input
                  type="checkbox"
                  checked={sel.has(r.id)}
                  onChange={() => toggle(r.id)}
                />
                <span className="flex-1">
                  <div className="font-bold">{r.id}</div>
                  <div className="text-sm text-muted">
                    {r.empresa}
                    {r.bodegaCodigo ? ` · bod ${r.bodegaCodigo}` : ""}
                    {r.tipoDocumento ? ` · ${r.tipoDocumento}` : ""}
                    {r.docNum ? ` ${r.docNum}` : ""} · {r.solicitanteNombre}
                  </div>
                </span>
                <span className="font-display font-bold">{fQ(r.total)}</span>
              </label>
            ))}
            {!items.length && (
              <p className="text-sm text-muted">No hay solicitudes aprobadas.</p>
            )}
          </div>
          <Button
            className="mt-4 w-full"
            variant="primary"
            disabled={!sel.size}
            onClick={() => void enviar()}
          >
            Enviar a SAP ({sel.size})
          </Button>
          {msg && <p className="mt-2 text-sm">{msg}</p>}
        </Card>
        <Card>
          <h2 className="font-bold">Hoja SolicitudCompra_POST</h2>
          <div className="mt-3 max-h-[480px] overflow-auto text-xs">
            <table className="w-full">
              <thead>
                <tr className="text-left text-muted">
                  <th className="p-2">DocNum</th>
                  <th className="p-2">Payload</th>
                </tr>
              </thead>
              <tbody>
                {post.map((p) => (
                  <tr key={p.id} className="border-t border-line align-top">
                    <td className="p-2 whitespace-nowrap">
                      <Badge tone="lima">{p.docNum}</Badge>
                    </td>
                    <td className="p-2 font-mono">
                      {JSON.stringify(p.payload).slice(0, 180)}…
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Card>
      </div>
    </div>
  );
}
