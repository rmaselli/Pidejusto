"use client";

import { useEffect, useState } from "react";
import { api, type NivelAprobacion, type ReglaAprobacion } from "@/lib/api";
import { useAuth } from "@/components/auth-provider";
import { Badge, Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { fQ } from "@/lib/utils";

const cadenaTxt = (niveles: string) =>
  niveles === "AUTO" ? "Aprobación automática" : niveles.split("+").join(" → ");

export default function NivelesAprobacionPage() {
  const { user } = useAuth();
  const admin = user?.rol === "Admin";
  const [niveles, setNiveles] = useState<NivelAprobacion[]>([]);
  const [reglas, setReglas] = useState<ReglaAprobacion[]>([]);
  const [cadenas, setCadenas] = useState<string[]>([]);
  const [edit, setEdit] = useState(false);
  const [msg, setMsg] = useState("");
  const [busy, setBusy] = useState("");

  async function load() {
    const r = await api.nivelesAprobacion();
    setNiveles(r.niveles);
    setReglas(r.reglas);
    setCadenas(r.cadenas);
  }

  useEffect(() => {
    void load().catch((e) => setMsg((e as Error).message));
  }, []);

  function patchNivel(codigo: string, patch: Partial<NivelAprobacion>) {
    setNiveles((rows) => rows.map((n) => (n.codigo === codigo ? { ...n, ...patch } : n)));
  }

  async function saveNivel(n: NivelAprobacion) {
    setBusy(n.codigo);
    setMsg("");
    try {
      const r = await api.saveNivel(n.codigo, {
        nombre: n.nombre.trim(),
        descripcion: n.descripcion.trim(),
        alcance: n.alcance,
        activo: n.activo,
      });
      patchNivel(n.codigo, r.nivel);
      setMsg(`Nivel ${n.codigo} actualizado`);
    } catch (e) {
      setMsg((e as Error).message);
    } finally {
      setBusy("");
    }
  }

  async function saveRegla(regla: ReglaAprobacion) {
    setBusy(`r${regla.id}`);
    setMsg("");
    try {
      const r = await api.saveReglaNiveles(regla.id, regla.niveles);
      setReglas((rows) => rows.map((x) => (x.id === regla.id ? r.regla : x)));
      setMsg(`Regla ${regla.regla} actualizada`);
    } catch (e) {
      setMsg((e as Error).message);
    } finally {
      setBusy("");
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div>
          <h1 className="font-display text-3xl font-extrabold text-brand-900">
            Niveles de aprobación
          </h1>
          <p className="mt-1 max-w-2xl text-muted">
            El flujo tiene tres niveles, en este orden. Una solicitud avanza al
            siguiente nivel que su regla exige y queda aprobada al completar el último.
          </p>
        </div>
        {admin && (
          <Button variant={edit ? "dark" : "primary"} onClick={() => setEdit((v) => !v)}>
            {edit ? "Cerrar administración" : "Administrar niveles"}
          </Button>
        )}
      </div>

      {msg && <Card className="text-sm">{msg}</Card>}

      <div className="grid gap-4 lg:grid-cols-3">
        {niveles.map((n, i) => (
          <Card key={n.codigo} className={n.activo ? "" : "opacity-60"}>
            <div className="flex items-center justify-between gap-2">
              <Badge tone="dark">
                {i + 1} · {n.codigo}
              </Badge>
              <Badge tone={n.activo ? "ok" : "bad"}>{n.activo ? "Activo" : "Inactivo"}</Badge>
            </div>
            {edit ? (
              <div className="mt-3 space-y-2">
                <label className="block text-xs font-bold text-muted">
                  Nombre
                  <input
                    className="mt-1 w-full rounded-xl border border-line bg-white px-3 py-2 text-sm font-semibold text-ink"
                    value={n.nombre}
                    onChange={(e) => patchNivel(n.codigo, { nombre: e.target.value })}
                  />
                </label>
                <label className="block text-xs font-bold text-muted">
                  Descripción
                  <textarea
                    className="mt-1 w-full rounded-xl border border-line bg-white px-3 py-2 text-sm font-normal text-ink"
                    rows={3}
                    value={n.descripcion}
                    onChange={(e) => patchNivel(n.codigo, { descripcion: e.target.value })}
                  />
                </label>
                <label className="block text-xs font-bold text-muted">
                  Alcance
                  <select
                    className="mt-1 w-full rounded-xl border border-line bg-white px-3 py-2 text-sm font-semibold text-ink"
                    value={n.alcance}
                    onChange={(e) =>
                      patchNivel(n.codigo, {
                        alcance: e.target.value === "todas" ? "todas" : "empresa",
                      })
                    }
                  >
                    <option value="empresa">Solo su empresa</option>
                    <option value="todas">Todas las empresas</option>
                  </select>
                </label>
                <label className="flex items-center gap-2 text-sm font-semibold">
                  <input
                    type="checkbox"
                    checked={n.activo}
                    onChange={(e) => patchNivel(n.codigo, { activo: e.target.checked })}
                  />
                  Nivel activo
                </label>
                <Button
                  size="sm"
                  variant="primary"
                  disabled={busy === n.codigo || !n.nombre.trim()}
                  onClick={() => void saveNivel(n)}
                >
                  Guardar {n.codigo}
                </Button>
              </div>
            ) : (
              <>
                <div className="mt-3 font-display text-xl font-bold">{n.nombre}</div>
                <p className="mt-1 text-sm text-muted">{n.descripcion}</p>
                <div className="mt-3 text-xs font-bold text-brand-800">
                  {n.alcance === "empresa" ? "Solo su empresa" : "Todas las empresas"}
                </div>
              </>
            )}
          </Card>
        ))}
      </div>

      <div>
        <h2 className="font-display text-xl font-bold">Cuándo se pide cada nivel</h2>
        <p className="mt-1 text-sm text-muted">
          Dentro de presupuesto la solicitud se aprueba sola. Fuera de presupuesto, el
          monto decide cuántos de los tres niveles intervienen.
        </p>
        <div className="mt-3 space-y-3">
          {reglas.map((regla) => (
            <Card key={regla.id} className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <div className="font-bold">
                  {regla.regla} · {regla.dentro === "SI" ? "Dentro de presupuesto" : "Fuera de presupuesto"}
                </div>
                <div className="text-sm text-muted">{regla.desc}</div>
                {regla.dentro !== "SI" && (
                  <div className="mt-1 text-xs font-semibold text-brand-800">
                    {fQ(regla.desde)} a {fQ(regla.hasta)}
                  </div>
                )}
              </div>
              {edit ? (
                <div className="flex items-center gap-2">
                  <select
                    className="rounded-xl border border-line bg-white px-3 py-2 text-sm font-semibold"
                    value={regla.niveles}
                    onChange={(e) =>
                      setReglas((rows) =>
                        rows.map((x) =>
                          x.id === regla.id ? { ...x, niveles: e.target.value } : x,
                        ),
                      )
                    }
                  >
                    {(cadenas.includes(regla.niveles) ? cadenas : [regla.niveles, ...cadenas]).map(
                      (c) => (
                        <option key={c} value={c}>
                          {cadenaTxt(c)}
                        </option>
                      ),
                    )}
                  </select>
                  <Button
                    size="sm"
                    variant="primary"
                    disabled={busy === `r${regla.id}`}
                    onClick={() => void saveRegla(regla)}
                  >
                    Guardar
                  </Button>
                </div>
              ) : (
                <Badge>{cadenaTxt(regla.niveles)}</Badge>
              )}
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
}
