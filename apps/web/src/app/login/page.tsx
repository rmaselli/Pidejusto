"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { ClipboardList, ShieldCheck, Warehouse, UserCog } from "lucide-react";
import { api, type User } from "@/lib/api";
import { useAuth } from "@/components/auth-provider";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import {
  homeForRole,
  roleDescription,
  roleKind,
  roleLabel,
} from "@/lib/roles";
import { cn } from "@/lib/utils";

type Gate = "solicitante" | "aprobador" | "operaciones";

const GATES: {
  id: Gate;
  title: string;
  subtitle: string;
  icon: typeof ClipboardList;
  match: (rol: string) => boolean;
}[] = [
  {
    id: "solicitante",
    title: "Solicitantes",
    subtitle: "Crear requerimientos de materiales",
    icon: ClipboardList,
    match: (rol) => roleKind(rol) === "solicitante",
  },
  {
    id: "aprobador",
    title: "Aprobadores",
    subtitle: "Autorizar o rechazar solicitudes",
    icon: ShieldCheck,
    match: (rol) => roleKind(rol) === "aprobador",
  },
  {
    id: "operaciones",
    title: "Operaciones",
    subtitle: "Bodega, compras y administración",
    icon: Warehouse,
    match: (rol) => ["bodega", "compras", "admin"].includes(roleKind(rol)),
  },
];

