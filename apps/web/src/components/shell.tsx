"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useEffect } from "react";
import { useAuth } from "./auth-provider";
import { Button } from "./ui/button";
import { Badge } from "./ui/card";
import { APROBADORES, roleDescription, roleKind, roleLabel } from "@/lib/roles";
import { cn } from "@/lib/utils";
import {
  Building2,
  CircleCheck,
  FileText,
  House,
  Layers,
  List,
  LogOut,
  PieChart,
  ShoppingCart,
  Smartphone,
  TrendingUp,
  Users,
  Warehouse,
  type LucideIcon,
} from "lucide-react";

const NAV: { href: string; label: string; icon: LucideIcon; roles: string[] }[] = [
  {
    href: "/",
    label: "Inicio",
    icon: House,
    roles: ["Solicitante", ...APROBADORES, "Bodega", "Compras", "Admin"],
  },
  { href: "/solicitar", label: "Solicitar", icon: ShoppingCart, roles: ["Solicitante", "Admin"] },
  {
    href: "/aprobar",
    label: "Aprobar",
    icon: CircleCheck,
    roles: [...APROBADORES, "Admin"],
  },
  {
    href: "/aprobacion/niveles",
    label: "Niveles",
    icon: Layers,
    roles: [...APROBADORES, "Admin"],
  },
  {
    href: "/m",
    label: "Móvil",
    icon: Smartphone,
    roles: [...APROBADORES, "Admin"],
  },
  { href: "/bodega", label: "Bodega → SAP", icon: Warehouse, roles: ["Bodega", "Admin"] },
  {
    href: "/seguimiento",
    label: "Seguimiento",
    icon: List,
    roles: ["Solicitante", ...APROBADORES, "Bodega", "Compras", "Admin"],
  },
  {
    href: "/metricas",
    label: "Métricas",
    icon: TrendingUp,
    roles: ["Aprobador N2", "Aprobador N3", "Admin", "Bodega"],
  },
  {
    href: "/presupuesto",
    label: "Presupuesto",
    icon: PieChart,
    roles: [...APROBADORES, "Admin"],
  },
  { href: "/admin/usuarios", label: "Usuarios", icon: Users, roles: ["Admin"] },
  { href: "/admin/empresas", label: "Empresas", icon: Building2, roles: ["Admin"] },
  { href: "/admin/bodegas", label: "Bodegas", icon: Warehouse, roles: ["Admin"] },
  { href: "/admin/documentos", label: "Documentos", icon: FileText, roles: ["Admin"] },
];

export function Shell({ children }: { children: React.ReactNode }) {
  const { user, loading, logout } = useAuth();
  const pathname = usePathname();
  const router = useRouter();

  useEffect(() => {
    if (loading) return;
    if (!user && pathname !== "/login") {
      router.replace("/login");
    }
  }, [loading, user, pathname, router]);

  if (loading) {
    return (
      <div className="grid min-h-screen place-items-center text-muted">
        Cargando…
      </div>
    );
  }

  if (!user && pathname !== "/login") {
    return (
      <div className="grid min-h-screen place-items-center text-muted">
        Redirigiendo al login…
      </div>
    );
  }

  if (pathname === "/login" || pathname.startsWith("/m")) {
    return <>{children}</>;
  }

  const links = NAV.filter((n) => n.roles.includes(user!.rol));

  return (
    <div className="min-h-screen">
      <header className="border-b-4 border-lima bg-brand-900 text-white">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-4 py-4">
          <div>
            <div className="font-display text-xl font-extrabold tracking-tight">
              Pide Justo
            </div>
            <div className="text-xs text-crema/80">
              Grupo M.E.M.E. SAP
            </div>
          </div>
          <div className="ml-auto flex items-center gap-3 rounded-full bg-white/10 px-3 py-1.5 text-sm">
            <span className="grid h-8 w-8 place-items-center rounded-full bg-lima font-display font-extrabold text-brand-900">
              {user!.nombre[0]}
            </span>
            <span>
              <div className="font-semibold leading-tight">{user!.nombre}</div>
              <div className="text-[11px] text-crema/70">
                {roleLabel(user!.rol)} · {user!.emp}
              </div>
            </span>
            <Button
              size="sm"
              variant="ghost"
              className="border-white/20 text-white"
              onClick={() => void logout().then(() => router.push("/login"))}
            >
              <LogOut className="h-3.5 w-3.5" />
              Salir
            </Button>
          </div>
        </div>
        <div className="mx-auto flex max-w-6xl flex-wrap items-center gap-2 px-4 pb-2">
          <Badge
            tone={
              roleKind(user!.rol) === "aprobador"
                ? "dark"
                : roleKind(user!.rol) === "solicitante"
                  ? "lima"
                  : "default"
            }
            className="bg-lima text-brand-900"
          >
            {roleLabel(user!.rol)}
          </Badge>
          <span className="text-xs text-crema/75">
            {roleDescription(user!.rol)}
          </span>
        </div>
        <nav className="mx-auto flex max-w-6xl gap-2 overflow-x-auto px-4 pb-3">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className={cn(
                "inline-flex items-center gap-1.5 rounded-full px-3.5 py-2 text-sm font-bold whitespace-nowrap",
                (l.href === "/"
                  ? pathname === "/"
                  : pathname.startsWith(l.href))
                  ? "bg-lima text-brand-900"
                  : "text-crema/90 hover:bg-white/10",
              )}
            >
              <l.icon className="h-4 w-4" strokeWidth={2.25} />
              {l.label}
            </Link>
          ))}
        </nav>
      </header>
      <main className="mx-auto max-w-6xl px-4 py-6">{children}</main>
    </div>
  );
}
