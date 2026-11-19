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
  type ServicioMaestros,
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

type CampoEstado = "cargando" | "error" | "vacio" | "listo";

type CampoSap = {
  label: string;
  value: string;
  options: { code: string; name: string; formato?: string }[];
  estado: CampoEstado;
  aviso?: string;
  onChange: (code: string) => void;
};

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
  const [svc, setSvc] = useState<SvcForm>(EMPTY_SVC);
  const [maestros, setMaestros] = useState<
    | { estado: "cargando" }
    | { estado: "error"; mensaje: string }
    | { estado: "listo"; data: ServicioMaestros }
  >({ estado: "cargando" });
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
    setMaestros({ estado: "cargando" });
  }, [empresa]);

  useEffect(() => {
    if (clase !== "servicio" || !empresa) return;
    let cancel = false;
    setMaestros({ estado: "cargando" });
    void api
      .contable(empresa)
      .then((r) => {
        if (!cancel) setContable({ catcta: r.catcta });
      })
      .catch((e) => {
        if (!cancel) setMsg(e.message);
      });
    void api
      .servicioMaestros(empresa)
      .then((r) => {
        if (!cancel) setMaestros({ estado: "listo", data: r });
      })
      .catch((e) => {
        if (!cancel) setMaestros({ estado: "error", mensaje: (e as Error).message });
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

  const sapCaido = maestros.estado === "error";
  const sapListo = maestros.estado === "listo" ? maestros.data : null;

  function falta(entidad: string) {
    return sapListo?.faltantes.some((f) => f.entidad === entidad) ?? false;
  }

  function campoDe(
    label: string,
    value: string,
    options: CampoSap["options"],
    entidadCaida: boolean,
    aviso: string,
    onChange: (code: string) => void,
  ): CampoSap {
    if (maestros.estado === "cargando") {
      return { label, value: "", options: [], estado: "cargando", onChange };
    }
    if (sapCaido) {
      return { label, value: "", options: [], estado: "error", onChange };
    }
    if (entidadCaida) {
      return { label, value: "", options: [], estado: "error", aviso, onChange };
    }
    if (!options.length) {
      return {
        label,
        value: "",
        options: [],
        estado: "vacio",
        aviso: "SAP no tiene registros para esta lista.",
        onChange,
      };
    }
    return { label, value, options, estado: "listo", onChange };
  }

  const cuentaCampo = campoDe(
    "Cuenta de mayor",
    svc.cuenta,
    sapListo?.cuentas || [],
    falta("ChartOfAccounts"),
    "SAP no devolvió el catálogo de cuentas.",
    (cuenta) => patchSvc({ cuenta }),
  );
  const proyectoCampo = campoDe(
    "Proyecto",
    svc.proyecto,
    sapListo?.proyectos || [],
    falta("ProjectsService"),
    "SAP no devolvió los proyectos.",
    (proyecto) => patchSvc({ proyecto }),
  );

  function campoDim(n: number, etiqueta: string, value: string, onChange: (code: string) => void) {
    const dim = sapListo?.dimensiones.find((d) => d.n === n);
    const opciones = dim?.opciones || [];
    const centrosMal = falta("ProfitCenters");
    const reglasMal = falta("DistributionRulesService");
    const aviso = centrosMal && reglasMal
      ? "SAP no devolvió centros ni reglas de distribución."
      : centrosMal
        ? "SAP no devolvió los centros de beneficio."
        : "SAP no devolvió las reglas de distribución.";
    return campoDe(
      dim?.nombre || etiqueta,
      value,
      opciones,
      !opciones.length && (centrosMal || reglasMal),
      aviso,
      onChange,
    );
  }

  const dep = campoDim(1, "Departamento", svc.d1, (d1) => patchSvc({ d1 }));
  const sub = campoDim(2, "Sub departamento", svc.d2, (d2) => patchSvc({ d2 }));
  const loc = campoDim(3, "Localidad", svc.d3, (d3) => patchSvc({ d3 }));
  const lin = campoDim(4, "Línea de producto", svc.d4, (d4) => patchSvc({ d4 }));
  const prod = campoDim(5, "Producto", svc.d5, (d5) => patchSvc({ d5 }));

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
    const campos = [cuentaCampo, proyectoCampo, dep, sub, loc, lin, prod];
    const pendiente = campos.find((c) => c.estado !== "listo");
    if (pendiente) {
      setMsg(
        pendiente.estado === "cargando"
          ? "Espere la consulta a SAP"
          : `${pendiente.label}: ${pendiente.aviso || "no disponible"}`,
      );
      return;
    }
    if (!svc.cuenta || !svc.proyecto || !svc.d1 || !svc.d2 || !svc.d3 || !svc.d4 || !svc.d5) {
      setMsg("Complete cuenta de mayor, proyecto y las dimensiones");
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
        depN: nombreDe(dep.options, svc.d1),
        subN: nombreDe(sub.options, svc.d2),
        ubiN: nombreDe(loc.options, svc.d3),
        linN: nombreDe(lin.options, svc.d4),
        prodN: nombreDe(prod.options, svc.d5),
        proyN: nombreDe(proyectoCampo.options, svc.proyecto),
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
            {maestros.estado === "error" && (
              <p className="mt-3 rounded-xl bg-[#F6EBCB] px-3 py-2 text-sm text-[#7a5a08]">
                {maestros.mensaje}
              </p>
            )}
            <div className="mt-3 grid gap-3 sm:grid-cols-2">
              <SapSelect campo={cuentaCampo} />
              <SapSelect campo={proyectoCampo} />
              <SapSelect campo={dep} />
              <SapSelect campo={sub} />
              <SapSelect campo={loc} />
              <SapSelect campo={lin} />
              <SapSelect campo={prod} />
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

function nombreDe(options: { code: string; name: string }[], code: string) {
  return options.find((o) => o.code === code)?.name || code;
}

function SapSelect({ campo }: { campo: CampoSap }) {
  const bloqueado = campo.estado !== "listo";
  const placeholder =
    campo.estado === "cargando"
      ? "Consultando SAP…"
      : campo.estado === "error"
        ? "No disponible"
        : campo.estado === "vacio"
          ? "Sin registros en SAP"
          : "Seleccione";
  return (
    <label className="block">
      <span className="text-xs font-bold uppercase text-muted">{campo.label}</span>
      <select
        className={`${fieldCls} ${bloqueado ? "text-muted" : ""}`}
        value={bloqueado ? "" : campo.value}
        disabled={bloqueado}
        onChange={(e) => campo.onChange(e.target.value)}
      >
        <option value="">{placeholder}</option>
        {campo.estado === "listo" &&
          campo.options.map((o) => (
            <option key={o.code} value={o.code}>
              {(o.formato && o.formato !== o.code ? `${o.formato} · ` : "") +
                `${o.name} · ${o.code}`}
            </option>
          ))}
      </select>
      {bloqueado && campo.aviso && (
        <span className="mt-1 block text-xs font-medium text-[#7a5a08]">{campo.aviso}</span>
      )}
    </label>
  );
}
