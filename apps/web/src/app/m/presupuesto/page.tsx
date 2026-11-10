"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/components/auth-provider";
import { api, type PresupuestoRow } from "@/lib/api";
import { Badge } from "@/components/ui/card";
import { fQ } from "@/lib/utils";

export default function MobilePresupuesto() {
  const { user } = useAuth();
  const [rows, setRows] = useState<PresupuestoRow[]>([]);

  useEffect(() => {
    const emp = user?.rol === "Aprobador N1" ? user.emp : undefined;
    void api.presupuesto(emp).then((r) => setRows(r.rows.slice(0, 40)));
  }, [user]);

  return (
    <div className="space-y-3">
      <h2 className="font-display text-xl font-bold">Presupuesto</h2>
      {rows.map((r, i) => (
        <div key={i} className="rounded-[20px] border border-line bg-card p-3.5">
          <div className="flex justify-between gap-2">
            <div>
              <div className="text-xs font-bold text-brand-700">{r.empresa}</div>
              <div className="font-bold">{r.categoria}</div>
            </div>
            <Badge
              tone={
                r.estado === "sana"
                  ? "ok"
                  : r.estado === "excedida"
                    ? "bad"
                    : "warn"
              }
            >
              {r.estado}
            </Badge>
          </div>
          <div className="mt-2 h-2.5 overflow-hidden rounded-full bg-soft">
            <div
              className="flex h-full"
              style={{ width: `${Math.min(100, r.uso * 100)}%` }}
            >
              <i
                className="block h-full bg-brand-800"
                style={{
                  width: `${r.presup ? (r.ejec / (r.ejec + r.comprometido || 1)) * 100 : 0}%`,
                }}
              />
              <i className="block h-full flex-1 bg-oro" />
            </div>
          </div>
          <div className="mt-2 grid grid-cols-2 gap-2 text-xs">
            <div>Presup. {fQ(r.presup)}</div>
            <div>Ejec. {fQ(r.ejec)}</div>
            <div>Comp. {fQ(r.comprometido)}</div>
            <div>Disp. {fQ(r.disponible)}</div>
          </div>
        </div>
      ))}
    </div>
  );
}
