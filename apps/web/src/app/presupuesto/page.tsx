"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/components/auth-provider";
import { api, type PresupuestoRow } from "@/lib/api";
import { Badge, Card } from "@/components/ui/card";
import { fQ } from "@/lib/utils";

export default function PresupuestoPage() {
  const { user } = useAuth();
  const [rows, setRows] = useState<PresupuestoRow[]>([]);

  useEffect(() => {
    const emp = user?.rol === "Aprobador N1" ? user.emp : undefined;
    void api.presupuesto(emp).then((r) => setRows(r.rows));
  }, [user]);

  const kpis = rows.reduce(
    (a, r) => {
      a.presup += r.presup;
      a.ejec += r.ejec;
      a.comp += r.comprometido;
      a.disp += r.disponible;
      return a;
    },
    { presup: 0, ejec: 0, comp: 0, disp: 0 },
  );

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold">Dashboard de presupuesto</h1>
      <div className="grid gap-3 sm:grid-cols-4">
        {[
          ["Presupuestado", kpis.presup],
          ["Ejecutado SAP", kpis.ejec],
          ["Comprometido app", kpis.comp],
          ["Disponible", kpis.disp],
        ].map(([l, v]) => (
          <Card key={l as string}>
            <div className="text-[10.5px] font-bold uppercase text-muted">{l as string}</div>
            <div className="font-display text-xl font-bold">{fQ(v as number)}</div>
          </Card>
        ))}
      </div>
      <Card className="overflow-auto">
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-xs uppercase text-muted">
              <th className="p-2">Empresa</th>
              <th className="p-2">Categoría</th>
              <th className="p-2 text-right">Presup.</th>
              <th className="p-2 text-right">Ejec.</th>
              <th className="p-2 text-right">Comp.</th>
              <th className="p-2 text-right">Disp.</th>
              <th className="p-2">Estado</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r, i) => (
              <tr key={i} className="border-t border-line">
                <td className="p-2">{r.empresa}</td>
                <td className="p-2">{r.categoria}</td>
                <td className="p-2 text-right">{fQ(r.presup)}</td>
                <td className="p-2 text-right">{fQ(r.ejec)}</td>
                <td className="p-2 text-right">{fQ(r.comprometido)}</td>
                <td className="p-2 text-right">{fQ(r.disponible)}</td>
                <td className="p-2">
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
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </Card>
    </div>
  );
}
