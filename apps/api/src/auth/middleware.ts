import type { NextFunction, Request, Response } from "express";
import type { Role } from "@pidejusto/shared";

/** Rol vacío: usuario auto-registrado desde MS365, pendiente de que un Admin le asigne rol. */
export const SIN_ROL = "";

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.session?.user) {
    return res.status(401).json({ error: "No autenticado" });
  }
  if (!req.session.user.rol) {
    return res
      .status(403)
      .json({ error: "Usuario pendiente de asignación de rol", code: "SIN_ROL" });
  }
  req.user = req.session.user;
  next();
}

export function requireRole(...roles: Role[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.session?.user) {
      return res.status(401).json({ error: "No autenticado" });
    }
    const rol = req.session.user.rol as Role;
    if (!roles.includes(rol) && rol !== "Admin") {
      return res.status(403).json({ error: "Sin permiso para esta acción" });
    }
    req.user = req.session.user;
    next();
  };
}
