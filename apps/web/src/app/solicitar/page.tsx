"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/components/auth-provider";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import { api, type Articulo, type Bodega, type PreviewLine, type TipoDocumento } from "@/lib/api";
import { fQ } from "@/lib/utils";

type CartLine = PreviewLine["line"] & { justificacion?: string };

export default function SolicitarPage() {
  const { user } = useAuth();
  const [q, setQ] = useState("");
  const [items, setItems] = useState<Articulo[]>([]);
  const [selected, setSelected] = useState<Articulo | null>(null);
  const [qty, setQty] = useState(1);
  const [just, setJust] = useState("");
  const [preview, setPreview] = useState<PreviewLine | null>(null);
  const [cart, setCart] = useState<CartLine[]>([]);
  const [requiredDate, setRequiredDate] = useState(() => {
    const d = new Date();
    d.setDate(d.getDate() + 12);
    return d.toISOString().slice(0, 10);
  });
  const [comentario, setComentario] = useState("");
  const [empresaSel, setEmpresaSel] = useState("");
  const [empresas, setEmpresas] = useState<{ codigo: string; nombreAnexo: string }[]>([]);
  const [bodegas, setBodegas] = useState<Bodega[]>([]);
  const [tipos, setTipos] = useState<TipoDocumento[]>([]);
  const [bodega, setBodega] = useState("");
  const [tipo, setTipo] = useState("SC");
  const [msg, setMsg] = useState("");
  const [busy, setBusy] = useState(false);

  const empresa = user?.emp === "TODAS" ? empresaSel : user?.emp || "";

  useEffect(() => {
    if (!user) return;
    void api.empresas().then((r) => {
      setEmpresas(r.empresas);
      setEmpresaSel((cur) => cur || r.empresas[0]?.codigo || "");
    });
    void api.tiposDocumento().then((r) => {
      setTipos(r.tipos.filter((t) => t.activo));
      setTipo((cur) => cur || r.tipos[0]?.codigo || "SC");
    });
  }, [user]);

  useEffect(() => {
    if (!empresa) return;
    void api.bodegas(empresa).then((r) => {
      const activas = r.bodegas.filter((b) => b.activo);
      setBodegas(activas);
      setBodega((cur) =>
        activas.some((b) => b.codigo === cur) ? cur : activas[0]?.codigo || "",
      );
    });
  }, [empresa]);

  useEffect(() => {
    if (!user || !empresa) return;
    void api.articulos(empresa, q).then((r) => setItems(r.items));
  }, [user, q, empresa]);

  useEffect(() => {
    if (!selected || !user || !empresa) return;
    void api
      .previewLine({
        empresa,
        itemCode: selected.itemCode,
        qty,
        justificacion: just,
      })
      .then(setPreview)
      .catch((e) => setMsg(e.message));
  }, [selected, qty, just, user, empresa]);

  async function searchClaude() {
    if (!q.trim()) return;
    setBusy(true);
    try {
      const r = await api.aiSearch(q);
      setMsg(`Búsqueda ${r.source}: ${r.items.length} resultado(s)`);
      if (r.items[0]) {
        const found = items.find((i) => i.itemCode === r.items[0].itemCode);
        if (found) setSelected(found);
        else {
          const more = await api.articulos(empresa, r.items[0].itemCode);
          if (more.items[0]) setSelected(more.items[0]);
        }
      }
    } catch (e) {
      setMsg((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  function addToCart() {
    if (!preview) return;
    if (preview.alerta.exige && !just.trim() && qty !== preview.alerta.sug) {
      setMsg(preview.alerta.msg);
      return;
    }
    if (!preview.line.ct.ok) {
      setMsg("Imputación contable inválida — revisa cuenta/centro");
      return;
    }
    setCart((c) => [
      ...c,
      { ...preview.line, qty, justificacion: just, just },
    ]);
    setSelected(null);
    setJust("");
    setMsg("Línea agregada al carrito");
  }

  async function enviar() {
    if (!cart.length) return;
    setBusy(true);
    try {
      const created = await api.createSolicitud({
        requiredDate,
        comentario,
        empresa,
        bodegaCodigo: bodega,
        tipoDocumento: tipo,
        lines: cart.map((l) => ({
          itemCode: l.code,
          qty: l.qty,
          justificacion: l.justificacion || l.just,
          contable: l.ct,
        })),
      });
      setCart([]);
      setMsg(
        `Solicitud ${created.id} creada · ${created.tipoDocumento || tipo} ${created.docNum || ""} · bodega ${created.bodegaCodigo || bodega} · ${created.estado}`,
      );
    } catch (e) {
      setMsg((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  const total = cart.reduce((a, l) => a + l.total, 0);

  return (
    <div className="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
      <div className="space-y-4">
        <Card>
          <h1 className="font-display text-2xl font-bold">Solicitar materiales</h1>
          <p className="text-sm text-muted">
            La solicitud queda registrada con empresa, bodega, tipo y número de documento.
          </p>
          <div className="mt-4 grid gap-3 sm:grid-cols-3">
            {user?.emp === "TODAS" && (
              <label className="text-xs font-bold uppercase text-muted">
                Empresa
                <select
                  className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                  value={empresaSel}
                  onChange={(e) => setEmpresaSel(e.target.value)}
                >
                  {empresas.map((e) => (
                    <option key={e.codigo} value={e.codigo}>
                      {e.codigo} · {e.nombreAnexo}
                    </option>
                  ))}
                </select>
              </label>
            )}
            {user?.emp !== "TODAS" && (
              <div className="rounded-xl bg-soft px-3 py-2 text-sm">
                <div className="text-[10px] font-bold uppercase text-muted">Empresa</div>
                <div className="font-bold">{empresa}</div>
              </div>
            )}
            <label className="text-xs font-bold uppercase text-muted">
              Bodega
              <select
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={bodega}
                onChange={(e) => setBodega(e.target.value)}
              >
                {bodegas.map((b) => (
                  <option key={b.codigo} value={b.codigo}>
                    {b.codigo} · {b.nombre}
                  </option>
                ))}
              </select>
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Tipo de documento
              <select
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={tipo}
                onChange={(e) => setTipo(e.target.value)}
              >
                {tipos.map((t) => (
                  <option key={t.codigo} value={t.codigo}>
                    {t.codigo} · {t.nombre}
                  </option>
                ))}
              </select>
            </label>
          </div>
          <div className="mt-4 flex gap-2">
            <input
              className="flex-1 rounded-xl border border-line bg-card px-3 py-2"
              placeholder="Buscar código, nombre o familia…"
              value={q}
              onChange={(e) => setQ(e.target.value)}
            />
            <Button variant="claude" onClick={() => void searchClaude()} disabled={busy}>
              Buscar con Claude
            </Button>
          </div>
          <div className="mt-3 max-h-64 overflow-auto rounded-xl border border-line">
            {items.map((a) => (
              <button
                key={a.itemCode}
                className="flex w-full items-start justify-between border-b border-line px-3 py-2 text-left hover:bg-soft"
                onClick={() => {
                  setSelected(a);
                  setQty(1);
                }}
              >
                <span>
                  <div className="font-semibold">{a.itemName}</div>
                  <div className="text-xs text-muted">
                    {a.itemCode} · {a.categoria}
                  </div>
                </span>
                <span className="text-sm font-semibold">{fQ(a.precioProm)}</span>
              </button>
            ))}
          </div>
        </Card>

        {selected && preview && (
          <Card>
            <div className="flex items-start justify-between gap-3">
              <div>
                <h2 className="font-display text-lg font-bold">{selected.itemName}</h2>
                <div className="text-sm text-muted">{selected.itemCode}</div>
              </div>
              <Badge
                tone={
                  preview.alerta.tipo === "Sobre máximo" ||
                  preview.alerta.tipo === "Contra pedido"
                    ? "bad"
                    : preview.alerta.tipo === "Cantidad corta"
                      ? "warn"
                      : "ok"
                }
              >
                {preview.alerta.tipo}
              </Badge>
            </div>
            <div className="mt-3 grid grid-cols-3 gap-2 text-sm">
              <div className="rounded-xl bg-soft p-3">
                <div className="text-[10px] font-bold uppercase text-muted">Disponible</div>
                <div className="font-display text-xl font-bold">
                  {Number(preview.line.disp).toFixed(0)}
                </div>
              </div>
              <div className="rounded-xl bg-soft p-3">
                <div className="text-[10px] font-bold uppercase text-muted">Mín / Máx</div>
                <div className="font-display text-xl font-bold">
                  {preview.mm.min} / {preview.mm.max}
                </div>
              </div>
              <div className="rounded-xl bg-soft p-3">
                <div className="text-[10px] font-bold uppercase text-muted">Sugerida</div>
                <div className="font-display text-xl font-bold">{preview.alerta.sug}</div>
              </div>
            </div>
            <p className="mt-2 text-sm text-muted">{preview.alerta.msg}</p>
            <div className="mt-3 flex flex-wrap items-end gap-3">
              <label className="text-xs font-bold uppercase text-muted">
                Cantidad
                <input
                  type="number"
                  min={1}
                  className="mt-1 block w-28 rounded-xl border border-line px-3 py-2"
                  value={qty}
                  onChange={(e) => setQty(Number(e.target.value))}
                />
              </label>
              <Button
                size="sm"
                variant="primary"
                onClick={() => setQty(preview.alerta.sug || 1)}
              >
                Usar sugerida
              </Button>
            </div>
            {(preview.alerta.exige || just) && (
              <textarea
                className="mt-3 w-full rounded-xl border border-line px-3 py-2"
                placeholder="Justificación (obligatoria si sobre máximo)"
                value={just}
                onChange={(e) => setJust(e.target.value)}
              />
            )}
            <div className="mt-3 text-sm">
              Cuenta {preview.line.ct.cta} ·{" "}
              <Badge tone={preview.line.ct.ok ? "ok" : "bad"}>
                {preview.line.ct.validacion}
              </Badge>
            </div>
            <div className="mt-4 flex gap-2">
              <Button variant="primary" onClick={addToCart}>
                Agregar · {fQ(preview.line.total)}
              </Button>
            </div>
          </Card>
        )}
      </div>

      <Card className="h-fit sticky top-4">
        <h2 className="font-display text-lg font-bold">Carrito</h2>
        {cart.length === 0 ? (
          <p className="mt-3 text-sm text-muted">Sin líneas todavía.</p>
        ) : (
          <ul className="mt-3 space-y-2">
            {cart.map((l, i) => (
              <li key={i} className="rounded-xl border border-line p-3 text-sm">
                <div className="font-semibold">{l.name}</div>
                <div className="text-muted">
                  {l.qty} × {fQ(l.price)} = {fQ(l.total)}
                </div>
                <Badge className="mt-1" tone={l.alerta === "En rango" ? "ok" : "warn"}>
                  {l.alerta}
                </Badge>
              </li>
            ))}
          </ul>
        )}
        <div className="mt-4 space-y-3">
          <label className="block text-xs font-bold uppercase text-muted">
            Fecha requerida
            <input
              type="date"
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={requiredDate}
              onChange={(e) => setRequiredDate(e.target.value)}
            />
          </label>
          <textarea
            className="w-full rounded-xl border border-line px-3 py-2"
            placeholder="Comentario"
            value={comentario}
            onChange={(e) => setComentario(e.target.value)}
          />
          <div className="flex items-center justify-between font-display text-xl font-bold">
            <span>Total</span>
            <span>{fQ(total)}</span>
          </div>
          <Button
            variant="dark"
            size="lg"
            className="w-full"
            disabled={!cart.length || busy || !bodega || !tipo || !empresa}
            onClick={() => void enviar()}
          >
            Enviar solicitud
          </Button>
          {msg && <p className="text-sm text-brand-800">{msg}</p>}
        </div>
      </Card>
    </div>
  );
}
