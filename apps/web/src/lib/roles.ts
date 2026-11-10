export type RoleKind = "solicitante" | "aprobador" | "bodega" | "compras" | "admin";

export const APROBADORES = ["Aprobador N1", "Aprobador N2", "Aprobador N3"] as const;

export function roleKind(rol: string): RoleKind {
  if (rol === "Solicitante") return "solicitante";
  if (rol.startsWith("Aprobador ")) return "aprobador";
  if (rol === "Bodega") return "bodega";
  if (rol === "Compras") return "compras";
  if (rol === "Admin") return "admin";
  return "solicitante";
}

export function roleLabel(rol: string): string {
  switch (roleKind(rol)) {
    case "solicitante":
      return "Solicitante";
    case "aprobador":
      return rol;
    case "bodega":
      return "Bodega";
    case "compras":
      return "Compras";
    case "admin":
      return "Administrador";
    default:
      return rol;
  }
}

export function roleDescription(rol: string): string {
  switch (rol) {
    case "Solicitante":
      return "Puede crear y enviar requerimientos de materiales";
    case "Aprobador N1":
      return "Primera autorización, solicitudes de su empresa";
    case "Aprobador N2":
      return "Segunda autorización, solicitudes de todas las empresas";
    case "Aprobador N3":
      return "Tercera autorización, solicitudes de todas las empresas";
    case "Bodega":
      return "Consolida aprobadas y las envía a SAP";
    case "Compras":
      return "Da seguimiento a solicitudes de compra";
    case "Admin":
      return "Administra usuarios, niveles y configuración";
    default:
      return "";
  }
}

export function homeForRole(_rol: string): string {
  return "/";
}

export function isAprobador(rol: string) {
  return roleKind(rol) === "aprobador";
}

export function isSolicitante(rol: string) {
  return roleKind(rol) === "solicitante";
}
