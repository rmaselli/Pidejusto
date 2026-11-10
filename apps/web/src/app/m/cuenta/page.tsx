"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useAuth } from "@/components/auth-provider";
import { api } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import { roleDescription, roleLabel } from "@/lib/roles";

export default function MobileCuenta() {
  const { user, logout } = useAuth();
  const router = useRouter();
  const [sap, setSap] = useState<{ provider: string; label: string; detail: string } | null>(
    null,
  );

  useEffect(() => {
    void api.sapStatus().then(setSap).catch(() => undefined);
  }, []);

  return (
    <div className="space-y-3">
      <Card>
        <h2 className="font-display text-xl font-bold">{user?.nombre}</h2>
        <div className="mt-2">
          <Badge tone="lima">{user ? roleLabel(user.rol) : ""}</Badge>
        </div>
        <p className="mt-2 text-sm text-brand-800">
          {user ? roleDescription(user.rol) : ""}
        </p>
        <p className="mt-2 text-sm text-muted">
          {user?.emp} · {user?.puesto}
        </p>
        <p className="text-sm text-muted">{user?.email}</p>
      </Card>
      {sap && (
        <Card>
          <div className="text-xs font-bold uppercase text-muted">Fuente SAP</div>
          <div className="font-semibold">{sap.provider}</div>
          <div className="text-sm text-muted">{sap.label}</div>
          <div className="text-sm">{sap.detail}</div>
        </Card>
      )}
      <Button
        variant="dark"
        className="w-full"
        onClick={() => void logout().then(() => router.push("/login"))}
      >
        Cerrar sesión
      </Button>
      <Button variant="ghost" className="w-full" onClick={() => router.push("/aprobar")}>
        Abrir vista escritorio
      </Button>
    </div>
  );
}