export default function LoginPage() {
  const { user, authMode, loading: authLoading, refresh } = useAuth();
  const router = useRouter();
  const [users, setUsers] = useState<User[]>([]);
  const [gate, setGate] = useState<Gate>("solicitante");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const [picked, setPicked] = useState<User | null>(null);

  useEffect(() => {
    if (!authLoading && user) router.replace(homeForRole(user.rol));
  }, [user, authLoading, router]);

  useEffect(() => {
    if (authLoading) return;
    if (authMode !== "demo") return;
    api
      .demoUsers()
      .then((r) => setUsers(r.users))
      .catch((e) => setError(e.message));
  }, [authMode, authLoading]);

  const visible = useMemo(
    () => users.filter((u) => GATES.find((g) => g.id === gate)?.match(u.rol)),
    [users, gate],
  );

  async function loginDemo(u: User) {
    setLoading(true);
    setError("");
    setPicked(u);
    try {
      await api.demoLogin(u.id);
      await refresh();
      router.replace(homeForRole(u.rol));
    } catch (e) {
      setError((e as Error).message);
      setPicked(null);
    } finally {
      setLoading(false);
    }
  }

  if (authLoading) {
    return (
      <div className="grid min-h-screen place-items-center text-muted">
        Cargando sesión…
      </div>
    );
  }

  return (
    <div className="min-h-screen px-4 py-10">
      <div className="mx-auto max-w-3xl">
        <div className="mb-8 text-center">
          <div className="inline-block rounded-full bg-lima px-3 py-1 font-display text-sm font-bold text-brand-900">
            Grupo M.E.M.E.
          </div>
          <h1 className="mt-4 font-display text-4xl font-extrabold text-brand-900">
            Pide Justo
          </h1>
          <h2 className="mt-4 font-display text-2xl font-extrabold text-brand-900">Cada proceso cuenta - Solicitud de materiales</h2>
          <p className="mx-auto mt-2 max-w-xl text-muted">
            Inicia sesión para continuar. El sistema identifica si eres{" "}
            <b>solicitante</b> (creas requerimientos) o <b>aprobador</b>{" "}
            (autorizas), y abre solo las pantallas de tu rol.
          </p>
        </div>

        {authMode === "azure" ? (
          <Card className="mx-auto max-w-md text-center">
            <ShieldCheck className="mx-auto mb-3 h-10 w-10 text-brand-700" />
            <h2 className="font-display text-xl font-bold">Acceso corporativo</h2>
            <p className="mt-2 text-sm text-muted">
              Tu cuenta Microsoft 365 se vincula al rol asignado en Pide Justo
              (Solicitante, Aprobador N1, N2 o N3, Bodega o Admin).
            </p>
            <Button
              variant="primary"
              size="lg"
              className="mt-6 w-full"
              onClick={() => {
                window.location.href = `${api.url}/auth/login`;
              }}
            >
              Continuar con Microsoft 365
            </Button>
          </Card>
        ) : (
          <div className="space-y-5">
            <div className="grid gap-3 sm:grid-cols-3">
              {GATES.map((g) => {
                const Icon = g.icon;
                const count = users.filter((u) => g.match(u.rol)).length;
                const on = gate === g.id;
                return (
                  <button
                    key={g.id}
                    type="button"
                    onClick={() => setGate(g.id)}
                    className={cn(
                      "rounded-[20px] border p-4 text-left transition",
                      on
                        ? "border-lima bg-lima/25 shadow-[0_8px_24px_rgba(16,49,43,.08)]"
                        : "border-line bg-card hover:bg-soft",
                    )}
                  >
                    <Icon
                      className={cn(
                        "mb-2 h-6 w-6",
                        on ? "text-brand-800" : "text-muted",
                      )}
                    />
                    <div className="font-display text-lg font-bold">{g.title}</div>
                    <div className="mt-1 text-xs text-muted">{g.subtitle}</div>
                    <div className="mt-3 text-[11px] font-bold uppercase tracking-wide text-brand-700">
                      {count} usuario{count === 1 ? "" : "s"}
                    </div>
                  </button>
                );
              })}
            </div>

            <Card>
              <div className="mb-4 flex flex-wrap items-center justify-between gap-2">
                <div>
                  <h2 className="font-display text-xl font-bold">
                    {GATES.find((g) => g.id === gate)?.title}
                  </h2>
                  <p className="text-sm text-muted">
                    Elige tu usuario. Tras el login verás solo las acciones de tu
                    rol.
                  </p>
                </div>
                <Badge tone="lima">Modo demo</Badge>
              </div>

              {error && (
                <p className="mb-3 rounded-xl bg-[#F8E6E1] px-3 py-2 text-sm text-danger">
                  {error}
                </p>
              )}

              <div className="space-y-2">
                {visible.map((u) => {
                  const kind = roleKind(u.rol);
                  return (
                    <button
                      key={u.id}
                      type="button"
                      disabled={loading}
                      onClick={() => void loginDemo(u)}
                      className={cn(
                        "flex w-full items-center gap-3 rounded-2xl border border-line bg-soft/50 px-3 py-3 text-left transition hover:border-lima hover:bg-lima/20",
                        picked?.id === u.id && "border-lima bg-lima/25",
                      )}
                    >
                      <span className="grid h-11 w-11 place-items-center rounded-full bg-brand-900 font-display text-lg font-extrabold text-lima">
                        {u.nombre[0]}
                      </span>
                      <span className="min-w-0 flex-1">
                        <span className="flex flex-wrap items-center gap-2">
                          <span className="font-bold">{u.nombre}</span>
                          <Badge
                            tone={
                              kind === "aprobador"
                                ? "dark"
                                : kind === "solicitante"
                                  ? "lima"
                                  : "default"
                            }
                          >
                            {roleLabel(u.rol)}
                          </Badge>
                        </span>
                        <span className="mt-0.5 block text-xs text-muted">
                          {u.emp} · {u.puesto}
                        </span>
                        <span className="mt-1 block text-xs text-brand-800">
                          {roleDescription(u.rol)}
                        </span>
                      </span>
                      <span className="hidden text-xs font-bold text-brand-700 sm:inline">
                        Entrar →
                      </span>
                    </button>
                  );
                })}
                {!visible.length && !error && (
                  <p className="py-8 text-center text-sm text-muted">
                    No hay usuarios en esta categoría.
                  </p>
                )}
              </div>
            </Card>

            <p className="flex items-center justify-center gap-2 text-center text-xs text-muted">
              <UserCog className="h-3.5 w-3.5" />
              En producción el acceso es con Microsoft 365; el rol viene de la
              base de datos.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
