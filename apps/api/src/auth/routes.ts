import { Router } from "express";
import { eq } from "drizzle-orm";
import { users } from "@pidejusto/db";
import type { Role, UserInfo } from "@pidejusto/shared";
import { config } from "../config.js";
import type { Db } from "@pidejusto/db";
import { requireAuth } from "./middleware.js";
import crypto from "crypto";

function toUserInfo(u: typeof users.$inferSelect): UserInfo {
  return {
    id: u.id,
    email: u.email,
    nombre: u.nombre,
    rol: u.rol as Role,
    emp: u.empresa,
    puesto: u.puesto || "",
  };
}

export function authRoutes(db: Db) {
  const r = Router();

  r.get("/me", (req, res) => {
    if (!req.session?.user) return res.status(401).json({ user: null });
    return res.json({ user: req.session.user, authMode: config.authMode });
  });

  r.get("/users-demo", async (_req, res) => {
    if (config.authMode !== "demo") {
      return res.status(403).json({ error: "Solo disponible en AUTH_MODE=demo" });
    }
    const list = await db.select().from(users).where(eq(users.activo, true));
    res.json({
      users: list.map(toUserInfo),
    });
  });

  r.post("/demo-login", async (req, res) => {
    if (config.authMode !== "demo") {
      return res.status(403).json({ error: "Solo disponible en AUTH_MODE=demo" });
    }
    const userId = String(req.body?.userId || "");
    const [u] = await db.select().from(users).where(eq(users.id, userId)).limit(1);
    if (!u || !u.activo) return res.status(404).json({ error: "Usuario no encontrado" });
    req.session.user = toUserInfo(u);
    res.json({ user: req.session.user });
  });

  r.post("/logout", (req, res) => {
    req.session.destroy(() => {
      res.clearCookie("connect.sid");
      res.json({ ok: true });
    });
  });

  r.get("/login", (req, res) => {
    if (config.authMode === "demo") {
      return res.redirect(`${config.webUrl}/login`);
    }
    const { clientId, tenantId, redirectUri } = config.azure;
    if (!clientId || !tenantId) {
      return res.status(500).json({
        error: "Azure AD no configurado. Defina AZURE_AD_CLIENT_ID y AZURE_AD_TENANT_ID.",
      });
    }
    const state = crypto.randomBytes(16).toString("hex");
    req.session.oauthState = state;
    const params = new URLSearchParams({
      client_id: clientId,
      response_type: "code",
      redirect_uri: redirectUri,
      response_mode: "query",
      scope: "openid profile email User.Read",
      state,
    });
    const url = `https://login.microsoftonline.com/${tenantId}/oauth2/v2.0/authorize?${params}`;
    res.redirect(url);
  });

  r.get("/callback", async (req, res) => {
    if (config.authMode !== "azure") {
      return res.status(400).send("AUTH_MODE no es azure");
    }
    const { code, state, error, error_description } = req.query as Record<
      string,
      string
    >;
    if (error) {
      return res.status(400).send(`OAuth error: ${error} ${error_description || ""}`);
    }
    if (!code || state !== req.session.oauthState) {
      return res.status(400).send("Estado OAuth inválido");
    }
    const { clientId, clientSecret, tenantId, redirectUri } = config.azure;
    const tokenRes = await fetch(
      `https://login.microsoftonline.com/${tenantId}/oauth2/v2.0/token`,
      {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: clientId,
          client_secret: clientSecret,
          code,
          redirect_uri: redirectUri,
          grant_type: "authorization_code",
          scope: "openid profile email User.Read",
        }),
      },
    );
    if (!tokenRes.ok) {
      const t = await tokenRes.text();
      return res.status(502).send(`Token exchange failed: ${t}`);
    }
    const tokens = (await tokenRes.json()) as { access_token: string };
    const meRes = await fetch("https://graph.microsoft.com/v1.0/me", {
      headers: { Authorization: `Bearer ${tokens.access_token}` },
    });
    if (!meRes.ok) {
      return res.status(502).send("No se pudo leer el perfil de Microsoft Graph");
    }
    const me = (await meRes.json()) as {
      id: string;
      displayName: string;
      mail?: string;
      userPrincipalName?: string;
    };
    const email = (me.mail || me.userPrincipalName || "").toLowerCase();
    if (!email) return res.status(400).send("La cuenta MS365 no tiene email");

    let [u] = await db.select().from(users).where(eq(users.email, email)).limit(1);
    if (!u) {
      // Auto-provision as Solicitante; admin can elevate later
      const id = `MS-${me.id.slice(0, 8)}`;
      await db.insert(users).values({
        id,
        email,
        nombre: me.displayName || email,
        rol: "Solicitante",
        empresa: "SUPREMA",
        puesto: "Usuario MS365",
        azureOid: me.id,
        activo: true,
      });
      [u] = await db.select().from(users).where(eq(users.id, id)).limit(1);
    } else if (!u.azureOid) {
      await db.update(users).set({ azureOid: me.id }).where(eq(users.id, u.id));
    }

    if (!u || !u.activo) return res.status(403).send("Usuario inactivo");
    req.session.user = toUserInfo(u);
    delete req.session.oauthState;
    res.redirect(config.webUrl);
  });

  r.get("/status", requireAuth, (_req, res) => {
    res.json({
      authMode: config.authMode,
      azureConfigured: Boolean(config.azure.clientId && config.azure.tenantId),
    });
  });

  return r;
}
