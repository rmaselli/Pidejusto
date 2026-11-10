"use client";

import { useEffect, useState } from "react";
import { api, type Metricas } from "@/lib/api";
import { Card } from "@/components/ui/card";

export default function MetricasPage() {
  const [m, setM] = useState<Metricas | null>(null);
  const [sap, setSap] = useState<{ provider: string; label: string; detail: string } | null>(
    null,
  );

  useEffect(() => {
    void api.metricas().then(setM);
    void api.sapStatus().then(setSap).catch(() => undefined);
  }, []);

  if (!m) return <div className="text-muted">Cargando métricas…</div>;

  const horas =
    m.tiempoPromedioMs != null ? (m.tiempoPromedioMs / 3600000).toFixed(1) : "—";

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold">Métricas</h1>
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
        <Card className="bg-brand-800 text-white">
          <div className="text-[10.5px] font-bold uppercase text-crema/70">Solicitudes</div>
          <div className="font-display text-3xl font-bold">{m.total}</div>
        </Card>
        <Card className="bg-lima text-brand-900">
          <div className="text-[10.5px] font-bold uppercase">% con presupuesto</div>
          <div className="font-display text-3xl font-bold">
            {m.pctPresupuesto.toFixed(0)}%
          </div>
        </Card>
        <Card>
          <div className="text-[10.5px] font-bold uppercase text-muted">
            Tiempo prom. a SAP
          </div>
          <div className="font-display text-3xl font-bold">{horas} h</div>
        </Card>
        <Card>
          <div className="text-[10.5px] font-bold uppercase text-muted">Fuente SAP</div>
          <div className="font-display text-xl font-bold">{sap?.provider || "—"}</div>
          <div className="text-xs text-muted">{sap?.detail}</div>
        </Card>
      </div>
      <Card>
        <h2 className="font-bold">Por estado</h2>
        <div className="mt-3 grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
          {Object.entries(m.byEstado).map(([k, v]) => (
            <div key={k} className="rounded-xl bg-soft p-3">
              <div className="text-xs font-bold uppercase text-muted">{k}</div>
              <div className="font-display text-2xl font-bold">{v}</div>
            </div>
          ))}
        </div>
      </Card>
    </div>
  );
}
