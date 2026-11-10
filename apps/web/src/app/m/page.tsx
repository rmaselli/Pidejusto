"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { api, type Solicitud } from "@/lib/api";
import { Badge } from "@/components/ui/card";
import { fQ } from "@/lib/utils";

export default function MobilePendientes() {
  const [items, setItems] = useState<Solicitud[]>([]);
  const [error, setError] = useState("");

  useEffect(() => {
    void api
      .pendientes()
      .then((r) => setItems(r.items))
      .catch((e) => setError(e.message));
  }, []);

  if (error) return <div className="text-danger">{error}</div>;
  if (!items.length) {
    return (
      <div className="rounded-[20px] border border-line bg-card p-8 text-center text-muted">
        No tienes pendientes. Buen trabajo.
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {items.map((r) => (
        <Link
          key={r.id}
          href={`/m/${r.id}`}
          className="block rounded-[20px] border border-line bg-card p-3.5 shadow-[0_1px_2px_rgba(16,49,43,.06),0_10px_28px_rgba(16,49,43,.07)] active:scale-[0.99]"
        >
          <div className="flex items-start justify-between gap-2">
            <div>
              <span className="text-xs font-bold text-brand-700">{r.empresa}</span>
              <div className="mt-1.5 font-bold">{r.id}</div>
              <div className="text-sm text-muted">{r.solicitanteNombre}</div>
            </div>
            <div className="font-display text-[22px] font-extrabold">{fQ(r.total)}</div>
          </div>
          <div className="mt-2.5 flex flex-wrap gap-1.5">
            <Badge tone="dark">{r.estado}</Badge>
            <Badge tone={r.dentroPresupuesto ? "ok" : "bad"}>
              {r.dentroPresupuesto ? "Presupuesto OK" : "Fuera presup."}
            </Badge>
            <Badge>{r.ruta?.regla}</Badge>
          </div>
        </Link>
      ))}
    </div>
  );
}
