"use client";

import { useEffect, useState } from "react";
import { api, type User } from "@/lib/api";
import { useAuth } from "@/components/auth-provider";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

const ROLES = [
  "Solicitante",
  "Aprobador N1",
  "Aprobador N2",
  "Aprobador N3",
  "Bodega",
  "Compras",
  "Admin",
];

type Row = User & { activo?: boolean };

const empty = {
  email: "",
  nombre: "",
  rol: "Solicitante",
  empresa: "",
  puesto: "",
};

export default function AdminUsuariosPage() {
  const { user: me } = useAuth();
  const [users, setUsers] = useState<Row[]>([]);
  const [empresas, setEmpresas] = useState<string[]>([]);
  const [msg, setMsg] = useState("");
  const [nuevo, setNuevo] = useState(empty);

  async function load() {
    const [r, e] = await Promise.all([api.adminUsers(), api.empresas()]);
    setUsers(r.users as Row[]);
    setEmpresas(e.empresas.map((x) => x.codigo));
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  function patchRow(id: string, partial: Partial<Row>) {
    setUsers((list) => list.map((x) => (x.id === id ? { ...x, ...partial } : x)));
  }

  async function save(u: Row) {
    try {
      await api.patchUser(u.id, {
        nombre: u.nombre,
        email: u.email,
        puesto: u.puesto,
        rol: u.rol,
        empresa: u.emp,
        activo: u.activo !== false,
      });
      setMsg(`Actualizado ${u.nombre}`);
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function crear() {
    try {
      await api.createUser(nuevo);
      setMsg(`Usuario ${nuevo.nombre} creado`);
      setNuevo({ ...empty, empresa: empresas[0] || "" });
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function eliminar(u: Row) {
    if (!window.confirm(`¿Eliminar a ${u.nombre}?`)) return;
    try {
      await api.deleteUser(u.id);
      setMsg(`Eliminado ${u.nombre}`);
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  return (
    <div className="space-y-4">
      <div>
        <h1 className="font-display text-2xl font-bold">Administrar usuarios</h1>
        <p className="text-sm text-muted">
          Alta, consulta, edición y baja. También está en Inicio y en el menú Usuarios.
        </p>
      </div>
      {msg && <p className="text-sm text-brand-800">{msg}</p>}
      <Card className="grid gap-3 md:grid-cols-2">
        <h2 className="font-bold md:col-span-2">Nuevo usuario</h2>
        <input
          className="rounded-xl border border-line px-3 py-2"
          placeholder="Nombre"
          value={nuevo.nombre}
          onChange={(e) => setNuevo({ ...nuevo, nombre: e.target.value })}
        />
        <input
          className="rounded-xl border border-line px-3 py-2"
          placeholder="Correo"
          value={nuevo.email}
          onChange={(e) => setNuevo({ ...nuevo, email: e.target.value })}
        />
        <select
          className="rounded-xl border border-line px-3 py-2"
          value={nuevo.rol}
          onChange={(e) => setNuevo({ ...nuevo, rol: e.target.value })}
        >
          {ROLES.map((r) => (
            <option key={r}>{r}</option>
          ))}
        </select>
        <select
          className="rounded-xl border border-line px-3 py-2"
          value={nuevo.empresa}
          onChange={(e) => setNuevo({ ...nuevo, empresa: e.target.value })}
        >
          <option value="">Empresa…</option>
          <option value="TODAS">TODAS</option>
          {empresas.map((c) => (
            <option key={c}>{c}</option>
          ))}
        </select>
        <input
          className="rounded-xl border border-line px-3 py-2 md:col-span-2"
          placeholder="Puesto"
          value={nuevo.puesto}
          onChange={(e) => setNuevo({ ...nuevo, puesto: e.target.value })}
        />
        <Button variant="primary" onClick={() => void crear()}>
          Crear usuario
        </Button>
      </Card>
      <div className="space-y-3">
        {users.map((u) => (
          <Card key={u.id} className="grid gap-3 md:grid-cols-2">
            <div className="md:col-span-2 text-xs font-bold uppercase text-muted">
              {u.id}
              {u.id === me?.id ? " · sesión actual" : ""}
            </div>
            <label className="text-xs font-bold uppercase text-muted">
              Nombre
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={u.nombre}
                onChange={(e) => patchRow(u.id, { nombre: e.target.value })}
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Correo
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={u.email || ""}
                onChange={(e) => patchRow(u.id, { email: e.target.value })}
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Puesto
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={u.puesto || ""}
                onChange={(e) => patchRow(u.id, { puesto: e.target.value })}
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Rol
              <select
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={u.rol}
                onChange={(e) => patchRow(u.id, { rol: e.target.value })}
              >
                {ROLES.map((r) => (
                  <option key={r} value={r}>
                    {r}
                  </option>
                ))}
              </select>
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Empresa
              <select
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={u.emp}
                onChange={(e) => patchRow(u.id, { emp: e.target.value })}
              >
                <option value="TODAS">TODAS</option>
                {empresas.map((c) => (
                  <option key={c}>{c}</option>
                ))}
                {u.emp && u.emp !== "TODAS" && !empresas.includes(u.emp) && (
                  <option value={u.emp}>{u.emp}</option>
                )}
              </select>
            </label>
            <label className="flex items-center gap-2 self-end text-sm font-bold">
              <input
                type="checkbox"
                checked={u.activo !== false}
                onChange={(e) => patchRow(u.id, { activo: e.target.checked })}
              />
              Activo
            </label>
            <div className="flex gap-2 md:col-span-2">
              <Button variant="primary" onClick={() => void save(u)}>
                Guardar
              </Button>
              <Button
                variant="danger"
                disabled={u.id === me?.id}
                onClick={() => void eliminar(u)}
              >
                Eliminar
              </Button>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
