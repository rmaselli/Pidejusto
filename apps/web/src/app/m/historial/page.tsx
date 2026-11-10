"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { api, type Solicitud } from "@/lib/api";
import { Badge } from "@/components/ui/card";
import { fQ } from "@/lib/utils";

export default function MobileHistorial() {
  const [items, setItems] = useState<Solicitud[]>([]);

  useEffect(() => {
    void api.historial().then((r) => setItems(r.items));
  }, []);

  if (!items.length) {
    return (
      <div className="rounded-[20px] border border-line bg-card p-8 text-center text-muted">
        Todavía no has aprobado ni rechazado solicitudes.
      </div>
    );
  }

  return (
    <div className="space-y-3">
      {items.map((r) => (
        <Link
          key={r.id}
          href={`/m/${r.id}`}
          className="block rounded-[20px] border border-line bg-card p-3.5"
        >
          <div className="flex justify-between">
            <div>
              <div className="text-xs font-bold text-brand-700">{r.empresa}</div>
              <div className="font-bold">{r.id}</div>
            </div>
            <div className="font-display text-xl font-extrabold">{fQ(r.total)}</div>
          </div>
          <Badge className="mt-2" tone="dark">
            {r.estado}
          </Badge>
        </Link>
      ))}
    </div>
  );
}
