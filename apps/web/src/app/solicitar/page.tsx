"use client";

import { useEffect, useRef, useState, type ReactNode } from "react";
import { MAX_LINEAS_SOLICITUD } from "@pidejusto/shared";
import { useAuth } from "@/components/auth-provider";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import {
  api,
  type Articulo,
  type Bodega,
  type CategoriaCuenta,
  type PrecioCompra,
  type PreviewLine,
  type SapOpcion,
  type TipoDocumento,
} from "@/lib/api";
import { dimsLinea, fFecha, fQ, mayus } from "@/lib/utils";

type Clase = "articulo" | "servicio";

type CartLine = PreviewLine["line"] & {
  justificacion?: string;
  clase: Clase;
};

type SvcForm = {
  qty: number;
  descripcion: string;
  price: number;
  cuenta: string;
  proyecto: string;
  d1: string;
  d2: string;
  d3: string;
  d4: string;
  d5: string;
  placa: string;
  obraProc: string;
  obraEsp: string;
};

const EMPTY_SVC: SvcForm = {
  qty: 1,
  descripcion: "",
  price: 0,
  cuenta: "",
  proyecto: "",
  d1: "",
  d2: "",
  d3: "",
  d4: "",
  d5: "",
  placa: "",
  obraProc: "",
  obraEsp: "",
};

const fieldCls =
  "mt-1 w-full rounded-xl border border-line bg-card px-3 py-2 text-sm font-medium text-ink";
const textCls = `${fieldCls} uppercase`;

function Field({
  label,
  children,
}: {
  label: string;
  children: ReactNode;
}) {
  return (
    <label className="block">
      <span className="text-xs font-bold uppercase text-muted">{label}</span>
      {children}
    </label>
  );
}

