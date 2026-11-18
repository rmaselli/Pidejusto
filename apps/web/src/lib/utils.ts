import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/** Fecha legible: dd/mm/yy hh24:mi:ss, en la hora local. */
export function fFecha(value: string | Date | null | undefined) {
  if (!value) return "";
  const d = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(d.getTime())) return String(value);
  const p = (n: number) => String(n).padStart(2, "0");
  return `${p(d.getDate())}/${p(d.getMonth() + 1)}/${p(d.getFullYear() % 100)} ${p(d.getHours())}:${p(d.getMinutes())}:${p(d.getSeconds())}`;
}

export function dimsLinea(ct?: Record<string, unknown> | null) {
  if (!ct) return "";
  const s = (k: string) => (typeof ct[k] === "string" ? (ct[k] as string) : "");
  const dep = s("depN") && s("subN") ? `${s("depN")} / ${s("subN")}` : s("depN") || s("subN");
  return [s("cta") ? `Cuenta ${s("cta")}` : "", s("proyN"), dep, s("ubiN"), s("linN"), s("prodN")]
    .filter(Boolean)
    .join(" · ");
}

export function mayus(value: string) {
  return value.toLocaleUpperCase("es");
}

export function fQ(n: number) {
  return (
    "Q " +
    Number(n || 0).toLocaleString("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })
  );
}
