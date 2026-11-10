"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useAuth } from "@/components/auth-provider";
import { api } from "@/lib/api";
import { cn } from "@/lib/utils";
import { ClipboardList, History, PieChart, UserRound } from "lucide-react";
import { APROBADORES } from "@/lib/roles";

export default function MobileLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, loading, logout } = useAuth();
  const router = useRouter();
  const pathname = usePathname();
  const [badge, setBadge] = useState(0);

  useEffect(() => {
    if (loading) return;
    if (!user) {
      router.replace("/login");
      return;
    }
    if (![...APROBADORES, "Admin"].includes(user.rol)) {
      router.replace("/");
    }
  }, [user, loading, router]);

  useEffect(() => {
    void api
      .pendientes()
      .then((r) => setBadge(r.items.length))
      .catch(() => undefined);
  }, [pathname]);

  if (loading || !user) return null;

  const tabs = [
    { href: "/m", label: "Pendientes", icon: ClipboardList, exact: true },
    { href: "/m/presupuesto", label: "Presupuesto", icon: PieChart },
    { href: "/m/historial", label: "Historial", icon: History },
    { href: "/m/cuenta", label: "Cuenta", icon: UserRound },
  ];

  return (
    <div className="mx-auto flex min-h-screen max-w-[560px] flex-col bg-surface">
      <header className="sticky top-0 z-20 rounded-b-[26px] border-b-[3px] border-lima bg-brand-900 px-4 pb-4 pt-[calc(env(safe-area-inset-top)+12px)] text-white">
        <div className="flex items-center gap-3">
          <div>
            <div className="font-display text-xl font-extrabold">Pide Justo</div>
            <div className="text-[10.5px] text-crema/70">Aprobadores · móvil</div>
          </div>
          <div className="ml-auto flex items-center gap-2 rounded-full bg-white/10 py-1 pr-3 pl-1 text-xs font-semibold">
            <span className="grid h-7 w-7 place-items-center rounded-full bg-lima font-display font-extrabold text-brand-900">
              {user.nombre[0]}
            </span>
            {user.nombre.split(" ")[0]}
          </div>
        </div>
        <div className="mt-3 font-display text-[22px] font-bold">
          Hola, <span className="text-lima">{user.nombre.split(" ")[0]}</span>
        </div>
        <div className="text-xs text-crema/70">
          {user.rol} · {user.emp}
        </div>
      </header>
      <div className="flex-1 px-3.5 pb-28 pt-3.5">{children}</div>
      <nav className="fixed inset-x-0 bottom-0 z-25 flex justify-center">
        <div className="flex w-full max-w-[560px] gap-1 border-t border-line bg-card px-2 pb-[calc(env(safe-area-inset-bottom)+8px)] pt-2 shadow-[0_-8px_24px_rgba(16,49,43,.1)]">
          {tabs.map((t) => {
            const on = t.exact ? pathname === t.href : pathname.startsWith(t.href);
            const Icon = t.icon;
            return (
              <Link
                key={t.href}
                href={t.href}
                className={cn(
                  "relative flex flex-1 flex-col items-center gap-1 rounded-2xl px-1 py-2 text-[10.5px] font-bold",
                  on ? "bg-lima text-brand-900" : "text-muted",
                )}
              >
                <Icon className="h-5 w-5" />
                {t.label}
                {t.href === "/m" && badge > 0 && (
                  <span className="absolute top-1 right-3 min-w-[17px] rounded-full bg-danger px-1.5 text-[10px] text-white">
                    {badge}
                  </span>
                )}
              </Link>
            );
          })}
        </div>
      </nav>
      {/* expose logout for cuenta page via window noop — cuenta uses useAuth */}
      <span className="hidden">{String(!!logout)}</span>
    </div>
  );
}