export default function SolicitarPage() {
  const { user } = useAuth();
  const [clase, setClase] = useState<Clase>("articulo");
  const [q, setQ] = useState("");
  const [items, setItems] = useState<Articulo[]>([]);
  const [selected, setSelected] = useState<Articulo | null>(null);
  const [qty, setQty] = useState(1);
  const [just, setJust] = useState("");
  const [preview, setPreview] = useState<PreviewLine | null>(null);
  const [historial, setHistorial] = useState<PrecioCompra[]>([]);
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
  const [sapMsg, setSapMsg] = useState("");
  const [busy, setBusy] = useState(false);
  const [buscando, setBuscando] = useState(false);
  const buscaId = useRef(0);
  const elegidos = useRef<Record<string, string>>({});
  const [svc, setSvc] = useState<SvcForm>(EMPTY_SVC);
  const [contable, setContable] = useState<{
    catcta: CategoriaCuenta[];
  } | null>(null);

  const empresa = user?.emp === "TODAS" ? empresaSel : user?.emp || "";
  const lleno = cart.length >= MAX_LINEAS_SOLICITUD;

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
    setCart([]);
    setSelected(null);
    setSvc(EMPTY_SVC);
    elegidos.current = {};
  }, [empresa]);

  useEffect(() => {
    if (clase !== "servicio" || !empresa) return;
    let cancel = false;
    void api
      .contable(empresa)
      .then((r) => {
        if (!cancel) setContable({ catcta: r.catcta });
      })
      .catch((e) => {
        if (!cancel) setMsg(e.message);
      });
    return () => {
      cancel = true;
    };
  }, [clase, empresa]);

  useEffect(() => {
    if (!selected || !user || !empresa || clase !== "articulo") return;
    void api
      .previewLine({
        empresa,
        itemCode: selected.itemCode,
        qty,
        justificacion: just,
      })
      .then(setPreview)
      .catch((e) => setMsg(e.message));
  }, [selected, qty, just, user, empresa, clase]);

  useEffect(() => {
    if (!selected || !empresa || clase !== "articulo") {
      setHistorial([]);
      return;
    }
    let cancel = false;
    void api
      .precios(empresa, selected.itemCode)
      .then((r) => {
        if (!cancel) setHistorial(r.items);
      })
      .catch(() => {
        if (!cancel) setHistorial([]);
      });
    return () => {
      cancel = true;
    };
  }, [selected, empresa, clase]);

  const catMatch = (contable?.catcta || []).filter(
    (c) => c.cuenta6 === svc.cuenta || c.cuenta7 === svc.cuenta,
  );
  const needsPlaca = catMatch.some((c) => c.requierePlaca);
  const needsObra =
    svc.cuenta.startsWith("1210") || catMatch.some((c) => c.requiereObra);

  function elegir(next: Clase) {
    setClase(next);
    setCart([]);
    setSelected(null);
    setPreview(null);
    setMsg("");
  }

  async function buscarArticulos(text: string, announce: boolean) {
    if (!empresa) return;
    const id = ++buscaId.current;
    setBuscando(true);
    try {
      const r = await api.articulos(empresa, text);
      if (id !== buscaId.current) return;
      setItems(r.items);
      const origen = r.source === "local" ? "catálogo local" : `SAP ${r.company || empresa}`;
      setSapMsg(
        r.items.length
          ? `${r.items.length} artículo(s) · ${origen}`
          : `Sin artículos en ${origen}`,
      );
      if (announce && r.items.length === 1) setSelected(r.items[0]);
    } catch (e) {
      if (id !== buscaId.current) return;
      setItems([]);
      setSapMsg((e as Error).message);
    } finally {
      if (id === buscaId.current) setBuscando(false);
    }
  }

  useEffect(() => {
    if (!user || !empresa || clase !== "articulo") return;
    const handle = setTimeout(() => {
      void buscarArticulos(q, false);
    }, q.trim() ? 400 : 0);
    return () => {
      clearTimeout(handle);
      buscaId.current += 1;
    };
  }, [user, q, empresa, clase]);

  function addToCart() {
    if (!preview || !selected) return;
    if (lleno) {
      setMsg(`Máximo ${MAX_LINEAS_SOLICITUD} líneas por solicitud`);
      return;
    }
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
      { ...preview.line, qty, justificacion: just, just, clase: "articulo" },
    ]);
    setSelected(null);
    setJust("");
    setMsg("Línea agregada al carrito");
  }

  function addServicio() {
    if (lleno) {
      setMsg(`Máximo ${MAX_LINEAS_SOLICITUD} líneas por solicitud`);
      return;
    }
    const descripcion = svc.descripcion.trim();
    if (!descripcion) {
      setMsg("Indique la descripción del servicio");
      return;
    }
    if (!(svc.qty > 0)) {
      setMsg("La cantidad debe ser mayor a cero");
      return;
    }
    if (!(svc.price > 0)) {
      setMsg("Indique el precio unitario");
      return;
    }
    if (!svc.cuenta || !svc.proyecto || !svc.d1 || !svc.d2 || !svc.d3 || !svc.d4 || !svc.d5) {
      setMsg("Seleccione cuenta, proyecto y dimensiones de cada lista");
      return;
    }
    if (needsPlaca && !svc.placa.trim()) {
      setMsg("Esta cuenta exige placa");
      return;
    }
    if (needsObra && (!svc.obraProc.trim() || !svc.obraEsp.trim())) {
      setMsg("Esta cuenta exige obra en proceso y número de obra");
      return;
    }
    const total = +(svc.qty * svc.price).toFixed(2);
    const line: CartLine = {
      clase: "servicio",
      code: "",
      name: descripcion,
      cat: "Servicio",
      qty: svc.qty,
      price: svc.price,
      total,
      sug: svc.qty,
      alerta: "Servicio",
      just: "",
      disp: 0,
      min: 0,
      max: 0,
      ct: {
        cta: svc.cuenta,
        d1: svc.d1,
        d2: svc.d2,
        d3: svc.d3,
        d4: svc.d4,
        d5: svc.d5,
        proy: svc.proyecto,
        depN: elegidos.current.d1 || svc.d1,
        subN: elegidos.current.d2 || svc.d2,
        ubiN: elegidos.current.d3 || svc.d3,
        linN: elegidos.current.d4 || svc.d4,
        prodN: elegidos.current.d5 || svc.d5,
        proyN: elegidos.current.proy || svc.proyecto,
        placa: svc.placa,
        obraProc: svc.obraProc,
        obraEsp: svc.obraEsp,
        ok: true,
        validacion: "Correctamente",
      },
    };
    setCart((c) => [...c, line]);
    setSvc((s) => ({ ...s, descripcion: "", qty: 1, price: 0, placa: "", obraProc: "", obraEsp: "" }));
    setMsg("Línea de servicio agregada");
  }

  async function enviar() {
    if (!cart.length) return;
    if (cart.length > MAX_LINEAS_SOLICITUD) {
      setMsg(`Máximo ${MAX_LINEAS_SOLICITUD} líneas por solicitud`);
      return;
    }
    setBusy(true);
    try {
      const created = await api.createSolicitud({
        clase,
        requiredDate,
        comentario,
        empresa,
        bodegaCodigo: bodega,
        tipoDocumento: tipo,
        lines:
          clase === "servicio"
            ? cart.map((l) => ({
                descripcion: l.name,
                qty: l.qty,
                price: l.price,
                cuenta: l.ct.cta,
                proyecto: l.ct.proy,
                d1: l.ct.d1,
                d2: l.ct.d2,
                d3: l.ct.d3,
                d4: l.ct.d4,
                d5: l.ct.d5,
                placa: l.ct.placa,
                obraProc: l.ct.obraProc,
                obraEsp: l.ct.obraEsp,
                depN: l.ct.depN,
                subN: l.ct.subN,
                ubiN: l.ct.ubiN,
                linN: l.ct.linN,
                prodN: l.ct.prodN,
                proyN: l.ct.proyN,
              }))
            : cart.map((l) => ({
                itemCode: l.code,
                qty: l.qty,
                justificacion: l.justificacion || l.just,
                contable: l.ct,
              })),
      });
      setCart([]);
      setMsg(
        `Solicitud ${created.id} creada · ${clase} · ${created.tipoDocumento || tipo} ${created.docNum || ""} · bodega ${created.bodegaCodigo || bodega} · ${created.estado}`,
      );
    } catch (e) {
      setMsg((e as Error).message);
    } finally {
      setBusy(false);
    }
  }

  const total = cart.reduce((a, l) => a + l.total, 0);

  function patchSvc(partial: Partial<SvcForm>) {
    const next = { ...partial };
    if (typeof next.descripcion === "string") next.descripcion = mayus(next.descripcion);
    if (typeof next.placa === "string") next.placa = mayus(next.placa);
    if (typeof next.obraProc === "string") next.obraProc = mayus(next.obraProc);
    if (typeof next.obraEsp === "string") next.obraEsp = mayus(next.obraEsp);
    setSvc((s) => ({ ...s, ...next }));
  }

  return (
    <div className="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
      <div className="space-y-4">
        <Card>
          <h1 className="font-display text-2xl font-bold">
            {clase === "servicio" ? "Solicitar servicio" : "Solicitar materiales"}
          </h1>
          <p className="text-sm text-muted">
            {clase === "servicio"
              ? "Línea de servicio de SAP B1: cantidad, descripción, cuenta y dimensiones. Máximo 21 líneas."
              : "La solicitud queda registrada con empresa, bodega, tipo y número de documento. El código del artículo no cambia."}
          </p>
          <div className="mt-4 grid grid-cols-2 gap-2">
            <button
              type="button"
              className={`rounded-xl px-3 py-2 text-sm font-bold ${
                clase === "servicio" ? "bg-brand-800 text-white" : "border border-line bg-card"
              }`}
              onClick={() => elegir("servicio")}
            >
              1 · Servicio
            </button>
            <button
              type="button"
              className={`rounded-xl px-3 py-2 text-sm font-bold ${
                clase === "articulo" ? "bg-brand-800 text-white" : "border border-line bg-card"
              }`}
              onClick={() => elegir("articulo")}
            >
              2 · Artículo
            </button>
          </div>
          <div className="mt-4 grid gap-3 sm:grid-cols-3">
            {user?.emp === "TODAS" && (
              <Field label="Empresa">
                <select
                  className={fieldCls}
                  value={empresaSel}
                  onChange={(e) => setEmpresaSel(e.target.value)}
                >
                  {empresas.map((e) => (
                    <option key={e.codigo} value={e.codigo}>
                      {e.codigo} · {e.nombreAnexo}
                    </option>
                  ))}
                </select>
              </Field>
            )}
            {user?.emp !== "TODAS" && (
              <div className="rounded-xl bg-soft px-3 py-2 text-sm">
                <div className="text-[10px] font-bold uppercase text-muted">Empresa</div>
                <div className="font-bold">{empresa}</div>
              </div>
            )}
            <Field label="Bodega">
              <select
                className={fieldCls}
                value={bodega}
                onChange={(e) => setBodega(e.target.value)}
              >
                {bodegas.map((b) => (
                  <option key={b.codigo} value={b.codigo}>
                    {b.codigo} · {b.nombre}
                  </option>
                ))}
              </select>
            </Field>
            <Field label="Tipo de documento">
              <select className={fieldCls} value={tipo} onChange={(e) => setTipo(e.target.value)}>
                {tipos.map((t) => (
                  <option key={t.codigo} value={t.codigo}>
                    {t.codigo} · {t.nombre}
                  </option>
                ))}
              </select>
            </Field>
          </div>

          {clase === "articulo" && (
            <>
              <div className="mt-4 flex gap-2">
                <input
                  className="flex-1 rounded-xl border border-line bg-card px-3 py-2 uppercase"
                  placeholder="Buscar código, nombre o familia…"
                  value={q}
                  onChange={(e) => setQ(mayus(e.target.value))}
                  onKeyDown={(e) => {
                    if (e.key === "Enter") void buscarArticulos(q, true);
                  }}
                />
                <Button
                  variant="claude"
                  onClick={() => void buscarArticulos(q, true)}
                  disabled={buscando}
                >
                  {buscando ? "Buscando…" : "Buscar en SAP"}
                </Button>
              </div>
              {sapMsg && <p className="mt-2 text-sm text-brand-800">{sapMsg}</p>}
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
            </>
          )}
        </Card>

        {clase === "articulo" && selected && preview && (
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
            <div className="mt-3 rounded-xl border border-line p-3">
              <div className="text-[10px] font-bold uppercase text-muted">
                Historial de precio de compra
              </div>
              <p className="mt-1 text-xs text-muted">
                Precio promedio SAP {fQ(selected.precioProm)}. Las compras anteriores quedan
                guardadas con este código.
              </p>
              {historial.length === 0 ? (
                <p className="mt-2 text-sm text-muted">Todavía no hay solicitudes de este código.</p>
              ) : (
                <ul className="mt-2 space-y-1 text-sm">
                  {historial.map((h) => (
                    <li key={`${h.solicitudId}-${h.fecha}`} className="flex justify-between gap-3">
                      <span className="text-muted">
                        {fFecha(h.fecha)} · {h.docNum || h.solicitudId} · {h.qty} und
                      </span>
                      <span className="font-semibold">{fQ(h.precio)}</span>
                    </li>
                  ))}
                </ul>
              )}
            </div>
            <div className="mt-3 flex flex-wrap items-end gap-3">
              <Field label="Cantidad">
                <input
                  type="number"
                  min={1}
                  className={`${fieldCls} w-28`}
                  value={qty}
                  onChange={(e) => setQty(Number(e.target.value))}
                />
              </Field>
              <Button size="sm" variant="primary" onClick={() => setQty(preview.alerta.sug || 1)}>
                Usar sugerida
              </Button>
            </div>
            {(preview.alerta.exige || just) && (
              <textarea
                className="mt-3 w-full rounded-xl border border-line px-3 py-2 uppercase"
                placeholder="Justificación (obligatoria si sobre máximo)"
                value={just}
                onChange={(e) => setJust(mayus(e.target.value))}
              />
            )}
            <div className="mt-3 text-sm">
              Cuenta {preview.line.ct.cta} ·{" "}
              <Badge tone={preview.line.ct.ok ? "ok" : "bad"}>{preview.line.ct.validacion}</Badge>
            </div>
            <div className="mt-4 flex gap-2">
              <Button variant="primary" onClick={addToCart} disabled={lleno}>
                Agregar · {fQ(preview.line.total)}
              </Button>
            </div>
          </Card>
        )}

        {clase === "servicio" && (
          <Card>
            <div className="flex items-center justify-between gap-3">
              <h2 className="font-display text-lg font-bold">Línea de servicio</h2>
              <span className="text-xs font-bold text-muted">
                {cart.length} / {MAX_LINEAS_SOLICITUD}
              </span>
            </div>
            <div className="mt-3 grid gap-3 sm:grid-cols-3">
              <Field label="Cantidad">
                <input
                  type="number"
                  min={0.01}
                  step="0.01"
                  className={fieldCls}
                  value={svc.qty}
                  onChange={(e) => patchSvc({ qty: Number(e.target.value) })}
                />
              </Field>
              <Field label="Precio unitario">
                <input
                  type="number"
                  min={0}
                  step="0.01"
                  className={fieldCls}
                  value={svc.price || ""}
                  onChange={(e) => patchSvc({ price: Number(e.target.value) })}
                />
              </Field>
              <div className="rounded-xl bg-soft px-3 py-2 text-sm sm:col-span-1">
                <div className="text-[10px] font-bold uppercase text-muted">Total línea</div>
                <div className="font-display text-xl font-bold">
                  {fQ((svc.qty || 0) * (svc.price || 0))}
                </div>
              </div>
            </div>
            <div className="mt-3">
              <Field label="Descripción">
                <input
                  className={textCls}
                  value={svc.descripcion}
                  placeholder="Texto libre del servicio"
                  onChange={(e) => patchSvc({ descripcion: e.target.value })}
                />
              </Field>
            </div>
            <div className="mt-3 grid gap-3 sm:grid-cols-2">
              <SapBusqueda
                key={`cuenta-${empresa}`}
                label="Cuenta de mayor"
                placeholder="Código o nombre"
                vacio="Sin cuentas con ese texto."
                buscar={(q) => api.cuentas(empresa, q).then((r) => r.items)}
                onPick={(code) => patchSvc({ cuenta: code })}
              />
              <SapBusqueda
                key={`proy-${empresa}`}
                label="Proyecto"
                placeholder="Código o nombre"
                vacio="Sin proyectos con ese texto."
                buscar={(q) => api.proyectos(empresa, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.proy = name;
                  patchSvc({ proyecto: code });
                }}
              />
              <SapBusqueda
                key={`d1-${empresa}`}
                label="Departamento"
                placeholder="Código o nombre"
                vacio="Sin departamentos con ese texto."
                buscar={(q) => api.dimensiones(empresa, 1, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.d1 = name;
                  patchSvc({ d1: code });
                }}
              />
              <SapBusqueda
                key={`d2-${empresa}`}
                label="Sub departamento"
                placeholder="Código o nombre"
                vacio="Sin sub departamentos con ese texto."
                buscar={(q) => api.dimensiones(empresa, 2, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.d2 = name;
                  patchSvc({ d2: code });
                }}
              />
              <SapBusqueda
                key={`d3-${empresa}`}
                label="Localidad"
                placeholder="Código o nombre"
                vacio="Sin localidades con ese texto."
                buscar={(q) => api.dimensiones(empresa, 3, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.d3 = name;
                  patchSvc({ d3: code });
                }}
              />
              <SapBusqueda
                key={`d4-${empresa}`}
                label="Línea de producto"
                placeholder="Código o nombre"
                vacio="Sin líneas con ese texto."
                buscar={(q) => api.dimensiones(empresa, 4, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.d4 = name;
                  patchSvc({ d4: code });
                }}
              />
              <SapBusqueda
                key={`d5-${empresa}`}
                label="Producto"
                placeholder="Código o nombre"
                vacio="Sin productos con ese texto."
                buscar={(q) => api.dimensiones(empresa, 5, q).then((r) => r.items)}
                onPick={(code, name) => {
                  elegidos.current.d5 = name;
                  patchSvc({ d5: code });
                }}
              />
            </div>
            {(needsPlaca || needsObra) && (
              <div className="mt-3 grid gap-3 sm:grid-cols-3">
                {needsPlaca && (
                  <Field label="Placa">
                    <input
                      className={textCls}
                      value={svc.placa}
                      onChange={(e) => patchSvc({ placa: e.target.value })}
                    />
                  </Field>
                )}
                {needsObra && (
                  <>
                    <Field label="Obra en proceso">
                      <input
                        className={textCls}
                        value={svc.obraProc}
                        onChange={(e) => patchSvc({ obraProc: e.target.value })}
                      />
                    </Field>
                    <Field label="No. obra específica">
                      <input
                        className={textCls}
                        value={svc.obraEsp}
                        onChange={(e) => patchSvc({ obraEsp: e.target.value })}
                      />
                    </Field>
                  </>
                )}
              </div>
            )}
            <div className="mt-4">
              <Button variant="primary" onClick={addServicio} disabled={lleno}>
                Agregar línea
              </Button>
            </div>
          </Card>
        )}
      </div>

      <Card className="h-fit sticky top-4">
        <div className="flex items-center justify-between">
          <h2 className="font-display text-lg font-bold">Carrito</h2>
          <span className="text-xs font-bold text-muted">
            {cart.length} / {MAX_LINEAS_SOLICITUD}
          </span>
        </div>
        {cart.length === 0 ? (
          <p className="mt-3 text-sm text-muted">Sin líneas todavía.</p>
        ) : (
          <ul className="mt-3 space-y-2">
            {cart.map((l, i) => (
              <li key={i} className="rounded-xl border border-line p-3 text-sm">
                <div className="flex items-start justify-between gap-2">
                  <div className="font-semibold">{l.name}</div>
                  <button
                    type="button"
                    className="text-xs font-bold text-danger"
                    onClick={() => setCart((c) => c.filter((_, j) => j !== i))}
                  >
                    Quitar
                  </button>
                </div>
                {l.clase === "articulo" && (
                  <div className="text-xs text-muted">{l.code}</div>
                )}
                <div className="text-muted">
                  {l.qty} × {fQ(l.price)} = {fQ(l.total)}
                </div>
                {l.clase === "servicio" && (
                  <div className="mt-1 text-xs text-muted">{dimsLinea(l.ct)}</div>
                )}
                <Badge className="mt-1" tone={l.alerta === "En rango" || l.alerta === "Servicio" ? "ok" : "warn"}>
                  {l.alerta}
                </Badge>
              </li>
            ))}
          </ul>
        )}
        <div className="mt-4 space-y-3">
          <Field label="Fecha requerida">
            <input
              type="date"
              className={fieldCls}
              value={requiredDate}
              onChange={(e) => setRequiredDate(e.target.value)}
            />
          </Field>
          <textarea
            className="w-full rounded-xl border border-line px-3 py-2 uppercase"
            placeholder="Comentario"
            value={comentario}
            onChange={(e) => setComentario(mayus(e.target.value))}
          />
          <div className="flex items-center justify-between font-display text-xl font-bold">
            <span>Total</span>
            <span>{fQ(total)}</span>
          </div>
          <Button
            variant="dark"
            size="lg"
            className="w-full"
            disabled={!cart.length || busy || !bodega || !tipo || !empresa || cart.length > MAX_LINEAS_SOLICITUD}
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

function SapBusqueda({
  label,
  placeholder,
  vacio,
  buscar,
  onPick,
}: {
  label: string;
  placeholder: string;
  vacio: string;
  buscar: (q: string) => Promise<SapOpcion[]>;
  onPick: (code: string, name: string) => void;
}) {
  const [texto, setTexto] = useState("");
  const [hits, setHits] = useState<SapOpcion[]>([]);
  const [estado, setEstado] = useState<"idle" | "buscando" | "error" | "vacio">("idle");
  const [aviso, setAviso] = useState("");
  const elegida = useRef("");
  const req = useRef(0);
  const buscarRef = useRef(buscar);
  buscarRef.current = buscar;

  useEffect(() => {
    if (texto === elegida.current || texto.trim().length < 2) {
      setHits([]);
      setEstado("idle");
      return;
    }
    const handle = setTimeout(() => {
      const id = ++req.current;
      setEstado("buscando");
      setHits([]);
      void buscarRef
        .current(texto.trim())
        .then((items) => {
          if (id !== req.current) return;
          setHits(items);
          setEstado(items.length ? "idle" : "vacio");
        })
        .catch((e) => {
          if (id !== req.current) return;
          setHits([]);
          setEstado("error");
          setAviso((e as Error).message);
        });
    }, 400);
    return () => {
      clearTimeout(handle);
      req.current += 1;
    };
  }, [texto]);

  return (
    <label className="relative block">
      <span className="text-xs font-bold uppercase text-muted">{label}</span>
      <input
        className={textCls}
        value={texto}
        placeholder={placeholder}
        autoComplete="off"
        onChange={(e) => {
          const next = mayus(e.target.value);
          setTexto(next);
          if (next !== elegida.current) onPick("", "");
        }}
      />
      {estado === "buscando" && <span className="mt-1 block text-xs text-muted">Buscando en SAP…</span>}
      {estado === "error" && (
        <span className="mt-1 block text-xs font-medium text-[#7a5a08]">{aviso}</span>
      )}
      {estado === "vacio" && <span className="mt-1 block text-xs text-muted">{vacio}</span>}
      {hits.length > 0 && (
        <ul className="absolute z-20 mt-1 max-h-56 w-full overflow-auto rounded-xl border border-line bg-card py-1 shadow-lg">
          {hits.map((c) => {
            const visible = c.formato && c.formato !== c.code ? c.formato : c.code;
            const chosen = c.formato && c.formato !== c.code ? `${c.formato} · ${c.name}` : `${c.code} · ${c.name}`;
            return (
              <li key={c.code}>
                <button
                  type="button"
                  className="w-full px-3 py-2 text-left text-sm hover:bg-soft"
                  onMouseDown={(e) => e.preventDefault()}
                  onClick={() => {
                    elegida.current = chosen;
                    setTexto(chosen);
                    setHits([]);
                    setEstado("idle");
                    onPick(c.code, c.name || c.code);
                  }}
                >
                  <span className="font-semibold">{visible}</span>
                  <span className="text-muted"> · {c.name}</span>
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </label>
  );
}
