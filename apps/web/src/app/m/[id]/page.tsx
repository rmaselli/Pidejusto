"use client";

import { useParams, useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { api, type Solicitud } from "@/lib/api";
import { Badge } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { fFecha, fQ } from "@/lib/utils";

export default function MobileDetalle() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const [req, setReq] = useState<Solicitud | null>(null);
  const [comentario, setComentario] = useState("");
  const [ai, setAi] = useState("");
  const [ask, setAsk] = useState<"aprobar" | "rechazar" | null>(null);
  const [msg, setMsg] = useState("");

  useEffect(() => {
    void api.solicitud(id).then(setReq).catch((e) => setMsg(e.message));
  }, [id]);

  async function confirm() {
    if (!req || !ask) return;
    try {
      if (ask === "rechazar" && !comentario.trim()) {
        setMsg("Rechazar exige comentario");
        return;
      }
      if (ask === "aprobar") await api.aprobar(req.id, comentario);
      else await api.rechazar(req.id, comentario);
      router.replace("/m");
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  if (!req) return <div className="text-muted">{msg || "Cargando…"}</div>;

  const canAct = req.estado.startsWith("Pendiente N");

  return (
    <div className="space-y-3 pb-24">
      <button className="text-sm font-bold text-brand-700" onClick={() => router.back()}>
        ← Volver
      </button>
      <div className="rounded-[20px] border border-line bg-card p-4">
        <div className="text-xs font-bold text-brand-700">{req.empresa}</div>
        <h1 className="font-display text-2xl font-bold">{req.id}</h1>
        <div className="font-display text-2xl font-extrabold">{fQ(req.total)}</div>
        <div className="mt-2 flex flex-wrap gap-1">
          <Badge tone="dark">{req.estado}</Badge>
          <Badge>{req.ruta?.regla}</Badge>
        </div>
      </div>

      {req.lines.map((l, i) => (
        <div key={i} className="rounded-[20px] border border-line bg-card p-4 text-sm">
          <div className="font-bold">{l.name}</div>
          <div className="text-muted">
            {l.qty} · sug {l.sug} · {fQ(l.total)}
          </div>
          <div className="mt-2 flex flex-wrap gap-1">
            <Badge tone={l.alerta === "En rango" ? "ok" : "warn"}>{l.alerta}</Badge>
            <Badge tone={l.ct.ok ? "ok" : "bad"}>{l.ct.validacion}</Badge>
          </div>
          <div className="mt-1 text-xs text-muted">
            {l.ct.cta} · {l.ct.depN}/{l.ct.subN}
          </div>
        </div>
      ))}

      <div className="rounded-[20px] border border-line bg-card p-4">
        <h3 className="font-bold">Bitácora</h3>
        <div className="mt-2 border-l-2 border-line pl-3 text-sm">
          {req.bit.map((b, i) => (
            <div key={i} className="py-1">
              <div className="text-[11px] text-muted">{fFecha(b.ts)}</div>
              <b>{b.user}</b> · {b.accion}
              {b.detalle && <div className="text-muted">{b.detalle}</div>}
            </div>
          ))}
        </div>
      </div>

      <Button
        variant="claude"
        className="w-full min-h-12 rounded-2xl"
        onClick={() =>
          void api.aiResumen(req.id).then((r) =>
            setAi(
              `${r.source === "local" ? "Motor local · sin Claude\n" : ""}${r.text}`,
            ),
          )
        }
      >
        Resumen con Claude
      </Button>
      {ai && (
        <pre className="whitespace-pre-wrap rounded-2xl border border-brand-600 bg-soft p-3 text-sm">
          {ai}
        </pre>
      )}

      {canAct && (
        <div className="fixed inset-x-0 bottom-[72px] z-20 mx-auto flex max-w-[560px] gap-2 px-3">
          <Button
            variant="danger"
            className="flex-1 min-h-12 rounded-2xl"
            onClick={() => setAsk("rechazar")}
          >
            Rechazar
          </Button>
          <Button
            variant="primary"
            className="flex-1 min-h-12 rounded-2xl"
            onClick={() => setAsk("aprobar")}
          >
            Aprobar
          </Button>
        </div>
      )}

      {ask && (
        <div className="fixed inset-0 z-40 grid place-items-end bg-black/40 p-3">
          <div className="w-full max-w-[560px] rounded-3xl bg-card p-4">
            <h3 className="font-display text-lg font-bold">
              {ask === "aprobar" ? "Confirmar aprobación" : "Confirmar rechazo"}
            </h3>
            <textarea
              className="mt-3 w-full rounded-xl border border-line p-3"
              placeholder={
                ask === "aprobar" ? "Comentario opcional" : "Motivo del rechazo"
              }
              value={comentario}
              onChange={(e) => setComentario(e.target.value)}
            />
            <div className="mt-3 flex gap-2">
              <Button className="flex-1" onClick={() => setAsk(null)}>
                Cancelar
              </Button>
              <Button
                className="flex-1"
                variant={ask === "aprobar" ? "primary" : "danger"}
                onClick={() => void confirm()}
              >
                Confirmar
              </Button>
            </div>
            {msg && <p className="mt-2 text-sm text-danger">{msg}</p>}
          </div>
        </div>
      )}
    </div>
  );
}
