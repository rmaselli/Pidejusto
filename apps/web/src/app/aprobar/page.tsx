"use client";

import { useEffect, useState } from "react";
import { api, type Solicitud } from "@/lib/api";
import { Badge, Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { fFecha, fQ } from "@/lib/utils";

export default function AprobarPage() {
  const [items, setItems] = useState<Solicitud[]>([]);
  const [sel, setSel] = useState<Solicitud | null>(null);
  const [comentario, setComentario] = useState("");
  const [ai, setAi] = useState("");
  const [msg, setMsg] = useState("");

  async function load() {
    const r = await api.pendientes();
    setItems(r.items);
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  async function act(kind: "aprobar" | "rechazar") {
    if (!sel) return;
    try {
      if (kind === "rechazar" && !comentario.trim()) {
        setMsg("Rechazar exige comentario");
        return;
      }
      const updated =
        kind === "aprobar"
          ? await api.aprobar(sel.id, comentario)
          : await api.rechazar(sel.id, comentario);
      setMsg(`${updated.id} → ${updated.estado}`);
      setSel(null);
      setComentario("");
      setAi("");
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  return (
    <div className="grid gap-6 lg:grid-cols-[0.9fr_1.1fr]">
      <div className="space-y-3">
        <h1 className="font-display text-2xl font-bold">Aprobaciones</h1>
        {items.length === 0 && (
          <Card className="text-muted">No hay pendientes para tu rol.</Card>
        )}
        {items.map((r) => (
          <button
            key={r.id}
            onClick={() => setSel(r)}
            className="block w-full text-left"
          >
            <Card className={sel?.id === r.id ? "ring-2 ring-lima" : ""}>
              <div className="flex justify-between gap-2">
                <div>
                  <div className="text-xs font-bold text-brand-700">{r.empresa}</div>
                  <div className="font-bold">{r.id}</div>
                  <div className="text-sm text-muted">{r.solicitanteNombre}</div>
                </div>
                <div className="font-display text-xl font-extrabold">{fQ(r.total)}</div>
              </div>
              <div className="mt-2 flex flex-wrap gap-1">
                <Badge tone="dark">{r.estado}</Badge>
                <Badge tone={r.dentroPresupuesto ? "ok" : "bad"}>
                  {r.dentroPresupuesto ? "En presupuesto" : "Fuera presupuesto"}
                </Badge>
                <Badge>{r.ruta?.regla}</Badge>
              </div>
            </Card>
          </button>
        ))}
      </div>

      {sel ? (
        <Card>
          <h2 className="font-display text-xl font-bold">{sel.id}</h2>
          <p className="text-sm text-muted">{sel.ruta?.desc}</p>
          <div className="mt-4 space-y-2">
            {sel.lines.map((l, i) => (
              <div key={i} className="rounded-xl border border-line p-3 text-sm">
                <div className="font-semibold">{l.name}</div>
                <div className="text-muted">
                  Pide {l.qty} · sugerida {l.sug} · {fQ(l.total)}
                </div>
                <div className="mt-1 flex flex-wrap gap-1">
                  <Badge tone={l.alerta === "En rango" ? "ok" : "warn"}>{l.alerta}</Badge>
                  <Badge tone={l.ct.ok ? "ok" : "bad"}>{l.ct.validacion}</Badge>
                </div>
              </div>
            ))}
          </div>
          <div className="mt-4">
            <h3 className="font-bold">Bitácora</h3>
            <div className="mt-2 border-l-2 border-line pl-3 text-sm">
              {sel.bit.map((b, i) => (
                <div key={i} className="py-1">
                  <div className="text-xs text-muted">{fFecha(b.ts)}</div>
                  <div>
                    <b>{b.user}</b> · {b.accion}
                  </div>
                  {b.detalle && <div className="text-muted">{b.detalle}</div>}
                </div>
              ))}
            </div>
          </div>
          <Button
            className="mt-4 w-full"
            variant="claude"
            onClick={() =>
              void api.aiResumen(sel.id).then((r) =>
                setAi(`${r.source === "local" ? "Motor local · sin Claude\n" : ""}${r.text}`),
              )
            }
          >
            Resumen con Claude
          </Button>
          {ai && (
            <pre className="mt-3 whitespace-pre-wrap rounded-xl border border-brand-600 bg-soft p-3 text-sm">
              {ai}
            </pre>
          )}
          <textarea
            className="mt-4 w-full rounded-xl border border-line px-3 py-2"
            placeholder="Comentario (obligatorio al rechazar)"
            value={comentario}
            onChange={(e) => setComentario(e.target.value)}
          />
          <div className="mt-3 flex gap-2">
            <Button variant="danger" className="flex-1" onClick={() => void act("rechazar")}>
              Rechazar
            </Button>
            <Button variant="primary" className="flex-1" onClick={() => void act("aprobar")}>
              Aprobar
            </Button>
          </div>
          {msg && <p className="mt-2 text-sm">{msg}</p>}
        </Card>
      ) : (
        <Card className="grid place-items-center text-muted">
          Selecciona una solicitud
        </Card>
      )}
    </div>
  );
}
