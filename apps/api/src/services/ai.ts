import {
  localMRP,
  localResumen,
  localSearch,
  type BudgetEval,
  type LineaSolicitud,
  type RutaAprobacion,
} from "@pidejusto/shared";
import { config } from "../config.js";

async function claude(
  system: string,
  user: string,
  maxTokens = 800,
): Promise<string | null> {
  if (!config.anthropicApiKey) return null;
  try {
    const r = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": config.anthropicApiKey,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify({
        model: "claude-sonnet-4-20250514",
        max_tokens: maxTokens,
        system,
        messages: [{ role: "user", content: user }],
      }),
    });
    if (!r.ok) return null;
    const j = (await r.json()) as {
      content?: { type: string; text?: string }[];
    };
    return j.content?.find((c) => c.type === "text")?.text || null;
  } catch {
    return null;
  }
}

export async function aiSearch(
  items: { code: string; name: string; cat: string }[],
  text: string,
) {
  const catalog = items
    .slice(0, 400)
    .map((i) => `${i.code}|${i.name}|${i.cat}`)
    .join("\n");
  const system =
    'Eres asistente de compras MRO. Responde SOLO JSON: {"items":[{"itemCode","cantidad":null,"motivo"}]} máximo 5.';
  const raw = await claude(system, `Catálogo:\n${catalog}\n\nPedido: ${text}`);
  if (raw) {
    try {
      const m = raw.match(/\{[\s\S]*\}/);
      if (m) {
        const parsed = JSON.parse(m[0]) as {
          items: { itemCode: string; cantidad: number | null; motivo: string }[];
        };
        return { source: "claude" as const, items: parsed.items || [] };
      }
    } catch {
      /* fallback */
    }
  }
  return { source: "local" as const, items: localSearch(items, text) };
}

export async function aiMrp(ctx: {
  sug: number;
  min: number;
  max: number;
  base: number;
  avg: number;
  code: string;
  name: string;
}) {
  const system =
    'Sugiere cantidad de compra MRO. Responde SOLO JSON: {"cantidad":number,"explicacion":"máx 2 frases"}. No superes el máximo salvo tendencia clara.';
  const raw = await claude(
    system,
    JSON.stringify(ctx),
  );
  if (raw) {
    try {
      const m = raw.match(/\{[\s\S]*\}/);
      if (m) {
        const parsed = JSON.parse(m[0]) as {
          cantidad: number;
          explicacion: string;
        };
        return { source: "claude" as const, ...parsed };
      }
    } catch {
      /* fallback */
    }
  }
  return { source: "local" as const, ...localMRP(ctx) };
}

export async function aiResumen(req: {
  id: string;
  solicitante: string;
  emp: string;
  total: number;
  comentario?: string;
  bud: BudgetEval;
  lines: LineaSolicitud[];
  ruta: RutaAprobacion;
}) {
  const system =
    'Resume riesgos para un aprobador. Exactamente 4 viñetas que empiecen con "• " y termina con "Recomendación: Aprobar" | "Aprobar con ajuste" | "Rechazar".';
  const raw = await claude(
    system,
    `Solicitud ${req.id} de ${req.solicitante} (${req.emp}), total ${req.total}, ruta ${req.ruta.regla}.\nLíneas: ${JSON.stringify(req.lines.map((l) => ({ art: l.name, cat: l.cat, pide: l.qty, sugerida: l.sug, alerta: l.alerta, total: l.total, cuenta: l.ct.cta })))}\nPresupuesto: ${JSON.stringify(req.bud.cats)}\nComentario: ${req.comentario || "—"}`,
  );
  if (raw) return { source: "claude" as const, text: raw };
  return { source: "local" as const, text: localResumen(req) };
}
