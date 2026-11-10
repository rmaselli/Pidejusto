"use client";

import { useEffect, useState } from "react";
import { api, type Bodega, type Empresa, type SerieDocumento, type TipoDocumento } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";

export default function DocumentosPage() {
  const [tipos, setTipos] = useState<TipoDocumento[]>([]);
  const [series, setSeries] = useState<SerieDocumento[]>([]);
  const [empresas, setEmpresas] = useState<Empresa[]>([]);
  const [bodegas, setBodegas] = useState<Bodega[]>([]);
  const [msg, setMsg] = useState("");
  const [tipo, setTipo] = useState({ codigo: "", nombre: "", objetoSap: "PurchaseRequests" });
  const [serie, setSerie] = useState({
    empresa: "",
    tipoCodigo: "SC",
    bodegaCodigo: "",
    prefijo: "",
    siguiente: 1,
    digitos: 5,
  });

  async function load() {
    const [t, s, e, b] = await Promise.all([
      api.tiposDocumento(),
      api.seriesDocumento(),
      api.empresas(),
      api.bodegas(),
    ]);
    setTipos(t.tipos);
    setSeries(s.series);
    setEmpresas(e.empresas);
    setBodegas(b.bodegas);
    setSerie((cur) => ({
      ...cur,
      empresa: cur.empresa || e.empresas[0]?.codigo || "",
      tipoCodigo: cur.tipoCodigo || t.tipos[0]?.codigo || "SC",
    }));
  }

  useEffect(() => {
    void load().catch((e) => setMsg(e.message));
  }, []);

  async function crearTipo() {
    try {
      await api.createTipo(tipo);
      setTipo({ codigo: "", nombre: "", objetoSap: "PurchaseRequests" });
      setMsg("Tipo de documento registrado");
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function saveTipo(t: TipoDocumento) {
    try {
      await api.saveTipo(t.codigo, { nombre: t.nombre, objetoSap: t.objetoSap, activo: t.activo });
      setMsg(`Tipo ${t.codigo} actualizado`);
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function crearSerie() {
    try {
      await api.createSerie(serie);
      setMsg("Numeración registrada");
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  async function saveSerie(s: SerieDocumento) {
    try {
      await api.saveSerie(s.id, {
        prefijo: s.prefijo,
        siguiente: Number(s.siguiente),
        digitos: Number(s.digitos),
        activo: s.activo,
      });
      setMsg("Serie actualizada");
      await load();
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  const bodegasEmpresa = bodegas.filter((b) => b.empresa === serie.empresa);

  return (
    <div className="space-y-8">
      <div>
        <h1 className="font-display text-2xl font-bold">Tipos y números de documento</h1>
        <p className="text-sm text-muted">
          Al crear una solicitud se toma el siguiente número de la serie de esa empresa, tipo y bodega.
        </p>
      </div>
      {msg && <p className="text-sm text-brand-800">{msg}</p>}

      <section className="space-y-3">
        <h2 className="font-display text-xl font-bold">Tipos</h2>
        <Card className="grid gap-3 md:grid-cols-4 md:items-end">
          <label className="text-xs font-bold uppercase text-muted">
            Código
            <input
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={tipo.codigo}
              onChange={(e) => setTipo({ ...tipo, codigo: e.target.value })}
            />
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Nombre
            <input
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={tipo.nombre}
              onChange={(e) => setTipo({ ...tipo, nombre: e.target.value })}
            />
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Objeto Service Layer
            <input
              className="mt-1 w-full rounded-xl border border-line px-3 py-2 font-mono"
              value={tipo.objetoSap}
              onChange={(e) => setTipo({ ...tipo, objetoSap: e.target.value })}
            />
          </label>
          <Button variant="primary" onClick={() => void crearTipo()}>
            Agregar tipo
          </Button>
        </Card>
        {tipos.map((t) => (
          <Card key={t.codigo} className="grid gap-3 md:grid-cols-[0.4fr_1fr_1fr_auto] md:items-end">
            <div className="font-bold">{t.codigo}</div>
            <label className="text-xs font-bold uppercase text-muted">
              Nombre
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={t.nombre}
                onChange={(e) =>
                  setTipos((list) =>
                    list.map((x) => (x.codigo === t.codigo ? { ...x, nombre: e.target.value } : x)),
                  )
                }
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Objeto SAP
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2 font-mono"
                value={t.objetoSap}
                onChange={(e) =>
                  setTipos((list) =>
                    list.map((x) =>
                      x.codigo === t.codigo ? { ...x, objetoSap: e.target.value } : x,
                    ),
                  )
                }
              />
            </label>
            <Button variant="primary" onClick={() => void saveTipo(t)}>
              Guardar
            </Button>
          </Card>
        ))}
      </section>

      <section className="space-y-3">
        <h2 className="font-display text-xl font-bold">Numeración</h2>
        <Card className="grid gap-3 md:grid-cols-3">
          <label className="text-xs font-bold uppercase text-muted">
            Empresa
            <select
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.empresa}
              onChange={(e) => setSerie({ ...serie, empresa: e.target.value, bodegaCodigo: "" })}
            >
              {empresas.map((e) => (
                <option key={e.codigo} value={e.codigo}>
                  {e.codigo}
                </option>
              ))}
            </select>
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Tipo
            <select
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.tipoCodigo}
              onChange={(e) => setSerie({ ...serie, tipoCodigo: e.target.value })}
            >
              {tipos.map((t) => (
                <option key={t.codigo} value={t.codigo}>
                  {t.codigo} · {t.nombre}
                </option>
              ))}
            </select>
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Bodega (opcional)
            <select
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.bodegaCodigo}
              onChange={(e) => setSerie({ ...serie, bodegaCodigo: e.target.value })}
            >
              <option value="">Todas las bodegas de la empresa</option>
              {bodegasEmpresa.map((b) => (
                <option key={b.codigo} value={b.codigo}>
                  {b.codigo} · {b.nombre}
                </option>
              ))}
            </select>
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Prefijo
            <input
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.prefijo}
              onChange={(e) => setSerie({ ...serie, prefijo: e.target.value })}
            />
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Siguiente
            <input
              type="number"
              min={1}
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.siguiente}
              onChange={(e) => setSerie({ ...serie, siguiente: Number(e.target.value) })}
            />
          </label>
          <label className="text-xs font-bold uppercase text-muted">
            Dígitos
            <input
              type="number"
              min={1}
              className="mt-1 w-full rounded-xl border border-line px-3 py-2"
              value={serie.digitos}
              onChange={(e) => setSerie({ ...serie, digitos: Number(e.target.value) })}
            />
          </label>
          <Button variant="primary" onClick={() => void crearSerie()}>
            Registrar numeración
          </Button>
        </Card>
        {series.map((s) => (
          <Card key={s.id} className="grid gap-3 md:grid-cols-[1.2fr_1fr_0.6fr_0.5fr_auto] md:items-end">
            <div>
              <div className="font-bold">
                {s.empresa} · {s.tipoCodigo}
                {s.bodegaCodigo ? ` · bod ${s.bodegaCodigo}` : ""}
              </div>
              <div className="text-xs text-muted">
                Próximo: {s.prefijo}
                {String(s.siguiente).padStart(s.digitos, "0")}
              </div>
            </div>
            <label className="text-xs font-bold uppercase text-muted">
              Prefijo
              <input
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={s.prefijo}
                onChange={(e) =>
                  setSeries((list) =>
                    list.map((x) => (x.id === s.id ? { ...x, prefijo: e.target.value } : x)),
                  )
                }
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Siguiente
              <input
                type="number"
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={s.siguiente}
                onChange={(e) =>
                  setSeries((list) =>
                    list.map((x) =>
                      x.id === s.id ? { ...x, siguiente: Number(e.target.value) } : x,
                    ),
                  )
                }
              />
            </label>
            <label className="text-xs font-bold uppercase text-muted">
              Dígitos
              <input
                type="number"
                className="mt-1 w-full rounded-xl border border-line px-3 py-2"
                value={s.digitos}
                onChange={(e) =>
                  setSeries((list) =>
                    list.map((x) =>
                      x.id === s.id ? { ...x, digitos: Number(e.target.value) } : x,
                    ),
                  )
                }
              />
            </label>
            <Button variant="primary" onClick={() => void saveSerie(s)}>
              Guardar
            </Button>
          </Card>
        ))}
      </section>
    </div>
  );
}
