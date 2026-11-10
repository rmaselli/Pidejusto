"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect } from "react";
import {
  Building2,
  ClipboardList,
  FileDigit,
  LineChart,
  ShieldCheck,
  Users,
  Warehouse,
} from "lucide-react";
import { useAuth } from "@/components/auth-provider";
import { Card } from "@/components/ui/card";
import { APROBADORES, roleDescription, roleLabel } from "@/lib/roles";

const ACTIONS: {
  href: string;
  title: string;
  text: string;
  roles: string[];
  icon: typeof Users;
}[] = [
  {
    href: "/admin/usuarios",
    title: "Administrar usuarios",
    text: "Alta, rol y empresa de quienes usan el portal",
    roles: ["Admin"],
    icon: Users,
  },
  {
    href: "/admin/empresas",
    title: "Empresas",
    text: "Nombre y base de datos SAP (CompanyDB) del Service Layer",
    roles: ["Admin"],
    icon: Building2,
  },
  {
    href: "/admin/bodegas",
    title: "Bodegas",
    text: "Almacenes por empresa que viajan en la solicitud",
    roles: ["Admin"],
    icon: Warehouse,
  },
  {
    href: "/admin/documentos",
    title: "Documentos",
    text: "Tipos de documento y la numeración que se asigna",
    roles: ["Admin"],
    icon: FileDigit,
  },
  {
    href: "/aprobacion/niveles",
    title: "Niveles de aprobación",
    text: "Los tres niveles del flujo. El administrador puede cambiarlos",
    roles: [...APROBADORES, "Admin"],
    icon: ShieldCheck,
  },
  {
    href: "/solicitar",
    title: "Solicitar",
    text: "Crear un requerimiento con empresa, bodega y documento",
    roles: ["Solicitante", "Admin"],
    icon: ClipboardList,
  },
  {
    href: "/aprobar",
    title: "Aprobar",
    text: "Autorizar o rechazar solicitudes pendientes",
    roles: [...APROBADORES, "Admin"],
    icon: ShieldCheck,
  },
  {
    href: "/m",
    title: "Aprobar en móvil",
    text: "La misma bandeja, pensada para el teléfono",
    roles: [...APROBADORES, "Admin"],
    icon: ShieldCheck,
  },
  {
    href: "/bodega",
    title: "Bodega → SAP",
    text: "Enviar aprobadas al Service Layer de su empresa",
    roles: ["Bodega", "Admin"],
    icon: Warehouse,
  },
  {
    href: "/seguimiento",
    title: "Seguimiento",
    text: "Estado, número de documento y bodega de cada solicitud",
    roles: ["Solicitante", ...APROBADORES, "Bodega", "Compras", "Admin"],
    icon: ClipboardList,
  },
  {
    href: "/presupuesto",
    title: "Presupuesto",
    text: "Ejecución y comprometido por categoría",
    roles: [...APROBADORES, "Admin"],
    icon: LineChart,
  },
  {
    href: "/metricas",
    title: "Métricas",
    text: "Volumen y tiempos del flujo de compras",
    roles: ["Aprobador N2", "Aprobador N3", "Admin", "Bodega"],
    icon: LineChart,
  },
];

export default function Home() {
  const { user, loading } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (loading) return;
    if (!user) router.replace("/login");
  }, [user, loading, router]);

  if (loading || !user) {
    return <div className="text-muted">Cargando inicio…</div>;
  }

  const actions = ACTIONS.filter((a) => a.roles.includes(user.rol));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-3xl font-extrabold text-brand-900">
          Inicio
        </h1>
        <p className="mt-1 text-muted">
          {roleLabel(user.rol)} · {user.emp}. {roleDescription(user.rol)}
        </p>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {actions.map((a) => {
          const Icon = a.icon;
          return (
            <Link key={a.href} href={a.href} className="block">
              <Card className="h-full transition hover:border-lima hover:bg-lima/10">
                <Icon className="mb-3 h-6 w-6 text-brand-800" />
                <div className="font-display text-lg font-bold">{a.title}</div>
                <p className="mt-1 text-sm text-muted">{a.text}</p>
              </Card>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
