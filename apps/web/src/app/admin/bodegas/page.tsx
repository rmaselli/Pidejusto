"use client";

import { useEffect, useState } from "react";
import { api, type Bodega, type Empresa } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";

export default function BodegasPage() {
  const [rows, setRows] = useState<Bodega[]>([]);
  const [empresas, setEmpresas] = useState<Empresa[]>([]);
  const [msg, setMsg] = useState("");
  const [nuevo, setNuevo] = useState({
    empresa: "",
    codigo: "",
    nombre: "",
    warehouseCode: "",
  });

  async function load() {
    const [b, e] = await Promise.all([api.bodegas(), api.empresas()]);
    setRows(b.bodegas);
    setEmpresas(e.empresas);
    setNuevo((n) => ({ ...n, empresa: n.empresa || e.empresas[0]?.codigo || "" }));
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  async function crear() {
    try {
      await api.createBodega(nuevo);
      setNuevo((n) => ({ ...n, codigo: "", nombre: "", warehouseCode: "" }));
      setMsg("Bodega registrada");
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function save(b: Bodega) {
    try {
      await api.saveBodega(b.id, {
        nombre: b.nombre,
        warehouseCode: b.warehouseCode,
        activo: b.activo,
      });
      setMsg(`Bodega ${b.codigo} actualizada`);
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  return (
    <div className="space-y-4">
      <div>
        <h1 className="font-display text-2xl font-bold">Bodegas</h1>
        <p className="text-sm text-muted">
          El código de almacén SAP se envía como WarehouseCode al registrar la transacción.
        </p>
      </div>
      {msg && <p className="text-sm text-brand-800">{msg}</p>}
      <Card className="grid gap-3 md:grid-cols-5 md:items-end">
        <label className="text-xs font-bold uppercase text-muted">
          Empresa
          <select
            className="mt-1 w-full rounded-xl border border-line px-3 py-2"
            value={nuevo.empresa}
            onChange={(e) => setNuevo({ ...nuevo, empresa: e.target.value })}
          >
            {empresas.map((e) => (
              <option key={e.codigo} value={e.codigo}>
                {e.codigo}
              </option>
            ))}
          </select>
        </label>
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
            value={nuevo.nombre}
            onChange={(e) => setNuevo({ ...nuevo, nombre: e.target.value })}
          />
        </label>
        <label className="text-xs font-bold uppercase text-muted">
          Almacén SAP
          <input
            className="mt-1 w-full rounded-xl border border-line px-3 py-2"
            value={nuevo.warehouseCode}
            onChange={(e) => setNuevo({ ...nuevo, warehouseCode: e.target.value })}
          />
        </label>
        <Button variant="primary" onClick={() => void crear()}>
          Agregar
        </Button>
      </Card>
      <div className="space-y-3">
        {rows.map((b) => (
          <Card key={b.id} className="grid gap-3 md:grid-cols-[0.7fr_1fr_0.8fr_auto] md:items-end">
            <div>
              <div className="font-bold">
                {b.empresa} · {b.codigo}
              </div>
              <div className="text-xs text-muted">{b.activo ? "Activa" : "Inactiva"}</div>
            </div>
            <label className="text-xs font-bold uppercase text-muted">
              Nombre
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={b.nombre}
                onChange={(e) =>
                  setRows((list) =>
                    list.map((x) => (x.id === b.id ? { ...x, nombre: e.target.value } : x)),
                  )
                }
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Almacén SAP
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2 font-mono"
                value={b.warehouseCode}
                onChange={(e) =>
                  setRows((list) =>
                    list.map((x) =>
                      x.id === b.id ? { ...x, warehouseCode: e.target.value } : x,
                    ),
                  )
                }
              />
            </label>
            <Button variant="primary" onClick={() => void save(b)}>
              Guardar
            </Button>
          </Card>
        ))}
      </div>
    </div>
  );
}
