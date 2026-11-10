"use client";

import { useEffect, useState } from "react";
import { api, type Empresa } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";

export default function EmpresasPage() {
  const [rows, setRows] = useState<Empresa[]>([]);
  const [msg, setMsg] = useState("");
  const [nuevo, setNuevo] = useState({ codigo: "", nombreAnexo: "", companyDb: "" });

  async function load() {
    const r = await api.empresas();
    setRows(r.empresas);
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  async function save(e: Empresa) {
    try {
      await api.saveEmpresa(e.codigo, {
        nombreAnexo: e.nombreAnexo,
        companyDb: e.companyDb,
        activo: e.activo,
      });
      setMsg(`Empresa ${e.codigo} actualizada. El Service Layer usará ${e.companyDb || "la base por defecto"}.`);
      await load();
    } catch (err) {
      setMsg((err as Error).message);
    }
  }

  async function crear() {
    try {
      await api.createEmpresa(nuevo);
      setNuevo({ codigo: "", nombreAnexo: "", companyDb: "" });
      setMsg("Empresa registrada");
      await load();
    } catch (err) {
      setMsg((err as Error).message);
    }
  }

  return (
    <div className="space-y-4">
      <div>
        <h1 className="font-display text-2xl font-bold">Empresas</h1>
        <p className="text-sm text-muted">
          Cada empresa se relaciona con el nombre de base de datos SAP (CompanyDB) que se usa al iniciar sesión en el Service Layer.
        </p>
      </div>
      {msg && <p className="text-sm text-brand-800">{msg}</p>}
      <Card className="grid gap-3 md:grid-cols-4 md:items-end">
        <label className="text-xs font-bold uppercase text-muted">
          Código
          <input
            className="mt-1 w-full rounded-xl border border-line px-3 py-2"
            value={nuevo.codigo}
            onChange={(e) => setNuevo({ ...nuevo, codigo: e.target.value })}
          />
        </label>
        <label className="text-xs font-bold uppercase text-muted">
          Nombre
          <input
            className="mt-1 w-full rounded-xl border border-line px-3 py-2"
            value={nuevo.nombreAnexo}
            onChange={(e) => setNuevo({ ...nuevo, nombreAnexo: e.target.value })}
          />
        </label>
        <label className="text-xs font-bold uppercase text-muted">
          CompanyDB
          <input
            className="mt-1 w-full rounded-xl border border-line px-3 py-2"
            placeholder="SBO_EMPRESA"
            value={nuevo.companyDb}
            onChange={(e) => setNuevo({ ...nuevo, companyDb: e.target.value })}
          />
        </label>
        <Button variant="primary" onClick={() => void crear()}>
          Agregar
        </Button>
      </Card>
      <div className="space-y-3">
        {rows.map((e) => (
          <Card key={e.codigo} className="grid gap-3 md:grid-cols-[0.6fr_1.2fr_1fr_auto] md:items-end">
            <div>
              <div className="text-xs font-bold uppercase text-muted">Código</div>
              <div className="font-bold">{e.codigo}</div>
            </div>
            <label className="text-xs font-bold uppercase text-muted">
              Nombre
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={e.nombreAnexo}
                onChange={(ev) =>
                  setRows((list) =>
                    list.map((x) =>
                      x.codigo === e.codigo ? { ...x, nombreAnexo: ev.target.value } : x,
                    ),
                  )
                }
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Base de datos SAP
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2 font-mono"
                value={e.companyDb}
                onChange={(ev) =>
                  setRows((list) =>
                    list.map((x) =>
                      x.codigo === e.codigo ? { ...x, companyDb: ev.target.value } : x,
                    ),
                  )
                }
              />
            </label>
            <Button variant="primary" onClick={() => void save(e)}>
              Guardar
            </Button>
          </Card>
        ))}
      </div>
    </div>
  );
}
