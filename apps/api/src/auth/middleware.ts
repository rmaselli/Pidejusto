import type { NextFunction, Request, Response } from "express";
import type { Role } from "@pidejusto/shared";

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.session?.user) {
    return res.status(401).json({ error: "No autenticado" });
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
