--
-- PostgreSQL database dump
--

\restrict af2xOIEeNufV0iDfuvxUAry9xbQ1iArh4SSjEAJcr6kdx19TOEml0Ubo67IffkM

-- Dumped from database version 16.14
-- Dumped by pg_dump version 16.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP INDEX IF EXISTS public.series_emp_tipo_bod;
DROP INDEX IF EXISTS public.existencias_emp_code;
DROP INDEX IF EXISTS public.consumo_emp_code;
DROP INDEX IF EXISTS public.bodegas_emp_codigo;
DROP INDEX IF EXISTS public.articulos_emp_code;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.tipos_documento DROP CONSTRAINT IF EXISTS tipos_documento_pkey;
ALTER TABLE IF EXISTS ONLY public.solicitudes DROP CONSTRAINT IF EXISTS solicitudes_pkey;
ALTER TABLE IF EXISTS ONLY public.solicitud_lineas DROP CONSTRAINT IF EXISTS solicitud_lineas_pkey;
ALTER TABLE IF EXISTS ONLY public.series_documento DROP CONSTRAINT IF EXISTS series_documento_pkey;
ALTER TABLE IF EXISTS ONLY public.sequences DROP CONSTRAINT IF EXISTS sequences_pkey;
ALTER TABLE IF EXISTS ONLY public.sap_post_lines DROP CONSTRAINT IF EXISTS sap_post_lines_pkey;
ALTER TABLE IF EXISTS ONLY public.parametros DROP CONSTRAINT IF EXISTS parametros_pkey;
ALTER TABLE IF EXISTS ONLY public.niveles_aprobacion DROP CONSTRAINT IF EXISTS niveles_aprobacion_pkey;
ALTER TABLE IF EXISTS ONLY public.matriz_contable DROP CONSTRAINT IF EXISTS matriz_contable_pkey;
ALTER TABLE IF EXISTS ONLY public.matriz_aprobacion DROP CONSTRAINT IF EXISTS matriz_aprobacion_pkey;
ALTER TABLE IF EXISTS ONLY public.homologacion DROP CONSTRAINT IF EXISTS homologacion_pkey;
ALTER TABLE IF EXISTS ONLY public.existencias DROP CONSTRAINT IF EXISTS existencias_pkey;
ALTER TABLE IF EXISTS ONLY public.empresas DROP CONSTRAINT IF EXISTS empresas_pkey;
ALTER TABLE IF EXISTS ONLY public.ejecucion_presupuesto DROP CONSTRAINT IF EXISTS ejecucion_presupuesto_pkey;
ALTER TABLE IF EXISTS ONLY public.cuentas_contables DROP CONSTRAINT IF EXISTS cuentas_contables_pkey;
ALTER TABLE IF EXISTS ONLY public.consumo_trimestral DROP CONSTRAINT IF EXISTS consumo_trimestral_pkey;
ALTER TABLE IF EXISTS ONLY public.categoria_cuenta DROP CONSTRAINT IF EXISTS categoria_cuenta_pkey;
ALTER TABLE IF EXISTS ONLY public.bodegas DROP CONSTRAINT IF EXISTS bodegas_pkey;
ALTER TABLE IF EXISTS ONLY public.bitacora DROP CONSTRAINT IF EXISTS bitacora_pkey;
ALTER TABLE IF EXISTS ONLY public.articulos DROP CONSTRAINT IF EXISTS articulos_pkey;
ALTER TABLE IF EXISTS ONLY drizzle.__drizzle_migrations DROP CONSTRAINT IF EXISTS __drizzle_migrations_pkey;
ALTER TABLE IF EXISTS public.solicitud_lineas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.series_documento ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sap_post_lines ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.parametros ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.matriz_contable ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.matriz_aprobacion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.homologacion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.existencias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ejecucion_presupuesto ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.consumo_trimestral ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bodegas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bitacora ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.articulos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS drizzle.__drizzle_migrations ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.tipos_documento;
DROP TABLE IF EXISTS public.solicitudes;
DROP SEQUENCE IF EXISTS public.solicitud_lineas_id_seq;
DROP TABLE IF EXISTS public.solicitud_lineas;
DROP SEQUENCE IF EXISTS public.series_documento_id_seq;
DROP TABLE IF EXISTS public.series_documento;
DROP TABLE IF EXISTS public.sequences;
DROP SEQUENCE IF EXISTS public.sap_post_lines_id_seq;
DROP TABLE IF EXISTS public.sap_post_lines;
DROP SEQUENCE IF EXISTS public.parametros_id_seq;
DROP TABLE IF EXISTS public.parametros;
DROP TABLE IF EXISTS public.niveles_aprobacion;
DROP SEQUENCE IF EXISTS public.matriz_contable_id_seq;
DROP TABLE IF EXISTS public.matriz_contable;
DROP SEQUENCE IF EXISTS public.matriz_aprobacion_id_seq;
DROP TABLE IF EXISTS public.matriz_aprobacion;
DROP SEQUENCE IF EXISTS public.homologacion_id_seq;
DROP TABLE IF EXISTS public.homologacion;
DROP SEQUENCE IF EXISTS public.existencias_id_seq;
DROP TABLE IF EXISTS public.existencias;
DROP TABLE IF EXISTS public.empresas;
DROP SEQUENCE IF EXISTS public.ejecucion_presupuesto_id_seq;
DROP TABLE IF EXISTS public.ejecucion_presupuesto;
DROP TABLE IF EXISTS public.cuentas_contables;
DROP SEQUENCE IF EXISTS public.consumo_trimestral_id_seq;
DROP TABLE IF EXISTS public.consumo_trimestral;
DROP TABLE IF EXISTS public.categoria_cuenta;
DROP SEQUENCE IF EXISTS public.bodegas_id_seq;
DROP TABLE IF EXISTS public.bodegas;
DROP SEQUENCE IF EXISTS public.bitacora_id_seq;
DROP TABLE IF EXISTS public.bitacora;
DROP SEQUENCE IF EXISTS public.articulos_id_seq;
DROP TABLE IF EXISTS public.articulos;
DROP SEQUENCE IF EXISTS drizzle.__drizzle_migrations_id_seq;
DROP TABLE IF EXISTS drizzle.__drizzle_migrations;
DROP SCHEMA IF EXISTS drizzle;
--
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA drizzle;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: -
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: -
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: -
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- Name: articulos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.articulos (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    item_code character varying(64) NOT NULL,
    item_name text NOT NULL,
    categoria text NOT NULL,
    area text,
    abc character varying(8),
    precio_prom double precision DEFAULT 0 NOT NULL,
    lead_time_dias integer DEFAULT 15 NOT NULL,
    codigo_corporativo character varying(64)
);


--
-- Name: articulos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.articulos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articulos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.articulos_id_seq OWNED BY public.articulos.id;


--
-- Name: bitacora; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bitacora (
    id integer NOT NULL,
    solicitud_id character varying(32) NOT NULL,
    ts timestamp with time zone DEFAULT now() NOT NULL,
    user_name text NOT NULL,
    accion text NOT NULL,
    detalle text DEFAULT ''::text
);


--
-- Name: bitacora_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bitacora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bitacora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bitacora_id_seq OWNED BY public.bitacora.id;


--
-- Name: bodegas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bodegas (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    codigo character varying(32) NOT NULL,
    nombre text NOT NULL,
    warehouse_code character varying(32) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: bodegas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bodegas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bodegas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bodegas_id_seq OWNED BY public.bodegas.id;


--
-- Name: categoria_cuenta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria_cuenta (
    categoria text NOT NULL,
    cuenta6 character varying(32),
    cuenta7 character varying(32),
    requiere_placa boolean DEFAULT false NOT NULL,
    requiere_obra boolean DEFAULT false NOT NULL,
    nota text
);


--
-- Name: consumo_trimestral; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consumo_trimestral (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    item_code character varying(64) NOT NULL,
    t0 double precision DEFAULT 0 NOT NULL,
    t1 double precision DEFAULT 0 NOT NULL,
    t2 double precision DEFAULT 0 NOT NULL,
    t3 double precision DEFAULT 0 NOT NULL
);


--
-- Name: consumo_trimestral_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.consumo_trimestral_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: consumo_trimestral_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.consumo_trimestral_id_seq OWNED BY public.consumo_trimestral.id;


--
-- Name: cuentas_contables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cuentas_contables (
    codigo character varying(32) NOT NULL,
    nombre text NOT NULL
);


--
-- Name: ejecucion_presupuesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ejecucion_presupuesto (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    categoria text NOT NULL,
    periodo character varying(32),
    ejecutado double precision DEFAULT 0 NOT NULL
);


--
-- Name: ejecucion_presupuesto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ejecucion_presupuesto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ejecucion_presupuesto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ejecucion_presupuesto_id_seq OWNED BY public.ejecucion_presupuesto.id;


--
-- Name: empresas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empresas (
    codigo character varying(64) NOT NULL,
    nombre_anexo text NOT NULL,
    company_db character varying(128) DEFAULT ''::character varying NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: existencias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.existencias (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    item_code character varying(64) NOT NULL,
    existencia double precision DEFAULT 0 NOT NULL,
    en_pedido double precision DEFAULT 0 NOT NULL,
    comprometido double precision DEFAULT 0 NOT NULL
);


--
-- Name: existencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.existencias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: existencias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.existencias_id_seq OWNED BY public.existencias.id;


--
-- Name: homologacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.homologacion (
    id integer NOT NULL,
    codigo_corporativo character varying(64) NOT NULL,
    empresa character varying(64) NOT NULL,
    codigo_local character varying(64) NOT NULL,
    descripcion_local text,
    precio_prom double precision DEFAULT 0
);


--
-- Name: homologacion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.homologacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: homologacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.homologacion_id_seq OWNED BY public.homologacion.id;


--
-- Name: matriz_aprobacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matriz_aprobacion (
    id integer NOT NULL,
    regla character varying(16) NOT NULL,
    monto_desde double precision DEFAULT 0 NOT NULL,
    monto_hasta double precision DEFAULT 0 NOT NULL,
    dentro_presupuesto character varying(16) NOT NULL,
    niveles_requeridos character varying(32) NOT NULL,
    descripcion text
);


--
-- Name: matriz_aprobacion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matriz_aprobacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matriz_aprobacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matriz_aprobacion_id_seq OWNED BY public.matriz_aprobacion.id;


--
-- Name: matriz_contable; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matriz_contable (
    id integer NOT NULL,
    empresa text NOT NULL,
    cta character varying(8) NOT NULL,
    dim1 text DEFAULT ''::text NOT NULL,
    dim2 text DEFAULT ''::text NOT NULL,
    dim3 text DEFAULT ''::text NOT NULL,
    dim4 text DEFAULT ''::text NOT NULL,
    dim5 text DEFAULT ''::text NOT NULL,
    proyecto text DEFAULT ''::text NOT NULL,
    departamento text DEFAULT ''::text NOT NULL,
    subdepartamento text DEFAULT ''::text NOT NULL,
    ubicacion text DEFAULT ''::text NOT NULL,
    linea_producto text DEFAULT ''::text NOT NULL,
    producto text DEFAULT ''::text NOT NULL,
    nombre_proyecto text DEFAULT ''::text NOT NULL
);


--
-- Name: matriz_contable_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matriz_contable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matriz_contable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matriz_contable_id_seq OWNED BY public.matriz_contable.id;


--
-- Name: niveles_aprobacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.niveles_aprobacion (
    codigo character varying(8) NOT NULL,
    nombre text NOT NULL,
    orden integer NOT NULL,
    alcance character varying(16) DEFAULT 'empresa'::character varying NOT NULL,
    descripcion text DEFAULT ''::text NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: parametros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parametros (
    id integer NOT NULL,
    z double precision NOT NULL,
    meses double precision NOT NULL,
    lt_std double precision NOT NULL,
    ajuste double precision DEFAULT 0 NOT NULL,
    margen double precision DEFAULT 0 NOT NULL,
    periodo character varying(32) NOT NULL,
    dias double precision NOT NULL
);


--
-- Name: parametros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parametros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parametros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parametros_id_seq OWNED BY public.parametros.id;


--
-- Name: sap_post_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sap_post_lines (
    id integer NOT NULL,
    doc_num character varying(64) NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    empresa character varying(64) DEFAULT ''::character varying NOT NULL,
    bodega_codigo character varying(32) DEFAULT ''::character varying NOT NULL,
    tipo_documento character varying(32) DEFAULT ''::character varying NOT NULL,
    numero_documento character varying(64) DEFAULT ''::character varying NOT NULL,
    company_db character varying(128) DEFAULT ''::character varying NOT NULL
);


--
-- Name: sap_post_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sap_post_lines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sap_post_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sap_post_lines_id_seq OWNED BY public.sap_post_lines.id;


--
-- Name: sequences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sequences (
    name character varying(32) NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


--
-- Name: series_documento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.series_documento (
    id integer NOT NULL,
    empresa character varying(64) NOT NULL,
    tipo_codigo character varying(32) NOT NULL,
    bodega_codigo character varying(32) DEFAULT ''::character varying NOT NULL,
    prefijo character varying(32) DEFAULT ''::character varying NOT NULL,
    siguiente integer DEFAULT 1 NOT NULL,
    digitos integer DEFAULT 5 NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: series_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.series_documento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: series_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.series_documento_id_seq OWNED BY public.series_documento.id;


--
-- Name: solicitud_lineas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solicitud_lineas (
    id integer NOT NULL,
    solicitud_id character varying(32) NOT NULL,
    empresa character varying(64) NOT NULL,
    item_code character varying(64) NOT NULL,
    item_name text NOT NULL,
    categoria text NOT NULL,
    qty double precision NOT NULL,
    price double precision NOT NULL,
    total double precision NOT NULL,
    sug double precision DEFAULT 0 NOT NULL,
    alerta character varying(32) NOT NULL,
    justificacion text DEFAULT ''::text,
    disp double precision DEFAULT 0,
    min double precision DEFAULT 0,
    max double precision DEFAULT 0,
    contable jsonb NOT NULL
);


--
-- Name: solicitud_lineas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solicitud_lineas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solicitud_lineas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solicitud_lineas_id_seq OWNED BY public.solicitud_lineas.id;


--
-- Name: solicitudes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solicitudes (
    id character varying(32) NOT NULL,
    empresa character varying(64) NOT NULL,
    solicitante_id character varying(64) NOT NULL,
    solicitante_nombre text NOT NULL,
    estado character varying(32) NOT NULL,
    total double precision DEFAULT 0 NOT NULL,
    dentro_presupuesto boolean DEFAULT true NOT NULL,
    ruta jsonb NOT NULL,
    bud jsonb NOT NULL,
    required_date character varying(16) NOT NULL,
    comentario text DEFAULT ''::text,
    doc_num character varying(64),
    created_at timestamp with time zone DEFAULT now(),
    approved_at timestamp with time zone,
    sent_at timestamp with time zone,
    bodega_codigo character varying(32) DEFAULT ''::character varying NOT NULL,
    tipo_documento character varying(32) DEFAULT 'SC'::character varying NOT NULL,
    sap_doc_num character varying(64),
    company_db character varying(128) DEFAULT ''::character varying NOT NULL
);


--
-- Name: tipos_documento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipos_documento (
    codigo character varying(32) NOT NULL,
    nombre text NOT NULL,
    objeto_sap character varying(64) DEFAULT 'PurchaseRequests'::character varying NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id character varying(64) NOT NULL,
    email character varying(256) NOT NULL,
    nombre text NOT NULL,
    rol character varying(32) NOT NULL,
    empresa character varying(64) NOT NULL,
    puesto text,
    azure_oid character varying(128),
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: -
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- Name: articulos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articulos ALTER COLUMN id SET DEFAULT nextval('public.articulos_id_seq'::regclass);


--
-- Name: bitacora id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bitacora ALTER COLUMN id SET DEFAULT nextval('public.bitacora_id_seq'::regclass);


--
-- Name: bodegas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bodegas ALTER COLUMN id SET DEFAULT nextval('public.bodegas_id_seq'::regclass);


--
-- Name: consumo_trimestral id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_trimestral ALTER COLUMN id SET DEFAULT nextval('public.consumo_trimestral_id_seq'::regclass);


--
-- Name: ejecucion_presupuesto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ejecucion_presupuesto ALTER COLUMN id SET DEFAULT nextval('public.ejecucion_presupuesto_id_seq'::regclass);


--
-- Name: existencias id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existencias ALTER COLUMN id SET DEFAULT nextval('public.existencias_id_seq'::regclass);


--
-- Name: homologacion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.homologacion ALTER COLUMN id SET DEFAULT nextval('public.homologacion_id_seq'::regclass);


--
-- Name: matriz_aprobacion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriz_aprobacion ALTER COLUMN id SET DEFAULT nextval('public.matriz_aprobacion_id_seq'::regclass);


--
-- Name: matriz_contable id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriz_contable ALTER COLUMN id SET DEFAULT nextval('public.matriz_contable_id_seq'::regclass);


--
-- Name: parametros id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parametros ALTER COLUMN id SET DEFAULT nextval('public.parametros_id_seq'::regclass);


--
-- Name: sap_post_lines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sap_post_lines ALTER COLUMN id SET DEFAULT nextval('public.sap_post_lines_id_seq'::regclass);


--
-- Name: series_documento id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_documento ALTER COLUMN id SET DEFAULT nextval('public.series_documento_id_seq'::regclass);


--
-- Name: solicitud_lineas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solicitud_lineas ALTER COLUMN id SET DEFAULT nextval('public.solicitud_lineas_id_seq'::regclass);


--
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: -
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
1	8c1590034e18f05e2e4f4a20b9d5113ae67ec8254abae0e4dd8e0909643f775f	1730000000000
2	629b1f49620925426b6c5b3b6026ce3cf70fcaab283c32107b393e3aa8f5f74d	1762700000000
3	fee8b186b9c3df04cba749f4625a41986aba76846a23480f49ba683773e4072d	1762800000000
\.


--
-- Data for Name: articulos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.articulos (id, empresa, item_code, item_name, categoria, area, abc, precio_prom, lead_time_dias, codigo_corporativo) FROM stdin;
1	PALMAS	MP0201005	FRUTA DE PALMA AFRICANA	Materia prima	Producción / Planta	A	1.1823	14	CORP-00723
2	SUPREMA	MP0201002	ACEITE CRUDO DE PALMA	Materia prima	Producción / Planta	A	8.7227	19	CORP-00015
3	TASINSA	PT49400000501	ACEITE CRUDO DE PALMA	Materia prima	Producción / Planta	A	7.6014	22	CORP-00015
4	PALMAS	MA0105017	DIESEL	Combustibles y lubricantes	Flota, maquinaria y combustible	B	25.8372	28	CORP-00466
5	SUPREMA	IN0103005	ENVASE ACEITE AUREOLA PET 750 ML CON ETIQUETA	Material de empaque	Producción / Planta	B	1266.0613	20	CORP-00517
6	SUPREMA	IN0103018	ENVASE ACEITE PET 3000 ML ETIQUETA CON ASA	Material de empaque	Producción / Planta	B	4717.1967	31	CORP-00525
7	SUPREMA	IN0103008	ENVASE ACEITE AUREOLA PET CON ETIQUETA 400 ML	Material de empaque	Producción / Planta	B	1159.9441	42	CORP-00519
8	SUPREMA	IN0103032	ENVASE ACEITE COSTEÑO 750 ML CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	1151.3371	39	CORP-00522
9	PALMAS	MP0201009	HIDROXIDO DE SODIO AL 50 %	Materia prima	Producción / Planta	B	2.7323	14	CORP-00780
10	SUPREMA	MA0105010	DIESEL	Combustibles y lubricantes	Flota, maquinaria y combustible	B	26.6446	20	CORP-00466
11	SUPREMA	IN0102035	CAJA MANTECA PANIFICACION Y FRITURAS 27 LB	Material de empaque	Producción / Planta	B	3302.9252	19	CORP-00221
12	SUPREMA	IN0106012	TAPA AMARILLA 180 ML, 450 ML, 750 ML, 900 ML	Material de empaque	Producción / Planta	B	113.6627	26	CORP-01159
13	SUPREMA	IN0102076	CAJA ACEITE AUREOLA 12 X 750 ML(NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	2657.6054	16	CORP-00194
14	SUPREMA	IN0103019	ENVASE ACEITE PLASTICO DESECHABLE 5 GL	Material de empaque	Producción / Planta	B	11.4379	40	CORP-00527
15	PALMAS	IN0102020	CAJA INVICTO GENERICO 400 GRAMOS 18 UNIDADES	Material de empaque	Producción / Planta	B	2077.4531	21	CORP-00214
16	SUPREMA	IN0102078	CAJA ACEITE AUREOLA PET 6X3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	4489.6698	19	CORP-00200
17	PALMAS	IN0202043	FRAGANCIA SUPERJABONSON 30.26541 IBERCHEM	Insumos químicos de producción	Producción / Planta	B	96.39	50	CORP-00721
18	PALMAS	IN0202004	ACIDO DODECILBENCENOSULFONICO	Insumos químicos de producción	Producción / Planta	B	20.0119	16	CORP-00039
19	PALMAS	IN0202072	FRAGANCIA NEW FLORAL EXPLOSION T13013335 TAKASAGO	Insumos químicos de producción	Producción / Planta	B	72.4347	43	CORP-00719
20	SUPREMA	IN0106010	TAPA AMARILLA ENVASE PET 3000 ML	Material de empaque	Producción / Planta	B	310.35	31	CORP-01162
21	SUPREMA	IN0201036	TIERRA DE BLANQUEO SEPIGEL NATURAL M-100 UF	Insumos químicos de producción	Producción / Planta	B	4.3818	34	CORP-01209
22	SUPREMA	IN0101003	BOLSA PLASTICA MANTECA 27 Y 25 LB	Material de empaque	Producción / Planta	B	796.2188	17	CORP-00127
23	GRS	IN0101009	BOLSA DE 350GRS. SAL MARCA RAMA BLANCA	Material de empaque	Producción / Planta	B	0.0574	33	CORP-00125
24	SUPREMA	IN0106023	TAPA VERDE   400 ML, 750 ML, 800 ML, 900 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	91.4045	42	CORP-01169
25	SUPREMA	IN0102069	CAJA ACEITE COSTEÑO DE 12 x 750 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	2657.2271	14	CORP-00207
26	SUPREMA	IN0105006	NYLON TIPO STRECH DE 18 DE ANCHO * 1200 PIE DE LARGO FLEJE DE CAJAS	Material de empaque	Producción / Planta	C	22.0868	42	CORP-00953
27	SUPREMA	IN0102075	CAJA ACEITE AUREOLA 24 x 400 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2887.7136	15	CORP-00196
28	SUPREMA	IN0102074	CAJA ACEITE AUREOLA 12X800 ML(NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2703.4224	19	CORP-00195
29	SUPREMA	IN0102026	CAJA MANTECA COSTEÑA 100% VEGETAL 50 LB	Material de empaque	Producción / Planta	C	5163.1971	16	CORP-00219
30	SUPREMA	IN0102034	CAJA MANTECA PANIFICACION Y FRITURAS 25 LB	Material de empaque	Producción / Planta	C	3244.1464	18	CORP-00220
31	PALMAS	MA0105007	ACEITE SAE No. 15W-40  CI-4 PLUS/SL  (GLS) (TONEL)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	79.6765	11	CORP-00025
32	SUPREMA	IN0106002	TAPA VERDE CANECAS DESECHABLE 5 GL	Material de empaque	Producción / Planta	C	1.1769	58	CORP-01170
33	SUPREMA	MA0105019	GAS PROPANO	Combustibles y lubricantes	Flota, maquinaria y combustible	C	22.7679	21	CORP-00737
34	PALMAS	IN0102021	CAJA JABONSON GENERICO 385 GRAMOS 18 UNIDADES	Material de empaque	Producción / Planta	C	2048.1509	12	CORP-00215
35	PALMAS	MA0105018	GASOLINA REGULAR - SUPER	Combustibles y lubricantes	Flota, maquinaria y combustible	C	24.7	15	CORP-00744
36	SUPREMA	IN0102060	CAJA ACEITE  SIRVASE  12X770ML	Material de empaque	Producción / Planta	C	2732.1429	8	CORP-00211
37	SUPREMA	IN0101004	BOLSA PLASTICA MANTECA 50 LB	Material de empaque	Producción / Planta	C	1177.1964	16	CORP-00128
38	SUPREMA	IN0201037	NITROGENO LIQUIDO	Insumos químicos de producción	Producción / Planta	C	11.09	50	CORP-00946
39	SUPREMA	IN0102070	CAJA ACEITE COSTEÑO DE 5 GL (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4097.4313	21	CORP-00208
40	GRS	IN0101010	BOLSA DE ARROBA 13 X 23	Material de empaque	Producción / Planta	C	0.4216	30	CORP-00126
41	GRS	IN0502001	YODO CAL	Insumos químicos de producción	Producción / Planta	C	32.4675	10	CORP-01394
42	SUPREMA	IN0105002	CINTA ADHESIVA DE 2PULG POR 1,500YDAS	Material de empaque	Producción / Planta	C	100	14	CORP-00312
43	PALMAS	IN0102003	CAJA LLAVE 200 GRAMOS /30 UNIDAD	Material de empaque	Producción / Planta	C	2308.8656	14	CORP-00217
44	SUPREMA	IN0102068	CAJA ACEITE COSTEÑO 6 x 3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4170.805	17	CORP-00206
45	PALMAS	MA0104077	LAMINA LISA H.N. 1/4 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	997.2283	20	CORP-00838
46	PALMAS	IN0202001	ACEITE MINERAL	Combustibles y lubricantes	Flota, maquinaria y combustible	C	14.4515	16	CORP-00020
47	PALMAS	MA0105019	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	19.6647	13	CORP-00748
48	SUPREMA	IN0102066	CAJA ACEITE COSTEÑO 24 x 400 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	3011.4484	17	CORP-00204
49	PALMAS	MA0107016	ELECTRODO INOX. UTP 312-16 1/8"	Herramientas	Bodega central (stock)	C	7.1896	14	CORP-00496
50	PALMAS	IN0202020	EDTA - TETRASODICO	Insumos químicos de producción	Producción / Planta	C	16.7073	12	CORP-00489
1424	SUPREMA	08-0291-02	SIERRA CIRCULAR	Herramientas	Mantenimiento industrial	C	636.1161	10	CORP-01109
51	PALMAS	MA0107011	ELECTRODO 6011 DE 1/8" (500 LIBRAS)	Herramientas	Bodega central (stock)	C	1.2523	11	CORP-00491
52	PALMAS	MA0107017	ELECTRODO INOX. UTP 312-16 3/32"	Herramientas	Bodega central (stock)	C	4.5072	13	CORP-00497
53	PALMAS	MA0107005	ELECTRODO 7018 DE 1/8 (575 LB)	Herramientas	Bodega central (stock)	C	1.6754	11	CORP-00492
54	PALMAS	MA0107019	CILINDRO OXIGENO INDUSTRIAL	Repuestos y componentes mecánicos	Bodega central (stock)	C	184.5468	16	CORP-00305
55	PALMAS	IN0105002	CINTA TRANSPARENTE DE 2	Material de empaque	Producción / Planta	C	3.5546	12	CORP-00327
56	PALMAS	IN0105004	FLEJE STRECH FILM SF021	Material de empaque	Producción / Planta	C	19.8968	11	CORP-00674
57	PALMAS	MA0101022	GUANTES CUERO MEDIA MANGA, ENGUATADOS	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	43.2277	16	CORP-00757
58	PALMAS	RE0304036	POMO SILICONE GRIS LOCTITE SI 5699 70 ML	Ferretería general	Bodega central (stock)	C	37.3214	15	CORP-01012
59	PALMAS	MA0107020	CILINDRO ACETILENO	Repuestos y componentes mecánicos	Bodega central (stock)	C	417.9659	19	CORP-00300
60	PALMAS	RE0316007	DISCO PULIR 1/4" X 7/8" X 9"	Herramientas	Bodega central (stock)	C	45.9967	14	CORP-00483
61	PALMAS	MA0107015	DISCO CORTAR INOXIDABLE 1/16 X 7/8 X 7"	Ferretería general	Bodega central (stock)	C	18.5928	18	CORP-00472
62	PALMAS	RE0201020	ROLLO CINTA # 33	Ferretería general	Bodega central (stock)	C	40.7421	15	CORP-00324
63	PALMAS	IN0104001	ETIQUETA BULTO No. 4 VERDE	Material de empaque	Producción / Planta	C	0.1488	10	CORP-00560
64	PALMAS	MA0108011	TORNILLO FAJA 1/4 X 1 CABEZA PLANA	Repuestos y componentes mecánicos	Bodega central (stock)	C	4.7857	19	CORP-01246
65	SUPREMA	RE0302028	COJINETE 6207 ZZ/C3 SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	70.8361	16	CORP-00358
66	TASINSA	PT49400000502	ACEITE CRUDO DE SOYA	Materia prima	Producción / Planta	A	8.4933	44	CORP-00016
67	SUPREMA	PT09251005108	ACEITE DE SOYA RBD	Materia prima	Producción / Planta	A	10.8311	11	CORP-00017
68	SUPREMA	IN0103006	ENVASE ACEITE AUREOLA PET 800 ML CON ETIQUETA	Material de empaque	Producción / Planta	B	1209.7246	43	CORP-00518
69	SUPREMA	IN0103003	ENVASE ACEITE 3000 ML SIN ETIQUETA	Material de empaque	Producción / Planta	B	4.9639	50	CORP-00513
70	SUPREMA	IN0103027	ENVASE ACEITE SIRVASE 770ML CON ETIQUETA	Material de empaque	Producción / Planta	B	1306.4059	40	CORP-00530
71	SUPREMA	IN0103037	CANECA VERDE ESTIBABLE 5 GL	Material de empaque	Producción / Planta	B	18.6021	77	CORP-00247
72	SUPREMA	IN0201016	PURE FLO B80	Insumos químicos de producción	Producción / Planta	B	6.4303	59	CORP-01023
73	SUPREMA	IN0103034	ENVASE ACEITE COSTEÑO PET CON ETIQUETA 400 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	979.2857	55	CORP-00524
74	SAN ANTONIO	IN0305005	FORMULA 3	Fertilizantes y agroquímicos	Agrícola (fincas)	B	193.1528	38	CORP-00689
75	SAN ANTONIO	IN0305009	FORMULA 4	Fertilizantes y agroquímicos	Agrícola (fincas)	B	222.9405	53	CORP-00691
76	SUPREMA	IN0103033	ENVASE ACEITE COSTEÑO 800 ML CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	1081.1593	51	CORP-00523
77	PALMAS	IN0202056	FRAGANCIA PINK SOAP TAKASAGO	Insumos químicos de producción	Producción / Planta	B	115.3253	43	CORP-00720
78	SUPREMA	IN0103038	CANECA ESTIBABLE AMARILLA 5 GL (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	19.0348	91	CORP-00243
79	PALMAS	IN0202019	DIOXIDO DE TITANIO	Insumos químicos de producción	Producción / Planta	B	33.9288	16	CORP-00469
80	SAN ANTONIO	IN0305007	FORMULA 6	Fertilizantes y agroquímicos	Agrícola (fincas)	B	221.6691	44	CORP-00698
81	PALMAS	IN0202085	FRAGANCIA BOM INTENSE	Insumos químicos de producción	Producción / Planta	B	220.0394	30	CORP-00714
82	SUPREMA	IN0103004	ENVASE ACEITE AUREOLA PET 1500 ML SIN ETIQUETA	Material de empaque	Producción / Planta	B	3290.9606	27	CORP-00516
83	SUPREMA	IN0103047	CANECA NATURAL COSTEÑO  ESTIBABLE  20 LITROS	Ferretería general	Mantenimiento industrial	B	19.7028	39	CORP-00245
84	SUPREMA	IN0102077	ETIQUETA  ACEITE AUREOLA 3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	B	304.0346	40	CORP-00557
85	SUPREMA	IN0201026	PALSGAARD 1388	Materia prima	Producción / Planta	B	254.9874	14	CORP-00965
86	PALMAS	IN0202081	FRAGANCIA AMIDALA FRESH NP10521 APAESA	Insumos químicos de producción	Producción / Planta	B	97.3326	32	CORP-00712
87	SAN ANTONIO	IN0305006	FORMULA 5	Fertilizantes y agroquímicos	Agrícola (fincas)	B	220.9619	44	CORP-00694
88	SUPREMA	IN0201003	ANTIOXIDANTE ANTAC PLUS A4	Insumos químicos de producción	Producción / Planta	C	75.4545	22	CORP-00087
89	PALMAS	IN0202086	FRAGANCIA CITRON VERT MAX T13016791 TAKASAGO	Insumos químicos de producción	Producción / Planta	C	107.1	40	CORP-00715
90	SUPREMA	IN0201014	PALSGAARD 6111	Materia prima	Producción / Planta	C	271.5477	14	CORP-00966
91	SUPREMA	IN0201001	ACIDO CITRICO	Insumos químicos de producción	Producción / Planta	C	9.0242	38	CORP-00038
92	SUPREMA	IN0103040	ENVASE ACEITE AUREOLA  150 ML CON ETIQUETA	Material de empaque	Producción / Planta	C	934.1953	62	CORP-00515
93	SUPREMA	IN0103043	CANECA AMARILLA ESTIBABLE 10 LITROS	Ferretería general	Mantenimiento industrial	C	12.3448	33	CORP-00242
94	SUPREMA	IN0103042	CANECA VERDE ESTIBABLE 10 LITROS	Ferretería general	Mantenimiento industrial	C	12.3447	33	CORP-00246
95	PALMAS	IN0202083	FARMAQUEST SGA LIQUIDO	Materia prima	Producción / Planta	C	14.0022	16	CORP-00606
96	SUPREMA	IN0104019	ETIQUETA  ACEITE COSTEÑO 3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	319.2824	32	CORP-00558
97	PALMAS	IN0202069	FRAGANCIA FLORES NATURALES MAX T13012428 TAKASAGO	Insumos químicos de producción	Producción / Planta	C	117.7243	37	CORP-00717
98	PALMAS	IN0202048	SILICATO DE SODIO AL 50%	Insumos químicos de producción	Producción / Planta	C	3.3983	17	CORP-01115
99	SUPREMA	IN0102036	CAJA MANTECA PANIFICACION Y FRITURAS 50 LB	Material de empaque	Producción / Planta	C	5054.4643	17	CORP-00222
100	SUPREMA	IN0106019	TAPA ROJA PARA ENVASE SIRVASE 770ML	Material de empaque	Producción / Planta	C	111.9146	35	CORP-01166
101	SUPREMA	MA0106038	YODO WIJS	Insumos químicos de producción	Calidad y laboratorio	C	1154.45	31	CORP-01395
102	PALMAS	RE0302019	COJINETE No. 29420-E  (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	6920.7143	22	CORP-00382
103	PALMAS	IN0202068	FRAGANCIA ARMONIA BLANCA MAX T13012427 TAKASAGO	Insumos químicos de producción	Producción / Planta	C	122.351	44	CORP-00713
104	SUPREMA	IN0102079	CAJA ACEITE AUREOLA DE 5 GL (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4101.9447	18	CORP-00199
105	PALMAS	IN0202009	COLORANTE AMARILLO DIBARPRINT DB	Insumos químicos de producción	Producción / Planta	C	105.9587	18	CORP-00421
106	PALMAS	IN0105006	SACO POLIPROPILENO 24 X 42 NUEVOS CON LOGOTIPO LAS PALMAS	Material de empaque	Producción / Planta	C	1.9554	19	CORP-01083
107	SUPREMA	IN0104020	ETIQUETA ACEITE AUREOLA 1500 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	244.1354	27	CORP-00556
108	SUPREMA	IN0102085	CAJA MANTECA TROPICANA 50 LB	Material de empaque	Producción / Planta	C	4978.6473	14	CORP-00225
109	SUPREMA	IN0201012	PALSGAARD 0291	Materia prima	Producción / Planta	C	222.8237	14	CORP-00964
110	SUPREMA	IN0106003	TAPA VERDE 3000 ML	Material de empaque	Producción / Planta	C	0.3544	49	CORP-01168
111	PALMAS	RE0302016	COJINETE No. 22226-E C3/W33 (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	4909.3527	20	CORP-00378
112	PALMAS	IN0202033	FRAGANCIA FRUTAMAX HP06112201 IBERCHEM	Insumos químicos de producción	Producción / Planta	C	13.2	53	CORP-00718
113	PALMAS	IN0202007	CARBONATO DE SODIO	Insumos químicos de producción	Producción / Planta	C	3.592	18	CORP-00252
114	SUPREMA	MA0110008	POLIMIX CF01 (POLICLORURO DE ALUMINIO) DICIEMBRE	Ferretería general	Mantenimiento industrial	C	9.8214	84	CORP-01001
115	PALMAS	RE0302018	COJINETE No. 29320-E C3/W33 (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	5165.1786	19	CORP-00381
116	SUPREMA	RE0317097	SOLVENTE 112 (DICIEMBRE)	Construcción y obra civil	Infraestructura y obra civil	C	396.7991	53	CORP-01127
117	PALMAS	RE0101087	FILTROS PARA DIESEL # RE-522878 = P551422 DONALDSON	Repuestos y componentes mecánicos	Bodega central (stock)	C	433.8393	14	CORP-00671
118	SUPREMA	IN0106024	TAPA AMARILLA CANECA ESTIBABLE 5 GL (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	1.0056	71	CORP-01161
119	SUPREMA	IN0102080	CAJA ACEITE AUREOLA PET6 X1500 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2820.6405	15	CORP-00201
120	PALMAS	RE0101084	FILTRO PARA AIRE AT-175223 = P537876 DONALDSON	Repuestos y componentes mecánicos	Bodega central (stock)	C	1333.0804	11	CORP-00654
121	SUPREMA	IN0102082	CAJA ACEITE AUREOLA 6 X 3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4143.0897	20	CORP-00198
122	SUPREMA	RE0317094	BOLSAS FILTRANTES 32 X 5 mm	Material de empaque	Producción / Planta	C	28.5714	34	CORP-00130
123	PALMAS	IN0202010	COLORANTE AZUL DIBARPRINT DB 151	Insumos químicos de producción	Producción / Planta	C	106.0674	16	CORP-00422
124	PALMAS	RE0302015	COJINETE No. 22224-E  (RECTO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	3769.3622	16	CORP-00376
125	PALMAS	RE0302013	COJINETE No. 22220-E C3/W33 (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	2366.0714	22	CORP-00375
126	SUPREMA	RE0304150	GASKET NT50X HT-NBR (FLOW GASKET) PARA INTERCAMBIADOR KELVION NT50X CDS-10	Repuestos y componentes mecánicos	Mantenimiento industrial	C	188.7644	103	CORP-00740
127	SUPREMA	IN0201018	SABOR MANTEQUILLA	Insumos químicos de producción	Producción / Planta	C	223.1505	12	CORP-01082
128	PALMAS	RE0101086	FILTROS PARA DIESEL # RE-541922 = P551433 DONALDSON	Repuestos y componentes mecánicos	Bodega central (stock)	C	433.5536	14	CORP-00672
129	PALMAS	MA0105009	ACEITE SPIRAX HD SAE No. 85W-140 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	91.578	9	CORP-00027
130	PALMAS	MA0110007	ALKEMY WT-BI-14 (ANTI-INCRUSTANTE Y ANTICORROSIVO)	Insumos químicos de producción	Producción / Planta	C	1943.1362	20	CORP-00070
131	PALMAS	MA0104028	LAMINA LISA H.N. 5/8 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	2442.1147	13	CORP-00843
132	PALMAS	IN0202011	COLORANTE ROJO BRILLANTE DB-500%	Insumos químicos de producción	Producción / Planta	C	463.6105	40	CORP-00423
133	SUPREMA	IN0106011	TAPA AMARILLA 3000 ML	Material de empaque	Producción / Planta	C	0.3476	48	CORP-01160
134	PALMAS	MA0110008	ALKEMY W-2902 = WT-AS-16 = WT-HI-40  (GLS)	Insumos químicos de producción	Producción / Planta	C	389.6545	20	CORP-00069
135	PALMAS	MA0105027	ACEITE VALVOLINE AGMA EP6/ISO 460 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	182.6166	23	CORP-00036
136	PALMAS	IN0202070	BENTONITA CALCICA MESH 325	Materia prima	Producción / Planta	C	1.0893	30	CORP-00120
137	PALMAS	IN0102001	CAJA INVICTO 200 GRAMOS /30 UNIDAD	Material de empaque	Producción / Planta	C	2308.8656	12	CORP-00212
138	PALMAS	RE0101088	FILTROS PARA ACEITE # RE-504836 = 550779 DONALDSON	Repuestos y componentes mecánicos	Bodega central (stock)	C	261.7411	14	CORP-00669
139	PALMAS	RE0302014	COJINETE No. 22224 EK/C3 SKF  (CONICO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	4080.6786	15	CORP-00377
140	PALMAS	RE0101079	FILTROS PARA DIESEL # P-551429	Repuestos y componentes mecánicos	Bodega central (stock)	C	334.9289	15	CORP-00670
141	SUPREMA	RE0317095	DISCO DE APRIETE COLOR CAFE  (TAPONADORA BOTELLAS) Z1016-098 (SEPTIEMBRE)	Material de empaque	Producción / Planta	C	376.0204	36	CORP-00474
142	PALMAS	MA0104025	LAMINA LISA H.N. 1/2 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	1920.0893	20	CORP-00837
143	PALMAS	IN0202050	LAURIL ETER SULFATO DE SODIO	Insumos químicos de producción	Producción / Planta	C	14.924	13	CORP-00860
144	PALMAS	MA0105011	ACEITE UNO SPIRAX S4 CX 10W TO-4 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	100.0443	9	CORP-00030
145	SUPREMA	MA0105008	ACEITE UNO LUBRICANTE 15W-40	Combustibles y lubricantes	Flota, maquinaria y combustible	C	81.76	14	CORP-00029
146	PALMAS	RE0101078	FILTRO PARA AIRE P-828889	Repuestos y componentes mecánicos	Bodega central (stock)	C	641.7708	15	CORP-00656
147	SUPREMA	IN0102064	CAJA MANTECA COSTEÑA 100% VEGETAL 27 LB	Material de empaque	Producción / Planta	C	3385.808	13	CORP-00218
148	SUPREMA	RE0301029	REFRIGERANTE R-438A MARCA DUPONT ISCEON MO99DE (CILINDRO DE 25 LIBRAS)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1502.7237	29	CORP-01037
149	PALMAS	MA0105013	ACEITE UNO THO OIL ISO 150 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	88.5076	12	CORP-00033
150	PALMAS	RE0302096	COJINETE No. 22219 EK  (CON MANGUITO FIJACION EJE 85 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	2329.4792	16	CORP-00374
151	PALMAS	MA0105016	DESENGRASANTE REN BALK (GLS)	Limpieza e higiene	Servicios generales y limpieza	C	189.7321	23	CORP-00460
152	PALMAS	MA0104027	LAMINA LISA H.N. 3/8 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	1508.8085	21	CORP-00842
153	SUPREMA	MA0110014	SPRAY PENETROX (DICIEMBRE)	Ferretería general	Mantenimiento industrial	C	143.3756	70	CORP-01141
154	PALMAS	RE0306006	CANGILON PLASTICO 5 X 7 ELEVADOR SILO SECADOR (CC07X5 P G STD)	Repuestos y componentes mecánicos	Bodega central (stock)	C	46.2151	18	CORP-00248
155	PALMAS	RE0101081	FILTRO PARA TRAMPA DE AGUA TY 15193	Repuestos y componentes mecánicos	Bodega central (stock)	C	100.2713	19	CORP-00660
156	PALMAS	RE0306013	FAJA HULE Y LONA COLOR NARANJA 1/4 X 8  (RESISTENTE ACEITE Y TEMPERATURA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	36.0332	13	CORP-00566
157	PALMAS	RE0201035	DIELTRON 1 (GLS)	Insumos químicos de producción	Producción / Planta	C	533.1554	26	CORP-00465
158	PALMAS	RE0101080	FILTROS PARA ACEITE # P-551352	Repuestos y componentes mecánicos	Bodega central (stock)	C	205.4162	14	CORP-00668
159	PALMAS	RE0101085	FILTRO PARA AIRE AT-175224 = P537877 DONALDSON	Repuestos y componentes mecánicos	Bodega central (stock)	C	690.9962	13	CORP-00655
160	SUPREMA	IN0102072	CAJA PARA ACEITE COSTEÑO 12X1250 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4030.1156	16	CORP-00228
161	PALMAS	RE0103025	HUBODOMETROS No. 650-0539 CUENTA KMS.	Ferretería general	Bodega central (stock)	C	706.0399	18	CORP-00784
162	SUPREMA	IN0102065	CAJA ACEITE COSTEÑO 12X800 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2658.1246	18	CORP-00203
163	SUPREMA	IN0102084	CAJA MANTECA TROPICANA 27 LB	Material de empaque	Producción / Planta	C	3385.808	19	CORP-00224
164	PALMAS	RE0103078	BOLSA AIRE 1 TORNILLO PARA SUSPENSION	Material de empaque	Producción / Planta	C	878.869	19	CORP-00124
165	SUPREMA	RE0102014	LLANTA NEUMATICA DE TRACCION 7.50-16	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1256.4732	20	CORP-00894
166	PALMAS	RE0201019	CINTA SCOTCH No. 23 3/4 = 130C (ROLLO)	Ferretería general	Bodega central (stock)	C	135.3854	14	CORP-00322
167	SUPREMA	RE0317143	DISCO DE APRIETE COLOR AMARILLO (TAPONADORA BOTELLAS) (SEPTIEMBRE)	Material de empaque	Producción / Planta	C	375.5466	33	CORP-00473
168	SUPREMA	IN0102006	CAJA ACEITE AUREOLA 48X150 ML	Material de empaque	Producción / Planta	C	2960.0491	12	CORP-00197
169	PALMAS	MA0105020	GRASA PETROCANADA PURITY FG2 SYNTHETICS EP2 (LBS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	105.8209	15	CORP-00750
170	PALMAS	MA0104018	LAMINA ANTIDESL. H.N. 3/16 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	960.8135	24	CORP-00832
171	PALMAS	RE0101077	FILTRO PARA AIRE P-829333	Repuestos y componentes mecánicos	Bodega central (stock)	C	359.5089	16	CORP-00657
172	PALMAS	RE0103068	REFRIGERANTE RADIADOR VEHICULOS (GLS)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	58.1084	9	CORP-01038
173	PALMAS	MA0104066	VIGA H.N. TIPO C  1/4 X 2 X 6 X 20	Construcción y obra civil	Infraestructura y obra civil	C	953.125	8	CORP-01387
174	PALMAS	RE0304017	ESTOPA SINTETICA HI-TEMP GRADO ALIMENTICIO 1/2  (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	52.7929	21	CORP-00550
175	PALMAS	RE0103079	PAQUETE RESORTAJE 4 HOJAS TIPO CACHO SEMICURVO	Papelería, oficina y cómputo	Administración y oficinas	C	708.8816	19	CORP-00971
176	PALMAS	MA0108015	TORNILLO HEXAG. 1 X 10	Ferretería general	Bodega central (stock)	C	41.4341	19	CORP-01252
177	PALMAS	MA0105023	AFLOJALOTODO SPRAY (BOTE 20 ONZAS)	Ferretería general	Bodega central (stock)	C	129.2477	23	CORP-00058
178	PALMAS	RE0304043	ESTOPA SINTETICA HI-TEMP GRADO ALIMENTICIO 7/16" (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	46.7831	18	CORP-00554
179	PALMAS	MA0105003	ACEITE FLUIDO ATF (TRANSMISION AUTOMATICA) (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	80.2458	11	CORP-00018
180	PALMAS	RE0306039	CADENA 80-2 (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	139.2978	15	CORP-00188
181	PALMAS	RE0304042	ESTOPA SINTETICA HI-TEMP GRADO ALIMENTICIO 3/8" (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	35.2867	19	CORP-00552
182	SUPREMA	MA0102082	TRAMPA TERMODINAMICA DE 1	Ferretería general	Mantenimiento industrial	C	955.763	24	CORP-01287
183	PALMAS	MA0104078	LAMINA LISA H.N. 1/8 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	495.6543	20	CORP-00839
184	SUPREMA	RE0102015	LLANTA NEUMATICA DIRECCIONAL 7.50-16	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1226.5625	20	CORP-00895
185	PALMAS	MA0105012	ACEITE UNO SPIRAX S4 TXM 10W-30 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	75.0393	13	CORP-00032
186	SUPREMA	IN0201005	BETACAROTENO	Insumos químicos de producción	Producción / Planta	C	735.93	12	CORP-00122
187	PALMAS	MA0104015	HEMBRA INOX. 1/4 X 1.1/4 X 20	Ferretería general	Bodega central (stock)	C	291.1518	30	CORP-00771
188	SUPREMA	MA0105022	ACEITE CAT HYD AD 10 1UG NO. PARTE 3096932	Combustibles y lubricantes	Flota, maquinaria y combustible	C	185.9286	41	CORP-00014
189	SUPREMA	MA0105021	ACEITE 85W 140	Combustibles y lubricantes	Flota, maquinaria y combustible	C	102.1768	13	CORP-00012
190	PALMAS	RE0304059	SELLO MECANICO 1.3/4 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	311.2765	14	CORP-01096
191	PALMAS	MA0105006	ACEITE RIMULA No. SAE-50 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	82.32	9	CORP-00022
192	PALMAS	RE0309015	WIPE (BOLA 1 LBS)	Papelería, oficina y cómputo	Administración y oficinas	C	11.8819	15	CORP-01390
193	SUPREMA	MA0110007	DIELTRON 1 (MAYO)	Insumos químicos de producción	Producción / Planta	C	529.9171	21	CORP-00464
194	SUPREMA	RE0302047	COJINETE 6310 ZZ M/SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	242.2799	20	CORP-00368
195	SUPREMA	RE0302007	COJINETE 3306 - 5306 2Z/C3 SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	515.1099	18	CORP-00351
196	PALMAS	RE0201002	BARNIZ ROJO EN SPRAY (BOTE)	Construcción y obra civil	Infraestructura y obra civil	C	110.4911	12	CORP-00104
197	PALMAS	RE0316001	CEPILLO ROLLIZO 3  (LIMP. TUBERIAS)	Construcción y obra civil	Infraestructura y obra civil	C	84.8214	17	CORP-00279
198	SUPREMA	IN0105001	CINTA ADHESIVA CIERRE DE CAJAS, 2 PULGADAS DE ANCHO	Material de empaque	Producción / Planta	C	3.523	14	CORP-00311
199	PALMAS	RE0316006	DISCO PULIR 1/4" X 7/8" X 7"	Herramientas	Bodega central (stock)	C	28.1782	20	CORP-00482
200	PALMAS	RE0308049	RETENEDOR 5.375 X 6.750 X 0.500 (417554 NATIONAL)	Repuestos y componentes mecánicos	Bodega central (stock)	C	358.2931	15	CORP-01067
201	SUPREMA	MA0105006	ACEITE SAE 80W-90	Combustibles y lubricantes	Flota, maquinaria y combustible	C	101.0298	15	CORP-00024
202	PALMAS	MA0105022	GRASA COJINETE ALTA TEMPERATURA LG HP 2/0.4 SKF  (POMO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	134.5982	14	CORP-00749
203	PALMAS	RE0309013	NYLON NEGRO 60-72 ANCHO (ROLLO 100 YDS.)	Ferretería general	Bodega central (stock)	C	562.5	20	CORP-00951
204	SUPREMA	IN0201022	SORBATO DE POTASIO	Insumos químicos de producción	Producción / Planta	C	24.7778	7	CORP-01132
205	PALMAS	MA0108055	TORNILLO HEXAG. 1 X 8	Ferretería general	Mantenimiento industrial	C	35.503	15	CORP-01256
206	PALMAS	RE0304019	ESTOPA SINTETICA HI-TEMP GRADO ALIMENTICIO 5/16  (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	26.5179	14	CORP-00553
207	SUPREMA	RE0101025	FILTRO DE DIESEL WIX 33937	Repuestos y componentes mecánicos	Mantenimiento industrial	C	303.1513	27	CORP-00642
208	SAN JORGE	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Fertilizantes y agroquímicos	Agrícola (fincas)	C	93.75	43	CORP-00442
209	SUPREMA	MA0107046	CILINDRO DE OXIGENO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	218.808	6	CORP-00301
210	SUPREMA	IN0201006	CILINDRO NITROGENO GASEOSO	Insumos químicos de producción	Producción / Planta	C	206.5772	2	CORP-00304
211	PALMAS	RE0304018	ESTOPA SINTETICA HI-TEMP GRADO ALIMENTICIO 1/4  (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	17.9286	17	CORP-00551
212	PALMAS	MA0110004	TAPON PLASTICO GARRAFON 5 (GLS)	Material de empaque	Producción / Planta	C	0.8937	11	CORP-01174
213	SUPREMA	MA0105005	ACEITE SAE 20W-50	Combustibles y lubricantes	Flota, maquinaria y combustible	C	104.9105	28	CORP-00023
214	SUPREMA	RE0316007	DISCO DE CORTE 4.5 X 1/8	Herramientas	Mantenimiento industrial	C	13.3929	26	CORP-00475
215	SAN ANTONIO	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Fertilizantes y agroquímicos	Agrícola (fincas)	C	93.75	31	CORP-00442
216	PALMAS	RE0306053	FAJAS # C-105	Repuestos y componentes mecánicos	Bodega central (stock)	C	131.5035	14	CORP-00600
217	SAN JORGE	IN0302006	ADHERENTE DISAWET MAX	Fertilizantes y agroquímicos	Agrícola (fincas)	C	82.5497	19	CORP-00055
218	PALMAS	RE0302084	COJINETE No. 6309 2RS  (45 X 100 X 25 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	168.5268	20	CORP-00409
219	SUPREMA	RE0310010	SPRAY DE PINTURA COLOR AZUL	Construcción y obra civil	Infraestructura y obra civil	C	22.3214	11	CORP-01139
220	PALMAS	IN0105003	CONO DE HILO POLYALG	Ferretería general	Mantenimiento industrial	C	12.9464	12	CORP-00433
221	SUPREMA	RE0302046	COJINETE 6309 ZZ/C3 SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	160.1749	19	CORP-00366
222	SUPREMA	IN0201004	BENZOATO DE SODIO	Insumos químicos de producción	Producción / Planta	C	15.2357	7	CORP-00121
223	SUPREMA	MA0105011	GRASA UNO LUBRICANTES EP-2(CUBETA 35 LIBRAS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	709.975	13	CORP-00751
224	SAN FRANCISCO	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	7.5625	26	CORP-00773
225	PALMAS	MA0108048	TORNILLO HEXAG. 1 X 4	Ferretería general	Bodega central (stock)	C	17.932	14	CORP-01254
226	SUPREMA	RE0101024	FILTRO DE ACEITE WIX 51810	Repuestos y componentes mecánicos	Mantenimiento industrial	C	179.937	25	CORP-00631
227	PALMAS	RE0308008	RETENEDOR 130 X 160 X 12 MM. (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	131.2849	18	CORP-01056
228	SAN FRANCISCO	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Fertilizantes y agroquímicos	Agrícola (fincas)	C	93.75	50	CORP-00442
229	PALMAS	MA0108021	TORNILLO HEXAG. 3/4 X 8	Ferretería general	Mantenimiento industrial	C	17.9479	14	CORP-01263
230	PALMAS	RE0201117	BOMBILLA AHORRADORA TIPO ESPIRAL 65W.	Materiales eléctricos	Bodega central (stock)	C	49.1071	14	CORP-00145
231	PALMAS	MA0108047	TORNILLO HEXAG. 1 X 6	Ferretería general	Mantenimiento industrial	C	17.2917	15	CORP-01255
232	SAN ANTONIO	IN0301017	ADHERENTE DISAWET MAX	Fertilizantes y agroquímicos	Agrícola (fincas)	C	75.1741	17	CORP-00055
233	PALMAS	MA0108012	TORNILLO FAJA 1/4 X 1.1/2 CABEZA PLANA	Repuestos y componentes mecánicos	Bodega central (stock)	C	5.6647	18	CORP-01245
234	PALMAS	MA0108026	TORNILLO HEXAG. 5/8 X 2.1/2	Ferretería general	Mantenimiento industrial	C	4.5036	22	CORP-01269
235	PALMAS	MA0107008	VARILLA ACERO PLATA 1/8 AL 5%	Construcción y obra civil	Infraestructura y obra civil	C	30.7897	18	CORP-01377
236	PALMAS	RE0304045	PERMATEX # 1C SECADO RAPIDO (POMO 311 GRAMOS)	Ferretería general	Bodega central (stock)	C	66.5306	31	CORP-00985
237	PALMAS	RE0103059	LIQUIDO DE FRENO WAGNER	Repuestos y componentes mecánicos	Bodega central (stock)	C	53.5714	17	CORP-00890
238	SUPREMA	RE0308014	RETENEDOR 450298	Repuestos y componentes mecánicos	Mantenimiento industrial	C	90.1451	22	CORP-01065
239	SUPREMA	RE0201023	CABLE TSJ 2X14	Materiales eléctricos	Mantenimiento industrial	C	8.3125	19	CORP-00184
240	SAN FRANCISCO	IN0302005	ADHERENTE DISAWETT MAX	Fertilizantes y agroquímicos	Agrícola (fincas)	C	71.071	33	CORP-00056
241	PALMAS	RE0102010	REMALON TIP TOP  5	Repuestos y componentes mecánicos	Mantenimiento industrial	C	65.1787	17	CORP-01046
242	PALMAS	RE0306050	FAJAS # C-64	Repuestos y componentes mecánicos	Bodega central (stock)	C	87.6786	20	CORP-00602
243	PALMAS	RE0102012	REMALON TIP-TOP  4	Repuestos y componentes mecánicos	Bodega central (stock)	C	50	16	CORP-01045
244	SUPREMA	RE0101054	FILTRO DE AIRE PARA MOTOR DE COMBUSTION INTERNA MARCA HONDA	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	138.3929	29	CORP-00634
245	SUPREMA	RE0201125	TOMACORRIENTE DOBLE BTICINO	Materiales eléctricos	Mantenimiento industrial	C	25.3022	18	CORP-01213
246	SUPREMA	MA0102105	VALVULA HN 1/2 BOLA ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	71.808	25	CORP-01347
247	PALMAS	RE0310014	PINTURA EN SPRAY (BOTE)	Construcción y obra civil	Infraestructura y obra civil	C	16.3603	18	CORP-00991
248	PALMAS	RE0306020	FAJAS # B-76	Repuestos y componentes mecánicos	Bodega central (stock)	C	58.7826	19	CORP-00591
249	SUPREMA	RE0309002	BATERIA AAA	Materiales eléctricos	Mantenimiento industrial	C	13.4821	11	CORP-00118
250	PALMAS	MA0108017	TORNILLO HEXAG. 3/4 X 3.1/2	Ferretería general	Bodega central (stock)	C	8.9705	16	CORP-01258
251	SUPREMA	RE0304151	GASKET NT50X HT-NBR (HEAD GASKET) PARA INTERCAMBIADOR KELVION NT50X CDS-10	Repuestos y componentes mecánicos	Mantenimiento industrial	C	184.5079	103	CORP-00741
252	SUPREMA	RE0304003	EMPAQUE DE METAL CIRCULAR (ESPIROMETALICO) CLASE 150 DE 02	Repuestos y componentes mecánicos	Mantenimiento industrial	C	25.1464	22	CORP-00498
253	PALMAS	RE0304053	EMPAQUE ESPIROMETALICO PARA VALVULA 2 (0-150 PSI)	Repuestos y componentes mecánicos	Bodega central (stock)	C	48.022	21	CORP-00502
254	PALMAS	RE0314019	RELAY DAQCN 8 PINES, BOBINA 220V. = VASTO MY2N	Materiales eléctricos	Bodega central (stock)	C	66.9643	9	CORP-01040
255	SUPREMA	MA0109003	PEGAMENTO TANGIT 1/4 GL	Construcción y obra civil	Infraestructura y obra civil	C	149.2121	26	CORP-00984
256	SUPREMA	MA0102102	VALVULA HN 1 BOLA ROSCABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	116.9643	12	CORP-01350
257	SUPREMA	RE0309001	BATERIA AA	Materiales eléctricos	Mantenimiento industrial	C	15.5	11	CORP-00117
258	PALMAS	MA0108023	TORNILLO HEXAG. 5/8 X 3	Ferretería general	Bodega central (stock)	C	3.6255	16	CORP-01270
259	PALMAS	RE0306042	FAJAS # B-60	Repuestos y componentes mecánicos	Bodega central (stock)	C	41.6812	12	CORP-00583
260	PALMAS	MA0109001	EPOXIMIL A+B  (KIT)	Repuestos y componentes mecánicos	Bodega central (stock)	C	29.1146	22	CORP-00533
261	PALMAS	MA0109002	PEGAMENTO SUPER BONDER (POMO 3 GRAMOS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	18.9093	24	CORP-00983
262	PALMAS	MA0108052	TORNILLO HEXAG. 1/2 X 1.1/2	Ferretería general	Bodega central (stock)	C	1.9063	18	CORP-01250
263	PALMAS	RE0306024	FAJAS # B-85	Repuestos y componentes mecánicos	Mantenimiento industrial	C	64.3544	15	CORP-00595
264	SUPREMA	RE0304131	EMPAQUE ESPIROMETALICO 1-1/2 CLASE 150	Repuestos y componentes mecánicos	Mantenimiento industrial	C	15.5089	12	CORP-00501
265	PALMAS	RE0306017	FAJAS # B-57	Repuestos y componentes mecánicos	Bodega central (stock)	C	43.2341	12	CORP-00581
266	PALMAS	RE0306048	FAJAS # B-62	Repuestos y componentes mecánicos	Bodega central (stock)	C	48.1071	12	CORP-00585
267	SUPREMA	MA0108005	TORNILLO 1/2 X 2 1/2 HEXA COMPLETO	Ferretería general	Mantenimiento industrial	C	4.7489	20	CORP-01217
268	PALMAS	RE0316009	LIJA ESMERIL PARA METAL  (PLIEGO)	Herramientas	Mantenimiento industrial	C	4.5901	19	CORP-00887
269	PALMAS	RE0306059	FAJAS # B-66	Repuestos y componentes mecánicos	Bodega central (stock)	C	52.0421	14	CORP-00587
270	SUPREMA	RE0309003	LIMA TRIANGULAR ORDINARIA	Herramientas	Mantenimiento industrial	C	10.4398	25	CORP-00889
271	PALMAS	MA0108022	TORNILLO HEXAG. 3/8 X 1.1/2	Ferretería general	Bodega central (stock)	C	2.346	17	CORP-01265
272	SUPREMA	RE0316002	CEPILLO DE ALAMBRE C/MANGO DE MADERA	Construcción y obra civil	Infraestructura y obra civil	C	13.3929	19	CORP-00276
273	PALMAS	RE0103030	MANITA AIRE CABEZAL Y PIPA	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	33.7406	17	CORP-00915
274	SUPREMA	MA0108042	TORNILLO HILTING DE 5/8 X 4	Ferretería general	Mantenimiento industrial	C	11.2077	16	CORP-01279
275	SUPREMA	RE0316018	DISCO MIL HOJAS 4.5" GRANO 80	Papelería, oficina y cómputo	Administración y oficinas	C	15.4617	17	CORP-00480
276	SUPREMA	RE0201067	FLIPON SIMPLE DE 20 AMPERIOS	Materiales eléctricos	Mantenimiento industrial	C	44.898	11	CORP-00678
277	PALMAS	RE0302042	COJINETE No. 6206 2RS  (30 X 62 X 16 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	51.1161	17	CORP-00395
278	PALMAS	RE0201041	FUSIBLE PITA TIPO K (DIF. AMPERAJE)(40 AMP)	Materiales eléctricos	Bodega central (stock)	C	18.4876	16	CORP-00732
279	PALMAS	MA0108016	TORNILLO HEXAG. 1/2 X 2	Ferretería general	Bodega central (stock)	C	1.6954	16	CORP-01251
280	PALMAS	RE0306016	FAJAS # B-52	Repuestos y componentes mecánicos	Bodega central (stock)	C	41.0408	16	CORP-00578
281	SUPREMA	RE0201068	FLIPON SIMPLE DE 30 AMPERIOS	Materiales eléctricos	Mantenimiento industrial	C	46.6518	13	CORP-00679
282	PALMAS	RE0102014	REMALON TIP-TOP 3	Repuestos y componentes mecánicos	Mantenimiento industrial	C	20.893	12	CORP-01044
283	SUPREMA	MA0102017	CINCHOS PLASTICOS 12	Ferretería general	Mantenimiento industrial	C	0.3482	20	CORP-00307
284	SUPREMA	MA0110001	ATOMIZADOR PLASTICO 500 ML	Ferretería general	Mantenimiento industrial	C	14.7321	38	CORP-00096
285	PALMAS	MA0102111	VALVULA INOX 1/2 TIPO PASO RAPIDO (ROSCADA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	61.9498	66	CORP-01363
286	PALMAS	MA0108030	TORNILLO HEXAG. INOX. 1/4 X 1	Ferretería general	Bodega central (stock)	C	1.7587	15	CORP-01273
287	PALMAS	RE0302085	COJINETE No. 6205 2RS  (25 X 52 X 15 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	38.5417	22	CORP-00394
288	PALMAS	MA0108024	TORNILLO HEXAG. 5/8 X 1.1/2	Ferretería general	Bodega central (stock)	C	2.0861	15	CORP-01267
289	SUPREMA	MA0108019	TORNILLO 3/8 X 1 1/2 HEXA COMPLETOS	Ferretería general	Mantenimiento industrial	C	2.0731	19	CORP-01225
290	PALMAS	RE0304008	CINTA TEFLON 3/4 (ROLLO)	Ferretería general	Bodega central (stock)	C	2.6462	35	CORP-00326
291	SUPREMA	MA0108041	TORNILLO HILTING DE 1/2 x 4	Ferretería general	Mantenimiento industrial	C	3.1696	18	CORP-01278
292	PALMAS	RE0201129	CINCHO PLASTICO DE 6"	Ferretería general	Bodega central (stock)	C	0.1339	16	CORP-00306
293	PALMAS	RE0306036	UNION CADENA 80-1	Repuestos y componentes mecánicos	Bodega central (stock)	C	8.7345	14	CORP-01325
294	SUPREMA	MA0108039	TORNILLO HILTIN DE 3/8 X 3	Ferretería general	Mantenimiento industrial	C	1.7917	18	CORP-01276
295	SUPREMA	MA0102019	CINCHOS PLASTICOS 8	Ferretería general	Mantenimiento industrial	C	0.2188	19	CORP-00309
296	SUPREMA	MA0108040	TORNILLO HILTING 3/8 X 2	Ferretería general	Mantenimiento industrial	C	1.1925	9	CORP-01277
297	SUPREMA	MA0108015	TORNILLO 3/16 X 1 BUSCA ROSCA	Ferretería general	Mantenimiento industrial	C	0.1667	13	CORP-01223
298	PALMAS	PT09211001101	ACEITE CRUDO DE PALMA	Materia prima	Producción / Planta	B	8.7087	11	CORP-00015
299	ACACIAS	IN0305008	FORMULA 6	Fertilizantes y agroquímicos	Agrícola (fincas)	B	217.7406	57	CORP-00695
300	QUIRICA	IN0305006	FORMULA 4  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	234.008	58	CORP-00691
301	QUIRICA	IN0305008	FORMULA 6	Fertilizantes y agroquímicos	Agrícola (fincas)	B	215.6411	63	CORP-00698
302	SAN ANTONIO	IN0305017	FÓRMULA 3 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	223.8308	22	CORP-00688
303	ACACIAS	IN0305007	FORMULA 5	Fertilizantes y agroquímicos	Agrícola (fincas)	B	216.6356	55	CORP-00694
304	ACACIAS	IN0305021	FÓRMULA 6 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	223.2161	23	CORP-00697
305	SAN JORGE	IN0305005	FORMULA 3	Fertilizantes y agroquímicos	Agrícola (fincas)	B	192.1281	55	CORP-00689
306	QUIRICA	IN0305020	FÓRMULA 6 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	223.2161	35	CORP-00696
307	QUIRICA	IN0305005	FORMULA 3  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	227.0411	38	CORP-00689
308	ALFA	IN0305006	FORMULA 4  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	234.008	51	CORP-00691
309	PALMAS	04-0743-01	PRENSA DE RAQUIS #3	Repuestos y componentes mecánicos	Mantenimiento industrial	B	571646.25	15	CORP-01018
310	ACACIAS	IN0305006	FORMULA 4  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	B	234.008	51	CORP-00691
311	SAN JORGE	IN0305006	FORMULA 4	Fertilizantes y agroquímicos	Agrícola (fincas)	B	220.4852	24	CORP-00691
312	SAN ANTONIO	07-0010-05	CAMIONETA JEEP CHEROKEE 2024	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	B	264377.6027	15	CORP-00238
313	ALFA	IN0305005	FORMULA 3	Fertilizantes y agroquímicos	Agrícola (fincas)	B	218.3939	38	CORP-00689
314	QUIRICA	IN0305007	FORMULA 5	Fertilizantes y agroquímicos	Agrícola (fincas)	B	215.5842	46	CORP-00694
315	SUPREMA	IN0103041	ENVASE ACEITE PET 3000 ML ETIQUETA CON ASA VERDE	Material de empaque	Producción / Planta	B	4645.3771	30	CORP-00526
316	SAN JORGE	IN0305017	FÓRMULA 3 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8308	16	CORP-00688
317	ALFA	IN0305022	FÓRMULA 7 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	24	CORP-00701
318	ACACIAS	IN0305020	FÓRMULA 5 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.7871	23	CORP-00693
319	ALFA	IN0305008	FORMULA 6	Fertilizantes y agroquímicos	Agrícola (fincas)	C	218.7763	57	CORP-00695
320	ACACIAS	IN0305005	FORMULA 3  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	227.0411	35	CORP-00689
321	ALFA	IN0305009	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.7848	52	CORP-00699
322	PALMAS	07-0139-01	CAMION DE VOLTEO CASCADA 116 C0-840CDF	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	343750	15	CORP-00236
323	QUIRICA	IN0305019	FÓRMULA 5 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.7871	21	CORP-00692
324	GRS	MA0109002	NYLON NEGRO OLESAL PRIME 120X328'X6	Ferretería general	Mantenimiento industrial	C	2098.7723	51	CORP-00952
325	QUIRICA	IN0305021	FÓRMULA 7 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	35	CORP-00700
326	PALMAS	07-0131-01	CABEZAL MARCA FREIGHTLINER CASCADIA MODELO 2019 PLACAS C-153CBJ (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	272321.4286	90	CORP-00177
327	QUIRICA	IN0305009	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.7848	64	CORP-00699
328	SUPREMA	07-0092-02	VEHICULO	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	264267.8571	19	CORP-01380
329	PALMAS	RE0317020	TUBO DE ACERO AL CCARBON DE 10" X 1/4" X 10 PIES, CON COPLA DE HIERRO	Construcción y obra civil	Flota, maquinaria y combustible	C	8348.2143	101	CORP-01293
330	SUPREMA	IN0103049	ENVASE ACEITE PRIMOR 700ML PET CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	1199.8888	15	CORP-00529
331	SAN ANTONIO	IN0305021	FÓRMULA 7 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	24	CORP-00701
332	PALMAS	RE0314044	PRESS BODY P/1542	Repuestos y componentes mecánicos	Mantenimiento industrial	C	52207.6654	15	CORP-01019
333	SAN FRANCISCO	IN0305009	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	239.7816	29	CORP-00699
334	SAN JORGE	IN0305014	FORMULA 9  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	199.8221	38	CORP-00708
335	ALFA	IN0305021	FÓRMULA 6 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.2161	24	CORP-00697
336	PALMAS	IN0202082	FRAGANCIA CITRON VERT PALM LX APAESA	Insumos químicos de producción	Producción / Planta	C	88.7946	36	CORP-00716
337	SAN JORGE	IN0305008	FORMULA 6  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	222.2598	37	CORP-00698
338	SUPREMA	07-0093-02	CAMION ISUZU	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	193750	17	CORP-00237
339	SAN ANTONIO	IN0305008	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.5035	43	CORP-00699
340	SAN FRANCISCO	IN0305005	FORMULA 3	Fertilizantes y agroquímicos	Agrícola (fincas)	C	196.7863	43	CORP-00689
341	SAN ANTONIO	IN0305016	FÓRMULA 2 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	221.4402	20	CORP-00685
342	SUPREMA	IN0103025	ENVASE AUREOLA 1250ML C/ETIQUETA	Material de empaque	Producción / Planta	C	2273.9625	51	CORP-00531
343	SUPREMA	IN0103024	ENVASE CON ETIQUETA COSTEÑA 1250 ML	Material de empaque	Producción / Planta	C	2273.9625	68	CORP-00532
344	SUPREMA	IN0103050	ENVASE ACEITE  PRIMOR 3000 ML ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4.7857	15	CORP-00528
345	QUIRICA	IN0305016	FÓRMULA 2 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	221.4402	27	CORP-00684
346	SAN ANTONIO	IN0305018	FÓRMULA 4 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	21	CORP-00690
347	SAN ANTONIO	IN0305020	FÓRMULA 6 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.2161	20	CORP-00697
348	PALMAS	IN0202024	LAUNDROSIL 5KSM 414 AZUL 1.4 MM	Materia prima	Producción / Planta	C	10.488	49	CORP-00859
349	ALFA	IN0305007	FORMULA 5	Fertilizantes y agroquímicos	Agrícola (fincas)	C	217.3082	46	CORP-00694
350	SAN FRANCISCO	IN0305004	FORMULA 2  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	197.9437	23	CORP-00686
351	SAN JORGE	IN0305007	FORMULA 5  (SACO 50 KILOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	225.1969	42	CORP-00694
352	ALFA	IN0305016	FÓRMULA 1 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	216.7955	22	CORP-00681
353	ALFA	IN0305014	FORMULA 8	Fertilizantes y agroquímicos	Agrícola (fincas)	C	197.4434	42	CORP-00705
354	SAN FRANCISCO	IN0305006	FORMULA 4	Fertilizantes y agroquímicos	Agrícola (fincas)	C	234.008	25	CORP-00691
355	PALMAS	RE0311014	ROTOR (STAR BOWL) STORK HSC6000	Repuestos y componentes mecánicos	Mantenimiento industrial	C	126896.67	15	CORP-01079
356	SAN JORGE	IN0305021	FÓRMULA 7 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	16	CORP-00701
357	SAN JORGE	IN0305009	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.7848	55	CORP-00699
358	SAN ANTONIO	IN0305004	FORMULA 2	Fertilizantes y agroquímicos	Agrícola (fincas)	C	167.4121	51	CORP-00683
359	PALMAS	RE0317024	ARAÑA DE BRONCE DE 10" X 1-1/2" CON BUJE NEOPRENO	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	3166.0232	101	CORP-00088
360	QUIRICA	IN0305004	FORMULA 2	Fertilizantes y agroquímicos	Agrícola (fincas)	C	167.4121	29	CORP-00683
361	SAN FRANCISCO	IN0305008	FORMULA 6	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.4433	46	CORP-00695
362	PALMAS	RE0317022	EJES DE ACERO INOX. 416 DE 1-1/2" X 10 PIES	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5285.7143	85	CORP-00490
363	SUPREMA	IN0103045	ENVASE ACEITE COSTEÑO 140 ML CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	723.2143	11	CORP-00521
364	SAN FRANCISCO	IN0305017	FÓRMULA 3 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.0357	27	CORP-00687
365	ALFA	IN0305003	FORMULA 1	Fertilizantes y agroquímicos	Agrícola (fincas)	C	178.2723	33	CORP-00680
366	PALMAS	IN0101053	TERMO INVICTO 400 GRS 18 UN COLOR NATURAL	Material de empaque	Producción / Planta	C	313.9587	35	CORP-01194
367	PALMAS	RE0317021	TUBO DE ACERO AL CCARBON DE 10" X 1/4" X 5 PIES, CON COPLA DE HIERRO	Construcción y obra civil	Flota, maquinaria y combustible	C	6071.4286	108	CORP-01294
368	PALMAS	RE0302106	COJINETE No. 29430-E1 SKF (PRENSA RAQUIS)	Repuestos y componentes mecánicos	Bodega central (stock)	C	15799.1607	26	CORP-00383
369	SAN FRANCISCO	IN0305013	FORMULA 8	Fertilizantes y agroquímicos	Agrícola (fincas)	C	198.2853	46	CORP-00702
370	SUPREMA	RE0301015	LIQUIDO TERMICO, PARATHERM FG PEAT	Otros materiales	Mantenimiento industrial	C	210.9959	104	CORP-00892
371	PALMAS	IN0101046	TERMO INVICTO 400 GRS 18 UN COLOR VERDE	Material de empaque	Producción / Planta	C	315.1847	38	CORP-01196
372	PALMAS	IN0101043	TERMO INVICTO 400 GRS 18 UN COLOR CELESTE	Material de empaque	Producción / Planta	C	322.6071	44	CORP-01192
373	PALMAS	IN0101044	TERMO INVICTO 400 GRS 18 UN COLOR AMARILLO	Material de empaque	Producción / Planta	C	322.6071	34	CORP-01191
374	SAN ANTONIO	IN0305019	FÓRMULA 5 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.7871	20	CORP-00693
375	PALMAS	IN0101047	TERMO INVICTO 400 GRS 18 UN COLOR NARANJA	Material de empaque	Producción / Planta	C	322.6071	35	CORP-01193
376	SAN FRANCISCO	IN0305003	FORMULA 1	Fertilizantes y agroquímicos	Agrícola (fincas)	C	197.4518	33	CORP-00682
377	GRS	RE0109001	PEGAMENTO AMARILLO NORMAL	Construcción y obra civil	Infraestructura y obra civil	C	69.1559	43	CORP-00978
378	SUPREMA	04-0415-02	ESPECTROFOTOMETRO	Insumos químicos de producción	Producción / Planta	C	75000	50	CORP-00541
379	SUPREMA	04-0410-02	SISTEMA ANTI-REBALSE TANQUES DE ENVASADO	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	74964.6161	15	CORP-01124
380	ALFA	IN0305020	FÓRMULA 5 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.7871	25	CORP-00693
381	ALFA	IN0305018	FÓRMULA 3 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8308	21	CORP-00688
382	PALMAS	04-0749-01	MOTOR SUCCION DE FIBRA	Ferretería general	Mantenimiento industrial	C	72767.8571	25	CORP-00940
383	PALMAS	RE0314042	CHUTE VDP3019	Repuestos y componentes mecánicos	Mantenimiento industrial	C	36098.8473	15	CORP-00298
384	SUPREMA	MA0106039	YODURO DE POTASIO	Insumos químicos de producción	Producción / Planta	C	2000	52	CORP-01396
385	ALFA	IN0305023	FÓRMULA 8 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	219.3911	27	CORP-00704
386	SAN JORGE	IN0305018	FÓRMULA 4 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	16	CORP-00690
387	SUPREMA	IN0103051	ENVASE ACEITE COSTEÑO 1250 ML PET CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	1860.7143	15	CORP-00520
388	ACACIAS	IN0201001	SEMILLAS D X NIGERIAL (SPRING)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	9.6229	29	CORP-01103
389	ACACIAS	IN0305022	FÓRMULA 7 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	223.8991	25	CORP-00701
390	PALMAS	07-0137-01	CAMIONETA MITSUBISHI 2024	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	61754.5893	3	CORP-00239
391	SUPREMA	RE0102005	LLANTA NUEVA  10-16.5 10 PLY NHS (265/70D16.5) MAYO	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1617.4107	28	CORP-00893
392	PALMAS	RE0314028	WORM SCREW LHS/RHS KWY-P10 (TORNILLO)	Ferretería general	Mantenimiento industrial	C	7205.2632	15	CORP-01393
393	PALMAS	RE0314008	CB10T WORM SCREW CAST STEEL 110MM BUSH L.H.S/R.H.S.	Repuestos y componentes mecánicos	Mantenimiento industrial	C	9510.2123	15	CORP-00268
394	SAN JORGE	IN0305023	FÓRMULA 9 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	320.0022	27	CORP-00707
395	ACACIAS	IN0305009	FORMULA 7	Fertilizantes y agroquímicos	Agrícola (fincas)	C	210.7848	48	CORP-00699
396	PALMAS	RE0317092	ROPER KIT #N44-133	Repuestos y componentes mecánicos	Bodega central (stock)	C	7667.3433	19	CORP-01077
397	SUPREMA	RE0317099	SOLVENTE PARA BESTCODE (NOVIEMBRE)	Construcción y obra civil	Infraestructura y obra civil	C	334.8214	60	CORP-01129
398	PALMAS	04-0687-01	COMPRESOR DE PISTÓN VELOCIDAD FIJA 10HP 460V CON ARRANCADOR DIRECTO MODELO 2545E10, SECADORA REFRIGERATIVA MODELO D72IN Y VÁLVULA DE PURGA AUTOMÁTICA (VER ANEXO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	52196.1161	22	CORP-00425
399	SAN ANTONIO	IN0305022	FÓRMULA 8 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	219.3911	24	CORP-00704
400	SUPREMA	IN0103046	ENVASE ACEITE AUREOLA 100% SOYA  900 ML CON ETIQUETA (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	1443.3228	54	CORP-00514
401	PALMAS	RE0311018	VARIADOR (TURBINA) KSD 12X48 ALPA FLUID COUPLIN	Materiales eléctricos	Mantenimiento industrial	C	12743.2744	15	CORP-01376
402	PALMAS	RE0303008	BARRA ACERO 1045  5.1/2 GRUESO	Ferretería general	Mantenimiento industrial	C	59.375	14	CORP-00107
403	PALMAS	RE0317100	CS SCROLL TIPO BRIDA (3 CUCHILLAS, 230) SSP 652B	Repuestos y componentes mecánicos	Bodega central (stock)	C	24503.9062	100	CORP-00446
404	PALMAS	RE0314014	FLEXIBLE COUPLING PIN AND BRUSH  (PRENSA KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	15697.6723	15	CORP-00675
405	QUIRICA	IN0305022	FÓRMULA 8 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	219.3911	37	CORP-00703
406	PALMAS	IN0202023	LAUNDROSIL 414 BLANCO 1.4 MM	Materia prima	Producción / Planta	C	11.376	44	CORP-00858
407	SUPREMA	RE0201216	3485MLA - SBC ASSEMBLY W/FLASHCARD ATOM ESTO INCLUYE LA TARJETA ELECTRÓNICA CPU BOARD (+) EL DISPLAY	Material de empaque	Producción / Planta	C	45000	80	CORP-00002
408	PALMAS	IN0202089	FRAGANCIA SUPERJABONSON APAESA	Insumos químicos de producción	Producción / Planta	C	99.0402	2	CORP-00722
409	PALMAS	RE0302004	CHUMACERA BANCO SNL 519-616 CON COJINETE 22219 EK Y MANGUITO FIJACION 85 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	4412.8571	26	CORP-00291
410	PALMAS	04-0750-01	MOTOR ELÉCTRICO WEG 15 HP 220/440	Materiales eléctricos	Mantenimiento industrial	C	43932.0446	15	CORP-00939
411	SAN JORGE	IN0303008	INSECTICIDA NOMOLT 15 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	436.9379	43	CORP-00805
412	PALMAS	IN0101045	TERMO INVICTO 400 GRS 18 UN COLOR ROSADO	Material de empaque	Producción / Planta	C	307.2321	35	CORP-01195
413	SUPREMA	RE0302095	IMPULSOR Y EJE PARA VENTILADOR ID PARA CALDERA DE 15 TPH MODELO: Y8-39	Repuestos y componentes mecánicos	Mantenimiento industrial	C	42511.8013	2	CORP-00796
414	SAN ANTONIO	IN0305013	FORMULA 8	Fertilizantes y agroquímicos	Agrícola (fincas)	C	198.2853	48	CORP-00702
415	GRS	07-0001-10	JEEP Placa: P0 - 805BWQ Modelo: 1987	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	42105.2679	3	CORP-00809
416	PALMAS	RE0314010	CB15T WORM SCREW CAST STEEL (HOLLOW) Ø110.1 MM L.H.S./R.H.S.	Repuestos y componentes mecánicos	Mantenimiento industrial	C	10389.7573	134	CORP-00270
417	SAN FRANCISCO	IN0305021	FÓRMULA 7 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	224.3089	27	CORP-00700
418	ACACIAS	IN0305023	FÓRMULA 8 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	219.3911	25	CORP-00704
419	PALMAS	04-0751-01	VENTILADOR AXIAL 60” 6 ASPAS D	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	40404.625	15	CORP-01383
420	PALMAS	RE0311026	DISH END PART. 39	Repuestos y componentes mecánicos	Mantenimiento industrial	C	20117.7022	15	CORP-00484
421	QUIRICA	IN0303008	INSECTICIDA NOMOLT 15 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	436.9379	17	CORP-00805
422	SUPREMA	RE0302096	IMPULSOR Y EJE PARA VENTILADOR FD PARA CALDERA DE 15 TPH MODELO: G4-73	Repuestos y componentes mecánicos	Mantenimiento industrial	C	38647.0487	2	CORP-00795
423	ACACIAS	IN0303010	INSECTICIDA BIOLOGICO COSTAR 18 WG (KILO)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	423.1406	55	CORP-00801
424	SAN JORGE	IN0303010	INSECTICIDA BIOLOGICO COSTAR 18 WG (KILO)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	423.1406	51	CORP-00801
425	QUIRICA	IN0305013	FORMULA 8	Fertilizantes y agroquímicos	Agrícola (fincas)	C	198.2853	46	CORP-00702
426	SUPREMA	IN0102086	CAJA MANTECA TROPICANA 25 LB	Material de empaque	Producción / Planta	C	3112.6621	10	CORP-00223
427	SUPREMA	IN0105008	LONA FILTRADO DE ACEITE	Combustibles y lubricantes	Flota, maquinaria y combustible	C	46.6518	7	CORP-00905
428	PALMAS	RE0314018	PRESS CAGE KWY-P10 (CANASTA PRENSA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4461.7095	15	CORP-01020
429	PALMAS	MA0105014	ACEITE VALVOLINE AGMA EP6/ISO 320 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	162.1754	14	CORP-00035
430	SUPREMA	04-0417-02	BASCULA ELECTRONICA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	35625	15	CORP-00113
431	SUPREMA	RE0304095	GASKET NT-50 M CLIP FLOW NBR	Papelería, oficina y cómputo	Administración y oficinas	C	214.3565	88	CORP-00739
432	PALMAS	RE0201001	ARRANCADOR SUAVE SIEMENS No. 3RW4036-1BB14  45AMP.	Repuestos y componentes mecánicos	Bodega central (stock)	C	7053.5714	11	CORP-00094
433	SUPREMA	RE0317244	BOQUILLA MOTRIZ Y DOS JUNTAS Ø140/155 MM TD Nº 02043168	Repuestos y componentes mecánicos	Mantenimiento industrial	C	34762.6929	1	CORP-00148
434	ACACIAS	IN0305014	FORMULA 8	Fertilizantes y agroquímicos	Agrícola (fincas)	C	198.2853	52	CORP-00702
435	SUPREMA	RE0317239	BOQUILLA MOTRIZ Y DOS JUNTAS Ø120/135 MM TD NO. 02043133	Repuestos y componentes mecánicos	Mantenimiento industrial	C	33672.0897	1	CORP-00147
436	PALMAS	RE0314007	CB10T PRESS CAGE (M/STEEL) T/H 3X4MM (EXPORT QUALITY)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5559.4845	15	CORP-00267
437	SAN JORGE	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	207.0312	76	CORP-00451
438	PALMAS	RE0317102	ANILLO PORTA CUCHILLA DE JAULA (4 CUCHILLAS-P, 210 MM) SSP 655B	Repuestos y componentes mecánicos	Bodega central (stock)	C	16406.5179	15	CORP-00082
439	PALMAS	RE0317101	BUJE DE BRONCE (210) B2 CP-1011D	Repuestos y componentes mecánicos	Bodega central (stock)	C	5397.1433	100	CORP-00165
440	PALMAS	RE0314053	SCREW PRESS DIGITAL CONTROL PANEL 1B	Repuestos y componentes mecánicos	Mantenimiento industrial	C	10765.8143	15	CORP-01087
441	SUPREMA	RE0304058	SELLO MECANICO DE 1 3/8, TIPO 650 RESORTE DERECHO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1588.7411	37	CORP-01100
442	PALMAS	RE0317025	COPLA PARA TUBO POZO 10" X 1/4"	Construcción y obra civil	Flota, maquinaria y combustible	C	1977.6786	101	CORP-00439
443	PALMAS	RE0314025	REXROTH STANDARD HYDRAULIC POWER UNIT FOR P15 C/W (PRENSA CB15T)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	31052.421	50	CORP-01071
444	PALMAS	RE0317099	MALLA DE JAULA DE PRENSA (810) SSP 653	Repuestos y componentes mecánicos	Bodega central (stock)	C	10215.9603	60	CORP-00911
445	PALMAS	IN0202022	LAUNDROSIL 3KV 414 VERDE 1.4 MM	Materia prima	Producción / Planta	C	10.1287	49	CORP-00857
446	PALMAS	IN0101048	TERMO JABONSON 385/18 GRS AMARILLO	Material de empaque	Producción / Planta	C	202.4554	53	CORP-01197
447	PALMAS	IN0101039	TERMO JABONSON GENERICO 540 GRS 12 UNIDAD	Material de empaque	Producción / Planta	C	232.1429	15	CORP-01201
448	SUPREMA	MA0106019	CLOROFORMO DE ANALISIS	Insumos químicos de producción	Calidad y laboratorio	C	148.875	29	CORP-00335
449	PALMAS	RE0313072	ROTOR ROD 20MM. DIA. X 375 MM.  (RIPPLE MILL)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4204.4946	15	CORP-01078
450	SUPREMA	IN0106001	TAPA VERDE ENVASE PET 3000 ML	Material de empaque	Producción / Planta	C	305.095	30	CORP-01171
451	PALMAS	RE0302095	CHUMACERA PARED COJIN. GN 215 KRRB, EJE 2.15/16"	Repuestos y componentes mecánicos	Bodega central (stock)	C	4781.25	2	CORP-00294
452	PALMAS	IN0101051	TERMO JABONSON 385/18 GRS VERDE	Material de empaque	Producción / Planta	C	202.4554	53	CORP-01199
453	SUPREMA	MA0110015	DESENGRASANTE MULTIPROPOSITO GRADO ALIMENTICIO (AGOSTO)	Limpieza e higiene	Servicios generales y limpieza	C	176.6071	46	CORP-00459
454	SUPREMA	RE0317242	IMPULSOR DE 8-1/2", PARTE 1286121	Repuestos y componentes mecánicos	Mantenimiento industrial	C	27452.8665	1	CORP-00794
455	SUPREMA	RE0201197	PZA SENSOR WATER 025-52739-000	Materiales eléctricos	Mantenimiento industrial	C	3427.6786	74	CORP-01024
456	PALMAS	RE0312028	SCREEN MESH P/N 10	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6854.3426	15	CORP-01086
457	SUPREMA	IN0103044	CANECA NATURAL AUREOLA ESTIBABLE  5 GLS	Material de empaque	Producción / Planta	C	19.125	5	CORP-00244
458	SUPREMA	IN0201028	LIENZO PARA/MARGARINA MULTIPROPOSITO.-	Material de empaque	Producción / Planta	C	452.6786	62	CORP-00882
459	SUPREMA	MA0106043	ALCOHOL INDUSTRIAL (OCTUBRE)	Limpieza e higiene	Servicios generales y limpieza	C	11.1607	59	CORP-00068
460	PALMAS	RE0314033	SQUARE SHAFT VDP3011  (DIGESTOR PRENSA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	13261.0018	15	CORP-01145
461	PALMAS	IN0101049	TERMO JABONSON 385/18 GRS CELESTE	Material de empaque	Producción / Planta	C	202.4554	70	CORP-01198
462	PALMAS	IN0101052	TERMO JABONSON 385/18 GRS VIOLETA	Material de empaque	Producción / Planta	C	202.4554	73	CORP-01200
463	SUPREMA	RE0317037	MECANICAL SEAL STATIONARY (PARTE 6765942)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5207.3649	72	CORP-00922
464	SUPREMA	MA0106027	PAPEL FILTRO 32x64 PULGADAS	Repuestos y componentes mecánicos	Mantenimiento industrial	C	12.9018	68	CORP-00969
465	SUPREMA	RE0304089	LAMINA EMPAQUE K1000S 1/4" 60"X80"	Construcción y obra civil	Infraestructura y obra civil	C	8482.1429	17	CORP-00834
466	SAN ANTONIO	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	207.5708	62	CORP-00451
467	PALMAS	RE0302006	CHUMACERA PARED COJIN. GN 207 KRRB (F-215)	Repuestos y componentes mecánicos	Bodega central (stock)	C	3127.2321	42	CORP-00293
468	QUIRICA	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	207.5893	35	CORP-00451
469	SAN FRANCISCO	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	207.5893	80	CORP-00451
470	SUPREMA	RE0304152	EMPAQUE INTERMEDIO EN HT-NBR (SNAP ON TYPE) PARA INTERCAMBIADOR KELVION NT80M CDL-10	Repuestos y componentes mecánicos	Mantenimiento industrial	C	351.7095	118	CORP-00508
471	SUPREMA	RE0317087	JUEGO TELA PARA FILTRO TAMBOR (8 PLIEGOS )	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3050.6287	15	CORP-00823
472	SUPREMA	RE0306010	CORREA DENTADA (3/8 PITCH, 195 DIENTES, ROJO LIMATEX) # PARTE 1099-205	Ferretería general	Mantenimiento industrial	C	2960.7143	45	CORP-00441
473	SAN JORGE	03-0016-04	PORTÓN DE DOBLE HOJA	Limpieza e higiene	Servicios generales y limpieza	C	23660.7143	15	CORP-01016
474	PALMAS	RE0314009	CB15T PRESS CAGE (M/STEEL) T/H 3X4MM (EXPORT QUALITY)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5903.658	50	CORP-00269
475	SAN ANTONIO	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	Fertilizantes y agroquímicos	Agrícola (fincas)	C	29.2592	24	CORP-00774
476	SUPREMA	RE0304046	SILICONE ROJO 70 ML. (ENERO)	Ferretería general	Mantenimiento industrial	C	24.1071	16	CORP-01116
477	PALMAS	06-0444-01	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	23141.25	63	CORP-01150
478	METALMECANICA	AV10110010114	SONDA D40	Otros materiales	Mantenimiento industrial	C	23052.4554	15	CORP-01130
479	SUPREMA	IN0106005	TAPA VERDE 1500 ML, 1300 ML	Material de empaque	Producción / Planta	C	315.5625	58	CORP-01167
480	SUPREMA	IN0106013	TAPA AMARILLA 1500 ML, 1300 ML	Material de empaque	Producción / Planta	C	315.5625	79	CORP-01158
481	PALMAS	RE0302108	COJINETE # 99550/99100 TIMKEN O SKF	Repuestos y componentes mecánicos	Bodega central (stock)	C	5669.6429	33	CORP-00371
482	PALMAS	IN0202016	COLORANTE VERDE DIBARPRINT BG	Insumos químicos de producción	Producción / Planta	C	185.854	17	CORP-00424
483	PALMAS	RE0302109	COJINETE #23028 JW33 C3 TIMKEN  O SKF	Repuestos y componentes mecánicos	Bodega central (stock)	C	5523.4241	59	CORP-00350
484	SUPREMA	IN0106030	TAPA AZUL PARA 400, 700, 800, 900 ML	Material de empaque	Producción / Planta	C	120.4192	15	CORP-01164
485	SUPREMA	IN0102041	CAJA MARGARINA INDUSTRIAL MULTIPROPOSITO 30 LB	Material de empaque	Producción / Planta	C	2987.4031	15	CORP-00226
486	PALMAS	RE0302091	COJINETE No. SMN 114+COL  (EJE 1.7/8)	Repuestos y componentes mecánicos	Bodega central (stock)	C	1485.9184	29	CORP-00420
487	PALMAS	MA0102115	VALVULA INOX 4 TIPO COMPUERTA (BRIDADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	5178.5714	14	CORP-01371
488	TASINSA	RE0309159	POLLY PIG CLEANER SIZE 10" TYPE 5A RED BARE SQUEEGEE LIMP. OLEODUCTO	Otros materiales	Mantenimiento industrial	C	1099.05	15	CORP-01005
489	SAN JORGE	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	Fertilizantes y agroquímicos	Agrícola (fincas)	C	28.9867	32	CORP-00774
490	PALMAS	RE0314047	MAIN SHAFT L.H.S P/1023 (MOTRIZ)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6516.1935	15	CORP-00907
491	PALMAS	08-0091-01	BALANZA ANALÍTICA PR224 DE 220 g (0.1 mg) CON AJUSTE INTERNO, MARCA OHAUS (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Calidad y laboratorio	C	19486.6071	48	CORP-00098
492	PALMAS	MA0107027	ELECTRODO ECA 9018 DE 5/32" X 14" = 132 LIBRAS	Herramientas	Bodega central (stock)	C	3.5973	11	CORP-00494
493	SUPREMA	RE0304061	SELLO MECANICO SEALCO TIPO 21 DE 1-3/4 SILICIO-SILICIO-VITON	Repuestos y componentes mecánicos	Mantenimiento industrial	C	714.3981	25	CORP-01102
494	SUPREMA	RE0317194	CILINDRO HIDRAULICO PARA PISO RECIPROCANTE DE RAMPA FUNDA ø100MM X VASTAGO ø50MM X CARRERA 250MM	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6265.7141	15	CORP-00303
495	ACACIAS	MA0102069	PEGAMENTO PVC WET BONDING PEGAR EN MOJADO	Construcción y obra civil	Flota, maquinaria y combustible	C	469.2857	43	CORP-00981
496	PALMAS	RE0312025	DIRT RECEIVER (60853995)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	9377.1808	15	CORP-00471
497	PALMAS	RE0311006	NOZZLE HOLDER (PORTA-BOQUILLAS) STORK	Repuestos y componentes mecánicos	Mantenimiento industrial	C	390.1309	15	CORP-00949
498	PALMAS	RE0314041	SLIDING DOOR VDP3023	Repuestos y componentes mecánicos	Mantenimiento industrial	C	9212.5808	15	CORP-01126
499	SUPREMA	RE0304088	LAMINA EMPAQUE K1000S 1/8" 60"X80"	Construcción y obra civil	Infraestructura y obra civil	C	4600.4464	14	CORP-00835
500	PALMAS	04-0733-01	BOMBA ROPER SERIE 3622	Repuestos y componentes mecánicos	Mantenimiento industrial	C	18276.7707	32	CORP-00136
501	SUPREMA	MA0110005	TOALLA PARA TRAPEADOR (AGOSTO)	Limpieza e higiene	Servicios generales y limpieza	C	13.1767	57	CORP-01212
502	PALMAS	RE0314017	HYDRAULIC CYLINDER//20-KWY P10  (PRENSA KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	9008.9078	15	CORP-00786
503	PALMAS	MA0105026	ACEITE VALVOLINE AGMA EP6/ISO 220 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	162.1754	20	CORP-00034
504	SUPREMA	MA0110011	SPRAY DE DIELTRON 3 (DICIEMBRE)	Ferretería general	Mantenimiento industrial	C	329.0179	58	CORP-01138
505	PALMAS	RE0312023	TOP CYLENDER (60857006)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	8772.4463	15	CORP-01215
506	SUPREMA	05-0574-02	TRANSPORTADOR DE RODILLOS	Repuestos y componentes mecánicos	Mantenimiento industrial	C	17410.7143	46	CORP-01289
507	SUPREMA	IN0102081	CAJA PARA ACEITE AUREOLA  12X1250 ML ( NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4279.4578	19	CORP-00227
508	SUPREMA	04-0398-02	MOTOR ELECTRICO	Materiales eléctricos	Mantenimiento industrial	C	16964.2857	7	CORP-00938
509	PALMAS	RE0302107	COJINETE No. 6328M SKF (PRENSA RAQUIS)	Repuestos y componentes mecánicos	Bodega central (stock)	C	8380.3571	23	CORP-00415
510	PALMAS	RE0314023	REXROTH HYDRAULIC CYLINDER (CB10T) CD210P 125/56-250	Repuestos y componentes mecánicos	Mantenimiento industrial	C	8304.0067	15	CORP-01070
511	PALMAS	RE0311028	JOURNAL SOLID PART. 20	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4138.8604	15	CORP-00815
512	PALMAS	RE0314046	MAIN SHAFT R.H.S P/1022 (CONDUCIDO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5499.1515	15	CORP-00909
513	PALMAS	RE0313073	BLEND PLATE´S ROD 20 MM. DIA X 430 MM.  (RIPPLE MILL)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2304.4259	15	CORP-00123
514	GRS	IN0402003	SAL MINERAL TORTUGA  FOSBOVI REPRODUCCION DSM	Materia prima	Producción / Planta	C	26.2645	21	CORP-01085
515	QUIRICA	04-0018-07	CAUDALIMETRO SEAMETRICS SEAMETRICS AG90-1000-BX-01-0064: DE 10"  (VER ANEXO)	Materiales eléctricos	Flota, maquinaria y combustible	C	15625	116	CORP-00266
516	ACACIAS	04-0132-03	CAUDALIMETRO ELECTROMAGNETICO SEAMETRICS AG90-1000-BX-01-0064: DE 10"  (VER ANEXO)	Materiales eléctricos	Flota, maquinaria y combustible	C	15625	1	CORP-00265
517	QUIRICA	04-0017-07	CAUDALIMETRO SEAMETRICS SEAMETRICS AG90-1000-BX-01-0064: DE 10"  (VER ANEXO)	Materiales eléctricos	Flota, maquinaria y combustible	C	15625	116	CORP-00266
518	PALMAS	RE0311027	JOURNAL HOLLOW (SLUDGE INLET) PART. 20	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3868.4711	15	CORP-00814
519	ACACIAS	IN0305016	FÓRMULA 1 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	216.7955	21	CORP-00681
520	PALMAS	RE0314043	TEAM PIPE VDP3021	Repuestos y componentes mecánicos	Mantenimiento industrial	C	7469.1321	15	CORP-01178
521	PALMAS	04-0711-01	BOMBA FRANKLIN	Repuestos y componentes mecánicos	Mantenimiento industrial	C	14910.7143	4	CORP-00134
522	SUPREMA	IN0102087	CAJA ACEITE COSTEÑO 48X140 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2931.3844	22	CORP-00205
523	GRS	07-0002-10	MOTOCICLETA MARCA SUZUKI GN125 TT	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	14642.8571	6	CORP-00936
524	PALMAS	RE0314011	CB3000L LONG ARM / VDP3014	Repuestos y componentes mecánicos	Mantenimiento industrial	C	907.3446	15	CORP-00271
525	PALMAS	04-0735-01	BOMBA, TANQUE 2, ACP	Repuestos y componentes mecánicos	Mantenimiento industrial	C	14241.0714	15	CORP-00138
526	SAN ANTONIO	05-0042-05	AIRE ACONDICIONADO MINI SPLIT	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	14175.5357	4	CORP-00063
527	PALMAS	RE0311021	SPHERICAL BEARING 22224EK+ SLEEVE (P/11)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3542.0839	15	CORP-01136
528	PALMAS	MA0104029	LAMINA LISA INOX. 1/4 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	3541.3839	9	CORP-00844
529	PALMAS	RE0302003	CHUMACERA BANCO COJIN. G 1115 KRRB DE 1.15/16	Repuestos y componentes mecánicos	Bodega central (stock)	C	3529.0179	15	CORP-00288
530	PALMAS	04-0734-01	BOMBA, TANQUE 2, ACP	Repuestos y componentes mecánicos	Mantenimiento industrial	C	13839.2857	28	CORP-00138
531	SUPREMA	IN0102089	CAJA ACEITE PRIMOR 12X700 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	2732.1429	19	CORP-00209
532	PALMAS	RE0312027	GEARED MOTOR P/N 1	Repuestos y componentes mecánicos	Mantenimiento industrial	C	13600.5525	15	CORP-00746
533	PALMAS	RE0314012	CB3000L SHORT ARM / VDP3013	Repuestos y componentes mecánicos	Mantenimiento industrial	C	837.8116	15	CORP-00272
534	SUPREMA	IN0102091	CAJA ACEITE COSTEÑO  12X1250 ML PET  (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4439.7321	15	CORP-00202
535	METALMECANICA	AV10110010113	PORTAMUESTRAS DE TEFLON 40 MM. (CONTIENE 1 SOPORTE + 10 TUBOS)	Ferretería general	Mantenimiento industrial	C	1328.04	22	CORP-01013
536	SUPREMA	RE0317053	TRUST BEARING (PARTE 9010169)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4413.3867	77	CORP-01291
537	SUPREMA	IN0104022	ETIQUETA  ACEITE PRIMOR 3000 ML  (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	378.9482	15	CORP-00559
538	PALMAS	04-0732-01	MOTOR SUMERGIBLE 7.5HP	Materiales eléctricos	Mantenimiento industrial	C	12857.1429	12	CORP-00941
539	ACACIAS	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	209.7482	36	CORP-00451
540	SAN ANTONIO	IN0303010	INSECTICIDA BIOLOGICO COSTAR 18 WG (KILO) BASE BACILIUS (CEPA SA-12)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	423.1406	51	CORP-00802
541	PALMAS	RE0317094	CUCHILLA AJUSTABLE SSP 650	Repuestos y componentes mecánicos	Bodega central (stock)	C	1582.9353	34	CORP-00447
542	PALMAS	RE0312013	BALL VALVE 1.1/2" & 3/4" C/W ACTUADOR (7880136)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6306.2775	15	CORP-00100
543	PALMAS	06-0437-01	FIREWALL	Papelería, oficina y cómputo	Administración y oficinas	C	12591.9	15	CORP-00673
544	GRS	RE0309006	CHEQUE  BRONCE HORIZONTAL BUGATI DE 4 C/RETENEDOR DE HULE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2098.2143	81	CORP-00280
545	SAN JORGE	MA0104021	TUBO PALMPRO-R 42MM X 6M	Ferretería general	Agrícola (fincas)	C	1239.9286	15	CORP-01311
546	ALFA	MA0101026	CUCHILLO MALAYO M222-B	Herramientas	Agrícola (fincas)	C	205.3571	28	CORP-00451
547	ACACIAS	IN0301001	HERBICIDA GLIFOSATO ALEMAN 35.6 SL	Fertilizantes y agroquímicos	Agrícola (fincas)	C	30.8036	16	CORP-00774
548	SUPREMA	06-0519-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	12053.5714	6	CORP-00848
549	SAN FRANCISCO	IN0305023	FÓRMULA 9 (45.36 kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	320.1388	27	CORP-00706
550	PALMAS	RE0102026	RUEDA POLIURETANO AMARILLO 10 X 4 TRIQUE ELEVADOR CAMIONES	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1964.2857	16	CORP-01081
551	SUPREMA	06-0582-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	38	CORP-00848
552	PALMAS	06-0470-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
553	PALMAS	06-0477-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
554	PALMAS	06-0474-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
555	PALMAS	06-0471-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
556	SUPREMA	06-0581-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	38	CORP-00848
557	PALMAS	06-0452-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	42	CORP-00848
558	PALMAS	06-0472-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
559	PALMAS	06-0469-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
560	PALMAS	06-0473-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	27	CORP-00848
561	PALMAS	06-0451-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11742.75	42	CORP-00848
562	PALMAS	RE0312014	BALL VALVE 1 1/2"   C/w ACTUADOR	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5804.5905	15	CORP-00101
563	SUPREMA	RE0317243	ANILLO DE CARCASA PARTE 1555935	Repuestos y componentes mecánicos	Mantenimiento industrial	C	11595.87	1	CORP-00081
564	SUPREMA	RE0317064	SIHI P/N 43006727 RADIAL SHAFT SEAL RING	Repuestos y componentes mecánicos	Mantenimiento industrial	C	361.5948	88	CORP-01114
565	SUPREMA	IN0106031	TAPA AZUL PARA  3000 ML    (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	0.3393	15	CORP-01163
566	PALMAS	RE0317098	CUCHILLA RASPADORA (L) SSP 104	Repuestos y componentes mecánicos	Bodega central (stock)	C	1921.5844	16	CORP-00450
567	PALMAS	RE0311004	NOZZLE (BOQUILLA) 1.7 MM. STORK	Repuestos y componentes mecánicos	Mantenimiento industrial	C	239.4846	15	CORP-00948
568	PALMAS	05-0560-01	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	11428.5714	15	CORP-00059
569	PALMAS	MA0102116	VALVULA INOX 4 TIPO PASO RAPIDO (BRIDADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	2800.4464	42	CORP-01372
570	PALMAS	07-0135-01	MOTO	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	11151.7857	3	CORP-00934
571	QUIRICA	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	27.7149	37	CORP-00775
572	ACACIAS	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	27.7149	37	CORP-00775
573	ALFA	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	27.7149	37	CORP-00775
574	ACACIAS	IN0305003	FORMULA 1	Fertilizantes y agroquímicos	Agrícola (fincas)	C	178.2723	42	CORP-00680
575	PALMAS	06-0484-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	10990.5228	24	CORP-00848
576	SUPREMA	IN0105009	TONEL PARA 54 GLS PLASTICO (LAVADO)	Material de empaque	Producción / Planta	C	346.1961	18	CORP-01214
577	SUPREMA	MA0110020	CW-500	Insumos químicos de producción	Producción / Planta	C	178.5714	15	CORP-00458
578	QUIRICA	MA0102069	PEGAMENTO PVC WET BONDING PEGAR EN MOJADO	Construcción y obra civil	Flota, maquinaria y combustible	C	469.2857	39	CORP-00981
579	PALMAS	RE0311017	RECOVERY OIL PIPE P/31	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1305.5873	15	CORP-01031
580	SUPREMA	MA0110010	SPRAY DE DEGREASER 92 (OCTUBRE)	Ferretería general	Mantenimiento industrial	C	101.5089	73	CORP-01137
581	SUPREMA	08-0294-02	AMPERIMETRO	Materiales eléctricos	Mantenimiento industrial	C	10352.6786	3	CORP-00075
582	PALMAS	RE0317103	ANILLO SECUNDARIO DE JAULA (8 CUCHILLAS-P) SSP 656B	Repuestos y componentes mecánicos	Bodega central (stock)	C	3449.3304	15	CORP-00083
583	SUPREMA	RE0317187	CADENA PARA TRANSPORTADOR DE CENIZA 18X760MM	Repuestos y componentes mecánicos	Mantenimiento industrial	C	292.0893	22	CORP-00192
584	PALMAS	MA0104065	VIGA H.N. TIPO C  1/4 X 2 X 4 X 20	Construcción y obra civil	Infraestructura y obra civil	C	631.6964	20	CORP-01386
585	SUPREMA	08-0298-02	AMPERIMETRO	Materiales eléctricos	Mantenimiento industrial	C	9955.3571	13	CORP-00075
586	PALMAS	RE0201115	HOROMETRO DIGITAL AUTONICS LE8N-BF (VOLTAJE 24-240VAC)	Materiales eléctricos	Bodega central (stock)	C	395.5357	12	CORP-00783
587	PALMAS	RE0317028	BUJES NEOPRENO EJE POZO 1.1/2" Ø INT. ARAÑA 2.1/2"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	394.6429	87	CORP-00169
588	GRS	06-0045-10	COMPUTADORA DE ESCRITORIO HP PRODESK	Papelería, oficina y cómputo	Administración y oficinas	C	9799.1071	15	CORP-00426
589	PALMAS	RE0317027	BUJES NEOPRENO EJE POZO 1.1/2" Ø INT. ARAÑA 2"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	391.0714	54	CORP-00168
590	SUPREMA	IN0102088	CAJA ACEITE AUREOLA 100% SOYA 12 X 900 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	3258.0804	18	CORP-00193
591	SAN JORGE	MA0104020	TUBO PALMPRO-R 38MM X 6M	Ferretería general	Agrícola (fincas)	C	974.8661	74	CORP-01310
592	SUPREMA	05-0554-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	9680.0357	18	CORP-00059
593	SUPREMA	05-0546-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	9680.0357	18	CORP-00059
594	SUPREMA	RE0317093	BOLSAS FILTRANTES 16 X 5 mm	Material de empaque	Producción / Planta	C	26.7857	13	CORP-00129
595	PALMAS	IN0102019	CAJA JABONSON GENERICO 540 GRS 12 UNIDADES	Material de empaque	Producción / Planta	C	2054.9129	16	CORP-00216
596	PALMAS	MA0102101	VALVULA BRONCE 3 TIPO COMPUERTA	Repuestos y componentes mecánicos	Bodega central (stock)	C	751.7857	17	CORP-01340
597	PALMAS	RE0302083	CHUMACERA BANCO COJIN. G 1108 KRRB DE 1.1/2	Repuestos y componentes mecánicos	Bodega central (stock)	C	744.9405	18	CORP-00287
598	PALMAS	MA0104090	VIGA HN TIPO H  8 X 8 X 31 LBS/PIE X 20	Construcción y obra civil	Infraestructura y obra civil	C	2232.1429	21	CORP-01388
599	SUPREMA	MA0110018	CHN-200	Insumos químicos de producción	Producción / Planta	C	111.6071	15	CORP-00283
600	PALMAS	08-0197-01	KIT DE HERRAMIENTAS INALÁMBRICAS M18 FUEL, 7 PIEZAS MILWAUKEE	Herramientas	Mantenimiento industrial	C	8924.1696	15	CORP-00828
601	SAN JORGE	IN0302008	COADYUVANTE LOCKER 34 SL	Fertilizantes y agroquímicos	Agrícola (fincas)	C	148.6808	50	CORP-00336
602	ACACIAS	MA0105003	ACEITE SAE No. 15W-40  CI-4 PLUS/SL  (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	84.5871	20	CORP-00026
603	PALMAS	05-0570-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	8872.6339	16	CORP-01119
604	PALMAS	07-0141-01	PICK-UP MADZA BT-50 MODELO 2022	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	8705.3571	15	CORP-00986
605	SAN ANTONIO	MA0105003	ACEITE SAE No. 15W-40  CI-4 PLUS/SL  (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	78.4	13	CORP-00025
606	PALMAS	RE0317097	JAULA DE PRENSA (405) SSP 654	Repuestos y componentes mecánicos	Bodega central (stock)	C	4299.7098	53	CORP-00808
607	SUPREMA	04-0419-02	BOMBA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	8562.5	15	CORP-00132
608	SUPREMA	RE0302010	COJINETE 3309 ARN ASTRIA 250H SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1702.6786	12	CORP-00352
609	SUPREMA	RE0201032	CINTA SCOTCH 33	Ferretería general	Mantenimiento industrial	C	42.4107	12	CORP-00320
610	GRS	04-0123-10	MOTOBOMBA KATSU POWER F440A 13 HP 3"x3"	Materiales eléctricos	Mantenimiento industrial	C	8482.1429	23	CORP-00935
611	PALMAS	RE0314005	4WMM6H-6XR1/F HAND CONTROL VALVE//12  (PRENSA CB10T/KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4235.1165	15	CORP-00004
612	METALMECANICA	08-0302-11	SET DE MICROMETROS EXTERIORES DE 0" A 6" DE 6 PZS SERIE 103-904-10 MARCA MITUTOYO (VER ANEXO)	Herramientas	Mantenimiento industrial	C	8437.5	15	CORP-01105
613	PALMAS	RE0302012	COJINETE No. 22213 EK  (CON MANGUITO FIJACION EJE 60 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	1052.6786	18	CORP-00373
614	PALMAS	MA0105010	ACEITE SUMMIT SINTETICO DSL-100 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	558.0359	15	CORP-00028
615	PALMAS	RE0201029	CONTACTOR SIEMENS SIRIUS 3RT1036	Materiales eléctricos	Bodega central (stock)	C	1195.7908	20	CORP-00437
616	PALMAS	RE0201127	CABLE No. 500 MCM	Materiales eléctricos	Bodega central (stock)	C	348.2143	11	CORP-00182
617	PALMAS	RE0314040	SPUR GEAR P/N 1021  (PRENSA KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	8342.9623	15	CORP-01143
618	PALMAS	MA0102112	VALVULA INOX 2 PASO RAPIDO (BRIDADA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2084.9107	62	CORP-01365
619	SUPREMA	IN0105005	MARCHAMO DE SEGURIDAD TIPO SURE LOCK NUMERADO	Ferretería general	Mantenimiento industrial	C	1.6518	15	CORP-00920
620	PALMAS	RE0314045	STRAINER	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4115.3557	15	CORP-01147
621	PALMAS	RE0201070	RESISTENCIA ESPIRAL 2100 WATTS  220 V. MOD. 5W8-221 DE 5 ESPIRALES	Materiales eléctricos	Bodega central (stock)	C	202.2768	18	CORP-01048
622	SUPREMA	06-0561-02	PORTATIL HP 460 G11	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	8026.7857	8	CORP-01015
623	SUPREMA	06-0562-02	PORTATIL HP 460 G11	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	8026.7857	8	CORP-01015
624	SUPREMA	06-0552-02	PORTATIL HP 460 G11	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	8026.7857	8	CORP-01015
625	SAN FRANCISCO	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	Fertilizantes y agroquímicos	Agrícola (fincas)	C	28.5973	22	CORP-00774
626	SUPREMA	RE0317240	BOQUILLA MOTRIZ Y JUEGO DE JUNTAS TD 02043112	Repuestos y componentes mecánicos	Mantenimiento industrial	C	7952.2433	1	CORP-00150
627	SAN JORGE	06-0029-04	LAPTOP HP 460G11 INTEL ULTRA 5-125UU, 16GB RAM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7937.5	24	CORP-00851
628	GABIOSA	06-0003-13	LAPTOP HP 460G11 I5 16GB RAM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7937.5	12	CORP-00850
629	SUPREMA	IN0202007	QUIMICO MBT-05	Ferretería general	Mantenimiento industrial	C	175	11	CORP-01025
630	PALMAS	RE0311002	INLET PIPE (TUBO ENTRADA) P/5	Ferretería general	Mantenimiento industrial	C	1958.3618	15	CORP-00799
631	PALMAS	RE0311020	INLET (CAST IRON) P/2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1958.3618	15	CORP-00798
632	PALMAS	05-0589-01	LIBRERO	Ferretería general	Mantenimiento industrial	C	7720.3125	15	CORP-00881
633	PALMAS	06-0440-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7669.6429	22	CORP-00848
634	SUPREMA	IN0202010	SOLVENTE MEK PARA LIMPIEZA	Construcción y obra civil	Infraestructura y obra civil	C	511.0345	59	CORP-01128
635	SAN JORGE	04-0025-04	MOTOSIERRA STIHL 382 C/2 LIT+FILTRO+BUJIA+LIMA	Repuestos y componentes mecánicos	Agrícola (fincas)	C	7641.0714	29	CORP-00942
636	SAN JORGE	04-0024-04	MOTOSIERRA STIHL 382 C/2 LIT+FILTRO+BUJIA+LIMA	Repuestos y componentes mecánicos	Agrícola (fincas)	C	7641.0714	29	CORP-00942
637	SUPREMA	MA0102115	VALVULA INOX 2 PASO RAPIDO SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	953.5714	24	CORP-01367
638	SUPREMA	RE0201196	KIT SENSOR KIT EEV 325-47673-000	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3777.6786	74	CORP-00831
639	SUPREMA	06-0536-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7506.5	20	CORP-00848
640	SUPREMA	06-0534-02	LAPTOP HP I7	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7491.0714	14	CORP-00853
641	GRS	RE0309090	SELLADORA  MANUAL DE 10 CD-260 300 WATTS	Construcción y obra civil	Infraestructura y obra civil	C	830.3571	60	CORP-01091
642	PALMAS	MA0102114	VALVULA INOX 3 TIPO PASO RAPIDO (ROSCADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	931.7857	10	CORP-01370
643	PALMAS	RE0304012	EMPAQUE SINTETICO HI TEMP GRADO ALIMENTICIO 1/8  (PIE²)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	99.1071	37	CORP-00511
644	METALMECANICA	08-0301-11	SET DE MICROMETROS EXTERIORES DE 0MM A 150MM DE 6 PZS SERIE 103-913-50 MARCA MITUTOYO (VER ANEXO)	Herramientas	Mantenimiento industrial	C	7406.25	15	CORP-01106
645	GRS	RE0309054	CHUMACERAS UCP 204-12 3/4"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	204.7619	19	CORP-00297
646	PALMAS	RE0314055	SPUR GEAR P/N 1521	Repuestos y componentes mecánicos	Mantenimiento industrial	C	7336.4265	15	CORP-01144
647	PALMAS	RE0101102	FILTRO TRAMPA DIESEL JOHN DEERE RE520906	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1211.9643	15	CORP-00664
648	PALMAS	RE0101103	FILTRO DE ACEITE JOHN DEERE RE509672	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1211.9643	15	CORP-00628
649	PALMAS	06-0486-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7223.2143	25	CORP-00848
650	SUPREMA	RE0304140	O-RING FOR LEAF NOZZLE øINT34.52x3.53 mm VITON	Repuestos y componentes mecánicos	Mantenimiento industrial	C	37.735	49	CORP-00956
651	PALMAS	06-0433-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	7133.9286	4	CORP-00848
652	GABIOSA	05-0015-13	SISTEMA DE AC DE 24,000 BTU R410  INNOVAIR	Insumos químicos de producción	Producción / Planta	C	3540.5045	15	CORP-01125
653	PALMAS	RE0314058	MAIN SHAFT L.H.S P/1523 (MOTRIZ)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6976.1115	15	CORP-00908
654	SUPREMA	06-0520-02	LAPTOP HP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6955.3571	29	CORP-00849
655	SUPREMA	06-0521-02	LAPTOP HP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6955.3571	29	CORP-00849
656	PALMAS	RE0103053	PAQUETE RESORTAJE 3 HOJAS TIPO CACHO SEMICURVO	Papelería, oficina y cómputo	Administración y oficinas	C	385.9127	17	CORP-00970
657	SAN JORGE	05-0035-04	TELEVISOR HISENSE 85A6N 85" SMART (GOOGLE TV) LED TV 4K_x0002_ULTRA HD (VER ANEXO)	Materiales eléctricos	Administración y oficinas	C	6927.6786	15	CORP-01185
658	PALMAS	MA0104024	LAMINA LISA H.N. 1.1/2 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	6895.3125	4	CORP-00836
659	PALMAS	RE0302005	CHUMACERA PARED COJIN. G 1108 KRRB DE 1.1/2	Repuestos y componentes mecánicos	Bodega central (stock)	C	861.1964	53	CORP-00292
660	SUPREMA	RE0101002	FILTRO ACEITE 15607-2250 SAKURA (JUNIO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	236.6071	33	CORP-00609
661	PALMAS	05-0598-01	HIDROLAVADORA	Papelería, oficina y cómputo	Administración y oficinas	C	6856.9643	18	CORP-00778
662	PALMAS	MA0104026	LAMINA LISA H.N. 3/16 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	678.3929	14	CORP-00841
663	SAN JORGE	06-0028-04	LAPTOP HP PROBOOK 460	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6776.7857	6	CORP-00854
664	SUPREMA	06-0533-02	LAPTOP HP I5	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6776.7857	14	CORP-00852
665	SUPREMA	06-0532-02	LAPTOP HP I5	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6776.7857	14	CORP-00852
666	SUPREMA	06-0535-02	LAPTOP HP I5	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6776.7857	16	CORP-00852
667	PALMAS	RE0302061	COJINETE No. 6313 2RS  (65 X 140 X 33 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	670.4714	12	CORP-00413
668	SUPREMA	06-0591-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
669	PALMAS	06-0512-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
670	PALMAS	06-0511-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
671	SUPREMA	06-0593-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
672	SUPREMA	06-0592-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
673	SUPREMA	06-0594-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
674	METALMECANICA	06-0060-11	COMPUTADORA LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00427
675	PALMAS	06-0515-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
676	SUPREMA	06-0590-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
677	PALMAS	06-0513-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
678	PALMAS	06-0514-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6617.25	15	CORP-00848
679	PALMAS	RE0306044	FAJAS DENTADAS # CX-90	Repuestos y componentes mecánicos	Mantenimiento industrial	C	547.5952	23	CORP-00605
680	PALMAS	06-0442-01	CAMARA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6451.5268	29	CORP-00232
681	SUPREMA	06-0545-02	CAMARA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6451.5268	36	CORP-00232
682	SUPREMA	06-0531-02	AUTOCLAVE ELECTRICO DE 25 O 26 LITROS	Materiales eléctricos	Mantenimiento industrial	C	6428.5714	4	CORP-00097
683	SUPREMA	RE0201025	CABLE TSJ 3x10	Materiales eléctricos	Mantenimiento industrial	C	32.0312	17	CORP-00186
684	PALMAS	RE0317110	TUBO DE EJE (ND-EXT) SSP 658B	Repuestos y componentes mecánicos	Bodega central (stock)	C	3196.6071	15	CORP-01295
685	SUPREMA	06-0544-02	LAPTOP HP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6370	19	CORP-00849
686	PALMAS	MA0107022	ELECTRODO HIERRO FUNDIDO 6040 1/8 = MAXWELD E-333	Herramientas	Bodega central (stock)	C	11.7219	22	CORP-00495
687	PALMAS	06-0429-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6343.75	12	CORP-00848
688	PALMAS	06-0421-01	GATEWAY	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6339.2857	27	CORP-00745
689	PALMAS	05-0577-01	CAMARA REFRIGERANTE DE 16'	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6319.6429	12	CORP-00234
690	PALMAS	RE0302082	COJINETE No. 23226-E 1A-XL-M-C3  (DESFRUTADORA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6312.5	16	CORP-00380
691	PALMAS	RE0317107	CONO DE PRENSA SEMI SSP 404	Repuestos y componentes mecánicos	Bodega central (stock)	C	3138.5491	15	CORP-00435
692	PALMAS	RE0302090	COJINETE No. 6312 2RS  (60 X 130 X 31 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	522.3214	24	CORP-00412
693	PALMAS	RE0201126	CABLE ASBESTADO PARA ALTA TEMPERATURA CALIBRE # 6	Materiales eléctricos	Bodega central (stock)	C	62.5	11	CORP-00181
694	PALMAS	06-0453-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.6594	42	CORP-00848
695	PALMAS	06-0476-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
696	SUPREMA	06-0571-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
697	SUPREMA	06-0578-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
698	SUPREMA	06-0572-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
699	PALMAS	06-0475-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
700	PALMAS	06-0462-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
701	PALMAS	06-0461-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
702	PALMAS	06-0460-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
703	PALMAS	06-0459-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
704	PALMAS	06-0458-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
705	PALMAS	06-0457-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
706	PALMAS	06-0456-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
707	PALMAS	06-0464-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
708	PALMAS	06-0450-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
709	PALMAS	06-0454-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
710	SUPREMA	06-0576-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
711	SUPREMA	06-0573-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
712	SUPREMA	06-0577-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
713	SUPREMA	06-0575-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
714	SUPREMA	06-0574-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
715	PALMAS	06-0455-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	42	CORP-00848
716	PALMAS	06-0466-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
717	PALMAS	06-0467-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
718	PALMAS	06-0465-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
719	PALMAS	06-0468-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
720	PALMAS	06-0463-01	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	27	CORP-00848
721	SUPREMA	06-0580-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
722	SUPREMA	06-0579-02	LAPTOP	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	6247.5228	38	CORP-00848
723	PALMAS	RE0314057	MAIN SHAFT R.H.S P/1522 (CONDUCIDO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6232.5315	15	CORP-00910
724	SUPREMA	RE0305011	MANOMETRO DE 0-160 PSI, 3" DIAL, 1/4" NPT, CON GLICERINA	Insumos químicos de producción	Producción / Planta	C	151.9146	24	CORP-00918
725	PALMAS	MA0102132	CHEQUE INOX. 2" TIPO T = CHEQUE WAFER DOBLE CORTINA INOX. CLASE 150D	Ferretería general	Bodega central (stock)	C	1235.7143	58	CORP-00281
726	SUPREMA	RE0201190	VARIADOR MARCA SIEMENS SINAMIC V20 MODELO 6SL3210-5BE27-5UV0 POTENCIA 10HP 380-480VAC	Materiales eléctricos	Mantenimiento industrial	C	6139.2857	17	CORP-01375
727	PALMAS	08-0122-01	PISTOLA IMPACTO INALAMBRICA 3/4"	Herramientas	Flota, maquinaria y combustible	C	6071.4286	12	CORP-00996
728	SAN JORGE	MA0104027	CLAMP MC - 42MM	Ferretería general	Agrícola (fincas)	C	120.5357	163	CORP-00334
729	PALMAS	07-0138-01	PICK UP MITSUBISHI 2024	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	6024.1071	1	CORP-00987
730	PALMAS	RE0306071	FAJA HULE Y LONA NEGRA DE  1/4 X 8  (RESISTENTE ACEITE Y TEMPERATURA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	39.0625	5	CORP-00567
731	SUPREMA	RE0317241	BOQUILLA MOTRIZ Y JUEGO DE JUNTAS TD 02043100	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5998.283	1	CORP-00149
732	SUPREMA	RE0317086	GREASE SEAL REAR (PARTE 9603013)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	595.7766	51	CORP-00755
733	PALMAS	RE0317017	LONA CRUDA 50 ANCHO (YARDA)	Papelería, oficina y cómputo	Administración y oficinas	C	46.9635	17	CORP-00904
734	PALMAS	07-0133-01	PICK-UP TOYOTA  HILUX MODELO 2022	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	5912.6786	15	CORP-00988
735	SUPREMA	RE0201012	BOTONERA STAR-STOP C/BOMBILLA T/LED 120V COMPLETA	Materiales eléctricos	Mantenimiento industrial	C	388.3929	17	CORP-00155
736	SUPREMA	06-0585-02	CODIFICADORA DE CAJAS	Material de empaque	Producción / Planta	C	5803.5714	2	CORP-00337
737	SUPREMA	RE0310011	THINER LACA	Ferretería general	Mantenimiento industrial	C	52.6786	17	CORP-01205
738	PALMAS	RE0101069	FILTRO ACEITE # RE-504836	Repuestos y componentes mecánicos	Bodega central (stock)	C	261.7411	15	CORP-00616
739	PALMAS	RE0302058	COJINETE No. 6311 2RS  (55 X 120 X 29 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	407.0077	14	CORP-00411
740	GABIOSA	08-0006-13	CORTASETOS HUSQVARNA MODELO 525HE4, CILINDRADA 25.4 CM³, POTENCIA DE MOTOR: 1.3 HP, VOLUMEN DEL TANQUE 0.5 L, PESO: 6.3 KG (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	5647.32	15	CORP-00444
741	SUPREMA	MA0106054	HEXANO	Insumos químicos de producción	Calidad y laboratorio	C	176.3393	38	CORP-00776
742	PALMAS	IN0102018	CAJA INVICTO GENERICO 300 GRS 12 UNIDADES	Material de empaque	Producción / Planta	C	1.4084	16	CORP-00213
743	PALMAS	MA0105028	ACEITE 80W-90 MARCA UNO	Combustibles y lubricantes	Flota, maquinaria y combustible	C	91.9869	11	CORP-00011
744	PALMAS	08-0092-01	POLIPASTO DE CADENA 5 TONS. MARCA YALE CON 10' DE CADENA (VER ANEXO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	5592.8571	7	CORP-01003
745	SUPREMA	MA0110004	DETERGENTE POLVO (NOVIEMBRE)	Limpieza e higiene	Servicios generales y limpieza	C	3.9824	57	CORP-00463
746	SUPREMA	RE0317196	JUNTA DE ORIFICIO DE MANO PARA CALDERA MEDIDA 88X102 MATERIAL EMBALAJE DE GRAFITO CON ANILLO DE METAL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	292.0893	15	CORP-00824
747	PALMAS	RE0302080	CHUMACERA BANCO SE 510-608 CON COJINETE Y MANGUITO FIJACION 45 MM.	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1363.8393	15	CORP-00290
748	PALMAS	RE0317106	PANTALLA SEMICIRCULAR INFERIOR DE JAULA SSP 657	Repuestos y componentes mecánicos	Bodega central (stock)	C	2680.9152	15	CORP-00968
749	SAN FRANCISCO	MA0102070	PILOTO REGULADOR DE 3 VÍAS BERMAD COLOR ROJO	Ferretería general	Flota, maquinaria y combustible	C	357.1429	61	CORP-00989
750	PALMAS	IN0202002	ACIDO CITRICO	Insumos químicos de producción	Producción / Planta	C	7.6403	12	CORP-00038
751	PALMAS	RE0314035	EXPELLER ARMS VDP3015 (PRENSAS)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1326.2504	15	CORP-00561
752	PALMAS	RE0304038	VELLUMOIDE 1/16 (PIE CUADRADO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	63.4929	14	CORP-01381
753	SUPREMA	RE0317061	SIHI P/N 20022156, SHAFT (EJE)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5250.3549	15	CORP-01113
754	SUPREMA	RE0317208	VALVULA DE SEGURIDAD 2" DE DEAREADOR	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2618.7316	15	CORP-01343
755	PALMAS	RE0306001	CABLE ACERADO 1/2 (MTS)	Materiales eléctricos	Bodega central (stock)	C	25.8929	8	CORP-00180
756	SUPREMA	RE0317195	JUNTA DE REGISTRO PARA TAMBORES DE CALDERA MEDIDA 300X400 MATERIAL EMBALAJE DE GRAFITO CON ANILLO DE METAL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	735.2593	15	CORP-00825
757	SUPREMA	MA0109005	POMO DE SUPER BONDER	Combustibles y lubricantes	Flota, maquinaria y combustible	C	102.6786	13	CORP-01011
758	SUPREMA	06-0518-02	CAMARA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	5088.3929	1	CORP-00232
759	SAN ANTONIO	05-0035-05	BUZON EN MADERA DE PALO BLANCO	Construcción y obra civil	Infraestructura y obra civil	C	2500	15	CORP-00175
760	PALMAS	RE0302068	COJINETE No. GN 207 KRRB = UEL 312-207	Repuestos y componentes mecánicos	Bodega central (stock)	C	2493.3036	88	CORP-00418
761	GRS	MA0105001	ACEITE 15W-40 MARCA UNO	Combustibles y lubricantes	Flota, maquinaria y combustible	C	90.1601	23	CORP-00009
762	ACACIAS	MA0102004	ADAPTADOR INYECTADO 3/4" LISO A 1/2" CON ROSCA	Construcción y obra civil	Flota, maquinaria y combustible	C	2.0427	65	CORP-00047
763	PALMAS	RE0201114	BOMBILLA AHORRADORA TIPO ESPIRAL 105 WATTS	Materiales eléctricos	Bodega central (stock)	C	75.8929	16	CORP-00143
764	ACACIAS	MA0105004	ACEITE SPIRAX HD SAE No. 85W-140 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	89.651	25	CORP-00027
765	PALMAS	RE0101099	FILTRO DIESEL # 1770A233	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	821.4286	27	CORP-00644
766	PALMAS	RE0101096	FILTRO DIESEL # 1770A194=1770A379	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	821.4286	27	CORP-00643
767	METALMECANICA	AV10110010112	PORTAMUESTRAS DE VIDRIO 40 MM. (CONTIENE 30 TUBOS)	Construcción y obra civil	Infraestructura y obra civil	C	4917.8571	44	CORP-01014
768	PALMAS	RE0304022	NEOLITE 1/4 GRUESO (PIE²)	Construcción y obra civil	Infraestructura y obra civil	C	77.9476	21	CORP-00945
769	SUPREMA	08-0287-02	SOPLADORA BR420 DE MOCHILA A GASOLINA	Herramientas	Mantenimiento industrial	C	4908.9286	4	CORP-01131
770	SUPREMA	RE0317060	CARTUCHO DE TINTA NEGRA IMA202-Z-(1) 800 mL CODIFICADORA ZANAZI	Papelería, oficina y cómputo	Administración y oficinas	C	814.2857	27	CORP-00257
771	PALMAS	RE0317012	ACOPLAMIENTO No. L-110 = L-125 LOVEJOY	Repuestos y componentes mecánicos	Bodega central (stock)	C	806.9673	25	CORP-00042
772	SUPREMA	MA0107016	LBS. DE ELECTRODO INOXIDABLE 3/32 308L	Herramientas	Mantenimiento industrial	C	62.7551	7	CORP-00871
773	SUPREMA	RE0306011	FAJA DENTADA 150L075 No. PARTE 1099-232	Repuestos y componentes mecánicos	Mantenimiento industrial	C	301.8415	23	CORP-00565
774	SUPREMA	IN0201009	LECITINA DE SOYA	Materia prima	Producción / Planta	C	19.672	3	CORP-00875
775	PALMAS	RE0302069	COJINETE No. GN 215 KRR, EJE 2.15/16	Repuestos y componentes mecánicos	Bodega central (stock)	C	2391.0714	15	CORP-00419
776	SUPREMA	RE0101008	FILTRO AIRE 17801 78020 (ABRIL)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	317.8571	37	CORP-00619
777	SUPREMA	MA0107020	LBS. ELECTRODO ACERO INOXIDABLE 1/8 309L	Herramientas	Mantenimiento industrial	C	61.4541	7	CORP-00872
778	PALMAS	RE0312021	BRUSH HELDER PART. 8 (BRUSH)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2362.014	15	CORP-00164
779	ACACIAS	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	19.1368	16	CORP-00747
780	SUPREMA	05-0576-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	4665.1696	3	CORP-00059
781	QUIRICA	MA0102012	ADAPTADOR INYECTADO 3/4" LISO A 1/2" CON ROSCA	Construcción y obra civil	Flota, maquinaria y combustible	C	1.9296	65	CORP-00047
782	SUPREMA	RE0101019	FILTRO TRAMPA AGUA 33349 WIX (ABRIL)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	158.0357	33	CORP-00662
783	PALMAS	08-0094-01	CINTA METRICA PLOMADA	Herramientas	Mantenimiento industrial	C	4575.8929	15	CORP-00317
784	SUPREMA	MA0106042	DESINFECTANTE QUAT 256 (RC QUIMICA)	Limpieza e higiene	Servicios generales y limpieza	C	190.1429	13	CORP-00461
785	PALMAS	04-0752-01	BOMBA DOSIFICADORA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4553.5714	15	CORP-00133
786	PALMAS	RE0302099	COJINETE No. 22314 E/C3 = NJ2314 ECPC4  (TAMIZ CIRCULAR 60")	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2237.3661	28	CORP-00379
787	PALMAS	06-0449-01	UPS	Materiales eléctricos	Mantenimiento industrial	C	4464.2857	9	CORP-01330
788	PALMAS	05-0621-01	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	4464.2768	15	CORP-00059
789	SUPREMA	05-0550-02	TELEVISOR	Papelería, oficina y cómputo	Administración y oficinas	C	4455.3571	7	CORP-01184
790	SUPREMA	05-0549-02	TELEVISOR	Papelería, oficina y cómputo	Administración y oficinas	C	4455.3571	7	CORP-01184
791	PALMAS	MA0102105	VALVULA HN 2 TIPO COMPUERTA (ROSCADA, 150 PSI)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	736.6071	58	CORP-01358
792	PALMAS	06-0489-01	IMPRESORA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	4419.6429	7	CORP-00787
793	PALMAS	06-0478-01	CAMARA FOTOGRAFICA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	4419.6429	15	CORP-00233
794	PALMAS	MA0104079	LAMINA LISA H.N. 1 X 4 X 8	Construcción y obra civil	Infraestructura y obra civil	C	4405.2679	12	CORP-00840
795	SUPREMA	IN0102090	CAJA ACEITE PRIMOR 6X3000 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	4387.958	15	CORP-00210
796	PALMAS	05-0597-01	DUCHA CON LAVA OJOS	Papelería, oficina y cómputo	Administración y oficinas	C	4375	9	CORP-00488
797	SAN ANTONIO	IN0301016	NOMOLT 15SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	436.9379	42	CORP-00947
798	PALMAS	06-0427-01	FORTIGATE	Papelería, oficina y cómputo	Administración y oficinas	C	4360.5	8	CORP-00709
799	SUPREMA	IN0106029	TAPA BLANCA  400 ML, 750 ML, 800 ML, 900 ML (NUEVA IMAGEN)	Material de empaque	Producción / Planta	C	120.4192	54	CORP-01165
800	PALMAS	06-0420-01	MULTIFUNCIONAL CANON MAXIFY GX7010 (VER ANEXO)	Papelería, oficina y cómputo	Administración y oficinas	C	4330.3571	11	CORP-00944
801	PALMAS	06-0418-01	IMPRESORA MULTIFUNCIONAL CANON MAXIFY GX7010 (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	4330.3571	11	CORP-00792
802	TASINSA	08-0272-09	CINTA METRICA	Herramientas	Mantenimiento industrial	C	4285.7143	30	CORP-00315
803	SUPREMA	RE0101026	FILTRO DE AIRE WIX 46932	Repuestos y componentes mecánicos	Mantenimiento industrial	C	428.5714	25	CORP-00638
804	SAN ANTONIO	MA0201002	MELAZA	Ganadería y alimento animal	Ganadería	C	5.3571	65	CORP-00925
805	TASINSA	06-0081-09	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	4284	65	CORP-01150
806	SUPREMA	RE0317082	ACOPLE FLEXIBLE  LEVOY S-FLEX JN No.7 COMPLETO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2133.9286	27	CORP-00043
807	ALFA	MA0104007	TUBO PVC 3/4 X 20'  (200 PSI.)	Construcción y obra civil	Flota, maquinaria y combustible	C	14.2042	43	CORP-01314
808	PALMAS	RE0314006	4WMM6H-6XR1/F HAND CONTROL VALVE//12  (PRENSA CB15T)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	4235.1165	15	CORP-00005
809	PALMAS	RE0201125	CINTA SCOTCH No. 27  3M (ROLLO)	Ferretería general	Bodega central (stock)	C	167.5	13	CORP-00323
810	PALMAS	RE0302081	CHUMACERA PARED # F-209 CON COJINETE Y MANGUITO FIJACION 40 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	464.628	17	CORP-00295
811	PALMAS	RE0309012	LAZO PLASTICO 1  (LBS.)	Ferretería general	Bodega central (stock)	C	16.5893	20	CORP-00864
812	PALMAS	08-0189-01	ESMERILADORA INALAMBRICA M 18 4.1/2"	Herramientas	Flota, maquinaria y combustible	C	4107.1429	27	CORP-00540
813	PALMAS	MA0104083	TUBING H.N. 3/16" X 3" X 3" X 20'	Ferretería general	Mantenimiento industrial	C	683.0357	50	CORP-01292
814	QUIRICA	MA0101041	FUNDA CUERO PARA MALAYO	Herramientas	Agrícola (fincas)	C	116.0714	34	CORP-00724
815	ACACIAS	MA0101041	FUNDA CUERO PARA MALAYO	Herramientas	Agrícola (fincas)	C	116.0714	18	CORP-00724
816	PALMAS	RE0304065	SELLO MECANICO 1.1/4"" TIPO 21""	Repuestos y componentes mecánicos	Bodega central (stock)	C	174.1071	13	CORP-01093
817	PALMAS	RE0101053	FILTRO DIESEL Y GASOLINA 70012 300-30 GASOLINERA	Repuestos y componentes mecánicos	Bodega central (stock)	C	285.0102	29	CORP-00652
818	SUPREMA	RE0317184	CANDADO TUERCA M12 PARA CADENA TRANSPORTADOR DE CENIZA CALDERA MAX TWO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	90.6484	22	CORP-00240
819	SUPREMA	06-0542-02	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	3977.3839	7	CORP-01150
820	SUPREMA	06-0543-02	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	3977.3839	7	CORP-01150
821	ACACIAS	MA0105007	ACEITE RIMULA No. SAE-50 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	72.2909	25	CORP-00022
822	SAN FRANCISCO	IN0301002	HERBICIDA DESPOTA	Fertilizantes y agroquímicos	Agrícola (fincas)	C	39.75	17	CORP-00772
823	PALMAS	RE0317105	ANILLO SEMICIRCULAR SUPERIOR DE JAULA SSP 402	Repuestos y componentes mecánicos	Bodega central (stock)	C	1984.2188	15	CORP-00084
824	PALMAS	08-0200-01	PISTOLA ENGRASADORA	Ferretería general	Mantenimiento industrial	C	3967.3571	15	CORP-00995
825	SUPREMA	05-0547-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	3936.4286	9	CORP-00059
826	ACACIAS	MA0105005	ACEITE UNO SPIRAX S4 CX 10W TO-4 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	71.5272	16	CORP-00030
827	SAN ANTONIO	MA0105006	ACEITE UNO SPIRAX S4 TXM 10W-30 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	71.5272	13	CORP-00031
828	SUPREMA	MA0102116	VALVULA INOX 3 PASO RAPIDO SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1955.3571	23	CORP-01369
829	SUPREMA	RE0201191	CINTA FONDO AMARILLO LETRA NEGRA 0.5X21 No M21-375-595-YL PARA ETIQUETADORA BRADY	Material de empaque	Producción / Planta	C	388.3929	13	CORP-00313
830	PALMAS	05-0610-01	BOMBA MOBIBLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3812.5	5	CORP-00135
831	PALMAS	RE0312024	MAIN SHAFT (DEL CEPILLO) ITEM 5	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1902.6698	15	CORP-00906
832	PALMAS	MA0104011	HEMBRA H.N. 1/4 X 6 X 20	Ferretería general	Bodega central (stock)	C	475.1339	4	CORP-00767
833	SUPREMA	MA0110019	CORROSTYL-SA	Insumos químicos de producción	Producción / Planta	C	75.8929	15	CORP-00443
834	SUPREMA	RE0305012	MANOMETRO DE 0- 60 PSI, 3" DIAL, 1/4" NPT, CON GLICERINA	Insumos químicos de producción	Producción / Planta	C	139.881	24	CORP-00919
835	PALMAS	MA0106016	ALCOHOL ETILICO INDUSTRIAL 96%	Limpieza e higiene	Servicios generales y limpieza	C	9.44	12	CORP-00067
836	PALMAS	05-0618-01	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	3770.8304	15	CORP-00059
837	SUPREMA	RE0317185	BARRA RASCADORA 100X538MM PARA TRANSPORTADOR DE CENIZA	Ferretería general	Mantenimiento industrial	C	221.585	22	CORP-00109
838	SUPREMA	RE0201055	CONTACTOR 3RT1045 TRIFASICO SIEMENS BOBINA 110 V	Materiales eléctricos	Mantenimiento industrial	C	1875	16	CORP-00436
839	PALMAS	MA0102152	TUBO INOX. 1 X 20 CEDULA-40	Ferretería general	Mantenimiento industrial	C	372.4107	36	CORP-01305
840	PALMAS	RE0314004	4WE6D-6X/EW 230N99K4 SELENOIDE VALVE//14  (PRENSA CB10T/KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3718.8945	15	CORP-00003
841	PALMAS	05-0592-01	RADIO PORTATIL INCLUYE AUDIFONOS HELICOIDALES	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3696.4286	25	CORP-01028
842	SAN ANTONIO	IN0305015	FÓRMULA 1 (45.36kg)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	216.7955	21	CORP-00681
843	PALMAS	RE0314049	SPACER P/1024	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1226.601	15	CORP-01133
844	SUPREMA	RE0304001	BANDA DE TEFLON 01 DE ANCHO 34 DE LARGO (SELLADORA DOY PACK BAND RITE MODELO 6000-4222-000)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	305.3571	28	CORP-00102
845	PALMAS	RE0317002	VALVULA MCDONAL 1/2 VISOR NIVEL CALDERA (JGO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	915.1793	17	CORP-01373
846	SUPREMA	RE0201184	CONTROLADOR DE TEMPERATURA MARCA OMRON MODELO E5CC	Materiales eléctricos	Mantenimiento industrial	C	1205.3571	18	CORP-00438
847	SUPREMA	MA0106051	DIMETILAMINA AL 40 %	Construcción y obra civil	Infraestructura y obra civil	C	3610	15	CORP-00468
848	GRS	05-0132-10	SIST MINI-SPLIT 24KBTU 220-230/1 R410	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	3571.4286	15	CORP-01123
849	SUPREMA	RE0201174	GUARDAMOTOR TRIFASICO SIEMENS 35-45AMP, 22KW, 480VAC, TAMAÑO S2, 3RV2031-4VA10	Materiales eléctricos	Mantenimiento industrial	C	1785.7143	17	CORP-00761
850	PALMAS	RE0312016	RELES DE 8 PINES BOBINA 110/120V OMRON  (DESARENADOR)	Materiales eléctricos	Mantenimiento industrial	C	445.7655	15	CORP-01041
851	PALMAS	MA0102106	VALVULA HN 2 TIPO COMPUERTA (SOLDABLE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	710.5089	13	CORP-01359
852	PALMAS	RE0303044	BARRA BRONCE  2.1/4 FOSFORADO	Ferretería general	Bodega central (stock)	C	73.9397	22	CORP-00108
853	PALMAS	RE0201045	GUARDAMOTOR SIEMENS 7-10 AMPERIOS No. 3RV1021-1JA10	Materiales eléctricos	Bodega central (stock)	C	709.8214	8	CORP-00759
854	GRS	MA0104030	TUBO PVC DE  4 160 PSI	Construcción y obra civil	Infraestructura y obra civil	C	352.6786	22	CORP-01316
855	ACACIAS	IN0302006	ADHERENTE DISAWET MAX	Fertilizantes y agroquímicos	Agrícola (fincas)	C	87.753	21	CORP-00055
856	PALMAS	RE0314054	STRAINER P/1014	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3495.744	15	CORP-01148
857	PALMAS	RE0314056	STRAINER P/1514	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3495.744	15	CORP-01149
858	PALMAS	RE0102025	TUBO LLANTA 1000 X 20	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	174.1071	16	CORP-01307
859	SUPREMA	RE0201102	LAMPARA IP65 CON DOS TUBOS T8 32 WATSS (CONTRA POLVO Y HUMEDAD) COMPLETA	Materiales eléctricos	Mantenimiento industrial	C	171.875	16	CORP-00845
860	PALMAS	RE0311024	OIL SEAL 100 x 130 x 12 (P/9)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	142.5332	15	CORP-00958
861	PALMAS	RE0102021	TUBO LLANTA 900 X 20	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	169.6429	16	CORP-01309
862	SUPREMA	RE0305010	MEDIDOR DE VACIO ANALOGO 0 A -30 INHG, 1/4" NPT CARATULA 3.5"	Materiales eléctricos	Mantenimiento industrial	C	375.9643	24	CORP-00924
863	SUPREMA	RE0301035	SPRAY ESPUMA DE POLIURETANO 480 GRAMOS	Ferretería general	Mantenimiento industrial	C	119.7704	26	CORP-01140
864	SUPREMA	RE0201128	TUBO LED T8 PARA LAMPARA	Materiales eléctricos	Mantenimiento industrial	C	22.3214	18	CORP-01306
865	SUPREMA	RE0302049	COJINETE 6312 ZZ	Repuestos y componentes mecánicos	Mantenimiento industrial	C	370.5357	15	CORP-00369
866	SUPREMA	RE0304139	DOOR GASKET 1200 EPDM NO. PARTE 76264366	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1665.3777	117	CORP-00487
867	PALMAS	05-0556-01	AIRE ACONDICIONADO DE 24KBTU SIST MINI-SPLIT 24KTBU 220-230/1 R410 SEER13 OASIS PRO INNOVAIR (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	3310.1786	8	CORP-00062
868	METALMECANICA	08-0318-11	EQUIPO DE OXICORTE	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	3294.6429	12	CORP-00534
869	PALMAS	RE0302101	COJINETE No. 6314 2RS  (70 X 150 X 35 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	812.5	12	CORP-00414
870	PALMAS	RE0317029	ACOPLAMIENTO # L-150 LOVEJOY	Repuestos y componentes mecánicos	Bodega central (stock)	C	649.7232	18	CORP-00040
871	PALMAS	RE0306054	CADENA 80-3  (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	162.1125	20	CORP-00189
872	SAN JORGE	MA0201002	MELAZA	Ganadería y alimento animal	Ganadería	C	5.3571	62	CORP-00925
873	PALMAS	RE0101097	FILTRO AIRE # 1500A098=MZ690446	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	531.25	27	CORP-00618
874	PALMAS	05-0596-01	ESCALERA	Herramientas	Mantenimiento industrial	C	3180.8036	17	CORP-00535
875	PALMAS	08-0093-01	COSEDORA	Ferretería general	Mantenimiento industrial	C	3125	10	CORP-00445
876	SUPREMA	MA0110022	H-40is	Insumos químicos de producción	Producción / Planta	C	156.25	15	CORP-00762
877	PALMAS	08-0095-01	ARRANCADOR TRANSPORTE PESADO	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	3125	13	CORP-00095
878	SUPREMA	06-0529-02	CARRO DE CURACIONES FABRINOX	Ferretería general	Mantenimiento industrial	C	3125	4	CORP-00256
879	PALMAS	04-0709-01	PALLET MANUAL	Material de empaque	Producción / Planta	C	3125	2	CORP-00961
880	PALMAS	08-0126-01	CARRO DE CURACIONES	Ferretería general	Mantenimiento industrial	C	3125	4	CORP-00255
881	PALMAS	08-0187-01	KIT DE PRUEBA DE PRESIÓN HIDRÁULICA 600 BAR / 10,000 PSI /60 MPA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	3125	32	CORP-00829
882	SUPREMA	RE0201192	CINTA FONDO BLANCO LETRA NEGRA 0.375X16 No M21-375-499-YL PARA ETIQUETADORA BRADY	Material de empaque	Producción / Planta	C	388.3929	13	CORP-00314
883	GRS	RE0109002	PEGAMENTO PARA PVC 1/4 GALÓN MARCA TANGIT TODA PRESION	Construcción y obra civil	Infraestructura y obra civil	C	155.3571	32	CORP-00979
884	QUIRICA	IN0302006	ADHERENTE DISAWET MAX	Fertilizantes y agroquímicos	Agrícola (fincas)	C	91.1853	17	CORP-00055
885	PALMAS	05-0569-01	SILLON	Papelería, oficina y cómputo	Administración y oficinas	C	3080.3571	62	CORP-01121
886	GRS	MA0103002	TABLA DE PINO 1"x1'x12' DE LARGO	Construcción y obra civil	Infraestructura y obra civil	C	101.7857	64	CORP-01153
887	PALMAS	RE0311003	LEAD RING STORK P/45A	Repuestos y componentes mecánicos	Mantenimiento industrial	C	31.7031	15	CORP-00874
888	SAN JORGE	MA0104026	CLAMP MC - 38MM	Ferretería general	Agrícola (fincas)	C	120.5357	116	CORP-00333
889	SUPREMA	05-0572-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
890	SUPREMA	05-0569-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
891	SUPREMA	05-0570-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
892	SUPREMA	05-0568-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
893	SUPREMA	05-0573-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
894	SUPREMA	05-0571-02	RADIO PORTATIL MOTOROLA	Herramientas	Mantenimiento industrial	C	2991.0714	7	CORP-01029
895	PALMAS	MA0102125	VALVULA HN 2 TIPO PASO RAPIDO (ROSCADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	332.2421	35	CORP-01360
896	SUPREMA	MA0107047	ACETILENO	Ferretería general	Mantenimiento industrial	C	3.0282	6	CORP-00037
897	PALMAS	04-0731-01	BOMBA SUMERGIBLE 7.5HP	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2946.4286	12	CORP-00137
898	PALMAS	06-0428-01	IMPRESORA EPSON ECOTANK L5590 MULTIFUNCIONAL INALÁMBRICA CON WIFI (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Calidad y laboratorio	C	2901.7857	13	CORP-00788
899	PALMAS	06-0432-01	IMPRESORA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2901.7857	5	CORP-00787
900	PALMAS	RE0310009	PINTURA ANTICORROSIVA (GLS)	Construcción y obra civil	Infraestructura y obra civil	C	142.8571	23	CORP-00990
901	PALMAS	RE0302067	COJINETE No. G 1203 KRRB = UEL 211-203	Repuestos y componentes mecánicos	Bodega central (stock)	C	569.6429	15	CORP-00417
902	GRS	RE0309003	TELA TEFLÓN PARA SELLADORA	Construcción y obra civil	Infraestructura y obra civil	C	218.75	32	CORP-01183
903	METALMECANICA	08-0312-11	JUEGO DE TALADRO PERCUTOR/DESTOR DE 1/2" M18 FUEL MARCA MILWAUKEE (VER ANEXO)	Herramientas	Mantenimiento industrial	C	2834.8214	32	CORP-00822
904	PALMAS	RE0317095	CUCHILLA RASPADORA IZQUIERDA - S(4T) SSP 651L	Repuestos y componentes mecánicos	Bodega central (stock)	C	2814.1071	36	CORP-00449
905	PALMAS	RE0317096	CUCHILLA RASPADORA DERECHA - S(2T) SSP 651R	Repuestos y componentes mecánicos	Bodega central (stock)	C	2814.1071	15	CORP-00448
906	PALMAS	RE0314030	FILTER ELEMENT- FOR RETURN LINE FILTER  (PRENSA CB10T/KWYP10)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	703.341	15	CORP-00608
907	GRS	IN0101004	BOLSAS  TRANSPARENTES DE 25 LBS CAL. 6	Material de empaque	Producción / Planta	C	1.1161	59	CORP-00131
908	PALMAS	RE0306003	CADENA 80-1 (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	55.7679	15	CORP-00187
909	SAN FRANCISCO	MA0101041	FUNDA CUERO PARA MALAYO	Herramientas	Agrícola (fincas)	C	116.0714	43	CORP-00724
910	SAN JORGE	MA0101041	FUNDA CUERO PARA MALAYO	Herramientas	Agrícola (fincas)	C	116.0714	34	CORP-00724
911	SAN ANTONIO	MA0101041	FUNDA CUERO PARA MALAYO	Herramientas	Agrícola (fincas)	C	116.0714	43	CORP-00724
912	PALMAS	05-0599-01	AIRE ACONDICIONADO 18BTU	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2773.4018	37	CORP-00060
913	SUPREMA	MA0102109	VALVULA HN 2 COMPUERTA ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	685.0893	25	CORP-01356
914	PALMAS	MA0102141	TUBO H.N. 1 X 20 CEDULA-40 SIN COSTURA	Ferretería general	Bodega central (stock)	C	194.6429	21	CORP-01301
915	SAN ANTONIO	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	Ferretería general	Agrícola (fincas)	C	301.5873	35	CORP-00066
916	PALMAS	RE0302045	COJINETE No. 6217 2RS  (85 X 150 X 28 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	903.5714	29	CORP-00400
917	METALMECANICA	RE0309137	GUANTES CUERO MEDIA MANGA  (HILO KEVLAR, ENGUATADOS COLOR AZUL)	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	46.4286	15	CORP-00757
918	PALMAS	RE0312017	TYMER 8 PINES 24-240V DE 0 A 60 SEG  (DESARENADOR)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	446.4321	15	CORP-01322
919	SUPREMA	RE0304087	LAMINA DE FIBRA SINTETICA 1940K 1/4" 60"X60" GDO. ALIMENTICIO	Construcción y obra civil	Infraestructura y obra civil	C	2678.5714	15	CORP-00833
920	SUPREMA	05-0551-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2678.5714	16	CORP-00059
921	SUPREMA	RE0201031	CINTA SCOTCH 23	Ferretería general	Mantenimiento industrial	C	133.9286	11	CORP-00319
922	SUPREMA	RE0307004	ABRAZADERA INDUSTRIAL PARA MANGUERA 01 (MARCA BREEZE)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	26.7857	10	CORP-00008
923	GRS	RE0307004	MANGUERA PLÁSTICA TRANSPARENTE  DE 1.1/4	Repuestos y componentes mecánicos	Mantenimiento industrial	C	17.8571	42	CORP-00914
924	PALMAS	05-0586-01	GABINETE PARA HERRAMIENTA	Herramientas	Mantenimiento industrial	C	2677.6786	15	CORP-00735
925	PALMAS	05-0582-01	GABINETE PARA HERRAMIENTA	Herramientas	Mantenimiento industrial	C	2677.6786	12	CORP-00735
926	PALMAS	05-0584-01	GABINETE PARA HERRAMIENTA	Herramientas	Mantenimiento industrial	C	2677.6786	45	CORP-00735
927	PALMAS	05-0585-01	GABINETE PARA HERRAMIENTA	Herramientas	Mantenimiento industrial	C	2677.6786	15	CORP-00735
928	PALMAS	05-0583-01	GABINETE PARA HERRAMIENTA	Herramientas	Mantenimiento industrial	C	2677.6786	86	CORP-00735
929	SUPREMA	06-0546-02	IMPRESORA EPSON L5590	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2674.1071	8	CORP-00790
930	SUPREMA	06-0565-02	IMPRESORA EPSON L5590	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2674.1071	8	CORP-00790
931	SUPREMA	06-0548-02	IMPRESORA EPSON L5590	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2674.1071	8	CORP-00790
932	SUPREMA	06-0547-02	IMPRESORA EPSON L5590	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2674.1071	8	CORP-00790
933	SAN ANTONIO	IN0305003	FORMULA 1	Fertilizantes y agroquímicos	Agrícola (fincas)	C	178.2723	41	CORP-00680
934	PALMAS	05-0563-01	RADIO PORTATIL	Herramientas	Mantenimiento industrial	C	2669.6429	4	CORP-01027
935	PALMAS	05-0565-01	RADIO PORTATIL	Herramientas	Mantenimiento industrial	C	2669.6429	4	CORP-01027
936	PALMAS	05-0564-01	RADIO PORTATIL	Herramientas	Mantenimiento industrial	C	2669.6429	4	CORP-01027
937	SUPREMA	05-0553-02	RADIO TRANSMISOR	Materiales eléctricos	Mantenimiento industrial	C	2669.6429	19	CORP-01030
938	SUPREMA	05-0552-02	RADIO TRANSMISOR	Materiales eléctricos	Mantenimiento industrial	C	2669.6429	19	CORP-01030
939	SUPREMA	06-0525-02	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2669.6429	4	CORP-01154
940	SUPREMA	06-0524-02	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2669.6429	4	CORP-01154
941	SUPREMA	06-0526-02	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2669.6429	4	CORP-01154
942	SUPREMA	06-0522-02	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2669.6429	4	CORP-01154
943	SUPREMA	06-0523-02	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2669.6429	4	CORP-01154
944	PALMAS	05-0551-01	CAMA MATRIMONIAL SUBLIME DOBLE PILLOW FIRME (VER ANEXO)	Papelería, oficina y cómputo	Administración y oficinas	C	2669.6429	13	CORP-00231
945	PALMAS	05-0547-01	CAMA MATRIMONIAL SUBLIME DOBLE PILLOW FIRME (VER ANEXO)	Papelería, oficina y cómputo	Administración y oficinas	C	2669.6429	11	CORP-00231
946	PALMAS	RE0302097	CHUMACERA BANCO COJIN. 2.15/16 SKF No. SY 2.15/16 UTF  (NTN)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	666.9643	41	CORP-00286
947	PALMAS	08-0127-01	TANQUE DE OXIGENO	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2660.7143	4	CORP-01157
948	GRS	RE0306008	FAJAS B-82 SUPER BELT	Repuestos y componentes mecánicos	Mantenimiento industrial	C	82.8125	15	CORP-00594
949	PALMAS	RE0101027	FILTRO AIRE LAF-1849 (FREIGHTLINER)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	658.0357	13	CORP-00624
950	SUPREMA	RE0317101	CARBON DC MOTOR BRUSH (K254C 917)	Ferretería general	Mantenimiento industrial	C	1309.8214	100	CORP-00251
951	ACACIAS	05-0076-03	TELEVISOR SAMSUNG UN50U8000F 50" SMART LED TV 4K ULTRA HD	Materiales eléctricos	Administración y oficinas	C	2597.3214	12	CORP-01187
952	SUPREMA	05-0541-02	TELEVISOR	Papelería, oficina y cómputo	Administración y oficinas	C	2597.3214	14	CORP-01184
953	PALMAS	05-0546-01	TELEVISOR SAMSUNG UN50U8000F 50" SMART LED TV 4K ULTRA HD (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	2597.3214	17	CORP-01188
954	PALMAS	05-0545-01	TELEVISOR SAMSUNG UN50U8000F 50" SMART LED TV 4K ULTRA HD (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	2597.3214	17	CORP-01188
955	SUPREMA	MA0107019	LBS. ELECTRODO H/FUNDIDO 1/8	Herramientas	Mantenimiento industrial	C	258.9286	13	CORP-00873
956	SUPREMA	RE0101013	FILTRO DIESEL 33390 (ABRIL)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	89.2857	34	CORP-00645
957	PALMAS	RE0302008	CHUMACERA PARED SKF No. FY60TF EJE 60 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	644.25	25	CORP-00296
958	SUPREMA	05-0567-02	TV SAMGUNG	Papelería, oficina y cómputo	Administración y oficinas	C	2570.5357	12	CORP-01320
959	PALMAS	MA0102145	TUBO H.N. 3 X 20 CEDULA-80 SIN COSTURA	Ferretería general	Bodega central (stock)	C	1283.4821	24	CORP-01303
960	PALMAS	MA0104073	HEMBRA H.N. 1/2" X 2" X 20'"	Ferretería general	Bodega central (stock)	C	254.7321	7	CORP-00764
961	SUPREMA	RE0101027	FILTRO WIX DIESEL 33231	Repuestos y componentes mecánicos	Mantenimiento industrial	C	254.4643	25	CORP-00666
962	PALMAS	06-0504-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2543.75	15	CORP-01154
963	SAN JORGE	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	Equipo de protección personal (EPP)	Ganadería	C	23.4127	18	CORP-00756
964	SAN FRANCISCO	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	Equipo de protección personal (EPP)	Ganadería	C	23.4127	19	CORP-00756
965	SAN ANTONIO	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	Equipo de protección personal (EPP)	Ganadería	C	23.4127	17	CORP-00756
966	PALMAS	RE0101101	FILTRO DE AIRE SECUNDARIO AT223226	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	1256.6964	15	CORP-00637
967	PALMAS	RE0301011	GAS REFRIGERANTE R-410A (LBS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	100.2	11	CORP-00738
968	PALMAS	04-0688-01	PALLET TRUCK DE ALUMINIO CON CAPACIDAD DE 2500KG CON MEDIDA DE 27X48 CON 2 RUEDAS DIRECCIONALES Y 4 RODILLOS DE CARGA, MARCA H-LIFT JAPAN (VER ANEXO)	Material de empaque	Producción / Planta	C	2500	11	CORP-00962
969	ALFA	05-0016-08	BUZÓN EN MADERA DE PALO BLANCO	Construcción y obra civil	Infraestructura y obra civil	C	2500	15	CORP-00175
970	SAN JORGE	05-0042-04	BUZÓN EN MADERA DE PALO BLANCO	Construcción y obra civil	Infraestructura y obra civil	C	2500	15	CORP-00175
971	PALMAS	06-0479-01	MINI PC STICK WINDOWS 11 PRO	Papelería, oficina y cómputo	Administración y oficinas	C	2491.0714	29	CORP-00930
972	GRS	RE0309034	QUINTAL ALAMBRE LISO GALVANIZADO CALIBRE 12	Ferretería general	Mantenimiento industrial	C	620.5357	29	CORP-01026
973	PALMAS	RE0314051	LEFT HAND COVER P/1031	Repuestos y componentes mecánicos	Mantenimiento industrial	C	820.284	15	CORP-00876
974	SUPREMA	MA0102108	VALVULA HN 2 BOLA SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	409.8214	22	CORP-01355
975	ACACIAS	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Ferretería general	Calidad y laboratorio	C	93.75	21	CORP-00442
976	QUIRICA	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Insumos químicos de producción	Calidad y laboratorio	C	93.75	21	CORP-00442
977	SUPREMA	08-0296-02	ESCALERA DE FIBRA	Herramientas	Mantenimiento industrial	C	2428.5714	30	CORP-00536
978	PALMAS	05-0557-01	AIRE ACONDICIONADO DE 18KBTU, SIST MINI-SPLIT 18KTBU 230/1R410 SEER13 HISENSE (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2424.4821	8	CORP-00061
979	PALMAS	05-0548-01	AIRE ACONDICIONADO SIST MINI-SPLIT 18KBTU 220-230/1 R410 SEER13 OASIS PRO INNOVAIR (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2419.6429	9	CORP-00064
980	PALMAS	RE0101092	FILTRO AIRE LAF 1544 = WIX 42321	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	402.0536	23	CORP-00623
981	GRS	RE0201089	TIMER CJ-1	Materiales eléctricos	Mantenimiento industrial	C	241.0714	80	CORP-01210
982	PALMAS	RE0304058	SELLO MECANICO 1.1/8 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	120.5357	6	CORP-01095
983	PALMAS	05-0552-01	REFRIGERADOR FROST DE 6' PIES, DOS PUERTAS GRIS MARCA MABE (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2406.25	6	CORP-01034
984	SUPREMA	08-0293-02	BARRENO	Herramientas	Mantenimiento industrial	C	2399.5982	10	CORP-00110
985	SAN FRANCISCO	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	Ferretería general	Agrícola (fincas)	C	66.369	12	CORP-00543
986	SAN ANTONIO	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	Ferretería general	Agrícola (fincas)	C	66.369	13	CORP-00543
987	SAN JORGE	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	Ferretería general	Agrícola (fincas)	C	66.369	11	CORP-00543
988	PALMAS	06-0446-01	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	2366.0714	7	CORP-01150
989	PALMAS	06-0445-01	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	2366.0714	7	CORP-01150
990	SUPREMA	RE0304091	PLANCHA DE NEOPRENO 1/4" 4'X4'	Construcción y obra civil	Infraestructura y obra civil	C	1183.0357	12	CORP-00999
991	SUPREMA	RE0317100	CARBON DC MOTOR BRUSH (K174)	Ferretería general	Mantenimiento industrial	C	1169.6429	100	CORP-00250
992	PALMAS	08-0201-01	MANGUERA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2321.4286	15	CORP-00912
993	PALMAS	RE0314050	THRUST RING P/1029a	Repuestos y componentes mecánicos	Mantenimiento industrial	C	772.7265	15	CORP-01207
994	SUPREMA	08-0289-02	MICROMETRO DIGITAL	Herramientas	Mantenimiento industrial	C	2316.9643	76	CORP-00928
995	PALMAS	MA0102142	TUBO H.N. 1.1/2 X 20 CEDULA-40 SIN COSTURA	Ferretería general	Bodega central (stock)	C	289.3527	21	CORP-01300
996	SUPREMA	06-0530-02	SILLA DE RUEDAS	Repuestos y componentes mecánicos	Mantenimiento industrial	C	2299.1071	4	CORP-01118
997	PALMAS	RE0302011	COJINETE No. 22211 EK  (CON MANGUITO FIJACION EJE 50MM)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	574.1071	16	CORP-00372
998	SUPREMA	05-0555-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2289.3304	16	CORP-00059
999	SUPREMA	05-0556-02	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2289.3304	16	CORP-00059
1000	PALMAS	06-0491-01	UPS	Materiales eléctricos	Mantenimiento industrial	C	2285.7143	15	CORP-01330
1001	PALMAS	06-0490-01	UPS	Materiales eléctricos	Mantenimiento industrial	C	2285.7143	15	CORP-01330
1002	SUPREMA	MA0102126	VALVULA COMPUERTA DE 1 1/2,  SOLDABLE HN	Repuestos y componentes mecánicos	Mantenimiento industrial	C	455	20	CORP-01341
1003	SUPREMA	RE0304041	POMO DE SILICONE GRIS GREY 5699 (LOCTITE)	Ferretería general	Mantenimiento industrial	C	37.3214	13	CORP-01008
1004	PALMAS	MA0104074	HEMBRA H.N. 1/2" X 1.1/2" X 20'	Ferretería general	Bodega central (stock)	C	223.2143	12	CORP-00763
1005	SUPREMA	RE0101038	FILTRO DE AIRE 42253	Repuestos y componentes mecánicos	Mantenimiento industrial	C	370.5357	24	CORP-00632
1006	SAN ANTONIO	MA0102012	ADAPTADOR INYECTADO DE 1/2 A 3/4	Construcción y obra civil	Flota, maquinaria y combustible	C	1.7679	69	CORP-00048
1007	PALMAS	RE0314052	RIGHT HAND COVER P/1032	Repuestos y componentes mecánicos	Mantenimiento industrial	C	735.93	15	CORP-01072
1008	SUPREMA	06-0540-02	IMPRESORA MOVIL	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2200	14	CORP-00791
1009	SUPREMA	06-0538-02	IMPRESORA MOVIL	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2200	14	CORP-00791
1010	SUPREMA	06-0541-02	IMPRESORA MOVIL	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2200	14	CORP-00791
1011	SUPREMA	06-0539-02	IMPRESORA MOVIL	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2200	14	CORP-00791
1012	SUPREMA	06-0537-02	IMPRESORA MOVIL	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2200	14	CORP-00791
1013	GRS	MA0103003	REGLÓN DE MATILISGUATE 3"x2"x7' DE LARGO	Ferretería general	Mantenimiento industrial	C	87.5	58	CORP-01039
1014	SAN FRANCISCO	IN0303008	INSECTICIDA NOMOLT 15 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	436.9379	42	CORP-00805
1015	GRS	RE0309024	LLAVE TIPO COMPUERTA DE BRONCE DE 4	Construcción y obra civil	Infraestructura y obra civil	C	1075.8929	11	CORP-00897
1016	ALFA	MA0101013	GUANTES CORTOS DE PIEL CERDO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	21.4286	17	CORP-00756
1017	PALMAS	RE0201104	SELECTOR SIEMENS 3 POSICIONES 2 CONTACTOS N.O.	Construcción y obra civil	Infraestructura y obra civil	C	214.2857	13	CORP-01090
1018	SAN FRANCISCO	MA0201002	MELAZA	Ganadería y alimento animal	Ganadería	C	5.3571	89	CORP-00925
1019	PALMAS	05-0593-01	BÁSCULA ELECTRÓNICA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2136.6518	15	CORP-00113
1020	PALMAS	05-0588-01	BASCULA ELECTRONICA DE PLATAFORMA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2136.6518	15	CORP-00114
1021	PALMAS	RE0306045	FAJAS # C-124	Repuestos y componentes mecánicos	Bodega central (stock)	C	152.0485	14	CORP-00601
1022	ALFA	MA0102122	VALVULA AIRE X-295 2	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	531.25	19	CORP-01335
1023	SUPREMA	MA0110009	POLIVID LIMPIA VIDRIOS	Construcción y obra civil	Infraestructura y obra civil	C	176.7857	8	CORP-01004
1024	SUPREMA	MA0105002	ACEITE CASTROL AUTO LUBE (LITRO)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	64.2857	28	CORP-00013
1025	PALMAS	05-0611-01	GABINETE ACERO INOXIDABLE	Ferretería general	Mantenimiento industrial	C	2119.6875	15	CORP-00733
1026	PALMAS	MA0104084	HEMBRA H.N. 3/8 X 2 X 20	Ferretería general	Bodega central (stock)	C	210.7143	7	CORP-00769
1027	PALMAS	RE0302037	COJINETE No. 6015 2RS  (75 X 115 X 20 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	350.8929	20	CORP-00388
1028	PALMAS	RE0101071	FILTRO  HIDRAULICO # AT-308274=AT-367840	Repuestos y componentes mecánicos	Bodega central (stock)	C	1050.0893	15	CORP-00653
1029	PALMAS	RE0310004	DILUYENTE INDUSTRIAL PINTURA TRAFICO O ASFALTO No. R2K4-1  (GLS)	Construcción y obra civil	Infraestructura y obra civil	C	100	18	CORP-00467
1030	PALMAS	06-0435-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2098.2143	14	CORP-01154
1031	PALMAS	06-0436-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2098.2143	14	CORP-01154
1032	PALMAS	06-0434-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2098.2143	14	CORP-01154
1033	PALMAS	RE0311022	LOCK NUT KM 23 P/35	Repuestos y componentes mecánicos	Mantenimiento industrial	C	519.1406	15	CORP-00899
1034	PALMAS	06-0443-01	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	2075.8929	10	CORP-01150
1035	PALMAS	RE0103010	CHICOTE LUZ CABEZAL	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	294.6429	21	CORP-00282
1036	PALMAS	RE0303039	BARRA ACERO 1045  1.1/2 GRUESO	Ferretería general	Mantenimiento industrial	C	2.9217	14	CORP-00105
1037	SAN ANTONIO	MA0202030	DESPARASITANTE IVOMEC 250 ML.	Ganadería y alimento animal	Ganadería	C	1026.7857	62	CORP-00462
1038	PALMAS	05-0608-01	CAMILLA	Papelería, oficina y cómputo	Administración y oficinas	C	2053.5714	15	CORP-00235
1039	SUPREMA	06-0564-02	IMPRESORA EPSON L4360	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2049.1071	8	CORP-00789
1040	SUPREMA	06-0549-02	IMPRESORA EPSON L4360	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2049.1071	8	CORP-00789
1041	SUPREMA	06-0550-02	IMPRESORA EPSON L4360	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2049.1071	8	CORP-00789
1042	SUPREMA	06-0563-02	IMPRESORA EPSON L4360	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2049.1071	8	CORP-00789
1043	SUPREMA	06-0551-02	IMPRESORA EPSON L4360	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2049.1071	8	CORP-00789
1044	PALMAS	MA0107026	CARRETE ALAMBRE ACERO AL CARBON 0.045 DE 33 LBS	Ferretería general	Bodega central (stock)	C	254.2411	15	CORP-00254
1045	PALMAS	06-0439-01	TABLET	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	2031.25	27	CORP-01154
1046	SAN ANTONIO	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	58.0357	14	CORP-00667
1047	PALMAS	MA0107028	CILINDRO GAS CO2	Repuestos y componentes mecánicos	Bodega central (stock)	C	405.0893	8	CORP-00302
1048	SUPREMA	MA0102111	VALVULA HN 3 PASO RAPIDO SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1008.9286	21	CORP-01361
1049	PALMAS	MA0102099	VALVULA BRONCE 1.1/2 TIPO COMPUERTA	Repuestos y componentes mecánicos	Bodega central (stock)	C	167.8571	17	CORP-01338
1050	PALMAS	RE0201103	SELECTOR SIEMENS 2 POSICIONES 1 CONTACTO N.O.	Construcción y obra civil	Infraestructura y obra civil	C	200.8929	12	CORP-01089
1051	PALMAS	05-0580-01	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	12	CORP-00485
1052	PALMAS	05-0579-01	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	12	CORP-00485
1053	SUPREMA	05-0557-02	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	2	CORP-00485
1054	SUPREMA	05-0558-02	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	2	CORP-00485
1055	PALMAS	05-0555-01	ARCHIVADOR DE 5 GAVETAS CON SISTEMA DE ANTI-VUELCA	Vehículos, maquinaria y equipo (activo)	Calidad y laboratorio	C	2008.9286	70	CORP-00089
1056	PALMAS	05-0553-01	ARCHIVADOR DE 5 GAVETAS CON SISTEMA DE ANTI-VUELCA	Vehículos, maquinaria y equipo (activo)	Calidad y laboratorio	C	2008.9286	70	CORP-00089
1057	SUPREMA	05-0565-02	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	15	CORP-00485
1058	SUPREMA	05-0566-02	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	2008.9286	15	CORP-00485
1059	TASINSA	05-0098-09	ESTACION LAVAOJOS PORTATIL CON CAPACIDAD DE 8 GALONES, CODIGO OJ201-2 (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	2008.9286	20	CORP-00545
1060	PALMAS	RE0101011	FILTRO ACEITE LFP-3000 (VOLTEO Y DORADO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	334.8214	15	CORP-00613
1061	PALMAS	RE0312008	SIGHT GLASS (PART. 60853848) = 206-111	Repuestos y componentes mecánicos	Mantenimiento industrial	C	995.724	15	CORP-01112
1062	PALMAS	MA0104013	HEMBRA H.N. 3/8 X 4 X 20	Ferretería general	Bodega central (stock)	C	397.4107	12	CORP-00770
1063	PALMAS	06-0488-01	IMPRESORA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1986.6071	15	CORP-00787
1064	PALMAS	RE0302078	COJINETE No. 6310 2RS  (50 X 110 X 27 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	329.4643	19	CORP-00410
1065	SUPREMA	RE0302052	COJINETE 6409 ZZ	Repuestos y componentes mecánicos	Mantenimiento industrial	C	982.1429	33	CORP-00370
1066	PALMAS	RE0304060	SELLO MECANICO 1.3/8 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	196.4286	4	CORP-01097
1067	SUPREMA	RE0316008	DISCO DE CORTE 9 x 1/8	Herramientas	Mantenimiento industrial	C	26.1905	26	CORP-00476
1068	TASINSA	05-0099-09	TELEVISOR LED FULL HLD DE 40"	Materiales eléctricos	Mantenimiento industrial	C	1963.3929	42	CORP-01186
1069	PALMAS	MA0104001	ANGULAR H.N. 1/4 X 2 X 20	Construcción y obra civil	Infraestructura y obra civil	C	244.2857	27	CORP-00078
1070	PALMAS	RE0101104	FILTRO TRAMPA DIESEL JOHN DEERE RE523236	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	317.3214	15	CORP-00665
1071	SUPREMA	RE0317085	AMORTIGUADOR LEVOY S-FLEX JN No. 8	Repuestos y componentes mecánicos	Mantenimiento industrial	C	633.9286	20	CORP-00074
1072	SUPREMA	MA0102110	VALVULA HN 2 GLOBO SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	633.5714	20	CORP-01357
1073	SUPREMA	RE0304042	POMO DE SILICONE PERMATEX RTV ULTRACOPPER	Ferretería general	Mantenimiento industrial	C	52.6786	17	CORP-01009
1074	PALMAS	RE0317108	BUJE DE BRONCE (HP - SUPERIOR) SSP 407	Repuestos y componentes mecánicos	Bodega central (stock)	C	946.0045	15	CORP-00167
1075	PALMAS	RE0317109	BUJE DE BRONCE (HP - INFERIOR) SSP 407A	Repuestos y componentes mecánicos	Bodega central (stock)	C	946.0045	15	CORP-00166
1076	PALMAS	RE0304040	VELLUMOIDE 1/32  (PIE CUADRADO)	Construcción y obra civil	Bodega central (stock)	C	48.3516	17	CORP-01382
1077	ACACIAS	MA0104002	TUBO PVC 1/2 X 20'	Construcción y obra civil	Flota, maquinaria y combustible	C	15.65	7	CORP-01312
1078	ALFA	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	Otros materiales	Calidad y laboratorio	C	93.75	40	CORP-00442
1079	SUPREMA	RE0201024	CABLE TSJ 3 X 12	Materiales eléctricos	Mantenimiento industrial	C	18.75	20	CORP-00185
1080	SUPREMA	06-0527-02	CAMILLA	Ferretería general	Mantenimiento industrial	C	1875	4	CORP-00235
1081	PALMAS	MA0106004	HEXANO EMSURE ACS, REAG  (LTS.)	Insumos químicos de producción	Calidad y laboratorio	C	9.0125	9	CORP-00777
1082	PALMAS	06-0419-01	IMPRESORA MULTIFUNCIONAL EPSON L4260 (VER ANEXO)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1866.0714	11	CORP-00793
1083	PALMAS	RE0317104	CADENA DE ACOPLAMIENTO TR 7013	Repuestos y componentes mecánicos	Bodega central (stock)	C	1857.8571	15	CORP-00190
1084	PALMAS	05-0571-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1085	PALMAS	05-0574-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1086	PALMAS	05-0572-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1087	PALMAS	05-0575-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1088	PALMAS	05-0576-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1089	PALMAS	05-0573-01	SILLA EJECUTIVA	Papelería, oficina y cómputo	Administración y oficinas	C	1837.3661	16	CORP-01119
1090	SUPREMA	RE0309019	BRIDA INOX 2" CLASE 150 SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	183.0357	16	CORP-00159
1091	SAN ANTONIO	MA0202024	LAZO PLASTICO 3/8"	Ferretería general	Agrícola (fincas)	C	12.1652	23	CORP-00865
1092	ACACIAS	MA0102107	TEE PVC 10	Construcción y obra civil	Flota, maquinaria y combustible	C	1817.3571	96	CORP-01180
1093	ACACIAS	MA0102035	CODO PVC 10 X 45°  (LISO)	Construcción y obra civil	Flota, maquinaria y combustible	C	1817.3571	38	CORP-00345
1094	SAN JORGE	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	Ferretería general	Agrícola (fincas)	C	302.0833	44	CORP-00066
1095	SUPREMA	RE0201186	SELECTOR DE 3 POSICIONES 110 VAC MARCA SIEMENS CON INDICADOR LUMINOSO	Construcción y obra civil	Infraestructura y obra civil	C	361.6071	13	CORP-01088
1096	PALMAS	RE0101098	FILTRO ACEITE # MZ 2690411=MZ690412	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	299.1071	27	CORP-00615
1097	PALMAS	RE0101010	FILTRO ACEITE LFP-2285 CAMION INTER)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	299.1071	16	CORP-00612
1098	SAN ANTONIO	MA0202015	VITAMINA OLIVITASAN 500 ML	Fertilizantes y agroquímicos	Agrícola (fincas)	C	447.7679	23	CORP-01389
1099	PALMAS	RE0312018	TYMER 8 PINES 24-240V DE 0 A 60 MIN  (DESARENADOR)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	446.4321	15	CORP-01321
1100	PALMAS	08-0198-01	OSCILOSCOPIO AUTOMOTRIZ	Materiales eléctricos	Flota, maquinaria y combustible	C	1785.7143	15	CORP-00960
1101	PALMAS	05-0537-01	GABINETE DE METAL BLANCO DOS PUERTAS VIDRIO REF 11536 (001502303 TUCO) (VER ANEXO)	Construcción y obra civil	Calidad y laboratorio	C	1784.8214	121	CORP-00734
1102	PALMAS	06-0481-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1784.8214	15	CORP-01154
1103	PALMAS	06-0483-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1784.8214	15	CORP-01154
1104	PALMAS	06-0480-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1784.8214	15	CORP-01154
1105	PALMAS	06-0482-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1784.8214	15	CORP-01154
1106	SUPREMA	MA0106061	HIDROXIDO DE SODIO	Insumos químicos de producción	Producción / Planta	C	1783.9286	64	CORP-00779
1107	SUPREMA	08-0297-02	JUEGO DE DADOS	Herramientas	Mantenimiento industrial	C	1782.2143	30	CORP-00817
1108	SUPREMA	05-0562-02	VENTILADOR INDUSTRIAL	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1781.25	35	CORP-01385
1109	SUPREMA	05-0561-02	VENTILADOR INDUSTRIAL	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1781.25	35	CORP-01385
1110	PALMAS	08-0123-01	BARRENO INALMABRICO 1/2"	Herramientas	Flota, maquinaria y combustible	C	1781.25	15	CORP-00111
1111	PALMAS	05-0554-01	ARCHIVO DE 2 PUERTAS DE METAL CON CERRADURA DE MANIGUETAS	Papelería, oficina y cómputo	Calidad y laboratorio	C	1776.7857	70	CORP-00090
1112	SUPREMA	RE0301027	REFRIGERANTE PARA RADIADOR DISEL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	103.729	10	CORP-01035
1113	PALMAS	RE0314060	SPACER P/1524	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1763.172	15	CORP-01134
1114	SUPREMA	MA0102124	TRAMPA TERMODINAMICA DE 1/2"	Ferretería general	Mantenimiento industrial	C	879.4643	28	CORP-01288
1115	SUPREMA	MA0108031	TORNILLO 5/8 X 3 HEXA COMPLETOS	Ferretería general	Mantenimiento industrial	C	13.2035	15	CORP-01233
1116	GRS	RE0304011	SELLO MECANICO 1 1/4 TIPO 21 SEALCO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	174.1071	14	CORP-01094
1117	METALMECANICA	08-0316-11	PUNTA LOGICA PS100 AUTEL	Ferretería general	Mantenimiento industrial	C	1741.0714	92	CORP-01022
1118	ALFA	MA0102035	CODO PVC 10 X 45°  (LISO)	Construcción y obra civil	Flota, maquinaria y combustible	C	1720.9464	41	CORP-00345
1119	SUPREMA	RE0101012	FILTRO AIRE LA 7056 MARCA LORENZ (JUNIO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	286.6071	61	CORP-00622
1120	SUPREMA	RE0304026	ESTOPA TEFLONADA DE 3/8+B546	Ferretería general	Mantenimiento industrial	C	34.375	15	CORP-00555
1121	PALMAS	MA0102096	VALVULA ALIVIO 3/8 NPT PIPA O PLATAFORMA	Repuestos y componentes mecánicos	Bodega central (stock)	C	214.2857	22	CORP-01336
1122	PALMAS	MA0108033	TORNILLO HEXAG. INOX. 3/8 X 1.1/2	Ferretería general	Bodega central (stock)	C	3.2768	11	CORP-01274
1123	METALMECANICA	08-0307-11	RUEDA DE MEDICIÓN DIGITAL DE 12" MARCA MILWAUKEE (VER ANEXO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1703.5714	29	CORP-01080
1124	METALMECANICA	08-0308-11	RUEDA DE MEDICIÓN DIGITAL DE 12" MARCA MILWAUKEE (VER ANEXO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1703.5714	29	CORP-01080
1125	SUPREMA	RE0317083	AMORTIGUADOR LEVOY S-FLEX JN No. 7	Repuestos y componentes mecánicos	Mantenimiento industrial	C	424.1071	33	CORP-00073
1126	SUPREMA	RE0201168	GUARDAMOTOR TRIFASICO SIEMENS 18-25AMP, 11KW, 480VAC, TAMAÑO S2, 3RV2031-4DA10	Materiales eléctricos	Mantenimiento industrial	C	848.2143	24	CORP-00760
1127	PALMAS	RE0314048	LOCKING COLLAR P/1029	Repuestos y componentes mecánicos	Mantenimiento industrial	C	561.204	15	CORP-00900
1128	ACACIAS	05-0077-03	INVERSOR DE CORRIENTE	Materiales eléctricos	Mantenimiento industrial	C	1683.0357	53	CORP-00807
1129	SAN JORGE	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	23.9222	40	CORP-00748
1130	PALMAS	RE0101070	FILTRO CONVERTIDOR # NR-0501232 665=AT-466863	Repuestos y componentes mecánicos	Bodega central (stock)	C	832.0089	15	CORP-00625
1131	PALMAS	06-0485-01	IMPRESORA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1651.7857	25	CORP-00787
1132	PALMAS	IN0105008	SACO POLIPROPILENO DE 55 X 85 CMS SIN LOGOTIPO	Material de empaque	Producción / Planta	C	1.6518	22	CORP-01084
1133	SUPREMA	RE0201006	BOMBILLA AHORRADORA 105 WATS	Materiales eléctricos	Mantenimiento industrial	C	82.1429	13	CORP-00139
1134	PALMAS	MA0102100	VALVULA BRONCE 2 TIPO COMPUERTA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	272.5446	46	CORP-01339
1135	PALMAS	RE0101095	FILTRO DE ACEITE # ME229416=QY010015V=QY012302	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	272.3214	27	CORP-00630
1136	PALMAS	05-0568-01	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Flota, maquinaria y combustible	C	1632.7232	14	CORP-00059
1137	PALMAS	05-0561-01	AIRE ACONDICIONADO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1632.7232	2	CORP-00059
1138	METALMECANICA	AV10110010108	MUESTRA ESTÁNDAR D40	Otros materiales	Mantenimiento industrial	C	815.8179	44	CORP-00943
1139	PALMAS	RE0311012	RETENEDOR 120 X 140 X 12 MM.  (MR04857 = MR09707)	Repuestos y componentes mecánicos	Bodega central (stock)	C	123.7356	15	CORP-01053
1140	PALMAS	RE0103070	MANGUERA ESPIRAL PASO AIRE CABEZAL	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	160.7143	22	CORP-00913
1141	SUPREMA	MA0110021	DISSO CK	Insumos químicos de producción	Producción / Planta	C	40.1786	15	CORP-00486
1142	SUPREMA	05-0559-02	TERMOHIGROMETRO DIGITAL	Ferretería general	Mantenimiento industrial	C	1607.1429	2	CORP-01203
1143	SUPREMA	06-0583-02	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	1607.1429	9	CORP-01150
1144	SUPREMA	05-0564-02	TERMOHIGROMETRO DIGITAL	Ferretería general	Mantenimiento industrial	C	1607.1429	20	CORP-01203
1145	SUPREMA	05-0560-02	TERMOHIGROMETRO DIGITAL	Ferretería general	Mantenimiento industrial	C	1607.1429	2	CORP-01203
1146	SUPREMA	06-0584-02	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	1607.1429	9	CORP-01150
1147	SUPREMA	05-0563-02	TERMOHIGROMETRO DIGITAL	Ferretería general	Mantenimiento industrial	C	1607.1429	20	CORP-01203
1148	PALMAS	05-0605-01	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1606.25	10	CORP-00485
1149	PALMAS	05-0604-01	DISPENSADOR DE AGUA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1606.25	10	CORP-00485
1150	SAN JORGE	05-0034-04	SILLA EJECUTIVA DS-1301N BASE CROMADA RESPALDO MESH (VER ANEXO)	Papelería, oficina y cómputo	Administración y oficinas	C	1598.2143	42	CORP-01120
1151	SUPREMA	06-0557-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1152	SUPREMA	06-0560-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1153	SUPREMA	06-0554-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1154	SUPREMA	06-0555-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1155	SUPREMA	06-0556-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1156	SUPREMA	06-0553-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1157	SUPREMA	06-0558-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1158	SUPREMA	06-0559-02	MONITOR DELL E2725HM	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1598.2143	8	CORP-00932
1159	SUPREMA	06-0528-02	BÁSCULA	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1589.2857	4	CORP-00112
1160	PALMAS	MA0102110	VALVULA INOX 1 TIPO PASO RAPIDO (ROSCADA)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	122.0124	66	CORP-01364
1161	PALMAS	MA0104082	HEMBRA H.N. 1/4 X 2 X 20	Ferretería general	Bodega central (stock)	C	132.0893	7	CORP-00766
1162	METALMECANICA	08-0315-11	PRENSA DE BANCO GIRATORIA DE 8" MARCA STANLEY 83-132 (VER ANEXO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1584.8214	25	CORP-01017
1163	METALMECANICA	08-0314-11	PRENSA DE BANCO GIRATORIA DE 8" MARCA STANLEY 83-132 (VER ANEXO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1584.8214	25	CORP-01017
1164	ACACIAS	MA0103011	LIMA TRIANGULAR 6"  (MARCA BELLOTA)	Herramientas	Agrícola (fincas)	C	16.471	46	CORP-00888
1165	PALMAS	RE0102018	TUBO LLANTA 19.5-L24	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	392.8571	13	CORP-01308
1166	PALMAS	RE0103076	GRASERA RECTA 1/4 NPT.	Ferretería general	Bodega central (stock)	C	16.1349	16	CORP-00752
1167	PALMAS	RE0312022	SPRING PART.9 (BRUSH)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	764.235	15	CORP-01142
1168	SAN FRANCISCO	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	34	CORP-00963
1169	SAN ANTONIO	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	19	CORP-00963
1170	PALMAS	05-0536-01	SILLA CONFORT (VER ANEXO)	Papelería, oficina y cómputo	Calidad y laboratorio	C	1525.9375	116	CORP-01117
1171	SUPREMA	05-0575-02	ESCRITORIO	Papelería, oficina y cómputo	Administración y oficinas	C	1517.8571	33	CORP-00537
1172	PALMAS	MA0105005	ACEITE REFRIGERANTE CAPELLA-68 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	302.6786	20	CORP-00021
1173	SUPREMA	RE0101036	FILTRO DE ACEITE 51799	Repuestos y componentes mecánicos	Mantenimiento industrial	C	252.2321	20	CORP-00626
1174	SUPREMA	RE0304128	O-RING, -109 VITON (DOUBLE SEAL) #PARTE 1115-168 PARA CHORRO EPACK	Repuestos y componentes mecánicos	Mantenimiento industrial	C	30.2232	127	CORP-00954
1175	SAN FRANCISCO	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	Ferretería general	Agrícola (fincas)	C	301.7857	42	CORP-00066
1176	ACACIAS	08-0064-03	BALANZA ELECTRONICA TAW	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	1506.6964	4	CORP-00099
1177	SUPREMA	RE0304101	SELLO MECANICO DE 1 1/4, TIPO 21, SILICIO/SILICIO/VITON (AGOSTO2)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	187.5	15	CORP-01099
1178	PALMAS	RE0302054	COJINETE No. 6307 2RS  (35 X 80 X 21 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	124.4048	19	CORP-00407
1179	SUPREMA	RE0302045	COJINETE 6308 ZZ SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	149.1071	17	CORP-00365
1180	SUPREMA	MA0107011	LBS. DE ELECTRODO 6011 1/8 (MARCA ECA)	Herramientas	Mantenimiento industrial	C	11.1607	7	CORP-00866
1181	ACACIAS	RE0301001	REFRIGERANTE RADIADOR VEHICULOS (GLS)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	58.8	25	CORP-01038
1182	PALMAS	RE0304015	ESTOPA GRAFITADA 1/4 (PIE)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	14.4643	16	CORP-00549
1183	SAN ANTONIO	MA0102130	VALVULA SELECTORA 3 VIAS 1/4	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	142.8571	74	CORP-01374
1184	SUPREMA	RE0201022	CABLE TSJ 2X12	Materiales eléctricos	Mantenimiento industrial	C	14.2857	17	CORP-00183
1185	SAN ANTONIO	IN0303003	INSECTICIDA FIADOR 35 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	355	26	CORP-00803
1186	PALMAS	05-0562-01	MOTOR A COMBUSTION	Papelería, oficina y cómputo	Administración y oficinas	C	1419.9107	15	CORP-00937
1187	PALMAS	RE0101100	FILTRO DE AIRE PRIMARIO JOHN DEERE AT175224	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	709.9554	15	CORP-00635
1188	PALMAS	RE0308010	RETENEDOR 160 X 200 X 15 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	352.6786	15	CORP-01058
1189	PALMAS	05-0595-01	CAMILLA	Ferretería general	Mantenimiento industrial	C	1408.0357	3	CORP-00235
1190	PALMAS	05-0594-01	CAMILLA	Ferretería general	Mantenimiento industrial	C	1408.0357	3	CORP-00235
1191	SUPREMA	MA0102098	VALVULA DE COMPUERTA HN 1 1/2 ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	468.5714	31	CORP-01342
1192	PALMAS	06-0426-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1396.1964	18	CORP-01154
1193	PALMAS	06-0423-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1396.1964	18	CORP-01154
1194	PALMAS	06-0424-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1396.1964	18	CORP-01154
1195	PALMAS	06-0425-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1396.1964	18	CORP-01154
1196	PALMAS	06-0422-01	TABLET	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1396.1964	18	CORP-01154
1197	PALMAS	RE0306065	FAJAS # B-124	Repuestos y componentes mecánicos	Bodega central (stock)	C	99.4898	12	CORP-00570
1198	PALMAS	08-0124-01	ESTETOSCOPIO	Ferretería general	Mantenimiento industrial	C	1383.9286	4	CORP-00547
1199	PALMAS	RE0317011	ACOPLAMIENTO No. L-100 LOVEJOY	Repuestos y componentes mecánicos	Bodega central (stock)	C	275.8214	33	CORP-00041
1200	QUIRICA	MA0101010	ESPINILLERA CHAPEO	Papelería, oficina y cómputo	Administración y oficinas	C	67.8571	16	CORP-00543
1201	SUPREMA	MA0102107	VALVULA HN 2 BOLA ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	338.8393	21	CORP-01354
1202	SAN ANTONIO	MA0105007	ACEITE RIMULA No. SAE-50 (GLS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	89.3047	16	CORP-00022
1203	ALFA	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	19.1367	15	CORP-00748
1204	SAN FRANCISCO	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	19.1367	27	CORP-00748
1205	SUPREMA	RE0301037	TUBOS CAPILARES	Ferretería general	Mantenimiento industrial	C	26.7857	76	CORP-01318
1206	PALMAS	05-0590-01	CAMA	Papelería, oficina y cómputo	Administración y oficinas	C	1339.2857	15	CORP-00230
1207	PALMAS	05-0591-01	CAMA	Papelería, oficina y cómputo	Administración y oficinas	C	1339.2857	15	CORP-00230
1208	PALMAS	RE0316005	DISCO PULIR 1/4 X 7/8 X 4.1/2	Herramientas	Bodega central (stock)	C	13.3929	22	CORP-00481
1209	GRS	RE0306007	FAJAS B-43 SUPER BELT	Repuestos y componentes mecánicos	Mantenimiento industrial	C	44.5238	12	CORP-00574
1210	PALMAS	RE0304062	SELLO MECANICO 1.5/8 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	266.7411	4	CORP-01098
1211	PALMAS	08-0190-01	JUEGO DE HERRAMIENTAS PARA MECÁNICO MIXTAS 154 PZA	Herramientas	Mantenimiento industrial	C	1321.4286	27	CORP-00821
1212	SAN JORGE	05-0037-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1213	SAN JORGE	05-0038-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1214	SAN JORGE	05-0041-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1215	SAN JORGE	05-0040-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1216	SAN JORGE	05-0039-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1217	SAN JORGE	05-0036-04	ESTANTERIA DE 4 NIVELES EN ACERO	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1313.8839	4	CORP-00546
1218	SUPREMA	MA0106023	FENOLFTALEINA	Insumos químicos de producción	Calidad y laboratorio	C	6.5526	50	CORP-00607
1219	METALMECANICA	08-0267-11	ARRANCADOR DE BATERIA Y COMPRESOR 12V 1000A SCHUMACHER	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1309.8214	15	CORP-00093
1220	PALMAS	RE0308005	RETENEDOR 100 X 120 X 13 (BUFA DELANT.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	81.25	18	CORP-01049
1221	SUPREMA	06-0569-02	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	1291.4554	22	CORP-01150
1222	PALMAS	MA0108046	TORNILLO HEXAG. 3/8 X 3.1/2	Ferretería general	Bodega central (stock)	C	2.3039	20	CORP-01266
1223	SAN ANTONIO	MA0202025	LAZO PLASTICO 1/2"	Ferretería general	Agrícola (fincas)	C	12.2768	23	CORP-00862
1224	SUPREMA	RE0317018	CABEZAL DE HILO AUTOCUTB DE CHAPEADORA STHIL FS-220	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	214.63	31	CORP-00176
1225	PALMAS	08-0192-01	MEZCLADORA ELECTRICA PORTATIL	Materiales eléctricos	Mantenimiento industrial	C	1285.7143	14	CORP-00926
1226	ACACIAS	MA0101013	GUANTES CORTOS DE PIEL CERDO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	21.4286	8	CORP-00756
1227	PALMAS	RE0311025	SPACER RING - INNER PART. 21, 22	Repuestos y componentes mecánicos	Mantenimiento industrial	C	318.3684	15	CORP-01135
1228	PALMAS	RE0304052	EMPAQUE ESPIROMETALICO PARA VALVULA 3 (0-200 PSI)	Repuestos y componentes mecánicos	Bodega central (stock)	C	84.8214	25	CORP-00503
1229	SAN FRANCISCO	IN0303003	INSECTICIDA FIADOR 35 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	316.6429	41	CORP-00803
1230	GRS	RE0306002	FAJA B-42 SUPER BELT	Repuestos y componentes mecánicos	Mantenimiento industrial	C	45.1531	11	CORP-00563
1231	PALMAS	RE0201118	AMPERIMETRO DIGITAL CAMSCO DMCP 96-3M = EBCHQ 79590	Materiales eléctricos	Bodega central (stock)	C	126.3393	9	CORP-00076
1232	PALMAS	MA0108049	TORNILLO HEXAG. 3/4 X 9	Ferretería general	Mantenimiento industrial	C	12.5893	28	CORP-01264
1233	SUPREMA	RE0304040	POMO DE PERMATEX 1C	Material de empaque	Producción / Planta	C	54.5264	22	CORP-01006
1234	PALMAS	08-0099-01	PUÑO DE MARCAJE EN BRONCE	Ferretería general	Mantenimiento industrial	C	1250	10	CORP-01021
1235	PALMAS	08-0097-01	PUÑO DE MARCAJE EN BRONCE	Ferretería general	Mantenimiento industrial	C	1250	10	CORP-01021
1236	PALMAS	08-0096-01	PUÑO DE MARCAJE EN BRONCE	Ferretería general	Mantenimiento industrial	C	1250	10	CORP-01021
1237	PALMAS	08-0098-01	PUÑO DE MARCAJE EN BRONCE	Ferretería general	Mantenimiento industrial	C	1250	10	CORP-01021
1238	SUPREMA	RE0201183	LAMPARA TIPO REFLECTOR 100 WATTS MULTIVOLTAJE	Materiales eléctricos	Mantenimiento industrial	C	247.3214	12	CORP-00846
1239	PALMAS	RE0301013	TARJETA ELECTRONICA A/C MINI SPLIT (3VEI C/DISP. QTH-10A QUALITY)	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	307.1439	13	CORP-01175
1240	PALMAS	RE0306027	FAJAS # B-128	Repuestos y componentes mecánicos	Bodega central (stock)	C	87.6913	13	CORP-00571
1241	SAN ANTONIO	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	17.4	14	CORP-00748
1242	GRS	RE0309085	POMO DE SILICÓN LOCTITE ULTRA GRIS 5699 70 ML	Ferretería general	Mantenimiento industrial	C	40.1786	19	CORP-01007
1243	PALMAS	RE0201116	BOMBILLA AHORRADORA TIPO ESPIRAL 27W.	Materiales eléctricos	Bodega central (stock)	C	40.1786	13	CORP-00144
1244	SUPREMA	RE0316019	CEPILLO CIRCULAR 4.5" TRENSADO	Papelería, oficina y cómputo	Administración y oficinas	C	40.1786	20	CORP-00274
1245	SUPREMA	RE0201217	3485FCSD-32 - FLASHCARD 32GB INDUSTRIAL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	1205.3571	80	CORP-00001
1246	PALMAS	06-0438-01	SWITCH	Materiales eléctricos	Mantenimiento industrial	C	1205.3571	12	CORP-01150
1247	ALFA	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	Ferretería general	Agrícola (fincas)	C	299.1071	40	CORP-00066
1248	SUPREMA	RE0201218	SENSOR DE PRESIÓN DE DEAREADO (0-0.4MPA) 4 BAR TAMAÑO 100MM	Materiales eléctricos	Mantenimiento industrial	C	584.1786	15	CORP-01104
1249	PALMAS	05-0578-01	HORNO MICROONDAS	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1160.7143	12	CORP-00782
1250	PALMAS	05-0559-01	SILLON BUTACA	Papelería, oficina y cómputo	Administración y oficinas	C	1159.8214	74	CORP-01122
1251	SAN FRANCISCO	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	384.2411	41	CORP-00727
1252	GRS	RE0309048	CEPILLO DE ALAMBRE CUADRADO SIN MANGO	Ferretería general	Mantenimiento industrial	C	142.8571	52	CORP-00278
1253	SUPREMA	06-0566-02	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1138.3929	22	CORP-00931
1254	SUPREMA	06-0567-02	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1138.3929	22	CORP-00931
1255	SUPREMA	06-0568-02	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	1138.3929	22	CORP-00931
1256	PALMAS	RE0306047	FAJAS # C-65	Repuestos y componentes mecánicos	Bodega central (stock)	C	70.7589	14	CORP-00603
1257	PALMAS	MA0102113	VALVULA INOX 2 TIPO PASO RAPIDO ROSCADA	Repuestos y componentes mecánicos	Bodega central (stock)	C	282.5982	18	CORP-01368
1258	PALMAS	RE0305006	PIROMETRO CAMSCO DMCP96-1 TIPO J = EBCHQ 58520	Materiales eléctricos	Bodega central (stock)	C	225.8482	5	CORP-00994
1259	SUPREMA	08-0292-02	ESMERIALADORA	Ferretería general	Mantenimiento industrial	C	1127.2768	10	CORP-00539
1260	METALMECANICA	RE0316014	BURIL COBALTO 1/2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	160.7143	22	CORP-00171
1261	PALMAS	RE0101093	FILTRO PARA AIRE P0616421 = WIX 46522 070924BB2	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	186.6667	23	CORP-00658
1262	GRS	RE0201094	BOMBILLA AHORRADORA VOLTECK LED 40W BASE E27	Materiales eléctricos	Mantenimiento industrial	C	44.6429	21	CORP-00146
1263	SUPREMA	RE0310001	BARNIZ DIELECTRICO SPRAY	Materiales eléctricos	Mantenimiento industrial	C	111.6071	31	CORP-00103
1264	PALMAS	RE0101068	FILTRO TRAMPA # AT-365870	Repuestos y componentes mecánicos	Bodega central (stock)	C	554.1071	15	CORP-00663
1265	PALMAS	RE0101018	FILTRO AGUA LFW-4071 (VOLTEO Y DORADO)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	110.7143	18	CORP-00617
1266	SAN ANTONIO	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	7.3661	13	CORP-00773
1267	PALMAS	RE0101008	FILTRO ACEITE LFP-2160 INTER AZUL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	183.0357	16	CORP-00611
1268	SUPREMA	RE0317183	TERMOCOPLA TIPO K DE CERAMICA VASTAGO DE 100CM	Construcción y obra civil	Infraestructura y obra civil	C	1097.8529	15	CORP-01202
1269	SAN ANTONIO	MA0202023	LAZO PLASTICO 1/4"	Ferretería general	Agrícola (fincas)	C	12.1776	27	CORP-00863
1270	PALMAS	MA0108018	TORNILLO HEXAG. 3/4 X 5	Ferretería general	Bodega central (stock)	C	10.9375	18	CORP-01261
1271	PALMAS	RE0306037	UNION CADENA 80-3	Repuestos y componentes mecánicos	Bodega central (stock)	C	108.9286	14	CORP-01327
1272	PALMAS	RE0304057	SELLO MECANICO 1.1/2 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	216.7857	4	CORP-01092
1273	PALMAS	RE0101037	FILTRO DIESEL 33651 = L3578FN  (FREIGHTLINER Y VOLVO)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	134.8214	16	CORP-00647
1274	PALMAS	RE0304050	EMPAQUE ESPIROMETALICO PARA VALVULA 6 (0-200 PSI)	Repuestos y componentes mecánicos	Bodega central (stock)	C	153.5332	23	CORP-00505
1275	GRS	RE0309027	RESISTENCIA CD-260 P/ SELLADORA MANUAL  10	Construcción y obra civil	Infraestructura y obra civil	C	14.881	74	CORP-01047
1276	PALMAS	RE0302002	CHUMACERA BANCO No. SY 50 TF/VA 201 MARCA SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	267.8571	43	CORP-00289
1277	PALMAS	RE0302066	COJINETE No. G 1108 KRRB = UEL 208-108	Repuestos y componentes mecánicos	Bodega central (stock)	C	267.8571	17	CORP-00416
1278	SUPREMA	RE0103022	SWITCH OJO DE CANGREJO 12/24 VDC 3 POSICIONES	Materiales eléctricos	Flota, maquinaria y combustible	C	26.7857	10	CORP-01152
1279	METALMECANICA	RE0309150	SIERRA NICHOLSON 1.1/4 X 18	Herramientas	Mantenimiento industrial	C	133.9286	23	CORP-01110
1280	SUPREMA	RE0309015	BRIDA HN 3" CLASE 150 SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	71.4286	14	CORP-00158
1281	PALMAS	MA0108029	TORNILLO HEXAG. INOX. 1/2 X 2	Ferretería general	Mantenimiento industrial	C	5.3125	28	CORP-01272
1282	SAN FRANCISCO	MA0102004	ADAPTADOR INYECTADO DE 3/4" LISO A 1/2" CON ROSCA	Construcción y obra civil	Flota, maquinaria y combustible	C	1.7679	72	CORP-00049
1283	PALMAS	08-0191-01	JUEGO DE HERRAMIENTAS PARA MECÁNICO 164 PZAS	Herramientas	Mantenimiento industrial	C	1058.0357	27	CORP-00820
1284	PALMAS	RE0306026	FAJAS # B-98	Repuestos y componentes mecánicos	Bodega central (stock)	C	81.2342	17	CORP-00599
1285	SUPREMA	MA0105018	ACEITE ISO 220	Combustibles y lubricantes	Flota, maquinaria y combustible	C	105.3929	12	CORP-00019
1286	PALMAS	MA0104012	HEMBRA H.N. 3/8 X 1 X 20	Ferretería general	Bodega central (stock)	C	105.2232	7	CORP-00768
1287	SAN JORGE	MA0101002	BATA TIPO GABACHA PVC	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	43.75	17	CORP-00116
1288	SUPREMA	RE0317009	AMORTIGUADOR DE HULE 7 LOVEJOY S-FLEX	Repuestos y componentes mecánicos	Mantenimiento industrial	C	522.3214	15	CORP-00071
1289	PALMAS	RE0306046	FAJAS # B-105	Repuestos y componentes mecánicos	Bodega central (stock)	C	74.4643	15	CORP-00569
1290	PALMAS	RE0302077	COJINETE No. 6308 2RS  (40 X 90 X 23 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	148.8418	16	CORP-00408
1291	SUPREMA	MA0102066	FILTRO TIPO Y DE 1 ROSCADO HN	Repuestos y componentes mecánicos	Mantenimiento industrial	C	345	21	CORP-00661
1292	PALMAS	MA0104067	ANGULAR H.N. 3/16" X 2"" X 20'	Construcción y obra civil	Infraestructura y obra civil	C	206.3393	21	CORP-00080
1293	PALMAS	RE0101073	FILTRO AIRE # AT-332908	Repuestos y componentes mecánicos	Bodega central (stock)	C	513.4375	15	CORP-00620
1294	PALMAS	08-0199-01	JUEGO  DE 10 COPAS DE IMPACTO	Herramientas	Mantenimiento industrial	C	1026.7857	15	CORP-00816
1295	SAN JORGE	MA0202030	DESPARASITANTE IVOMEC 250 ML.	Ganadería y alimento animal	Ganadería	C	1026.7857	89	CORP-00462
1296	PALMAS	05-0566-01	LOKER	Papelería, oficina y cómputo	Administración y oficinas	C	1026.7857	22	CORP-00903
1297	SAN FRANCISCO	MA0202030	DESPARASITANTE IVOMEC 250 ML.	Ganadería y alimento animal	Ganadería	C	1026.7857	45	CORP-00462
1298	SUPREMA	RE0316009	DISCO DE PULIR 4.5 X 1/4	Herramientas	Mantenimiento industrial	C	20.5357	24	CORP-00479
1299	PALMAS	RE0308027	RETENEDOR 82 X 105 X 12 MM.  (DOBLE LABIO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	169.6429	14	CORP-01068
1300	PALMAS	MA0102103	VALVULA HN 1 TIPO PASO RAPIDO (ROSCADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	101.3616	35	CORP-01353
1301	SAN FRANCISCO	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	Ferretería general	Agrícola (fincas)	C	20.9821	14	CORP-00879
1302	SAN ANTONIO	MA0108005	TORNILLO HEX HN GR8 1"X11" COMPLETO ROSCA	Ferretería general	Bodega central (stock)	C	125	18	CORP-01248
1303	SUPREMA	RE0201101	INTERRUPTOR SIMPLE PARA EMPOTRAR BTICINO	Materiales eléctricos	Mantenimiento industrial	C	22.2202	17	CORP-00806
1304	SAN ANTONIO	MA0101008	CINTURON BELCRO (10 TALLA 3, 10 TALLA M Y 10 TALLA L)	Ferretería general	Agrícola (fincas)	C	41.0714	13	CORP-00328
1305	SAN JORGE	MA0101008	CINTURON BELCRO (10 TALLA S, 10 TALLA M Y 4 TALLA S)	Ferretería general	Agrícola (fincas)	C	41.0714	18	CORP-00330
1306	SAN FRANCISCO	MA0101008	CINTURON BELCRO (10 TALLA S, 10 TALLA M Y 4 TALLA L)	Ferretería general	Agrícola (fincas)	C	41.0714	13	CORP-00329
1307	PALMAS	RE0302044	COJINETE No. 6209 2RS  (45 X 85 X 19 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	122.9911	17	CORP-00398
1308	PALMAS	RE0304064	SELLO MECANICO DOBLE CARA 1.3/8 TIPO 21	Repuestos y componentes mecánicos	Bodega central (stock)	C	196.4286	4	CORP-01101
1309	PALMAS	RE0308007	RETENEDOR 110 X 140 X 13 MM. (0516 BUFA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	98.2143	15	CORP-01051
1310	SUPREMA	RE0201008	BOMBILLA AHORRADORA 45 WATTS	Materiales eléctricos	Mantenimiento industrial	C	49.1071	13	CORP-00141
1311	SUPREMA	MA0107012	LBS. DE ELECTRODO 6011 3/32 (MARCA ECA)	Herramientas	Mantenimiento industrial	C	11.1607	7	CORP-00867
1312	SAN JORGE	06-0030-04	MONITOR HP - 21.5" - SERIE 3 PRO 322 PF HDMI-DP-VGA	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	973.2143	24	CORP-00933
1313	SUPREMA	RE0304090	PLANCHA DE NEOPRENO 1/8" 4'X4'	Construcción y obra civil	Infraestructura y obra civil	C	482.1429	15	CORP-01000
1314	SAN FRANCISCO	MA0101002	BATA TIPO GABACHA PVC	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	40.1786	21	CORP-00116
1315	SAN ANTONIO	MA0101002	BATA TIPO GABACHA PVC	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	40.1786	13	CORP-00116
1316	PALMAS	08-0125-01	ESFIGMOMANOMETRO	Herramientas	Mantenimiento industrial	C	959.8214	4	CORP-00538
1317	SUPREMA	MA0108007	TORNILLO 1/2 X 2 HEXA COMPLETOS GRADO 5 ROSCA CORRIDA	Ferretería general	Mantenimiento industrial	C	7.3489	21	CORP-01218
1318	PALMAS	MA0108034	TORNILLO HEXAG. INOX. 3/8 X 2	Ferretería general	Mantenimiento industrial	C	4.7768	28	CORP-01275
1319	SAN FRANCISCO	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	316.9643	14	CORP-00092
1320	SAN ANTONIO	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	316.9643	14	CORP-00092
1321	SAN JORGE	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	316.9643	14	CORP-00092
1322	PALMAS	RE0306018	FAJAS # B-58	Repuestos y componentes mecánicos	Bodega central (stock)	C	47.2321	17	CORP-00582
1323	GRS	RE0309058	CINTA SCOTCH # 33  3/4	Ferretería general	Mantenimiento industrial	C	39.2857	12	CORP-00321
1324	PALMAS	MA0102104	VALVULA HN 1/2 TIPO COMPUERTA (ROSCADA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	117.7232	12	CORP-01348
1325	SAN ANTONIO	MA0104002	TUBO PVC 1/2 X 20'	Construcción y obra civil	Flota, maquinaria y combustible	C	15.6498	20	CORP-01312
1326	SUPREMA	RE0308010	RETENEDOR 330663 NATIONAL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	46.875	15	CORP-01059
1327	PALMAS	RE0311023	LOCKWASHER MB 23 P/35A	Repuestos y componentes mecánicos	Mantenimiento industrial	C	233.7266	15	CORP-00902
1328	SUPREMA	RE0305001	CINTA METRICA DE 10 METROS	Herramientas	Mantenimiento industrial	C	93.2946	18	CORP-00316
1329	QUIRICA	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	77.4821	17	CORP-00357
1330	SAN JORGE	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	58.0357	14	CORP-00667
1331	PALMAS	RE0306061	FAJAS # B-88	Repuestos y componentes mecánicos	Bodega central (stock)	C	70.4856	18	CORP-00596
1332	ALFA	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	30	CORP-00963
1333	ACACIAS	MA0101033	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	35	CORP-00963
1334	SAN JORGE	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	46	CORP-00963
1335	PALMAS	RE0306043	FAJAS # B-69	Repuestos y componentes mecánicos	Bodega central (stock)	C	50.881	13	CORP-00589
1336	SUPREMA	06-0589-02	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	915.1786	15	CORP-00931
1337	PALMAS	06-0509-01	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	915.1786	15	CORP-00931
1338	PALMAS	06-0510-01	MONITOR	Vehículos, maquinaria y equipo (activo)	Administración y oficinas	C	915.1786	15	CORP-00931
1339	SUPREMA	RE0103014	REFRIGERANTE PARA RADIADOR GASOLINA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	129.4643	17	CORP-01036
1340	SUPREMA	RE0304006	EMPAQUE DE METAL CIRCULAR (ESPIROMETALICO) CLASE 150 DE 2-1/2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	25.7934	26	CORP-00500
1341	SAN FRANCISCO	MA0202015	VITAMINA OLIVITASAN 500 ML	Fertilizantes y agroquímicos	Administración y oficinas	C	447.7679	14	CORP-01389
1342	SAN JORGE	MA0202015	VITAMINA OLIVITASAN 500 ML	Fertilizantes y agroquímicos	Administración y oficinas	C	447.7679	24	CORP-01389
1343	PALMAS	MA0108028	TORNILLO HEXAG. 7/8 X 3.1/2	Ferretería general	Mantenimiento industrial	C	8.9286	28	CORP-01271
1344	SUPREMA	RE0306013	FAJA B-68	Repuestos y componentes mecánicos	Mantenimiento industrial	C	63.5204	29	CORP-00564
1345	PALMAS	MA0108054	TORNILLO HEXAG. 3/4 X 6	Ferretería general	Bodega central (stock)	C	8.8616	12	CORP-01262
1346	SUPREMA	MA0102101	VALVULA HN 1 1/2 GLOBO ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	440.7143	20	CORP-01346
1347	SUPREMA	RE0308011	RETENEDOR 340483 NATIONAL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	43.8616	18	CORP-01060
1348	SUPREMA	MA0103026	TAPAGOTERA SISTA GALON	Ferretería general	Mantenimiento industrial	C	437.5	63	CORP-01172
1349	SAN JORGE	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Ganadería	C	79.4643	29	CORP-00357
1350	SAN ANTONIO	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	430.3482	26	CORP-00727
1351	SAN JORGE	MA0202025	LAZO PLASTICO 1/2"	Ferretería general	Agrícola (fincas)	C	12.2768	25	CORP-00862
1352	SUPREMA	RE0309009	SIERRA PARA METAL	Herramientas	Mantenimiento industrial	C	8.5938	28	CORP-01111
1353	PALMAS	RE0103026	INDICADOR TEMPERATURA COMPLETO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	285.7143	15	CORP-00797
1354	ALFA	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	Ferretería general	Mantenimiento industrial	C	71.4286	27	CORP-00091
1355	SUPREMA	RE0317031	HILO TRUPER 2.7 M X 63 M PARA CHAPEADORA	Ferretería general	Mantenimiento industrial	C	106.548	17	CORP-00781
1356	GRS	RE0302012	COJINETE 6307 R2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	84.8214	16	CORP-00363
1357	SUPREMA	08-0301-02	TROCKET	Ferretería general	Mantenimiento industrial	C	847.3661	15	CORP-01290
1358	SUPREMA	08-0300-02	TROCKET	Ferretería general	Mantenimiento industrial	C	847.3661	15	CORP-01290
1359	SUPREMA	08-0299-02	TROCKET	Ferretería general	Mantenimiento industrial	C	847.3661	15	CORP-01290
1360	SUPREMA	08-0302-02	TROCKET	Ferretería general	Mantenimiento industrial	C	847.3661	15	CORP-01290
1361	PALMAS	RE0302076	COJINETE No. 6207 2RS  (35 X 72 X 17 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	65.1786	19	CORP-00396
1362	QUIRICA	MA0202025	LAZO PLASTICO 1/2"	Ferretería general	Ganadería	C	12.0536	27	CORP-00862
1363	ACACIAS	MA0202025	LAZO PLASTICO 1/2"	Ferretería general	Ganadería	C	12.0536	36	CORP-00862
1364	SUPREMA	RE0304043	POMO DE SILICONE TRANSPARENTE	Ferretería general	Mantenimiento industrial	C	23.3036	13	CORP-01010
1365	SUPREMA	05-0545-02	TROCKET	Ferretería general	Mantenimiento industrial	C	831.2411	15	CORP-01290
1366	SUPREMA	05-0543-02	TROCKET	Ferretería general	Mantenimiento industrial	C	831.2411	15	CORP-01290
1367	SUPREMA	05-0544-02	TROCKET	Ferretería general	Mantenimiento industrial	C	831.2411	15	CORP-01290
1368	PALMAS	RE0314062	LEFT HAND COVER P/1531	Repuestos y componentes mecánicos	Mantenimiento industrial	C	820.3095	15	CORP-00877
1369	PALMAS	RE0314063	RIGHT HAND COVER P/1532	Repuestos y componentes mecánicos	Mantenimiento industrial	C	820.121	15	CORP-01073
1370	PALMAS	RE0306058	FAJAS # B-65	Repuestos y componentes mecánicos	Bodega central (stock)	C	67.9152	15	CORP-00586
1371	PALMAS	RE0308006	RETENEDOR 100 X 130 X 12 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	90.501	18	CORP-01050
1372	SAN ANTONIO	MA0202017	VACUNA BOVIBAC PLUS 50 ML	Ganadería y alimento animal	Ganadería	C	203.5714	15	CORP-01331
1373	SAN JORGE	MA0202017	VACUNA BOVIBAC PLUS 50 ML	Ganadería y alimento animal	Ganadería	C	203.5714	14	CORP-01331
1374	SAN FRANCISCO	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	58.0357	15	CORP-00667
1375	PALMAS	MA0108065	TORNILLO HEXAG. 1 X 3" NC. (COMPLETOS, GRADO 8)	Ferretería general	Bodega central (stock)	C	31.25	23	CORP-01253
1376	SUPREMA	RE0302030	COJINETE 6209 ZZ/C3 SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	100.8929	23	CORP-00360
1377	GRS	RE0309019	LAZO DE 1/4 DE 25 LBS	Ferretería general	Mantenimiento industrial	C	401.7857	15	CORP-00861
1378	SUPREMA	RE0103013	BUJIA BPR5	Repuestos y componentes mecánicos	Mantenimiento industrial	C	31.6071	19	CORP-00170
1379	QUIRICA	MA0104002	TUBO PVC 1/2 X 20'	Construcción y obra civil	Flota, maquinaria y combustible	C	15.65	7	CORP-01312
1380	SAN ANTONIO	MA0102017	ADAPTADOR MACHO PVC 3	Construcción y obra civil	Flota, maquinaria y combustible	C	15.625	74	CORP-00050
1381	SUPREMA	RE0201007	BOMBILLA AHORRADORA 25 WATTS	Materiales eléctricos	Mantenimiento industrial	C	19.4196	13	CORP-00140
1382	GRS	RE0309032	AISLADORES PLÁSTICO P/POSTE TIPO W	Construcción y obra civil	Infraestructura y obra civil	C	3.8839	105	CORP-00065
1383	PALMAS	RE0314061	THRUST RING P/1529a	Repuestos y componentes mecánicos	Mantenimiento industrial	C	772.7265	15	CORP-01208
1384	QUIRICA	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	Herramientas	Agrícola (fincas)	C	30.5357	35	CORP-00963
1385	PALMAS	RE0306025	FAJAS # B-90	Repuestos y componentes mecánicos	Mantenimiento industrial	C	75.8929	14	CORP-00597
1386	PALMAS	MA0104081	ANGULAR H.N. 1/4 X 1.1/2 X 20	Construcción y obra civil	Infraestructura y obra civil	C	188.9286	20	CORP-00077
1387	PALMAS	RE0302105	COJINETE No. 6212 2RS  (60 X 110 X 22 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	188.3929	10	CORP-00399
1388	PALMAS	RE0306062	FAJAS # B-94	Repuestos y componentes mecánicos	Mantenimiento industrial	C	75.3571	19	CORP-00598
1389	SAN FRANCISCO	MA0101015	GUANTES NITRILO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	12.5	13	CORP-00758
1390	SAN ANTONIO	MA0101015	GUANTES NITRILO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	12.5	12	CORP-00758
1391	SUPREMA	RE0317144	VENTILADOR DE ALUMINIO PARA MOTOR DIAM. EXT. 6" CIEGO	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	367.8571	14	CORP-01384
1392	PALMAS	RE0317111	TUBO DE SELLO SSP 674A	Papelería, oficina y cómputo	Administración y oficinas	C	730.8482	15	CORP-01296
1393	PALMAS	MA0102138	TUBO GALV. 1/2 X 20 CEDULA-40	Ferretería general	Mantenimiento industrial	C	91.125	79	CORP-01299
1394	SUPREMA	RE0304010	EMPAQUE PARA BRIDA TIPO CLAMP DE 1 DE (EPDM)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	6.5747	35	CORP-00510
1395	SAN ANTONIO	MA0202009	INSECTICIDA HECTOGAN	Fertilizantes y agroquímicos	Agrícola (fincas)	C	361.6071	7	CORP-00804
1396	SAN FRANCISCO	MA0202009	INSECTICIDA HECTOGAN	Fertilizantes y agroquímicos	Agrícola (fincas)	C	361.6071	7	CORP-00804
1397	SUPREMA	RE0304163	JUNTA PLANA Ø140/155 MM TD NO.02043168	Repuestos y componentes mecánicos	Mantenimiento industrial	C	713.9089	1	CORP-00827
1398	SAN ANTONIO	MA0101003	BOTAS HULE (1#38, 1#40, 3#40, 4#41, 4#42 Y 1#43)	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	50.8929	12	CORP-00152
1399	SUPREMA	RE0304153	EMPAQUE INICIAL EN HT-NBR (SNAP ON TYPE) PARA INTERCAMBIADOR KELVION NT80M CDL-10	Repuestos y componentes mecánicos	Mantenimiento industrial	C	351.7095	118	CORP-00507
1400	SUPREMA	RE0310002	BROCHA DE 3	Ferretería general	Mantenimiento industrial	C	11.1607	16	CORP-00163
1401	PALMAS	MA0104010	HEMBRA H.N. 1/4 X 1 X 20	Ferretería general	Bodega central (stock)	C	58.5714	7	CORP-00765
1402	PALMAS	RE0306015	FAJAS # B-50	Repuestos y componentes mecánicos	Bodega central (stock)	C	38.8889	13	CORP-00577
1403	PALMAS	RE0306066	FAJAS # C-78	Repuestos y componentes mecánicos	Bodega central (stock)	C	87.5	11	CORP-00604
1404	PALMAS	RE0101067	FILTRO DIESEL # RE-509031	Repuestos y componentes mecánicos	Bodega central (stock)	C	349.8661	15	CORP-00651
1405	SUPREMA	RE0302027	COJINETE 6206 ZZ M/SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	53.7033	22	CORP-00356
1406	QUIRICA	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	43.5268	18	CORP-01064
1407	PALMAS	RE0102028	PEGAMENTO PEGAR REMALON  (BOTE)	Construcción y obra civil	Infraestructura y obra civil	C	347.7679	12	CORP-00980
1408	METALMECANICA	08-0309-11	MEDIDOR DE DISTANCIA LASER GLM 40 MTS MARCA BOSCH (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	691.9643	29	CORP-00923
1409	METALMECANICA	08-0311-11	MEDIDOR DE DISTANCIA LASER GLM 40 MTS MARCA BOSCH (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	691.9643	29	CORP-00923
1410	METALMECANICA	08-0310-11	MEDIDOR DE DISTANCIA LASER GLM 40 MTS MARCA BOSCH (VER ANEXO)	Materiales eléctricos	Mantenimiento industrial	C	691.9643	29	CORP-00923
1411	SUPREMA	MA0108028	TORNILLO 5/8 X 2 1/2 HEXA COMPLETO GRADO 5	Ferretería general	Mantenimiento industrial	C	5.3306	21	CORP-01230
1412	SUPREMA	MA0102104	VALVULA HN 1 GLOBO SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	339.2857	27	CORP-01352
1413	PALMAS	MA0104063	VARILLA LISA H.N. 3/8 X 20	Construcción y obra civil	Infraestructura y obra civil	C	33.9286	7	CORP-01379
1414	QUIRICA	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	19.1367	49	CORP-00748
1415	SUPREMA	MA0101026	CINTA REFLECTIVA	Ferretería general	Mantenimiento industrial	C	6.6964	23	CORP-00318
1416	SUPREMA	MA0102103	VALVULA HN 1 GLOBO ROSCADA 150 PSI	Repuestos y componentes mecánicos	Mantenimiento industrial	C	334.8214	32	CORP-01351
1417	SUPREMA	MA0102114	VALVULA INOX 2 PASO RAPIDO ROSCABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	334.8214	26	CORP-01366
1418	SUPREMA	RE0308038	RETENEDOR 472164	Repuestos y componentes mecánicos	Mantenimiento industrial	C	47.7551	6	CORP-01066
1419	PALMAS	MA0108005	TORNILLO ALLEN CAB. AVELLANADA 1/2 X 2	Ferretería general	Bodega central (stock)	C	3.3393	15	CORP-01235
1420	SAN JORGE	MA0101004	CARETA ESMERILAR, COMPLETA	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	27.6786	11	CORP-00253
1421	SAN ANTONIO	MA0101004	CARETA ESMERILAR, COMPLETA	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	27.6786	11	CORP-00253
1422	SAN FRANCISCO	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	Herramientas	Agrícola (fincas)	C	10.7143	27	CORP-00888
1423	SUPREMA	RE0101046	FILTRO DE AIRE SAMURAI 1780130070	Repuestos y componentes mecánicos	Mantenimiento industrial	C	80.3571	5	CORP-00636
1425	SUPREMA	RE0304160	JUNTA PLANA Ø120/135 MM TD NO.02043133	Repuestos y componentes mecánicos	Mantenimiento industrial	C	635.7013	1	CORP-00826
1426	SAN JORGE	IN0303003	INSECTICIDA FIADOR 35 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	316.9643	41	CORP-00803
1427	ALFA	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Ganadería	C	48.2143	29	CORP-01064
1428	SAN ANTONIO	MA0202004	LARVICID UNICLILINA SPRAY	Ferretería general	Agrícola (fincas)	C	62.5	101	CORP-00856
1429	SUPREMA	RE0304127	O-RING, AS568A-115 VITON #PARTE 1115-167 PARA CHORRO EPACK	Repuestos y componentes mecánicos	Mantenimiento industrial	C	12.5	127	CORP-00955
1430	SUPREMA	RE0309020	BRIEDA NOX 1-1/2" CLASE 150 SOLDABLE	Ferretería general	Mantenimiento industrial	C	89.2857	10	CORP-00160
1431	PALMAS	RE0101072	FILTRO AIRE # AT-332909	Repuestos y componentes mecánicos	Bodega central (stock)	C	310.0446	15	CORP-00621
1432	ACACIAS	RE0302002	COJINETE # 6207 2RS1/C3 (MARCA SKF)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	61.6071	29	CORP-00357
1433	SUPREMA	RE0101049	FILTRO DE ACEITE MD069782	Repuestos y componentes mecánicos	Mantenimiento industrial	C	205.3571	39	CORP-00629
1434	SUPREMA	RE0317005	ACOPLE LOVEJOY TIPO ESTRELLA L150	Repuestos y componentes mecánicos	Mantenimiento industrial	C	615.1786	40	CORP-00044
1435	GRS	MA0105011	BOTE AFLOJATODO RENBALK 20 ONZ.	Ferretería general	Mantenimiento industrial	C	102.2321	30	CORP-00154
1436	GRS	RE0302011	COJINETE 6306 R2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	61.1607	16	CORP-00361
1437	SAN FRANCISCO	MA0101003	BOTAS HULE (1#38, 3#40, 4#41, 2#42, 2#43)	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	50.8929	155	CORP-00153
1438	SAN JORGE	MA0101003	BOTAS HULE (1#38, 1#40, 2#40, 4#41, 2#42 Y 2#43)	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	50.8929	18	CORP-00151
1439	PALMAS	MA0108025	TORNILLO HEXAG. 5/8 X 2	Ferretería general	Bodega central (stock)	C	2.0312	12	CORP-01268
1440	SAN FRANCISCO	MA0202024	LAZO PLASTICO 3/8"	Ferretería general	Agrícola (fincas)	C	12.1652	52	CORP-00865
1441	SUPREMA	RE0304004	EMPAQUE DE METAL CIRCULAR (ESPIROMETALICO) CLASE 150 DE 03	Repuestos y componentes mecánicos	Mantenimiento industrial	C	30.3571	22	CORP-00499
1442	PALMAS	MA0108020	TORNILLO HEXAG. 3/4 X 4	Ferretería general	Mantenimiento industrial	C	6.0714	31	CORP-01260
1443	QUIRICA	MA0202024	LAZO PLASTICO 3/8"	Ferretería general	Ganadería	C	12.0536	36	CORP-00865
1444	SUPREMA	RE0201065	FLIPON DOBLE DE 30 AMPERIOS GENERAL ELECTRIC	Materiales eléctricos	Mantenimiento industrial	C	120.5357	14	CORP-00676
1445	PALMAS	MA0107025	ELECTRODO BRONCE UTP-32 DE 1/8"	Herramientas	Mantenimiento industrial	C	12.0536	7	CORP-00493
1446	SUPREMA	RE0305005	MANOMETRO 0-300 PSI DE 2.5 DE DIAL 1/4 DE ROSCA NPT	Herramientas	Mantenimiento industrial	C	200.8929	18	CORP-00916
1447	ACACIAS	MA0202024	LAZO PLASTICO 3/8"	Ferretería general	Ganadería	C	12.0536	44	CORP-00865
1448	SAN JORGE	MA0202024	LAZO PLASTICO 3/8"	Ferretería general	Agrícola (fincas)	C	12.0536	52	CORP-00865
1449	ALFA	MA0102110	TEE PVC 3/4	Construcción y obra civil	Flota, maquinaria y combustible	C	2.0076	60	CORP-01182
1450	SAN JORGE	MA0101015	GUANTES NITRILO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	12.5	12	CORP-00758
1451	PALMAS	RE0314059	LOCKING COLLAR P/1529	Repuestos y componentes mecánicos	Mantenimiento industrial	C	598.0005	15	CORP-00901
1452	PALMAS	RE0301015	TERMOSTATO RAINBOW TS-320S 20A/250VAC 50-320°C HORNO VWR	Materiales eléctricos	Bodega central (stock)	C	147.3214	8	CORP-01204
1453	PALMAS	RE0306063	FAJAS # B-102	Repuestos y componentes mecánicos	Bodega central (stock)	C	73.2143	17	CORP-00568
1454	PALMAS	RE0101048	FILTRO DIESEL LFP-815 FN (FREIGHTLINER)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	146.4286	18	CORP-00649
1455	PALMAS	RE0101049	FILTRO DIESEL LFP-816 FN (FREIGHTLINER)	Repuestos y componentes mecánicos	Flota, maquinaria y combustible	C	146.4286	18	CORP-00650
1456	PALMAS	RE0302051	COJINETE No. 6305 2RS  (25 X 62 X 17 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	58.3929	35	CORP-00405
1457	PALMAS	RE0306060	FAJAS # B-70	Repuestos y componentes mecánicos	Mantenimiento industrial	C	58.0357	17	CORP-00590
1458	PALMAS	MA0102093	UNION UNIVERSAL HN 2  (ROSCADO)	Ferretería general	Mantenimiento industrial	C	96.4286	84	CORP-01329
1459	SUPREMA	RE0101050	FILTRO DE AIRE M0603446 K20TB	Repuestos y componentes mecánicos	Mantenimiento industrial	C	191.9643	39	CORP-00633
1460	SAN FRANCISCO	MA0101009	CINTURON CUERO PARA FUERZA (4 TALLA M, 4 TALLA S)	Ferretería general	Agrícola (fincas)	C	71.4286	27	CORP-00331
1461	SAN ANTONIO	MA0101009	CINTURON CUERO PARA FUERZA (4 TALLA M Y 4 TALLA S)	Ferretería general	Ganadería	C	71.4286	18	CORP-00332
1462	SAN JORGE	MA0101009	CINTURON CUERO PARA FUERZA (4 TALLA M Y 4 TALLA S)	Ferretería general	Agrícola (fincas)	C	71.4286	8	CORP-00332
1463	GRS	RE0310003	PINTURA ESMALTE BRILLANTE VERDE JARDIN	Construcción y obra civil	Infraestructura y obra civil	C	113.3929	16	CORP-00993
1464	ALFA	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Ganadería	C	94.3839	29	CORP-00357
1465	PALMAS	RE0308009	RETENEDOR 150 X 180 X 15 MM. (PRENSA)	Repuestos y componentes mecánicos	Bodega central (stock)	C	141.0714	15	CORP-01057
1466	SUPREMA	RE0309017	BRIDA HN 1-1/2" CLASE 150 SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	37.5	9	CORP-00156
1467	METALMECANICA	RE0316005	BURIL TUNGSTENO DERECHO 1/2"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	42.8571	19	CORP-00172
1468	ACACIAS	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	Ferretería general	Agrícola (fincas)	C	23.2143	16	CORP-00879
1469	SUPREMA	RE0101037	FILTRO DE DIESEL 33336	Repuestos y componentes mecánicos	Mantenimiento industrial	C	110.8929	24	CORP-00639
1470	PALMAS	RE0306019	FAJAS # B-67	Repuestos y componentes mecánicos	Mantenimiento industrial	C	55.3571	23	CORP-00588
1471	PALMAS	MA0105002	ACEITE 3 EN 1 (BOTE 90 ML.)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	42.239	27	CORP-00010
1472	PALMAS	RE0103038	RETENEDOR 85 X 105 X 13 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	274.2679	21	CORP-01069
1473	PALMAS	RE0312026	NUT (60853850)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	271.7622	15	CORP-00950
1474	GRS	RE0201095	BOMBILLA AHORRADORA ESPIRAL 25 W SYLVANIA	Materiales eléctricos	Mantenimiento industrial	C	26.7857	24	CORP-00142
1475	SUPREMA	RE0103005	LIQUIDO DE FRENOS WAGNER	Repuestos y componentes mecánicos	Mantenimiento industrial	C	53.5714	13	CORP-00891
1476	SUPREMA	08-0295-02	POLIPASTO	Herramientas	Mantenimiento industrial	C	535.7143	30	CORP-01002
1477	PALMAS	RE0304010	EMPAQUE HULE TUBO VIDRIO VISOR 15.5 MM. Ø EXT.	Construcción y obra civil	Infraestructura y obra civil	C	17.857	17	CORP-00506
1478	PALMAS	MA0108019	TORNILLO HEXAG. 3/4 X 1.1/2	Ferretería general	Mantenimiento industrial	C	5.3125	28	CORP-01257
1479	SUPREMA	RE0201015	CABLE 12 THHN COLOR NEGRO	Materiales eléctricos	Mantenimiento industrial	C	5.2232	15	CORP-00179
1480	SUPREMA	MA0102100	VALVULA HN 1 1/2 BOLA ROSCADA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	260.2679	10	CORP-01345
1481	SAN ANTONIO	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	Fertilizantes y agroquímicos	Agrícola (fincas)	C	37.0536	23	CORP-00085
1482	PALMAS	RE0312007	GASKET (PART. 60853849) = 206-106	Repuestos y componentes mecánicos	Mantenimiento industrial	C	259.3692	15	CORP-00743
1483	PALMAS	MA0104004	ANGULAR H.N. 3/16 X 1.1/2 X 20	Construcción y obra civil	Infraestructura y obra civil	C	129.4643	27	CORP-00079
1484	METALMECANICA	RE0316007	BURIL TUNGSTENO PUNTA 1/2"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	42.8571	22	CORP-00174
1485	SAN JORGE	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	Herramientas	Agrícola (fincas)	C	10.7143	41	CORP-00888
1486	SAN ANTONIO	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	Herramientas	Agrícola (fincas)	C	10.7143	23	CORP-00888
1487	PALMAS	RE0306057	FAJAS # B-49	Repuestos y componentes mecánicos	Bodega central (stock)	C	39.3098	17	CORP-00576
1488	SAN JORGE	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	Ferretería general	Agrícola (fincas)	C	20.9821	16	CORP-00879
1489	SAN ANTONIO	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	Ferretería general	Agrícola (fincas)	C	20.9821	13	CORP-00879
1490	PALMAS	RE0304051	EMPAQUE ESPIROMETALICO PARA VALVULA 4 (0-150 PSI)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	100.4464	26	CORP-00504
1491	PALMAS	RE0306049	FAJAS # B-61	Repuestos y componentes mecánicos	Mantenimiento industrial	C	50	14	CORP-00584
1492	SUPREMA	MA0102106	VALVULA HN 1/4 ROSCADA PASO RAPIDO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	62.5	30	CORP-01349
1493	SAN JORGE	MA0101022	PANTALLA CARETA ESMERILAR	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	20.5357	6	CORP-00967
1494	SAN ANTONIO	MA0101022	PANTALLA CARETA ESMERILAR	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	20.5357	13	CORP-00967
1495	SUPREMA	MA0102096	VALVULA 3/4 PARA CHORRO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	49.1071	25	CORP-01334
1496	SUPREMA	RE0316014	LIJA 80 P/METAL	Ferretería general	Mantenimiento industrial	C	6.5476	21	CORP-00886
1497	GRS	RE0309022	LLAVE DE PASO GALVANIZADA DE 3/4	Construcción y obra civil	Infraestructura y obra civil	C	49.1071	5	CORP-00896
1498	PALMAS	IN0106001	TAPON PLASTICO GARRAFON 5 (GLS)	Material de empaque	Producción / Planta	C	0.8929	12	CORP-01174
1499	SUPREMA	RE0302044	COJINETE 6307 ZZ SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	122.3214	19	CORP-00364
1500	PALMAS	RE0302073	OBSTURACION SKF No. TSN 519L EJE 85 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	241.4643	16	CORP-00957
1501	SUPREMA	MA0102097	VALVULA BONCE 1/2 PARA CHORRO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	53.5714	21	CORP-01337
1502	SUPREMA	RE0316012	LIJA 60 P/METAL	Ferretería general	Mantenimiento industrial	C	6.824	21	CORP-00884
1503	PALMAS	MA0108056	TORNILLO EXAGONAL 1/2 X 2.1/2	Ferretería general	Bodega central (stock)	C	1.5848	12	CORP-01244
1504	SUPREMA	MA0107015	LBS. DE ELECTRODO 7018 1/8 (MARCA ECA)	Herramientas	Mantenimiento industrial	C	10.7143	7	CORP-00870
1505	PALMAS	RE0312006	GASKET (PART. 206103)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	234.9909	15	CORP-00742
1506	ALFA	MA0102069	PEGAMENTO PVC WET BONDING PEGAR EN MOJADO (PRESENT. 1/4 GALON)	Construcción y obra civil	Flota, maquinaria y combustible	C	469.2768	47	CORP-00982
1507	PALMAS	RE0309014	PITA NYLON 1/8 X 10 LBS. (ROLLO)	Ferretería general	Bodega central (stock)	C	93.75	8	CORP-00997
1508	GRS	RE0309030	WIPE COLOR BLANCO	Fertilizantes y agroquímicos	Agrícola (fincas)	C	11.6071	18	CORP-01392
1509	PALMAS	RE0302052	COJINETE No. 6306 2RS  (30 X 72 X 19 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	76.7857	14	CORP-00406
1510	SUPREMA	RE0101040	FILTRO DE ACEITE HIDRAULICO 57131	Repuestos y componentes mecánicos	Mantenimiento industrial	C	91.9643	21	CORP-00627
1511	SAN JORGE	MA0202009	INSECTICIDA HECTOGAN	Fertilizantes y agroquímicos	Agrícola (fincas)	C	455.3571	7	CORP-00804
1512	GRS	MA0106001	KIT LASER PARA DETERMINACIÓN DE YODO EN SAL 40 DETERMINACIONES	Insumos químicos de producción	Producción / Planta	C	223.2143	15	CORP-00830
1513	ACACIAS	MA0108004	TORNILLO ABRAZADERA 8X50 MM. ROSCA CORRIDA (COMPLETOS, GRADO 8)	Ferretería general	Mantenimiento industrial	C	2.2321	16	CORP-01234
1514	SAN JORGE	MA0108004	TORNILLO ABRAZADERA 8X50 MM. ROSCA CORRIDA (COMPLETOS, GRADO 8)	Ferretería general	Mantenimiento industrial	C	2.2321	19	CORP-01234
1515	SUPREMA	RE0304045	ROLLO DE TEFLON DE 3/4	Ferretería general	Mantenimiento industrial	C	2.2321	22	CORP-01076
1516	SAN ANTONIO	MA0102104	TEE PLASTICA 1/8 X 8MM	Construcción y obra civil	Flota, maquinaria y combustible	C	11.1607	72	CORP-01179
1517	PALMAS	MA0107024	VARILLA LATON CON FUNDENTE 1/8 X 36	Construcción y obra civil	Infraestructura y obra civil	C	14.4009	16	CORP-01378
1518	ALFA	MA0102042	CODO PVC 3/4 X 90°  (LISO)	Construcción y obra civil	Flota, maquinaria y combustible	C	1.4911	61	CORP-00347
1519	PALMAS	RE0310012	RODILLO PINTAR, COMPLETO (KIT)	Repuestos y componentes mecánicos	Bodega central (stock)	C	43.75	38	CORP-01074
1520	SUPREMA	RE0101048	FILTRO DE DIESEL SFF 0900	Repuestos y componentes mecánicos	Mantenimiento industrial	C	87.5	39	CORP-00641
1521	PALMAS	RE0306052	UNION CADENA 80-2	Repuestos y componentes mecánicos	Bodega central (stock)	C	17.5	12	CORP-01326
1522	PALMAS	RE0314036	EXPELLER ARMS VDP3015a B/N (PRENSAS)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	108.9442	15	CORP-00562
1523	PALMAS	RE0101094	FILTRO PARA DIESEL FP586F LUBER FINER = FF5018 SORL	Repuestos y componentes mecánicos	Mantenimiento industrial	C	72.3214	57	CORP-00659
1524	SUPREMA	RE0304009	EMPAQUE METAL CIRCULAR (ESPIROMETALICO) CLASE 150 DE 01	Repuestos y componentes mecánicos	Mantenimiento industrial	C	12.3622	22	CORP-00509
1525	SAN FRANCISCO	MA0202025	LAZO PLASTICO 1/2"	Ferretería general	Agrícola (fincas)	C	12.2768	23	CORP-00862
1526	SAN ANTONIO	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	Ferretería general	Agrícola (fincas)	C	71.4286	23	CORP-00091
1527	SAN JORGE	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	Ferretería general	Agrícola (fincas)	C	71.4286	30	CORP-00091
1528	SUPREMA	MA0107013	LBS. DE ELECTRODO 6013 1/8	Herramientas	Mantenimiento industrial	C	12.9464	6	CORP-00868
1529	SUPREMA	MA0107014	LBS. DE ELECTRODO 6013 3/32	Herramientas	Mantenimiento industrial	C	12.9464	6	CORP-00869
1530	PALMAS	MA0102079	TUBO HN 1/2 X 20 CEDULA-40 SIN COSTURA	Ferretería general	Mantenimiento industrial	C	106.0714	21	CORP-01304
1531	SUPREMA	RE0201157	FUSIBLE DE CARTUCHO 100 AMP SIEMENS 3NA3 830	Materiales eléctricos	Mantenimiento industrial	C	84.8214	13	CORP-00728
1532	SUPREMA	RE0304161	JUEGO DE EMPAQUES INTERNOS TD 02043112	Repuestos y componentes mecánicos	Mantenimiento industrial	C	422.5942	1	CORP-00819
1533	SUPREMA	MA0103007	CINTA SISTA TAPAGOTERA	Ferretería general	Mantenimiento industrial	C	209.8214	47	CORP-00325
1534	PALMAS	RE0306056	FAJAS # B-46	Repuestos y componentes mecánicos	Bodega central (stock)	C	34.375	17	CORP-00575
1535	QUIRICA	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	33.9286	29	CORP-00393
1536	SAN FRANCISCO	MA0202017	VACUNA BOVIBAC PLUS 50 ML	Ganadería y alimento animal	Ganadería	C	203.5714	10	CORP-01331
1537	SAN JORGE	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Ganadería	C	33.9286	28	CORP-00393
1538	SUPREMA	MA0108030	TORNILLO 5/8 X 3 1/2 HEXA COMPLETOS	Ferretería general	Mantenimiento industrial	C	5.3571	16	CORP-01232
1539	PALMAS	RE0101090	FILTRO ACEITE LFP 3900 LUBER FINER = LF3345 FLEETGUARD	Repuestos y componentes mecánicos	Mantenimiento industrial	C	66.875	57	CORP-00614
1540	GRS	RE0201033	CAPACITOR DE MARCHA JARD 55MFD 440V 370V-12752	Materiales eléctricos	Mantenimiento industrial	C	79.6161	30	CORP-00249
1541	SUPREMA	RE0201014	CABLE 10 THHN COLOR NEGRO	Materiales eléctricos	Mantenimiento industrial	C	7.8571	13	CORP-00178
1542	GRS	RE0302014	COJINETE 63092RS	Repuestos y componentes mecánicos	Mantenimiento industrial	C	196.0714	10	CORP-00367
1543	GRS	MA0108010	TORNILLOS ACERO INOX. R/ CORRIDA 3/8 X 4-1/2 COMPLETOS	Ferretería general	Mantenimiento industrial	C	15.625	21	CORP-01283
1544	SUPREMA	MA0109001	ADHESIVO EPOXICO LOCTITE EPOXI-MIL	Ferretería general	Mantenimiento industrial	C	35.0731	20	CORP-00057
1545	SAN JORGE	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	384.2411	41	CORP-00727
1546	SUPREMA	RE0101014	FILTRO DIESEL 33393	Repuestos y componentes mecánicos	Mantenimiento industrial	C	94.1964	14	CORP-00646
1547	PALMAS	RE0308047	RETENEDOR 110 X 150 X 13 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	93.75	18	CORP-01052
1548	SAN JORGE	MA0202004	LARVICID UNICICLINA SPRAY	Ferretería general	Agrícola (fincas)	C	62.5	112	CORP-00855
1549	PALMAS	RE0308044	RETENEDOR 120 X 150 X 13 MM.	Repuestos y componentes mecánicos	Bodega central (stock)	C	93.75	23	CORP-01054
1550	SAN JORGE	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	Fertilizantes y agroquímicos	Agrícola (fincas)	C	37.0536	22	CORP-00085
1551	SAN JORGE	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	Fertilizantes y agroquímicos	Agrícola (fincas)	C	7.3661	40	CORP-00773
1552	PALMAS	MA0108045	TORNILLO CENTRO 1/2" X 8"	Ferretería general	Bodega central (stock)	C	24.4643	17	CORP-01243
1553	PALMAS	RE0304014	ESTOPA GRAFITADA 1/2 (PIE)	Repuestos y componentes mecánicos	Bodega central (stock)	C	36.6071	7	CORP-00548
1554	SUPREMA	RE0101047	FILTRO DE DIESEL AUTOX I.N: 23390-0L010	Repuestos y componentes mecánicos	Mantenimiento industrial	C	45.7589	5	CORP-00640
1555	PALMAS	RE0317003	TUBO VIDRIO VISOR 15.5 MM X 12 LINEA ROJA (PIREX)	Construcción y obra civil	Infraestructura y obra civil	C	183.035	13	CORP-01317
1556	SUPREMA	RE0309016	BRIDA HN 2" CLASE  150 SOLDABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	40.1786	8	CORP-00157
1557	PALMAS	MA0102159	TUBO H.N. 2 X 20 CEDULA-40 SIN COSTURA	Ferretería general	Mantenimiento industrial	C	360.4018	21	CORP-01302
1558	SUPREMA	RE0317091	CONO DE HILO POLYALGODON 15	Repuestos y componentes mecánicos	Mantenimiento industrial	C	13.8393	35	CORP-00434
1559	SAN JORGE	MA0104015	TORNILLO CABEZA HEXAG. NC. DE 1/4" X 1.1/2"  (COMPLETOS, GRADO 8)	Ferretería general	Mantenimiento industrial	C	1.7857	19	CORP-01239
1560	ACACIAS	MA0108001	TORNILLO CABEZA HEXAG. NC. DE 1/4" X 1.1/2"  (COMPLETOS, GRADO 8)	Ferretería general	Mantenimiento industrial	C	1.7857	16	CORP-01239
1561	PALMAS	RE0306008	CHUCHO SUJETACABLE 5/8	Ferretería general	Bodega central (stock)	C	11.6071	16	CORP-00285
1562	SUPREMA	RE0201004	BATERIA DE 9 VOLTIOS CUADRADA	Materiales eléctricos	Mantenimiento industrial	C	34.8214	9	CORP-00119
1563	ACACIAS	MA0202001	ANTIBIOTICO EMISINA 100 ML.	Papelería, oficina y cómputo	Ganadería	C	348.2143	32	CORP-00086
1564	SUPREMA	RE0201069	FOTOCELDAS FICHER 220 VOLTIOS	Materiales eléctricos	Mantenimiento industrial	C	57.7232	14	CORP-00711
1565	PALMAS	RE0306055	FAJAS # B-42	Repuestos y componentes mecánicos	Mantenimiento industrial	C	34.5982	17	CORP-00572
1566	SUPREMA	RE0304162	JUEGO DE EMPAQUES INTERNOS TD 02043100	Repuestos y componentes mecánicos	Mantenimiento industrial	C	345.821	1	CORP-00818
1567	PALMAS	RE0101091	FILTRO DIESEL LFF3417 LUBER FINER = FS1280 FLEETGUARD	Repuestos y componentes mecánicos	Mantenimiento industrial	C	57.3661	57	CORP-00648
1568	PALMAS	RE0302040	COJINETE No. 6201 2RS  (12 X 32 X 10 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	24.5026	18	CORP-00390
1569	PALMAS	RE0308018	RETENEDOR 38 X 62 X 8 MM.	Repuestos y componentes mecánicos	Mantenimiento industrial	C	42.7679	6	CORP-01062
1570	SAN ANTONIO	MA0102068	MICROTUBO PLASTICO 8MM	Ferretería general	Flota, maquinaria y combustible	C	7.5893	54	CORP-00929
1571	GRS	RE0310002	PINTURA ESMALTE BRILLANTE AMARILLO	Construcción y obra civil	Infraestructura y obra civil	C	113.3929	17	CORP-00992
1572	PALMAS	RE0103014	CONECTOR HEMBRA CHICOTE LUZ	Materiales eléctricos	Bodega central (stock)	C	84.8214	19	CORP-00428
1573	PALMAS	RE0302043	COJINETE No. 6208 2RS  (40 X 80 X 18 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	83.9286	29	CORP-00397
1574	ALFA	MA0104006	TUBO PVC 3 X 20'  (80 PSI.)	Construcción y obra civil	Flota, maquinaria y combustible	C	83.8795	52	CORP-01315
1575	SAN FRANCISCO	MA0101018	MASCARILLA MEDIA CARA 3M	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	111.6071	14	CORP-00921
1576	SAN ANTONIO	MA0101018	MASCARILLA MEDIA CARA 3M	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	111.6071	13	CORP-00921
1577	SAN JORGE	MA0101018	MASCARILLA MEDIA CARA 3M	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	111.6071	16	CORP-00921
1578	SAN FRANCISCO	MA0101004	CARETA ESMERILAR, COMPLETA	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	27.6786	85	CORP-00253
1579	ALFA	MA0102004	ADAPTADOR PVC INYECTADO DE 3/4" A 1/2" CON ROSCA	Construcción y obra civil	Flota, maquinaria y combustible	C	2.2054	74	CORP-00054
1580	PALMAS	RE0306068	CADENA No 60-1	Repuestos y componentes mecánicos	Mantenimiento industrial	C	32.7679	16	CORP-00191
1581	ALFA	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	Repuestos y componentes mecánicos	Ganadería	C	40.4107	29	CORP-00393
1582	ALFA	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	Herramientas	Agrícola (fincas)	C	13.3929	36	CORP-00888
1583	GRS	RE0309026	MICRO SWICH P/SELLADORAS CD-260	Construcción y obra civil	Infraestructura y obra civil	C	40.1786	32	CORP-00927
1584	SUPREMA	RE0317039	RETENEDOR 35-52-7 NBR	Fertilizantes y agroquímicos	Agrícola (fincas)	C	40.1786	29	CORP-01061
1585	SUPREMA	RE0316017	CEPILLO DE ALAMBRE 2" TIPO COPA PARA BARRENO	Herramientas	Mantenimiento industrial	C	10.7143	31	CORP-00275
1586	PALMAS	MA0108036	TORNILLO POLSER (PUNTA BROCA) 1/4 X 2 COMPLETO	Herramientas	Mantenimiento industrial	C	0.3125	22	CORP-01280
1587	SUPREMA	MA0107034	TIZA	Ferretería general	Mantenimiento industrial	C	3.125	39	CORP-01211
1588	PALMAS	RE0103040	TERMINAL PLOMO PARA BATERIAS	Materiales eléctricos	Mantenimiento industrial	C	15.625	19	CORP-01189
1589	PALMAS	MA0105024	PASTA KOLOR KUT MEDIR COMBUSTIBLE (BOTE 2.25 ONZAS)	Combustibles y lubricantes	Flota, maquinaria y combustible	C	103.9732	52	CORP-00977
1590	PALMAS	RE0306023	FAJAS # B-81	Repuestos y componentes mecánicos	Mantenimiento industrial	C	75.8929	34	CORP-00593
1591	ACACIAS	RE0302001	COJINETE No. 6204 2RS1/C3 (MARCA SKF)	Repuestos y componentes mecánicos	Agrícola (fincas)	C	30.3571	29	CORP-00393
1592	METALMECANICA	RE0316006	BURIL TUNGSTENO IZQUIERDO 1/2"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	42.8571	19	CORP-00173
1593	SUPREMA	RE0302025	COJINETE 6204 ZZ SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	37.5	19	CORP-00353
1594	SAN FRANCISCO	MA0102017	ADAPTADOR MACHO PVC 3	Construcción y obra civil	Flota, maquinaria y combustible	C	15.625	80	CORP-00050
1595	SUPREMA	RE0302042	COJINETE 6306 ZZ	Repuestos y componentes mecánicos	Mantenimiento industrial	C	74.1071	16	CORP-00362
1596	PALMAS	RE0201039	FOTOCELDA 105/285 VOLTIOS	Materiales eléctricos	Bodega central (stock)	C	58.0357	13	CORP-00710
1597	SUPREMA	MA0108022	TORNILLO 3/8 X 2 HEXA COMPLETOS HN (ROSCA CORRIDA)	Ferretería general	Mantenimiento industrial	C	7.1429	19	CORP-01228
1598	SAN FRANCISCO	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	Ferretería general	Agrícola (fincas)	C	71.4286	27	CORP-00091
1599	PALMAS	RE0303046	BARRA ACERO 1045  2 GRUESO	Ferretería general	Mantenimiento industrial	C	6.9643	31	CORP-00106
1600	SAN ANTONIO	IN0303001	INSECTICIDA ARTILLERO 25 EC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	68	26	CORP-00800
1601	PALMAS	RE0306021	FAJAS # B-78	Repuestos y componentes mecánicos	Mantenimiento industrial	C	67.8571	14	CORP-00592
1602	SUPREMA	MA0102092	UNION UNIVERSAL HN 1 ROSCADA	Insumos químicos de producción	Producción / Planta	C	44.6429	21	CORP-01328
1603	SAN ANTONIO	MA0202032	CICATRIZANTE TOPAZONE SPRAY	Ferretería general	Agrícola (fincas)	C	89.2857	23	CORP-00299
1604	PALMAS	MA0108053	TORNILLO HEXAG. 3/4 X 3" NC. (COMPLETOS, GRADO 8)	Ferretería general	Bodega central (stock)	C	13.3929	17	CORP-01259
1605	PALMAS	RE0306040	FAJAS # B-53	Repuestos y componentes mecánicos	Bodega central (stock)	C	32.8125	18	CORP-00579
1606	SAN JORGE	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Ganadería	C	43.5268	28	CORP-01064
1607	SUPREMA	RE0201127	TUBO FLEXIBLE LT 3/4	Ferretería general	Mantenimiento industrial	C	10.2679	15	CORP-01298
1608	GRS	RE0309045	CANDADO YALE  DE 60MM	Construcción y obra civil	Infraestructura y obra civil	C	84.0357	56	CORP-00241
1609	PALMAS	MA0102022	CODO HN 2 X 90° (ROSCADO)	Construcción y obra civil	Infraestructura y obra civil	C	41.9643	53	CORP-00341
1610	SAN FRANCISCO	MA0202004	LARVICID UNICICLINA SPRAY	Ferretería general	Agrícola (fincas)	C	62.5	104	CORP-00855
1611	SUPREMA	RE0304132	EMPAQUE TIPO CLAMP 2" EPDM	Ferretería general	Mantenimiento industrial	C	7.1429	19	CORP-00512
1612	SUPREMA	MA0108008	TORNILLO 1/2 X 3 HEXA COMPLETO ROSCA CORRIDA	Ferretería general	Mantenimiento industrial	C	3.6673	21	CORP-01219
1613	PALMAS	RE0103041	TORNILLO CENTRO 1/2 X 12	Ferretería general	Mantenimiento industrial	C	24.6429	21	CORP-01242
1614	SAN FRANCISCO	MA0101022	PANTALLA CARETA ESMERILAR	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	20.5357	85	CORP-00967
1615	SAN FRANCISCO	IN0303001	INSECTICIDA ARTILLERO 25 EC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	60.7143	41	CORP-00800
1616	SUPREMA	RE0201144	TUBO FLEXIBLE LT - 1/2	Ferretería general	Mantenimiento industrial	C	8.0357	20	CORP-01297
1617	PALMAS	RE0201018	CINCHOS PLASTICOS DE DIF. MEDIDAS	Ferretería general	Bodega central (stock)	C	0.2709	15	CORP-00310
1618	QUIRICA	MA0202023	LAZO PLASTICO 1/4"	Ferretería general	Ganadería	C	12.0536	55	CORP-00863
1619	ACACIAS	MA0202023	LAZO PLASTICO 1/4"	Ferretería general	Ganadería	C	12.0536	53	CORP-00863
1620	SAN FRANCISCO	MA0202023	LAZO PLASTICO 1/4"	Ferretería general	Agrícola (fincas)	C	12.0536	61	CORP-00863
1621	SAN JORGE	MA0202023	LAZO PLASTICO 1/4"	Ferretería general	Agrícola (fincas)	C	12.0536	52	CORP-00863
1622	SUPREMA	MA0108016	TORNILLO 3/4 X 3 HEXA COMPLETO	Ferretería general	Mantenimiento industrial	C	5.1339	29	CORP-01224
1623	SUPREMA	RE0309007	BROCA P/METAL 1/8 DE COBALTO	Herramientas	Mantenimiento industrial	C	10.132	20	CORP-00161
1624	PALMAS	RE0306007	CHUCHO SUJETACABLE 1/2	Ferretería general	Bodega central (stock)	C	5.8036	14	CORP-00284
1625	PALMAS	RE0302031	COJINETE No. 6002 2RS  (15 X 32 X 9 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	29.0089	15	CORP-00385
1626	PALMAS	RE0307013	GRASERAS CURVAS DE 1/8"	Repuestos y componentes mecánicos	Mantenimiento industrial	C	9.0179	6	CORP-00753
1627	PALMAS	RE0201058	REFLECTOR AHORRADOR 25 WATTS E-27	Materiales eléctricos	Bodega central (stock)	C	22.3214	5	CORP-01033
1628	ACACIAS	MA0102067	MANOMETRO CON GLICERINA 0-100 PSI. CARAT. 2.5	Insumos químicos de producción	Producción / Planta	C	111.6071	61	CORP-00917
1629	SUPREMA	MA0102099	VALVULA HG 3/4 PASO RAPIDO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	55.7143	25	CORP-01344
1630	SAN FRANCISCO	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	Fertilizantes y agroquímicos	Agrícola (fincas)	C	37.0536	22	CORP-00085
1631	SUPREMA	MA0101021	ROLLO DE CINTA DE PELIGRO COLOR ROJO	Ferretería general	Mantenimiento industrial	C	107.1429	23	CORP-01075
1632	PALMAS	RE0306010	ESPROCKET 22 DIENTES CADENA 60-1	Repuestos y componentes mecánicos	Mantenimiento industrial	C	209.8214	19	CORP-00544
1633	SUPREMA	RE0201155	SWITCH DOBLE 120 VAC, 15 AMP PARA EMPOTRAR	Materiales eléctricos	Mantenimiento industrial	C	34.1071	14	CORP-01151
1634	SAN FRANCISCO	MA0104005	TUBO PVC 2 X 20'  (80 PSI.)	Construcción y obra civil	Flota, maquinaria y combustible	C	40.9107	48	CORP-01313
1635	SAN ANTONIO	MA0102109	TEE PVC 3	Construcción y obra civil	Flota, maquinaria y combustible	C	33.9286	73	CORP-01181
1636	SAN FRANCISCO	IN0304001	FUNGICIDA CLOROTAC 72 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	67.2857	41	CORP-00725
1637	PALMAS	RE0302033	COJINETE No. 6007 2RS  (35 X 62 X 14 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	50	29	CORP-00387
1638	ALFA	RE0310013	THINER LACA (SELLADO)	Otros materiales	Agrícola (fincas)	C	98.2143	13	CORP-01206
1639	GRS	MA0101008	PAR DE BOTAS BLANCAS #40	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	49.1071	26	CORP-00973
1640	SUPREMA	RE0302029	COJINETE 6208 ZZ SKF	Repuestos y componentes mecánicos	Mantenimiento industrial	C	96.4286	22	CORP-00359
1641	SAN ANTONIO	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	Fertilizantes y agroquímicos	Agrícola (fincas)	C	59.9387	26	CORP-00726
1642	GRS	IN0501004	CULTIVOS STI-12 PARA MOZARELLA	Ferretería general	Mantenimiento industrial	C	94.6429	15	CORP-00452
1643	SAN JORGE	IN0303001	INSECTICIDA ARTILLERO 25 EC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	60.7143	41	CORP-00800
1644	GRS	RE0302006	COJINETE 62052RS	Repuestos y componentes mecánicos	Mantenimiento industrial	C	44.9196	10	CORP-00355
1645	PALMAS	RE0302049	COJINETE No. 6302 2RS  (15 X 42 X 13 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	44.8393	15	CORP-00403
1646	PALMAS	MA0108064	TARUGO PLASTICO DIF. MEDIDAS	Ferretería general	Mantenimiento industrial	C	0.8929	13	CORP-01176
1647	PALMAS	RE0312019	BASES DE 8 PINES PARA RELES   (DESARENADOR)	Materiales eléctricos	Mantenimiento industrial	C	17.8571	22	CORP-00115
1648	SUPREMA	MA0109002	CEMENTO DE CONTACTO DE 1/32	Construcción y obra civil	Infraestructura y obra civil	C	14.8304	38	CORP-00273
1649	SUPREMA	RE0308046	RETENEDOR # 12364	Repuestos y componentes mecánicos	Mantenimiento industrial	C	88.1696	23	CORP-01055
1650	SAN JORGE	MA0202032	CICATRIZANTE TOPAZONE SPRAY	Ferretería general	Agrícola (fincas)	C	87.0536	20	CORP-00299
1651	SAN FRANCISCO	MA0202032	CICATRIZANTE TOPAZONE SPRAY	Ferretería general	Agrícola (fincas)	C	87.0536	20	CORP-00299
1652	SUPREMA	RE0317012	AMORTIGUADOR L-150	Repuestos y componentes mecánicos	Mantenimiento industrial	C	87.0536	40	CORP-00072
1653	PALMAS	RE0302050	COJINETE No. 6303 2RS  (17 X 47 X 14 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	34.8214	29	CORP-00404
1654	SUPREMA	RE0316011	LIJA 400 P/METAL	Ferretería general	Mantenimiento industrial	C	2.9018	23	CORP-00883
1655	SAN ANTONIO	MA0202005	LOCION PODAL 960 ML.	Papelería, oficina y cómputo	Administración y oficinas	C	174.1071	45	CORP-00898
1656	SAN FRANCISCO	MA0202005	LOCION PODAL 960 ML.	Papelería, oficina y cómputo	Administración y oficinas	C	174.1071	26	CORP-00898
1657	SAN JORGE	MA0202005	LOCION PODAL 960 ML.	Papelería, oficina y cómputo	Administración y oficinas	C	174.1071	26	CORP-00898
1658	PALMAS	RE0303035	CUÑA CUADRADA 7/8	Ferretería general	Bodega central (stock)	C	3.6086	2	CORP-00457
1659	PALMAS	MA0102089	UNION UNIVERSAL HN 1 (ROSCADA)	Ferretería general	Mantenimiento industrial	C	42.8571	84	CORP-01328
1660	SAN JORGE	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	Fertilizantes y agroquímicos	Agrícola (fincas)	C	53.5156	41	CORP-00726
1661	SUPREMA	MA0108013	TORNILLO 1/4 X 2 INOXIDABLE COMPLETO ROSCA CORRIDA	Ferretería general	Mantenimiento industrial	C	4.8661	24	CORP-01222
1662	SUPREMA	RE0201066	FLIPON SIMPLE DE 15 WATTS	Materiales eléctricos	Mantenimiento industrial	C	42.5	12	CORP-00677
1663	SUPREMA	MA0108020	TORNILLO 3/8 X 1 HEXA COMPLETO	Ferretería general	Mantenimiento industrial	C	1.3321	19	CORP-01226
1664	SUPREMA	RE0103010	TERMINALES PARA BORNE DE BATERIA	Materiales eléctricos	Mantenimiento industrial	C	13.7217	24	CORP-01190
1665	SUPREMA	RE0101004	FILTRO ACEITE FRAM PH 3682	Repuestos y componentes mecánicos	Mantenimiento industrial	C	80.3571	18	CORP-00610
1666	PALMAS	MA0101026	LENTES CLAROS CLIMAX SEGURIDAD INDUS	Ferretería general	Mantenimiento industrial	C	10.2679	16	CORP-00878
1667	SUPREMA	MA0108029	TORNILLO 5/8 X 2 HEXA COMPLETO	Ferretería general	Mantenimiento industrial	C	4.2411	29	CORP-01231
1668	GRS	MA0102024	CODO PVC LISO DE 2 X 90	Construcción y obra civil	Infraestructura y obra civil	C	7.5893	36	CORP-00349
1669	PALMAS	RE0302048	COJINETE No. 6301 2RS  (12 X 37 X 12 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	30.3571	29	CORP-00402
1670	SAN ANTONIO	IN0304001	FUNGICIDA CLOROTAC 72 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	75.3839	26	CORP-00725
1671	SUPREMA	MA0102113	VALVULA INOX 1/2 PASO RAPIDO ROSCABLE	Repuestos y componentes mecánicos	Mantenimiento industrial	C	37.5	23	CORP-01362
1672	GRS	MA0101011	PAR DE BOTAS BLANCAS #41	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	49.1071	27	CORP-00974
1673	GRS	MA0101007	PAR DE BOTAS BLANCAS  # 39	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	49.1071	15	CORP-00972
1674	SUPREMA	RE0307002	ABRAZADERA HANGLER DE 1/2	Ferretería general	Mantenimiento industrial	C	1.4732	18	CORP-00006
1675	SUPREMA	RE0201038	CONECTOR LT 1/2 RECTO	Materiales eléctricos	Mantenimiento industrial	C	5.8125	14	CORP-00429
1676	PALMAS	RE0302047	COJINETE No. 6300 2RS  (10 X 35 X 11 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	28.5714	20	CORP-00401
1677	SUPREMA	RE0307003	ABRAZADERA HANGLER DE 3/4	Ferretería general	Mantenimiento industrial	C	1.5	20	CORP-00007
1678	PALMAS	RE0301008	GAS MAPP (BOTELLA)	Material de empaque	Producción / Planta	C	47.4196	20	CORP-00736
1679	PALMAS	RE0314027	STR0502SG1M90 SUCTION STRAINER//4  (PRENSA CB15T)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	142.137	15	CORP-01146
1680	PALMAS	RE0307015	GRASERAS DE 1/8 RECTA	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5.625	6	CORP-00754
1681	SUPREMA	MA0108003	TORNILLO 1/2 X 1 1/2 HEXA COMPLETOS	Ferretería general	Mantenimiento industrial	C	2.0536	21	CORP-01216
1682	SAN JORGE	MA0108002	TUERCA HEXAG. ABRAZADERA 7/16" N.C.	Ferretería general	Mantenimiento industrial	C	0.6696	16	CORP-01319
1683	PALMAS	RE0201061	RELEVADOR CAMSCO 8 PINES 120V. (ENCAPSULADOS)	Materiales eléctricos	Bodega central (stock)	C	66.9643	10	CORP-01042
1684	PALMAS	MA0108063	CASTIGADOR ALLEN 5/8 X 1 R. ORD.	Repuestos y componentes mecánicos	Bodega central (stock)	C	13.3929	10	CORP-00264
1685	PALMAS	RE0302041	COJINETE No. 6204 2RS  (20 X 47 X 14 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	32.1429	16	CORP-00392
1686	PALMAS	RE0302030	COJINETE No. 6000 2RS  (10 X 26 X 8 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	16.0714	23	CORP-00384
1687	GRS	RE0309091	SIERRA ACERO PLATA	Herramientas	Mantenimiento industrial	C	10.7143	13	CORP-01107
1688	SUPREMA	MA0108012	TORNILLO 1/4 X 2 HEXA COMPLETO ROSCA CORRIDA G8	Ferretería general	Mantenimiento industrial	C	3.8393	23	CORP-01221
1689	PALMAS	RE0306041	FAJAS # B-56	Repuestos y componentes mecánicos	Bodega central (stock)	C	62.8839	8	CORP-00580
1690	SAN FRANCISCO	MA0101006	CASCO CLIMAX SEGURIDAD INDUSTRIAL COLOR AZUL	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	31.25	23	CORP-00258
1691	SAN ANTONIO	MA0101006	CASCO SEGURIDAD INDUSTRIAL CLIMAX COLOR AZUL	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	31.25	22	CORP-00259
1692	SAN JORGE	MA0101006	CASCO CLIMAX SEGURIDAD INDUSTRIAL COLOR AZUL	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	31.25	32	CORP-00258
1693	GRS	IN0403016	VACUNA RAYOVET	Ganadería y alimento animal	Ganadería	C	0.8304	15	CORP-01332
1694	GRS	MA0102012	ADAPTADOR MACHO PVC DE 2	Construcción y obra civil	Flota, maquinaria y combustible	C	6.1607	37	CORP-00052
1695	GRS	RE0309081	LENTES PLÁSTICOS OSCUROS	Ferretería general	Mantenimiento industrial	C	7.1429	17	CORP-00880
1696	PALMAS	RE0303034	CUÑA CUADRADA 5/8	Ferretería general	Bodega central (stock)	C	2.4181	2	CORP-00456
1697	SAN FRANCISCO	MA0102068	MICROTUBO PLASTICO 8MM	Ferretería general	Flota, maquinaria y combustible	C	7.5893	56	CORP-00929
1698	SUPREMA	RE0302026	COJINETE 6205 ZZ / C3	Repuestos y componentes mecánicos	Mantenimiento industrial	C	37.5	17	CORP-00354
1699	ALFA	MA0102067	MANOMETRO CON GLICERINA 0-100 PSI. CARAT. 2.5	Insumos químicos de producción	Producción / Planta	C	111.6071	50	CORP-00917
1700	PALMAS	RE0302100	COJINETE No. 6203 2RS  (17 X 40 X 12 MM.)	Repuestos y componentes mecánicos	Mantenimiento industrial	C	26.7857	16	CORP-00391
1701	SUPREMA	RE0201061	ESPIGA DE HULE 110 V.	Repuestos y componentes mecánicos	Mantenimiento industrial	C	7.1429	19	CORP-00542
1702	GRS	RE0309063	DISCO DE CORTE DE 9	Herramientas	Mantenimiento industrial	C	21.4286	37	CORP-00478
1703	PALMAS	RE0302032	COJINETE No. 6003 2RS  (17 X 35 X 10 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	25	29	CORP-00386
1704	GRS	MA0102036	REDUCIDOR LISO DE 2 A 3/4	Construcción y obra civil	Infraestructura y obra civil	C	4.9107	39	CORP-01032
1705	SUPREMA	RE0309008	BROCA P/METAL 5/16	Herramientas	Mantenimiento industrial	C	8.9286	23	CORP-00162
1706	GRS	MA0101012	PAR DE BOTAS BLANCAS #42	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	49.1071	15	CORP-00975
1707	GRS	MA0108022	TORNILLOS HEX ACERO INOX. NC 3/8 X 1.1/4 COM	Ferretería general	Mantenimiento industrial	C	3.7946	21	CORP-01286
1708	SUPREMA	RE0201111	PLAFONERA	Materiales eléctricos	Mantenimiento industrial	C	6.25	13	CORP-00998
1709	ACACIAS	MA0102068	MICROTUBO PLASTICO 8MM	Ferretería general	Flota, maquinaria y combustible	C	7.5893	51	CORP-00929
1710	SAN FRANCISCO	MA0103005	LAÑA O GRAPA PARA CERCAS	Ferretería general	Agrícola (fincas)	C	8.9286	41	CORP-00847
1711	SAN ANTONIO	MA0103005	LAÑA O GRAPA PARA CERCAS	Papelería, oficina y cómputo	Administración y oficinas	C	8.9286	41	CORP-00847
1712	GRS	RE0309047	CEPILLO DE ALAMBRE CON MANGO DE MADERA	Construcción y obra civil	Infraestructura y obra civil	C	10.7143	35	CORP-00277
1713	PALMAS	MA0102019	CODO HN 1 X 90° (ROSCADO)	Construcción y obra civil	Infraestructura y obra civil	C	14.2857	84	CORP-00340
1714	PALMAS	RE0306014	FAJAS # B-43	Repuestos y componentes mecánicos	Bodega central (stock)	C	42.8214	17	CORP-00573
1715	SAN FRANCISCO	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	Fertilizantes y agroquímicos	Agrícola (fincas)	C	53.5156	41	CORP-00726
1716	SAN ANTONIO	MA0202018	VACUNA RAYOVET 50 ML	Ganadería y alimento animal	Ganadería	C	41.9643	8	CORP-01333
1717	SAN JORGE	MA0202016	DIPIRON 500 FRASCO 100 ML	Papelería, oficina y cómputo	Administración y oficinas	C	82.0714	10	CORP-00470
1718	SAN ANTONIO	MA0202016	DIPIRON 500 FRASCO 100 ML	Papelería, oficina y cómputo	Administración y oficinas	C	81.4286	8	CORP-00470
1719	SAN FRANCISCO	MA0202016	DIPIRON 500 FRASCO 100 ML	Papelería, oficina y cómputo	Administración y oficinas	C	81.4286	10	CORP-00470
1720	PALMAS	RE0103060	HULE MANITA AIRE CABEZAL	Ferretería general	Flota, maquinaria y combustible	C	2.6786	15	CORP-00785
1721	PALMAS	MA0108038	TORNILLO TIPO ESTUFA 1/4 X 1	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	0.4018	28	CORP-01281
1722	PALMAS	RE0302039	COJINETE No. 6200 2RS  (10 X 30 X 9 MM.)	Repuestos y componentes mecánicos	Bodega central (stock)	C	19.6429	15	CORP-00389
1723	SAN FRANCISCO	MA0104002	TUBO PVC 1/2 X 20'	Construcción y obra civil	Flota, maquinaria y combustible	C	15.65	59	CORP-01312
1724	PALMAS	MA0108059	CASTIGADOR ALLEN 1/2 X 1 R. ORD.	Repuestos y componentes mecánicos	Bodega central (stock)	C	3.125	10	CORP-00261
1725	ALFA	MA0102037	CODO PVC 2 X 45°  (LISO)	Construcción y obra civil	Flota, maquinaria y combustible	C	8.4593	74	CORP-00346
1726	QUIRICA	MA0102068	MICROTUBO PLASTICO 8MM	Ferretería general	Flota, maquinaria y combustible	C	7.5893	53	CORP-00929
1727	SUPREMA	RE0201041	CONECTOR LT 3/4 RECTO	Materiales eléctricos	Mantenimiento industrial	C	7.4554	13	CORP-00432
1728	PALMAS	RE0306035	UNION CADENA 60-2	Repuestos y componentes mecánicos	Mantenimiento industrial	C	7.3661	21	CORP-01324
1729	SAN ANTONIO	MA0108006	TORNILLO HEX HN GR8 5/8"X2-1/2" COMPLETO ROSCA ORDINARIA	Ferretería general	Bodega central (stock)	C	4.5982	15	CORP-01249
1730	PALMAS	RE0303030	CUÑA CUADRADA 1/2	Ferretería general	Bodega central (stock)	C	0.9524	41	CORP-00454
1731	PALMAS	RE0306034	UNION CADENA 60-1	Repuestos y componentes mecánicos	Mantenimiento industrial	C	14.2857	16	CORP-01323
1732	SAN FRANCISCO	MA0101024	TAFILETE ATORNILLABLE CASCO SEGURIDAD CLIMAX	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	17.8571	50	CORP-01156
1733	SAN JORGE	MA0101024	TAFILETE ATORNILLABLE CASCO CLIMAX	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	17.8571	52	CORP-01155
1734	SAN ANTONIO	MA0101024	TAFILETE ATORNILLABLE CASCO CLIMAX	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	17.8571	73	CORP-01155
1735	SUPREMA	MA0108045	TORNILLO CASTIGADOR 3/8""X3/8"" NC	Ferretería general	Mantenimiento industrial	C	1.9984	19	CORP-01240
1736	SAN JORGE	IN0304001	FUNGICIDA CLOROTAC 72 SC	Fertilizantes y agroquímicos	Agrícola (fincas)	C	67.3036	41	CORP-00725
1737	PALMAS	MA0108061	CASTIGADOR ALLEN 3/8 X 3/4 R. ORD.	Repuestos y componentes mecánicos	Bodega central (stock)	C	2.6786	10	CORP-00263
1738	SUPREMA	MA0102023	CODO HG 1/2 ROSCADO	Construcción y obra civil	Infraestructura y obra civil	C	6.6964	21	CORP-00339
1739	ACACIAS	MA0108002	TUERCA HEXAG. ABRAZADERA 7/16" N.C.	Ferretería general	Mantenimiento industrial	C	0.6696	16	CORP-01319
1740	SUPREMA	RE0103015	FUSIBLE MINI 10 AMP PARA CAMION	Materiales eléctricos	Flota, maquinaria y combustible	C	3.125	15	CORP-00729
1741	SUPREMA	RE0103016	FUSIBLE MINI 15 AMP PARA CAMION	Materiales eléctricos	Flota, maquinaria y combustible	C	3.125	15	CORP-00730
1742	SUPREMA	RE0103017	FUSIBLE MINI 20 AMP PARA CAMION	Materiales eléctricos	Flota, maquinaria y combustible	C	3.125	15	CORP-00731
1743	GRS	MA0102011	ADAPTADOR MACHO PVC DE 1	Construcción y obra civil	Flota, maquinaria y combustible	C	3.0357	30	CORP-00051
1744	ALFA	MA0202031	JERINGAS DESECHABLE 50 ML.	Limpieza e higiene	Administración y oficinas	C	6.0268	22	CORP-00813
1745	SUPREMA	MA0108021	TORNILLO 3/8 X 2 1/2 HEXA COMPLETO GRADO 5	Ferretería general	Mantenimiento industrial	C	1.6518	34	CORP-01227
1746	PALMAS	RE0311013	RETENEDOR 44 X 65 X 10 MM. (DOBLE LABIO)	Repuestos y componentes mecánicos	Bodega central (stock)	C	29.0536	29	CORP-01063
1747	ALFA	MA0101029	WIPE  (BOLA 1 LIBRA)	Otros materiales	Flota, maquinaria y combustible	C	11.6071	17	CORP-01391
1748	ACACIAS	MA0101029	WIPE  (BOLA 1 LIBRA)	Ferretería general	Flota, maquinaria y combustible	C	11.6071	17	CORP-01391
1749	ACACIAS	MA0101021	OREJERA CASCO SEGURIDAD INDUS. COLOR AMARILLO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	58.0357	18	CORP-00959
1750	SUPREMA	RE0201037	CONECTOR LT 1 RECTO	Materiales eléctricos	Mantenimiento industrial	C	11.4732	14	CORP-00431
1751	GRS	MA0102027	COPLA PVC DE 2	Construcción y obra civil	Infraestructura y obra civil	C	4.7321	22	CORP-00440
1752	PALMAS	MA0108060	CASTIGADOR ALLEN 3/8 X 1/2 R. ORD.	Repuestos y componentes mecánicos	Bodega central (stock)	C	2.2321	10	CORP-00262
1753	GRS	MA0102023	CODO PVC LISO DE 1 X 90	Construcción y obra civil	Infraestructura y obra civil	C	3.5714	30	CORP-00348
1754	SAN ANTONIO	MA0108007	TORNILLO HEX HN GR8 1/2"X7" COMPLETO ROSCA ORDINARIA	Ferretería general	Bodega central (stock)	C	22.8571	21	CORP-01247
1755	SUPREMA	RE0201143	CAJA RECTANGULAR PVC DE 2 x 4	Construcción y obra civil	Infraestructura y obra civil	C	2.8125	14	CORP-00229
1756	PALMAS	MA0108039	TORNILLO TIPO ESTUFA 3/16 X 1	Vehículos, maquinaria y equipo (activo)	Mantenimiento industrial	C	0.2232	28	CORP-01282
1757	SUPREMA	MA0103017	REMACHES DE 1/8 X 1/2	Ferretería general	Mantenimiento industrial	C	0.0893	56	CORP-01043
1758	SAN JORGE	MA0103005	LAÑA O GRAPA PARA CERCAS	Ferretería general	Agrícola (fincas)	C	8.9286	44	CORP-00847
1759	GRS	RE0309062	DISCO DE CORTE DE 4 1/2	Herramientas	Mantenimiento industrial	C	8.8839	37	CORP-00477
1760	SUPREMA	RE0316013	LIJA 600 P/METAL	Ferretería general	Mantenimiento industrial	C	2.4554	21	CORP-00885
1761	PALMAS	MA0108006	TORNILLO ALLEN CAB. AVELLANADA 5/16 X 3/4 NC.	Ferretería general	Bodega central (stock)	C	5.3571	16	CORP-01236
1762	SUPREMA	RE0201039	CONECTOR LT 1/2CURVO	Materiales eléctricos	Mantenimiento industrial	C	7.0089	14	CORP-00430
1763	SAN FRANCISCO	MA0202018	VACUNA RAYOVET 50 ML	Ganadería y alimento animal	Ganadería	C	41.9643	10	CORP-01333
1764	SAN JORGE	MA0202018	VACUNA RAYOVET 50 ML	Ganadería y alimento animal	Ganadería	C	41.9643	10	CORP-01333
1765	ACACIAS	MA0101006	CASCO SEGURIDAD INDUSTRIAL COLOR AMARILLO	Equipo de protección personal (EPP)	Seguridad industrial (EPP)	C	40.1786	18	CORP-00260
1766	GRS	MA0108013	TORNILLOS EXAGONAL ACERO INOX. DE 5/16 X 1 COMPLETOS	Ferretería general	Mantenimiento industrial	C	1.6071	21	CORP-01284
1767	GRS	MA0102013	ADAPTADOR MACHO PVC DE 3/4	Construcción y obra civil	Infraestructura y obra civil	C	1.3425	23	CORP-00053
1768	SUPREMA	MA0108009	TORNILLO 1/4 X 1 HEXA COMPLETOS	Ferretería general	Mantenimiento industrial	C	0.4613	14	CORP-01220
1769	SAN ANTONIO	MA0202031	JERINGA DESECHABLE 50 ML.	Limpieza e higiene	Servicios generales y limpieza	C	6.0268	22	CORP-00812
1770	SUPREMA	RE0201122	TARUGO PLASTICOS 1/4	Ferretería general	Mantenimiento industrial	C	0.1786	20	CORP-01177
1771	PALMAS	MA0108009	TORNILLO BUSCA ROSCA 1/4 X 1	Ferretería general	Mantenimiento industrial	C	0.1786	28	CORP-01237
1772	PALMAS	RE0303033	CUÑA CUADRADA 3/8	Ferretería general	Bodega central (stock)	C	0.6511	2	CORP-00455
1773	GRS	MA0108019	TORNILLOS HEX ACERO INOX. 1/4 X 1 COMPLETOS	Ferretería general	Mantenimiento industrial	C	1.25	21	CORP-01285
1774	ALFA	MA0101028	SIERRA ACERO PLATA 1/2" X 12"	Herramientas	Flota, maquinaria y combustible	C	7.5893	19	CORP-01108
1775	SUPREMA	MA0108023	TORNILLO 5/16 X 1 1/2 HEXA COMPLETO	Ferretería general	Mantenimiento industrial	C	0.6696	12	CORP-01229
1776	GRS	MA0102022	CODO LISO PVC DE 3/4	Construcción y obra civil	Infraestructura y obra civil	C	1.4732	39	CORP-00342
1777	SAN ANTONIO	MA0202029	JERINGA DESECHABLE 20 ML	Limpieza e higiene	Servicios generales y limpieza	C	2.9018	22	CORP-00811
1778	SAN FRANCISCO	MA0202029	JERINGA DESECHABLE 20 ML	Limpieza e higiene	Servicios generales y limpieza	C	2.9018	20	CORP-00811
1779	SAN JORGE	MA0202029	JERINGA DESECHABLE 20 ML	Limpieza e higiene	Servicios generales y limpieza	C	2.9018	20	CORP-00811
1780	GRS	MA0101010	PAR DE LENTES POLICARBONATO CLAROS CLIMAX	Ferretería general	Bodega central (stock)	C	9.375	11	CORP-00976
1781	GRS	MA0102017	CODO CON ROSCA PVC DE 1	Construcción y obra civil	Infraestructura y obra civil	C	5.3571	72	CORP-00338
1782	SAN ANTONIO	MA0102032	CODO PVC 1 X 90°  (LISO)	Construcción y obra civil	Flota, maquinaria y combustible	C	2.6786	74	CORP-00344
1783	PALMAS	MA0108010	TORNILLO BUSCA ROSCA 3/16 X 1	Ferretería general	Mantenimiento industrial	C	0.1339	28	CORP-01238
1784	SAN JORGE	MA0202031	JERINGAS DESECHABLE 50 ML.	Limpieza e higiene	Servicios generales y limpieza	C	6.0268	20	CORP-00813
1785	SAN FRANCISCO	MA0202031	JERINGAS DESECHABLE 50 ML.	Limpieza e higiene	Servicios generales y limpieza	C	6.0268	20	CORP-00813
1786	GRS	MA0102005	ADAPTADOR HEMBRA PVC 3/4	Construcción y obra civil	Flota, maquinaria y combustible	C	1.7411	40	CORP-00046
1787	SUPREMA	MA0108035	TORNILLO CASTIGADOR ALLEN 1/4 X 1/4 NC	Ferretería general	Mantenimiento industrial	C	0.4464	13	CORP-01241
1788	ALFA	MA0102033	CODO PVC 1/2 X 90°  (CON ROSCA)	Construcción y obra civil	Flota, maquinaria y combustible	C	1.6211	43	CORP-00343
1789	ALFA	MA0102006	ADAPTADOR HEMBRA PVC 1	Construcción y obra civil	Flota, maquinaria y combustible	C	2.8058	38	CORP-00045
1790	ALFA	MA0202028	JERINGA DESECHABLE 10 ML	Limpieza e higiene	Administración y oficinas	C	1.1161	15	CORP-00810
1791	GRS	MA0102048	TAPÓN LISO PVC DE  3/4	Material de empaque	Producción / Planta	C	1.0268	23	CORP-01173
1792	SUPREMA	MA0102018	CINCHOS PLASTICOS 6	Ferretería general	Mantenimiento industrial	C	0.0893	17	CORP-00308
1793	SUPREMA	RE0303018	CUÑA 3/16" PARA ACOPLAMIENTO	Repuestos y componentes mecánicos	Mantenimiento industrial	C	5.3571	20	CORP-00453
\.


--
-- Data for Name: bitacora; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bitacora (id, solicitud_id, ts, user_name, accion, detalle) FROM stdin;
1	SC-2026-0001	2026-11-10 02:15:12.248122+00	Sistema	Validación presupuesto	Dentro de presupuesto
2	SC-2026-0001	2026-11-10 02:15:12.248122+00	Sistema	Aprobación automática	Dentro de presupuesto: pasa directo a Bodega
3	SC-2026-0001	2026-11-10 02:15:12.254839+00	Ana Morales	Creó solicitud	1 línea(s) · R1
4	SC-2026-0002	2026-11-10 02:15:22.643587+00	Sistema	Validación presupuesto	Fuera de presupuesto · R3
5	SC-2026-0002	2026-11-10 02:15:22.643587+00	Sistema	Pendiente N1	Enviada al gerente de la empresa
6	SC-2026-0002	2026-11-10 02:15:22.647493+00	Ana Morales	Creó solicitud	1 línea(s) · R3
7	SC-2026-0002	2026-11-10 02:15:22.708595+00	Jorge Castillo	Aprobó N1	ok n1
8	SC-2026-0002	2026-11-10 02:15:22.712304+00	Sistema	Escalamiento a N2	Total requiere Dirección de Operaciones
9	SC-2026-0002	2026-11-10 02:15:22.753302+00	Roberto Aldana	Aprobó N2	ok n2
10	SC-2026-0002	2026-11-10 02:15:22.877374+00	Marta Solís	Enviada a SAP	SC-2026-0001
11	SC-2026-0001	2026-11-10 02:15:22.884516+00	Marta Solís	Enviada a SAP	SC-2026-0001
12	SC-2026-0003	2026-11-10 02:25:37.573291+00	Sistema	Validación presupuesto	Dentro de presupuesto
13	SC-2026-0003	2026-11-10 02:25:37.573291+00	Sistema	Aprobación automática	Dentro de presupuesto: pasa directo a Bodega
14	SC-2026-0003	2026-11-10 02:25:37.579849+00	Ana Morales	Creó solicitud	1 línea(s) · R1
15	SC-2026-0004	2026-11-10 13:55:57.197143+00	Sistema	Validación presupuesto	Dentro de presupuesto
16	SC-2026-0004	2026-11-10 13:55:57.197143+00	Sistema	Aprobación automática	Dentro de presupuesto: pasa directo a Bodega
17	SC-2026-0004	2026-11-10 13:55:57.201226+00	Admin Pide Justo	Creó solicitud	1 línea(s) · R1 · SC PALMAS-SC-00001 · bodega 01
18	SC-2026-0005	2026-11-10 14:25:35.456967+00	Sistema	Validación presupuesto	Dentro de presupuesto
19	SC-2026-0005	2026-11-10 14:25:35.456967+00	Sistema	Pendiente N1	Primera autorización. Solo ve solicitudes de su empresa.
20	SC-2026-0005	2026-11-10 14:25:35.461354+00	Admin Pide Justo	Creó solicitud	1 línea(s) · R1 · SC PALMAS-SC-00002 · bodega 01
21	SC-2026-0005	2026-11-10 14:26:41.166154+00	Sofía Herrera	Aprobó N1	
22	SC-2026-0005	2026-11-10 14:26:41.173275+00	Sistema	Escalamiento a N2	Pasa a Aprobador de operaciones
23	SC-2026-0005	2026-11-10 14:27:40.660702+00	Roberto Aldana	Aprobó N2	
24	SC-2026-0005	2026-11-10 14:27:40.665504+00	Sistema	Escalamiento a N3	Pasa a Dirección
25	SC-2026-0005	2026-11-10 14:28:31.291006+00	Dirección de Operaciones	Aprobó N3	
26	SC-2026-0006	2026-11-10 14:42:05.624313+00	Sistema	Validación presupuesto	Dentro de presupuesto
27	SC-2026-0006	2026-11-10 14:42:05.624313+00	Sistema	Aprobación automática	Dentro de presupuesto: pasa directo a Bodega
28	SC-2026-0006	2026-11-10 14:42:05.628072+00	Ana Morales	Creó solicitud	1 línea(s) · R1 · SC SUPREMA-SC-00001 · bodega 01
29	SC-2026-0006	2026-11-10 14:45:48.165139+00	Admin Pide Justo	Enviada a SAP	SC · SUPREMA-SC-00001 · bodega 01 · CompanyDB SBO_SUPREMA
30	SC-2026-0007	2026-11-10 14:50:22.275813+00	Sistema	Validación presupuesto	Dentro de presupuesto
31	SC-2026-0007	2026-11-10 14:50:22.275813+00	Sistema	Aprobación automática	Dentro de presupuesto: pasa directo a Bodega
32	SC-2026-0007	2026-11-10 14:50:22.280684+00	Ronald	Creó solicitud	1 línea(s) · R1 · SC SUPREMA-SC-00002 · bodega 01
33	SC-2026-0007	2026-11-10 16:18:57.541324+00	Admin Pide Justo	Enviada a SAP	SC · SUPREMA-SC-00002 · bodega 01 · CompanyDB SBO_SUPREMA
\.


--
-- Data for Name: bodegas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bodegas (id, empresa, codigo, nombre, warehouse_code, activo) FROM stdin;
1	SUPREMA	01	Bodega principal	01	t
2	PALMAS	01	Bodega principal	01	t
3	ACACIAS	01	Bodega principal	01	t
4	ALFA	01	Bodega principal	01	t
5	QUIRICA	01	Bodega principal	01	t
6	SAN ANTONIO	01	Bodega principal	01	t
7	SAN FRANCISCO	01	Bodega principal	01	t
8	SAN JORGE	01	Bodega principal	01	t
9	TASINSA	01	Bodega principal	01	t
10	METALMECANICA	01	Bodega principal	01	t
11	GRS	01	Bodega principal	01	t
12	GABIOSA	01	Bodega principal	01	t
\.


--
-- Data for Name: categoria_cuenta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categoria_cuenta (categoria, cuenta6, cuenta7, requiere_placa, requiere_obra, nota) FROM stdin;
Combustibles y lubricantes	61302301	71302301	f	f	Combustibles y lubricantes
Construcción y obra civil	61300101	71304001	f	f	Si la obra se capitaliza usar 12100901 (exige Nº obra en proceso y Nº obra específica; la matriz del Anexo 2 no trae prefijo 1)
Equipo de protección personal (EPP)	61301701	71301701	f	f	Implementos y equipo de trabajo
Ferretería general	61300101	71304001	f	f	Materiales e insumos / insumos
Fertilizantes y agroquímicos	61300101	71304001	f	f	Materiales e insumos / insumos
Herramientas	61303908	71303908	f	f	Herramientas y cristalería
Insumos químicos de producción	61300101	71304001	f	f	Materiales e insumos / insumos
Materiales eléctricos	61300101	71304001	f	f	Materiales e insumos / insumos
Papelería, oficina y cómputo	61302401	71302401	f	f	Papelería y útiles
Repuestos y componentes mecánicos	61302804	71302804	f	f	Rep. y mant. maquinaria y equipo; si es para vehículo usar 61302807/71302807 (exige placa)
Vehículos, maquinaria y equipo (activo)	61303904	71303907	t	f	Si se capitaliza, registrar además en la hoja ACTIVOS FIJOS del Anexo 1 (código de activo fijo)
Limpieza e higiene	61300101	71304001	f	f	Materiales e insumos / insumos
Otros materiales	61300101	71304001	f	f	Materiales e insumos / insumos
Ganadería y alimento animal	61300101	71304001	f	f	Materiales e insumos / insumos
Materia prima	61300101	\N	f	f	Siempre costo
Material de empaque	61300101	\N	f	f	Siempre costo
\.


--
-- Data for Name: consumo_trimestral; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.consumo_trimestral (id, empresa, item_code, t0, t1, t2, t3) FROM stdin;
1	PALMAS	MP0201005	30036000	58282150	43629040	44535000
2	SUPREMA	MP0201002	2000000	2800000	6000000	5400000
3	TASINSA	PT49400000501	1805000	2005000	2005000	1205000
4	PALMAS	MA0105017	104000	160000	144000	80000
5	SUPREMA	IN0103005	1440	1680	2400	1680
6	SUPREMA	IN0103018	480	480	600	300
7	SUPREMA	IN0103008	960	600	1200	1080
8	SUPREMA	IN0103032	720	480	1182.394	480
9	PALMAS	MP0201009	300000	200000	450000	200000
10	SUPREMA	MA0105010	27000	31000	27000	31000
11	SUPREMA	IN0102035	135	170	100	130
12	SUPREMA	IN0106012	2496	2760	4900	3460
13	SUPREMA	IN0102076	110	180	160	110
14	SUPREMA	IN0103019	15000	15000	45000	32000
15	PALMAS	IN0102020	150	135	195	88
16	SUPREMA	IN0102078	65	50	75	30
17	PALMAS	IN0202043	2861	2000	3200	1600
18	PALMAS	IN0202004	12000	12000	12000	9000
19	PALMAS	IN0202072	4500	2000	3200	2600
20	SUPREMA	IN0106010	480	505	710	360
21	SUPREMA	IN0201036	19800	39600	19800	59400
22	SUPREMA	IN0101003	150	210	240	120
23	GRS	IN0101009	2400000	1200000	2430000	3620000
24	SUPREMA	IN0106023	900	840	1998.394	1544
25	SUPREMA	IN0102069	55	35	50	40
26	SUPREMA	IN0105006	5000	4000	5100	5000
27	SUPREMA	IN0102075	26	35	50	35
28	SUPREMA	IN0102074	20	40	40	45
29	SUPREMA	IN0102026	20	15	10	18
30	SUPREMA	IN0102034	10	30	30	25
31	PALMAS	MA0105007	460	2145	550	550
32	SUPREMA	IN0106002	15000	30000	110300	83824
33	SUPREMA	MA0105019	3137	3207	3000	3000
34	PALMAS	IN0102021	30	45	15	37
35	PALMAS	MA0105018	2000	2000	3000	2000
36	SUPREMA	IN0102060	41	20	0	20
37	SUPREMA	IN0101004	30	40	50	30
38	SUPREMA	IN0201037	3966.28	3797.37	3539.4	4423.5
39	SUPREMA	IN0102070	0	6	20	15
40	GRS	IN0101010	101000	50300	98300	143400
41	GRS	IN0502001	1320	660	1320	1485
42	SUPREMA	IN0105002	300	350	600	300
43	PALMAS	IN0102003	9	9	21	28
44	SUPREMA	IN0102068	5	9	9	7
45	PALMAS	MA0104077	11	38	42	21
46	PALMAS	IN0202001	1140	2200	3136	1068
47	PALMAS	MA0105019	710	1975	840	1485
48	SUPREMA	IN0102066	5	8	7	8
49	PALMAS	MA0107016	847	1500	1000	2940
50	PALMAS	IN0202020	400	1200	700	400
51	PALMAS	MA0107011	16962	2650	7000	7440
52	PALMAS	MA0107017	1886	500	2500	4370
53	PALMAS	MA0107005	9218	1650	4000	6900
54	PALMAS	MA0107019	42	65	37	46
55	PALMAS	IN0105002	2500	3220	2880	1080
56	PALMAS	IN0105004	800	500	100	200
57	PALMAS	MA0101022	153	200	100	200
58	PALMAS	RE0304036	106	202	144	275
59	PALMAS	MA0107020	7	23	7	20
60	PALMAS	RE0316007	28	59	50	200
61	PALMAS	MA0107015	208	125	300	200
62	PALMAS	RE0201020	42	110	70	60
63	PALMAS	IN0104001	24000	24000	12000	12000
64	PALMAS	MA0108011	400	400	200	1000
65	SUPREMA	RE0302028	15	19	10	6
66	TASINSA	PT49400000502	2000476	2002198	2000079	3995838
67	SUPREMA	PT09251005108	600000	0	1000000	200000
68	SUPREMA	IN0103006	0	480	1200	600
69	SUPREMA	IN0103003	60000	60000	133000	162462
70	SUPREMA	IN0103027	360	360	250	360
71	SUPREMA	IN0103037	0	15000	40000	25000
72	SUPREMA	IN0201016	72000	72000	0	72000
73	SUPREMA	IN0103034	180	360	360	460
74	SAN ANTONIO	IN0305005	1931	984	3331	0
75	SAN ANTONIO	IN0305009	1557	2725	641	0
76	SUPREMA	IN0103033	0	0	360	520
77	PALMAS	IN0202056	4000	1600	2000	0
78	SUPREMA	IN0103038	0	15000	15000	15000
79	PALMAS	IN0202019	6000	9000	6000	3000
80	SAN ANTONIO	IN0305007	1074	1420	641	0
81	PALMAS	IN0202085	800	1200	0	1000
82	SUPREMA	IN0103004	0	25	110	60
83	SUPREMA	IN0103047	0	0	14300	18000
84	SUPREMA	IN0102077	500	385	650	500
85	SUPREMA	IN0201026	1225	0	750	0
86	PALMAS	IN0202081	2800	1000	0	1200
87	SAN ANTONIO	IN0305006	989	716	354	0
88	SUPREMA	IN0201003	1800	0	1200	2400
89	PALMAS	IN0202086	2500	0	1000	0
90	SUPREMA	IN0201014	880	0	500	0
91	SUPREMA	IN0201001	10000	15000	0	10000
92	SUPREMA	IN0103040	96	0	100	100
93	SUPREMA	IN0103043	0	0	11000	8836
94	SUPREMA	IN0103042	0	0	11000	8824
95	PALMAS	IN0202083	4800	4800	6000	0
96	SUPREMA	IN0104019	100	50	150	350
97	PALMAS	IN0202069	500	300	300	600
98	PALMAS	IN0202048	12600	12000	18844.5	12000
99	SUPREMA	IN0102036	20	0	15	0
100	SUPREMA	IN0106019	360	360	250	360
101	SUPREMA	MA0106038	42	36	0	42
102	PALMAS	RE0302019	8	4	0	8
103	PALMAS	IN0202068	300	300	300	0
104	SUPREMA	IN0102079	0	6	10	10
105	PALMAS	IN0202009	180	360	270	120
106	PALMAS	IN0105006	0	40000	10000	0
107	SUPREMA	IN0104020	100	0	150	120
108	SUPREMA	IN0102085	15	0	0	3
109	SUPREMA	IN0201012	260	0	140	0
110	SUPREMA	IN0106003	30000	30000	110000	65900
111	PALMAS	RE0302016	4	4	0	8
112	PALMAS	IN0202033	2800	1000	1000	1000
113	PALMAS	IN0202007	6000	6000	3000	6000
114	SUPREMA	MA0110008	750	3800	0	2850
115	PALMAS	RE0302018	4	4	0	6
116	SUPREMA	RE0317097	30	72	0	78
117	PALMAS	RE0101087	3	20	88	45
118	SUPREMA	IN0106024	0	15000	27430	23836
119	SUPREMA	IN0102080	2	7	14	0
120	PALMAS	RE0101084	2	3	24	18
121	SUPREMA	IN0102082	3	10	0	2
122	SUPREMA	RE0317094	1025	0	525	525
123	PALMAS	IN0202010	0	240	210	60
124	PALMAS	RE0302015	2	4	4	4
125	PALMAS	RE0302013	8	6	0	8
126	SUPREMA	RE0304150	43	0	75	150
127	SUPREMA	IN0201018	120	0	100	0
128	PALMAS	RE0101086	3	20	44	45
129	PALMAS	MA0105009	190	0	330	0
130	PALMAS	MA0110007	4	0	2	18
131	PALMAS	MA0104028	0	2	5	12
132	PALMAS	IN0202011	0	25	25	50
133	SUPREMA	IN0106011	30000	0	30000	71400
134	PALMAS	MA0110008	10	0	10	95
135	PALMAS	MA0105027	55	110	55	25
136	PALMAS	IN0202070	27216	13608	0	0
137	PALMAS	IN0102001	3	9	0	6
138	PALMAS	RE0101088	4	20	88	45
139	PALMAS	RE0302014	2	4	0	4
140	PALMAS	RE0101079	7	20	61	30
141	SUPREMA	RE0317095	0	60	0	45
142	PALMAS	MA0104025	2	6	0	12
143	PALMAS	IN0202050	850	850	0	850
144	PALMAS	MA0105011	0	15	220	110
145	SUPREMA	MA0105008	110	55	220	0
146	PALMAS	RE0101078	6	0	32	10
147	SUPREMA	IN0102064	0	5	0	4
148	SUPREMA	RE0301029	6	0	7	6
149	PALMAS	MA0105013	45	110	110	55
150	PALMAS	RE0302096	0	4	4	4
151	PALMAS	MA0105016	31	74	0	40
152	PALMAS	MA0104027	1	6	5	6
153	SUPREMA	MA0110014	18	96	72	0
154	PALMAS	RE0306006	125	150	300	0
155	PALMAS	RE0101081	20	105	60	75
156	PALMAS	RE0306013	100	200	200	200
157	PALMAS	RE0201035	7	15	25	0
158	PALMAS	RE0101080	7	20	61	30
159	PALMAS	RE0101085	2	3	12	18
160	SUPREMA	IN0102072	5	0	0	1
161	PALMAS	RE0103025	0	10	24	0
162	SUPREMA	IN0102065	5	0	0	4
163	SUPREMA	IN0102084	0	0	2	5
164	PALMAS	RE0103078	6	10	8	0
165	SUPREMA	RE0102014	4	0	8	4
166	PALMAS	RE0201019	22	30	50	40
167	SUPREMA	RE0317143	0	29	0	20
168	SUPREMA	IN0102006	2	0	2	2
169	PALMAS	MA0105020	52.5	44.092	35	35
170	PALMAS	MA0104018	2	4	0	12
171	PALMAS	RE0101077	6	0	32	10
172	PALMAS	RE0103068	80	50	55	110
173	PALMAS	MA0104066	4	4	0	8
174	PALMAS	RE0304017	33	75	150	0
175	PALMAS	RE0103079	1	8	10	0
176	PALMAS	MA0108015	45	80	0	200
177	PALMAS	MA0105023	12	59	30	0
178	PALMAS	RE0304043	21	50	200	0
179	PALMAS	MA0105003	45	0	55	55
180	PALMAS	RE0306039	20	20	40	0
181	PALMAS	RE0304042	11	98	200	0
182	SUPREMA	MA0102082	0	5	3	3
183	PALMAS	MA0104078	3	6	0	12
184	SUPREMA	RE0102015	2	0	4	2
185	PALMAS	MA0105012	115	15	0	0
186	SUPREMA	IN0201005	5	0	8	0
187	PALMAS	MA0104015	4	4	12	12
188	SUPREMA	MA0105022	0	10	20	20
189	SUPREMA	MA0105021	25	20	40	0
190	PALMAS	RE0304059	7	0	20	0
191	PALMAS	MA0105006	15	25	0	55
192	PALMAS	RE0309015	0	200	200	250
193	SUPREMA	MA0110007	3	3	8	0
194	SUPREMA	RE0302047	8	13	0	8
195	SUPREMA	RE0302007	2	8	0	3
196	PALMAS	RE0201002	20	10	30	0
197	PALMAS	RE0316001	29	0	48	0
198	SUPREMA	IN0105001	0	0	1300	450
199	PALMAS	RE0316006	18	100	100	0
200	PALMAS	RE0308049	4	4	8	1
201	SUPREMA	MA0105006	0	30	30	0
202	PALMAS	MA0105022	11	17	0	15
203	PALMAS	RE0309013	0	2	4	4
204	SUPREMA	IN0201022	125	0	100	0
205	PALMAS	MA0108055	0	50	0	100
206	PALMAS	RE0304019	0	50	150	0
207	SUPREMA	RE0101025	0	10	2	5
208	SAN JORGE	IN0302004	0	10	10	32
209	SUPREMA	MA0107046	6	9	0	6
210	SUPREMA	IN0201006	0	7	10	5
211	PALMAS	RE0304018	50	50	150	0
212	PALMAS	MA0110004	550	1100	3300	0
213	SUPREMA	MA0105005	12	12	18	0
214	SUPREMA	RE0316007	150	100	0	70
215	SAN ANTONIO	IN0302004	0	20	12	12
216	PALMAS	RE0306053	4	12	15	0
217	SAN JORGE	IN0302006	7	0	10	32
218	PALMAS	RE0302084	7	6	5	6
219	SUPREMA	RE0310010	0	80	50	50
220	PALMAS	IN0105003	100	0	100	100
221	SUPREMA	RE0302046	0	15	2	7
222	SUPREMA	IN0201004	125	0	125	0
223	SUPREMA	MA0105011	0	2	3	0
224	SAN FRANCISCO	IN0301020	250	0	200	0
225	PALMAS	MA0108048	29	50	0	100
226	SUPREMA	RE0101024	0	10	2	5
227	PALMAS	RE0308008	12	0	10	0
228	SAN FRANCISCO	IN0302004	0	15	10	5
229	PALMAS	MA0108021	0	50	0	100
230	PALMAS	RE0201117	13	0	40	0
231	PALMAS	MA0108047	0	50	0	100
232	SAN ANTONIO	IN0301017	10	0	12	12
233	PALMAS	MA0108012	150	200	0	100
234	PALMAS	MA0108026	60	6	0	500
235	PALMAS	MA0107008	15	25	40	0
236	PALMAS	RE0304045	10	0	0	25
237	PALMAS	RE0103059	2	5	35	0
238	SUPREMA	RE0308014	12	6	6	0
239	SUPREMA	RE0201023	100	0	50	100
240	SAN FRANCISCO	IN0302005	14	0	10	5
241	PALMAS	RE0102010	9	20	0	0
242	PALMAS	RE0306050	2	4	14	0
243	PALMAS	RE0102012	7	20	0	8
244	SUPREMA	RE0101054	2	6	0	4
245	SUPREMA	RE0201125	20	0	20	25
246	SUPREMA	MA0102105	4	10	4	2
247	PALMAS	RE0310014	15	30	40	0
248	PALMAS	RE0306020	9	4	10	0
249	SUPREMA	RE0309002	20	20	20	40
250	PALMAS	MA0108017	49	100	0	0
251	SUPREMA	RE0304151	1	0	2	4
252	SUPREMA	RE0304003	40	0	0	10
253	PALMAS	RE0304053	6	10	10	0
254	PALMAS	RE0314019	8	0	10	0
255	SUPREMA	MA0109003	2	0	2	4
256	SUPREMA	MA0102102	0	4	3	3
257	SUPREMA	RE0309001	20	0	18	37
258	PALMAS	MA0108023	14	300	0	0
259	PALMAS	RE0306042	2	10	15	0
260	PALMAS	MA0109001	5	6	10	15
261	PALMAS	MA0109002	7	25	0	20
262	PALMAS	MA0108052	61	150	0	300
263	PALMAS	RE0306024	2	1	10	0
264	SUPREMA	RE0304131	32	0	0	20
265	PALMAS	RE0306017	10	0	8	0
266	PALMAS	RE0306048	8	0	8	0
267	SUPREMA	MA0108005	50	0	70	40
268	PALMAS	RE0316009	35	80	0	50
269	PALMAS	RE0306059	4	10	0	0
270	SUPREMA	RE0309003	12	20	0	35
271	PALMAS	MA0108022	238	60	0	0
272	SUPREMA	RE0316002	14	20	0	14
273	PALMAS	RE0103030	4	5	10	0
274	SUPREMA	MA0108042	0	15	30	12
275	SUPREMA	RE0316018	10	0	15	16
276	SUPREMA	RE0201067	6	6	0	2
277	PALMAS	RE0302042	6	6	0	0
278	PALMAS	RE0201041	3	10	0	20
279	PALMAS	MA0108016	46	300	0	0
280	PALMAS	RE0306016	4	10	0	0
281	SUPREMA	RE0201068	3	3	0	6
282	PALMAS	RE0102014	5	20	0	0
283	SUPREMA	MA0102017	600	0	400	500
284	SUPREMA	MA0110001	10	0	10	15
285	PALMAS	MA0102111	0	0	5	3
286	PALMAS	MA0108030	64	0	0	200
287	PALMAS	RE0302085	6	6	0	0
288	PALMAS	MA0108024	14	200	0	0
289	SUPREMA	MA0108019	50	0	100	37
290	PALMAS	RE0304008	24	50	0	50
291	SUPREMA	MA0108041	35	15	0	50
292	PALMAS	RE0201129	1213	990	0	0
293	PALMAS	RE0306036	8	5	10	0
294	SUPREMA	MA0108039	30	30	0	30
295	SUPREMA	MA0102019	300	0	200	100
296	SUPREMA	MA0108040	0	35	35	34
297	SUPREMA	MA0108015	100	100	175	0
298	PALMAS	PT09211001101	0	0	2000000	0
299	ACACIAS	IN0305008	0	2361	2766	0
300	QUIRICA	IN0305006	0	4194	0	0
301	QUIRICA	IN0305008	0	1274	2610	0
302	SAN ANTONIO	IN0305017	0	0	0	3671
303	ACACIAS	IN0305007	1694	0	1636	0
304	ACACIAS	IN0305021	0	0	0	3049
305	SAN JORGE	IN0305005	0	1513	1999	0
306	QUIRICA	IN0305020	0	0	0	2877
307	QUIRICA	IN0305005	2795	0	0	0
308	ALFA	IN0305006	0	2553	0	0
309	PALMAS	04-0743-01	0	0	0	1
310	ACACIAS	IN0305006	0	2393	0	0
311	SAN JORGE	IN0305006	2168	0	326	0
312	SAN ANTONIO	07-0010-05	0	2	0	0
313	ALFA	IN0305005	1921	0	295	0
314	QUIRICA	IN0305007	861	0	1330	0
315	SUPREMA	IN0103041	60	0	36	0
316	SAN JORGE	IN0305017	0	0	0	1906
317	ALFA	IN0305022	0	0	0	1892
318	ACACIAS	IN0305020	0	0	0	1803
319	ALFA	IN0305008	0	915	825	0
320	ACACIAS	IN0305005	1638	0	0	0
321	ALFA	IN0305009	0	0	1716	0
322	PALMAS	07-0139-01	0	0	0	1
323	QUIRICA	IN0305019	0	0	0	1466
324	GRS	MA0109002	71	0	0	81
325	QUIRICA	IN0305021	0	0	0	1403
326	PALMAS	07-0131-01	1	0	0	0
327	QUIRICA	IN0305009	0	0	1273	0
328	SUPREMA	07-0092-02	1	0	0	0
329	PALMAS	RE0317020	8	20	0	0
330	SUPREMA	IN0103049	0	0	0	180
331	SAN ANTONIO	IN0305021	0	0	0	942
332	PALMAS	RE0314044	4	0	0	0
333	SAN FRANCISCO	IN0305009	0	0	864	0
334	SAN JORGE	IN0305014	510	510	0	0
335	ALFA	IN0305021	0	0	0	908
336	PALMAS	IN0202082	2200	0	0	0
337	SAN JORGE	IN0305008	873	0	0	0
338	SUPREMA	07-0093-02	0	1	0	0
339	SAN ANTONIO	IN0305008	0	13	855	0
340	SAN FRANCISCO	IN0305005	476	0	415	0
341	SAN ANTONIO	IN0305016	0	0	0	771
342	SUPREMA	IN0103025	36	0	0	36
343	SUPREMA	IN0103024	36	0	0	36
344	SUPREMA	IN0103050	0	0	0	34018
345	QUIRICA	IN0305016	0	0	0	716
346	SAN ANTONIO	IN0305018	0	0	0	706
347	SAN ANTONIO	IN0305020	0	0	0	706
348	PALMAS	IN0202024	15000	0	0	0
349	ALFA	IN0305007	412	0	295	0
350	SAN FRANCISCO	IN0305004	382	382	0	0
351	SAN JORGE	IN0305007	0	604	0	0
352	ALFA	IN0305016	0	0	0	625
353	ALFA	IN0305014	372	0	292	0
354	SAN FRANCISCO	IN0305006	0	559	0	0
355	PALMAS	RE0311014	1	0	0	0
356	SAN JORGE	IN0305021	0	0	0	566
357	SAN JORGE	IN0305009	0	0	599	0
358	SAN ANTONIO	IN0305004	0	0	700	0
359	PALMAS	RE0317024	17	20	0	0
360	QUIRICA	IN0305004	0	0	649	0
361	SAN FRANCISCO	IN0305008	0	0	508	0
362	PALMAS	RE0317022	0	20	0	0
363	SUPREMA	IN0103045	0	0	96	48
364	SAN FRANCISCO	IN0305017	0	0	0	458
365	ALFA	IN0305003	0	0	567	0
366	PALMAS	IN0101053	180	140	0	0
367	PALMAS	RE0317021	6	10	0	0
368	PALMAS	RE0302106	0	4	0	2
369	SAN FRANCISCO	IN0305013	0	0	470	0
370	SUPREMA	RE0301015	0	0	0	440
371	PALMAS	IN0101046	140	150	0	0
372	PALMAS	IN0101043	0	280	0	0
373	PALMAS	IN0101044	0	280	0	0
374	SAN ANTONIO	IN0305019	0	0	0	391
375	PALMAS	IN0101047	0	260	0	0
376	SAN FRANCISCO	IN0305003	182	242	0	0
377	GRS	RE0109001	0	0	0	1155
378	SUPREMA	04-0415-02	0	0	0	1
379	SUPREMA	04-0410-02	0	0	1	0
380	ALFA	IN0305020	0	0	0	325
381	ALFA	IN0305018	0	0	0	326
382	PALMAS	04-0749-01	0	0	0	1
383	PALMAS	RE0314042	2	0	0	0
384	SUPREMA	MA0106039	0	36	0	0
385	ALFA	IN0305023	0	0	0	322
386	SAN JORGE	IN0305018	0	0	0	308
387	SUPREMA	IN0103051	0	0	0	36
388	ACACIAS	IN0201001	0	0	6695	0
389	ACACIAS	IN0305022	0	0	0	285
390	PALMAS	07-0137-01	0	0	1	0
391	SUPREMA	RE0102005	6	0	30	0
392	PALMAS	RE0314028	8	0	0	0
393	PALMAS	RE0314008	6	0	0	0
394	SAN JORGE	IN0305023	0	0	0	172
395	ACACIAS	IN0305009	0	0	258	0
396	PALMAS	RE0317092	3	0	4	0
397	SUPREMA	RE0317099	0	72	84	0
398	PALMAS	04-0687-01	1	0	0	0
399	SAN ANTONIO	IN0305022	0	0	0	237
400	SUPREMA	IN0103046	0	0	0	36
401	PALMAS	RE0311018	4	0	0	0
402	PALMAS	RE0303008	0	0	850	0
403	PALMAS	RE0317100	0	0	0	2
404	PALMAS	RE0314014	3	0	0	0
405	QUIRICA	IN0305022	0	0	0	209
406	PALMAS	IN0202023	2000	2000	0	0
407	SUPREMA	RE0201216	1	0	0	0
408	PALMAS	IN0202089	450	0	0	0
409	PALMAS	RE0302004	0	4	0	6
410	PALMAS	04-0750-01	0	0	0	1
411	SAN JORGE	IN0303008	0	0	0	100
412	PALMAS	IN0101045	140	0	0	0
413	SUPREMA	RE0302095	1	0	0	0
414	SAN ANTONIO	IN0305013	0	0	214	0
415	GRS	07-0001-10	0	0	1	0
416	PALMAS	RE0314010	4	0	0	0
417	SAN FRANCISCO	IN0305021	0	0	0	185
418	ACACIAS	IN0305023	0	0	0	188
419	PALMAS	04-0751-01	0	0	0	1
420	PALMAS	RE0311026	2	0	0	0
421	QUIRICA	IN0303008	0	0	0	90
422	SUPREMA	RE0302096	1	0	0	0
423	ACACIAS	IN0303010	0	0	0	90
424	SAN JORGE	IN0303010	0	0	0	90
425	QUIRICA	IN0305013	0	0	190	0
426	SUPREMA	IN0102086	12	0	0	0
427	SUPREMA	IN0105008	400	0	400	0
428	PALMAS	RE0314018	8	0	0	0
429	PALMAS	MA0105014	0	0	220	0
430	SUPREMA	04-0417-02	0	0	0	1
431	SUPREMA	RE0304095	0	0	76	90
432	PALMAS	RE0201001	0	0	5	0
433	SUPREMA	RE0317244	1	0	0	0
434	ACACIAS	IN0305014	0	0	170	0
435	SUPREMA	RE0317239	1	0	0	0
436	PALMAS	RE0314007	6	0	0	0
437	SAN JORGE	MA0101026	60	0	100	0
438	PALMAS	RE0317102	0	0	0	2
439	PALMAS	RE0317101	0	0	0	6
440	PALMAS	RE0314053	3	0	0	0
441	SUPREMA	RE0304058	0	10	10	0
442	PALMAS	RE0317025	6	10	0	0
443	PALMAS	RE0314025	1	0	0	0
444	PALMAS	RE0317099	0	0	0	3
445	PALMAS	IN0202022	3000	0	0	0
446	PALMAS	IN0101048	0	150	0	0
447	PALMAS	IN0101039	0	0	0	130
448	SUPREMA	MA0106019	0	100	0	100
449	PALMAS	RE0313072	7	0	0	0
450	SUPREMA	IN0106001	60	0	36	0
451	PALMAS	RE0302095	0	0	0	6
452	PALMAS	IN0101051	0	140	0	0
453	SUPREMA	MA0110015	0	72	0	88
454	SUPREMA	RE0317242	1	0	0	0
455	SUPREMA	RE0201197	4	0	4	0
456	PALMAS	RE0312028	4	0	0	0
457	SUPREMA	IN0103044	0	0	1430	0
458	SUPREMA	IN0201028	0	0	60	0
459	SUPREMA	MA0106043	0	2400	0	0
460	PALMAS	RE0314033	2	0	0	0
461	PALMAS	IN0101049	130	0	0	0
462	PALMAS	IN0101052	130	0	0	0
463	SUPREMA	RE0317037	0	5	0	0
464	SUPREMA	MA0106027	2000	0	0	0
465	SUPREMA	RE0304089	3	0	0	0
466	SAN ANTONIO	MA0101026	60	0	61	0
467	PALMAS	RE0302006	0	4	0	4
468	QUIRICA	MA0101026	60	0	60	0
469	SAN FRANCISCO	MA0101026	60	0	60	0
470	SUPREMA	RE0304152	0	0	70	0
471	SUPREMA	RE0317087	8	0	0	0
472	SUPREMA	RE0306010	0	0	8	0
473	SAN JORGE	03-0016-04	0	0	0	1
474	PALMAS	RE0314009	4	0	0	0
475	SAN ANTONIO	IN0301005	400	0	400	0
476	SUPREMA	RE0304046	120	840	0	0
477	PALMAS	06-0444-01	0	1	0	0
478	METALMECANICA	AV10110010114	0	0	0	1
479	SUPREMA	IN0106005	36	0	0	36
480	SUPREMA	IN0106013	36	0	0	36
481	PALMAS	RE0302108	2	2	0	0
482	PALMAS	IN0202016	0	60	60	0
483	PALMAS	RE0302109	2	2	0	0
484	SUPREMA	IN0106030	0	0	0	180
485	SUPREMA	IN0102041	0	0	7	0
486	PALMAS	RE0302091	0	0	14	0
487	PALMAS	MA0102115	0	0	0	4
488	TASINSA	RE0309159	0	0	18	0
489	SAN JORGE	IN0301005	280	0	400	0
490	PALMAS	RE0314047	3	0	0	0
491	PALMAS	08-0091-01	1	0	0	0
492	PALMAS	MA0107027	5376	0	0	0
493	SUPREMA	RE0304061	0	10	17	0
494	SUPREMA	RE0317194	0	3	0	0
495	ACACIAS	MA0102069	0	40	0	0
496	PALMAS	RE0312025	2	0	0	0
497	PALMAS	RE0311006	48	0	0	0
498	PALMAS	RE0314041	2	0	0	0
499	SUPREMA	RE0304088	0	2	0	2
500	PALMAS	04-0733-01	0	0	1	0
501	SUPREMA	MA0110005	0	648	720	0
502	PALMAS	RE0314017	2	0	0	0
503	PALMAS	MA0105026	0	0	0	110
504	SUPREMA	MA0110011	0	0	54	0
505	PALMAS	RE0312023	2	0	0	0
506	SUPREMA	05-0574-02	0	0	0	1
507	SUPREMA	IN0102081	0	0	0	4
508	SUPREMA	04-0398-02	1	0	0	0
509	PALMAS	RE0302107	0	0	0	2
510	PALMAS	RE0314023	2	0	0	0
511	PALMAS	RE0311028	4	0	0	0
512	PALMAS	RE0314046	3	0	0	0
513	PALMAS	RE0313073	7	0	0	0
514	GRS	IN0402003	0	300	300	0
515	QUIRICA	04-0018-07	0	1	0	0
516	ACACIAS	04-0132-03	0	1	0	0
517	QUIRICA	04-0017-07	0	1	0	0
518	PALMAS	RE0311027	4	0	0	0
519	ACACIAS	IN0305016	0	0	0	69
520	PALMAS	RE0314043	2	0	0	0
521	PALMAS	04-0711-01	0	0	1	0
522	SUPREMA	IN0102087	0	0	2	3
523	GRS	07-0002-10	0	0	0	1
524	PALMAS	RE0314011	16	0	0	0
525	PALMAS	04-0735-01	0	0	0	1
526	SAN ANTONIO	05-0042-05	0	0	0	1
527	PALMAS	RE0311021	4	0	0	0
528	PALMAS	MA0104029	0	0	0	4
529	PALMAS	RE0302003	0	0	0	4
530	PALMAS	04-0734-01	0	0	0	1
531	SUPREMA	IN0102089	0	0	0	5
532	PALMAS	RE0312027	1	0	0	0
533	PALMAS	RE0314012	16	0	0	0
534	SUPREMA	IN0102091	0	0	0	3
535	METALMECANICA	AV10110010113	0	0	10	0
536	SUPREMA	RE0317053	0	0	3	0
537	SUPREMA	IN0104022	0	0	0	34
538	PALMAS	04-0732-01	0	0	1	0
539	ACACIAS	MA0101026	60	0	1	0
540	SAN ANTONIO	IN0303010	0	0	0	30
541	PALMAS	RE0317094	0	0	0	8
542	PALMAS	RE0312013	2	0	0	0
543	PALMAS	06-0437-01	0	1	0	0
544	GRS	RE0309006	6	0	0	0
545	SAN JORGE	MA0104021	0	0	10	0
546	ALFA	MA0101026	0	0	60	0
547	ACACIAS	IN0301001	400	0	0	0
548	SUPREMA	06-0519-02	1	0	0	0
549	SAN FRANCISCO	IN0305023	0	0	0	37
550	PALMAS	RE0102026	0	6	0	0
551	SUPREMA	06-0582-02	0	0	1	0
552	PALMAS	06-0470-01	0	0	1	0
553	PALMAS	06-0477-01	0	0	1	0
554	PALMAS	06-0474-01	0	0	1	0
555	PALMAS	06-0471-01	0	0	1	0
556	SUPREMA	06-0581-02	0	0	1	0
557	PALMAS	06-0452-01	0	0	1	0
558	PALMAS	06-0472-01	0	0	1	0
559	PALMAS	06-0469-01	0	0	1	0
560	PALMAS	06-0473-01	0	0	1	0
561	PALMAS	06-0451-01	0	0	1	0
562	PALMAS	RE0312014	2	0	0	0
563	SUPREMA	RE0317243	1	0	0	0
564	SUPREMA	RE0317064	0	32	0	0
565	SUPREMA	IN0106031	0	0	0	34018
566	PALMAS	RE0317098	0	0	0	6
567	PALMAS	RE0311004	48	0	0	0
568	PALMAS	05-0560-01	1	0	0	0
569	PALMAS	MA0102116	0	0	1	3
570	PALMAS	07-0135-01	0	0	1	0
571	QUIRICA	IN0301023	0	0	0	400
572	ACACIAS	IN0301023	0	0	0	400
573	ALFA	IN0301023	0	0	0	400
574	ACACIAS	IN0305003	0	0	62	0
575	PALMAS	06-0484-01	0	0	1	0
576	SUPREMA	IN0105009	15	0	16	0
577	SUPREMA	MA0110020	0	0	0	60
578	QUIRICA	MA0102069	0	22.5	0	0
579	PALMAS	RE0311017	8	0	0	0
580	SUPREMA	MA0110010	0	0	102	0
581	SUPREMA	08-0294-02	0	0	1	0
582	PALMAS	RE0317103	0	0	0	3
583	SUPREMA	RE0317187	0	0	35	0
584	PALMAS	MA0104065	0	4	0	12
585	SUPREMA	08-0298-02	0	0	0	1
586	PALMAS	RE0201115	0	10	15	0
587	PALMAS	RE0317028	0	25	0	0
588	GRS	06-0045-10	0	0	0	1
589	PALMAS	RE0317027	0	25	0	0
590	SUPREMA	IN0102088	0	0	0	3
591	SAN JORGE	MA0104020	0	0	10	0
592	SUPREMA	05-0554-02	0	1	0	0
593	SUPREMA	05-0546-02	0	1	0	0
594	SUPREMA	RE0317093	0	0	150	200
595	PALMAS	IN0102019	0	0	4.5	0
596	PALMAS	MA0102101	0	0	0	12
597	PALMAS	RE0302083	0	8	0	4
598	PALMAS	MA0104090	0	0	0	4
599	SUPREMA	MA0110018	0	0	0	80
600	PALMAS	08-0197-01	0	0	0	1
601	SAN JORGE	IN0302008	0	0	0	60
602	ACACIAS	MA0105003	50	55	0	0
603	PALMAS	05-0570-01	0	0	1	0
604	PALMAS	07-0141-01	0	0	0	1
605	SAN ANTONIO	MA0105003	0	110	0	0
606	PALMAS	RE0317097	0	0	0	2
607	SUPREMA	04-0419-02	0	0	0	1
608	SUPREMA	RE0302010	0	5	0	0
609	SUPREMA	RE0201032	0	100	0	100
610	GRS	04-0123-10	0	0	1	0
611	PALMAS	RE0314005	2	0	0	0
612	METALMECANICA	08-0302-11	1	0	0	0
613	PALMAS	RE0302012	0	0	4	4
614	PALMAS	MA0105010	5	10	0	0
615	PALMAS	RE0201029	2	0	5	0
616	PALMAS	RE0201127	0	0	24	0
617	PALMAS	RE0314040	1	0	0	0
618	PALMAS	MA0102112	0	0	4	0
619	SUPREMA	IN0105005	0	0	5000	0
620	PALMAS	RE0314045	2	0	0	0
621	PALMAS	RE0201070	12	0	28	0
622	SUPREMA	06-0561-02	0	0	1	0
623	SUPREMA	06-0562-02	0	0	1	0
624	SUPREMA	06-0552-02	0	0	1	0
625	SAN FRANCISCO	IN0301005	80	0	200	0
626	SUPREMA	RE0317240	1	0	0	0
627	SAN JORGE	06-0029-04	0	0	0	1
628	GABIOSA	06-0003-13	0	0	1	0
629	SUPREMA	IN0202007	45	0	0	0
630	PALMAS	RE0311002	4	0	0	0
631	PALMAS	RE0311020	4	0	0	0
632	PALMAS	05-0589-01	0	0	1	0
633	PALMAS	06-0440-01	0	0	1	0
634	SUPREMA	IN0202010	7	0	8	0
635	SAN JORGE	04-0025-04	0	0	1	0
636	SAN JORGE	04-0024-04	0	0	1	0
637	SUPREMA	MA0102115	0	0	4	4
638	SUPREMA	RE0201196	0	0	2	0
639	SUPREMA	06-0536-02	0	1	0	0
640	SUPREMA	06-0534-02	0	1	0	0
641	GRS	RE0309090	0	9	0	0
642	PALMAS	MA0102114	0	0	0	8
643	PALMAS	RE0304012	0	75	0	0
644	METALMECANICA	08-0301-11	1	0	0	0
645	GRS	RE0309054	20	0	16	0
646	PALMAS	RE0314055	1	0	0	0
647	PALMAS	RE0101102	0	0	0	6
648	PALMAS	RE0101103	0	0	0	6
649	PALMAS	06-0486-01	0	0	0	1
650	SUPREMA	RE0304140	0	90	0	100
651	PALMAS	06-0433-01	0	1	0	0
652	GABIOSA	05-0015-13	0	0	0	2
653	PALMAS	RE0314058	1	0	0	0
654	SUPREMA	06-0520-02	1	0	0	0
655	SUPREMA	06-0521-02	1	0	0	0
656	PALMAS	RE0103053	0	8	10	0
657	SAN JORGE	05-0035-04	1	0	0	0
658	PALMAS	MA0104024	0	0	0	1
659	PALMAS	RE0302005	0	4	0	4
660	SUPREMA	RE0101002	0	29	0	0
661	PALMAS	05-0598-01	0	0	0	1
662	PALMAS	MA0104026	0	0	0	10
663	SAN JORGE	06-0028-04	0	1	0	0
664	SUPREMA	06-0533-02	0	1	0	0
665	SUPREMA	06-0532-02	0	1	0	0
666	SUPREMA	06-0535-02	0	1	0	0
667	PALMAS	RE0302061	2	8	0	0
668	SUPREMA	06-0591-02	0	0	0	1
669	PALMAS	06-0512-01	0	0	0	1
670	PALMAS	06-0511-01	0	0	0	1
671	SUPREMA	06-0593-02	0	0	0	1
672	SUPREMA	06-0592-02	0	0	0	1
673	SUPREMA	06-0594-02	0	0	0	1
674	METALMECANICA	06-0060-11	0	0	0	1
675	PALMAS	06-0515-01	0	0	0	1
676	SUPREMA	06-0590-02	0	0	0	1
677	PALMAS	06-0513-01	0	0	0	1
678	PALMAS	06-0514-01	0	0	0	1
679	PALMAS	RE0306044	0	4	8	0
680	PALMAS	06-0442-01	0	1	0	0
681	SUPREMA	06-0545-02	0	0	1	0
682	SUPREMA	06-0531-02	1	0	0	0
683	SUPREMA	RE0201025	0	0	100	100
684	PALMAS	RE0317110	0	0	0	2
685	SUPREMA	06-0544-02	0	1	0	0
686	PALMAS	MA0107022	243	0	0	300
687	PALMAS	06-0429-01	0	0	1	0
688	PALMAS	06-0421-01	1	0	0	0
689	PALMAS	05-0577-01	0	0	1	0
690	PALMAS	RE0302082	0	1	0	0
691	PALMAS	RE0317107	0	0	0	2
692	PALMAS	RE0302090	0	12	0	0
693	PALMAS	RE0201126	0	0	100	0
694	PALMAS	06-0453-01	0	0	1	0
695	PALMAS	06-0476-01	0	0	1	0
696	SUPREMA	06-0571-02	0	0	1	0
697	SUPREMA	06-0578-02	0	0	1	0
698	SUPREMA	06-0572-02	0	0	1	0
699	PALMAS	06-0475-01	0	0	1	0
700	PALMAS	06-0462-01	0	0	1	0
701	PALMAS	06-0461-01	0	0	1	0
702	PALMAS	06-0460-01	0	0	1	0
703	PALMAS	06-0459-01	0	0	1	0
704	PALMAS	06-0458-01	0	0	1	0
705	PALMAS	06-0457-01	0	0	1	0
706	PALMAS	06-0456-01	0	0	1	0
707	PALMAS	06-0464-01	0	0	1	0
708	PALMAS	06-0450-01	0	0	1	0
709	PALMAS	06-0454-01	0	0	1	0
710	SUPREMA	06-0576-02	0	0	1	0
711	SUPREMA	06-0573-02	0	0	1	0
712	SUPREMA	06-0577-02	0	0	1	0
713	SUPREMA	06-0575-02	0	0	1	0
714	SUPREMA	06-0574-02	0	0	1	0
715	PALMAS	06-0455-01	0	0	1	0
716	PALMAS	06-0466-01	0	0	1	0
717	PALMAS	06-0467-01	0	0	1	0
718	PALMAS	06-0465-01	0	0	1	0
719	PALMAS	06-0468-01	0	0	1	0
720	PALMAS	06-0463-01	0	0	1	0
721	SUPREMA	06-0580-02	0	0	1	0
722	SUPREMA	06-0579-02	0	0	1	0
723	PALMAS	RE0314057	1	0	0	0
724	SUPREMA	RE0305011	18	0	23	0
725	PALMAS	MA0102132	1	0	4	0
726	SUPREMA	RE0201190	0	0	0	1
727	PALMAS	08-0122-01	0	0	1	0
728	SAN JORGE	MA0104027	50	0	0	0
729	PALMAS	07-0138-01	0	0	0	1
730	PALMAS	RE0306071	0	154	0	0
731	SUPREMA	RE0317241	1	0	0	0
732	SUPREMA	RE0317086	0	10	0	0
733	PALMAS	RE0317017	16	110	0	0
734	PALMAS	07-0133-01	1	0	0	0
735	SUPREMA	RE0201012	0	10	0	5
736	SUPREMA	06-0585-02	0	0	1	0
737	SUPREMA	RE0310011	0	55	0	55
738	PALMAS	RE0101069	2	20	0	0
739	PALMAS	RE0302058	2	12	0	0
740	GABIOSA	08-0006-13	1	0	0	0
741	SUPREMA	MA0106054	32	0	0	0
742	PALMAS	IN0102018	0	4000	0	0
743	PALMAS	MA0105028	0	0	61	0
744	PALMAS	08-0092-01	1	0	0	0
745	SUPREMA	MA0110004	520	0	0	880
746	SUPREMA	RE0317196	0	0	19	0
747	PALMAS	RE0302080	0	4	0	0
748	PALMAS	RE0317106	0	0	0	2
749	SAN FRANCISCO	MA0102070	15	0	0	0
750	PALMAS	IN0202002	300	400	0	0
751	PALMAS	RE0314035	4	0	0	0
752	PALMAS	RE0304038	0	32	51	0
753	SUPREMA	RE0317061	0	1	0	0
754	SUPREMA	RE0317208	0	0	2	0
755	PALMAS	RE0306001	0	0	200	0
756	SUPREMA	RE0317195	0	0	7	0
757	SUPREMA	MA0109005	50	0	0	0
758	SUPREMA	06-0518-02	1	0	0	0
759	SAN ANTONIO	05-0035-05	0	0	2	0
760	PALMAS	RE0302068	1	0	0	1
761	GRS	MA0105001	0	0	0	55
762	ACACIAS	MA0102004	900	1520	0	0
763	PALMAS	RE0201114	15	0	50	0
764	ACACIAS	MA0105004	0	55	0	0
765	PALMAS	RE0101099	0	0	2	4
766	PALMAS	RE0101096	0	0	2	4
767	METALMECANICA	AV10110010112	0	0	0	1
768	PALMAS	RE0304022	45	18	0	0
769	SUPREMA	08-0287-02	1	0	0	0
770	SUPREMA	RE0317060	0	6	0	0
771	PALMAS	RE0317012	1	0	5	0
772	SUPREMA	MA0107016	44	33	0	0
773	SUPREMA	RE0306011	0	6	0	10
774	SUPREMA	IN0201009	200	0	45	0
775	PALMAS	RE0302069	0	0	0	2
776	SUPREMA	RE0101008	0	15	0	0
777	SUPREMA	MA0107020	44	33	0	0
778	PALMAS	RE0312021	2	0	0	0
779	ACACIAS	MA0105008	105	140	0	0
780	SUPREMA	05-0576-02	0	0	0	1
781	QUIRICA	MA0102012	1500	880	0	0
782	SUPREMA	RE0101019	0	29	0	0
783	PALMAS	08-0094-01	0	0	0	1
784	SUPREMA	MA0106042	24	0	0	0
785	PALMAS	04-0752-01	0	0	0	1
786	PALMAS	RE0302099	0	2	0	0
787	PALMAS	06-0449-01	0	0	1	0
788	PALMAS	05-0621-01	0	0	0	1
789	SUPREMA	05-0550-02	0	1	0	0
790	SUPREMA	05-0549-02	0	1	0	0
791	PALMAS	MA0102105	0	0	6	0
792	PALMAS	06-0489-01	0	0	0	1
793	PALMAS	06-0478-01	0	0	1	0
794	PALMAS	MA0104079	0	0	0	1
795	SUPREMA	IN0102090	0	0	0	1
796	PALMAS	05-0597-01	0	0	0	1
797	SAN ANTONIO	IN0301016	0	0	0	10
798	PALMAS	06-0427-01	1	0	0	0
799	SUPREMA	IN0106029	0	0	0	36
800	PALMAS	06-0420-01	1	0	0	0
801	PALMAS	06-0418-01	1	0	0	0
802	TASINSA	08-0272-09	0	1	0	0
803	SUPREMA	RE0101026	0	5	5	0
804	SAN ANTONIO	MA0201002	800	0	0	0
805	TASINSA	06-0081-09	0	1	0	0
806	SUPREMA	RE0317082	0	0	0	2
807	ALFA	MA0104007	299	0	0	0
808	PALMAS	RE0314006	1	0	0	0
809	PALMAS	RE0201125	5	20	0	0
810	PALMAS	RE0302081	4	5	0	0
811	PALMAS	RE0309012	0	0	250	0
812	PALMAS	08-0189-01	0	0	0	1
813	PALMAS	MA0104083	0	6	0	0
814	QUIRICA	MA0101041	35	0	0	0
815	ACACIAS	MA0101041	35	0	0	0
816	PALMAS	RE0304065	3	0	20	0
817	PALMAS	RE0101053	6	8	0	0
818	SUPREMA	RE0317184	0	0	44	0
819	SUPREMA	06-0542-02	0	1	0	0
820	SUPREMA	06-0543-02	0	1	0	0
821	ACACIAS	MA0105007	0	55	0	0
822	SAN FRANCISCO	IN0301002	100	0	0	0
823	PALMAS	RE0317105	0	0	0	2
824	PALMAS	08-0200-01	0	0	0	1
825	SUPREMA	05-0547-02	0	1	0	0
826	ACACIAS	MA0105005	0	55	0	0
827	SAN ANTONIO	MA0105006	0	55	0	0
828	SUPREMA	MA0102116	0	0	2	0
829	SUPREMA	RE0201191	0	0	6	4
830	PALMAS	05-0610-01	0	0	0	1
831	PALMAS	RE0312024	2	0	0	0
832	PALMAS	MA0104011	0	0	0	8
833	SUPREMA	MA0110019	0	0	0	50
834	SUPREMA	RE0305012	10	0	17	0
835	PALMAS	MA0106016	0	200	200	0
836	PALMAS	05-0618-01	0	0	0	1
837	SUPREMA	RE0317185	0	0	17	0
838	SUPREMA	RE0201055	0	0	2	0
839	PALMAS	MA0102152	0	0	10	0
840	PALMAS	RE0314004	1	0	0	0
841	PALMAS	05-0592-01	0	0	0	1
842	SAN ANTONIO	IN0305015	0	0	0	17
843	PALMAS	RE0314049	3	0	0	0
844	SUPREMA	RE0304001	0	0	12	0
845	PALMAS	RE0317002	0	0	2	2
846	SUPREMA	RE0201184	0	0	3	0
847	SUPREMA	MA0106051	0	0	0	1
848	GRS	05-0132-10	0	0	0	1
849	SUPREMA	RE0201174	0	0	2	0
850	PALMAS	RE0312016	8	0	0	0
851	PALMAS	MA0102106	0	0	0	5
852	PALMAS	RE0303044	48	0	0	0
853	PALMAS	RE0201045	0	0	5	0
854	GRS	MA0104030	0	0	0	10
855	ACACIAS	IN0302006	6	0	0	34
856	PALMAS	RE0314054	1	0	0	0
857	PALMAS	RE0314056	1	0	0	0
858	PALMAS	RE0102025	0	20	0	0
859	SUPREMA	RE0201102	10	0	0	10
860	PALMAS	RE0311024	24	0	0	0
861	PALMAS	RE0102021	0	20	0	0
862	SUPREMA	RE0305010	6	0	3	0
863	SUPREMA	RE0301035	28	0	0	0
864	SUPREMA	RE0201128	0	75	0	75
865	SUPREMA	RE0302049	0	0	0	9
866	SUPREMA	RE0304139	0	2	0	0
867	PALMAS	05-0556-01	1	0	0	0
868	METALMECANICA	08-0318-11	0	1	0	0
869	PALMAS	RE0302101	0	0	4	0
870	PALMAS	RE0317029	0	0	5	0
871	PALMAS	RE0306054	0	0	20	0
872	SAN JORGE	MA0201002	600	0	0	0
873	PALMAS	RE0101097	0	0	2	4
874	PALMAS	05-0596-01	0	0	0	1
875	PALMAS	08-0093-01	0	1	0	0
876	SUPREMA	MA0110022	0	0	0	20
877	PALMAS	08-0095-01	0	1	0	0
878	SUPREMA	06-0529-02	1	0	0	0
879	PALMAS	04-0709-01	0	1	0	0
880	PALMAS	08-0126-01	0	0	1	0
881	PALMAS	08-0187-01	0	0	0	1
882	SUPREMA	RE0201192	0	0	6	2
883	GRS	RE0109002	0	0	8	12
884	QUIRICA	IN0302006	0	0	0	34
885	PALMAS	05-0569-01	0	0	1	0
886	GRS	MA0103002	30	0	0	0
887	PALMAS	RE0311003	96	0	0	0
888	SAN JORGE	MA0104026	25	0	0	0
889	SUPREMA	05-0572-02	0	0	1	0
890	SUPREMA	05-0569-02	0	0	1	0
891	SUPREMA	05-0570-02	0	0	1	0
892	SUPREMA	05-0568-02	0	0	1	0
893	SUPREMA	05-0573-02	0	0	1	0
894	SUPREMA	05-0571-02	0	0	1	0
895	PALMAS	MA0102125	0	0	4	5
896	SUPREMA	MA0107047	0	980	0	0
897	PALMAS	04-0731-01	0	0	1	0
898	PALMAS	06-0428-01	1	0	0	0
899	PALMAS	06-0432-01	0	1	0	0
900	PALMAS	RE0310009	0	20	0	0
901	PALMAS	RE0302067	0	0	0	5
902	GRS	RE0309003	0	5	0	8
903	METALMECANICA	08-0312-11	1	0	0	0
904	PALMAS	RE0317095	0	0	0	1
905	PALMAS	RE0317096	0	0	0	1
906	PALMAS	RE0314030	4	0	0	0
907	GRS	IN0101004	2500	0	0	0
908	PALMAS	RE0306003	10	40	0	0
909	SAN FRANCISCO	MA0101041	24	0	0	0
910	SAN JORGE	MA0101041	24	0	0	0
911	SAN ANTONIO	MA0101041	24	0	0	0
912	PALMAS	05-0599-01	0	0	0	1
913	SUPREMA	MA0102109	0	2	2	0
914	PALMAS	MA0102141	2	12	0	0
915	SAN ANTONIO	MA0103010	0	4	5	0
916	PALMAS	RE0302045	0	0	0	3
917	METALMECANICA	RE0309137	58	0	0	0
918	PALMAS	RE0312017	6	0	0	0
919	SUPREMA	RE0304087	1	0	0	0
920	SUPREMA	05-0551-02	0	1	0	0
921	SUPREMA	RE0201031	20	0	0	0
922	SUPREMA	RE0307004	0	0	0	100
923	GRS	RE0307004	0	0	0	150
924	PALMAS	05-0586-01	0	0	0	1
925	PALMAS	05-0582-01	0	0	1	0
926	PALMAS	05-0584-01	0	0	0	1
927	PALMAS	05-0585-01	0	0	0	1
928	PALMAS	05-0583-01	0	0	1	0
929	SUPREMA	06-0546-02	0	0	1	0
930	SUPREMA	06-0565-02	0	0	1	0
931	SUPREMA	06-0548-02	0	0	1	0
932	SUPREMA	06-0547-02	0	0	1	0
933	SAN ANTONIO	IN0305003	0	0	15	0
934	PALMAS	05-0563-01	0	1	0	0
935	PALMAS	05-0565-01	0	1	0	0
936	PALMAS	05-0564-01	0	1	0	0
937	SUPREMA	05-0553-02	0	1	0	0
938	SUPREMA	05-0552-02	0	1	0	0
939	SUPREMA	06-0525-02	1	0	0	0
940	SUPREMA	06-0524-02	1	0	0	0
941	SUPREMA	06-0526-02	1	0	0	0
942	SUPREMA	06-0522-02	1	0	0	0
943	SUPREMA	06-0523-02	1	0	0	0
944	PALMAS	05-0551-01	1	0	0	0
945	PALMAS	05-0547-01	1	0	0	0
946	PALMAS	RE0302097	0	4	0	0
947	PALMAS	08-0127-01	0	0	1	0
948	GRS	RE0306008	0	12	20	0
949	PALMAS	RE0101027	0	4	0	0
950	SUPREMA	RE0317101	0	2	0	0
951	ACACIAS	05-0076-03	1	0	0	0
952	SUPREMA	05-0541-02	1	0	0	0
953	PALMAS	05-0546-01	1	0	0	0
954	PALMAS	05-0545-01	1	0	0	0
955	SUPREMA	MA0107019	10	0	0	0
956	SUPREMA	RE0101013	0	29	0	0
957	PALMAS	RE0302008	0	2	0	2
958	SUPREMA	05-0567-02	0	0	1	0
959	PALMAS	MA0102145	2	0	0	0
960	PALMAS	MA0104073	0	0	0	10
961	SUPREMA	RE0101027	0	5	5	0
962	PALMAS	06-0504-01	0	0	0	1
963	SAN JORGE	MA0101013	60	0	0	48
964	SAN FRANCISCO	MA0101013	60	0	0	48
965	SAN ANTONIO	MA0101013	60	0	0	48
966	PALMAS	RE0101101	0	0	0	2
967	PALMAS	RE0301011	0	25	0	0
968	PALMAS	04-0688-01	1	0	0	0
969	ALFA	05-0016-08	0	0	1	0
970	SAN JORGE	05-0042-04	0	0	1	0
971	PALMAS	06-0479-01	0	0	0	1
972	GRS	RE0309034	0	0	4	0
973	PALMAS	RE0314051	3	0	0	0
974	SUPREMA	MA0102108	0	4	0	2
975	ACACIAS	IN0302004	0	4	0	22
976	QUIRICA	IN0302004	0	4	0	22
977	SUPREMA	08-0296-02	0	0	1	0
978	PALMAS	05-0557-01	1	0	0	0
979	PALMAS	05-0548-01	1	0	0	0
980	PALMAS	RE0101092	0	0	2	4
981	GRS	RE0201089	0	0	0	10
982	PALMAS	RE0304058	0	0	20	0
983	PALMAS	05-0552-01	1	0	0	0
984	SUPREMA	08-0293-02	1	0	0	0
985	SAN FRANCISCO	MA0101010	24	0	0	12
986	SAN ANTONIO	MA0101010	24	0	0	12
987	SAN JORGE	MA0101010	24	0	0	12
988	PALMAS	06-0446-01	0	0	1	0
989	PALMAS	06-0445-01	0	0	1	0
990	SUPREMA	RE0304091	0	0	0	2
991	SUPREMA	RE0317100	0	2	0	0
992	PALMAS	08-0201-01	0	0	0	1
993	PALMAS	RE0314050	3	0	0	0
994	SUPREMA	08-0289-02	1	0	0	0
995	PALMAS	MA0102142	2	6	0	0
996	SUPREMA	06-0530-02	1	0	0	0
997	PALMAS	RE0302011	0	4	0	0
998	SUPREMA	05-0555-02	0	1	0	0
999	SUPREMA	05-0556-02	0	1	0	0
1000	PALMAS	06-0491-01	0	0	0	1
1001	PALMAS	06-0490-01	0	0	0	1
1002	SUPREMA	MA0102126	0	0	4	1
1003	SUPREMA	RE0304041	60	0	0	0
1004	PALMAS	MA0104074	0	0	0	10
1005	SUPREMA	RE0101038	3	0	3	0
1006	SAN ANTONIO	MA0102012	1250	0	0	0
1007	PALMAS	RE0314052	3	0	0	0
1008	SUPREMA	06-0540-02	0	1	0	0
1009	SUPREMA	06-0538-02	0	1	0	0
1010	SUPREMA	06-0541-02	0	1	0	0
1011	SUPREMA	06-0539-02	0	1	0	0
1012	SUPREMA	06-0537-02	0	1	0	0
1013	GRS	MA0103003	25	0	0	0
1014	SAN FRANCISCO	IN0303008	0	0	0	5
1015	GRS	RE0309024	0	0	0	2
1016	ALFA	MA0101013	100	0	0	0
1017	PALMAS	RE0201104	0	0	10	0
1018	SAN FRANCISCO	MA0201002	400	0	0	0
1019	PALMAS	05-0593-01	0	0	0	1
1020	PALMAS	05-0588-01	0	0	1	0
1021	PALMAS	RE0306045	4	0	10	0
1022	ALFA	MA0102122	4	0	0	0
1023	SUPREMA	MA0110009	0	12	0	0
1024	SUPREMA	MA0105002	21	12	0	0
1025	PALMAS	05-0611-01	0	0	0	1
1026	PALMAS	MA0104084	0	0	0	10
1027	PALMAS	RE0302037	3	0	0	3
1028	PALMAS	RE0101071	2	0	0	0
1029	PALMAS	RE0310004	0	6	15	0
1030	PALMAS	06-0435-01	0	1	0	0
1031	PALMAS	06-0436-01	0	1	0	0
1032	PALMAS	06-0434-01	0	1	0	0
1033	PALMAS	RE0311022	4	0	0	0
1034	PALMAS	06-0443-01	0	0	1	0
1035	PALMAS	RE0103010	2	5	0	0
1036	PALMAS	RE0303039	0	0	705	0
1037	SAN ANTONIO	MA0202030	0	0	0	2
1038	PALMAS	05-0608-01	0	0	0	1
1039	SUPREMA	06-0564-02	0	0	1	0
1040	SUPREMA	06-0549-02	0	0	1	0
1041	SUPREMA	06-0550-02	0	0	1	0
1042	SUPREMA	06-0563-02	0	0	1	0
1043	SUPREMA	06-0551-02	0	0	1	0
1044	PALMAS	MA0107026	5	3	0	0
1045	PALMAS	06-0439-01	0	0	1	0
1046	SAN ANTONIO	MA0101011	35	0	0	0
1047	PALMAS	MA0107028	5	0	0	0
1048	SUPREMA	MA0102111	0	0	2	0
1049	PALMAS	MA0102099	0	0	0	12
1050	PALMAS	RE0201103	0	0	10	0
1051	PALMAS	05-0580-01	0	0	1	0
1052	PALMAS	05-0579-01	0	0	1	0
1053	SUPREMA	05-0557-02	0	1	0	0
1054	SUPREMA	05-0558-02	0	1	0	0
1055	PALMAS	05-0555-01	0	1	0	0
1056	PALMAS	05-0553-01	0	1	0	0
1057	SUPREMA	05-0565-02	0	0	1	0
1058	SUPREMA	05-0566-02	0	0	1	0
1059	TASINSA	05-0098-09	1	0	0	0
1060	PALMAS	RE0101011	0	6	0	0
1061	PALMAS	RE0312008	2	0	0	0
1062	PALMAS	MA0104013	0	0	0	5
1063	PALMAS	06-0488-01	0	0	0	1
1064	PALMAS	RE0302078	0	6	0	0
1065	SUPREMA	RE0302052	2	0	0	0
1066	PALMAS	RE0304060	0	0	10	0
1067	SUPREMA	RE0316008	25	0	0	50
1068	TASINSA	05-0099-09	0	1	0	0
1069	PALMAS	MA0104001	0	8	0	0
1070	PALMAS	RE0101104	0	0	0	6
1071	SUPREMA	RE0317085	3	0	0	0
1072	SUPREMA	MA0102110	0	0	2	1
1073	SUPREMA	RE0304042	12	24	0	0
1074	PALMAS	RE0317108	0	0	0	2
1075	PALMAS	RE0317109	0	0	0	2
1076	PALMAS	RE0304040	12	0	27	0
1077	ACACIAS	MA0104002	120	0	0	0
1078	ALFA	IN0302004	0	15	0	5
1079	SUPREMA	RE0201024	0	0	100	0
1080	SUPREMA	06-0527-02	1	0	0	0
1081	PALMAS	MA0106004	0	208	0	0
1082	PALMAS	06-0419-01	1	0	0	0
1083	PALMAS	RE0317104	0	0	0	1
1084	PALMAS	05-0571-01	0	0	1	0
1085	PALMAS	05-0574-01	0	0	1	0
1086	PALMAS	05-0572-01	0	0	1	0
1087	PALMAS	05-0575-01	0	0	1	0
1088	PALMAS	05-0576-01	0	0	1	0
1089	PALMAS	05-0573-01	0	0	1	0
1090	SUPREMA	RE0309019	0	0	0	10
1091	SAN ANTONIO	MA0202024	0	75	75	0
1092	ACACIAS	MA0102107	0	1	0	0
1093	ACACIAS	MA0102035	0	1	0	0
1094	SAN JORGE	MA0103010	0	2	4	0
1095	SUPREMA	RE0201186	5	0	0	0
1096	PALMAS	RE0101098	0	0	2	4
1097	PALMAS	RE0101010	0	6	0	0
1098	SAN ANTONIO	MA0202015	2	0	0	2
1099	PALMAS	RE0312018	4	0	0	0
1100	PALMAS	08-0198-01	0	0	0	1
1101	PALMAS	05-0537-01	1	0	0	0
1102	PALMAS	06-0481-01	0	0	1	0
1103	PALMAS	06-0483-01	0	0	1	0
1104	PALMAS	06-0480-01	0	0	1	0
1105	PALMAS	06-0482-01	0	0	1	0
1106	SUPREMA	MA0106061	0	0	0	1
1107	SUPREMA	08-0297-02	0	0	1	0
1108	SUPREMA	05-0562-02	0	1	0	0
1109	SUPREMA	05-0561-02	0	1	0	0
1110	PALMAS	08-0123-01	0	0	1	0
1111	PALMAS	05-0554-01	0	1	0	0
1112	SUPREMA	RE0301027	10	0	7	0
1113	PALMAS	RE0314060	1	0	0	0
1114	SUPREMA	MA0102124	0	0	2	0
1115	SUPREMA	MA0108031	0	0	100	32
1116	GRS	RE0304011	0	0	0	10
1117	METALMECANICA	08-0316-11	0	1	0	0
1118	ALFA	MA0102035	0	1	0	0
1119	SUPREMA	RE0101012	0	6	0	0
1120	SUPREMA	RE0304026	0	0	0	50
1121	PALMAS	MA0102096	2	0	0	6
1122	PALMAS	MA0108033	312	208	0	0
1123	METALMECANICA	08-0307-11	1	0	0	0
1124	METALMECANICA	08-0308-11	1	0	0	0
1125	SUPREMA	RE0317083	0	4	0	0
1126	SUPREMA	RE0201168	0	0	2	0
1127	PALMAS	RE0314048	3	0	0	0
1128	ACACIAS	05-0077-03	0	0	1	0
1129	SAN JORGE	MA0105008	0	70	0	0
1130	PALMAS	RE0101070	2	0	0	0
1131	PALMAS	06-0485-01	0	0	0	1
1132	PALMAS	IN0105008	0	0	0	1000
1133	SUPREMA	RE0201006	20	0	0	0
1134	PALMAS	MA0102100	0	0	6	0
1135	PALMAS	RE0101095	0	0	2	4
1136	PALMAS	05-0568-01	0	0	1	0
1137	PALMAS	05-0561-01	0	1	0	0
1138	METALMECANICA	AV10110010108	0	0	1	1
1139	PALMAS	RE0311012	3	0	10	0
1140	PALMAS	RE0103070	0	10	0	0
1141	SUPREMA	MA0110021	0	0	0	40
1142	SUPREMA	05-0559-02	0	1	0	0
1143	SUPREMA	06-0583-02	0	0	1	0
1144	SUPREMA	05-0564-02	0	0	1	0
1145	SUPREMA	05-0560-02	0	1	0	0
1146	SUPREMA	06-0584-02	0	0	1	0
1147	SUPREMA	05-0563-02	0	0	1	0
1148	PALMAS	05-0605-01	0	0	0	1
1149	PALMAS	05-0604-01	0	0	0	1
1150	SAN JORGE	05-0034-04	1	0	0	0
1151	SUPREMA	06-0557-02	0	0	1	0
1152	SUPREMA	06-0560-02	0	0	1	0
1153	SUPREMA	06-0554-02	0	0	1	0
1154	SUPREMA	06-0555-02	0	0	1	0
1155	SUPREMA	06-0556-02	0	0	1	0
1156	SUPREMA	06-0553-02	0	0	1	0
1157	SUPREMA	06-0558-02	0	0	1	0
1158	SUPREMA	06-0559-02	0	0	1	0
1159	SUPREMA	06-0528-02	1	0	0	0
1160	PALMAS	MA0102110	0	0	13	0
1161	PALMAS	MA0104082	0	0	0	12
1162	METALMECANICA	08-0315-11	1	0	0	0
1163	METALMECANICA	08-0314-11	1	0	0	0
1164	ACACIAS	MA0103011	72	0	24	0
1165	PALMAS	RE0102018	0	4	0	0
1166	PALMAS	RE0103076	10	85	0	0
1167	PALMAS	RE0312022	2	0	0	0
1168	SAN FRANCISCO	MA0101040	0	50	0	0
1169	SAN ANTONIO	MA0101040	0	50	0	0
1170	PALMAS	05-0536-01	1	0	0	0
1171	SUPREMA	05-0575-02	0	0	0	1
1172	PALMAS	MA0105005	0	5	0	0
1173	SUPREMA	RE0101036	3	0	3	0
1174	SUPREMA	RE0304128	50	0	0	0
1175	SAN FRANCISCO	MA0103010	0	2	3	0
1176	ACACIAS	08-0064-03	0	0	1	0
1177	SUPREMA	RE0304101	0	0	8	0
1178	PALMAS	RE0302054	2	10	0	0
1179	SUPREMA	RE0302045	0	10	0	0
1180	SUPREMA	MA0107011	132	0	0	0
1181	ACACIAS	RE0301001	0	25	0	0
1182	PALMAS	RE0304015	0	100	0	0
1183	SAN ANTONIO	MA0102130	10	0	0	0
1184	SUPREMA	RE0201022	0	0	0	100
1185	SAN ANTONIO	IN0303003	0	0	0	4
1186	PALMAS	05-0562-01	0	1	0	0
1187	PALMAS	RE0101100	0	0	0	2
1188	PALMAS	RE0308010	0	0	4	0
1189	PALMAS	05-0595-01	0	0	0	1
1190	PALMAS	05-0594-01	0	0	0	1
1191	SUPREMA	MA0102098	0	0	3	0
1192	PALMAS	06-0426-01	1	0	0	0
1193	PALMAS	06-0423-01	1	0	0	0
1194	PALMAS	06-0424-01	1	0	0	0
1195	PALMAS	06-0425-01	1	0	0	0
1196	PALMAS	06-0422-01	1	0	0	0
1197	PALMAS	RE0306065	6	0	8	0
1198	PALMAS	08-0124-01	0	0	1	0
1199	PALMAS	RE0317011	0	0	5	0
1200	QUIRICA	MA0101010	20	0	0	0
1201	SUPREMA	MA0102107	0	4	0	0
1202	SAN ANTONIO	MA0105007	0	15	0	0
1203	ALFA	MA0105008	0	70	0	0
1204	SAN FRANCISCO	MA0105008	0	70	0	0
1205	SUPREMA	RE0301037	0	50	0	0
1206	PALMAS	05-0590-01	0	0	1	0
1207	PALMAS	05-0591-01	0	0	1	0
1208	PALMAS	RE0316005	0	0	0	100
1209	GRS	RE0306007	0	8	22	0
1210	PALMAS	RE0304062	0	0	5	0
1211	PALMAS	08-0190-01	0	0	0	1
1212	SAN JORGE	05-0037-04	0	1	0	0
1213	SAN JORGE	05-0038-04	0	1	0	0
1214	SAN JORGE	05-0041-04	0	1	0	0
1215	SAN JORGE	05-0040-04	0	1	0	0
1216	SAN JORGE	05-0039-04	0	1	0	0
1217	SAN JORGE	05-0036-04	0	1	0	0
1218	SUPREMA	MA0106023	0	200	0	0
1219	METALMECANICA	08-0267-11	1	0	0	0
1220	PALMAS	RE0308005	0	0	16	0
1221	SUPREMA	06-0569-02	0	0	1	0
1222	PALMAS	MA0108046	60	0	0	500
1223	SAN ANTONIO	MA0202025	0	0	105	0
1224	SUPREMA	RE0317018	6	0	0	0
1225	PALMAS	08-0192-01	0	0	0	1
1226	ACACIAS	MA0101013	60	0	0	0
1227	PALMAS	RE0311025	4	0	0	0
1228	PALMAS	RE0304052	0	5	10	0
1229	SAN FRANCISCO	IN0303003	0	0	0	4
1230	GRS	RE0306002	0	12	16	0
1231	PALMAS	RE0201118	0	0	10	0
1232	PALMAS	MA0108049	0	0	0	100
1233	SUPREMA	RE0304040	12	11	0	0
1234	PALMAS	08-0099-01	0	0	1	0
1235	PALMAS	08-0097-01	0	0	1	0
1236	PALMAS	08-0096-01	0	0	1	0
1237	PALMAS	08-0098-01	0	0	1	0
1238	SUPREMA	RE0201183	0	0	5	0
1239	PALMAS	RE0301013	2	2	0	0
1240	PALMAS	RE0306027	0	0	14	0
1241	SAN ANTONIO	MA0105008	0	70	0	0
1242	GRS	RE0309085	0	0	10	20
1243	PALMAS	RE0201116	0	0	30	0
1244	SUPREMA	RE0316019	10	20	0	0
1245	SUPREMA	RE0201217	1	0	0	0
1246	PALMAS	06-0438-01	0	1	0	0
1247	ALFA	MA0103010	0	4	0	0
1248	SUPREMA	RE0201218	0	0	2	0
1249	PALMAS	05-0578-01	0	0	1	0
1250	PALMAS	05-0559-01	0	0	1	0
1251	SAN FRANCISCO	IN0304003	0	0	0	3
1252	GRS	RE0309048	8	0	0	0
1253	SUPREMA	06-0566-02	0	0	1	0
1254	SUPREMA	06-0567-02	0	0	1	0
1255	SUPREMA	06-0568-02	0	0	1	0
1256	PALMAS	RE0306047	0	0	16	0
1257	PALMAS	MA0102113	0	0	0	4
1258	PALMAS	RE0305006	0	0	5	0
1259	SUPREMA	08-0292-02	1	0	0	0
1260	METALMECANICA	RE0316014	7	0	0	0
1261	PALMAS	RE0101093	0	0	2	4
1262	GRS	RE0201094	25	0	0	0
1263	SUPREMA	RE0310001	0	0	0	10
1264	PALMAS	RE0101068	2	0	0	0
1265	PALMAS	RE0101018	0	10	0	0
1266	SAN ANTONIO	IN0301020	150	0	0	0
1267	PALMAS	RE0101008	0	6	0	0
1268	SUPREMA	RE0317183	0	0	1	0
1269	SAN ANTONIO	MA0202023	0	40	50	0
1270	PALMAS	MA0108018	0	100	0	0
1271	PALMAS	RE0306037	0	0	10	0
1272	PALMAS	RE0304057	0	0	5	0
1273	PALMAS	RE0101037	0	8	0	0
1274	PALMAS	RE0304050	2	5	0	0
1275	GRS	RE0309027	0	48	0	24
1276	PALMAS	RE0302002	0	4	0	0
1277	PALMAS	RE0302066	0	0	4	0
1278	SUPREMA	RE0103022	0	0	0	40
1279	METALMECANICA	RE0309150	8	0	0	0
1280	SUPREMA	RE0309015	0	0	0	15
1281	PALMAS	MA0108029	0	0	0	200
1282	SAN FRANCISCO	MA0102004	600	0	0	0
1283	PALMAS	08-0191-01	0	0	0	1
1284	PALMAS	RE0306026	3	0	10	0
1285	SUPREMA	MA0105018	0	10	0	0
1286	PALMAS	MA0104012	0	0	0	10
1287	SAN JORGE	MA0101002	24	0	0	0
1288	SUPREMA	RE0317009	0	0	0	2
1289	PALMAS	RE0306046	2	0	12	0
1290	PALMAS	RE0302077	3	0	0	4
1291	SUPREMA	MA0102066	0	0	0	3
1292	PALMAS	MA0104067	0	5	0	0
1293	PALMAS	RE0101073	2	0	0	0
1294	PALMAS	08-0199-01	0	0	0	1
1295	SAN JORGE	MA0202030	0	0	0	1
1296	PALMAS	05-0566-01	0	1	0	0
1297	SAN FRANCISCO	MA0202030	0	0	0	1
1298	SUPREMA	RE0316009	50	0	0	0
1299	PALMAS	RE0308027	6	0	0	0
1300	PALMAS	MA0102103	0	0	5	5
1301	SAN FRANCISCO	MA0101017	48	0	0	0
1302	SAN ANTONIO	MA0108005	0	0	8	0
1303	SUPREMA	RE0201101	30	0	15	0
1304	SAN ANTONIO	MA0101008	24	0	0	0
1305	SAN JORGE	MA0101008	24	0	0	0
1306	SAN FRANCISCO	MA0101008	24	0	0	0
1307	PALMAS	RE0302044	0	0	8	0
1308	PALMAS	RE0304064	0	0	5	0
1309	PALMAS	RE0308007	0	0	10	0
1310	SUPREMA	RE0201008	0	20	0	0
1311	SUPREMA	MA0107012	88	0	0	0
1312	SAN JORGE	06-0030-04	0	0	0	1
1313	SUPREMA	RE0304090	0	0	0	2
1314	SAN FRANCISCO	MA0101002	24	0	0	0
1315	SAN ANTONIO	MA0101002	24	0	0	0
1316	PALMAS	08-0125-01	0	0	1	0
1317	SUPREMA	MA0108007	30	0	100	0
1318	PALMAS	MA0108034	0	0	0	200
1319	SAN FRANCISCO	MA0101001	3	0	0	0
1320	SAN ANTONIO	MA0101001	3	0	0	0
1321	SAN JORGE	MA0101001	3	0	0	0
1322	PALMAS	RE0306018	8	0	12	0
1323	GRS	RE0309058	0	0	0	24
1324	PALMAS	MA0102104	0	0	0	8
1325	SAN ANTONIO	MA0104002	60	0	0	0
1326	SUPREMA	RE0308010	10	0	10	0
1327	PALMAS	RE0311023	4	0	0	0
1328	SUPREMA	RE0305001	0	0	0	10
1329	QUIRICA	RE0302002	12	0	0	0
1330	SAN JORGE	MA0101011	16	0	0	0
1331	PALMAS	RE0306061	3	10	0	0
1332	ALFA	MA0101040	0	30	0	0
1333	ACACIAS	MA0101033	0	30	0	0
1334	SAN JORGE	MA0101040	0	30	0	0
1335	PALMAS	RE0306043	0	10	8	0
1336	SUPREMA	06-0589-02	0	0	0	1
1337	PALMAS	06-0509-01	0	0	0	1
1338	PALMAS	06-0510-01	0	0	0	1
1339	SUPREMA	RE0103014	0	0	7	0
1340	SUPREMA	RE0304006	35	0	0	0
1341	SAN FRANCISCO	MA0202015	1	0	0	1
1342	SAN JORGE	MA0202015	1	0	0	1
1343	PALMAS	MA0108028	0	0	0	100
1344	SUPREMA	RE0306013	0	6	8	0
1345	PALMAS	MA0108054	0	100	0	0
1346	SUPREMA	MA0102101	0	0	2	0
1347	SUPREMA	RE0308011	0	20	0	0
1348	SUPREMA	MA0103026	0	2	0	0
1349	SAN JORGE	RE0302002	11	0	0	0
1350	SAN ANTONIO	IN0304003	0	0	0	2
1351	SAN JORGE	MA0202025	0	0	70	0
1352	SUPREMA	RE0309009	50	0	0	50
1353	PALMAS	RE0103026	0	3	0	0
1354	ALFA	MA0202022	0	12	0	0
1355	SUPREMA	RE0317031	3	0	0	5
1356	GRS	RE0302012	0	0	0	10
1357	SUPREMA	08-0301-02	0	0	0	1
1358	SUPREMA	08-0300-02	0	0	0	1
1359	SUPREMA	08-0299-02	0	0	0	1
1360	SUPREMA	08-0302-02	0	0	0	1
1361	PALMAS	RE0302076	3	10	0	0
1362	QUIRICA	MA0202025	70	0	0	0
1363	ACACIAS	MA0202025	70	0	0	0
1364	SUPREMA	RE0304043	0	36	0	0
1365	SUPREMA	05-0545-02	1	0	0	0
1366	SUPREMA	05-0543-02	1	0	0	0
1367	SUPREMA	05-0544-02	1	0	0	0
1368	PALMAS	RE0314062	1	0	0	0
1369	PALMAS	RE0314063	1	0	0	0
1370	PALMAS	RE0306058	2	10	0	0
1371	PALMAS	RE0308006	9	0	0	0
1372	SAN ANTONIO	MA0202017	4	0	0	0
1373	SAN JORGE	MA0202017	4	0	0	0
1374	SAN FRANCISCO	MA0101011	14	0	0	0
1375	PALMAS	MA0108065	26	0	0	0
1376	SUPREMA	RE0302030	0	0	8	0
1377	GRS	RE0309019	0	0	0	2
1378	SUPREMA	RE0103013	5	0	0	20
1379	QUIRICA	MA0104002	50	0	0	0
1380	SAN ANTONIO	MA0102017	50	0	0	0
1381	SUPREMA	RE0201007	20	20	0	0
1382	GRS	RE0309032	0	200	0	0
1383	PALMAS	RE0314061	1	0	0	0
1384	QUIRICA	MA0101040	0	25	0	0
1385	PALMAS	RE0306025	0	10	0	0
1386	PALMAS	MA0104081	0	4	0	0
1387	PALMAS	RE0302105	0	0	0	4
1388	PALMAS	RE0306062	0	0	10	0
1389	SAN FRANCISCO	MA0101015	60	0	0	0
1390	SAN ANTONIO	MA0101015	60	0	0	0
1391	SUPREMA	RE0317144	0	0	0	2
1392	PALMAS	RE0317111	0	0	0	1
1393	PALMAS	MA0102138	0	0	0	8
1394	SUPREMA	RE0304010	0	50	0	60
1395	SAN ANTONIO	MA0202009	2	0	0	0
1396	SAN FRANCISCO	MA0202009	2	0	0	0
1397	SUPREMA	RE0304163	1	0	0	0
1398	SAN ANTONIO	MA0101003	14	0	0	0
1399	SUPREMA	RE0304153	0	0	2	0
1400	SUPREMA	RE0310002	0	20	0	43
1401	PALMAS	MA0104010	0	0	0	12
1402	PALMAS	RE0306015	0	10	8	0
1403	PALMAS	RE0306066	0	0	8	0
1404	PALMAS	RE0101067	2	0	0	0
1405	SUPREMA	RE0302027	0	0	13	0
1406	QUIRICA	RE0308001	16	0	0	0
1407	PALMAS	RE0102028	0	2	0	0
1408	METALMECANICA	08-0309-11	1	0	0	0
1409	METALMECANICA	08-0311-11	1	0	0	0
1410	METALMECANICA	08-0310-11	1	0	0	0
1411	SUPREMA	MA0108028	0	0	90	38
1412	SUPREMA	MA0102104	0	0	2	0
1413	PALMAS	MA0104063	0	0	0	20
1414	QUIRICA	MA0105008	0	35	0	0
1415	SUPREMA	MA0101026	0	0	100	0
1416	SUPREMA	MA0102103	0	0	2	0
1417	SUPREMA	MA0102114	0	0	2	0
1418	SUPREMA	RE0308038	6	0	8	0
1419	PALMAS	MA0108005	0	200	0	0
1420	SAN JORGE	MA0101004	24	0	0	0
1421	SAN ANTONIO	MA0101004	24	0	0	0
1422	SAN FRANCISCO	MA0103011	0	60	0	0
1423	SUPREMA	RE0101046	3	0	5	0
1424	SUPREMA	08-0291-02	1	0	0	0
1425	SUPREMA	RE0304160	1	0	0	0
1426	SAN JORGE	IN0303003	0	0	0	2
1427	ALFA	RE0308001	13	0	0	0
1428	SAN ANTONIO	MA0202004	0	0	0	10
1429	SUPREMA	RE0304127	50	0	0	0
1430	SUPREMA	RE0309020	0	0	0	7
1431	PALMAS	RE0101072	2	0	0	0
1432	ACACIAS	RE0302002	10	0	0	0
1433	SUPREMA	RE0101049	0	3	0	0
1434	SUPREMA	RE0317005	0	1	0	0
1435	GRS	MA0105011	0	0	6	0
1436	GRS	RE0302011	0	0	0	10
1437	SAN FRANCISCO	MA0101003	12	0	0	0
1438	SAN JORGE	MA0101003	12	0	0	0
1439	PALMAS	MA0108025	0	300	0	0
1440	SAN FRANCISCO	MA0202024	0	25	25	0
1441	SUPREMA	RE0304004	20	0	0	0
1442	PALMAS	MA0108020	0	0	0	100
1443	QUIRICA	MA0202024	50	0	0	0
1444	SUPREMA	RE0201065	0	0	0	5
1445	PALMAS	MA0107025	0	50	0	0
1446	SUPREMA	RE0305005	0	0	3	0
1447	ACACIAS	MA0202024	50	0	0	0
1448	SAN JORGE	MA0202024	0	50	0	0
1449	ALFA	MA0102110	299	0	0	0
1450	SAN JORGE	MA0101015	48	0	0	0
1451	PALMAS	RE0314059	1	0	0	0
1452	PALMAS	RE0301015	0	0	4	0
1453	PALMAS	RE0306063	0	0	8	0
1454	PALMAS	RE0101048	0	4	0	0
1455	PALMAS	RE0101049	0	4	0	0
1456	PALMAS	RE0302051	0	10	0	0
1457	PALMAS	RE0306060	0	10	0	0
1458	PALMAS	MA0102093	0	0	6	0
1459	SUPREMA	RE0101050	0	3	0	0
1460	SAN FRANCISCO	MA0101009	8	0	0	0
1461	SAN ANTONIO	MA0101009	8	0	0	0
1462	SAN JORGE	MA0101009	8	0	0	0
1463	GRS	RE0310003	0	0	0	5
1464	ALFA	RE0302002	6	0	0	0
1465	PALMAS	RE0308009	0	0	4	0
1466	SUPREMA	RE0309017	0	0	0	15
1467	METALMECANICA	RE0316005	13	0	0	0
1468	ACACIAS	MA0101017	24	0	0	0
1469	SUPREMA	RE0101037	2	0	3	0
1470	PALMAS	RE0306019	0	10	0	0
1471	PALMAS	MA0105002	3	0	0	10
1472	PALMAS	RE0103038	2	0	0	0
1473	PALMAS	RE0312026	2	0	0	0
1474	GRS	RE0201095	20	0	0	0
1475	SUPREMA	RE0103005	6	0	0	4
1476	SUPREMA	08-0295-02	0	0	1	0
1477	PALMAS	RE0304010	0	10	20	0
1478	PALMAS	MA0108019	0	0	0	100
1479	SUPREMA	RE0201015	0	0	0	100
1480	SUPREMA	MA0102100	0	2	0	0
1481	SAN ANTONIO	MA0202035	0	0	0	14
1482	PALMAS	RE0312007	2	0	0	0
1483	PALMAS	MA0104004	0	4	0	0
1484	METALMECANICA	RE0316007	12	0	0	0
1485	SAN JORGE	MA0103011	0	48	0	0
1486	SAN ANTONIO	MA0103011	0	48	0	0
1487	PALMAS	RE0306057	3	10	0	0
1488	SAN JORGE	MA0101017	24	0	0	0
1489	SAN ANTONIO	MA0101017	24	0	0	0
1490	PALMAS	RE0304051	0	5	0	0
1491	PALMAS	RE0306049	0	10	0	0
1492	SUPREMA	MA0102106	0	0	8	0
1493	SAN JORGE	MA0101022	24	0	0	0
1494	SAN ANTONIO	MA0101022	24	0	0	0
1495	SUPREMA	MA0102096	0	10	0	0
1496	SUPREMA	RE0316014	25	0	50	0
1497	GRS	RE0309022	0	0	0	10
1498	PALMAS	IN0106001	550	0	0	0
1499	SUPREMA	RE0302044	0	0	4	0
1500	PALMAS	RE0302073	2	0	0	0
1501	SUPREMA	MA0102097	0	6	3	0
1502	SUPREMA	RE0316012	20	0	50	0
1503	PALMAS	MA0108056	0	300	0	0
1504	SUPREMA	MA0107015	44	0	0	0
1505	PALMAS	RE0312006	2	0	0	0
1506	ALFA	MA0102069	1	0	0	0
1507	PALMAS	RE0309014	0	0	5	0
1508	GRS	RE0309030	40	0	0	0
1509	PALMAS	RE0302052	0	6	0	0
1510	SUPREMA	RE0101040	2	0	3	0
1511	SAN JORGE	MA0202009	1	0	0	0
1512	GRS	MA0106001	0	0	2	0
1513	ACACIAS	MA0108004	200	0	0	0
1514	SAN JORGE	MA0108004	200	0	0	0
1515	SUPREMA	RE0304045	0	0	0	200
1516	SAN ANTONIO	MA0102104	40	0	0	0
1517	PALMAS	MA0107024	31	0	0	0
1518	ALFA	MA0102042	299	0	0	0
1519	PALMAS	RE0310012	0	0	0	10
1520	SUPREMA	RE0101048	0	5	0	0
1521	PALMAS	RE0306052	0	5	20	0
1522	PALMAS	RE0314036	4	0	0	0
1523	PALMAS	RE0101094	0	0	2	4
1524	SUPREMA	RE0304009	35	0	0	0
1525	SAN FRANCISCO	MA0202025	0	0	35	0
1526	SAN ANTONIO	MA0202022	0	6	0	0
1527	SAN JORGE	MA0202022	0	6	0	0
1528	SUPREMA	MA0107013	0	33	0	0
1529	SUPREMA	MA0107014	0	33	0	0
1530	PALMAS	MA0102079	0	4	0	0
1531	SUPREMA	RE0201157	5	0	0	0
1532	SUPREMA	RE0304161	1	0	0	0
1533	SUPREMA	MA0103007	0	2	0	0
1534	PALMAS	RE0306056	0	0	12	0
1535	QUIRICA	RE0302001	12	0	0	0
1536	SAN FRANCISCO	MA0202017	2	0	0	0
1537	SAN JORGE	RE0302001	12	0	0	0
1538	SUPREMA	MA0108030	0	0	75	0
1539	PALMAS	RE0101090	0	0	2	4
1540	GRS	RE0201033	0	0	5	0
1541	SUPREMA	RE0201014	0	0	0	50
1542	GRS	RE0302014	0	2	0	0
1543	GRS	MA0108010	0	0	0	25
1544	SUPREMA	MA0109001	6	0	5	0
1545	SAN JORGE	IN0304003	0	0	0	1
1546	SUPREMA	RE0101014	2	2	0	0
1547	PALMAS	RE0308047	0	0	4	0
1548	SAN JORGE	MA0202004	0	0	0	6
1549	PALMAS	RE0308044	0	0	4	0
1550	SAN JORGE	MA0202035	0	0	0	10
1551	SAN JORGE	IN0301020	0	0	50	0
1552	PALMAS	MA0108045	5	10	0	0
1553	PALMAS	RE0304014	0	0	10	0
1554	SUPREMA	RE0101047	3	0	5	0
1555	PALMAS	RE0317003	0	2	0	0
1556	SUPREMA	RE0309016	0	0	0	9
1557	PALMAS	MA0102159	0	1	0	0
1558	SUPREMA	RE0317091	11	15	0	0
1559	SAN JORGE	MA0104015	200	0	0	0
1560	ACACIAS	MA0108001	200	0	0	0
1561	PALMAS	RE0306008	0	0	30	0
1562	SUPREMA	RE0201004	4	6	0	0
1563	ACACIAS	MA0202001	1	0	0	0
1564	SUPREMA	RE0201069	6	0	0	0
1565	PALMAS	RE0306055	0	10	0	0
1566	SUPREMA	RE0304162	1	0	0	0
1567	PALMAS	RE0101091	0	0	2	4
1568	PALMAS	RE0302040	0	0	14	0
1569	PALMAS	RE0308018	0	8	0	0
1570	SAN ANTONIO	MA0102068	45	0	0	0
1571	GRS	RE0310002	0	0	0	3
1572	PALMAS	RE0103014	4	0	0	0
1573	PALMAS	RE0302043	0	0	0	4
1574	ALFA	MA0104006	4	0	0	0
1575	SAN FRANCISCO	MA0101018	3	0	0	0
1576	SAN ANTONIO	MA0101018	3	0	0	0
1577	SAN JORGE	MA0101018	3	0	0	0
1578	SAN FRANCISCO	MA0101004	12	0	0	0
1579	ALFA	MA0102004	149	0	0	0
1580	PALMAS	RE0306068	0	10	0	0
1581	ALFA	RE0302001	8	0	0	0
1582	ALFA	MA0103011	24	0	0	0
1583	GRS	RE0309026	0	0	0	8
1584	SUPREMA	RE0317039	0	0	8	0
1585	SUPREMA	RE0316017	10	0	0	20
1586	PALMAS	MA0108036	0	0	0	1000
1587	SUPREMA	MA0107034	100	0	0	0
1588	PALMAS	RE0103040	0	20	0	0
1589	PALMAS	MA0105024	0	0	3	0
1590	PALMAS	RE0306023	0	4	0	0
1591	ACACIAS	RE0302001	10	0	0	0
1592	METALMECANICA	RE0316006	7	0	0	0
1593	SUPREMA	RE0302025	8	0	0	0
1594	SAN FRANCISCO	MA0102017	19	0	0	0
1595	SUPREMA	RE0302042	0	0	4	0
1596	PALMAS	RE0201039	0	0	5	0
1597	SUPREMA	MA0108022	40	0	0	0
1598	SAN FRANCISCO	MA0202022	0	4	0	0
1599	PALMAS	RE0303046	0	0	40	0
1600	SAN ANTONIO	IN0303001	0	0	0	4
1601	PALMAS	RE0306021	0	4	0	0
1602	SUPREMA	MA0102092	0	0	6	0
1603	SAN ANTONIO	MA0202032	1	0	0	2
1604	PALMAS	MA0108053	20	0	0	0
1605	PALMAS	RE0306040	0	0	8	0
1606	SAN JORGE	RE0308001	6	0	0	0
1607	SUPREMA	RE0201127	25	0	0	0
1608	GRS	RE0309045	0	3	0	0
1609	PALMAS	MA0102022	0	0	6	0
1610	SAN FRANCISCO	MA0202004	0	0	0	4
1611	SUPREMA	RE0304132	0	0	35	0
1612	SUPREMA	MA0108008	0	50	0	18
1613	PALMAS	RE0103041	0	10	0	0
1614	SAN FRANCISCO	MA0101022	12	0	0	0
1615	SAN FRANCISCO	IN0303001	0	0	0	4
1616	SUPREMA	RE0201144	30	0	0	0
1617	PALMAS	RE0201018	390	0	0	500
1618	QUIRICA	MA0202023	20	0	0	0
1619	ACACIAS	MA0202023	20	0	0	0
1620	SAN FRANCISCO	MA0202023	0	20	0	0
1621	SAN JORGE	MA0202023	0	20	0	0
1622	SUPREMA	MA0108016	0	0	0	46
1623	SUPREMA	RE0309007	0	15	0	8
1624	PALMAS	RE0306007	10	0	30	0
1625	PALMAS	RE0302031	0	0	8	0
1626	PALMAS	RE0307013	0	0	0	25
1627	PALMAS	RE0201058	0	0	10	0
1628	ACACIAS	MA0102067	2	0	0	0
1629	SUPREMA	MA0102099	0	4	0	0
1630	SAN FRANCISCO	MA0202035	0	0	0	6
1631	SUPREMA	MA0101021	0	0	2	0
1632	PALMAS	RE0306010	0	1	0	0
1633	SUPREMA	RE0201155	0	6	0	0
1634	SAN FRANCISCO	MA0104005	5	0	0	0
1635	SAN ANTONIO	MA0102109	6	0	0	0
1636	SAN FRANCISCO	IN0304001	0	0	0	3
1637	PALMAS	RE0302033	0	0	0	4
1638	ALFA	RE0310013	2	0	0	0
1639	GRS	MA0101008	0	0	0	4
1640	SUPREMA	RE0302029	0	0	2	0
1641	SAN ANTONIO	IN0304002	0	0	0	3.2
1642	GRS	IN0501004	0	2	0	0
1643	SAN JORGE	IN0303001	0	0	0	3
1644	GRS	RE0302006	0	4	0	0
1645	PALMAS	RE0302049	0	0	4	0
1646	PALMAS	MA0108064	0	0	0	200
1647	PALMAS	RE0312019	10	0	0	0
1648	SUPREMA	MA0109002	12	0	0	0
1649	SUPREMA	RE0308046	0	0	0	2
1650	SAN JORGE	MA0202032	1	0	0	1
1651	SAN FRANCISCO	MA0202032	1	0	0	1
1652	SUPREMA	RE0317012	0	2	0	0
1653	PALMAS	RE0302050	0	0	0	5
1654	SUPREMA	RE0316011	20	0	40	0
1655	SAN ANTONIO	MA0202005	1	0	0	0
1656	SAN FRANCISCO	MA0202005	1	0	0	0
1657	SAN JORGE	MA0202005	1	0	0	0
1658	PALMAS	RE0303035	0	0	48	0
1659	PALMAS	MA0102089	0	0	4	0
1660	SAN JORGE	IN0304002	0	0	0	3.2
1661	SUPREMA	MA0108013	0	0	0	35
1662	SUPREMA	RE0201066	2	2	0	0
1663	SUPREMA	MA0108020	40	0	0	84
1664	SUPREMA	RE0103010	12	0	0	0
1665	SUPREMA	RE0101004	0	0	2	0
1666	PALMAS	MA0101026	0	15	0	0
1667	SUPREMA	MA0108029	0	0	0	36
1668	GRS	MA0102024	0	0	0	20
1669	PALMAS	RE0302048	0	0	0	5
1670	SAN ANTONIO	IN0304001	0	0	0	2
1671	SUPREMA	MA0102113	0	0	4	0
1672	GRS	MA0101011	0	0	0	3
1673	GRS	MA0101007	0	0	0	3
1674	SUPREMA	RE0307002	100	0	0	0
1675	SUPREMA	RE0201038	25	0	0	0
1676	PALMAS	RE0302047	0	0	0	5
1677	SUPREMA	RE0307003	95	0	0	0
1678	PALMAS	RE0301008	0	3	0	0
1679	PALMAS	RE0314027	1	0	0	0
1680	PALMAS	RE0307015	0	0	0	25
1681	SUPREMA	MA0108003	0	0	0	66
1682	SAN JORGE	MA0108002	200	0	0	0
1683	PALMAS	RE0201061	2	0	0	0
1684	PALMAS	MA0108063	0	10	0	0
1685	PALMAS	RE0302041	0	4	0	0
1686	PALMAS	RE0302030	0	0	0	8
1687	GRS	RE0309091	0	0	0	12
1688	SUPREMA	MA0108012	0	0	0	33
1689	PALMAS	RE0306041	2	0	0	0
1690	SAN FRANCISCO	MA0101006	4	0	0	0
1691	SAN ANTONIO	MA0101006	4	0	0	0
1692	SAN JORGE	MA0101006	0	4	0	0
1693	GRS	IN0403016	150	0	0	0
1694	GRS	MA0102012	0	0	0	20
1695	GRS	RE0309081	0	0	0	17
1696	PALMAS	RE0303034	0	0	48	0
1697	SAN FRANCISCO	MA0102068	15	0	0	0
1698	SUPREMA	RE0302026	0	0	3	0
1699	ALFA	MA0102067	1	0	0	0
1700	PALMAS	RE0302100	0	4	0	0
1701	SUPREMA	RE0201061	0	0	0	15
1702	GRS	RE0309063	0	5	0	0
1703	PALMAS	RE0302032	0	0	0	4
1704	GRS	MA0102036	0	0	0	20
1705	SUPREMA	RE0309008	0	0	0	11
1706	GRS	MA0101012	0	0	0	2
1707	GRS	MA0108022	0	0	0	25
1708	SUPREMA	RE0201111	0	0	15	0
1709	ACACIAS	MA0102068	12	0	0	0
1710	SAN FRANCISCO	MA0103005	0	10	0	0
1711	SAN ANTONIO	MA0103005	0	10	0	0
1712	GRS	RE0309047	8	0	0	0
1713	PALMAS	MA0102019	0	0	6	0
1714	PALMAS	RE0306014	2	0	0	0
1715	SAN FRANCISCO	IN0304002	0	0	0	1.6
1716	SAN ANTONIO	MA0202018	2	0	0	0
1717	SAN JORGE	MA0202016	1	0	0	0
1718	SAN ANTONIO	MA0202016	1	0	0	0
1719	SAN FRANCISCO	MA0202016	1	0	0	0
1720	PALMAS	RE0103060	0	10	20	0
1721	PALMAS	MA0108038	0	0	0	200
1722	PALMAS	RE0302039	0	0	0	4
1723	SAN FRANCISCO	MA0104002	5	0	0	0
1724	PALMAS	MA0108059	0	25	0	0
1725	ALFA	MA0102037	9	0	0	0
1726	QUIRICA	MA0102068	10	0	0	0
1727	SUPREMA	RE0201041	10	0	0	0
1728	PALMAS	RE0306035	0	10	0	0
1729	SAN ANTONIO	MA0108006	0	0	16	0
1730	PALMAS	RE0303030	27	0	48	0
1731	PALMAS	RE0306034	0	5	0	0
1732	SAN FRANCISCO	MA0101024	4	0	0	0
1733	SAN JORGE	MA0101024	0	4	0	0
1734	SAN ANTONIO	MA0101024	4	0	0	0
1735	SUPREMA	MA0108045	20	0	0	14
1736	SAN JORGE	IN0304001	0	0	0	1
1737	PALMAS	MA0108061	0	25	0	0
1738	SUPREMA	MA0102023	0	0	10	0
1739	ACACIAS	MA0108002	100	0	0	0
1740	SUPREMA	RE0103015	0	0	20	0
1741	SUPREMA	RE0103016	0	0	20	0
1742	SUPREMA	RE0103017	0	0	20	0
1743	GRS	MA0102011	0	0	0	20
1744	ALFA	MA0202031	10	0	0	0
1745	SUPREMA	MA0108021	0	0	0	36
1746	PALMAS	RE0311013	2	0	0	0
1747	ALFA	MA0101029	5	0	0	0
1748	ACACIAS	MA0101029	0	5	0	0
1749	ACACIAS	MA0101021	1	0	0	0
1750	SUPREMA	RE0201037	5	0	0	0
1751	GRS	MA0102027	0	0	12	0
1752	PALMAS	MA0108060	0	25	0	0
1753	GRS	MA0102023	0	0	0	15
1754	SAN ANTONIO	MA0108007	0	0	2	0
1755	SUPREMA	RE0201143	16	0	0	0
1756	PALMAS	MA0108039	0	0	0	200
1757	SUPREMA	MA0103017	500	0	0	0
1758	SAN JORGE	MA0103005	0	5	0	0
1759	GRS	RE0309062	0	5	0	0
1760	SUPREMA	RE0316013	18	0	0	0
1761	PALMAS	MA0108006	8	0	0	0
1762	SUPREMA	RE0201039	6	0	0	0
1763	SAN FRANCISCO	MA0202018	1	0	0	0
1764	SAN JORGE	MA0202018	1	0	0	0
1765	ACACIAS	MA0101006	1	0	0	0
1766	GRS	MA0108013	0	0	0	25
1767	GRS	MA0102013	0	0	18	10
1768	SUPREMA	MA0108009	0	45	0	36
1769	SAN ANTONIO	MA0202031	6	0	0	0
1770	SUPREMA	RE0201122	100	0	0	100
1771	PALMAS	MA0108009	0	0	0	200
1772	PALMAS	RE0303033	0	0	48	0
1773	GRS	MA0108019	0	0	0	25
1774	ALFA	MA0101028	4	0	0	0
1775	SUPREMA	MA0108023	0	45	0	0
1776	GRS	MA0102022	0	0	20	0
1777	SAN ANTONIO	MA0202029	10	0	0	0
1778	SAN FRANCISCO	MA0202029	10	0	0	0
1779	SAN JORGE	MA0202029	10	0	0	0
1780	GRS	MA0101010	0	0	0	3
1781	GRS	MA0102017	0	0	0	5
1782	SAN ANTONIO	MA0102032	10	0	0	0
1783	PALMAS	MA0108010	0	0	0	200
1784	SAN JORGE	MA0202031	3	0	0	0
1785	SAN FRANCISCO	MA0202031	3	0	0	0
1786	GRS	MA0102005	0	0	0	10
1787	SUPREMA	MA0108035	0	15	20	0
1788	ALFA	MA0102033	9	0	0	0
1789	ALFA	MA0102006	4	0	0	0
1790	ALFA	MA0202028	10	0	0	0
1791	GRS	MA0102048	0	0	10	0
1792	SUPREMA	MA0102018	0	0	100	0
1793	SUPREMA	RE0303018	0	0	1	0
\.


--
-- Data for Name: cuentas_contables; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cuentas_contables (codigo, nombre) FROM stdin;
12100901	CONSTRUCCIONES EN PROCESO
71301301	GASTOS MEDICOS-GASTO
71301401	GASTOS DE VIAJE-GASTO
71301501	ALIMENTACION-GASTO
71301601	CAPACITACION A EMPLEADOS-GASTO
71301701	IMPLEMENTOS Y EQUIPO DE TRABAJO-GASTO
71301801	HONORARIOS PROFESIONALES LOCALES-GASTO
71301901	HONORARIOS PROFESIONALES DEL EXTERIOR-GASTO
71302001	SEGUROS PARA EMPLEADOS-GASTO
71302101	SERVICIOS PRESTADOS-GASTO
71302102	SERVICIOS DE MAQUILA-GASTO
71302201	ENERGIA ELECTRICA-GASTO
71302301	COMBUSTIBLES Y LUBRICANTES-GASTO
71302401	PAPELERIA Y UTILES-GASTO
71302501	TELEFONO-GASTO
71302502	INTERNET-GASTO
71302503	RADIOS-GASTO
71302601	SEGUROS Y FIANZAS-GASTO
71302701	SUSCRIPCIONES Y MEMBRESIAS-GASTO
71302803	REPARACION Y MANTENIMIENTO INSTALACIONES-GASTO
71302804	REPARACION Y MANTENIMIENTO MAQUINARIA Y EQUIPO-GASTO
71302805	REPARACION Y MANTENIMIENTO MOBILIARIO Y EQUIPO-GASTO
71302806	REPARACION Y MANTENIMIENTO EQUIPO DE COMPUTO-GASTO
71302807	REPARACION Y MANTENIMIENTO VEHICULOS-GASTO
71302808	REPARACION Y MANTENIMIENTO HERRAMIENTAS Y CRISTALERIA-GASTO
71303103	ARRENDAMIENTO INSTALACIONES-GASTO
71303104	ARRENDAMIENTO MAQUINARIA Y EQUIPO-GASTO
71303105	ARRENDAMIENTO MOBILIARIO Y EQUIPO-GASTO
71303106	ARRENDAMIENTO EQUIPO DE COMPUTO-GASTO
71303107	ARRENDAMIENTO VEHICULOS-GASTO
71303201	SEGURIDAD Y VIGILANCIA-GASTO
71303301	CORREOS Y MENSAJERIA-GASTO
71303401	FLETES Y ACARREOS-GASTO
71303501	PUBLICIDAD Y PROMOCIONES-GASTO
71303601	TASAS, IMPUESTOS Y CONTRIBUCIONES-GASTO
71303701	DONACIONES-GASTO
71303905	MOBILIARIO Y EQUIPO-GASTO
71303906	EQUIPO DE COMPUTO-GASTO
71303907	VEHICULOS-GASTO
71303908	HERRAMIENTAS Y CRISTALERIA-GASTO
71304001	INSUMOS-GASTO
71304101	ATENCION A EMPLEADOS-GASTO
71304201	UNIFORMES-GASTO
71304301	DIETAS-GASTO
71304401	REGALIAS-GASTO
71309802	SERVICIO DE MAQUILA-GASTO
13100202	CUOTAS PAGADAS ANTICIPADAS
61301501	ALIMENTACION-COSTO
91300101	MATERIALES E INSUMOS
91301701	IMPLEMENTOS Y EQUIPO DE TRABAJO
91302803	REPARACION Y MANTENIMIENTO INSTALACIONES
91302804	REPARACION Y MANTENIMIENTO MAQUINARIA Y EQUIPO
91303401	FLETES Y ACARREOS
91304001	INSUMOS
61300101	MATERIALES E INSUMOS-COSTO
61301301	GASTOS MEDICOS-COSTO
61301401	GASTOS DE VIAJE-COSTO
61301601	CAPACITACION A EMPLEADOS-COSTO
61301701	IMPLEMENTOS Y EQUIPO DE TRABAJO-COSTO
61301801	HONORARIOS PROFESIONALES LOCALES-COSTO
61301901	HONORARIOS PROFESIONALES DEL EXTERIOR-COSTO
61302001	SEGUROS PARA EMPLEADOS-COSTO
61302101	SERVICIOS PRESTADOS-COSTO
61302102	SERVICIOS DE MAQUILA-COSTO
61302201	ENERGIA ELECTRICA-COSTO
61302301	COMBUSTIBLES Y LUBRICANTES-COSTO
61302401	PAPELERIA Y UTILES-COSTO
61302501	TELEFONO-COSTO
61302502	INTERNET-COSTO
61302503	RADIOS-COSTO
61302601	SEGUROS Y FIANZAS-COSTO
61302701	SUSCRIPCIONES Y MEMBRESIAS-COSTO
61302801	REPARACION Y MANTENIMIENTO TERRENOS-COSTO
61302802	REPARACION Y MANTENIMIENTO EDIFICIOS-COSTO
61302803	REPARACION Y MANTENIMIENTO INSTALACIONES-COSTO
61302804	REPARACION Y MANTENIMIENTO MAQUINARIA Y EQUIPO-COSTO
61302805	REPARACION Y MANTENIMIENTO MOBILIARIO Y EQUIPO-COSTO
61302806	REPARACION Y MANTENIMIENTO EQUIPO DE COMPUTO-COSTO
61302807	REPARACION Y MANTENIMIENTO VEHICULOS-COSTO
61302808	REPARACION Y MANTENIMIENTO HERRAMIENTAS Y CRISTALERIA-COSTO
61302809	REPARACION Y MANTENIMIENTO PROPIEDADES AJENAS-COSTO
61302901	DEPRECIACION ACTIVOS BIOLOGICOS-COSTO
61303001	AMORTIZACION SOFTWARE-COSTO
61303101	ARRENDAMIENTO TERRENOS-COSTO
61303102	ARRENDAMIENTO EDIFICIOS-COSTO
61303103	ARRENDAMIENTO INSTALACIONES-COSTO
61303104	ARRENDAMIENTO MAQUINARIA Y EQUIPO-COSTO
61303105	ARRENDAMIENTO MOBILIARIO Y EQUIPO-COSTO
61303106	ARRENDAMIENTO EQUIPO DE COMPUTO-COSTO
61303107	ARRENDAMIENTO VEHICULOS-COSTO
61303201	SEGURIDAD Y VIGILANCIA-COSTO
61303301	CORREOS Y MENSAJERIA-COSTO
61303401	FLETES Y ACARREOS-COSTO
61303501	PUBLICIDAD Y PROMOCIONES-COSTO
61303601	TASAS, IMPUESTOS Y CONTRIBUCIONES-COSTO
61303701	DONACIONES-COSTO
61303904	MAQUINARIA Y EQUIPO-COSTO
61303905	MOBILIARIO Y EQUIPO-COSTO
61303906	EQUIPO DE COMPUTO-COSTO
61303907	VEHICULOS-COSTO
61303908	HERRAMIENTAS Y CRISTALERIA-COSTO
61304201	UNIFORMES-COSTO
61304401	REGALIAS-COSTO
61309401	VARIACION EN PRECIO-COSTO
61309501	MERMAS Y DESPERDICIOS-COSTO
61309502	MERMAS Y DESPERDICIOS ACEITES EMPACADOS-COSTO
61309503	MERMAS Y DESPERDICIOS MANTECAS-COSTO
61309504	MERMAS Y DESPERDICIOS MARGARINAS-COSTO
61309601	VARIACION PRODUCCION POSITIVO-COSTO
61309602	VARIACION PRODUCCION NEGATIVO-COSTO
61309701	REPROCESO PRODUCTOS TERMINADOS-COSTO
61309801	SUBPRODUCTO ACEITES Y GRASAS (ACIDOS GRASOS)-COSTO
61309901	REGULARIZACION GASTO DE FABRICACION A-COSTO
61309902	REGULARIZACION GASTO DE FABRICACION B-COSTO
61309903	REGULARIZACION GASTO DE FABRICACION MAQUILA-COSTO
71300201	SUELDOS Y SALARIOS ORDINARIOS-GASTO
71300301	SUELDOS Y SALARIOS EXTRAORDINARIOS-GASTO
71300401	BONIFICACION INCENTIVO-GASTO
71300501	OTRAS BONIFICACIONES-GASTO
71300601	COMISIONES SOBRE VENTAS-GASTO
71300701	CUOTA PATRONAL IGSS-GASTO
71300801	IRTRA E INTECAP-GASTO
71300901	AGUINALDO-GASTO
71301001	BONO 14-GASTO
71301101	VACACIONES-GASTO
71301201	INDEMNIZACIONES-GASTO
71301902	SERVICIOS PROFESIONALES DEL EXTERIOR-GASTO
71302801	REPARACION Y MANTENIMIENTO TERRENOS-GASTO
71302802	REPARACION Y MANTENIMIENTO EDIFICIOS-GASTO
71302902	DEPRECIACION EDIFICIOS-GASTO
71302903	DEPRECIACION INSTALACIONES-GASTO
71302904	DEPRECIACION MAQUINARIA Y EQUIPO-GASTO
71302905	DEPRECIACION MOBILIARIO Y EQUIPO-GASTO
71302906	DEPRECIACION EQUIPO DE COMPUTO-GASTO
71302907	DEPRECIACION VEHICULOS-GASTO
71302908	DEPRECIACION HERRAMIENTAS Y CRISTALERIA-GASTO
71302909	DEPRECIACION MEJORAS A PROPIEDADES AJENAS-GASTO
71302910	DEPRECIACION ACTIVOS BIOLOGICOS-GASTO
71303001	AMORTIZACION SOFTWARE-GASTO
71303002	AMORTIZACION LICENCIAS-GASTO
71303003	AMORTIZACION MARCAS Y PATENTES-GASTO
71303101	ARRENDAMIENTO TERRENOS-GASTO
71303102	ARRENDAMIENTO EDIFICIOS-GASTO
71303801	CUENTAS INCOBRABLES-GASTO
81100101	INTERESES PRODUCTO
81200101	GANANCIA EN DIFERENCIAL CAMBIARIO
81200201	GANANCIA EN VENTA DE ACTIVOS
81200301	DESCUENTOS RECIBIDOS
81200401	OTROS INGRESOS FINANCIEROS
82100101	INTERESES GASTO
82100201	COMISIONES BANCARIAS
82200101	PERDIDA EN DIFERENCIAL CAMBIARIO
82200201	PERDIDA EN VENTA DE ACTIVOS
82200301	DESCUENTOS CONCEDIDOS
82200401	GASTOS POR RENTAS DE CAPITAL
82200901	MULTAS Y MORAS
82200902	GASTOS DE EJERCICIOS ANTERIORES
82200903	CARGA DE SALDOS INICIALES
82200904	GASTOS DEL EJERCICIO
82200914	GASTOS DE VIAJE
89100101	CUENTA DE COMPENSACION DE CENTRO DE BENEFICIO
89100102	DIFERENCIA DE REDONDEO O TIPO DE CAMBIO GANANCIA
89100103	DIFERENCIA DE REDONDEO O TIPO DE CAMBIO PERDIDA
89100104	CUENTA RESUMEN DE RESULTADOS
89100105	CUENTAS DE CIERRE DE BALANCE
89100106	CUENTAS DE APERTURA DE BALANCE
\.


--
-- Data for Name: ejecucion_presupuesto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ejecucion_presupuesto (id, empresa, categoria, periodo, ejecutado) FROM stdin;
1	SUPREMA	Repuestos y componentes mecánicos	T4-2026	200000
2	PALMAS	Combustibles y lubricantes	T4-2026	3390000
\.


--
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.empresas (codigo, nombre_anexo, company_db, activo) FROM stdin;
PALMAS	Las Palmas, S.A.	SBO_PALMAS	t
ACACIAS	Acacias, S.A.	SBO_ACACIAS	t
ALFA	Alfa, S.A.	SBO_ALFA	t
QUIRICA	Quirica, S.A.	SBO_QUIRICA	t
SAN ANTONIO	San Antonio, S.A.	SBO_SAN_ANTONIO	t
SAN FRANCISCO	San Francisco, S.A.	SBO_SAN_FRANCISCO	t
SAN JORGE	San Jorge Los Magueyes, S.A.	SBO_SAN_JORGE	t
TASINSA	Tasinsa	SBO_TASINSA	t
METALMECANICA	Metalmecanica	SBO_METALMECANICA	t
GRS	Ganaderia Rio Seco	SBO_GRS	t
GABIOSA	Gas Biologico	SBO_GABIOSA	t
SUPREMA	Suprema, S.A.	SBO_SUPREMA	t
\.


--
-- Data for Name: existencias; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.existencias (id, empresa, item_code, existencia, en_pedido, comprometido) FROM stdin;
1	PALMAS	MP0201005	6100074	0	0
2	SUPREMA	MP0201002	1848953	0	0
3	TASINSA	PT49400000501	773573	0	0
4	PALMAS	MA0105017	33268	36600	3327
5	SUPREMA	IN0103005	1029	0	103
6	SUPREMA	IN0103018	384	0	0
7	SUPREMA	IN0103008	366	0	37
8	SUPREMA	IN0103032	693	0	0
9	PALMAS	MP0201009	200417	86250	0
10	SUPREMA	MA0105010	3727	8700	0
11	SUPREMA	IN0102035	55	40	0
12	SUPREMA	IN0106012	1713	0	171
13	SUPREMA	IN0102076	20	0	0
14	SUPREMA	IN0103019	10100	0	0
15	PALMAS	IN0102020	76	43	8
16	SUPREMA	IN0102078	15	0	0
17	PALMAS	IN0202043	1288	0	0
18	PALMAS	IN0202004	3688	0	0
19	PALMAS	IN0202072	3703	0	370
20	SUPREMA	IN0106010	285	0	0
21	SUPREMA	IN0201036	14267	10395	0
22	SUPREMA	IN0101003	90	0	9
23	GRS	IN0101009	3118921	0	0
24	SUPREMA	IN0106023	427	0	0
25	SUPREMA	IN0102069	23	0	2
26	SUPREMA	IN0105006	4852	0	485
27	SUPREMA	IN0102075	18	0	2
28	SUPREMA	IN0102074	9	11	0
29	SUPREMA	IN0102026	9	5	0
30	SUPREMA	IN0102034	20	0	0
31	PALMAS	MA0105007	1800	0	0
32	SUPREMA	IN0106002	88557	0	0
33	SUPREMA	MA0105019	1116	0	0
34	PALMAS	IN0102021	15	10	0
35	PALMAS	MA0105018	1140	675	0
36	SUPREMA	IN0102060	10	0	1
37	SUPREMA	IN0101004	13	0	1
38	SUPREMA	IN0201037	2874	0	0
39	SUPREMA	IN0102070	17	0	0
40	GRS	IN0101010	22181	0	0
41	GRS	IN0502001	130	0	0
42	SUPREMA	IN0105002	212	0	0
43	PALMAS	IN0102003	15	0	0
44	SUPREMA	IN0102068	2	0	0
45	PALMAS	MA0104077	11	0	0
46	PALMAS	IN0202001	518	0	0
47	PALMAS	MA0105019	682	376	0
48	SUPREMA	IN0102066	2	2	0
49	PALMAS	MA0107016	462	0	0
50	PALMAS	IN0202020	221	0	0
51	PALMAS	MA0107011	5641	2554	0
52	PALMAS	MA0107017	1466	0	0
53	PALMAS	MA0107005	3257	0	0
54	PALMAS	MA0107019	23	0	2
55	PALMAS	IN0105002	1032	0	0
56	PALMAS	IN0105004	237	0	24
57	PALMAS	MA0101022	37	0	4
58	PALMAS	RE0304036	125	0	0
59	PALMAS	MA0107020	14	4	0
60	PALMAS	RE0316007	95	0	10
61	PALMAS	MA0107015	134	0	13
62	PALMAS	RE0201020	41	0	4
63	PALMAS	IN0104001	7097	0	710
64	PALMAS	MA0108011	291	0	29
65	SUPREMA	RE0302028	16	0	0
66	TASINSA	PT49400000502	1035566	749894	0
67	SUPREMA	PT09251005108	303808	0	30381
68	SUPREMA	IN0103006	1327	0	133
69	SUPREMA	IN0103003	120757	0	12076
70	SUPREMA	IN0103027	342	0	34
71	SUPREMA	IN0103037	24109	0	0
72	SUPREMA	IN0201016	46931	0	0
73	SUPREMA	IN0103034	291	0	0
74	SAN ANTONIO	IN0305005	2452	0	0
75	SAN ANTONIO	IN0305009	3331	0	0
76	SUPREMA	IN0103033	263	66	0
77	PALMAS	IN0202056	4775	0	0
78	SUPREMA	IN0103038	7795	3375	0
79	PALMAS	IN0202019	4828	0	0
80	SAN ANTONIO	IN0305007	920	0	0
81	PALMAS	IN0202085	1019	225	0
82	SUPREMA	IN0103004	56	0	6
83	SUPREMA	IN0103047	24123	0	0
84	SUPREMA	IN0102077	400	0	0
85	SUPREMA	IN0201026	361	0	0
86	PALMAS	IN0202081	1608	375	0
87	SAN ANTONIO	IN0305006	1320	0	132
88	SUPREMA	IN0201003	1912	405	191
89	PALMAS	IN0202086	1326	0	133
90	SUPREMA	IN0201014	324	104	0
91	SUPREMA	IN0201001	21000	0	0
92	SUPREMA	IN0103040	195	0	20
93	SUPREMA	IN0103043	9792	1488	0
94	SUPREMA	IN0103042	11083	0	1108
95	PALMAS	IN0202083	1537	0	154
96	SUPREMA	IN0104019	71	0	0
97	PALMAS	IN0202069	160	128	16
98	PALMAS	IN0202048	7523	4158	752
99	SUPREMA	IN0102036	11	0	0
100	SUPREMA	IN0106019	230	0	0
101	SUPREMA	MA0106038	51	0	0
102	PALMAS	RE0302019	6	0	0
103	PALMAS	IN0202068	91	0	0
104	SUPREMA	IN0102079	2	0	0
105	PALMAS	IN0202009	138	0	0
106	PALMAS	IN0105006	27687	3750	0
107	SUPREMA	IN0104020	90	0	0
108	SUPREMA	IN0102085	7	1	1
109	SUPREMA	IN0201012	72	30	7
110	SUPREMA	IN0106003	45936	0	0
111	PALMAS	RE0302016	2	0	0
112	PALMAS	IN0202033	1515	0	152
113	PALMAS	IN0202007	2002	0	200
114	SUPREMA	MA0110008	5638	555	0
115	PALMAS	RE0302018	4	0	0
116	SUPREMA	RE0317097	99	0	0
117	PALMAS	RE0101087	33	0	0
118	SUPREMA	IN0106024	34917	0	3492
119	SUPREMA	IN0102080	3	0	0
120	PALMAS	RE0101084	14	0	0
121	SUPREMA	IN0102082	6	0	1
122	SUPREMA	RE0317094	448	0	0
123	PALMAS	IN0202010	182	38	18
124	PALMAS	RE0302015	1	0	0
125	PALMAS	RE0302013	6	0	0
126	SUPREMA	RE0304150	286	0	29
127	SUPREMA	IN0201018	64	16	6
128	PALMAS	RE0101086	29	0	0
129	PALMAS	MA0105009	62	39	0
130	PALMAS	MA0110007	13	0	0
131	PALMAS	MA0104028	4	0	0
132	PALMAS	IN0202011	12	0	0
133	SUPREMA	IN0106011	26884	9855	2688
134	PALMAS	MA0110008	16	9	0
135	PALMAS	MA0105027	63	18	6
136	PALMAS	IN0202070	14221	3062	0
137	PALMAS	IN0102001	3	0	0
138	PALMAS	RE0101088	25	0	0
139	PALMAS	RE0302014	1	0	0
140	PALMAS	RE0101079	15	9	0
141	SUPREMA	RE0317095	44	8	0
142	PALMAS	MA0104025	3	0	0
143	PALMAS	IN0202050	539	191	0
144	PALMAS	MA0105011	70	0	0
145	SUPREMA	MA0105008	133	0	0
146	PALMAS	RE0101078	18	4	0
147	SUPREMA	IN0102064	1	0	0
148	SUPREMA	RE0301029	2	0	0
149	PALMAS	MA0105013	56	0	0
150	PALMAS	RE0302096	3	0	0
151	PALMAS	MA0105016	14	0	0
152	PALMAS	MA0104027	3	1	0
153	SUPREMA	MA0110014	96	14	0
154	PALMAS	RE0306006	130	0	0
155	PALMAS	RE0101081	22	0	0
156	PALMAS	RE0306013	72	0	7
157	PALMAS	RE0201035	17	0	0
158	PALMAS	RE0101080	21	0	0
159	PALMAS	RE0101085	8	0	1
160	SUPREMA	IN0102072	3	0	0
161	PALMAS	RE0103025	6	0	1
162	SUPREMA	IN0102065	4	0	0
163	SUPREMA	IN0102084	3	0	0
164	PALMAS	RE0103078	8	0	0
165	SUPREMA	RE0102014	6	0	0
166	PALMAS	RE0201019	17	11	2
167	SUPREMA	RE0317143	10	0	0
168	SUPREMA	IN0102006	1	0	0
169	PALMAS	MA0105020	14	12	0
170	PALMAS	MA0104018	9	0	0
171	PALMAS	RE0101077	5	4	0
172	PALMAS	RE0103068	15	0	0
173	PALMAS	MA0104066	2	0	0
174	PALMAS	RE0304017	43	19	0
175	PALMAS	RE0103079	5	0	0
176	PALMAS	MA0108015	107	0	11
177	PALMAS	MA0105023	15	0	0
178	PALMAS	RE0304043	109	0	0
179	PALMAS	MA0105003	15	0	0
180	PALMAS	RE0306039	17	0	0
181	PALMAS	RE0304042	73	0	7
182	SUPREMA	MA0102082	4	0	0
183	PALMAS	MA0104078	11	0	1
184	SUPREMA	RE0102015	2	0	0
185	PALMAS	MA0105012	59	10	6
186	SUPREMA	IN0201005	3	0	0
187	PALMAS	MA0104015	4	0	0
188	SUPREMA	MA0105022	24	0	0
189	SUPREMA	MA0105021	23	0	2
190	PALMAS	RE0304059	5	0	0
191	PALMAS	MA0105006	6	0	0
192	PALMAS	RE0309015	77	0	8
193	SUPREMA	MA0110007	2	0	0
194	SUPREMA	RE0302047	10	2	0
195	SUPREMA	RE0302007	5	0	0
196	PALMAS	RE0201002	17	0	2
197	PALMAS	RE0316001	37	0	0
198	SUPREMA	IN0105001	178	0	18
199	PALMAS	RE0316006	84	0	8
200	PALMAS	RE0308049	4	0	0
201	SUPREMA	MA0105006	16	0	0
202	PALMAS	MA0105022	11	3	0
203	PALMAS	RE0309013	4	0	0
204	SUPREMA	IN0201022	36	0	4
205	PALMAS	MA0108055	13	0	1
206	PALMAS	RE0304019	82	15	0
207	SUPREMA	RE0101025	1	0	0
208	SAN JORGE	IN0302004	20	0	0
209	SUPREMA	MA0107046	3	0	0
210	SUPREMA	IN0201006	3	2	0
211	PALMAS	RE0304018	47	0	0
212	PALMAS	MA0110004	537	371	0
213	SUPREMA	MA0105005	15	3	0
214	SUPREMA	RE0316007	91	0	0
215	SAN ANTONIO	IN0302004	17	0	2
216	PALMAS	RE0306053	7	2	0
217	SAN JORGE	IN0302006	5	0	0
218	PALMAS	RE0302084	4	0	0
219	SUPREMA	RE0310010	22	0	0
220	PALMAS	IN0105003	60	0	0
221	SUPREMA	RE0302046	6	0	0
222	SUPREMA	IN0201004	16	0	2
223	SUPREMA	MA0105011	1	0	0
224	SAN FRANCISCO	IN0301020	84	34	0
225	PALMAS	MA0108048	51	0	5
226	SUPREMA	RE0101024	4	0	0
227	PALMAS	RE0308008	9	0	0
228	SAN FRANCISCO	IN0302004	11	0	0
229	PALMAS	MA0108021	37	0	4
230	PALMAS	RE0201117	14	0	0
231	PALMAS	MA0108047	65	0	0
232	SAN ANTONIO	IN0301017	10	3	0
233	PALMAS	MA0108012	27	0	0
234	PALMAS	MA0108026	341	0	0
235	PALMAS	MA0107008	19	6	2
236	PALMAS	RE0304045	22	0	0
237	PALMAS	RE0103059	24	0	0
238	SUPREMA	RE0308014	9	0	0
239	SUPREMA	RE0201023	83	0	0
240	SAN FRANCISCO	IN0302005	8	0	0
241	PALMAS	RE0102010	13	0	0
242	PALMAS	RE0306050	5	2	0
243	PALMAS	RE0102012	13	0	0
244	SUPREMA	RE0101054	4	0	0
245	SUPREMA	RE0201125	21	0	2
246	SUPREMA	MA0102105	5	2	0
247	PALMAS	RE0310014	27	0	0
248	PALMAS	RE0306020	9	0	0
249	SUPREMA	RE0309002	11	0	0
250	PALMAS	MA0108017	17	0	0
251	SUPREMA	RE0304151	2	0	0
252	SUPREMA	RE0304003	14	0	0
253	PALMAS	RE0304053	8	0	0
254	PALMAS	RE0314019	6	0	0
255	SUPREMA	MA0109003	3	0	0
256	SUPREMA	MA0102102	1	0	0
257	SUPREMA	RE0309001	10	0	1
258	PALMAS	MA0108023	208	0	0
259	PALMAS	RE0306042	2	0	0
260	PALMAS	MA0109001	3	0	0
261	PALMAS	MA0109002	18	0	2
262	PALMAS	MA0108052	204	0	20
263	PALMAS	RE0306024	6	1	0
264	SUPREMA	RE0304131	4	4	0
265	PALMAS	RE0306017	6	0	0
266	PALMAS	RE0306048	2	0	0
267	SUPREMA	MA0108005	42	0	0
268	PALMAS	RE0316009	21	0	0
269	PALMAS	RE0306059	1	0	0
270	SUPREMA	RE0309003	23	0	2
271	PALMAS	MA0108022	99	0	10
272	SUPREMA	RE0316002	12	0	1
273	PALMAS	RE0103030	2	0	0
274	SUPREMA	MA0108042	21	0	2
275	SUPREMA	RE0316018	7	0	1
276	SUPREMA	RE0201067	4	1	0
277	PALMAS	RE0302042	6	0	1
278	PALMAS	RE0201041	7	0	1
279	PALMAS	MA0108016	180	0	18
280	PALMAS	RE0306016	1	0	0
281	SUPREMA	RE0201068	1	1	0
282	PALMAS	RE0102014	11	0	0
283	SUPREMA	MA0102017	160	0	0
284	SUPREMA	MA0110001	17	3	0
285	PALMAS	MA0102111	3	0	0
286	PALMAS	MA0108030	112	0	0
287	PALMAS	RE0302085	5	0	0
288	PALMAS	MA0108024	92	0	0
289	SUPREMA	MA0108019	49	0	5
290	PALMAS	RE0304008	57	9	0
291	SUPREMA	MA0108041	33	0	3
292	PALMAS	RE0201129	196	0	0
293	PALMAS	RE0306036	2	0	0
294	SUPREMA	MA0108039	8	0	1
295	SUPREMA	MA0102019	115	0	0
296	SUPREMA	MA0108040	18	0	0
297	SUPREMA	MA0108015	32	0	0
298	PALMAS	PT09211001101	0	0	0
299	ACACIAS	IN0305008	1974	0	0
300	QUIRICA	IN0305006	768	0	0
301	QUIRICA	IN0305008	2101	0	0
302	SAN ANTONIO	IN0305017	0	0	0
303	ACACIAS	IN0305007	536	250	0
304	ACACIAS	IN0305021	0	0	0
305	SAN JORGE	IN0305005	1500	0	0
306	QUIRICA	IN0305020	0	0	0
307	QUIRICA	IN0305005	0	0	0
308	ALFA	IN0305006	0	0	0
309	PALMAS	04-0743-01	0	0	0
310	ACACIAS	IN0305006	0	0	0
311	SAN JORGE	IN0305006	418	0	0
312	SAN ANTONIO	07-0010-05	0	0	0
313	ALFA	IN0305005	542	0	0
314	QUIRICA	IN0305007	1218	0	122
315	SUPREMA	IN0103041	48	0	5
316	SAN JORGE	IN0305017	0	0	0
317	ALFA	IN0305022	0	0	0
318	ACACIAS	IN0305020	0	0	0
319	ALFA	IN0305008	1475	0	148
320	ACACIAS	IN0305005	371	0	0
321	ALFA	IN0305009	170	0	17
322	PALMAS	07-0139-01	0	0	0
323	QUIRICA	IN0305019	128	0	0
324	GRS	MA0109002	126	11	0
325	QUIRICA	IN0305021	0	0	0
326	PALMAS	07-0131-01	0	0	0
327	QUIRICA	IN0305009	0	0	0
328	SUPREMA	07-0092-02	0	0	0
329	PALMAS	RE0317020	32	0	0
330	SUPREMA	IN0103049	0	0	0
331	SAN ANTONIO	IN0305021	0	0	0
332	PALMAS	RE0314044	0	0	0
333	SAN FRANCISCO	IN0305009	200	0	0
334	SAN JORGE	IN0305014	460	76	46
335	ALFA	IN0305021	0	0	0
336	PALMAS	IN0202082	0	0	0
337	SAN JORGE	IN0305008	0	0	0
338	SUPREMA	07-0093-02	0	0	0
339	SAN ANTONIO	IN0305008	818	0	0
340	SAN FRANCISCO	IN0305005	484	0	0
341	SAN ANTONIO	IN0305016	163	0	16
342	SUPREMA	IN0103025	65	5	6
343	SUPREMA	IN0103024	56	0	0
344	SUPREMA	IN0103050	0	0	0
345	QUIRICA	IN0305016	0	0	0
346	SAN ANTONIO	IN0305018	0	0	0
347	SAN ANTONIO	IN0305020	0	0	0
348	PALMAS	IN0202024	0	0	0
349	ALFA	IN0305007	262	0	0
350	SAN FRANCISCO	IN0305004	392	57	0
351	SAN JORGE	IN0305007	0	0	0
352	ALFA	IN0305016	0	0	0
353	ALFA	IN0305014	189	0	0
354	SAN FRANCISCO	IN0305006	0	0	0
355	PALMAS	RE0311014	0	0	0
356	SAN JORGE	IN0305021	0	0	0
357	SAN JORGE	IN0305009	136	0	0
358	SAN ANTONIO	IN0305004	24	0	0
359	PALMAS	RE0317024	25	0	2
360	QUIRICA	IN0305004	0	0	0
361	SAN FRANCISCO	IN0305008	0	0	0
362	PALMAS	RE0317022	0	0	0
363	SUPREMA	IN0103045	30	0	3
364	SAN FRANCISCO	IN0305017	0	0	0
365	ALFA	IN0305003	0	0	0
366	PALMAS	IN0101053	82	24	8
367	PALMAS	RE0317021	19	0	0
368	PALMAS	RE0302106	1	0	0
369	SAN FRANCISCO	IN0305013	0	0	0
370	SUPREMA	RE0301015	0	0	0
371	PALMAS	IN0101046	89	22	9
372	PALMAS	IN0101043	0	0	0
373	PALMAS	IN0101044	0	0	0
374	SAN ANTONIO	IN0305019	79	0	0
375	PALMAS	IN0101047	0	0	0
376	SAN FRANCISCO	IN0305003	198	0	20
377	GRS	RE0109001	0	0	0
378	SUPREMA	04-0415-02	0	0	0
379	SUPREMA	04-0410-02	0	0	0
380	ALFA	IN0305020	0	0	0
381	ALFA	IN0305018	0	0	0
382	PALMAS	04-0749-01	0	0	0
383	PALMAS	RE0314042	0	0	0
384	SUPREMA	MA0106039	0	0	0
385	ALFA	IN0305023	0	0	0
386	SAN JORGE	IN0305018	0	0	0
387	SUPREMA	IN0103051	0	0	0
388	ACACIAS	IN0201001	0	0	0
389	ACACIAS	IN0305022	0	0	0
390	PALMAS	07-0137-01	0	0	0
391	SUPREMA	RE0102005	28	0	0
392	PALMAS	RE0314028	0	0	0
393	PALMAS	RE0314008	0	0	0
394	SAN JORGE	IN0305023	0	0	0
395	ACACIAS	IN0305009	0	0	0
396	PALMAS	RE0317092	1	0	0
397	SUPREMA	RE0317099	61	0	6
398	PALMAS	04-0687-01	0	0	0
399	SAN ANTONIO	IN0305022	0	0	0
400	SUPREMA	IN0103046	0	0	0
401	PALMAS	RE0311018	0	0	0
402	PALMAS	RE0303008	118	0	12
403	PALMAS	RE0317100	0	0	0
404	PALMAS	RE0314014	0	0	0
405	QUIRICA	IN0305022	0	0	0
406	PALMAS	IN0202023	1139	300	0
407	SUPREMA	RE0201216	0	0	0
408	PALMAS	IN0202089	62	0	0
409	PALMAS	RE0302004	2	0	0
410	PALMAS	04-0750-01	0	0	0
411	SAN JORGE	IN0303008	12	0	0
412	PALMAS	IN0101045	0	0	0
413	SUPREMA	RE0302095	0	0	0
414	SAN ANTONIO	IN0305013	0	0	0
415	GRS	07-0001-10	0	0	0
416	PALMAS	RE0314010	0	0	0
417	SAN FRANCISCO	IN0305021	39	0	0
418	ACACIAS	IN0305023	0	0	0
419	PALMAS	04-0751-01	0	0	0
420	PALMAS	RE0311026	0	0	0
421	QUIRICA	IN0303008	0	0	0
422	SUPREMA	RE0302096	0	0	0
423	ACACIAS	IN0303010	0	0	0
424	SAN JORGE	IN0303010	0	0	0
425	QUIRICA	IN0305013	31	0	0
426	SUPREMA	IN0102086	0	0	0
427	SUPREMA	IN0105008	149	0	15
428	PALMAS	RE0314018	1	0	0
429	PALMAS	MA0105014	26	0	0
430	SUPREMA	04-0417-02	0	0	0
431	SUPREMA	RE0304095	89	0	0
432	PALMAS	RE0201001	0	0	0
433	SUPREMA	RE0317244	0	0	0
434	ACACIAS	IN0305014	0	0	0
435	SUPREMA	RE0317239	0	0	0
436	PALMAS	RE0314007	0	0	0
437	SAN JORGE	MA0101026	89	0	0
438	PALMAS	RE0317102	0	0	0
439	PALMAS	RE0317101	1	0	0
440	PALMAS	RE0314053	0	0	0
441	SUPREMA	RE0304058	5	0	0
442	PALMAS	RE0317025	7	0	1
443	PALMAS	RE0314025	0	0	0
444	PALMAS	RE0317099	0	0	0
445	PALMAS	IN0202022	0	0	0
446	PALMAS	IN0101048	0	0	0
447	PALMAS	IN0101039	0	0	0
448	SUPREMA	MA0106019	54	0	0
449	PALMAS	RE0313072	0	0	0
450	SUPREMA	IN0106001	16	0	0
451	PALMAS	RE0302095	0	0	0
452	PALMAS	IN0101051	0	0	0
453	SUPREMA	MA0110015	111	12	0
454	SUPREMA	RE0317242	0	0	0
455	SUPREMA	RE0201197	9	0	0
456	PALMAS	RE0312028	0	0	0
457	SUPREMA	IN0103044	0	0	0
458	SUPREMA	IN0201028	0	0	0
459	SUPREMA	MA0106043	0	0	0
460	PALMAS	RE0314033	0	0	0
461	PALMAS	IN0101049	15	0	0
462	PALMAS	IN0101052	0	0	0
463	SUPREMA	RE0317037	0	0	0
464	SUPREMA	MA0106027	0	0	0
465	SUPREMA	RE0304089	0	0	0
466	SAN ANTONIO	MA0101026	66	0	0
467	PALMAS	RE0302006	5	0	0
468	QUIRICA	MA0101026	38	0	4
469	SAN FRANCISCO	MA0101026	122	0	12
470	SUPREMA	RE0304152	0	0	0
471	SUPREMA	RE0317087	2	0	0
472	SUPREMA	RE0306010	0	0	0
473	SAN JORGE	03-0016-04	0	0	0
474	PALMAS	RE0314009	0	0	0
475	SAN ANTONIO	IN0301005	107	60	11
476	SUPREMA	RE0304046	547	0	0
477	PALMAS	06-0444-01	0	0	0
478	METALMECANICA	AV10110010114	0	0	0
479	SUPREMA	IN0106005	61	5	0
480	SUPREMA	IN0106013	16	0	0
481	PALMAS	RE0302108	3	0	0
482	PALMAS	IN0202016	34	9	0
483	PALMAS	RE0302109	3	0	0
484	SUPREMA	IN0106030	0	0	0
485	SUPREMA	IN0102041	0	0	0
486	PALMAS	RE0302091	0	0	0
487	PALMAS	MA0102115	0	0	0
488	TASINSA	RE0309159	0	0	0
489	SAN JORGE	IN0301005	142	0	0
490	PALMAS	RE0314047	0	0	0
491	PALMAS	08-0091-01	0	0	0
492	PALMAS	MA0107027	0	0	0
493	SUPREMA	RE0304061	16	2	0
494	SUPREMA	RE0317194	0	0	0
495	ACACIAS	MA0102069	0	0	0
496	PALMAS	RE0312025	0	0	0
497	PALMAS	RE0311006	0	0	0
498	PALMAS	RE0314041	0	0	0
499	SUPREMA	RE0304088	1	0	0
500	PALMAS	04-0733-01	0	0	0
501	SUPREMA	MA0110005	1135	0	114
502	PALMAS	RE0314017	0	0	0
503	PALMAS	MA0105026	0	0	0
504	SUPREMA	MA0110011	0	0	0
505	PALMAS	RE0312023	0	0	0
506	SUPREMA	05-0574-02	0	0	0
507	SUPREMA	IN0102081	1	0	0
508	SUPREMA	04-0398-02	0	0	0
509	PALMAS	RE0302107	0	0	0
510	PALMAS	RE0314023	0	0	0
511	PALMAS	RE0311028	0	0	0
512	PALMAS	RE0314046	0	0	0
513	PALMAS	RE0313073	0	0	0
514	GRS	IN0402003	224	0	22
515	QUIRICA	04-0018-07	0	0	0
516	ACACIAS	04-0132-03	0	0	0
517	QUIRICA	04-0017-07	0	0	0
518	PALMAS	RE0311027	1	0	0
519	ACACIAS	IN0305016	1	0	0
520	PALMAS	RE0314043	0	0	0
521	PALMAS	04-0711-01	0	0	0
522	SUPREMA	IN0102087	2	0	0
523	GRS	07-0002-10	0	0	0
524	PALMAS	RE0314011	1	0	0
525	PALMAS	04-0735-01	0	0	0
526	SAN ANTONIO	05-0042-05	0	0	0
527	PALMAS	RE0311021	1	0	0
528	PALMAS	MA0104029	0	0	0
529	PALMAS	RE0302003	0	0	0
530	PALMAS	04-0734-01	0	0	0
531	SUPREMA	IN0102089	1	0	0
532	PALMAS	RE0312027	0	0	0
533	PALMAS	RE0314012	3	0	0
534	SUPREMA	IN0102091	0	0	0
535	METALMECANICA	AV10110010113	0	0	0
536	SUPREMA	RE0317053	0	0	0
537	SUPREMA	IN0104022	0	0	0
538	PALMAS	04-0732-01	0	0	0
539	ACACIAS	MA0101026	21	0	0
540	SAN ANTONIO	IN0303010	7	0	0
541	PALMAS	RE0317094	0	0	0
542	PALMAS	RE0312013	0	0	0
543	PALMAS	06-0437-01	0	0	0
544	GRS	RE0309006	1	0	0
545	SAN JORGE	MA0104021	1	0	0
546	ALFA	MA0101026	0	0	0
547	ACACIAS	IN0301001	0	0	0
548	SUPREMA	06-0519-02	0	0	0
549	SAN FRANCISCO	IN0305023	0	0	0
550	PALMAS	RE0102026	0	0	0
551	SUPREMA	06-0582-02	0	0	0
552	PALMAS	06-0470-01	0	0	0
553	PALMAS	06-0477-01	0	0	0
554	PALMAS	06-0474-01	0	0	0
555	PALMAS	06-0471-01	0	0	0
556	SUPREMA	06-0581-02	0	0	0
557	PALMAS	06-0452-01	0	0	0
558	PALMAS	06-0472-01	0	0	0
559	PALMAS	06-0469-01	0	0	0
560	PALMAS	06-0473-01	0	0	0
561	PALMAS	06-0451-01	0	0	0
562	PALMAS	RE0312014	0	0	0
563	SUPREMA	RE0317243	0	0	0
564	SUPREMA	RE0317064	0	0	0
565	SUPREMA	IN0106031	522	0	0
566	PALMAS	RE0317098	0	0	0
567	PALMAS	RE0311004	12	0	0
568	PALMAS	05-0560-01	0	0	0
569	PALMAS	MA0102116	5	0	0
570	PALMAS	07-0135-01	0	0	0
571	QUIRICA	IN0301023	0	0	0
572	ACACIAS	IN0301023	70	0	0
573	ALFA	IN0301023	0	0	0
574	ACACIAS	IN0305003	0	0	0
575	PALMAS	06-0484-01	0	0	0
576	SUPREMA	IN0105009	11	0	0
577	SUPREMA	MA0110020	0	0	0
578	QUIRICA	MA0102069	0	0	0
579	PALMAS	RE0311017	0	0	0
580	SUPREMA	MA0110010	0	0	0
581	SUPREMA	08-0294-02	0	0	0
582	PALMAS	RE0317103	0	0	0
583	SUPREMA	RE0317187	0	0	0
584	PALMAS	MA0104065	5	1	0
585	SUPREMA	08-0298-02	0	0	0
586	PALMAS	RE0201115	11	0	1
587	PALMAS	RE0317028	0	0	0
588	GRS	06-0045-10	0	0	0
589	PALMAS	RE0317027	0	0	0
590	SUPREMA	IN0102088	0	0	0
591	SAN JORGE	MA0104020	0	0	0
592	SUPREMA	05-0554-02	0	0	0
593	SUPREMA	05-0546-02	0	0	0
594	SUPREMA	RE0317093	138	0	0
595	PALMAS	IN0102019	0	0	0
596	PALMAS	MA0102101	0	0	0
597	PALMAS	RE0302083	7	0	0
598	PALMAS	MA0104090	0	0	0
599	SUPREMA	MA0110018	0	0	0
600	PALMAS	08-0197-01	0	0	0
601	SAN JORGE	IN0302008	0	0	0
602	ACACIAS	MA0105003	16	0	0
603	PALMAS	05-0570-01	0	0	0
604	PALMAS	07-0141-01	0	0	0
605	SAN ANTONIO	MA0105003	0	0	0
606	PALMAS	RE0317097	0	0	0
607	SUPREMA	04-0419-02	0	0	0
608	SUPREMA	RE0302010	0	0	0
609	SUPREMA	RE0201032	69	0	0
610	GRS	04-0123-10	0	0	0
611	PALMAS	RE0314005	0	0	0
612	METALMECANICA	08-0302-11	0	0	0
613	PALMAS	RE0302012	4	1	0
614	PALMAS	MA0105010	5	1	0
615	PALMAS	RE0201029	2	0	0
616	PALMAS	RE0201127	6	0	1
617	PALMAS	RE0314040	0	0	0
618	PALMAS	MA0102112	0	0	0
619	SUPREMA	IN0105005	0	0	0
620	PALMAS	RE0314045	0	0	0
621	PALMAS	RE0201070	12	0	0
622	SUPREMA	06-0561-02	0	0	0
623	SUPREMA	06-0562-02	0	0	0
624	SUPREMA	06-0552-02	0	0	0
625	SAN FRANCISCO	IN0301005	97	0	0
626	SUPREMA	RE0317240	0	0	0
627	SAN JORGE	06-0029-04	0	0	0
628	GABIOSA	06-0003-13	0	0	0
629	SUPREMA	IN0202007	9	0	0
630	PALMAS	RE0311002	0	0	0
631	PALMAS	RE0311020	0	0	0
632	PALMAS	05-0589-01	0	0	0
633	PALMAS	06-0440-01	0	0	0
634	SUPREMA	IN0202010	10	1	0
635	SAN JORGE	04-0025-04	0	0	0
636	SAN JORGE	04-0024-04	0	0	0
637	SUPREMA	MA0102115	3	0	0
638	SUPREMA	RE0201196	0	0	0
639	SUPREMA	06-0536-02	0	0	0
640	SUPREMA	06-0534-02	0	0	0
641	GRS	RE0309090	0	0	0
642	PALMAS	MA0102114	0	0	0
643	PALMAS	RE0304012	0	0	0
644	METALMECANICA	08-0301-11	0	0	0
645	GRS	RE0309054	16	3	0
646	PALMAS	RE0314055	0	0	0
647	PALMAS	RE0101102	0	0	0
648	PALMAS	RE0101103	0	0	0
649	PALMAS	06-0486-01	0	0	0
650	SUPREMA	RE0304140	115	14	0
651	PALMAS	06-0433-01	0	0	0
652	GABIOSA	05-0015-13	0	0	0
653	PALMAS	RE0314058	0	0	0
654	SUPREMA	06-0520-02	0	0	0
655	SUPREMA	06-0521-02	0	0	0
656	PALMAS	RE0103053	5	1	0
657	SAN JORGE	05-0035-04	0	0	0
658	PALMAS	MA0104024	0	0	0
659	PALMAS	RE0302005	9	0	1
660	SUPREMA	RE0101002	0	0	0
661	PALMAS	05-0598-01	0	0	0
662	PALMAS	MA0104026	0	0	0
663	SAN JORGE	06-0028-04	0	0	0
664	SUPREMA	06-0533-02	0	0	0
665	SUPREMA	06-0532-02	0	0	0
666	SUPREMA	06-0535-02	0	0	0
667	PALMAS	RE0302061	2	1	0
668	SUPREMA	06-0591-02	0	0	0
669	PALMAS	06-0512-01	0	0	0
670	PALMAS	06-0511-01	0	0	0
671	SUPREMA	06-0593-02	0	0	0
672	SUPREMA	06-0592-02	0	0	0
673	SUPREMA	06-0594-02	0	0	0
674	METALMECANICA	06-0060-11	0	0	0
675	PALMAS	06-0515-01	0	0	0
676	SUPREMA	06-0590-02	0	0	0
677	PALMAS	06-0513-01	0	0	0
678	PALMAS	06-0514-01	0	0	0
679	PALMAS	RE0306044	2	0	0
680	PALMAS	06-0442-01	0	0	0
681	SUPREMA	06-0545-02	0	0	0
682	SUPREMA	06-0531-02	0	0	0
683	SUPREMA	RE0201025	81	0	0
684	PALMAS	RE0317110	0	0	0
685	SUPREMA	06-0544-02	0	0	0
686	PALMAS	MA0107022	209	0	0
687	PALMAS	06-0429-01	0	0	0
688	PALMAS	06-0421-01	0	0	0
689	PALMAS	05-0577-01	0	0	0
690	PALMAS	RE0302082	0	0	0
691	PALMAS	RE0317107	0	0	0
692	PALMAS	RE0302090	0	0	0
693	PALMAS	RE0201126	0	0	0
694	PALMAS	06-0453-01	0	0	0
695	PALMAS	06-0476-01	0	0	0
696	SUPREMA	06-0571-02	0	0	0
697	SUPREMA	06-0578-02	0	0	0
698	SUPREMA	06-0572-02	0	0	0
699	PALMAS	06-0475-01	0	0	0
700	PALMAS	06-0462-01	0	0	0
701	PALMAS	06-0461-01	0	0	0
702	PALMAS	06-0460-01	0	0	0
703	PALMAS	06-0459-01	0	0	0
704	PALMAS	06-0458-01	0	0	0
705	PALMAS	06-0457-01	0	0	0
706	PALMAS	06-0456-01	0	0	0
707	PALMAS	06-0464-01	0	0	0
708	PALMAS	06-0450-01	0	0	0
709	PALMAS	06-0454-01	0	0	0
710	SUPREMA	06-0576-02	0	0	0
711	SUPREMA	06-0573-02	0	0	0
712	SUPREMA	06-0577-02	0	0	0
713	SUPREMA	06-0575-02	0	0	0
714	SUPREMA	06-0574-02	0	0	0
715	PALMAS	06-0455-01	0	0	0
716	PALMAS	06-0466-01	0	0	0
717	PALMAS	06-0467-01	0	0	0
718	PALMAS	06-0465-01	0	0	0
719	PALMAS	06-0468-01	0	0	0
720	PALMAS	06-0463-01	0	0	0
721	SUPREMA	06-0580-02	0	0	0
722	SUPREMA	06-0579-02	0	0	0
723	PALMAS	RE0314057	0	0	0
724	SUPREMA	RE0305011	17	0	2
725	PALMAS	MA0102132	6	0	1
726	SUPREMA	RE0201190	0	0	0
727	PALMAS	08-0122-01	0	0	0
728	SAN JORGE	MA0104027	0	0	0
729	PALMAS	07-0138-01	0	0	0
730	PALMAS	RE0306071	0	0	0
731	SUPREMA	RE0317241	0	0	0
732	SUPREMA	RE0317086	0	0	0
733	PALMAS	RE0317017	40	9	0
734	PALMAS	07-0133-01	0	0	0
735	SUPREMA	RE0201012	2	1	0
736	SUPREMA	06-0585-02	0	0	0
737	SUPREMA	RE0310011	50	0	0
738	PALMAS	RE0101069	11	2	0
739	PALMAS	RE0302058	5	0	0
740	GABIOSA	08-0006-13	0	0	0
741	SUPREMA	MA0106054	0	0	0
742	PALMAS	IN0102018	0	0	0
743	PALMAS	MA0105028	0	0	0
744	PALMAS	08-0092-01	0	0	0
745	SUPREMA	MA0110004	1035	105	0
746	SUPREMA	RE0317196	0	0	0
747	PALMAS	RE0302080	0	0	0
748	PALMAS	RE0317106	0	0	0
749	SAN FRANCISCO	MA0102070	0	0	0
750	PALMAS	IN0202002	20	0	0
751	PALMAS	RE0314035	0	0	0
752	PALMAS	RE0304038	10	0	1
753	SUPREMA	RE0317061	0	0	0
754	SUPREMA	RE0317208	0	0	0
755	PALMAS	RE0306001	39	0	4
756	SUPREMA	RE0317195	1	0	0
757	SUPREMA	MA0109005	2	0	0
758	SUPREMA	06-0518-02	0	0	0
759	SAN ANTONIO	05-0035-05	0	0	0
760	PALMAS	RE0302068	1	0	0
761	GRS	MA0105001	0	0	0
762	ACACIAS	MA0102004	777	0	78
763	PALMAS	RE0201114	17	0	0
764	ACACIAS	MA0105004	0	0	0
765	PALMAS	RE0101099	4	0	0
766	PALMAS	RE0101096	2	0	0
767	METALMECANICA	AV10110010112	0	0	0
768	PALMAS	RE0304022	30	5	0
769	SUPREMA	08-0287-02	0	0	0
770	SUPREMA	RE0317060	0	0	0
771	PALMAS	RE0317012	5	0	0
772	SUPREMA	MA0107016	11	0	0
773	SUPREMA	RE0306011	9	0	0
774	SUPREMA	IN0201009	22	0	0
775	PALMAS	RE0302069	0	0	0
776	SUPREMA	RE0101008	1	0	0
777	SUPREMA	MA0107020	5	0	0
778	PALMAS	RE0312021	0	0	0
779	ACACIAS	MA0105008	96	18	0
780	SUPREMA	05-0576-02	0	0	0
781	QUIRICA	MA0102012	2027	178	0
782	SUPREMA	RE0101019	3	0	0
783	PALMAS	08-0094-01	0	0	0
784	SUPREMA	MA0106042	0	0	0
785	PALMAS	04-0752-01	0	0	0
786	PALMAS	RE0302099	0	0	0
787	PALMAS	06-0449-01	0	0	0
788	PALMAS	05-0621-01	0	0	0
789	SUPREMA	05-0550-02	0	0	0
790	SUPREMA	05-0549-02	0	0	0
791	PALMAS	MA0102105	0	0	0
792	PALMAS	06-0489-01	0	0	0
793	PALMAS	06-0478-01	0	0	0
794	PALMAS	MA0104079	0	0	0
795	SUPREMA	IN0102090	0	0	0
796	PALMAS	05-0597-01	0	0	0
797	SAN ANTONIO	IN0301016	0	0	0
798	PALMAS	06-0427-01	0	0	0
799	SUPREMA	IN0106029	0	0	0
800	PALMAS	06-0420-01	0	0	0
801	PALMAS	06-0418-01	0	0	0
802	TASINSA	08-0272-09	0	0	0
803	SUPREMA	RE0101026	2	0	0
804	SAN ANTONIO	MA0201002	0	0	0
805	TASINSA	06-0081-09	0	0	0
806	SUPREMA	RE0317082	0	0	0
807	ALFA	MA0104007	0	0	0
808	PALMAS	RE0314006	0	0	0
809	PALMAS	RE0201125	4	0	0
810	PALMAS	RE0302081	1	0	0
811	PALMAS	RE0309012	0	0	0
812	PALMAS	08-0189-01	0	0	0
813	PALMAS	MA0104083	0	0	0
814	QUIRICA	MA0101041	0	0	0
815	ACACIAS	MA0101041	0	0	0
816	PALMAS	RE0304065	4	0	0
817	PALMAS	RE0101053	7	1	0
818	SUPREMA	RE0317184	0	0	0
819	SUPREMA	06-0542-02	0	0	0
820	SUPREMA	06-0543-02	0	0	0
821	ACACIAS	MA0105007	0	0	0
822	SAN FRANCISCO	IN0301002	0	0	0
823	PALMAS	RE0317105	0	0	0
824	PALMAS	08-0200-01	0	0	0
825	SUPREMA	05-0547-02	0	0	0
826	ACACIAS	MA0105005	0	0	0
827	SAN ANTONIO	MA0105006	0	0	0
828	SUPREMA	MA0102116	0	0	0
829	SUPREMA	RE0201191	2	0	0
830	PALMAS	05-0610-01	0	0	0
831	PALMAS	RE0312024	0	0	0
832	PALMAS	MA0104011	1	0	0
833	SUPREMA	MA0110019	0	0	0
834	SUPREMA	RE0305012	4	0	0
835	PALMAS	MA0106016	112	0	0
836	PALMAS	05-0618-01	0	0	0
837	SUPREMA	RE0317185	0	0	0
838	SUPREMA	RE0201055	0	0	0
839	PALMAS	MA0102152	0	0	0
840	PALMAS	RE0314004	0	0	0
841	PALMAS	05-0592-01	0	0	0
842	SAN ANTONIO	IN0305015	1	0	0
843	PALMAS	RE0314049	0	0	0
844	SUPREMA	RE0304001	0	0	0
845	PALMAS	RE0317002	1	0	0
846	SUPREMA	RE0201184	0	0	0
847	SUPREMA	MA0106051	0	0	0
848	GRS	05-0132-10	0	0	0
849	SUPREMA	RE0201174	0	0	0
850	PALMAS	RE0312016	0	0	0
851	PALMAS	MA0102106	0	0	0
852	PALMAS	RE0303044	4	0	0
853	PALMAS	RE0201045	0	0	0
854	GRS	MA0104030	0	0	0
855	ACACIAS	IN0302006	14	0	0
856	PALMAS	RE0314054	0	0	0
857	PALMAS	RE0314056	0	0	0
858	PALMAS	RE0102025	0	0	0
859	SUPREMA	RE0201102	4	2	0
860	PALMAS	RE0311024	0	0	0
861	PALMAS	RE0102021	0	0	0
862	SUPREMA	RE0305010	2	0	0
863	SUPREMA	RE0301035	0	0	0
864	SUPREMA	RE0201128	48	11	0
865	SUPREMA	RE0302049	0	0	0
866	SUPREMA	RE0304139	0	0	0
867	PALMAS	05-0556-01	0	0	0
868	METALMECANICA	08-0318-11	0	0	0
869	PALMAS	RE0302101	0	0	0
870	PALMAS	RE0317029	0	0	0
871	PALMAS	RE0306054	0	0	0
872	SAN JORGE	MA0201002	0	0	0
873	PALMAS	RE0101097	1	0	0
874	PALMAS	05-0596-01	0	0	0
875	PALMAS	08-0093-01	0	0	0
876	SUPREMA	MA0110022	0	0	0
877	PALMAS	08-0095-01	0	0	0
878	SUPREMA	06-0529-02	0	0	0
879	PALMAS	04-0709-01	0	0	0
880	PALMAS	08-0126-01	0	0	0
881	PALMAS	08-0187-01	0	0	0
882	SUPREMA	RE0201192	3	0	0
883	GRS	RE0109002	12	0	1
884	QUIRICA	IN0302006	0	0	0
885	PALMAS	05-0569-01	0	0	0
886	GRS	MA0103002	7	0	1
887	PALMAS	RE0311003	7	0	0
888	SAN JORGE	MA0104026	0	0	0
889	SUPREMA	05-0572-02	0	0	0
890	SUPREMA	05-0569-02	0	0	0
891	SUPREMA	05-0570-02	0	0	0
892	SUPREMA	05-0568-02	0	0	0
893	SUPREMA	05-0573-02	0	0	0
894	SUPREMA	05-0571-02	0	0	0
895	PALMAS	MA0102125	5	0	0
896	SUPREMA	MA0107047	0	0	0
897	PALMAS	04-0731-01	0	0	0
898	PALMAS	06-0428-01	0	0	0
899	PALMAS	06-0432-01	0	0	0
900	PALMAS	RE0310009	0	0	0
901	PALMAS	RE0302067	0	0	0
902	GRS	RE0309003	8	1	0
903	METALMECANICA	08-0312-11	0	0	0
904	PALMAS	RE0317095	0	0	0
905	PALMAS	RE0317096	0	0	0
906	PALMAS	RE0314030	1	0	0
907	GRS	IN0101004	0	0	0
908	PALMAS	RE0306003	17	0	0
909	SAN FRANCISCO	MA0101041	0	0	0
910	SAN JORGE	MA0101041	6	0	0
911	SAN ANTONIO	MA0101041	0	0	0
912	PALMAS	05-0599-01	0	0	0
913	SUPREMA	MA0102109	3	0	0
914	PALMAS	MA0102141	10	0	0
915	SAN ANTONIO	MA0103010	5	0	0
916	PALMAS	RE0302045	0	0	0
917	METALMECANICA	RE0309137	0	0	0
918	PALMAS	RE0312017	0	0	0
919	SUPREMA	RE0304087	0	0	0
920	SUPREMA	05-0551-02	0	0	0
921	SUPREMA	RE0201031	0	0	0
922	SUPREMA	RE0307004	0	0	0
923	GRS	RE0307004	0	0	0
924	PALMAS	05-0586-01	0	0	0
925	PALMAS	05-0582-01	0	0	0
926	PALMAS	05-0584-01	0	0	0
927	PALMAS	05-0585-01	0	0	0
928	PALMAS	05-0583-01	0	0	0
929	SUPREMA	06-0546-02	0	0	0
930	SUPREMA	06-0565-02	0	0	0
931	SUPREMA	06-0548-02	0	0	0
932	SUPREMA	06-0547-02	0	0	0
933	SAN ANTONIO	IN0305003	3	0	0
934	PALMAS	05-0563-01	0	0	0
935	PALMAS	05-0565-01	0	0	0
936	PALMAS	05-0564-01	0	0	0
937	SUPREMA	05-0553-02	0	0	0
938	SUPREMA	05-0552-02	0	0	0
939	SUPREMA	06-0525-02	0	0	0
940	SUPREMA	06-0524-02	0	0	0
941	SUPREMA	06-0526-02	0	0	0
942	SUPREMA	06-0522-02	0	0	0
943	SUPREMA	06-0523-02	0	0	0
944	PALMAS	05-0551-01	0	0	0
945	PALMAS	05-0547-01	0	0	0
946	PALMAS	RE0302097	0	0	0
947	PALMAS	08-0127-01	0	0	0
948	GRS	RE0306008	7	0	0
949	PALMAS	RE0101027	0	0	0
950	SUPREMA	RE0317101	0	0	0
951	ACACIAS	05-0076-03	0	0	0
952	SUPREMA	05-0541-02	0	0	0
953	PALMAS	05-0546-01	0	0	0
954	PALMAS	05-0545-01	0	0	0
955	SUPREMA	MA0107019	0	0	0
956	SUPREMA	RE0101013	0	0	0
957	PALMAS	RE0302008	2	0	0
958	SUPREMA	05-0567-02	0	0	0
959	PALMAS	MA0102145	0	0	0
960	PALMAS	MA0104073	2	0	0
961	SUPREMA	RE0101027	4	0	0
962	PALMAS	06-0504-01	0	0	0
963	SAN JORGE	MA0101013	49	0	5
964	SAN FRANCISCO	MA0101013	21	0	0
965	SAN ANTONIO	MA0101013	40	0	0
966	PALMAS	RE0101101	0	0	0
967	PALMAS	RE0301011	0	0	0
968	PALMAS	04-0688-01	0	0	0
969	ALFA	05-0016-08	0	0	0
970	SAN JORGE	05-0042-04	0	0	0
971	PALMAS	06-0479-01	0	0	0
972	GRS	RE0309034	0	0	0
973	PALMAS	RE0314051	0	0	0
974	SUPREMA	MA0102108	3	0	0
975	ACACIAS	IN0302004	8	0	0
976	QUIRICA	IN0302004	17	2	2
977	SUPREMA	08-0296-02	0	0	0
978	PALMAS	05-0557-01	0	0	0
979	PALMAS	05-0548-01	0	0	0
980	PALMAS	RE0101092	2	0	0
981	GRS	RE0201089	0	0	0
982	PALMAS	RE0304058	0	0	0
983	PALMAS	05-0552-01	0	0	0
984	SUPREMA	08-0293-02	0	0	0
985	SAN FRANCISCO	MA0101010	8	3	0
986	SAN ANTONIO	MA0101010	12	0	1
987	SAN JORGE	MA0101010	9	0	0
988	PALMAS	06-0446-01	0	0	0
989	PALMAS	06-0445-01	0	0	0
990	SUPREMA	RE0304091	0	0	0
991	SUPREMA	RE0317100	0	0	0
992	PALMAS	08-0201-01	0	0	0
993	PALMAS	RE0314050	0	0	0
994	SUPREMA	08-0289-02	0	0	0
995	PALMAS	MA0102142	3	0	0
996	SUPREMA	06-0530-02	0	0	0
997	PALMAS	RE0302011	1	0	0
998	SUPREMA	05-0555-02	0	0	0
999	SUPREMA	05-0556-02	0	0	0
1000	PALMAS	06-0491-01	0	0	0
1001	PALMAS	06-0490-01	0	0	0
1002	SUPREMA	MA0102126	2	0	0
1003	SUPREMA	RE0304041	0	0	0
1004	PALMAS	MA0104074	0	0	0
1005	SUPREMA	RE0101038	1	0	0
1006	SAN ANTONIO	MA0102012	0	0	0
1007	PALMAS	RE0314052	0	0	0
1008	SUPREMA	06-0540-02	0	0	0
1009	SUPREMA	06-0538-02	0	0	0
1010	SUPREMA	06-0541-02	0	0	0
1011	SUPREMA	06-0539-02	0	0	0
1012	SUPREMA	06-0537-02	0	0	0
1013	GRS	MA0103003	0	0	0
1014	SAN FRANCISCO	IN0303008	0	0	0
1015	GRS	RE0309024	0	0	0
1016	ALFA	MA0101013	5	0	0
1017	PALMAS	RE0201104	0	0	0
1018	SAN FRANCISCO	MA0201002	92	0	0
1019	PALMAS	05-0593-01	0	0	0
1020	PALMAS	05-0588-01	0	0	0
1021	PALMAS	RE0306045	5	0	0
1022	ALFA	MA0102122	0	0	0
1023	SUPREMA	MA0110009	3	0	0
1024	SUPREMA	MA0105002	21	2	2
1025	PALMAS	05-0611-01	0	0	0
1026	PALMAS	MA0104084	0	0	0
1027	PALMAS	RE0302037	2	0	0
1028	PALMAS	RE0101071	0	0	0
1029	PALMAS	RE0310004	7	2	0
1030	PALMAS	06-0435-01	0	0	0
1031	PALMAS	06-0436-01	0	0	0
1032	PALMAS	06-0434-01	0	0	0
1033	PALMAS	RE0311022	0	0	0
1034	PALMAS	06-0443-01	0	0	0
1035	PALMAS	RE0103010	3	0	0
1036	PALMAS	RE0303039	0	0	0
1037	SAN ANTONIO	MA0202030	0	0	0
1038	PALMAS	05-0608-01	0	0	0
1039	SUPREMA	06-0564-02	0	0	0
1040	SUPREMA	06-0549-02	0	0	0
1041	SUPREMA	06-0550-02	0	0	0
1042	SUPREMA	06-0563-02	0	0	0
1043	SUPREMA	06-0551-02	0	0	0
1044	PALMAS	MA0107026	3	0	0
1045	PALMAS	06-0439-01	0	0	0
1046	SAN ANTONIO	MA0101011	0	0	0
1047	PALMAS	MA0107028	0	0	0
1048	SUPREMA	MA0102111	0	0	0
1049	PALMAS	MA0102099	0	0	0
1050	PALMAS	RE0201103	0	0	0
1051	PALMAS	05-0580-01	0	0	0
1052	PALMAS	05-0579-01	0	0	0
1053	SUPREMA	05-0557-02	0	0	0
1054	SUPREMA	05-0558-02	0	0	0
1055	PALMAS	05-0555-01	0	0	0
1056	PALMAS	05-0553-01	0	0	0
1057	SUPREMA	05-0565-02	0	0	0
1058	SUPREMA	05-0566-02	0	0	0
1059	TASINSA	05-0098-09	0	0	0
1060	PALMAS	RE0101011	0	0	0
1061	PALMAS	RE0312008	0	0	0
1062	PALMAS	MA0104013	0	0	0
1063	PALMAS	06-0488-01	0	0	0
1064	PALMAS	RE0302078	0	0	0
1065	SUPREMA	RE0302052	0	0	0
1066	PALMAS	RE0304060	0	0	0
1067	SUPREMA	RE0316008	32	0	3
1068	TASINSA	05-0099-09	0	0	0
1069	PALMAS	MA0104001	0	0	0
1070	PALMAS	RE0101104	0	0	0
1071	SUPREMA	RE0317085	0	0	0
1072	SUPREMA	MA0102110	2	0	0
1073	SUPREMA	RE0304042	6	0	0
1074	PALMAS	RE0317108	0	0	0
1075	PALMAS	RE0317109	0	0	0
1076	PALMAS	RE0304040	19	3	0
1077	ACACIAS	MA0104002	0	0	0
1078	ALFA	IN0302004	9	2	0
1079	SUPREMA	RE0201024	0	0	0
1080	SUPREMA	06-0527-02	0	0	0
1081	PALMAS	MA0106004	8	0	0
1082	PALMAS	06-0419-01	0	0	0
1083	PALMAS	RE0317104	0	0	0
1084	PALMAS	05-0571-01	0	0	0
1085	PALMAS	05-0574-01	0	0	0
1086	PALMAS	05-0572-01	0	0	0
1087	PALMAS	05-0575-01	0	0	0
1088	PALMAS	05-0576-01	0	0	0
1089	PALMAS	05-0573-01	0	0	0
1090	SUPREMA	RE0309019	0	0	0
1091	SAN ANTONIO	MA0202024	78	0	0
1092	ACACIAS	MA0102107	0	0	0
1093	ACACIAS	MA0102035	0	0	0
1094	SAN JORGE	MA0103010	4	0	0
1095	SUPREMA	RE0201186	0	0	0
1096	PALMAS	RE0101098	3	0	0
1097	PALMAS	RE0101010	0	0	0
1098	SAN ANTONIO	MA0202015	2	0	0
1099	PALMAS	RE0312018	0	0	0
1100	PALMAS	08-0198-01	0	0	0
1101	PALMAS	05-0537-01	0	0	0
1102	PALMAS	06-0481-01	0	0	0
1103	PALMAS	06-0483-01	0	0	0
1104	PALMAS	06-0480-01	0	0	0
1105	PALMAS	06-0482-01	0	0	0
1106	SUPREMA	MA0106061	0	0	0
1107	SUPREMA	08-0297-02	0	0	0
1108	SUPREMA	05-0562-02	0	0	0
1109	SUPREMA	05-0561-02	0	0	0
1110	PALMAS	08-0123-01	0	0	0
1111	PALMAS	05-0554-01	0	0	0
1112	SUPREMA	RE0301027	5	0	0
1113	PALMAS	RE0314060	0	0	0
1114	SUPREMA	MA0102124	0	0	0
1115	SUPREMA	MA0108031	13	0	0
1116	GRS	RE0304011	0	0	0
1117	METALMECANICA	08-0316-11	0	0	0
1118	ALFA	MA0102035	0	0	0
1119	SUPREMA	RE0101012	0	0	0
1120	SUPREMA	RE0304026	0	0	0
1121	PALMAS	MA0102096	4	0	0
1122	PALMAS	MA0108033	94	0	9
1123	METALMECANICA	08-0307-11	0	0	0
1124	METALMECANICA	08-0308-11	0	0	0
1125	SUPREMA	RE0317083	0	0	0
1126	SUPREMA	RE0201168	0	0	0
1127	PALMAS	RE0314048	0	0	0
1128	ACACIAS	05-0077-03	0	0	0
1129	SAN JORGE	MA0105008	0	0	0
1130	PALMAS	RE0101070	0	0	0
1131	PALMAS	06-0485-01	0	0	0
1132	PALMAS	IN0105008	137	0	14
1133	SUPREMA	RE0201006	0	0	0
1134	PALMAS	MA0102100	1	0	0
1135	PALMAS	RE0101095	1	0	0
1136	PALMAS	05-0568-01	0	0	0
1137	PALMAS	05-0561-01	0	0	0
1138	METALMECANICA	AV10110010108	0	0	0
1139	PALMAS	RE0311012	7	1	0
1140	PALMAS	RE0103070	0	0	0
1141	SUPREMA	MA0110021	0	0	0
1142	SUPREMA	05-0559-02	0	0	0
1143	SUPREMA	06-0583-02	0	0	0
1144	SUPREMA	05-0564-02	0	0	0
1145	SUPREMA	05-0560-02	0	0	0
1146	SUPREMA	06-0584-02	0	0	0
1147	SUPREMA	05-0563-02	0	0	0
1148	PALMAS	05-0605-01	0	0	0
1149	PALMAS	05-0604-01	0	0	0
1150	SAN JORGE	05-0034-04	0	0	0
1151	SUPREMA	06-0557-02	0	0	0
1152	SUPREMA	06-0560-02	0	0	0
1153	SUPREMA	06-0554-02	0	0	0
1154	SUPREMA	06-0555-02	0	0	0
1155	SUPREMA	06-0556-02	0	0	0
1156	SUPREMA	06-0553-02	0	0	0
1157	SUPREMA	06-0558-02	0	0	0
1158	SUPREMA	06-0559-02	0	0	0
1159	SUPREMA	06-0528-02	0	0	0
1160	PALMAS	MA0102110	0	0	0
1161	PALMAS	MA0104082	0	0	0
1162	METALMECANICA	08-0315-11	0	0	0
1163	METALMECANICA	08-0314-11	0	0	0
1164	ACACIAS	MA0103011	20	0	0
1165	PALMAS	RE0102018	0	0	0
1166	PALMAS	RE0103076	34	0	3
1167	PALMAS	RE0312022	0	0	0
1168	SAN FRANCISCO	MA0101040	0	0	0
1169	SAN ANTONIO	MA0101040	0	0	0
1170	PALMAS	05-0536-01	0	0	0
1171	SUPREMA	05-0575-02	0	0	0
1172	PALMAS	MA0105005	0	0	0
1173	SUPREMA	RE0101036	3	0	0
1174	SUPREMA	RE0304128	0	0	0
1175	SAN FRANCISCO	MA0103010	4	0	0
1176	ACACIAS	08-0064-03	0	0	0
1177	SUPREMA	RE0304101	0	0	0
1178	PALMAS	RE0302054	9	0	0
1179	SUPREMA	RE0302045	0	0	0
1180	SUPREMA	MA0107011	0	0	0
1181	ACACIAS	RE0301001	0	0	0
1182	PALMAS	RE0304015	0	0	0
1183	SAN ANTONIO	MA0102130	1	0	0
1184	SUPREMA	RE0201022	0	0	0
1185	SAN ANTONIO	IN0303003	0	0	0
1186	PALMAS	05-0562-01	0	0	0
1187	PALMAS	RE0101100	0	0	0
1188	PALMAS	RE0308010	0	0	0
1189	PALMAS	05-0595-01	0	0	0
1190	PALMAS	05-0594-01	0	0	0
1191	SUPREMA	MA0102098	0	0	0
1192	PALMAS	06-0426-01	0	0	0
1193	PALMAS	06-0423-01	0	0	0
1194	PALMAS	06-0424-01	0	0	0
1195	PALMAS	06-0425-01	0	0	0
1196	PALMAS	06-0422-01	0	0	0
1197	PALMAS	RE0306065	2	0	0
1198	PALMAS	08-0124-01	0	0	0
1199	PALMAS	RE0317011	0	0	0
1200	QUIRICA	MA0101010	0	0	0
1201	SUPREMA	MA0102107	0	0	0
1202	SAN ANTONIO	MA0105007	2	0	0
1203	ALFA	MA0105008	0	0	0
1204	SAN FRANCISCO	MA0105008	0	0	0
1205	SUPREMA	RE0301037	0	0	0
1206	PALMAS	05-0590-01	0	0	0
1207	PALMAS	05-0591-01	0	0	0
1208	PALMAS	RE0316005	0	0	0
1209	GRS	RE0306007	4	0	0
1210	PALMAS	RE0304062	0	0	0
1211	PALMAS	08-0190-01	0	0	0
1212	SAN JORGE	05-0037-04	0	0	0
1213	SAN JORGE	05-0038-04	0	0	0
1214	SAN JORGE	05-0041-04	0	0	0
1215	SAN JORGE	05-0040-04	0	0	0
1216	SAN JORGE	05-0039-04	0	0	0
1217	SAN JORGE	05-0036-04	0	0	0
1218	SUPREMA	MA0106023	0	0	0
1219	METALMECANICA	08-0267-11	0	0	0
1220	PALMAS	RE0308005	0	0	0
1221	SUPREMA	06-0569-02	0	0	0
1222	PALMAS	MA0108046	221	0	0
1223	SAN ANTONIO	MA0202025	0	0	0
1224	SUPREMA	RE0317018	1	0	0
1225	PALMAS	08-0192-01	0	0	0
1226	ACACIAS	MA0101013	0	0	0
1227	PALMAS	RE0311025	0	0	0
1228	PALMAS	RE0304052	3	0	0
1229	SAN FRANCISCO	IN0303003	0	0	0
1230	GRS	RE0306002	9	2	1
1231	PALMAS	RE0201118	0	0	0
1232	PALMAS	MA0108049	0	0	0
1233	SUPREMA	RE0304040	11	0	0
1234	PALMAS	08-0099-01	0	0	0
1235	PALMAS	08-0097-01	0	0	0
1236	PALMAS	08-0096-01	0	0	0
1237	PALMAS	08-0098-01	0	0	0
1238	SUPREMA	RE0201183	1	0	0
1239	PALMAS	RE0301013	1	0	0
1240	PALMAS	RE0306027	0	0	0
1241	SAN ANTONIO	MA0105008	0	0	0
1242	GRS	RE0309085	3	0	0
1243	PALMAS	RE0201116	3	0	0
1244	SUPREMA	RE0316019	7	0	0
1245	SUPREMA	RE0201217	0	0	0
1246	PALMAS	06-0438-01	0	0	0
1247	ALFA	MA0103010	0	0	0
1248	SUPREMA	RE0201218	0	0	0
1249	PALMAS	05-0578-01	0	0	0
1250	PALMAS	05-0559-01	0	0	0
1251	SAN FRANCISCO	IN0304003	0	0	0
1252	GRS	RE0309048	0	0	0
1253	SUPREMA	06-0566-02	0	0	0
1254	SUPREMA	06-0567-02	0	0	0
1255	SUPREMA	06-0568-02	0	0	0
1256	PALMAS	RE0306047	0	0	0
1257	PALMAS	MA0102113	0	0	0
1258	PALMAS	RE0305006	0	0	0
1259	SUPREMA	08-0292-02	0	0	0
1260	METALMECANICA	RE0316014	0	0	0
1261	PALMAS	RE0101093	2	0	0
1262	GRS	RE0201094	0	0	0
1263	SUPREMA	RE0310001	2	0	0
1264	PALMAS	RE0101068	0	0	0
1265	PALMAS	RE0101018	0	0	0
1266	SAN ANTONIO	IN0301020	26	0	0
1267	PALMAS	RE0101008	0	0	0
1268	SUPREMA	RE0317183	0	0	0
1269	SAN ANTONIO	MA0202023	21	0	0
1270	PALMAS	MA0108018	0	0	0
1271	PALMAS	RE0306037	0	0	0
1272	PALMAS	RE0304057	0	0	0
1273	PALMAS	RE0101037	0	0	0
1274	PALMAS	RE0304050	4	1	0
1275	GRS	RE0309027	30	0	0
1276	PALMAS	RE0302002	0	0	0
1277	PALMAS	RE0302066	1	0	0
1278	SUPREMA	RE0103022	0	0	0
1279	METALMECANICA	RE0309150	0	0	0
1280	SUPREMA	RE0309015	0	0	0
1281	PALMAS	MA0108029	0	0	0
1282	SAN FRANCISCO	MA0102004	29	0	0
1283	PALMAS	08-0191-01	0	0	0
1284	PALMAS	RE0306026	7	0	0
1285	SUPREMA	MA0105018	0	0	0
1286	PALMAS	MA0104012	0	0	0
1287	SAN JORGE	MA0101002	4	0	0
1288	SUPREMA	RE0317009	0	0	0
1289	PALMAS	RE0306046	7	1	0
1290	PALMAS	RE0302077	1	0	0
1291	SUPREMA	MA0102066	0	0	0
1292	PALMAS	MA0104067	0	0	0
1293	PALMAS	RE0101073	0	0	0
1294	PALMAS	08-0199-01	0	0	0
1295	SAN JORGE	MA0202030	0	0	0
1296	PALMAS	05-0566-01	0	0	0
1297	SAN FRANCISCO	MA0202030	0	0	0
1298	SUPREMA	RE0316009	0	0	0
1299	PALMAS	RE0308027	0	0	0
1300	PALMAS	MA0102103	7	0	1
1301	SAN FRANCISCO	MA0101017	0	0	0
1302	SAN ANTONIO	MA0108005	0	0	0
1303	SUPREMA	RE0201101	16	3	0
1304	SAN ANTONIO	MA0101008	0	0	0
1305	SAN JORGE	MA0101008	0	0	0
1306	SAN FRANCISCO	MA0101008	0	0	0
1307	PALMAS	RE0302044	0	0	0
1308	PALMAS	RE0304064	0	0	0
1309	PALMAS	RE0308007	0	0	0
1310	SUPREMA	RE0201008	0	0	0
1311	SUPREMA	MA0107012	19	0	0
1312	SAN JORGE	06-0030-04	0	0	0
1313	SUPREMA	RE0304090	0	0	0
1314	SAN FRANCISCO	MA0101002	0	0	0
1315	SAN ANTONIO	MA0101002	0	0	0
1316	PALMAS	08-0125-01	0	0	0
1317	SUPREMA	MA0108007	73	0	0
1318	PALMAS	MA0108034	32	0	3
1319	SAN FRANCISCO	MA0101001	0	0	0
1320	SAN ANTONIO	MA0101001	0	0	0
1321	SAN JORGE	MA0101001	0	0	0
1322	PALMAS	RE0306018	10	0	0
1323	GRS	RE0309058	0	0	0
1324	PALMAS	MA0102104	2	0	0
1325	SAN ANTONIO	MA0104002	14	0	1
1326	SUPREMA	RE0308010	5	0	0
1327	PALMAS	RE0311023	1	0	0
1328	SUPREMA	RE0305001	0	0	0
1329	QUIRICA	RE0302002	0	0	0
1330	SAN JORGE	MA0101011	0	0	0
1331	PALMAS	RE0306061	9	0	0
1332	ALFA	MA0101040	0	0	0
1333	ACACIAS	MA0101033	0	0	0
1334	SAN JORGE	MA0101040	0	0	0
1335	PALMAS	RE0306043	3	0	0
1336	SUPREMA	06-0589-02	0	0	0
1337	PALMAS	06-0509-01	0	0	0
1338	PALMAS	06-0510-01	0	0	0
1339	SUPREMA	RE0103014	0	0	0
1340	SUPREMA	RE0304006	0	0	0
1341	SAN FRANCISCO	MA0202015	2	0	0
1342	SAN JORGE	MA0202015	2	0	0
1343	PALMAS	MA0108028	0	0	0
1344	SUPREMA	RE0306013	4	0	0
1345	PALMAS	MA0108054	0	0	0
1346	SUPREMA	MA0102101	0	0	0
1347	SUPREMA	RE0308011	0	0	0
1348	SUPREMA	MA0103026	0	0	0
1349	SAN JORGE	RE0302002	0	0	0
1350	SAN ANTONIO	IN0304003	0	0	0
1351	SAN JORGE	MA0202025	0	0	0
1352	SUPREMA	RE0309009	32	0	0
1353	PALMAS	RE0103026	0	0	0
1354	ALFA	MA0202022	0	0	0
1355	SUPREMA	RE0317031	2	0	0
1356	GRS	RE0302012	0	0	0
1357	SUPREMA	08-0301-02	0	0	0
1358	SUPREMA	08-0300-02	0	0	0
1359	SUPREMA	08-0299-02	0	0	0
1360	SUPREMA	08-0302-02	0	0	0
1361	PALMAS	RE0302076	2	0	0
1362	QUIRICA	MA0202025	0	0	0
1363	ACACIAS	MA0202025	0	0	0
1364	SUPREMA	RE0304043	7	0	0
1365	SUPREMA	05-0545-02	0	0	0
1366	SUPREMA	05-0543-02	0	0	0
1367	SUPREMA	05-0544-02	0	0	0
1368	PALMAS	RE0314062	0	0	0
1369	PALMAS	RE0314063	0	0	0
1370	PALMAS	RE0306058	2	0	0
1371	PALMAS	RE0308006	1	0	0
1372	SAN ANTONIO	MA0202017	0	0	0
1373	SAN JORGE	MA0202017	0	0	0
1374	SAN FRANCISCO	MA0101011	0	0	0
1375	PALMAS	MA0108065	0	0	0
1376	SUPREMA	RE0302030	0	0	0
1377	GRS	RE0309019	0	0	0
1378	SUPREMA	RE0103013	5	0	0
1379	QUIRICA	MA0104002	4	0	0
1380	SAN ANTONIO	MA0102017	0	0	0
1381	SUPREMA	RE0201007	9	0	0
1382	GRS	RE0309032	0	0	0
1383	PALMAS	RE0314061	0	0	0
1384	QUIRICA	MA0101040	4	0	0
1385	PALMAS	RE0306025	0	0	0
1386	PALMAS	MA0104081	0	0	0
1387	PALMAS	RE0302105	1	0	0
1388	PALMAS	RE0306062	0	0	0
1389	SAN FRANCISCO	MA0101015	6	0	1
1390	SAN ANTONIO	MA0101015	0	0	0
1391	SUPREMA	RE0317144	0	0	0
1392	PALMAS	RE0317111	0	0	0
1393	PALMAS	MA0102138	0	0	0
1394	SUPREMA	RE0304010	25	0	2
1395	SAN ANTONIO	MA0202009	0	0	0
1396	SAN FRANCISCO	MA0202009	0	0	0
1397	SUPREMA	RE0304163	0	0	0
1398	SAN ANTONIO	MA0101003	0	0	0
1399	SUPREMA	RE0304153	0	0	0
1400	SUPREMA	RE0310002	20	5	0
1401	PALMAS	MA0104010	0	0	0
1402	PALMAS	RE0306015	3	1	0
1403	PALMAS	RE0306066	0	0	0
1404	PALMAS	RE0101067	0	0	0
1405	SUPREMA	RE0302027	0	0	0
1406	QUIRICA	RE0308001	0	0	0
1407	PALMAS	RE0102028	0	0	0
1408	METALMECANICA	08-0309-11	0	0	0
1409	METALMECANICA	08-0311-11	0	0	0
1410	METALMECANICA	08-0310-11	0	0	0
1411	SUPREMA	MA0108028	24	0	0
1412	SUPREMA	MA0102104	0	0	0
1413	PALMAS	MA0104063	0	0	0
1414	QUIRICA	MA0105008	0	0	0
1415	SUPREMA	MA0101026	2	0	0
1416	SUPREMA	MA0102103	0	0	0
1417	SUPREMA	MA0102114	0	0	0
1418	SUPREMA	RE0308038	1	0	0
1419	PALMAS	MA0108005	20	0	0
1420	SAN JORGE	MA0101004	0	0	0
1421	SAN ANTONIO	MA0101004	5	0	0
1422	SAN FRANCISCO	MA0103011	0	0	0
1423	SUPREMA	RE0101046	1	1	0
1424	SUPREMA	08-0291-02	0	0	0
1425	SUPREMA	RE0304160	0	0	0
1426	SAN JORGE	IN0303003	0	0	0
1427	ALFA	RE0308001	0	0	0
1428	SAN ANTONIO	MA0202004	2	0	0
1429	SUPREMA	RE0304127	0	0	0
1430	SUPREMA	RE0309020	0	0	0
1431	PALMAS	RE0101072	0	0	0
1432	ACACIAS	RE0302002	0	0	0
1433	SUPREMA	RE0101049	0	0	0
1434	SUPREMA	RE0317005	0	0	0
1435	GRS	MA0105011	0	0	0
1436	GRS	RE0302011	0	0	0
1437	SAN FRANCISCO	MA0101003	0	0	0
1438	SAN JORGE	MA0101003	0	0	0
1439	PALMAS	MA0108025	0	0	0
1440	SAN FRANCISCO	MA0202024	29	4	0
1441	SUPREMA	RE0304004	0	0	0
1442	PALMAS	MA0108020	0	0	0
1443	QUIRICA	MA0202024	0	0	0
1444	SUPREMA	RE0201065	0	0	0
1445	PALMAS	MA0107025	0	0	0
1446	SUPREMA	RE0305005	0	0	0
1447	ACACIAS	MA0202024	0	0	0
1448	SAN JORGE	MA0202024	0	0	0
1449	ALFA	MA0102110	60	0	6
1450	SAN JORGE	MA0101015	1	0	0
1451	PALMAS	RE0314059	0	0	0
1452	PALMAS	RE0301015	0	0	0
1453	PALMAS	RE0306063	0	0	0
1454	PALMAS	RE0101048	0	0	0
1455	PALMAS	RE0101049	0	0	0
1456	PALMAS	RE0302051	1	0	0
1457	PALMAS	RE0306060	0	0	0
1458	PALMAS	MA0102093	0	0	0
1459	SUPREMA	RE0101050	0	0	0
1460	SAN FRANCISCO	MA0101009	0	0	0
1461	SAN ANTONIO	MA0101009	0	0	0
1462	SAN JORGE	MA0101009	0	0	0
1463	GRS	RE0310003	0	0	0
1464	ALFA	RE0302002	0	0	0
1465	PALMAS	RE0308009	0	0	0
1466	SUPREMA	RE0309017	0	0	0
1467	METALMECANICA	RE0316005	0	0	0
1468	ACACIAS	MA0101017	0	0	0
1469	SUPREMA	RE0101037	1	0	0
1470	PALMAS	RE0306019	0	0	0
1471	PALMAS	MA0105002	8	1	0
1472	PALMAS	RE0103038	0	0	0
1473	PALMAS	RE0312026	0	0	0
1474	GRS	RE0201095	0	0	0
1475	SUPREMA	RE0103005	1	0	0
1476	SUPREMA	08-0295-02	0	0	0
1477	PALMAS	RE0304010	4	0	0
1478	PALMAS	MA0108019	0	0	0
1479	SUPREMA	RE0201015	0	0	0
1480	SUPREMA	MA0102100	0	0	0
1481	SAN ANTONIO	MA0202035	0	0	0
1482	PALMAS	RE0312007	0	0	0
1483	PALMAS	MA0104004	0	0	0
1484	METALMECANICA	RE0316007	0	0	0
1485	SAN JORGE	MA0103011	8	0	0
1486	SAN ANTONIO	MA0103011	0	0	0
1487	PALMAS	RE0306057	7	0	0
1488	SAN JORGE	MA0101017	0	0	0
1489	SAN ANTONIO	MA0101017	0	0	0
1490	PALMAS	RE0304051	0	0	0
1491	PALMAS	RE0306049	0	0	0
1492	SUPREMA	MA0102106	0	0	0
1493	SAN JORGE	MA0101022	5	0	0
1494	SAN ANTONIO	MA0101022	0	0	0
1495	SUPREMA	MA0102096	0	0	0
1496	SUPREMA	RE0316014	15	0	2
1497	GRS	RE0309022	0	0	0
1498	PALMAS	IN0106001	129	0	13
1499	SUPREMA	RE0302044	1	0	0
1500	PALMAS	RE0302073	0	0	0
1501	SUPREMA	MA0102097	4	1	0
1502	SUPREMA	RE0316012	26	0	0
1503	PALMAS	MA0108056	0	0	0
1504	SUPREMA	MA0107015	0	0	0
1505	PALMAS	RE0312006	0	0	0
1506	ALFA	MA0102069	0	0	0
1507	PALMAS	RE0309014	0	0	0
1508	GRS	RE0309030	0	0	0
1509	PALMAS	RE0302052	0	0	0
1510	SUPREMA	RE0101040	1	0	0
1511	SAN JORGE	MA0202009	0	0	0
1512	GRS	MA0106001	0	0	0
1513	ACACIAS	MA0108004	0	0	0
1514	SAN JORGE	MA0108004	0	0	0
1515	SUPREMA	RE0304045	0	0	0
1516	SAN ANTONIO	MA0102104	0	0	0
1517	PALMAS	MA0107024	0	0	0
1518	ALFA	MA0102042	35	0	0
1519	PALMAS	RE0310012	0	0	0
1520	SUPREMA	RE0101048	0	0	0
1521	PALMAS	RE0306052	9	0	1
1522	PALMAS	RE0314036	0	0	0
1523	PALMAS	RE0101094	4	0	0
1524	SUPREMA	RE0304009	0	0	0
1525	SAN FRANCISCO	MA0202025	0	0	0
1526	SAN ANTONIO	MA0202022	0	0	0
1527	SAN JORGE	MA0202022	0	0	0
1528	SUPREMA	MA0107013	0	0	0
1529	SUPREMA	MA0107014	0	0	0
1530	PALMAS	MA0102079	0	0	0
1531	SUPREMA	RE0201157	0	0	0
1532	SUPREMA	RE0304161	0	0	0
1533	SUPREMA	MA0103007	0	0	0
1534	PALMAS	RE0306056	0	0	0
1535	QUIRICA	RE0302001	0	0	0
1536	SAN FRANCISCO	MA0202017	0	0	0
1537	SAN JORGE	RE0302001	3	0	0
1538	SUPREMA	MA0108030	16	0	0
1539	PALMAS	RE0101090	6	0	0
1540	GRS	RE0201033	0	0	0
1541	SUPREMA	RE0201014	0	0	0
1542	GRS	RE0302014	0	0	0
1543	GRS	MA0108010	0	0	0
1544	SUPREMA	MA0109001	7	0	0
1545	SAN JORGE	IN0304003	0	0	0
1546	SUPREMA	RE0101014	2	0	0
1547	PALMAS	RE0308047	0	0	0
1548	SAN JORGE	MA0202004	0	0	0
1549	PALMAS	RE0308044	0	0	0
1550	SAN JORGE	MA0202035	1	0	0
1551	SAN JORGE	IN0301020	0	0	0
1552	PALMAS	MA0108045	4	0	0
1553	PALMAS	RE0304014	0	0	0
1554	SUPREMA	RE0101047	2	0	0
1555	PALMAS	RE0317003	0	0	0
1556	SUPREMA	RE0309016	2	0	0
1557	PALMAS	MA0102159	0	0	0
1558	SUPREMA	RE0317091	17	2	2
1559	SAN JORGE	MA0104015	0	0	0
1560	ACACIAS	MA0108001	0	0	0
1561	PALMAS	RE0306008	5	0	0
1562	SUPREMA	RE0201004	3	0	0
1563	ACACIAS	MA0202001	0	0	0
1564	SUPREMA	RE0201069	0	0	0
1565	PALMAS	RE0306055	0	0	0
1566	SUPREMA	RE0304162	0	0	0
1567	PALMAS	RE0101091	5	0	0
1568	PALMAS	RE0302040	0	0	0
1569	PALMAS	RE0308018	0	0	0
1570	SAN ANTONIO	MA0102068	0	0	0
1571	GRS	RE0310002	0	0	0
1572	PALMAS	RE0103014	0	0	0
1573	PALMAS	RE0302043	0	0	0
1574	ALFA	MA0104006	0	0	0
1575	SAN FRANCISCO	MA0101018	0	0	0
1576	SAN ANTONIO	MA0101018	0	0	0
1577	SAN JORGE	MA0101018	0	0	0
1578	SAN FRANCISCO	MA0101004	0	0	0
1579	ALFA	MA0102004	0	0	0
1580	PALMAS	RE0306068	0	0	0
1581	ALFA	RE0302001	0	0	0
1582	ALFA	MA0103011	0	0	0
1583	GRS	RE0309026	0	0	0
1584	SUPREMA	RE0317039	0	0	0
1585	SUPREMA	RE0316017	16	0	0
1586	PALMAS	MA0108036	0	0	0
1587	SUPREMA	MA0107034	0	0	0
1588	PALMAS	RE0103040	0	0	0
1589	PALMAS	MA0105024	0	0	0
1590	PALMAS	RE0306023	1	0	0
1591	ACACIAS	RE0302001	0	0	0
1592	METALMECANICA	RE0316006	0	0	0
1593	SUPREMA	RE0302025	0	0	0
1594	SAN FRANCISCO	MA0102017	0	0	0
1595	SUPREMA	RE0302042	1	0	0
1596	PALMAS	RE0201039	1	0	0
1597	SUPREMA	MA0108022	9	0	0
1598	SAN FRANCISCO	MA0202022	0	0	0
1599	PALMAS	RE0303046	0	0	0
1600	SAN ANTONIO	IN0303001	0	0	0
1601	PALMAS	RE0306021	0	0	0
1602	SUPREMA	MA0102092	0	0	0
1603	SAN ANTONIO	MA0202032	1	0	0
1604	PALMAS	MA0108053	0	0	0
1605	PALMAS	RE0306040	1	0	0
1606	SAN JORGE	RE0308001	0	0	0
1607	SUPREMA	RE0201127	0	0	0
1608	GRS	RE0309045	0	0	0
1609	PALMAS	MA0102022	0	0	0
1610	SAN FRANCISCO	MA0202004	0	0	0
1611	SUPREMA	RE0304132	0	0	0
1612	SUPREMA	MA0108008	13	0	0
1613	PALMAS	RE0103041	0	0	0
1614	SAN FRANCISCO	MA0101022	1	0	0
1615	SAN FRANCISCO	IN0303001	0	0	0
1616	SUPREMA	RE0201144	0	0	0
1617	PALMAS	RE0201018	87	0	9
1618	QUIRICA	MA0202023	4	0	0
1619	ACACIAS	MA0202023	0	0	0
1620	SAN FRANCISCO	MA0202023	0	0	0
1621	SAN JORGE	MA0202023	0	0	0
1622	SUPREMA	MA0108016	0	0	0
1623	SUPREMA	RE0309007	5	2	0
1624	PALMAS	RE0306007	15	0	2
1625	PALMAS	RE0302031	0	0	0
1626	PALMAS	RE0307013	0	0	0
1627	PALMAS	RE0201058	0	0	0
1628	ACACIAS	MA0102067	0	0	0
1629	SUPREMA	MA0102099	1	0	0
1630	SAN FRANCISCO	MA0202035	1	0	0
1631	SUPREMA	MA0101021	0	0	0
1632	PALMAS	RE0306010	0	0	0
1633	SUPREMA	RE0201155	1	0	0
1634	SAN FRANCISCO	MA0104005	0	0	0
1635	SAN ANTONIO	MA0102109	0	0	0
1636	SAN FRANCISCO	IN0304001	0	0	0
1637	PALMAS	RE0302033	0	0	0
1638	ALFA	RE0310013	0	0	0
1639	GRS	MA0101008	0	0	0
1640	SUPREMA	RE0302029	0	0	0
1641	SAN ANTONIO	IN0304002	0	0	0
1642	GRS	IN0501004	0	0	0
1643	SAN JORGE	IN0303001	0	0	0
1644	GRS	RE0302006	0	0	0
1645	PALMAS	RE0302049	1	0	0
1646	PALMAS	MA0108064	0	0	0
1647	PALMAS	RE0312019	0	0	0
1648	SUPREMA	MA0109002	0	0	0
1649	SUPREMA	RE0308046	0	0	0
1650	SAN JORGE	MA0202032	2	0	0
1651	SAN FRANCISCO	MA0202032	1	0	0
1652	SUPREMA	RE0317012	0	0	0
1653	PALMAS	RE0302050	0	0	0
1654	SUPREMA	RE0316011	22	0	0
1655	SAN ANTONIO	MA0202005	0	0	0
1656	SAN FRANCISCO	MA0202005	0	0	0
1657	SAN JORGE	MA0202005	0	0	0
1658	PALMAS	RE0303035	3	0	0
1659	PALMAS	MA0102089	0	0	0
1660	SAN JORGE	IN0304002	0	0	0
1661	SUPREMA	MA0108013	0	0	0
1662	SUPREMA	RE0201066	0	0	0
1663	SUPREMA	MA0108020	25	9	0
1664	SUPREMA	RE0103010	0	0	0
1665	SUPREMA	RE0101004	0	0	0
1666	PALMAS	MA0101026	1	0	0
1667	SUPREMA	MA0108029	8	0	0
1668	GRS	MA0102024	1	0	0
1669	PALMAS	RE0302048	0	0	0
1670	SAN ANTONIO	IN0304001	0	0	0
1671	SUPREMA	MA0102113	0	0	0
1672	GRS	MA0101011	0	0	0
1673	GRS	MA0101007	0	0	0
1674	SUPREMA	RE0307002	0	0	0
1675	SUPREMA	RE0201038	0	0	0
1676	PALMAS	RE0302047	0	0	0
1677	SUPREMA	RE0307003	23	0	0
1678	PALMAS	RE0301008	0	0	0
1679	PALMAS	RE0314027	0	0	0
1680	PALMAS	RE0307015	0	0	0
1681	SUPREMA	MA0108003	0	0	0
1682	SAN JORGE	MA0108002	0	0	0
1683	PALMAS	RE0201061	0	0	0
1684	PALMAS	MA0108063	0	0	0
1685	PALMAS	RE0302041	0	0	0
1686	PALMAS	RE0302030	0	0	0
1687	GRS	RE0309091	0	0	0
1688	SUPREMA	MA0108012	0	0	0
1689	PALMAS	RE0306041	0	0	0
1690	SAN FRANCISCO	MA0101006	0	0	0
1691	SAN ANTONIO	MA0101006	0	0	0
1692	SAN JORGE	MA0101006	0	0	0
1693	GRS	IN0403016	4	0	0
1694	GRS	MA0102012	0	0	0
1695	GRS	RE0309081	0	0	0
1696	PALMAS	RE0303034	0	0	0
1697	SAN FRANCISCO	MA0102068	0	0	0
1698	SUPREMA	RE0302026	0	0	0
1699	ALFA	MA0102067	0	0	0
1700	PALMAS	RE0302100	0	0	0
1701	SUPREMA	RE0201061	0	0	0
1702	GRS	RE0309063	0	0	0
1703	PALMAS	RE0302032	0	0	0
1704	GRS	MA0102036	0	0	0
1705	SUPREMA	RE0309008	0	0	0
1706	GRS	MA0101012	0	0	0
1707	GRS	MA0108022	0	0	0
1708	SUPREMA	RE0201111	0	0	0
1709	ACACIAS	MA0102068	0	0	0
1710	SAN FRANCISCO	MA0103005	0	0	0
1711	SAN ANTONIO	MA0103005	0	0	0
1712	GRS	RE0309047	1	0	0
1713	PALMAS	MA0102019	1	0	0
1714	PALMAS	RE0306014	0	0	0
1715	SAN FRANCISCO	IN0304002	0	0	0
1716	SAN ANTONIO	MA0202018	0	0	0
1717	SAN JORGE	MA0202016	0	0	0
1718	SAN ANTONIO	MA0202016	0	0	0
1719	SAN FRANCISCO	MA0202016	0	0	0
1720	PALMAS	RE0103060	10	2	0
1721	PALMAS	MA0108038	0	0	0
1722	PALMAS	RE0302039	0	0	0
1723	SAN FRANCISCO	MA0104002	1	0	0
1724	PALMAS	MA0108059	0	0	0
1725	ALFA	MA0102037	0	0	0
1726	QUIRICA	MA0102068	0	0	0
1727	SUPREMA	RE0201041	0	0	0
1728	PALMAS	RE0306035	0	0	0
1729	SAN ANTONIO	MA0108006	0	0	0
1730	PALMAS	RE0303030	26	0	0
1731	PALMAS	RE0306034	0	0	0
1732	SAN FRANCISCO	MA0101024	0	0	0
1733	SAN JORGE	MA0101024	0	0	0
1734	SAN ANTONIO	MA0101024	0	0	0
1735	SUPREMA	MA0108045	14	0	0
1736	SAN JORGE	IN0304001	0	0	0
1737	PALMAS	MA0108061	0	0	0
1738	SUPREMA	MA0102023	0	0	0
1739	ACACIAS	MA0108002	0	0	0
1740	SUPREMA	RE0103015	0	0	0
1741	SUPREMA	RE0103016	3	0	0
1742	SUPREMA	RE0103017	0	0	0
1743	GRS	MA0102011	0	0	0
1744	ALFA	MA0202031	0	0	0
1745	SUPREMA	MA0108021	0	0	0
1746	PALMAS	RE0311013	0	0	0
1747	ALFA	MA0101029	0	0	0
1748	ACACIAS	MA0101029	0	0	0
1749	ACACIAS	MA0101021	0	0	0
1750	SUPREMA	RE0201037	0	0	0
1751	GRS	MA0102027	0	0	0
1752	PALMAS	MA0108060	0	0	0
1753	GRS	MA0102023	0	0	0
1754	SAN ANTONIO	MA0108007	0	0	0
1755	SUPREMA	RE0201143	3	0	0
1756	PALMAS	MA0108039	0	0	0
1757	SUPREMA	MA0103017	0	0	0
1758	SAN JORGE	MA0103005	0	0	0
1759	GRS	RE0309062	0	0	0
1760	SUPREMA	RE0316013	3	0	0
1761	PALMAS	MA0108006	0	0	0
1762	SUPREMA	RE0201039	0	0	0
1763	SAN FRANCISCO	MA0202018	0	0	0
1764	SAN JORGE	MA0202018	0	0	0
1765	ACACIAS	MA0101006	0	0	0
1766	GRS	MA0108013	0	0	0
1767	GRS	MA0102013	12	0	0
1768	SUPREMA	MA0108009	7	0	1
1769	SAN ANTONIO	MA0202031	0	0	0
1770	SUPREMA	RE0201122	59	15	6
1771	PALMAS	MA0108009	0	0	0
1772	PALMAS	RE0303033	0	0	0
1773	GRS	MA0108019	0	0	0
1774	ALFA	MA0101028	0	0	0
1775	SUPREMA	MA0108023	0	0	0
1776	GRS	MA0102022	0	0	0
1777	SAN ANTONIO	MA0202029	0	0	0
1778	SAN FRANCISCO	MA0202029	0	0	0
1779	SAN JORGE	MA0202029	0	0	0
1780	GRS	MA0101010	1	0	0
1781	GRS	MA0102017	0	0	0
1782	SAN ANTONIO	MA0102032	0	0	0
1783	PALMAS	MA0108010	0	0	0
1784	SAN JORGE	MA0202031	0	0	0
1785	SAN FRANCISCO	MA0202031	0	0	0
1786	GRS	MA0102005	1	0	0
1787	SUPREMA	MA0108035	6	0	0
1788	ALFA	MA0102033	1	0	0
1789	ALFA	MA0102006	0	0	0
1790	ALFA	MA0202028	2	0	0
1791	GRS	MA0102048	0	0	0
1792	SUPREMA	MA0102018	0	0	0
1793	SUPREMA	RE0303018	0	0	0
\.


--
-- Data for Name: homologacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.homologacion (id, codigo_corporativo, empresa, codigo_local, descripcion_local, precio_prom) FROM stdin;
1	CORP-00015	SUPREMA	MP0201002	ACEITE CRUDO DE PALMA	8.7227
2	CORP-00015	TASINSA	PT49400000501	ACEITE CRUDO DE PALMA	7.6014
3	CORP-00015	PALMAS	PT09211001101	ACEITE CRUDO DE PALMA	8.7087
4	CORP-00022	PALMAS	MA0105006	ACEITE RIMULA No. SAE-50 (GLS)	82.32
5	CORP-00022	ACACIAS	MA0105007	ACEITE RIMULA No. SAE-50 (GLS)	72.2909
6	CORP-00022	SAN ANTONIO	MA0105007	ACEITE RIMULA No. SAE-50 (GLS)	89.3047
7	CORP-00025	PALMAS	MA0105007	ACEITE SAE No. 15W-40  CI-4 PLUS/SL  (GLS) (TONEL)	79.6765
8	CORP-00025	SAN ANTONIO	MA0105003	ACEITE SAE No. 15W-40  CI-4 PLUS/SL  (GLS)	78.4
9	CORP-00027	PALMAS	MA0105009	ACEITE SPIRAX HD SAE No. 85W-140 (GLS)	91.578
10	CORP-00027	ACACIAS	MA0105004	ACEITE SPIRAX HD SAE No. 85W-140 (GLS)	89.651
11	CORP-00030	PALMAS	MA0105011	ACEITE UNO SPIRAX S4 CX 10W TO-4 (GLS)	100.0443
12	CORP-00030	ACACIAS	MA0105005	ACEITE UNO SPIRAX S4 CX 10W TO-4 (GLS)	71.5272
13	CORP-00038	SUPREMA	IN0201001	ACIDO CITRICO	9.0242
14	CORP-00038	PALMAS	IN0202002	ACIDO CITRICO	7.6403
15	CORP-00047	ACACIAS	MA0102004	ADAPTADOR INYECTADO 3/4" LISO A 1/2" CON ROSCA	2.0427
16	CORP-00047	QUIRICA	MA0102012	ADAPTADOR INYECTADO 3/4" LISO A 1/2" CON ROSCA	1.9296
17	CORP-00050	SAN ANTONIO	MA0102017	ADAPTADOR MACHO PVC 3	15.625
18	CORP-00050	SAN FRANCISCO	MA0102017	ADAPTADOR MACHO PVC 3	15.625
19	CORP-00055	SAN JORGE	IN0302006	ADHERENTE DISAWET MAX	82.5497
20	CORP-00055	SAN ANTONIO	IN0301017	ADHERENTE DISAWET MAX	75.1741
21	CORP-00055	ACACIAS	IN0302006	ADHERENTE DISAWET MAX	87.753
22	CORP-00055	QUIRICA	IN0302006	ADHERENTE DISAWET MAX	91.1853
23	CORP-00059	PALMAS	05-0560-01	AIRE ACONDICIONADO	11428.5714
24	CORP-00059	SUPREMA	05-0554-02	AIRE ACONDICIONADO	9680.0357
25	CORP-00059	SUPREMA	05-0546-02	AIRE ACONDICIONADO	9680.0357
26	CORP-00059	SUPREMA	05-0576-02	AIRE ACONDICIONADO	4665.1696
27	CORP-00059	PALMAS	05-0621-01	AIRE ACONDICIONADO	4464.2768
28	CORP-00059	SUPREMA	05-0547-02	AIRE ACONDICIONADO	3936.4286
29	CORP-00059	PALMAS	05-0618-01	AIRE ACONDICIONADO	3770.8304
30	CORP-00059	SUPREMA	05-0551-02	AIRE ACONDICIONADO	2678.5714
31	CORP-00059	SUPREMA	05-0555-02	AIRE ACONDICIONADO	2289.3304
32	CORP-00059	SUPREMA	05-0556-02	AIRE ACONDICIONADO	2289.3304
33	CORP-00059	PALMAS	05-0568-01	AIRE ACONDICIONADO	1632.7232
34	CORP-00059	PALMAS	05-0561-01	AIRE ACONDICIONADO	1632.7232
35	CORP-00066	SAN ANTONIO	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	301.5873
36	CORP-00066	SAN JORGE	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	302.0833
37	CORP-00066	SAN FRANCISCO	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	301.7857
38	CORP-00066	ALFA	MA0103010	ALAMBRE PUAS GALV. 400 VARAS	299.1071
39	CORP-00085	SAN ANTONIO	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	37.0536
40	CORP-00085	SAN JORGE	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	37.0536
41	CORP-00085	SAN FRANCISCO	MA0202035	ANTIBIOTICO AGRIPEN FORTE 6 MILLONES	37.0536
42	CORP-00091	ALFA	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	71.4286
43	CORP-00091	SAN ANTONIO	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	71.4286
44	CORP-00091	SAN JORGE	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	71.4286
45	CORP-00091	SAN FRANCISCO	MA0202022	ARGOLLA NARIGUERA DE BRONCE 3/8""X3"	71.4286
46	CORP-00092	SAN FRANCISCO	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	316.9643
47	CORP-00092	SAN ANTONIO	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	316.9643
48	CORP-00092	SAN JORGE	MA0101001	ARNES SEGURIDAD INDUSTRIAL CON LINEA VIDA DE 3 PUNTOS	316.9643
49	CORP-00113	SUPREMA	04-0417-02	BASCULA ELECTRONICA	35625
50	CORP-00113	PALMAS	05-0593-01	BÁSCULA ELECTRÓNICA	2136.6518
51	CORP-00116	SAN JORGE	MA0101002	BATA TIPO GABACHA PVC	43.75
52	CORP-00116	SAN FRANCISCO	MA0101002	BATA TIPO GABACHA PVC	40.1786
53	CORP-00116	SAN ANTONIO	MA0101002	BATA TIPO GABACHA PVC	40.1786
54	CORP-00175	SAN ANTONIO	05-0035-05	BUZON EN MADERA DE PALO BLANCO	2500
55	CORP-00175	ALFA	05-0016-08	BUZÓN EN MADERA DE PALO BLANCO	2500
56	CORP-00175	SAN JORGE	05-0042-04	BUZÓN EN MADERA DE PALO BLANCO	2500
57	CORP-00232	PALMAS	06-0442-01	CAMARA	6451.5268
58	CORP-00232	SUPREMA	06-0545-02	CAMARA	6451.5268
59	CORP-00232	SUPREMA	06-0518-02	CAMARA	5088.3929
60	CORP-00235	PALMAS	05-0608-01	CAMILLA	2053.5714
61	CORP-00235	SUPREMA	06-0527-02	CAMILLA	1875
62	CORP-00235	PALMAS	05-0595-01	CAMILLA	1408.0357
63	CORP-00235	PALMAS	05-0594-01	CAMILLA	1408.0357
64	CORP-00253	SAN JORGE	MA0101004	CARETA ESMERILAR, COMPLETA	27.6786
65	CORP-00253	SAN ANTONIO	MA0101004	CARETA ESMERILAR, COMPLETA	27.6786
66	CORP-00253	SAN FRANCISCO	MA0101004	CARETA ESMERILAR, COMPLETA	27.6786
67	CORP-00258	SAN FRANCISCO	MA0101006	CASCO CLIMAX SEGURIDAD INDUSTRIAL COLOR AZUL	31.25
68	CORP-00258	SAN JORGE	MA0101006	CASCO CLIMAX SEGURIDAD INDUSTRIAL COLOR AZUL	31.25
69	CORP-00299	SAN ANTONIO	MA0202032	CICATRIZANTE TOPAZONE SPRAY	89.2857
70	CORP-00299	SAN JORGE	MA0202032	CICATRIZANTE TOPAZONE SPRAY	87.0536
71	CORP-00299	SAN FRANCISCO	MA0202032	CICATRIZANTE TOPAZONE SPRAY	87.0536
72	CORP-00332	SAN ANTONIO	MA0101009	CINTURON CUERO PARA FUERZA (4 TALLA M Y 4 TALLA S)	71.4286
73	CORP-00332	SAN JORGE	MA0101009	CINTURON CUERO PARA FUERZA (4 TALLA M Y 4 TALLA S)	71.4286
74	CORP-00345	ACACIAS	MA0102035	CODO PVC 10 X 45°  (LISO)	1817.3571
75	CORP-00345	ALFA	MA0102035	CODO PVC 10 X 45°  (LISO)	1720.9464
76	CORP-00357	QUIRICA	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	77.4821
77	CORP-00357	SAN JORGE	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	79.4643
78	CORP-00357	ACACIAS	RE0302002	COJINETE # 6207 2RS1/C3 (MARCA SKF)	61.6071
79	CORP-00357	ALFA	RE0302002	COJINETE # 6207 2RS1/C3  (MARCA SKF)	94.3839
80	CORP-00393	QUIRICA	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	33.9286
81	CORP-00393	SAN JORGE	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	33.9286
82	CORP-00393	ALFA	RE0302001	COJINETE No. 6204 2RS1/C3  (MARCA SKF)	40.4107
83	CORP-00393	ACACIAS	RE0302001	COJINETE No. 6204 2RS1/C3 (MARCA SKF)	30.3571
84	CORP-00442	SAN JORGE	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
85	CORP-00442	SAN ANTONIO	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
86	CORP-00442	SAN FRANCISCO	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
87	CORP-00442	ACACIAS	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
88	CORP-00442	QUIRICA	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
89	CORP-00442	ALFA	IN0302004	CORRECTOR DE AGUA PH PRO BUFFER	93.75
90	CORP-00451	SAN JORGE	MA0101026	CUCHILLO MALAYO M222-B	207.0312
91	CORP-00451	SAN ANTONIO	MA0101026	CUCHILLO MALAYO M222-B	207.5708
92	CORP-00451	QUIRICA	MA0101026	CUCHILLO MALAYO M222-B	207.5893
93	CORP-00451	SAN FRANCISCO	MA0101026	CUCHILLO MALAYO M222-B	207.5893
94	CORP-00451	ACACIAS	MA0101026	CUCHILLO MALAYO M222-B	209.7482
95	CORP-00451	ALFA	MA0101026	CUCHILLO MALAYO M222-B	205.3571
96	CORP-00462	SAN ANTONIO	MA0202030	DESPARASITANTE IVOMEC 250 ML.	1026.7857
97	CORP-00462	SAN JORGE	MA0202030	DESPARASITANTE IVOMEC 250 ML.	1026.7857
98	CORP-00462	SAN FRANCISCO	MA0202030	DESPARASITANTE IVOMEC 250 ML.	1026.7857
99	CORP-00466	PALMAS	MA0105017	DIESEL	25.8372
100	CORP-00466	SUPREMA	MA0105010	DIESEL	26.6446
101	CORP-00470	SAN JORGE	MA0202016	DIPIRON 500 FRASCO 100 ML	82.0714
102	CORP-00470	SAN ANTONIO	MA0202016	DIPIRON 500 FRASCO 100 ML	81.4286
103	CORP-00470	SAN FRANCISCO	MA0202016	DIPIRON 500 FRASCO 100 ML	81.4286
104	CORP-00485	PALMAS	05-0580-01	DISPENSADOR DE AGUA	2008.9286
105	CORP-00485	PALMAS	05-0579-01	DISPENSADOR DE AGUA	2008.9286
106	CORP-00485	SUPREMA	05-0557-02	DISPENSADOR DE AGUA	2008.9286
107	CORP-00485	SUPREMA	05-0558-02	DISPENSADOR DE AGUA	2008.9286
108	CORP-00485	SUPREMA	05-0565-02	DISPENSADOR DE AGUA	2008.9286
109	CORP-00485	SUPREMA	05-0566-02	DISPENSADOR DE AGUA	2008.9286
110	CORP-00485	PALMAS	05-0605-01	DISPENSADOR DE AGUA	1606.25
111	CORP-00485	PALMAS	05-0604-01	DISPENSADOR DE AGUA	1606.25
112	CORP-00543	SAN FRANCISCO	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	66.369
113	CORP-00543	SAN ANTONIO	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	66.369
114	CORP-00543	SAN JORGE	MA0101010	ESPINILLERA CHAPEO (CAÑERA)	66.369
115	CORP-00543	QUIRICA	MA0101010	ESPINILLERA CHAPEO	67.8571
116	CORP-00667	SAN ANTONIO	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	58.0357
117	CORP-00667	SAN JORGE	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	58.0357
118	CORP-00667	SAN FRANCISCO	MA0101011	FILTROS 3M CODIGO 2097 (CON CARBON ACTIVO)	58.0357
119	CORP-00680	ALFA	IN0305003	FORMULA 1	178.2723
120	CORP-00680	ACACIAS	IN0305003	FORMULA 1	178.2723
121	CORP-00680	SAN ANTONIO	IN0305003	FORMULA 1	178.2723
122	CORP-00681	ALFA	IN0305016	FÓRMULA 1 (45.36kg)	216.7955
123	CORP-00681	ACACIAS	IN0305016	FÓRMULA 1 (45.36kg)	216.7955
124	CORP-00681	SAN ANTONIO	IN0305015	FÓRMULA 1 (45.36kg)	216.7955
125	CORP-00683	SAN ANTONIO	IN0305004	FORMULA 2	167.4121
126	CORP-00683	QUIRICA	IN0305004	FORMULA 2	167.4121
127	CORP-00688	SAN ANTONIO	IN0305017	FÓRMULA 3 (45.36kg)	223.8308
128	CORP-00688	SAN JORGE	IN0305017	FÓRMULA 3 (45.36kg)	223.8308
129	CORP-00688	ALFA	IN0305018	FÓRMULA 3 (45.36kg)	223.8308
130	CORP-00689	SAN ANTONIO	IN0305005	FORMULA 3	193.1528
131	CORP-00689	SAN JORGE	IN0305005	FORMULA 3	192.1281
132	CORP-00689	QUIRICA	IN0305005	FORMULA 3  (SACO 50 KILOS)	227.0411
133	CORP-00689	ALFA	IN0305005	FORMULA 3	218.3939
134	CORP-00689	ACACIAS	IN0305005	FORMULA 3  (SACO 50 KILOS)	227.0411
135	CORP-00689	SAN FRANCISCO	IN0305005	FORMULA 3	196.7863
136	CORP-00690	SAN ANTONIO	IN0305018	FÓRMULA 4 (45.36kg)	223.8991
137	CORP-00690	SAN JORGE	IN0305018	FÓRMULA 4 (45.36kg)	223.8991
138	CORP-00691	SAN ANTONIO	IN0305009	FORMULA 4	222.9405
139	CORP-00691	QUIRICA	IN0305006	FORMULA 4  (SACO 50 KILOS)	234.008
140	CORP-00691	ALFA	IN0305006	FORMULA 4  (SACO 50 KILOS)	234.008
141	CORP-00691	ACACIAS	IN0305006	FORMULA 4  (SACO 50 KILOS)	234.008
142	CORP-00691	SAN JORGE	IN0305006	FORMULA 4	220.4852
143	CORP-00691	SAN FRANCISCO	IN0305006	FORMULA 4	234.008
144	CORP-00693	ACACIAS	IN0305020	FÓRMULA 5 (45.36kg)	224.7871
145	CORP-00693	SAN ANTONIO	IN0305019	FÓRMULA 5 (45.36kg)	224.7871
146	CORP-00693	ALFA	IN0305020	FÓRMULA 5 (45.36kg)	224.7871
147	CORP-00694	SAN ANTONIO	IN0305006	FORMULA 5	220.9619
148	CORP-00694	ACACIAS	IN0305007	FORMULA 5	216.6356
149	CORP-00694	QUIRICA	IN0305007	FORMULA 5	215.5842
150	CORP-00694	ALFA	IN0305007	FORMULA 5	217.3082
151	CORP-00694	SAN JORGE	IN0305007	FORMULA 5  (SACO 50 KILOS)	225.1969
152	CORP-00695	ACACIAS	IN0305008	FORMULA 6	217.7406
153	CORP-00695	ALFA	IN0305008	FORMULA 6	218.7763
154	CORP-00695	SAN FRANCISCO	IN0305008	FORMULA 6	210.4433
155	CORP-00697	ACACIAS	IN0305021	FÓRMULA 6 (45.36kg)	223.2161
156	CORP-00697	ALFA	IN0305021	FÓRMULA 6 (45.36kg)	223.2161
157	CORP-00697	SAN ANTONIO	IN0305020	FÓRMULA 6 (45.36kg)	223.2161
158	CORP-00698	SAN ANTONIO	IN0305007	FORMULA 6	221.6691
159	CORP-00698	QUIRICA	IN0305008	FORMULA 6	215.6411
160	CORP-00698	SAN JORGE	IN0305008	FORMULA 6  (SACO 50 KILOS)	222.2598
161	CORP-00699	ALFA	IN0305009	FORMULA 7	210.7848
162	CORP-00699	QUIRICA	IN0305009	FORMULA 7	210.7848
163	CORP-00699	SAN FRANCISCO	IN0305009	FORMULA 7	239.7816
164	CORP-00699	SAN ANTONIO	IN0305008	FORMULA 7	210.5035
165	CORP-00699	SAN JORGE	IN0305009	FORMULA 7	210.7848
166	CORP-00699	ACACIAS	IN0305009	FORMULA 7	210.7848
167	CORP-00700	QUIRICA	IN0305021	FÓRMULA 7 (45.36 kg)	223.8991
168	CORP-00700	SAN FRANCISCO	IN0305021	FÓRMULA 7 (45.36 kg)	224.3089
169	CORP-00701	ALFA	IN0305022	FÓRMULA 7 (45.36kg)	223.8991
170	CORP-00701	SAN ANTONIO	IN0305021	FÓRMULA 7 (45.36kg)	223.8991
171	CORP-00701	SAN JORGE	IN0305021	FÓRMULA 7 (45.36kg)	223.8991
172	CORP-00701	ACACIAS	IN0305022	FÓRMULA 7 (45.36kg)	223.8991
173	CORP-00702	SAN FRANCISCO	IN0305013	FORMULA 8	198.2853
174	CORP-00702	SAN ANTONIO	IN0305013	FORMULA 8	198.2853
175	CORP-00702	QUIRICA	IN0305013	FORMULA 8	198.2853
176	CORP-00702	ACACIAS	IN0305014	FORMULA 8	198.2853
177	CORP-00704	ALFA	IN0305023	FÓRMULA 8 (45.36kg)	219.3911
178	CORP-00704	SAN ANTONIO	IN0305022	FÓRMULA 8 (45.36kg)	219.3911
179	CORP-00704	ACACIAS	IN0305023	FÓRMULA 8 (45.36kg)	219.3911
180	CORP-00724	QUIRICA	MA0101041	FUNDA CUERO PARA MALAYO	116.0714
181	CORP-00724	ACACIAS	MA0101041	FUNDA CUERO PARA MALAYO	116.0714
182	CORP-00724	SAN FRANCISCO	MA0101041	FUNDA CUERO PARA MALAYO	116.0714
183	CORP-00724	SAN JORGE	MA0101041	FUNDA CUERO PARA MALAYO	116.0714
184	CORP-00724	SAN ANTONIO	MA0101041	FUNDA CUERO PARA MALAYO	116.0714
185	CORP-00725	SAN FRANCISCO	IN0304001	FUNGICIDA CLOROTAC 72 SC	67.2857
186	CORP-00725	SAN ANTONIO	IN0304001	FUNGICIDA CLOROTAC 72 SC	75.3839
187	CORP-00725	SAN JORGE	IN0304001	FUNGICIDA CLOROTAC 72 SC	67.3036
188	CORP-00726	SAN ANTONIO	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	59.9387
189	CORP-00726	SAN JORGE	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	53.5156
190	CORP-00726	SAN FRANCISCO	IN0304002	FUNGICIDA FUNGITANE 80WP BOLSA 800 GRAMOS	53.5156
191	CORP-00727	SAN FRANCISCO	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	384.2411
192	CORP-00727	SAN ANTONIO	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	430.3482
193	CORP-00727	SAN JORGE	IN0304003	FUNGICIDA HALCON EXTRA 28 SC	384.2411
194	CORP-00748	PALMAS	MA0105019	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	19.6647
195	CORP-00748	SAN JORGE	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	23.9222
196	CORP-00748	ALFA	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	19.1367
197	CORP-00748	SAN FRANCISCO	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	19.1367
198	CORP-00748	SAN ANTONIO	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	17.4
199	CORP-00748	QUIRICA	MA0105008	GRASA CHASIS ALVANIA EP-2 = UNO AXXIS  (LBS.)	19.1367
200	CORP-00756	SAN JORGE	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	23.4127
201	CORP-00756	SAN FRANCISCO	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	23.4127
202	CORP-00756	SAN ANTONIO	MA0101013	GUANTES CORTOS DE PIEL CERDO TALLA L	23.4127
203	CORP-00756	ALFA	MA0101013	GUANTES CORTOS DE PIEL CERDO	21.4286
204	CORP-00756	ACACIAS	MA0101013	GUANTES CORTOS DE PIEL CERDO	21.4286
205	CORP-00757	PALMAS	MA0101022	GUANTES CUERO MEDIA MANGA, ENGUATADOS	43.2277
206	CORP-00757	METALMECANICA	RE0309137	GUANTES CUERO MEDIA MANGA  (HILO KEVLAR, ENGUATADOS COLOR AZUL)	46.4286
207	CORP-00758	SAN FRANCISCO	MA0101015	GUANTES NITRILO	12.5
208	CORP-00758	SAN ANTONIO	MA0101015	GUANTES NITRILO	12.5
209	CORP-00758	SAN JORGE	MA0101015	GUANTES NITRILO	12.5
210	CORP-00773	SAN FRANCISCO	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	7.5625
211	CORP-00773	SAN ANTONIO	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	7.3661
212	CORP-00773	SAN JORGE	IN0301020	HERBICIDA ESKOBIYOL 60WP (10 GRAMOS)	7.3661
213	CORP-00774	SAN ANTONIO	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	29.2592
214	CORP-00774	SAN JORGE	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	28.9867
215	CORP-00774	ACACIAS	IN0301001	HERBICIDA GLIFOSATO ALEMAN 35.6 SL	30.8036
216	CORP-00774	SAN FRANCISCO	IN0301005	HERBICIDA GLIFOSATO ALEMAN 35,6 SL	28.5973
217	CORP-00775	QUIRICA	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	27.7149
218	CORP-00775	ACACIAS	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	27.7149
219	CORP-00775	ALFA	IN0301023	HERBICIDA PANTEK 36 SL ( GLIFOSATO)	27.7149
220	CORP-00800	SAN ANTONIO	IN0303001	INSECTICIDA ARTILLERO 25 EC	68
221	CORP-00800	SAN FRANCISCO	IN0303001	INSECTICIDA ARTILLERO 25 EC	60.7143
222	CORP-00800	SAN JORGE	IN0303001	INSECTICIDA ARTILLERO 25 EC	60.7143
223	CORP-00801	ACACIAS	IN0303010	INSECTICIDA BIOLOGICO COSTAR 18 WG (KILO)	423.1406
224	CORP-00801	SAN JORGE	IN0303010	INSECTICIDA BIOLOGICO COSTAR 18 WG (KILO)	423.1406
225	CORP-00803	SAN ANTONIO	IN0303003	INSECTICIDA FIADOR 35 SC	355
226	CORP-00803	SAN FRANCISCO	IN0303003	INSECTICIDA FIADOR 35 SC	316.6429
227	CORP-00803	SAN JORGE	IN0303003	INSECTICIDA FIADOR 35 SC	316.9643
228	CORP-00804	SAN ANTONIO	MA0202009	INSECTICIDA HECTOGAN	361.6071
229	CORP-00804	SAN FRANCISCO	MA0202009	INSECTICIDA HECTOGAN	361.6071
230	CORP-00804	SAN JORGE	MA0202009	INSECTICIDA HECTOGAN	455.3571
231	CORP-00805	SAN JORGE	IN0303008	INSECTICIDA NOMOLT 15 SC	436.9379
232	CORP-00805	QUIRICA	IN0303008	INSECTICIDA NOMOLT 15 SC	436.9379
233	CORP-00805	SAN FRANCISCO	IN0303008	INSECTICIDA NOMOLT 15 SC	436.9379
234	CORP-00811	SAN ANTONIO	MA0202029	JERINGA DESECHABLE 20 ML	2.9018
235	CORP-00811	SAN FRANCISCO	MA0202029	JERINGA DESECHABLE 20 ML	2.9018
236	CORP-00811	SAN JORGE	MA0202029	JERINGA DESECHABLE 20 ML	2.9018
237	CORP-00813	ALFA	MA0202031	JERINGAS DESECHABLE 50 ML.	6.0268
238	CORP-00813	SAN JORGE	MA0202031	JERINGAS DESECHABLE 50 ML.	6.0268
239	CORP-00813	SAN FRANCISCO	MA0202031	JERINGAS DESECHABLE 50 ML.	6.0268
240	CORP-00847	SAN FRANCISCO	MA0103005	LAÑA O GRAPA PARA CERCAS	8.9286
241	CORP-00847	SAN ANTONIO	MA0103005	LAÑA O GRAPA PARA CERCAS	8.9286
242	CORP-00847	SAN JORGE	MA0103005	LAÑA O GRAPA PARA CERCAS	8.9286
243	CORP-00848	SUPREMA	06-0519-02	LAPTOP	12053.5714
244	CORP-00848	SUPREMA	06-0582-02	LAPTOP	11742.75
245	CORP-00848	PALMAS	06-0470-01	LAPTOP	11742.75
246	CORP-00848	PALMAS	06-0477-01	LAPTOP	11742.75
247	CORP-00848	PALMAS	06-0474-01	LAPTOP	11742.75
248	CORP-00848	PALMAS	06-0471-01	LAPTOP	11742.75
249	CORP-00848	SUPREMA	06-0581-02	LAPTOP	11742.75
250	CORP-00848	PALMAS	06-0452-01	LAPTOP	11742.75
251	CORP-00848	PALMAS	06-0472-01	LAPTOP	11742.75
252	CORP-00848	PALMAS	06-0469-01	LAPTOP	11742.75
253	CORP-00848	PALMAS	06-0473-01	LAPTOP	11742.75
254	CORP-00848	PALMAS	06-0451-01	LAPTOP	11742.75
255	CORP-00848	PALMAS	06-0484-01	LAPTOP	10990.5228
256	CORP-00848	PALMAS	06-0440-01	LAPTOP	7669.6429
257	CORP-00848	SUPREMA	06-0536-02	LAPTOP	7506.5
258	CORP-00848	PALMAS	06-0486-01	LAPTOP	7223.2143
259	CORP-00848	PALMAS	06-0433-01	LAPTOP	7133.9286
260	CORP-00848	SUPREMA	06-0591-02	LAPTOP	6617.25
261	CORP-00848	PALMAS	06-0512-01	LAPTOP	6617.25
262	CORP-00848	PALMAS	06-0511-01	LAPTOP	6617.25
263	CORP-00848	SUPREMA	06-0593-02	LAPTOP	6617.25
264	CORP-00848	SUPREMA	06-0592-02	LAPTOP	6617.25
265	CORP-00848	SUPREMA	06-0594-02	LAPTOP	6617.25
266	CORP-00848	PALMAS	06-0515-01	LAPTOP	6617.25
267	CORP-00848	SUPREMA	06-0590-02	LAPTOP	6617.25
268	CORP-00848	PALMAS	06-0513-01	LAPTOP	6617.25
269	CORP-00848	PALMAS	06-0514-01	LAPTOP	6617.25
270	CORP-00848	PALMAS	06-0429-01	LAPTOP	6343.75
271	CORP-00848	PALMAS	06-0453-01	LAPTOP	6247.6594
272	CORP-00848	PALMAS	06-0476-01	LAPTOP	6247.5228
273	CORP-00848	SUPREMA	06-0571-02	LAPTOP	6247.5228
274	CORP-00848	SUPREMA	06-0578-02	LAPTOP	6247.5228
275	CORP-00848	SUPREMA	06-0572-02	LAPTOP	6247.5228
276	CORP-00848	PALMAS	06-0475-01	LAPTOP	6247.5228
277	CORP-00848	PALMAS	06-0462-01	LAPTOP	6247.5228
278	CORP-00848	PALMAS	06-0461-01	LAPTOP	6247.5228
279	CORP-00848	PALMAS	06-0460-01	LAPTOP	6247.5228
280	CORP-00848	PALMAS	06-0459-01	LAPTOP	6247.5228
281	CORP-00848	PALMAS	06-0458-01	LAPTOP	6247.5228
282	CORP-00848	PALMAS	06-0457-01	LAPTOP	6247.5228
283	CORP-00848	PALMAS	06-0456-01	LAPTOP	6247.5228
284	CORP-00848	PALMAS	06-0464-01	LAPTOP	6247.5228
285	CORP-00848	PALMAS	06-0450-01	LAPTOP	6247.5228
286	CORP-00848	PALMAS	06-0454-01	LAPTOP	6247.5228
287	CORP-00848	SUPREMA	06-0576-02	LAPTOP	6247.5228
288	CORP-00848	SUPREMA	06-0573-02	LAPTOP	6247.5228
289	CORP-00848	SUPREMA	06-0577-02	LAPTOP	6247.5228
290	CORP-00848	SUPREMA	06-0575-02	LAPTOP	6247.5228
291	CORP-00848	SUPREMA	06-0574-02	LAPTOP	6247.5228
292	CORP-00848	PALMAS	06-0455-01	LAPTOP	6247.5228
293	CORP-00848	PALMAS	06-0466-01	LAPTOP	6247.5228
294	CORP-00848	PALMAS	06-0467-01	LAPTOP	6247.5228
295	CORP-00848	PALMAS	06-0465-01	LAPTOP	6247.5228
296	CORP-00848	PALMAS	06-0468-01	LAPTOP	6247.5228
297	CORP-00848	PALMAS	06-0463-01	LAPTOP	6247.5228
298	CORP-00848	SUPREMA	06-0580-02	LAPTOP	6247.5228
299	CORP-00848	SUPREMA	06-0579-02	LAPTOP	6247.5228
300	CORP-00855	SAN JORGE	MA0202004	LARVICID UNICICLINA SPRAY	62.5
301	CORP-00855	SAN FRANCISCO	MA0202004	LARVICID UNICICLINA SPRAY	62.5
302	CORP-00862	SAN ANTONIO	MA0202025	LAZO PLASTICO 1/2"	12.2768
303	CORP-00862	SAN JORGE	MA0202025	LAZO PLASTICO 1/2"	12.2768
304	CORP-00862	QUIRICA	MA0202025	LAZO PLASTICO 1/2"	12.0536
305	CORP-00862	ACACIAS	MA0202025	LAZO PLASTICO 1/2"	12.0536
306	CORP-00862	SAN FRANCISCO	MA0202025	LAZO PLASTICO 1/2"	12.2768
307	CORP-00863	SAN ANTONIO	MA0202023	LAZO PLASTICO 1/4"	12.1776
308	CORP-00863	QUIRICA	MA0202023	LAZO PLASTICO 1/4"	12.0536
309	CORP-00863	ACACIAS	MA0202023	LAZO PLASTICO 1/4"	12.0536
310	CORP-00863	SAN FRANCISCO	MA0202023	LAZO PLASTICO 1/4"	12.0536
311	CORP-00863	SAN JORGE	MA0202023	LAZO PLASTICO 1/4"	12.0536
312	CORP-00865	SAN ANTONIO	MA0202024	LAZO PLASTICO 3/8"	12.1652
313	CORP-00865	SAN FRANCISCO	MA0202024	LAZO PLASTICO 3/8"	12.1652
314	CORP-00865	QUIRICA	MA0202024	LAZO PLASTICO 3/8"	12.0536
315	CORP-00865	ACACIAS	MA0202024	LAZO PLASTICO 3/8"	12.0536
316	CORP-00865	SAN JORGE	MA0202024	LAZO PLASTICO 3/8"	12.0536
317	CORP-00879	SAN FRANCISCO	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	20.9821
318	CORP-00879	ACACIAS	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	23.2143
319	CORP-00879	SAN JORGE	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	20.9821
320	CORP-00879	SAN ANTONIO	MA0101017	LENTES CLAROS NEMESIS ANTIEMPAÑANTES	20.9821
321	CORP-00888	ACACIAS	MA0103011	LIMA TRIANGULAR 6"  (MARCA BELLOTA)	16.471
322	CORP-00888	SAN FRANCISCO	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	10.7143
323	CORP-00888	SAN JORGE	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	10.7143
324	CORP-00888	SAN ANTONIO	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	10.7143
325	CORP-00888	ALFA	MA0103011	LIMA TRIANGULAR 6" MARCA BELLOTA	13.3929
326	CORP-00898	SAN ANTONIO	MA0202005	LOCION PODAL 960 ML.	174.1071
327	CORP-00898	SAN FRANCISCO	MA0202005	LOCION PODAL 960 ML.	174.1071
328	CORP-00898	SAN JORGE	MA0202005	LOCION PODAL 960 ML.	174.1071
329	CORP-00917	ACACIAS	MA0102067	MANOMETRO CON GLICERINA 0-100 PSI. CARAT. 2.5	111.6071
330	CORP-00917	ALFA	MA0102067	MANOMETRO CON GLICERINA 0-100 PSI. CARAT. 2.5	111.6071
331	CORP-00921	SAN FRANCISCO	MA0101018	MASCARILLA MEDIA CARA 3M	111.6071
332	CORP-00921	SAN ANTONIO	MA0101018	MASCARILLA MEDIA CARA 3M	111.6071
333	CORP-00921	SAN JORGE	MA0101018	MASCARILLA MEDIA CARA 3M	111.6071
334	CORP-00925	SAN ANTONIO	MA0201002	MELAZA	5.3571
335	CORP-00925	SAN JORGE	MA0201002	MELAZA	5.3571
336	CORP-00925	SAN FRANCISCO	MA0201002	MELAZA	5.3571
337	CORP-00929	SAN ANTONIO	MA0102068	MICROTUBO PLASTICO 8MM	7.5893
338	CORP-00929	SAN FRANCISCO	MA0102068	MICROTUBO PLASTICO 8MM	7.5893
339	CORP-00929	ACACIAS	MA0102068	MICROTUBO PLASTICO 8MM	7.5893
340	CORP-00929	QUIRICA	MA0102068	MICROTUBO PLASTICO 8MM	7.5893
341	CORP-00931	SUPREMA	06-0566-02	MONITOR	1138.3929
342	CORP-00931	SUPREMA	06-0567-02	MONITOR	1138.3929
343	CORP-00931	SUPREMA	06-0568-02	MONITOR	1138.3929
344	CORP-00931	SUPREMA	06-0589-02	MONITOR	915.1786
345	CORP-00931	PALMAS	06-0509-01	MONITOR	915.1786
346	CORP-00931	PALMAS	06-0510-01	MONITOR	915.1786
347	CORP-00963	SAN FRANCISCO	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	30.5357
348	CORP-00963	SAN ANTONIO	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	30.5357
349	CORP-00963	ALFA	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	30.5357
350	CORP-00963	ACACIAS	MA0101033	PALO MADERA 1 X 5-8' MALAYOS	30.5357
351	CORP-00963	SAN JORGE	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	30.5357
352	CORP-00963	QUIRICA	MA0101040	PALO MADERA 1 X 5-8' MALAYOS	30.5357
353	CORP-00967	SAN JORGE	MA0101022	PANTALLA CARETA ESMERILAR	20.5357
354	CORP-00967	SAN ANTONIO	MA0101022	PANTALLA CARETA ESMERILAR	20.5357
355	CORP-00967	SAN FRANCISCO	MA0101022	PANTALLA CARETA ESMERILAR	20.5357
356	CORP-00981	ACACIAS	MA0102069	PEGAMENTO PVC WET BONDING PEGAR EN MOJADO	469.2857
357	CORP-00981	QUIRICA	MA0102069	PEGAMENTO PVC WET BONDING PEGAR EN MOJADO	469.2857
358	CORP-01038	PALMAS	RE0103068	REFRIGERANTE RADIADOR VEHICULOS (GLS)	58.1084
359	CORP-01038	ACACIAS	RE0301001	REFRIGERANTE RADIADOR VEHICULOS (GLS)	58.8
360	CORP-01064	QUIRICA	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	43.5268
361	CORP-01064	ALFA	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	48.2143
362	CORP-01064	SAN JORGE	RE0308001	RETENEDOR 45 X 75 X 8 MM. (DOBLE LABIO)	43.5268
363	CORP-01150	PALMAS	06-0444-01	SWITCH	23141.25
364	CORP-01150	TASINSA	06-0081-09	SWITCH	4284
365	CORP-01150	SUPREMA	06-0542-02	SWITCH	3977.3839
366	CORP-01150	SUPREMA	06-0543-02	SWITCH	3977.3839
367	CORP-01150	PALMAS	06-0446-01	SWITCH	2366.0714
368	CORP-01150	PALMAS	06-0445-01	SWITCH	2366.0714
369	CORP-01150	PALMAS	06-0443-01	SWITCH	2075.8929
370	CORP-01150	SUPREMA	06-0583-02	SWITCH	1607.1429
371	CORP-01150	SUPREMA	06-0584-02	SWITCH	1607.1429
372	CORP-01150	SUPREMA	06-0569-02	SWITCH	1291.4554
373	CORP-01150	PALMAS	06-0438-01	SWITCH	1205.3571
374	CORP-01154	SUPREMA	06-0525-02	TABLET	2669.6429
375	CORP-01154	SUPREMA	06-0524-02	TABLET	2669.6429
376	CORP-01154	SUPREMA	06-0526-02	TABLET	2669.6429
377	CORP-01154	SUPREMA	06-0522-02	TABLET	2669.6429
378	CORP-01154	SUPREMA	06-0523-02	TABLET	2669.6429
379	CORP-01154	PALMAS	06-0504-01	TABLET	2543.75
380	CORP-01154	PALMAS	06-0435-01	TABLET	2098.2143
381	CORP-01154	PALMAS	06-0436-01	TABLET	2098.2143
382	CORP-01154	PALMAS	06-0434-01	TABLET	2098.2143
383	CORP-01154	PALMAS	06-0439-01	TABLET	2031.25
384	CORP-01154	PALMAS	06-0481-01	TABLET	1784.8214
385	CORP-01154	PALMAS	06-0483-01	TABLET	1784.8214
386	CORP-01154	PALMAS	06-0480-01	TABLET	1784.8214
387	CORP-01154	PALMAS	06-0482-01	TABLET	1784.8214
388	CORP-01154	PALMAS	06-0426-01	TABLET	1396.1964
389	CORP-01154	PALMAS	06-0423-01	TABLET	1396.1964
390	CORP-01154	PALMAS	06-0424-01	TABLET	1396.1964
391	CORP-01154	PALMAS	06-0425-01	TABLET	1396.1964
392	CORP-01154	PALMAS	06-0422-01	TABLET	1396.1964
393	CORP-01155	SAN JORGE	MA0101024	TAFILETE ATORNILLABLE CASCO CLIMAX	17.8571
394	CORP-01155	SAN ANTONIO	MA0101024	TAFILETE ATORNILLABLE CASCO CLIMAX	17.8571
395	CORP-01234	ACACIAS	MA0108004	TORNILLO ABRAZADERA 8X50 MM. ROSCA CORRIDA (COMPLETOS, GRADO 8)	2.2321
396	CORP-01234	SAN JORGE	MA0108004	TORNILLO ABRAZADERA 8X50 MM. ROSCA CORRIDA (COMPLETOS, GRADO 8)	2.2321
397	CORP-01239	SAN JORGE	MA0104015	TORNILLO CABEZA HEXAG. NC. DE 1/4" X 1.1/2"  (COMPLETOS, GRADO 8)	1.7857
398	CORP-01239	ACACIAS	MA0108001	TORNILLO CABEZA HEXAG. NC. DE 1/4" X 1.1/2"  (COMPLETOS, GRADO 8)	1.7857
399	CORP-01312	ACACIAS	MA0104002	TUBO PVC 1/2 X 20'	15.65
400	CORP-01312	SAN ANTONIO	MA0104002	TUBO PVC 1/2 X 20'	15.6498
401	CORP-01312	QUIRICA	MA0104002	TUBO PVC 1/2 X 20'	15.65
402	CORP-01312	SAN FRANCISCO	MA0104002	TUBO PVC 1/2 X 20'	15.65
403	CORP-01319	SAN JORGE	MA0108002	TUERCA HEXAG. ABRAZADERA 7/16" N.C.	0.6696
404	CORP-01319	ACACIAS	MA0108002	TUERCA HEXAG. ABRAZADERA 7/16" N.C.	0.6696
405	CORP-01328	SUPREMA	MA0102092	UNION UNIVERSAL HN 1 ROSCADA	44.6429
406	CORP-01328	PALMAS	MA0102089	UNION UNIVERSAL HN 1 (ROSCADA)	42.8571
407	CORP-01331	SAN ANTONIO	MA0202017	VACUNA BOVIBAC PLUS 50 ML	203.5714
408	CORP-01331	SAN JORGE	MA0202017	VACUNA BOVIBAC PLUS 50 ML	203.5714
409	CORP-01331	SAN FRANCISCO	MA0202017	VACUNA BOVIBAC PLUS 50 ML	203.5714
410	CORP-01333	SAN ANTONIO	MA0202018	VACUNA RAYOVET 50 ML	41.9643
411	CORP-01333	SAN FRANCISCO	MA0202018	VACUNA RAYOVET 50 ML	41.9643
412	CORP-01333	SAN JORGE	MA0202018	VACUNA RAYOVET 50 ML	41.9643
413	CORP-01389	SAN ANTONIO	MA0202015	VITAMINA OLIVITASAN 500 ML	447.7679
414	CORP-01389	SAN FRANCISCO	MA0202015	VITAMINA OLIVITASAN 500 ML	447.7679
415	CORP-01389	SAN JORGE	MA0202015	VITAMINA OLIVITASAN 500 ML	447.7679
416	CORP-01391	ALFA	MA0101029	WIPE  (BOLA 1 LIBRA)	11.6071
417	CORP-01391	ACACIAS	MA0101029	WIPE  (BOLA 1 LIBRA)	11.6071
\.


--
-- Data for Name: matriz_aprobacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.matriz_aprobacion (id, regla, monto_desde, monto_hasta, dentro_presupuesto, niveles_requeridos, descripcion) FROM stdin;
2	R2	0	10000	NO	N1	Excede presupuesto hasta Q10,000: aprueba el gerente de la empresa
3	R3	10000.01	999999999	NO	N1+N2+N3	Excede presupuesto y supera Q 10,000: N1, N2 y N3
1	R1	0	999999999	SI	AUTO	Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras
\.


--
-- Data for Name: matriz_contable; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.matriz_contable (id, empresa, cta, dim1, dim2, dim3, dim4, dim5, proyecto, departamento, subdepartamento, ubicacion, linea_producto, producto, nombre_proyecto) FROM stdin;
1	Suprema, S.A.	7	00	0001	U01	L00	P00	0201P1S1M01	Administración	Directorio	Oficinas Centrales	No definido	No definido	Gerencia General
2	Suprema, S.A.	7	00	0002	U01	L00	P00	0201P1S1M01	Administración	Gerencia General	Oficinas Centrales	No definido	No definido	Gerencia General
3	Suprema, S.A.	7	00	0002	U01	L00	P00	0201P1S1M04	Administración	Gerencia General	Oficinas Centrales	No definido	No definido	Exportacion
4	Suprema, S.A.	7	00	0002	U02	L01	P01	0201P1S1M01	Administración	Gerencia General	Planta	Grasas y Aceites	Aceites a Granel	Gerencia General
5	Suprema, S.A.	7	00	0003	U01	L00	P00	0201P1S1M01	Administración	Dirección de operaciones	Oficinas Centrales	No definido	No definido	Gerencia General
6	Suprema, S.A.	7	00	0004	U01	L00	P00	0201P1S1M01	Administración	Asesoría Legal	Oficinas Centrales	No definido	No definido	Gerencia General
7	Suprema, S.A.	7	00	0004	U01	L01	P01	0202P1A1C01	Administración	Asesoría Legal	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
8	Suprema, S.A.	7	00	0004	U01	L01	P02	0202P1A1C01	Administración	Asesoría Legal	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
9	Suprema, S.A.	7	00	0004	U01	L01	P03	0202P1A1C01	Administración	Asesoría Legal	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
10	Suprema, S.A.	7	00	0004	U01	L01	P04	0202P1A1C01	Administración	Asesoría Legal	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
11	Suprema, S.A.	7	00	0004	U01	L02	P11	0202P1A1C01	Administración	Asesoría Legal	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
12	Suprema, S.A.	7	00	0009	U01	L00	P00	0201P1S1M03	Administración	Administración Oficinas Centra	Oficinas Centrales	No definido	No definido	Servicios
13	Suprema, S.A.	7	00	0009	U01	L00	P00	0201P1S1M01	Administración	Administración Oficinas Centra	Oficinas Centrales	No definido	No definido	Gerencia General
14	Suprema, S.A.	7	00	0009	U01	L01	P01	0202P1A1C01	Administración	Administración Oficinas Centra	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
15	Suprema, S.A.	7	00	0009	U01	L01	P02	0202P1A1C01	Administración	Administración Oficinas Centra	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
16	Suprema, S.A.	7	00	0009	U01	L01	P03	0202P1A1C01	Administración	Administración Oficinas Centra	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
17	Suprema, S.A.	7	00	0009	U01	L01	P04	0202P1A1C01	Administración	Administración Oficinas Centra	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
18	Suprema, S.A.	7	00	0009	U01	L02	P11	0202P1A1C01	Administración	Administración Oficinas Centra	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
19	Suprema, S.A.	8	00	0002	U01	L00	P00	0201P1S1M03	Administración	Gerencia General	Oficinas Centrales	No definido	No definido	Servicios
20	Suprema, S.A.	8	00	0002	U01	L00	P00	0201P1S1M01	Administración	Gerencia General	Oficinas Centrales	No definido	No definido	Gerencia General
21	Suprema, S.A.	8	00	0009	U01	L00	P00	0201P1S1M01	Administración	Administración Oficinas Centra	Oficinas Centrales	No definido	No definido	Gerencia General
22	Suprema, S.A.	7	01	0101	U01	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoria	Oficinas Centrales	No definido	No definido	Gerencia General
23	Suprema, S.A.	7	01	0101	U02	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoria	Planta	No definido	No definido	Gerencia General
24	Suprema, S.A.	8	01	0101	U01	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoria	Oficinas Centrales	No definido	No definido	Gerencia General
25	Suprema, S.A.	7	02	0201	U01	L00	P00	0201P1S1M01	Dirección de Proyectos	Jefatura proyectos	Oficinas Centrales	No definido	No definido	Gerencia General
26	Suprema, S.A.	7	02	0201	U02	L00	P00	0201P1S1M01	Dirección de Proyectos	Jefatura proyectos	Planta	No definido	No definido	Gerencia General
27	Suprema, S.A.	6	03	0302	U02	L08	P50	0201P1S1M01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
28	Suprema, S.A.	6	03	0303	U02	L08	P50	0201P1S1M01	Gerencia Administrativa	Bodega de Aceites a Granel	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
29	Suprema, S.A.	6	03	0304	U02	L08	P50	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
30	Suprema, S.A.	6	03	0306	U02	L08	P50	0201P1S1M01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
31	Suprema, S.A.	7	03	0301	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Gerencia General
32	Suprema, S.A.	7	03	0301	U02	L00	P00	0201P1S1M03	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Servicios
33	Suprema, S.A.	7	03	0305	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Gerencia General
34	Suprema, S.A.	7	03	0307	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Transporte de Personal	Planta	No definido	No definido	Gerencia General
35	Suprema, S.A.	7	03	0308	U02	L00	P00	0201P1S1M03	Gerencia Administrativa	Silos	Planta	No definido	No definido	Servicios
36	Suprema, S.A.	7	03	0309	U02	L00	P00	0201P1S1M03	Gerencia Administrativa	Administración Planta	Planta	No definido	No definido	Servicios
37	Suprema, S.A.	7	03	0309	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Administración Planta	Planta	No definido	No definido	Gerencia General
38	Suprema, S.A.	7	04	0401	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Jefatura Finanzas	Oficinas Centrales	No definido	No definido	Gerencia General
39	Suprema, S.A.	7	04	0402	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Contabilidad	Oficinas Centrales	No definido	No definido	Gerencia General
40	Suprema, S.A.	7	04	0402	U01	L00	P00	0201P1S1M04	Gerencia Financiera	Contabilidad	Oficinas Centrales	No definido	No definido	Exportacion
41	Suprema, S.A.	7	04	0403	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Créditos	Oficinas Centrales	No definido	No definido	Gerencia General
42	Suprema, S.A.	7	04	0403	U01	L00	P00	0202P1A1C01	Gerencia Financiera	Créditos	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
43	Suprema, S.A.	7	04	0404	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Tesorería	Oficinas Centrales	No definido	No definido	Gerencia General
44	Suprema, S.A.	8	04	0402	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Contabilidad	Oficinas Centrales	No definido	No definido	Gerencia General
45	Suprema, S.A.	8	04	0404	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Tesorería	Oficinas Centrales	No definido	No definido	Gerencia General
46	Suprema, S.A.	7	05	0501	U01	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestion Humana	Oficinas Centrales	No definido	No definido	Gerencia General
47	Suprema, S.A.	7	05	0501	U02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestion Humana	Planta	No definido	No definido	Gerencia General
48	Suprema, S.A.	7	05	0502	U01	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	Oficinas Centrales	No definido	No definido	Gerencia General
49	Suprema, S.A.	7	05	0502	U02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Gerencia General
50	Suprema, S.A.	8	05	0501	U02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestion Humana	Planta	No definido	No definido	Gerencia General
51	Suprema, S.A.	7	06	0601	U02	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Jefatura Depto Sostenibilidad	Planta	No definido	No definido	Gerencia General
52	Suprema, S.A.	7	06	0601	U01	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Jefatura Depto Sostenibilidad	Oficinas Centrales	No definido	No definido	Gerencia General
53	Suprema, S.A.	7	06	0602	U02	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Certificaciones, registros y l	Planta	No definido	No definido	Gerencia General
54	Suprema, S.A.	7	06	0603	U02	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Certificación RSPO	Planta	No definido	No definido	Gerencia General
55	Suprema, S.A.	7	10	1001	U01	L00	P00	0201P1S1M01	Compras	Jefatura Compras	Oficinas Centrales	No definido	No definido	Gerencia General
56	Suprema, S.A.	8	10	1001	U01	L00	P00	0201P1S1M01	Compras	Jefatura Compras	Oficinas Centrales	No definido	No definido	Gerencia General
57	Suprema, S.A.	7	11	1101	U01	L00	P00	0201P1S1M01	IT	Jefatura IT	Oficinas Centrales	No definido	No definido	Gerencia General
58	Suprema, S.A.	7	11	1101	U02	L00	P00	0201P1S1M01	IT	Jefatura IT	Planta	No definido	No definido	Gerencia General
59	Suprema, S.A.	8	11	1101	U02	L00	P00	0201P1S1M01	IT	Jefatura IT	Planta	No definido	No definido	Gerencia General
60	Suprema, S.A.	8	11	1101	U01	L00	P00	0201P1S1M01	IT	Jefatura IT	Oficinas Centrales	No definido	No definido	Gerencia General
61	Suprema, S.A.	7	12	1201	U02	L00	P00	0202P1A1C01	Logística	Logistica	Planta	No definido	No definido	COMERCIALIZADORA
62	Suprema, S.A.	7	12	1201	U02	L00	P00	0201P1S1M03	Logística	Logistica	Planta	No definido	No definido	Servicios
63	Suprema, S.A.	7	12	1201	U02	L01	P01	0202P1A1C01	Logística	Logistica	Planta	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
64	Suprema, S.A.	7	12	1201	U02	L01	P02	0202P1A1C01	Logística	Logistica	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
65	Suprema, S.A.	7	12	1201	U02	L01	P03	0202P1A1C01	Logística	Logistica	Planta	Grasas y Aceites	Mantecas	COMERCIALIZADORA
66	Suprema, S.A.	7	12	1201	U02	L01	P04	0202P1A1C01	Logística	Logistica	Planta	Grasas y Aceites	Margarinas	COMERCIALIZADORA
67	Suprema, S.A.	7	12	1201	U02	L02	P11	0202P1A1C01	Logística	Logistica	Planta	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
68	Suprema, S.A.	7	12	1202	U01	L00	P00	0202P1A1C01	Logística	Bodega PT	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
69	Suprema, S.A.	7	12	1202	U01	L00	P00	0201P1S1M03	Logística	Bodega PT	Oficinas Centrales	No definido	No definido	Servicios
70	Suprema, S.A.	7	12	1202	U01	L01	P02	0201P1S1M01	Logística	Bodega PT	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerencia General
71	Suprema, S.A.	7	12	1202	U01	L01	P03	0201P1S1M01	Logística	Bodega PT	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerencia General
72	Suprema, S.A.	7	12	1202	U01	L01	P04	0201P1S1M01	Logística	Bodega PT	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerencia General
73	Suprema, S.A.	7	12	1202	U01	L02	P11	0201P1S1M01	Logística	Bodega PT	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerencia General
74	Suprema, S.A.	7	12	1202	U02	L00	P00	0202P1A1C01	Logística	Bodega PT	Planta	No definido	No definido	COMERCIALIZADORA
75	Suprema, S.A.	7	12	1202	U01	L01	P02	0202P1A1C01	Logística	Bodega PT	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
76	Suprema, S.A.	7	12	1202	U01	L02	P11	0202P1A1C01	Logística	Bodega PT	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
77	Suprema, S.A.	7	12	1202	U02	L01	P01	0202P1A1C01	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
78	Suprema, S.A.	7	12	1202	U02	L01	P02	0202P1A1C01	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
79	Suprema, S.A.	7	12	1202	U02	L01	P03	0202P1A1C01	Logística	Bodega PT	Planta	Grasas y Aceites	Mantecas	COMERCIALIZADORA
80	Suprema, S.A.	7	12	1202	U02	L01	P04	0202P1A1C01	Logística	Bodega PT	Planta	Grasas y Aceites	Margarinas	COMERCIALIZADORA
81	Suprema, S.A.	7	12	1202	U02	L02	P11	0202P1A1C01	Logística	Bodega PT	Planta	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
82	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M03	Logística	Transporte	Planta	No definido	No definido	Erick Cifuentes
83	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M03	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
84	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M03	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
85	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M03	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Erick Cifuentes
86	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M03	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Erick Cifuentes
87	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M03	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
88	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M05	Logística	Transporte	Planta	No definido	No definido	Vidal Ramirez
89	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M05	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
90	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M05	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
91	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M05	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Vidal Ramirez
92	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M05	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Vidal Ramirez
2107	Ganaderia Rio Seco	6	20	2002	U11	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 3	SAL	SAL A GRANEL	SAL
93	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M05	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
94	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A2S1M02	Logística	Transporte	Planta	No definido	No definido	Jose Aguilar
95	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A2S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Jose Aguilar
96	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A2S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Jose Aguilar
97	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A2S1M02	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Jose Aguilar
98	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A2S1M02	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Jose Aguilar
99	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A2S1M02	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
100	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A4S1M01	Logística	Transporte	Planta	No definido	No definido	Selvin Ovedh Luna Arenales
101	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A4S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
102	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A4S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
103	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A4S1M01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
104	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A4S1M01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
105	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A4S1M01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
106	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A2S1M01	Logística	Transporte	Planta	No definido	No definido	Roberto Lopez
107	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A2S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Roberto Lopez
108	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A2S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Roberto Lopez
109	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A2S1M01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Roberto Lopez
110	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A2S1M01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Roberto Lopez
111	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A2S1M01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
112	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M99	Logística	Transporte	Planta	No definido	No definido	Miguel Estuardo Romero Matias
113	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
114	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
115	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M99	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
116	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M99	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
117	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M99	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
118	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A3S1M99	Logística	Transporte	Planta	No definido	No definido	Mario Humberto Vega Ponciano
119	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A3S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
120	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A3S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
121	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A3S1M99	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
122	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A3S1M99	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
123	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A3S1M99	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
124	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A3S1M02	Logística	Transporte	Planta	No definido	No definido	Julio Mauricio Juarez Lopez
125	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A3S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
126	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A3S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
127	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A3S1M02	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
128	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A3S1M02	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
129	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A3S1M02	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
130	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M02	Logística	Transporte	Planta	No definido	No definido	Juan Jose Flores
131	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
132	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
133	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M02	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Juan Jose Flores
134	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M02	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Juan Jose Flores
135	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M02	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
136	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S2I01	Logística	Transporte	Planta	No definido	No definido	Jose Eduardo Letona Fonseca
137	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S2I01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
138	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S2I01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
139	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S2I01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
140	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S2I01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
141	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S2I01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
142	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M04	Logística	Transporte	Planta	No definido	No definido	Jose Antonio Mendez
143	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M04	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
144	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M04	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
145	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M04	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Jose Antonio Mendez
146	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M04	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Jose Antonio Mendez
147	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M04	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
148	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A3S1M03	Logística	Transporte	Planta	No definido	No definido	Jorge Alberto Estrada Manzo
149	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A3S1M03	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
150	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A3S1M03	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
151	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A3S1M03	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
152	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A3S1M03	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
153	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A3S1M03	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
154	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A5S1M01	Logística	Transporte	Planta	No definido	No definido	Henry David Fildalgo Galicia
155	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A5S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
156	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A5S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
157	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A5S1M01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
158	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A5S1M01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
159	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A5S1M01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
160	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S2S01	Logística	Transporte	Planta	No definido	No definido	Maurel Perez
161	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S2S01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Maurel Perez
162	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S2S01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Maurel Perez
163	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S2S01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Maurel Perez
164	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S2S01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Maurel Perez
165	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S2S01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
166	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S1M01	Logística	Transporte	Planta	No definido	No definido	Gerson Flores
167	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Gerson Flores
168	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S1M01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Gerson Flores
169	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S1M01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Gerson Flores
170	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S1M01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Gerson Flores
171	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S1M01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
172	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A5S1M99	Logística	Transporte	Planta	No definido	No definido	Fabio Rodas Falla
173	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A5S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
174	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A5S1M99	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
175	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A5S1M99	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Fabio Rodas Falla
176	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A5S1M99	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Fabio Rodas Falla
177	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A5S1M99	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
178	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A1S2S02	Logística	Transporte	Planta	No definido	No definido	Maria Maldonado
179	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A1S2S02	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Maria Maldonado
180	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A1S2S02	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Maria Maldonado
181	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A1S2S02	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Maria Maldonado
182	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A1S2S02	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Maria Maldonado
183	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A1S2S02	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
184	Suprema, S.A.	7	12	1203	U02	L00	P00	0202P1A1C01	Logística	Transporte	Planta	No definido	No definido	COMERCIALIZADORA
185	Suprema, S.A.	7	12	1203	U02	L01	P01	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
186	Suprema, S.A.	7	12	1203	U02	L01	P02	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
187	Suprema, S.A.	7	12	1203	U02	L01	P03	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	COMERCIALIZADORA
188	Suprema, S.A.	7	12	1203	U02	L01	P04	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	COMERCIALIZADORA
189	Suprema, S.A.	7	12	1203	U02	L02	P11	0202P1A1C01	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
190	Suprema, S.A.	7	12	1203	U02	L00	P00	0202A4S1M02	Logística	Transporte	Planta	No definido	No definido	Carlos Alberto Ruedas Morataya
191	Suprema, S.A.	7	12	1203	U02	L01	P01	0202A4S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
192	Suprema, S.A.	7	12	1203	U02	L01	P02	0202A4S1M02	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
193	Suprema, S.A.	7	12	1203	U02	L01	P03	0202A4S1M02	Logística	Transporte	Planta	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
194	Suprema, S.A.	7	12	1203	U02	L01	P04	0202A4S1M02	Logística	Transporte	Planta	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
195	Suprema, S.A.	7	12	1203	U02	L02	P11	0202A4S1M02	Logística	Transporte	Planta	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
196	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M03	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Erick Cifuentes
197	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M05	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Vidal Ramirez
198	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A2S1M02	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Jose Aguilar
199	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A4S1M01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Selvin Ovedh Luna Arenales
200	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A2S1M01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Roberto Lopez
201	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M99	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Miguel Estuardo Romero Matias
202	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A3S1M99	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Mario Humberto Vega Ponciano
203	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A3S1M02	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Julio Mauricio Juarez Lopez
204	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M02	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Juan Jose Flores
205	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S2I01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Jose Eduardo Letona Fonseca
206	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M04	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Jose Antonio Mendez
207	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A3S1M03	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Jorge Alberto Estrada Manzo
208	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A5S1M01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Henry David Fildalgo Galicia
209	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S2S01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Maurel Perez
210	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S1M01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Gerson Flores
211	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A5S1M99	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Fabio Rodas Falla
212	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A1S2S02	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Maria Maldonado
213	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202P1A1C01	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	COMERCIALIZADORA
214	Suprema, S.A.	7	12	1203	12-CAM01	L00	P00	0202A4S1M02	Logística	Transporte	CAMION 828 CBZ	No definido	No definido	Carlos Alberto Ruedas Morataya
215	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M03	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Erick Cifuentes
216	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M05	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Vidal Ramirez
217	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A2S1M02	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Jose Aguilar
218	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A4S1M01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Selvin Ovedh Luna Arenales
219	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A2S1M01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Roberto Lopez
220	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M99	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Miguel Estuardo Romero Matias
221	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A3S1M99	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Mario Humberto Vega Ponciano
222	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A3S1M02	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Julio Mauricio Juarez Lopez
223	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M02	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Juan Jose Flores
224	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S2I01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Jose Eduardo Letona Fonseca
225	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M04	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Jose Antonio Mendez
226	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A3S1M03	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Jorge Alberto Estrada Manzo
227	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A5S1M01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Henry David Fildalgo Galicia
228	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S2S01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Maurel Perez
229	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S1M01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Gerson Flores
230	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A5S1M99	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Fabio Rodas Falla
231	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A1S2S02	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Maria Maldonado
232	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202P1A1C01	Logística	Transporte	CAMION C-351BKN	No definido	No definido	COMERCIALIZADORA
233	Suprema, S.A.	7	12	1203	12-CAM02	L00	P00	0202A4S1M02	Logística	Transporte	CAMION C-351BKN	No definido	No definido	Carlos Alberto Ruedas Morataya
234	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M03	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Erick Cifuentes
235	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M05	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Vidal Ramirez
236	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A2S1M02	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Jose Aguilar
237	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A4S1M01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Selvin Ovedh Luna Arenales
238	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A2S1M01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Roberto Lopez
239	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M99	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Miguel Estuardo Romero Matias
240	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A3S1M99	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Mario Humberto Vega Ponciano
241	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A3S1M02	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Julio Mauricio Juarez Lopez
242	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M02	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Juan Jose Flores
243	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S2I01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Jose Eduardo Letona Fonseca
244	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M04	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Jose Antonio Mendez
245	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A3S1M03	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Jorge Alberto Estrada Manzo
246	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A5S1M01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Henry David Fildalgo Galicia
247	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S2S01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Maurel Perez
248	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S1M01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Gerson Flores
249	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A5S1M99	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Fabio Rodas Falla
250	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A1S2S02	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Maria Maldonado
251	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202P1A1C01	Logística	Transporte	CAMION C-568BRM	No definido	No definido	COMERCIALIZADORA
252	Suprema, S.A.	7	12	1203	12-CAM03	L00	P00	0202A4S1M02	Logística	Transporte	CAMION C-568BRM	No definido	No definido	Carlos Alberto Ruedas Morataya
253	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M03	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Erick Cifuentes
254	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M05	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Vidal Ramirez
255	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A2S1M02	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Jose Aguilar
256	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A4S1M01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Selvin Ovedh Luna Arenales
257	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A2S1M01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Roberto Lopez
258	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M99	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Miguel Estuardo Romero Matias
259	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A3S1M99	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Mario Humberto Vega Ponciano
260	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A3S1M02	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Julio Mauricio Juarez Lopez
261	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M02	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Juan Jose Flores
262	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S2I01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Jose Eduardo Letona Fonseca
263	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M04	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Jose Antonio Mendez
264	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A3S1M03	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Jorge Alberto Estrada Manzo
265	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A5S1M01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Henry David Fildalgo Galicia
266	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S2S01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Maurel Perez
267	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S1M01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Gerson Flores
268	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A5S1M99	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Fabio Rodas Falla
269	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A1S2S02	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Maria Maldonado
270	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202P1A1C01	Logística	Transporte	CAMION 606 BKP	No definido	No definido	COMERCIALIZADORA
271	Suprema, S.A.	7	12	1203	12-CAM04	L00	P00	0202A4S1M02	Logística	Transporte	CAMION 606 BKP	No definido	No definido	Carlos Alberto Ruedas Morataya
272	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M03	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Erick Cifuentes
273	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M05	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Vidal Ramirez
274	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A2S1M02	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Jose Aguilar
275	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A4S1M01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Selvin Ovedh Luna Arenales
276	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A2S1M01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Roberto Lopez
277	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M99	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Miguel Estuardo Romero Matias
278	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A3S1M99	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Mario Humberto Vega Ponciano
279	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A3S1M02	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Julio Mauricio Juarez Lopez
280	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M02	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Juan Jose Flores
281	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S2I01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Jose Eduardo Letona Fonseca
282	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M04	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Jose Antonio Mendez
283	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A3S1M03	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Jorge Alberto Estrada Manzo
284	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A5S1M01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Henry David Fildalgo Galicia
285	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S2S01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Maurel Perez
286	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S1M01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Gerson Flores
287	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A5S1M99	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Fabio Rodas Falla
288	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A1S2S02	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Maria Maldonado
289	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202P1A1C01	Logística	Transporte	CAMION C-574BLN	No definido	No definido	COMERCIALIZADORA
290	Suprema, S.A.	7	12	1203	12-CAM05	L00	P00	0202A4S1M02	Logística	Transporte	CAMION C-574BLN	No definido	No definido	Carlos Alberto Ruedas Morataya
291	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M03	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
292	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M05	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
293	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A2S1M02	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Jose Aguilar
294	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A4S1M01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
295	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A2S1M01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Roberto Lopez
296	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M99	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
297	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A3S1M99	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
298	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A3S1M02	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
299	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M02	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
300	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S2I01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
301	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M04	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
302	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A3S1M03	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
303	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A5S1M01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
304	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S2S01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Maurel Perez
305	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S1M01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Gerson Flores
306	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A5S1M99	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
307	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A1S2S02	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Maria Maldonado
308	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202P1A1C01	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
309	Suprema, S.A.	7	12	1203	12-PIP01	L01	P01	0202A4S1M02	Logística	Transporte	CAMION 265 BLR	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
310	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M03	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
311	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M05	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
312	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A2S1M02	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Jose Aguilar
313	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A4S1M01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
314	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A2S1M01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Roberto Lopez
315	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M99	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
316	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A3S1M99	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
317	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A3S1M02	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
318	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M02	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
319	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S2I01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
320	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M04	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
321	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A3S1M03	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
322	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A5S1M01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
323	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S2S01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Maurel Perez
324	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S1M01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Gerson Flores
325	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A5S1M99	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
326	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A1S2S02	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Maria Maldonado
327	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202P1A1C01	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
328	Suprema, S.A.	7	12	1203	12-PIP02	L01	P01	0202A4S1M02	Logística	Transporte	CAMION 982 BWD	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
329	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M03	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
330	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M05	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
331	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A2S1M02	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Jose Aguilar
332	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A4S1M01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
333	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A2S1M01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Roberto Lopez
334	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M99	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
335	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A3S1M99	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
336	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A3S1M02	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
337	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M02	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
338	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S2I01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
339	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M04	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
340	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A3S1M03	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
341	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A5S1M01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
342	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S2S01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Maurel Perez
343	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S1M01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Gerson Flores
344	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A5S1M99	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
345	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A1S2S02	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Maria Maldonado
346	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202P1A1C01	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
347	Suprema, S.A.	7	12	1203	12-PIP03	L01	P01	0202A4S1M02	Logística	Transporte	CAMION 597 BPH	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
348	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Erick Cifuentes
349	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Vidal Ramirez
350	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Jose Aguilar
351	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Selvin Ovedh Luna Arenales
352	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Roberto Lopez
353	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Miguel Estuardo Romero Matias
354	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Mario Humberto Vega Ponciano
355	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Julio Mauricio Juarez Lopez
356	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Juan Jose Flores
357	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Jose Eduardo Letona Fonseca
358	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Jose Antonio Mendez
359	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Jorge Alberto Estrada Manzo
360	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Henry David Fildalgo Galicia
361	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Maurel Perez
362	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Gerson Flores
363	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Fabio Rodas Falla
364	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Maria Maldonado
365	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	COMERCIALIZADORA
366	Suprema, S.A.	7	12	1203	12-TER01	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES ABSALON	No definido	No definido	Carlos Alberto Ruedas Morataya
367	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Erick Cifuentes
368	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Vidal Ramirez
369	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Jose Aguilar
370	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Selvin Ovedh Luna Arenales
371	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Roberto Lopez
372	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Miguel Estuardo Romero Matias
373	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Mario Humberto Vega Ponciano
374	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Julio Mauricio Juarez Lopez
375	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Juan Jose Flores
376	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Jose Eduardo Letona Fonseca
377	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Jose Antonio Mendez
378	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Jorge Alberto Estrada Manzo
379	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Henry David Fildalgo Galicia
380	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Maurel Perez
381	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Gerson Flores
382	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Fabio Rodas Falla
383	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Maria Maldonado
384	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	COMERCIALIZADORA
385	Suprema, S.A.	7	12	1203	12-TER02	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES ALEJANDRITA	No definido	No definido	Carlos Alberto Ruedas Morataya
386	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Erick Cifuentes
387	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Vidal Ramirez
388	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Jose Aguilar
389	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Selvin Ovedh Luna Arenales
390	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Roberto Lopez
391	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Miguel Estuardo Romero Matias
392	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Mario Humberto Vega Ponciano
393	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Julio Mauricio Juarez Lopez
394	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Juan Jose Flores
395	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Jose Eduardo Letona Fonseca
396	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Jose Antonio Mendez
397	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Jorge Alberto Estrada Manzo
398	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Henry David Fildalgo Galicia
399	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Maurel Perez
400	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Gerson Flores
401	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Fabio Rodas Falla
402	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Maria Maldonado
403	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	COMERCIALIZADORA
404	Suprema, S.A.	7	12	1203	12-TER03	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES BAMARSA	No definido	No definido	Carlos Alberto Ruedas Morataya
405	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Erick Cifuentes
406	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Vidal Ramirez
407	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Jose Aguilar
408	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Selvin Ovedh Luna Arenales
409	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Roberto Lopez
410	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Miguel Estuardo Romero Matias
411	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Mario Humberto Vega Ponciano
412	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Julio Mauricio Juarez Lopez
413	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Juan Jose Flores
414	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Jose Eduardo Letona Fonseca
415	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Jose Antonio Mendez
416	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Jorge Alberto Estrada Manzo
417	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Henry David Fildalgo Galicia
418	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Maurel Perez
419	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Gerson Flores
420	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Fabio Rodas Falla
421	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Maria Maldonado
422	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	COMERCIALIZADORA
423	Suprema, S.A.	7	12	1203	12-TER04	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES CDDK	No definido	No definido	Carlos Alberto Ruedas Morataya
424	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Erick Cifuentes
425	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Vidal Ramirez
426	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Jose Aguilar
427	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Selvin Ovedh Luna Arenales
428	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Roberto Lopez
429	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Miguel Estuardo Romero Matias
430	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Mario Humberto Vega Ponciano
431	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Julio Mauricio Juarez Lopez
432	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Juan Jose Flores
433	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Jose Eduardo Letona Fonseca
434	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Jose Antonio Mendez
435	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Jorge Alberto Estrada Manzo
436	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Henry David Fildalgo Galicia
437	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Maurel Perez
438	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Gerson Flores
439	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Fabio Rodas Falla
440	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Maria Maldonado
441	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	COMERCIALIZADORA
442	Suprema, S.A.	7	12	1203	12-TER05	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES ENRIQUEZ	No definido	No definido	Carlos Alberto Ruedas Morataya
443	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Erick Cifuentes
444	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Vidal Ramirez
445	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Jose Aguilar
446	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Selvin Ovedh Luna Arenales
447	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Roberto Lopez
448	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Miguel Estuardo Romero Matias
449	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Mario Humberto Vega Ponciano
450	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Julio Mauricio Juarez Lopez
451	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Juan Jose Flores
452	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Jose Eduardo Letona Fonseca
453	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Jose Antonio Mendez
454	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Jorge Alberto Estrada Manzo
455	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Henry David Fildalgo Galicia
456	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Maurel Perez
457	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Gerson Flores
458	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Fabio Rodas Falla
459	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Maria Maldonado
460	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	COMERCIALIZADORA
461	Suprema, S.A.	7	12	1203	12-TER06	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES GUERRA	No definido	No definido	Carlos Alberto Ruedas Morataya
462	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Erick Cifuentes
463	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Vidal Ramirez
464	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Jose Aguilar
465	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Selvin Ovedh Luna Arenales
466	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Roberto Lopez
467	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Miguel Estuardo Romero Matias
468	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Mario Humberto Vega Ponciano
469	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Julio Mauricio Juarez Lopez
470	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Juan Jose Flores
471	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Jose Eduardo Letona Fonseca
472	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Jose Antonio Mendez
473	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Jorge Alberto Estrada Manzo
474	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Henry David Fildalgo Galicia
475	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Maurel Perez
476	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Gerson Flores
477	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Fabio Rodas Falla
478	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Maria Maldonado
479	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	COMERCIALIZADORA
480	Suprema, S.A.	7	12	1203	12-TER07	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES GUZMAN	No definido	No definido	Carlos Alberto Ruedas Morataya
481	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Erick Cifuentes
482	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Vidal Ramirez
483	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Jose Aguilar
484	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Selvin Ovedh Luna Arenales
485	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Roberto Lopez
486	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Miguel Estuardo Romero Matias
487	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Mario Humberto Vega Ponciano
488	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Julio Mauricio Juarez Lopez
489	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Juan Jose Flores
490	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Jose Eduardo Letona Fonseca
491	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Jose Antonio Mendez
492	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Jorge Alberto Estrada Manzo
493	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Henry David Fildalgo Galicia
494	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Maurel Perez
495	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Gerson Flores
496	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Fabio Rodas Falla
497	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Maria Maldonado
498	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	COMERCIALIZADORA
499	Suprema, S.A.	7	12	1203	12-TER08	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES HERNANDEZ	No definido	No definido	Carlos Alberto Ruedas Morataya
500	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Erick Cifuentes
501	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Vidal Ramirez
502	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Jose Aguilar
503	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Selvin Ovedh Luna Arenales
504	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Roberto Lopez
505	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Miguel Estuardo Romero Matias
506	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Mario Humberto Vega Ponciano
507	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Julio Mauricio Juarez Lopez
508	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Juan Jose Flores
509	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Jose Eduardo Letona Fonseca
510	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Jose Antonio Mendez
511	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Jorge Alberto Estrada Manzo
512	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Henry David Fildalgo Galicia
513	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Maurel Perez
514	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Gerson Flores
515	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Fabio Rodas Falla
516	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Maria Maldonado
517	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	COMERCIALIZADORA
518	Suprema, S.A.	7	12	1203	12-TER09	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES MADALET	No definido	No definido	Carlos Alberto Ruedas Morataya
519	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Erick Cifuentes
520	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Vidal Ramirez
521	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Jose Aguilar
522	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Selvin Ovedh Luna Arenales
523	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Roberto Lopez
524	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Miguel Estuardo Romero Matias
525	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Mario Humberto Vega Ponciano
526	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Julio Mauricio Juarez Lopez
527	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Juan Jose Flores
528	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Jose Eduardo Letona Fonseca
529	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Jose Antonio Mendez
530	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Jorge Alberto Estrada Manzo
531	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Henry David Fildalgo Galicia
532	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Maurel Perez
533	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Gerson Flores
534	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Fabio Rodas Falla
535	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Maria Maldonado
536	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	COMERCIALIZADORA
537	Suprema, S.A.	7	12	1203	12-TER10	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES MAY	No definido	No definido	Carlos Alberto Ruedas Morataya
538	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Erick Cifuentes
539	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Vidal Ramirez
540	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Jose Aguilar
541	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Selvin Ovedh Luna Arenales
542	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Roberto Lopez
543	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Miguel Estuardo Romero Matias
544	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Mario Humberto Vega Ponciano
545	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Julio Mauricio Juarez Lopez
546	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Juan Jose Flores
547	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Jose Eduardo Letona Fonseca
548	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Jose Antonio Mendez
549	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Jorge Alberto Estrada Manzo
550	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Henry David Fildalgo Galicia
551	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Maurel Perez
552	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Gerson Flores
553	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Fabio Rodas Falla
554	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Maria Maldonado
555	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	COMERCIALIZADORA
556	Suprema, S.A.	7	12	1203	12-TER11	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES REYES SANTOS	No definido	No definido	Carlos Alberto Ruedas Morataya
557	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Erick Cifuentes
558	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Vidal Ramirez
559	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Jose Aguilar
560	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Selvin Ovedh Luna Arenales
561	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Roberto Lopez
562	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Miguel Estuardo Romero Matias
563	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Mario Humberto Vega Ponciano
564	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Julio Mauricio Juarez Lopez
565	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Juan Jose Flores
566	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Jose Eduardo Letona Fonseca
567	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Jose Antonio Mendez
568	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Jorge Alberto Estrada Manzo
569	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Henry David Fildalgo Galicia
570	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Maurel Perez
571	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Gerson Flores
572	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Fabio Rodas Falla
573	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Maria Maldonado
574	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	COMERCIALIZADORA
575	Suprema, S.A.	7	12	1203	12-TER12	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES V.W.	No definido	No definido	Carlos Alberto Ruedas Morataya
576	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M03	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Erick Cifuentes
577	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M05	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Vidal Ramirez
578	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A2S1M02	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Jose Aguilar
579	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A4S1M01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Selvin Ovedh Luna Arenales
580	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A2S1M01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Roberto Lopez
581	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M99	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Miguel Estuardo Romero Matias
582	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A3S1M99	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Mario Humberto Vega Ponciano
583	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A3S1M02	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Julio Mauricio Juarez Lopez
584	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M02	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Juan Jose Flores
585	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S2I01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Jose Eduardo Letona Fonseca
586	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M04	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Jose Antonio Mendez
587	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A3S1M03	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Jorge Alberto Estrada Manzo
588	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A5S1M01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Henry David Fildalgo Galicia
589	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S2S01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Maurel Perez
590	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S1M01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Gerson Flores
591	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A5S1M99	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Fabio Rodas Falla
592	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A1S2S02	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Maria Maldonado
593	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202P1A1C01	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	COMERCIALIZADORA
594	Suprema, S.A.	7	12	1203	12-TER13	L00	P00	0202A4S1M02	Logística	Transporte	TRANSPORTES VALENZUELA 15 TM	No definido	No definido	Carlos Alberto Ruedas Morataya
595	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M03	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
596	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M05	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
597	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A2S1M02	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Jose Aguilar
598	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A4S1M01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
599	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A2S1M01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Roberto Lopez
600	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M99	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
601	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A3S1M99	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
602	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A3S1M02	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
603	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M02	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
604	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S2I01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
605	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M04	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
606	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A3S1M03	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
607	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A5S1M01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
608	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S2S01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Maurel Perez
609	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S1M01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Gerson Flores
610	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A5S1M99	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
611	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A1S2S02	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Maria Maldonado
612	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202P1A1C01	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
613	Suprema, S.A.	7	12	1203	12-CAM02	L01	P01	0202A4S1M02	Logística	Transporte	CAMION C-351BKN	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
614	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M03	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
615	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M05	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
616	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A2S1M02	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Jose Aguilar
617	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A4S1M01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
618	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A2S1M01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Roberto Lopez
619	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M99	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
620	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A3S1M99	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
621	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A3S1M02	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
622	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M02	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
623	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S2I01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
624	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M04	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
625	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A3S1M03	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
626	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A5S1M01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
627	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S2S01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Maurel Perez
628	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S1M01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Gerson Flores
629	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A5S1M99	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
630	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A1S2S02	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Maria Maldonado
631	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202P1A1C01	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
632	Suprema, S.A.	7	12	1203	12-TER04	L01	P01	0202A4S1M02	Logística	Transporte	TRANSPORTES CDDK	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
633	Suprema, S.A.	8	12	1202	U02	L01	P02	0202P1A1C01	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
634	Suprema, S.A.	8	12	1202	U02	L01	P02	0201P1S1M01	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites Empacados	Gerencia General
635	Suprema, S.A.	8	12	1203	U02	L01	P02	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
636	Suprema, S.A.	8	12	1203	U02	L01	P01	0202P1A1C01	Logística	Transporte	Planta	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
637	Suprema, S.A.	7	13	1301	U01	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	Oficinas Centrales	No definido	No definido	Gerencia General
638	Suprema, S.A.	7	13	1301	U02	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Gerencia General
639	Suprema, S.A.	7	13	1302	U01	L00	P00	0201P1S1M01	Seguridad	Ejecutiva	Oficinas Centrales	No definido	No definido	Gerencia General
640	Suprema, S.A.	7	13	1303	U01	L00	P00	0201P1S1M01	Seguridad	Perimetral	Oficinas Centrales	No definido	No definido	Gerencia General
641	Suprema, S.A.	7	13	1303	U02	L00	P00	0201P1S1M01	Seguridad	Perimetral	Planta	No definido	No definido	Gerencia General
642	Suprema, S.A.	7	13	1304	U02	L00	P00	0202P1A1C01	Seguridad	De Ruta	Planta	No definido	No definido	COMERCIALIZADORA
643	Suprema, S.A.	7	13	1304	U02	L01	P01	0202P1A1C01	Seguridad	De Ruta	Planta	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
644	Suprema, S.A.	7	13	1304	U02	L01	P02	0202P1A1C01	Seguridad	De Ruta	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
645	Suprema, S.A.	7	13	1304	U02	L01	P03	0202P1A1C01	Seguridad	De Ruta	Planta	Grasas y Aceites	Mantecas	COMERCIALIZADORA
646	Suprema, S.A.	7	13	1304	U02	L01	P04	0202P1A1C01	Seguridad	De Ruta	Planta	Grasas y Aceites	Margarinas	COMERCIALIZADORA
647	Suprema, S.A.	7	13	1304	U02	L02	P11	0202P1A1C01	Seguridad	De Ruta	Planta	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
648	Suprema, S.A.	8	13	1304	U02	L01	P02	0202P1A1C01	Seguridad	De Ruta	Planta	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
649	Suprema, S.A.	6	20	2000	U02	L08	P20	0201P1S1M01	Producción	Superintendencia de Procesos	Planta	Procesos Productivos	No definido-Costo - planta ref	Gerencia General
650	Suprema, S.A.	6	20	2001	U02	L08	P20	0201P1S1M01	Producción	Jefatura General Produccion	Planta	Procesos Productivos	No definido-Costo - planta ref	Gerencia General
651	Suprema, S.A.	6	20	2002	U02	L08	P20	0201P1S1M01	Producción	Jefatura Grasas y Aceites	Planta	Procesos Productivos	No definido-Costo - planta ref	Gerencia General
652	Suprema, S.A.	6	20	2003	U02	L08	P30	0201P1S1M01	Producción	Jefatura Envasado	Planta	Procesos Productivos	No definido-costo - envasado	Gerencia General
653	Suprema, S.A.	6	20	2011	U02	L08	P20	0201P1S1M01	Producción	Grasas y Aceites Refinados	Planta	Procesos Productivos	No definido-Costo - planta ref	Gerencia General
654	Suprema, S.A.	6	20	2011	U02	L08	P21	0201P1S1M01	Producción	Grasas y Aceites Refinados	Planta	Procesos Productivos	Blanqueo	Gerencia General
655	Suprema, S.A.	6	20	2011	U02	L08	P22	0201P1S1M01	Producción	Grasas y Aceites Refinados	Planta	Procesos Productivos	Desodorizado	Gerencia General
656	Suprema, S.A.	6	20	2011	U02	L08	P23	0201P1S1M01	Producción	Grasas y Aceites Refinados	Planta	Procesos Productivos	Fraccionamiento	Gerencia General
657	Suprema, S.A.	6	20	2011	U02	L08	P33	0201P1S1M01	Producción	Grasas y Aceites Refinados	Planta	Procesos Productivos	Preparación de margarina	Gerencia General
658	Suprema, S.A.	6	20	2012	U02	L08	P30	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	No definido-costo - envasado	Gerencia General
659	Suprema, S.A.	6	20	2012	U02	L08	P31	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	Linea envasado aceite e-pack	Gerencia General
660	Suprema, S.A.	6	20	2012	U02	L08	P32	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	Linea de envasado canecas	Gerencia General
661	Suprema, S.A.	6	20	2012	U02	L08	P34	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	Envasado manteca y margarina	Gerencia General
662	Suprema, S.A.	6	20	2012	U02	L08	P36	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	Envasado margarina en barra	Gerencia General
663	Suprema, S.A.	6	20	2012	U02	L08	P37	0201P1S1M01	Producción	Envasado Grasas y Aceites	Planta	Procesos Productivos	Linea aceite Galonera	Gerencia General
664	Suprema, S.A.	6	20	2021	U02	L08	P20	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	No definido-Costo - planta ref	Gerencia General
665	Suprema, S.A.	6	20	2021	U02	L08	P21	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Blanqueo	Gerencia General
666	Suprema, S.A.	6	20	2021	U02	L08	P22	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Desodorizado	Gerencia General
667	Suprema, S.A.	6	20	2021	U02	L08	P23	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Fraccionamiento	Gerencia General
668	Suprema, S.A.	6	20	2021	U02	L08	P30	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	No definido-costo - envasado	Gerencia General
669	Suprema, S.A.	6	20	2021	U02	L08	P31	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Linea envasado aceite e-pack	Gerencia General
670	Suprema, S.A.	6	20	2021	U02	L08	P32	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Linea de envasado canecas	Gerencia General
671	Suprema, S.A.	6	20	2021	U02	L08	P33	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Preparación de margarina	Gerencia General
672	Suprema, S.A.	6	20	2021	U02	L08	P34	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Envasado manteca y margarina	Gerencia General
673	Suprema, S.A.	6	20	2021	U02	L08	P36	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Envasado margarina en barra	Gerencia General
674	Suprema, S.A.	6	20	2021	U02	L08	P37	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	Linea aceite Galonera	Gerencia General
675	Suprema, S.A.	6	20	2021	U02	L08	P50	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
676	Suprema, S.A.	6	20	2022	U02	L08	P50	0201P1S1M01	Producción	Calderas	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
677	Suprema, S.A.	6	20	2023	U02	L08	P50	0201P1S1M01	Producción	Planta de tratamiento de Aguas	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
678	Suprema, S.A.	6	20	2099	U02	L08	P50	0201P1S1M01	Producción	Procesos Productivos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
679	Suprema, S.A.	7	20	2000	U02	L00	P00	0201P1S1M01	Producción	Superintendencia de Procesos	Planta	No definido	No definido	Gerencia General
680	Suprema, S.A.	8	20	2021	U02	L08	P50	0201P1S1M01	Producción	Mantenimiento Grasas y Aceites	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
681	Suprema, S.A.	6	21	2101	U02	L08	P50	0201P1S1M01	Control de Calidad	Jefatura Control de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
682	Suprema, S.A.	6	21	2102	U02	L08	P50	0201P1S1M01	Control de Calidad	Laboratorio	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
683	Suprema, S.A.	6	21	2103	U02	L08	P50	0201P1S1M01	Control de Calidad	Inspección de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
684	Suprema, S.A.	7	30	3001	U01	L00	P00	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
685	Suprema, S.A.	7	30	3001	U01	L01	P01	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
686	Suprema, S.A.	7	30	3001	U01	L01	P02	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
687	Suprema, S.A.	7	30	3001	U01	L01	P03	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
688	Suprema, S.A.	7	30	3001	U01	L01	P04	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
689	Suprema, S.A.	7	30	3001	U01	L02	P11	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
690	Suprema, S.A.	7	30	3002	U01	L00	P00	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
691	Suprema, S.A.	7	30	3002	U01	L01	P01	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
692	Suprema, S.A.	7	30	3002	U01	L01	P02	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
693	Suprema, S.A.	7	30	3002	U01	L01	P03	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
694	Suprema, S.A.	7	30	3002	U01	L01	P04	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
695	Suprema, S.A.	7	30	3002	U01	L02	P11	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
696	Suprema, S.A.	7	30	3002	U01	L00	P00	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	No definido	No definido	Luis Arturo Echeverria
697	Suprema, S.A.	7	30	3002	U01	L01	P01	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Luis Arturo Echeverria
698	Suprema, S.A.	7	30	3002	U01	L01	P02	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Luis Arturo Echeverria
699	Suprema, S.A.	7	30	3002	U01	L01	P03	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Mantecas	Luis Arturo Echeverria
700	Suprema, S.A.	7	30	3002	U01	L01	P04	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Grasas y Aceites	Margarinas	Luis Arturo Echeverria
701	Suprema, S.A.	7	30	3002	U01	L02	P11	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Luis Arturo Echeverria
702	Suprema, S.A.	7	30	3003	U01	L00	P00	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	No definido	No definido	Maria Maldonado
703	Suprema, S.A.	7	30	3003	U01	L01	P01	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
704	Suprema, S.A.	7	30	3003	U01	L01	P02	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
705	Suprema, S.A.	7	30	3003	U01	L01	P03	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
706	Suprema, S.A.	7	30	3003	U01	L01	P04	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
707	Suprema, S.A.	7	30	3003	U01	L02	P11	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
708	Suprema, S.A.	7	30	3003	U01	L00	P00	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	No definido	No definido	Carlos Alberto Ruedas Morataya
709	Suprema, S.A.	7	30	3003	U01	L01	P01	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
710	Suprema, S.A.	7	30	3003	U01	L01	P02	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
711	Suprema, S.A.	7	30	3003	U01	L01	P03	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
712	Suprema, S.A.	7	30	3003	U01	L01	P04	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
713	Suprema, S.A.	7	30	3003	U01	L02	P11	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
714	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Erick Cifuentes
715	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
716	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
717	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
718	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
719	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
720	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Vidal Ramirez
721	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
722	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
723	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
724	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
725	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M05	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
726	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Jose Aguilar
727	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
728	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
729	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
730	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
731	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A2S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
732	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
733	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1D02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
734	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M06	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
735	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A3S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
736	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A4S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
737	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
738	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1D02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
739	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M06	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
740	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A3S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
741	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A4S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
742	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
743	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1D02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
744	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M06	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
745	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A3S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
746	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A4S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
747	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
748	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1D02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
749	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M06	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
750	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A3S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
751	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A4S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
752	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
753	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1D02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
754	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M06	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
755	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A3S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
756	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A4S1D01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
757	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Selvin Ovedh Luna Arenales
758	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
759	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
760	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
761	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
762	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A4S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
763	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Roberto Lopez
764	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
765	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
766	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
767	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
768	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A2S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
769	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Miguel Estuardo Romero Matias
770	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
771	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
772	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
773	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
774	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
775	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Julio Mauricio Juarez Lopez
776	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
777	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
778	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
779	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
780	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A3S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
781	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Juan Jose Flores
782	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
783	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
784	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
785	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
786	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M02	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
787	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Jose Eduardo Letona Fonseca
788	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
789	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
790	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
791	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
792	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S2I01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
793	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Jose Antonio Mendez
794	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
795	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
796	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
797	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
798	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M04	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
799	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Jorge Alberto Estrada Manzo
800	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
801	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
802	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
803	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
804	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A3S1M03	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
805	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Henry David Fildalgo Galicia
806	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
807	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
808	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
809	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
810	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A5S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
811	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Gerson Flores
812	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
813	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
814	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
815	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
816	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A1S1M01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
817	Suprema, S.A.	7	30	3004	U01	L00	P00	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	Fabio Rodas Falla
818	Suprema, S.A.	7	30	3004	U01	L01	P01	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
819	Suprema, S.A.	7	30	3004	U01	L01	P02	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
820	Suprema, S.A.	7	30	3004	U01	L01	P03	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
821	Suprema, S.A.	7	30	3004	U01	L01	P04	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
822	Suprema, S.A.	7	30	3004	U01	L02	P11	0202A5S1M99	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
823	Suprema, S.A.	7	30	3004	U01	L00	P00	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
824	Suprema, S.A.	7	30	3004	U01	L01	P01	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
825	Suprema, S.A.	7	30	3004	U01	L01	P02	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
826	Suprema, S.A.	7	30	3004	U01	L01	P03	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
827	Suprema, S.A.	7	30	3004	U01	L01	P04	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
828	Suprema, S.A.	7	30	3004	U01	L02	P11	0202P1A1C01	Dirección Comercial	Canal Tradicional	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
829	Suprema, S.A.	7	30	3005	U01	L00	P00	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	No definido	No definido	Mario Humberto Vega Ponciano
830	Suprema, S.A.	7	30	3005	U01	L01	P01	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
831	Suprema, S.A.	7	30	3005	U01	L01	P02	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
832	Suprema, S.A.	7	30	3005	U01	L01	P03	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
833	Suprema, S.A.	7	30	3005	U01	L01	P04	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
834	Suprema, S.A.	7	30	3005	U01	L02	P11	0202A3S1M99	Dirección Comercial	Canal distribución horizontal	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
835	Suprema, S.A.	7	30	3006	U01	L00	P00	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	No definido	No definido	Maurel Perez
836	Suprema, S.A.	7	30	3006	U01	L01	P01	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
837	Suprema, S.A.	7	30	3006	U01	L01	P02	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
838	Suprema, S.A.	7	30	3006	U01	L01	P03	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
839	Suprema, S.A.	7	30	3006	U01	L01	P04	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
840	Suprema, S.A.	7	30	3006	U01	L02	P11	0202A1S2S01	Dirección Comercial	Canal Moderno	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
841	Suprema, S.A.	7	30	3007	U01	L00	P00	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	No definido	No definido	Fernando Ovalle
842	Suprema, S.A.	7	30	3007	U01	L01	P01	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fernando Ovalle
843	Suprema, S.A.	7	30	3007	U01	L01	P02	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fernando Ovalle
844	Suprema, S.A.	7	30	3007	U01	L01	P03	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Mantecas	Fernando Ovalle
845	Suprema, S.A.	7	30	3007	U01	L01	P04	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Margarinas	Fernando Ovalle
846	Suprema, S.A.	7	30	3007	U01	L02	P11	0202T1S1M01	Dirección Comercial	Canal exportación	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fernando Ovalle
847	Suprema, S.A.	7	30	3007	U01	L00	P00	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	No definido	No definido	Exportacion
848	Suprema, S.A.	7	30	3007	U01	L01	P01	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Exportacion
849	Suprema, S.A.	7	30	3007	U01	L01	P02	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Exportacion
850	Suprema, S.A.	7	30	3007	U01	L01	P03	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Mantecas	Exportacion
851	Suprema, S.A.	7	30	3007	U01	L01	P04	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Margarinas	Exportacion
852	Suprema, S.A.	7	30	3007	U01	L02	P11	0201P1S1M04	Dirección Comercial	Canal exportación	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Exportacion
853	Suprema, S.A.	7	30	3007	U01	L00	P00	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	No definido	No definido	Donald Quan
854	Suprema, S.A.	7	30	3007	U01	L01	P01	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Donald Quan
855	Suprema, S.A.	7	30	3007	U01	L01	P02	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Donald Quan
856	Suprema, S.A.	7	30	3007	U01	L01	P03	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Mantecas	Donald Quan
857	Suprema, S.A.	7	30	3007	U01	L01	P04	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	Grasas y Aceites	Margarinas	Donald Quan
858	Suprema, S.A.	7	30	3007	U01	L02	P11	0201P1S1M02	Dirección Comercial	Canal exportación	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Donald Quan
859	Suprema, S.A.	7	30	3008	U01	L00	P00	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
860	Suprema, S.A.	7	30	3008	U01	L01	P01	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
861	Suprema, S.A.	7	30	3008	U01	L01	P02	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
862	Suprema, S.A.	7	30	3008	U01	L01	P03	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
863	Suprema, S.A.	7	30	3008	U01	L01	P04	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
864	Suprema, S.A.	7	30	3008	U01	L02	P11	0202P1A1C01	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
865	Suprema, S.A.	7	30	3008	U01	L00	P00	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	No definido	No definido	Monica Aristondo
866	Suprema, S.A.	7	30	3008	U01	L01	P01	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Monica Aristondo
867	Suprema, S.A.	7	30	3008	U01	L01	P02	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Monica Aristondo
868	Suprema, S.A.	7	30	3008	U01	L01	P03	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Mantecas	Monica Aristondo
869	Suprema, S.A.	7	30	3008	U01	L01	P04	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Grasas y Aceites	Margarinas	Monica Aristondo
870	Suprema, S.A.	7	30	3008	U01	L02	P11	0202A1S1M98	Dirección Comercial	Gerencia Vtas canales especial	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Monica Aristondo
871	Suprema, S.A.	8	30	3001	U01	L00	P00	0202P1A1C01	Dirección Comercial	Direccion Comercial	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
872	Suprema, S.A.	8	30	3002	U01	L00	P00	0202P1A1C01	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
873	Suprema, S.A.	8	30	3002	U01	L00	P00	0202A3S1M98	Dirección Comercial	Gerencia Vta tradicional/Distr	Oficinas Centrales	No definido	No definido	Luis Arturo Echeverria
874	Suprema, S.A.	8	30	3003	U01	L00	P00	0202A1S2S02	Dirección Comercial	Canal B2B	Oficinas Centrales	No definido	No definido	Maria Maldonado
875	Suprema, S.A.	8	30	3003	U01	L00	P00	0202A4S1M02	Dirección Comercial	Canal B2B	Oficinas Centrales	No definido	No definido	Carlos Alberto Ruedas Morataya
876	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
877	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
878	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
879	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
880	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
881	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M05	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
882	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M05	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
883	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M05	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
884	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M05	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
885	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M05	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
886	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A2S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
887	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A2S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
888	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A2S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
889	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A2S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
890	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A2S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
891	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
892	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1D02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
893	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M06	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
894	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A3S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
895	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A4S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
896	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
897	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1D02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
898	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M06	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
899	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A3S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
900	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A4S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
901	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
902	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1D02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
903	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M06	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
904	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A3S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
905	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A4S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
906	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
907	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1D02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
908	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M06	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
909	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A3S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
910	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A4S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
911	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
912	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1D02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
913	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M06	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
914	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A3S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
915	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A4S1D01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
916	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A4S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
917	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A4S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
918	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A4S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
919	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A4S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
920	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A4S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
921	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A2S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
922	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A2S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
923	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A2S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
924	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A2S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
925	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A2S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
926	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
927	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
928	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
929	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
930	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
931	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A3S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
932	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A3S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
933	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A3S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
934	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A3S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
935	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A3S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
936	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A3S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
937	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A3S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
938	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A3S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
939	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A3S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
940	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A3S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
941	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
942	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
943	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
944	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
945	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
946	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S2I01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
947	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S2I01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
948	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S2I01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
949	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S2I01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
950	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S2I01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
951	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M04	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
952	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M04	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
953	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M04	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
954	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M04	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
955	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M04	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
956	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A3S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
957	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A3S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
958	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A3S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
959	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A3S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
960	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A3S1M03	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
961	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A5S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
962	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A5S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
963	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A5S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
964	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A5S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
965	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A5S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
966	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S2S01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
967	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S2S01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
968	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S2S01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
969	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S2S01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
970	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S2S01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
971	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
972	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
973	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
974	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
975	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
976	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A5S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
977	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A5S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
978	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A5S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
979	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A5S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
980	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A5S1M99	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
981	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A1S2S02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
982	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A1S2S02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
983	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A1S2S02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
984	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A1S2S02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
985	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A1S2S02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
986	Suprema, S.A.	7	31	3101	U01	L00	P00	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
987	Suprema, S.A.	7	31	3101	U01	L01	P01	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
988	Suprema, S.A.	7	31	3101	U01	L01	P02	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
989	Suprema, S.A.	7	31	3101	U01	L01	P03	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
990	Suprema, S.A.	7	31	3101	U01	L01	P04	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
991	Suprema, S.A.	7	31	3101	U01	L02	P11	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
992	Suprema, S.A.	7	31	3101	U01	L01	P01	0202A4S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
993	Suprema, S.A.	7	31	3101	U01	L01	P02	0202A4S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
994	Suprema, S.A.	7	31	3101	U01	L01	P03	0202A4S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
995	Suprema, S.A.	7	31	3101	U01	L01	P04	0202A4S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
996	Suprema, S.A.	7	31	3101	U01	L02	P11	0202A4S1M02	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
997	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
998	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
999	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
1000	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
1001	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
1002	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M05	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
1003	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M05	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
1004	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M05	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
1005	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M05	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
1006	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M05	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
1007	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A2S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
1008	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A2S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
1009	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A2S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
1010	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A2S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
1011	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A2S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
1012	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1013	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1D02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1014	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M06	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1015	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A3S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1016	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A4S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1017	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1018	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1D02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1019	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M06	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1020	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A3S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1021	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A4S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1022	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1023	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1D02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1024	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M06	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1025	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A3S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1026	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A4S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1027	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1028	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1D02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1029	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M06	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1030	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A3S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1031	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A4S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1032	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1033	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1D02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1034	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M06	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1035	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A3S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1036	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A4S1D01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1037	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A4S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
1038	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A4S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
1039	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A4S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
1040	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A4S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
1041	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A4S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
1042	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A2S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
1043	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A2S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
1044	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A2S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
1045	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A2S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
1046	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A2S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
1047	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
1048	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
1049	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
1050	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
1051	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
1052	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A3S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
1053	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A3S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
1054	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A3S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
1055	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A3S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
1056	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A3S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
1057	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A3S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
1058	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A3S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
1059	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A3S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
1060	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A3S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
1061	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A3S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
1062	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
1063	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
1064	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
1065	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
1066	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
1067	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S2I01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
1068	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S2I01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
1069	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S2I01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
1070	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S2I01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
1071	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S2I01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
1072	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M04	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
1073	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M04	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
1074	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M04	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
1075	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M04	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
1076	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M04	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
1077	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A3S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
1078	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A3S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
1079	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A3S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
1080	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A3S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
1081	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A3S1M03	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
1082	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A5S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
1083	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A5S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
1084	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A5S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
1085	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A5S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
1086	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A5S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
1087	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S2S01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
1088	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1089	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S2S01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
1090	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S2S01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
1091	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1092	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
1093	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
1094	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
1095	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
1096	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S1M01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
1097	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A5S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
1098	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A5S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
1099	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A5S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
1100	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A5S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
1101	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A5S1M99	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
1102	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A1S2S02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
1103	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A1S2S02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
1104	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A1S2S02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
1105	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A1S2S02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
1106	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A1S2S02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
1107	Suprema, S.A.	7	31	3102	U01	L01	P01	0201P1S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Donald Quan
1108	Suprema, S.A.	7	31	3102	U01	L00	P00	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1109	Suprema, S.A.	7	31	3102	U01	L01	P01	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
1110	Suprema, S.A.	7	31	3102	U01	L01	P02	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
1111	Suprema, S.A.	7	31	3102	U01	L01	P03	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
1112	Suprema, S.A.	7	31	3102	U01	L01	P04	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
1113	Suprema, S.A.	7	31	3102	U01	L02	P11	0202P1A1C01	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
1114	Suprema, S.A.	7	31	3102	U01	L01	P01	0202A4S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
1115	Suprema, S.A.	7	31	3102	U01	L01	P02	0202A4S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
1116	Suprema, S.A.	7	31	3102	U01	L01	P03	0202A4S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
1117	Suprema, S.A.	7	31	3102	U01	L01	P04	0202A4S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
1118	Suprema, S.A.	7	31	3102	U01	L02	P11	0202A4S1M02	Mercadeo	Ventas Gerencia	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
1119	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
1120	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
1121	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
1122	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
1123	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
1124	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M05	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
1125	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M05	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
1126	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M05	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
1127	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M05	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
1128	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M05	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
1129	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A2S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
1130	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A2S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
1131	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A2S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
1132	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A2S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
1133	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A2S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
1134	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1135	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1D02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1136	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M06	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1137	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A3S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1138	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A4S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1139	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1140	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1D02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1141	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M06	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1142	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A3S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1143	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A4S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1144	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1145	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1D02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1146	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M06	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1147	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A3S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1148	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A4S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1149	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1150	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1D02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1151	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M06	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1152	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A3S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1153	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A4S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1154	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1155	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1D02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1156	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M06	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1157	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A3S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1158	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A4S1D01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1159	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A4S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
1160	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A4S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
1161	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A4S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
1162	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A4S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
1163	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A4S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
1164	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A2S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
1165	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A2S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
1166	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A2S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
1167	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A2S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
1168	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A2S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
1169	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
1170	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
1171	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
1172	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
1173	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
1174	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A3S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
1175	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A3S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
1176	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A3S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
1177	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A3S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
1178	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A3S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
1179	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A3S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
1180	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A3S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
1181	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A3S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
1182	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A3S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
1183	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A3S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
1184	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
1185	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
1186	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
1187	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
1188	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
1189	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S2I01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
1190	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S2I01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
1191	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S2I01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
1192	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S2I01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
1193	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S2I01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
1194	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M04	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
1195	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M04	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
1196	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M04	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
1197	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M04	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
1198	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M04	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
1199	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A3S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
1200	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A3S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
1201	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A3S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
1202	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A3S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
1203	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A3S1M03	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
1204	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A5S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
1205	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A5S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
1206	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A5S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
1207	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A5S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
1208	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A5S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
1209	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S2S01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
1210	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1211	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S2S01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
1212	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S2S01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
1213	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1214	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
1215	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
1216	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
1217	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
1218	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
1219	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A5S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
1220	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A5S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
1221	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A5S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
1222	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A5S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
1223	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A5S1M99	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
1224	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A1S2S02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
1225	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A1S2S02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
1226	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A1S2S02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
1227	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A1S2S02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
1228	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A1S2S02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
1229	Suprema, S.A.	7	31	3103	U01	L00	P00	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1230	Suprema, S.A.	7	31	3103	U01	L01	P01	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
1231	Suprema, S.A.	7	31	3103	U01	L01	P02	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
1232	Suprema, S.A.	7	31	3103	U01	L01	P03	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
1233	Suprema, S.A.	7	31	3103	U01	L01	P04	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
1234	Suprema, S.A.	7	31	3103	U01	L02	P11	0202P1A1C01	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
1235	Suprema, S.A.	7	31	3103	U01	L01	P01	0202A4S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
1236	Suprema, S.A.	7	31	3103	U01	L01	P02	0202A4S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
1237	Suprema, S.A.	7	31	3103	U01	L01	P03	0202A4S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
1238	Suprema, S.A.	7	31	3103	U01	L01	P04	0202A4S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
1239	Suprema, S.A.	7	31	3103	U01	L02	P11	0202A4S1M02	Mercadeo	Ventas Institucional-Industria	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
1240	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
1241	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
1242	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Erick Cifuentes
1243	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
1244	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
1245	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
1246	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M05	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
1247	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M05	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
1248	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M05	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
1249	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M05	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
1250	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M05	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
1251	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
1252	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Jose Aguilar
1253	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
1254	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
1255	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
1256	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
1257	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1258	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1D02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1259	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M06	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1260	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A3S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1261	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A4S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1262	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1263	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1D02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1264	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M06	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1265	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A3S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1266	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A4S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1267	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1268	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1D02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1269	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M06	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1270	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A3S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1271	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A4S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1272	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1273	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1D02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1274	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M06	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1275	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A3S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1276	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A4S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1277	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1278	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1D02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1279	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M06	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1280	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A3S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1281	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A4S1D01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1282	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Selvin Ovedh Luna Arenales
1283	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
1284	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
1285	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
1286	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
1287	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
1288	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
1289	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Roberto Lopez
1290	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
1291	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
1292	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
1293	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
1294	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Miguel Estuardo Romero Matias
1295	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
1296	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
1297	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
1298	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
1299	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
1300	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
1301	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Mario Humberto Vega Ponciano
1302	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
1303	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
1304	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
1305	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
1306	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Julio Mauricio Juarez Lopez
1307	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
1308	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
1309	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
1310	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
1311	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A3S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
1312	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Juan Jose Flores
1313	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
1314	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
1315	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
1316	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
1317	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
1318	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S2I01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
1319	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S2I01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
1320	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S2I01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
1321	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S2I01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
1322	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S2I01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
1323	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M04	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
1324	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M04	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
1325	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M04	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
1326	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M04	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
1327	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M04	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
1328	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
1329	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Jorge Alberto Estrada Manzo
1330	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
1331	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
1332	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
1333	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
1334	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
1335	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Henry David Fildalgo Galicia
1336	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
1337	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
1338	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
1339	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
1340	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S2S01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
1341	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1342	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S2S01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
1343	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S2S01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
1344	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1345	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Gerson Flores
1346	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
1347	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
1348	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
1349	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
1350	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
1351	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
1352	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Fabio Rodas Falla
1353	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
1354	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
1355	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
1356	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
1357	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A1S2S02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
1358	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A1S2S02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
1359	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A1S2S02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
1360	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A1S2S02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
1361	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A1S2S02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
1362	Suprema, S.A.	7	31	3104	U01	L00	P00	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1363	Suprema, S.A.	7	31	3104	U01	L01	P01	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
1364	Suprema, S.A.	7	31	3104	U01	L01	P02	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
1365	Suprema, S.A.	7	31	3104	U01	L01	P03	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
1366	Suprema, S.A.	7	31	3104	U01	L01	P04	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
1367	Suprema, S.A.	7	31	3104	U01	L02	P11	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
1368	Suprema, S.A.	7	31	3104	U01	L00	P00	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Carlos Alberto Ruedas Morataya
1369	Suprema, S.A.	7	31	3104	U01	L01	P01	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
1370	Suprema, S.A.	7	31	3104	U01	L01	P02	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
1371	Suprema, S.A.	7	31	3104	U01	L01	P03	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
1372	Suprema, S.A.	7	31	3104	U01	L01	P04	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
1373	Suprema, S.A.	7	31	3104	U01	L02	P11	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
1374	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Erick Cifuentes
1375	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Erick Cifuentes
1376	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Erick Cifuentes
1377	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Erick Cifuentes
1378	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Erick Cifuentes
1379	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M05	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vidal Ramirez
1380	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M05	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vidal Ramirez
1381	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M05	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vidal Ramirez
1382	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M05	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vidal Ramirez
1383	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M05	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vidal Ramirez
1384	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A2S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Aguilar
1385	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A2S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Aguilar
1386	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A2S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Aguilar
1387	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A2S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Aguilar
1388	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A2S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Aguilar
1389	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1390	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1D02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1391	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M06	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1392	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A3S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1393	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A4S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Vacante
1394	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1395	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1D02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1396	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M06	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1397	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A3S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1398	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A4S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Vacante
1399	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1400	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1D02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1401	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M06	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1402	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A3S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1403	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A4S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Vacante
1404	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1405	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1D02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1406	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M06	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1407	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A3S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1408	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A4S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Vacante
1409	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1410	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1D02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1411	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M06	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1412	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A3S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1413	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A4S1D01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Vacante
1414	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A4S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Selvin Ovedh Luna Arenales
1415	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A4S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Selvin Ovedh Luna Arenales
1416	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A4S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Selvin Ovedh Luna Arenales
1417	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A4S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Selvin Ovedh Luna Arenales
1418	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A4S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Selvin Ovedh Luna Arenales
1419	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A2S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Roberto Lopez
1420	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A2S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Roberto Lopez
1421	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A2S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Roberto Lopez
1422	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A2S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Roberto Lopez
1423	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A2S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Roberto Lopez
1424	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Miguel Estuardo Romero Matias
1425	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Miguel Estuardo Romero Matias
1426	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Miguel Estuardo Romero Matias
1427	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Miguel Estuardo Romero Matias
1428	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Miguel Estuardo Romero Matias
1429	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A3S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Mario Humberto Vega Ponciano
1430	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A3S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Mario Humberto Vega Ponciano
1431	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A3S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Mario Humberto Vega Ponciano
1432	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A3S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Mario Humberto Vega Ponciano
1433	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A3S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Humberto Vega Ponciano
1434	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A3S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Julio Mauricio Juarez Lopez
1435	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A3S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Julio Mauricio Juarez Lopez
1436	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A3S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Julio Mauricio Juarez Lopez
1437	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A3S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Julio Mauricio Juarez Lopez
1438	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A3S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Julio Mauricio Juarez Lopez
1439	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Juan Jose Flores
1440	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Juan Jose Flores
1441	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Juan Jose Flores
1442	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Juan Jose Flores
1443	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Juan Jose Flores
1444	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S2I01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Eduardo Letona Fonseca
1445	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S2I01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Eduardo Letona Fonseca
1446	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S2I01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Eduardo Letona Fonseca
1447	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S2I01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Eduardo Letona Fonseca
1448	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S2I01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Eduardo Letona Fonseca
1449	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M04	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jose Antonio Mendez
1450	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M04	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jose Antonio Mendez
1451	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M04	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Jose Antonio Mendez
1452	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M04	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Jose Antonio Mendez
1453	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M04	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jose Antonio Mendez
1454	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A3S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Jorge Alberto Estrada Manzo
1455	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A3S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Jorge Alberto Estrada Manzo
1456	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A3S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Jorge Alberto Estrada Manzo
1457	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A3S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Jorge Alberto Estrada Manzo
1458	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A3S1M03	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Jorge Alberto Estrada Manzo
1459	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A5S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Henry David Fildalgo Galicia
1460	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A5S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Henry David Fildalgo Galicia
1461	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A5S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Henry David Fildalgo Galicia
1462	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A5S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Henry David Fildalgo Galicia
1463	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A5S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Henry David Fildalgo Galicia
1464	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S2S01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
1465	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1466	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S2S01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
1467	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S2S01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
1468	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1469	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Gerson Flores
1470	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Gerson Flores
1471	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Gerson Flores
1472	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Gerson Flores
1473	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S1M01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Gerson Flores
1474	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A5S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Fabio Rodas Falla
1475	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A5S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
1476	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A5S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Fabio Rodas Falla
1477	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A5S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Fabio Rodas Falla
1478	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A5S1M99	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Fabio Rodas Falla
1479	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A1S2S02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maria Maldonado
1480	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A1S2S02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maria Maldonado
1481	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A1S2S02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Maria Maldonado
1482	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A1S2S02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Maria Maldonado
1483	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A1S2S02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maria Maldonado
1484	Suprema, S.A.	7	31	3105	U01	L00	P00	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1485	Suprema, S.A.	7	31	3105	U01	L01	P01	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	COMERCIALIZADORA
1486	Suprema, S.A.	7	31	3105	U01	L01	P02	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	COMERCIALIZADORA
1487	Suprema, S.A.	7	31	3105	U01	L01	P03	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	COMERCIALIZADORA
1488	Suprema, S.A.	7	31	3105	U01	L01	P04	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	COMERCIALIZADORA
1489	Suprema, S.A.	7	31	3105	U01	L02	P11	0202P1A1C01	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	COMERCIALIZADORA
1490	Suprema, S.A.	7	31	3105	U01	L01	P01	0202A4S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Carlos Alberto Ruedas Morataya
1491	Suprema, S.A.	7	31	3105	U01	L01	P02	0202A4S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Carlos Alberto Ruedas Morataya
1492	Suprema, S.A.	7	31	3105	U01	L01	P03	0202A4S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Mantecas	Carlos Alberto Ruedas Morataya
1493	Suprema, S.A.	7	31	3105	U01	L01	P04	0202A4S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Grasas y Aceites	Margarinas	Carlos Alberto Ruedas Morataya
1494	Suprema, S.A.	7	31	3105	U01	L02	P11	0202A4S1M02	Mercadeo	Ventas al Detalle	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Carlos Alberto Ruedas Morataya
1495	Suprema, S.A.	7	31	3106	U01	L00	P00	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	No definido	No definido	Maurel Perez
1496	Suprema, S.A.	7	31	3106	U01	L01	P00	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	No definido	Maurel Perez
1497	Suprema, S.A.	7	31	3106	U01	L01	P01	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	Aceites a Granel	Maurel Perez
1498	Suprema, S.A.	7	31	3106	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1499	Suprema, S.A.	7	31	3106	U01	L01	P03	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	Mantecas	Maurel Perez
1500	Suprema, S.A.	7	31	3106	U01	L01	P04	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	Margarinas	Maurel Perez
1501	Suprema, S.A.	7	31	3106	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1502	Suprema, S.A.	8	31	3101	U01	L00	P00	0202P1A1C01	Mercadeo	Jefatura Mercadeo	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1503	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A4S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Selvin Ovedh Luna Arenales
1504	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A4S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Carlos Alberto Ruedas Morataya
1505	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A5S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Henry David Fildalgo Galicia
1506	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A3S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Jorge Alberto Estrada Manzo
1507	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A2S1M01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Roberto Lopez
1508	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A2S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Jose Aguilar
1509	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A1S1M02	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Juan Jose Flores
1510	Suprema, S.A.	8	31	3104	U01	L01	P02	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Fabio Rodas Falla
1511	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A3S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Mario Humberto Vega Ponciano
1512	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A1S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Miguel Estuardo Romero Matias
1513	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A1S1M03	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Erick Cifuentes
1514	Suprema, S.A.	8	31	3104	U01	L00	P00	0202P1A1C01	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	COMERCIALIZADORA
1515	Suprema, S.A.	8	31	3104	U01	L00	P00	0202A5S1M99	Mercadeo	Ventas Mayoristas	Oficinas Centrales	No definido	No definido	Fabio Rodas Falla
1516	Suprema, S.A.	8	31	3106	U01	L01	P02	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Grasas y Aceites	Aceites Empacados	Maurel Perez
1517	Suprema, S.A.	8	31	3106	U01	L02	P11	0202A1S2S01	Mercadeo	Ventas Supermercados	Oficinas Centrales	Jabones y Detergentes	Jabones de Lavandería	Maurel Perez
1518	Suprema, S.A.	7	32	3201	U01	L00	P00	0201P1S1M01	IDI	Jefatura IDI	Oficinas Centrales	No definido	No definido	Gerencia General
1519	Suprema, S.A.	6	90	9001	U90	L90	P90	0201P1S1M01	Reguladora	Reguladora	Reguladora	Reguladora	Reguladora A	Gerencia General
1520	Las Palmas, S.A.	7	00	0001	U01	L00	P00	0201P1S1M01	Administración	Directorio	Oficinas centrales	No definido	No definido	Gerencia General
1521	Las Palmas, S.A.	7	00	0002	U01	L00	P00	0201P1S1M01	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Gerencia General
1522	Las Palmas, S.A.	7	00	0002	U01	L00	P00	0201P1S1M03	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Servicios
1523	Las Palmas, S.A.	7	00	0002	U02	L00	P00	0201P1S1M01	Administración	Gerencia General	Planta	No definido	No definido	Gerencia General
1524	Las Palmas, S.A.	7	00	0002	U02	L00	P00	0201P1S1M03	Administración	Gerencia General	Planta	No definido	No definido	Servicios
1525	Las Palmas, S.A.	7	00	0002	U01	L00	P00	0201P1S1M02	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Otros SV
1526	Las Palmas, S.A.	7	00	0003	U01	L00	P00	0201P1S1M01	Administración	Dirección de operaciones	Oficinas centrales	No definido	No definido	Gerencia General
1527	Las Palmas, S.A.	7	00	0004	U01	L00	P00	0201P1S1M01	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Gerencia General
1528	Las Palmas, S.A.	7	00	0009	U01	L00	P00	0201P1S1M01	Administración	Administración Oficinas Centra	Oficinas centrales	No definido	No definido	Gerencia General
1529	Las Palmas, S.A.	7	00	0009	U01	L00	P00	0201P1S1M03	Administración	Administración Oficinas Centra	Oficinas centrales	No definido	No definido	Servicios
1530	Las Palmas, S.A.	7	00	0009	U01	L00	P00	0201P1S1M02	Administración	Administración Oficinas Centra	Oficinas centrales	No definido	No definido	Otros SV
1531	Las Palmas, S.A.	7	00	0009	U01	L01	P01	0204A1P1P01	Administración	Administración Oficinas Centra	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1532	Las Palmas, S.A.	7	00	0009	U01	L02	P11	0203J1P1P01	Administración	Administración Oficinas Centra	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1533	Las Palmas, S.A.	7	00	0009	U01	L01	P01	0201P1S1M04	Administración	Administración Oficinas Centra	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Exportacion
1534	Las Palmas, S.A.	7	01	0101	U01	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Gerencia General
1535	Las Palmas, S.A.	7	01	0101	01-AUD03	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoría	OASIS OFICINA AUDITORES	No definido	No definido	Gerencia General
1536	Las Palmas, S.A.	7	01	0101	01-AUD04	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoría	A/C OFICINA AUDITORES	No definido	No definido	Gerencia General
1537	Las Palmas, S.A.	7	01	0101	U02	L00	P00	0201P1S1M01	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Gerencia General
1538	Las Palmas, S.A.	7	02	0201	U01	L00	P00	0201P1S1M01	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Gerencia General
1539	Las Palmas, S.A.	7	02	0201	U02	L00	P00	0201P1S1M01	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Gerencia General
1540	Las Palmas, S.A.	7	03	0301	U02	L00	P00	0201P1S1M03	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Servicios
1541	Las Palmas, S.A.	7	03	0301	03-ADM02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	CAMIONC-884BMX	No definido	No definido	Gerencia General
1542	Las Palmas, S.A.	7	12	1203	03-ADM03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	CABEZALC-473BLM	No definido	No definido	Gerencia General
1543	Las Palmas, S.A.	7	03	0301	03-ADM04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	CAMION CISTERNA C-996BKD	No definido	No definido	Gerencia General
1544	Las Palmas, S.A.	7	03	0301	03-ADM05	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	TABLERO CIRCUITOS 120/240V OF	No definido	No definido	Gerencia General
1545	Las Palmas, S.A.	7	03	0301	03-ADM06	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS TRABAJOS VARIOS	No definido	No definido	Gerencia General
1546	Las Palmas, S.A.	7	03	0301	03-ADM07	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS OFICINAS ADMIN	No definido	No definido	Gerencia General
1547	Las Palmas, S.A.	7	03	0301	03-ADM08	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	TRANSF 480/240V CASA PAT AD BO	No definido	No definido	Gerencia General
1548	Las Palmas, S.A.	7	03	0301	03-ADM09	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	TANQUE ELEVADO AGUA	No definido	No definido	Gerencia General
1549	Las Palmas, S.A.	7	03	0301	03-ADM10	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	POZO DE AGUA	No definido	No definido	Gerencia General
1550	Las Palmas, S.A.	7	03	0301	03-CLI02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C CLINICA MEDICA	No definido	No definido	Gerencia General
1551	Las Palmas, S.A.	7	03	0301	03-CLI03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS CLINICA MEDICA	No definido	No definido	Gerencia General
1552	Las Palmas, S.A.	7	03	0301	03-CLI04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C SALA CLINICA MEDICA	No definido	No definido	Gerencia General
1553	Las Palmas, S.A.	7	03	0301	03-SL102	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C SALA REUNIONES PALMAS ADMI	No definido	No definido	Gerencia General
1554	Las Palmas, S.A.	7	03	0301	03-SL202	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS SALA REUNIO AREA AGRICOL	No definido	No definido	Gerencia General
1555	Las Palmas, S.A.	7	03	0301	03-BAS02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	ILUMINACION BASCULA	No definido	No definido	Gerencia General
1556	Las Palmas, S.A.	7	03	0301	03-BAS03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	TRANSF 480/240 V. BOD CEN, BAS	No definido	No definido	Gerencia General
1557	Las Palmas, S.A.	7	03	0301	03-BAS04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS OFICINA BASCULA	No definido	No definido	Gerencia General
1558	Las Palmas, S.A.	7	03	0301	03-BAS05	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C OFICINA BASCULA	No definido	No definido	Gerencia General
1559	Las Palmas, S.A.	7	03	0301	03-CM102	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C COMEDOR JEFATURAS	No definido	No definido	Gerencia General
1560	Las Palmas, S.A.	7	03	0301	03-CM103	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS COMEDOR JEFATURAS	No definido	No definido	Gerencia General
1561	Las Palmas, S.A.	7	03	0301	03-CM202	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C COMEDOR GENERAL ASOPALMAS	No definido	No definido	Gerencia General
1562	Las Palmas, S.A.	7	03	0301	03-CM203	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C COCINA GENERAL ASOPALMAS	No definido	No definido	Gerencia General
1563	Las Palmas, S.A.	7	03	0301	03-PPA02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C PLANTA PURIFICADORA	No definido	No definido	Gerencia General
1564	Las Palmas, S.A.	7	03	0301	03-PPA03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	PLANTA PURIFICADORA DE AGUA	No definido	No definido	Gerencia General
1565	Las Palmas, S.A.	7	03	0301	03-PPA04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	MOTOBOMBA DE GASOLINA HONDA	No definido	No definido	Gerencia General
1566	Las Palmas, S.A.	7	03	0301	03-CJE02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS CASA PATRONAL	No definido	No definido	Gerencia General
1567	Las Palmas, S.A.	7	03	0301	03-CJE03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C CASA JEFATURA NO.2 (ADMON)	No definido	No definido	Gerencia General
1568	Las Palmas, S.A.	7	03	0301	03-CJE04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HABITACION JEFE DE PB	No definido	No definido	Gerencia General
1569	Las Palmas, S.A.	7	03	0301	03-CJE05	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HABITACION ANALISTA PROD	No definido	No definido	Gerencia General
1570	Las Palmas, S.A.	7	03	0301	03-CJE06	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	PANEL DISTR 120/240 CASA GEREN	No definido	No definido	Gerencia General
1571	Las Palmas, S.A.	7	03	0301	03-CJE07	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HAB NO.3 JEF NO.4 AGRICOLA	No definido	No definido	Gerencia General
1572	Las Palmas, S.A.	7	03	0301	03-CJE08	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HABITACION HUESPED NO.1	No definido	No definido	Gerencia General
1573	Las Palmas, S.A.	7	03	0301	03-CJE09	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HABITACION HUESPED NO.2	No definido	No definido	Gerencia General
1574	Las Palmas, S.A.	7	03	0301	03-CJE10	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C HABITACION DE HUESPED NO.3	No definido	No definido	Gerencia General
1575	Las Palmas, S.A.	7	03	0301	03-CJE11	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C CUARTO BRIGADA BOMBEROS	No definido	No definido	Gerencia General
1576	Las Palmas, S.A.	7	03	0301	03-CJE12	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C SALA CASA JEFATURA NO.2	No definido	No definido	Gerencia General
1577	Las Palmas, S.A.	7	03	0301	03-CJE13	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	BOMBA SUM TANQUE ELEV CASA GER	No definido	No definido	Gerencia General
1578	Las Palmas, S.A.	7	03	0301	03-CJE14	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C CASA JEFATURA NO.3	No definido	No definido	Gerencia General
1579	Las Palmas, S.A.	7	03	0301	03-CJE15	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS HABITACION JEFE DE MANTE	No definido	No definido	Gerencia General
1580	Las Palmas, S.A.	7	03	0301	03-OFI02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C OF COORDINADOR ADMIN PALMA	No definido	No definido	Gerencia General
1581	Las Palmas, S.A.	7	03	0301	03-OFI03	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	OASIS OFICINA SUPERVISION PB	No definido	No definido	Gerencia General
1582	Las Palmas, S.A.	7	03	0301	03-OFI04	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	A/C OF SUPERINTENDENTE PROCESO	No definido	No definido	Gerencia General
1583	Las Palmas, S.A.	7	03	0301	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Gerencia General
1584	Las Palmas, S.A.	7	03	0301	U01	L00	P00	0201P1S1M01	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Gerencia General
1585	Las Palmas, S.A.	6	03	0302	U02	L08	P20	0204A1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1586	Las Palmas, S.A.	6	03	0302	U02	L08	P30	0203J1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-costo-Palmisteria	Jabon
1587	Las Palmas, S.A.	6	03	0302	U02	L08	P40	0203J1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1588	Las Palmas, S.A.	6	03	0302	U02	L08	P50	0203J1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-costo-Virutas Vent	Jabon
1589	Las Palmas, S.A.	6	03	0302	U02	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1590	Las Palmas, S.A.	6	03	0302	U02	L08	P60	0203J1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Jabon
1591	Las Palmas, S.A.	6	03	0302	U02	L08	P60	0204A1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Aceite
1592	Las Palmas, S.A.	6	03	0302	U02	L02	P11	0203J1P1P01	Gerencia Administrativa	Bodega de MP e Insumos	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1593	Las Palmas, S.A.	6	03	0303	U02	L08	P20	0204A1P1P01	Gerencia Administrativa	Bodega de Aceites a Granel	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1594	Las Palmas, S.A.	6	03	0303	U02	L08	P30	0204A1P1P01	Gerencia Administrativa	Bodega de Aceites a Granel	Planta	Procesos Productivos	No definido-costo-Palmisteria	Aceite
1595	Las Palmas, S.A.	6	03	0303	U02	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega de Aceites a Granel	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1596	Las Palmas, S.A.	6	03	0304	U02	L08	P20	0204A1P1P01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1597	Las Palmas, S.A.	6	03	0304	U02	L08	P30	0204A1P1P01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-costo-Palmisteria	Aceite
1598	Las Palmas, S.A.	6	03	0304	U02	L08	P40	0203J1P1P01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1599	Las Palmas, S.A.	6	03	0304	U02	L08	P50	0203J1P1P01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-costo-Virutas Vent	Jabon
1600	Las Palmas, S.A.	6	03	0304	U02	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1689	Las Palmas, S.A.	7	13	1304	U02	L00	P00	0201P1S1M01	Seguridad	De Ruta	Planta	No definido	No definido	Gerencia General
1601	Las Palmas, S.A.	6	03	0304	03-BOC02	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	OASIS BODEGA CENTRAL	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1602	Las Palmas, S.A.	6	03	0304	03-BOC03	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	PANEL DE DIST 120/240V BOD CEN	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1603	Las Palmas, S.A.	6	03	0304	03-BOC04	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	A/C BODEGA CENTRAL	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1604	Las Palmas, S.A.	6	03	0304	03-BOC05	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	PANEL DE TRANSF 120/240V B CEN	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1605	Las Palmas, S.A.	6	03	0304	03-GAS2	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	BOMBA DE GASOLINA GASOLINERA	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1606	Las Palmas, S.A.	6	03	0304	03-GAS3	L08	P60	0201P1S1M01	Gerencia Administrativa	Bodega Materiales y Repuestos	BOMBA DIESEL GASOLINERA PALMAS	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1607	Las Palmas, S.A.	7	03	0305	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Gerencia General
1608	Las Palmas, S.A.	7	03	0305	U01	L00	P00	0201P1S1M01	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Gerencia General
1609	Las Palmas, S.A.	6	03	0306	U02	L08	P20	0204A1P1P01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1610	Las Palmas, S.A.	6	03	0306	U02	L08	P30	0204A1P1P01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-costo-Palmisteria	Aceite
1611	Las Palmas, S.A.	6	03	0306	U02	L08	P40	0203J1P1P01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1612	Las Palmas, S.A.	6	03	0306	U02	L08	P50	0203J1P1P01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-costo-Virutas Vent	Jabon
1613	Las Palmas, S.A.	6	03	0306	U02	L08	P60	0201P1S1M01	Gerencia Administrativa	Seguridad Industrial	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1614	Las Palmas, S.A.	7	03	0307	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Transporte de Personal	Planta	No definido	No definido	Gerencia General
1615	Las Palmas, S.A.	7	03	0308	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Silos	Planta	No definido	No definido	Gerencia General
1616	Las Palmas, S.A.	7	03	0309	U02	L00	P00	0201P1S1M01	Gerencia Administrativa	Administración Planta	Planta	No definido	No definido	Gerencia General
1617	Las Palmas, S.A.	7	03	0309	U02	L00	P00	0201P1S1M02	Gerencia Administrativa	Administración Planta	Planta	No definido	No definido	Otros SV
1618	Las Palmas, S.A.	7	03	0309	U02	L00	P00	0201P1S1M03	Gerencia Administrativa	Administración Planta	Planta	No definido	No definido	Servicios
1619	Las Palmas, S.A.	7	03	0309	U02	L01	P01	0204A1P1P01	Gerencia Administrativa	Administración Planta	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1620	Las Palmas, S.A.	7	03	0309	U02	L02	P11	0203J1P1P01	Gerencia Administrativa	Administración Planta	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1621	Las Palmas, S.A.	7	03	0309	U02	L02	P11	0201P1S1M02	Gerencia Administrativa	Administración Planta	Planta	Jabones y Detergentes	Jabones de Lavandería	Otros SV
1622	Las Palmas, S.A.	7	04	0401	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Gerencia General
1623	Las Palmas, S.A.	7	04	0402	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Gerencia General
1624	Las Palmas, S.A.	7	04	0402	U01	L01	P01	0201P1S1M04	Gerencia Financiera	Contabilidad	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Exportacion
1625	Las Palmas, S.A.	7	04	0403	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Gerencia General
1626	Las Palmas, S.A.	7	04	0404	U01	L00	P00	0201P1S1M01	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Gerencia General
1627	Las Palmas, S.A.	7	04	0404	U01	L00	P00	0201P1S1M02	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Otros SV
1628	Las Palmas, S.A.	7	05	0501	U01	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Gerencia General
1629	Las Palmas, S.A.	7	05	0501	U02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Gerencia General
1630	Las Palmas, S.A.	7	05	0501	05-GEH03	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Jefatura Gestión Humana	A/C OFICINA GESTION HUMANA	No definido	No definido	Gerencia General
1631	Las Palmas, S.A.	7	05	0502	U01	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Gerencia General
1632	Las Palmas, S.A.	7	05	0502	U02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Gerencia General
1633	Las Palmas, S.A.	7	05	0502	05-NOM02	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	A/C OFICINA NOMINA PALMAS	No definido	No definido	Gerencia General
1634	Las Palmas, S.A.	7	05	0502	05-NOM03	L00	P00	0201P1S1M01	Gerencia de Gestión Humana	Nóminas	OASIS OFICINA NOMINAS	No definido	No definido	Gerencia General
1635	Las Palmas, S.A.	7	06	0601	U02	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Gerencia General
1636	Las Palmas, S.A.	7	06	0601	U01	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Gerencia General
1637	Las Palmas, S.A.	7	06	0602	U02	L00	P00	0201P1S1M01	Gerencia Garantía de Calidad	Certificaciones, registros y l	Planta	No definido	No definido	Gerencia General
1638	Las Palmas, S.A.	7	06	0602	U02	L01	P01	0204A1P1P01	Gerencia Garantía de Calidad	Certificaciones, registros y l	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1639	Las Palmas, S.A.	7	06	0602	U02	L02	P11	0203J1P1P01	Gerencia Garantía de Calidad	Certificaciones, registros y l	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1640	Las Palmas, S.A.	7	06	0603	U02	L01	P01	0204A1P1P01	Gerencia Garantía de Calidad	Certificación RSPO	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1641	Las Palmas, S.A.	7	06	0603	U02	L02	P11	0203J1P1P01	Gerencia Garantía de Calidad	Certificación RSPO	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
2105	Ganaderia Rio Seco	6	20	2002	U10	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 2	SAL	SAL A GRANEL	SAL
1642	Las Palmas, S.A.	7	10	1001	U01	L00	P00	0201P1S1M01	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Gerencia General
1643	Las Palmas, S.A.	7	10	1001	U02	L00	P00	0201P1S1M01	Compras	Jefatura Compras	Planta	No definido	No definido	Gerencia General
1644	Las Palmas, S.A.	7	11	1101	U01	L00	P00	0201P1S1M01	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Gerencia General
1645	Las Palmas, S.A.	7	11	1101	U02	L00	P00	0201P1S1M01	IT	Jefatura IT	Planta	No definido	No definido	Gerencia General
1646	Las Palmas, S.A.	7	11	1101	11-SIS02	L00	P00	0201P1S1M01	IT	Jefatura IT	A/C OFICINA DE SISTEMAS	No definido	No definido	Gerencia General
1647	Las Palmas, S.A.	7	11	1101	11-SIS03	L00	P00	0201P1S1M01	IT	Jefatura IT	ANTENA TELECOM MONT FRUTA	No definido	No definido	Gerencia General
1648	Las Palmas, S.A.	7	11	1101	11-SIS04	L00	P00	0201P1S1M01	IT	Jefatura IT	PANEL DE TRANSF P/G OF SISTEMA	No definido	No definido	Gerencia General
1649	Las Palmas, S.A.	7	11	1101	11-SIS05	L00	P00	0201P1S1M01	IT	Jefatura IT	ANTENA TELECOM BOD FERT	No definido	No definido	Gerencia General
1650	Las Palmas, S.A.	7	11	1101	11-SIS06	L00	P00	0201P1S1M01	IT	Jefatura IT	TORRE TELECOMUNICACIONES	No definido	No definido	Gerencia General
1651	Las Palmas, S.A.	7	12	1201	U02	L00	P00	0201P1S1M01	Logística	Jefatura Lógistica	Planta	No definido	No definido	Gerencia General
1652	Las Palmas, S.A.	7	12	1201	U02	L01	P01	0204A1P1P01	Logística	Jefatura Lógistica	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1653	Las Palmas, S.A.	7	12	1201	U02	L02	P11	0203J1P1P01	Logística	Jefatura Lógistica	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1654	Las Palmas, S.A.	7	12	1202	U02	L00	P00	0201P1S1M01	Logística	Bodega PT	Planta	No definido	No definido	Gerencia General
1655	Las Palmas, S.A.	7	12	1202	U02	L01	P01	0204A1P1P01	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1656	Las Palmas, S.A.	7	12	1202	U02	L01	P01	0201P1S1M04	Logística	Bodega PT	Planta	Grasas y Aceites	Aceites a Granel	Exportacion
1657	Las Palmas, S.A.	7	12	1202	U02	L02	P11	0203J1P1P01	Logística	Bodega PT	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1658	Las Palmas, S.A.	7	12	1203	U02	L00	P00	0201P1S1M01	Logística	Transporte Industrial	Planta	No definido	No definido	Gerencia General
1659	Las Palmas, S.A.	7	12	1203	U02	L01	P01	0204A1P1P01	Logística	Transporte Industrial	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1660	Las Palmas, S.A.	7	12	1203	12-BIO01	L01	P01	0204A1P1P01	Logística	Transporte Industrial	CABEZAL C-831BLF	Grasas y Aceites	Aceites a Granel	Aceite
1661	Las Palmas, S.A.	7	12	1203	12-BIO02	L01	P01	0204A1P1P01	Logística	Transporte Industrial	FURGON TC-076BDJ	Grasas y Aceites	Aceites a Granel	Aceite
1662	Las Palmas, S.A.	7	12	1203	12-BIO03	L01	P01	0204A1P1P01	Logística	Transporte Industrial	FURGON TC-060BKM	Grasas y Aceites	Aceites a Granel	Aceite
1663	Las Palmas, S.A.	7	12	1203	U02	L02	P11	0203J1P1P01	Logística	Transporte Industrial	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1664	Las Palmas, S.A.	7	12	1204	12-ACE02	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CISTERNA TC-079BVQ	Grasas y Aceites	Aceites a Granel	Aceite
1665	Las Palmas, S.A.	7	12	1204	12-ACE03	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CISTERNA TC-079BVQ	Grasas y Aceites	Aceites a Granel	Aceite
1666	Las Palmas, S.A.	7	12	1204	12-ACE04	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CISTERNA TC018BZQ	Grasas y Aceites	Aceites a Granel	Aceite
1667	Las Palmas, S.A.	7	12	1204	12-ACE05	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CABEZAL C-563BZK	Grasas y Aceites	Aceites a Granel	Aceite
1668	Las Palmas, S.A.	7	12	1204	12-ACE06	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CISTERNA TC019BZQ	Grasas y Aceites	Aceites a Granel	Aceite
1669	Las Palmas, S.A.	7	12	1204	12-ACE07	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CABEZAL C-406BQN	Grasas y Aceites	Aceites a Granel	Aceite
1670	Las Palmas, S.A.	7	12	1204	12-ACE08	L01	P01	0204A1P1P01	Logística	Transporte a Granel	CISTERNA TC-07CGC	Grasas y Aceites	Aceites a Granel	Aceite
1671	Las Palmas, S.A.	7	12	1204	U02	L01	P01	0204A1P1P01	Logística	Transporte a Granel	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1672	Las Palmas, S.A.	7	12	1204	U02	L01	P01	0201P1S1M04	Logística	Transporte a Granel	Planta	Grasas y Aceites	Aceites a Granel	Exportacion
1673	Las Palmas, S.A.	7	13	1301	U01	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Gerencia General
1674	Las Palmas, S.A.	7	13	1301	U02	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Gerencia General
1675	Las Palmas, S.A.	7	13	1301	13-SEJ02	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	OASIS VIVIENDA DE SEGURIDAD	No definido	No definido	Gerencia General
1676	Las Palmas, S.A.	7	13	1301	13-SEJ03	L00	P00	0201P1S1M01	Seguridad	Jefatura Seguridad	A/C COMISARIATO PALMAS	No definido	No definido	Gerencia General
1677	Las Palmas, S.A.	7	13	1302	U01	L00	P00	0201P1S1M01	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Gerencia General
1678	Las Palmas, S.A.	7	13	1303	U01	L00	P00	0201P1S1M01	Seguridad	Perimetral	Oficinas centrales	No definido	No definido	Gerencia General
1679	Las Palmas, S.A.	7	13	1303	U02	L00	P00	0201P1S1M01	Seguridad	Perimetral	Planta	No definido	No definido	Gerencia General
1680	Las Palmas, S.A.	7	13	1303	13-SEP01	L00	P00	0201P1S1M01	Seguridad	Perimetral	SEGURIDAD PERIMETRAL	No definido	No definido	Gerencia General
1681	Las Palmas, S.A.	7	13	1303	13-SEP02	L00	P00	0201P1S1M01	Seguridad	Perimetral	OASIS GARITA SUR	No definido	No definido	Gerencia General
1682	Las Palmas, S.A.	7	13	1303	13-SEP03	L00	P00	0201P1S1M01	Seguridad	Perimetral	OASIS GARITA NORTE	No definido	No definido	Gerencia General
1683	Las Palmas, S.A.	7	13	1303	13-SEP04	L00	P00	0201P1S1M01	Seguridad	Perimetral	ILUMINACION GARITA ESTE	No definido	No definido	Gerencia General
1684	Las Palmas, S.A.	7	13	1303	13-SEP05	L00	P00	0201P1S1M01	Seguridad	Perimetral	OASIS GARITA ESTE	No definido	No definido	Gerencia General
1685	Las Palmas, S.A.	7	13	1303	13-SEP06	L00	P00	0201P1S1M01	Seguridad	Perimetral	ILUMINACION GARITA NORTE	No definido	No definido	Gerencia General
1686	Las Palmas, S.A.	7	13	1303	13-SEP07	L00	P00	0201P1S1M01	Seguridad	Perimetral	ILUMINACION GARITA SUR	No definido	No definido	Gerencia General
1687	Las Palmas, S.A.	7	13	1303	13-SEP08	L00	P00	0201P1S1M01	Seguridad	Perimetral	PANEL DE DIST 120/240V GAS GN	No definido	No definido	Gerencia General
1688	Las Palmas, S.A.	7	13	1303	13-SEP09	L00	P00	0201P1S1M01	Seguridad	Perimetral	A/C VIVIENDA SEG GARITA N RIMO	No definido	No definido	Gerencia General
1690	Las Palmas, S.A.	7	13	1304	U02	L01	P01	0204A1P1P01	Seguridad	De Ruta	Planta	Grasas y Aceites	Aceites a Granel	Aceite
1691	Las Palmas, S.A.	7	13	1304	U02	L02	P11	0203J1P1P01	Seguridad	De Ruta	Planta	Jabones y Detergentes	Jabones de Lavandería	Jabon
1692	Las Palmas, S.A.	7	13	1304	U02	L02	P11	0201P1S1M01	Seguridad	De Ruta	Planta	Jabones y Detergentes	Jabones de Lavandería	Gerencia General
1693	Las Palmas, S.A.	6	20	2000	U02	L08	P20	0204A1P1P01	Producción	Superintendencia de Procesos	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1694	Las Palmas, S.A.	7	20	2000	U02	L00	P00	0201P1S1M01	Producción	Superintendencia de Procesos	Planta	No definido	No definido	Gerencia General
1695	Las Palmas, S.A.	6	20	2001	U02	L08	P20	0204A1P1P01	Producción	Jefatura General Producción	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1696	Las Palmas, S.A.	6	20	2002	U02	L08	P20	0204A1P1P01	Producción	Jefatura Grasas y Aceites	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1697	Las Palmas, S.A.	6	20	2003	U02	L08	P40	0203J1P1P01	Producción	Jefatura Jabones	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1698	Las Palmas, S.A.	6	20	2011	U02	L08	P20	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1699	Las Palmas, S.A.	6	20	2011	U02	L08	P21	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Esterilización Fruta	Aceite
1700	Las Palmas, S.A.	6	20	2011	U02	L08	P22	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Desfrutación	Aceite
1701	Las Palmas, S.A.	6	20	2011	U02	L08	P23	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Extracción ACP	Aceite
1702	Las Palmas, S.A.	6	20	2011	U02	L08	P24	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Prensado de Raquis	Aceite
1703	Las Palmas, S.A.	6	20	2011	U02	L08	P25	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Clarificación	Aceite
1704	Las Palmas, S.A.	6	20	2011	U02	L08	P26	0204A1P1P01	Producción	Aceites ACP	Planta	Procesos Productivos	Lavado y secado Aceite	Aceite
1705	Las Palmas, S.A.	6	20	2012	U02	L08	P30	0204A1P1P01	Producción	Aceite Palmiste	Planta	Procesos Productivos	No definido-costo-Palmisteria	Aceite
1706	Las Palmas, S.A.	6	20	2012	U02	L08	P32	0204A1P1P01	Producción	Aceite Palmiste	Planta	Procesos Productivos	Extracción Aceite de Palmiste	Aceite
1707	Las Palmas, S.A.	6	20	2012	U02	L08	P33	0204A1P1P01	Producción	Aceite Palmiste	Planta	Procesos Productivos	Blanqueo de PKO	Aceite
1708	Las Palmas, S.A.	6	20	2012	U02	L08	P34	0204A1P1P01	Producción	Aceite Palmiste	Planta	Procesos Productivos	Molido/Envasar Harina Palmiste	Aceite
1709	Las Palmas, S.A.	6	20	2013	U02	L08	P40	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1710	Las Palmas, S.A.	6	20	2013	U02	L08	P41	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Empastados Jabón Lavandería	Jabon
1711	Las Palmas, S.A.	6	20	2013	U02	L08	P42	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Secado Color y perfume J. Lav.	Jabon
1712	Las Palmas, S.A.	6	20	2013	U02	L08	P43	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Extruido y corte J. Lav.	Jabon
1713	Las Palmas, S.A.	6	20	2013	U02	L08	P44	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Troquelado Jabón Lavandería	Jabon
1714	Las Palmas, S.A.	6	20	2013	U02	L08	P45	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Empacado Jabón Lavandería	Jabon
1715	Las Palmas, S.A.	6	20	2013	U02	L08	P46	0203J1P1P01	Producción	Jabón Lavandería	Planta	Procesos Productivos	Pailas	Jabon
1716	Las Palmas, S.A.	6	20	2014	U02	L08	P50	0203J1P1P01	Producción	Viruta	Planta	Procesos Productivos	No definido-costo-Virutas Vent	Jabon
1717	Las Palmas, S.A.	6	20	2014	U02	L08	P51	0203J1P1P01	Producción	Viruta	Planta	Procesos Productivos	Empastado Viruta	Jabon
1718	Las Palmas, S.A.	6	20	2014	U02	L08	P52	0203J1P1P01	Producción	Viruta	Planta	Procesos Productivos	Secado Viruta	Jabon
1719	Las Palmas, S.A.	6	20	2014	U02	L08	P53	0203J1P1P01	Producción	Viruta	Planta	Procesos Productivos	Mezcla, color extruido Viruta	Jabon
1720	Las Palmas, S.A.	6	20	2014	U02	L08	P54	0203J1P1P01	Producción	Viruta	Planta	Procesos Productivos	Pesaje y Entarimado Viruta	Jabon
1721	Las Palmas, S.A.	6	20	2021	U02	L08	P60	0201P1S1M01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1722	Las Palmas, S.A.	6	20	2021	U02	L08	P20	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	No definido-costo-Beneficio	Aceite
1723	Las Palmas, S.A.	6	20	2021	U02	L08	P21	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Esterilización Fruta	Aceite
1724	Las Palmas, S.A.	6	20	2021	U02	L08	P22	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Desfrutación	Aceite
1725	Las Palmas, S.A.	6	20	2021	U02	L08	P23	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Extracción ACP	Aceite
1726	Las Palmas, S.A.	6	20	2021	U02	L08	P24	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Prensado de Raquis	Aceite
1727	Las Palmas, S.A.	6	20	2021	U02	L08	P25	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Clarificación	Aceite
1728	Las Palmas, S.A.	6	20	2021	U02	L08	P26	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Lavado y secado Aceite	Aceite
1729	Las Palmas, S.A.	6	20	2021	U02	L08	P30	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	No definido-costo-Palmisteria	Aceite
1730	Las Palmas, S.A.	6	20	2021	U02	L08	P32	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Extracción Aceite de Palmiste	Aceite
1731	Las Palmas, S.A.	6	20	2021	U02	L08	P33	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Blanqueo de PKO	Aceite
1732	Las Palmas, S.A.	6	20	2021	U02	L08	P34	0204A1P1P01	Producción	Mantenimiento Beneficio	Planta	Procesos Productivos	Molido/Envasar Harina Palmiste	Aceite
1733	Las Palmas, S.A.	6	20	2022	U02	L08	P60	0201P1S1M01	Producción	Biomasa	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1734	Las Palmas, S.A.	6	20	2023	U02	L08	P41	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Empastados Jabón Lavandería	Jabon
1735	Las Palmas, S.A.	6	20	2023	U02	L08	P42	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Secado Color y perfume J. Lav.	Jabon
1736	Las Palmas, S.A.	6	20	2023	U02	L08	P43	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Extruido y corte J. Lav.	Jabon
1737	Las Palmas, S.A.	6	20	2023	U02	L08	P44	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Troquelado Jabón Lavandería	Jabon
1738	Las Palmas, S.A.	6	20	2023	U02	L08	P45	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Empacado Jabón Lavandería	Jabon
1739	Las Palmas, S.A.	6	20	2023	U02	L08	P46	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Pailas	Jabon
1740	Las Palmas, S.A.	6	20	2023	U02	L08	P50	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	No definido-costo-Virutas Vent	Jabon
1741	Las Palmas, S.A.	6	20	2023	U02	L08	P51	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Empastado Viruta	Jabon
1742	Las Palmas, S.A.	6	20	2023	U02	L08	P52	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Secado Viruta	Jabon
1743	Las Palmas, S.A.	6	20	2023	U02	L08	P53	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Mezcla, color extruido Viruta	Jabon
1744	Las Palmas, S.A.	6	20	2023	U02	L08	P54	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	Pesaje y Entarimado Viruta	Jabon
1745	Las Palmas, S.A.	6	20	2023	U02	L08	P40	0203J1P1P01	Producción	Mantenimiento Jabones	Planta	Procesos Productivos	No definido-costo-Jabon lavan	Jabon
1746	Las Palmas, S.A.	6	20	2024	U02	L08	P60	0201P1S1M01	Producción	Sistema de Enfriamiento	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1747	Las Palmas, S.A.	6	20	2025	U02	L08	P60	0201P1S1M01	Producción	Calderas	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1748	Las Palmas, S.A.	6	20	2026	U02	L10	P71	0204A1P1P01	Producción	Transporte Agricola	Planta	Fruta	Servicios de Transporte	Aceite
1749	Las Palmas, S.A.	6	20	2026	20-CAB01	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-194 BMD	Fruta	Servicios de Transporte	Aceite
1750	Las Palmas, S.A.	6	20	2026	20-CAB02	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-720 BYL	Fruta	Servicios de Transporte	Aceite
1751	Las Palmas, S.A.	6	20	2026	20-CAB03	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-890 BMY	Fruta	Servicios de Transporte	Aceite
1752	Las Palmas, S.A.	6	20	2026	20-CAB04	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-942 BLS	Fruta	Servicios de Transporte	Aceite
1753	Las Palmas, S.A.	6	20	2026	20-CAB05	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-998 BXZ	Fruta	Servicios de Transporte	Aceite
1754	Las Palmas, S.A.	6	20	2026	20-CAB06	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZALC-071 BRP	Fruta	Servicios de Transporte	Aceite
1755	Las Palmas, S.A.	6	20	2026	20-CAB07	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CABEZAL C-153 CBJ	Fruta	Servicios de Transporte	Aceite
1756	Las Palmas, S.A.	6	20	2026	20-CAM01	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-105 BZD	Fruta	Servicios de Transporte	Aceite
1757	Las Palmas, S.A.	6	20	2026	20-CAM02	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-186 BVJ	Fruta	Servicios de Transporte	Aceite
1758	Las Palmas, S.A.	6	20	2026	20-CAM03	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-205 BZC	Fruta	Servicios de Transporte	Aceite
1759	Las Palmas, S.A.	6	20	2026	20-CAM04	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-259 BXW	Fruta	Servicios de Transporte	Aceite
1760	Las Palmas, S.A.	6	20	2026	20-CAM05	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-425 BVW	Fruta	Servicios de Transporte	Aceite
1761	Las Palmas, S.A.	6	20	2026	20-CAM06	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-483 BNN	Fruta	Servicios de Transporte	Aceite
1762	Las Palmas, S.A.	6	20	2026	20-CAM07	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-491 BVB	Fruta	Servicios de Transporte	Aceite
1763	Las Palmas, S.A.	6	20	2026	20-CAM08	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-492 BVB	Fruta	Servicios de Transporte	Aceite
1764	Las Palmas, S.A.	6	20	2026	20-CAM09	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-793 BPH	Fruta	Servicios de Transporte	Aceite
1765	Las Palmas, S.A.	6	20	2026	20-CAM10	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-880 BVZ	Fruta	Servicios de Transporte	Aceite
1766	Las Palmas, S.A.	6	20	2026	20-CAM11	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-962 BRB	Fruta	Servicios de Transporte	Aceite
1767	Las Palmas, S.A.	6	20	2026	20-CAM12	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CAMION C-836 CBN	Fruta	Servicios de Transporte	Aceite
1768	Las Palmas, S.A.	6	20	2026	20-TOR01	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 1	Fruta	Servicios de Transporte	Aceite
1769	Las Palmas, S.A.	6	20	2026	20-TOR10	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 10	Fruta	Servicios de Transporte	Aceite
1770	Las Palmas, S.A.	6	20	2026	20-TOR11	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 11	Fruta	Servicios de Transporte	Aceite
1771	Las Palmas, S.A.	6	20	2026	20-TOR12	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 12	Fruta	Servicios de Transporte	Aceite
1772	Las Palmas, S.A.	6	20	2026	20-TOR13	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 13	Fruta	Servicios de Transporte	Aceite
1773	Las Palmas, S.A.	6	20	2026	20-TOR14	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 14	Fruta	Servicios de Transporte	Aceite
1774	Las Palmas, S.A.	6	20	2026	20-TOR15	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 15	Fruta	Servicios de Transporte	Aceite
1775	Las Palmas, S.A.	6	20	2026	20-TOR16	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 16	Fruta	Servicios de Transporte	Aceite
1776	Las Palmas, S.A.	6	20	2026	20-TOR02	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 2	Fruta	Servicios de Transporte	Aceite
1777	Las Palmas, S.A.	6	20	2026	20-TOR03	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 3	Fruta	Servicios de Transporte	Aceite
1778	Las Palmas, S.A.	6	20	2026	20-TOR04	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 4	Fruta	Servicios de Transporte	Aceite
1779	Las Palmas, S.A.	6	20	2026	20-TOR05	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 5	Fruta	Servicios de Transporte	Aceite
1780	Las Palmas, S.A.	6	20	2026	20-TOR06	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 6	Fruta	Servicios de Transporte	Aceite
1781	Las Palmas, S.A.	6	20	2026	20-TOR07	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 7	Fruta	Servicios de Transporte	Aceite
1782	Las Palmas, S.A.	6	20	2026	20-TOR08	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 8	Fruta	Servicios de Transporte	Aceite
1783	Las Palmas, S.A.	6	20	2026	20-TOR09	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 9	Fruta	Servicios de Transporte	Aceite
1784	Las Palmas, S.A.	6	20	2026	20-TOR18	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 18	Fruta	Servicios de Transporte	Aceite
1785	Las Palmas, S.A.	6	20	2026	20-TOR19	L10	P71	0204A1P1P01	Producción	Transporte Agricola	CARRETON TORNAMESA # 19	Fruta	Servicios de Transporte	Aceite
1786	Las Palmas, S.A.	6	20	2026	20-DOL01	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 1	Fruta	Servicios de Transporte	Aceite
1787	Las Palmas, S.A.	6	20	2026	20-DOL10	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 10	Fruta	Servicios de Transporte	Aceite
1788	Las Palmas, S.A.	6	20	2026	20-DOL11	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 11	Fruta	Servicios de Transporte	Aceite
1789	Las Palmas, S.A.	6	20	2026	20-DOL02	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 2	Fruta	Servicios de Transporte	Aceite
1790	Las Palmas, S.A.	6	20	2026	20-DOL03	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 3	Fruta	Servicios de Transporte	Aceite
1791	Las Palmas, S.A.	6	20	2026	20-DOL04	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 4	Fruta	Servicios de Transporte	Aceite
1792	Las Palmas, S.A.	6	20	2026	20-DOL05	L10	P71	0204A1P1P01	Producción	Transporte Agricola	DOLLY # 5	Fruta	Servicios de Transporte	Aceite
1793	Las Palmas, S.A.	7	20	2027	U02	L10	P72	0201P1S1M03	Producción	Equipo de Riego	Planta	Fruta	Servicios Equipo de Riego	Servicios
1794	Las Palmas, S.A.	7	20	2027	20-RMB05	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOBOMBA DE RIEGO #5 ERMB05	Fruta	Servicios Equipo de Riego	Servicios
1795	Las Palmas, S.A.	7	20	2027	20-RMB08	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOBOMBA DE RIEGO #8 ERMB08	Fruta	Servicios Equipo de Riego	Servicios
1796	Las Palmas, S.A.	7	20	2027	20-RMT01	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #1 ERMT01	Fruta	Servicios Equipo de Riego	Servicios
1797	Las Palmas, S.A.	7	20	2027	20-RMT10	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #10 ERMT10	Fruta	Servicios Equipo de Riego	Servicios
1798	Las Palmas, S.A.	7	20	2027	20-RMT11	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #11 ERMT11	Fruta	Servicios Equipo de Riego	Servicios
1799	Las Palmas, S.A.	7	20	2027	20-RMT12	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #12 ERMT12	Fruta	Servicios Equipo de Riego	Servicios
1800	Las Palmas, S.A.	7	20	2027	20-RMT13	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #13 ERMT13	Fruta	Servicios Equipo de Riego	Servicios
1801	Las Palmas, S.A.	7	20	2027	20-RMT14	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #14 ERMT14	Fruta	Servicios Equipo de Riego	Servicios
1802	Las Palmas, S.A.	7	20	2027	20-RMT15	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #15 ERMT15	Fruta	Servicios Equipo de Riego	Servicios
1803	Las Palmas, S.A.	7	20	2027	20-RMT16	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #16 ERMT16	Fruta	Servicios Equipo de Riego	Servicios
1804	Las Palmas, S.A.	7	20	2027	20-RMT17	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #17 ERMT17	Fruta	Servicios Equipo de Riego	Servicios
1805	Las Palmas, S.A.	7	20	2027	20-RMT18	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #18 ERMT18	Fruta	Servicios Equipo de Riego	Servicios
1806	Las Palmas, S.A.	7	20	2027	20-RMT19	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #19 ERMT19	Fruta	Servicios Equipo de Riego	Servicios
1807	Las Palmas, S.A.	7	20	2027	20-RMT02	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #2 ERMT02	Fruta	Servicios Equipo de Riego	Servicios
1808	Las Palmas, S.A.	7	20	2027	20-RMT03	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #3 ERMT03	Fruta	Servicios Equipo de Riego	Servicios
1809	Las Palmas, S.A.	7	20	2027	20-RMT05	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #5 ERMT05	Fruta	Servicios Equipo de Riego	Servicios
1810	Las Palmas, S.A.	7	20	2027	20-RMT06	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #6 ERMT06	Fruta	Servicios Equipo de Riego	Servicios
1811	Las Palmas, S.A.	7	20	2027	20-RMT07	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #7 ERMT07	Fruta	Servicios Equipo de Riego	Servicios
1812	Las Palmas, S.A.	7	20	2027	20-RMT08	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #8 ERMT08	Fruta	Servicios Equipo de Riego	Servicios
1813	Las Palmas, S.A.	7	20	2027	20-RMT09	L10	P72	0201P1S1M03	Producción	Equipo de Riego	MOTOR DE RIEGO #9 ERMT09	Fruta	Servicios Equipo de Riego	Servicios
1814	Las Palmas, S.A.	7	20	2028	U02	L10	P73	0201P1S1M03	Producción	Maquinaria	Planta	Fruta	Servicios de Tractores	Servicios
1815	Las Palmas, S.A.	6	20	2099	U02	L08	P60	0201P1S1M01	Producción	Procesos Productivos	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1816	Las Palmas, S.A.	6	21	2101	U02	L08	P60	0201P1S1M01	Control de Calidad	Jefatura Control de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1817	Las Palmas, S.A.	6	21	2101	U02	L08	P60	0204A1P1P01	Control de Calidad	Jefatura Control de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Aceite
1818	Las Palmas, S.A.	6	21	2101	U02	L08	P60	0203J1P1P01	Control de Calidad	Jefatura Control de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Jabon
1819	Las Palmas, S.A.	6	21	2102	U02	L08	P60	0201P1S1M01	Control de Calidad	Laboratorio	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1820	Las Palmas, S.A.	6	21	2102	U02	L08	P60	0204A1P1P01	Control de Calidad	Laboratorio	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Aceite
1821	Las Palmas, S.A.	6	21	2102	U02	L08	P60	0203J1P1P01	Control de Calidad	Laboratorio	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Jabon
1822	Las Palmas, S.A.	6	21	2103	U02	L08	P60	0203J1P1P01	Control de Calidad	Inspección de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Jabon
1823	Las Palmas, S.A.	6	21	2103	U02	L08	P60	0204A1P1P01	Control de Calidad	Inspección de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Aceite
1824	Las Palmas, S.A.	6	21	2103	U02	L08	P60	0201P1S1M01	Control de Calidad	Inspección de Calidad	Planta	Procesos Productivos	No definido-Costo-Centros Serv	Gerencia General
1825	Las Palmas, S.A.	7	30	3001	U01	L00	P00	0201P1S1M01	Dirección Comercial	Jefatura Dirección Comercial	Oficinas centrales	No definido	No definido	Gerencia General
1826	Las Palmas, S.A.	7	30	3001	U01	L01	P01	0204A1P1P01	Dirección Comercial	Jefatura Dirección Comercial	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1827	Las Palmas, S.A.	7	30	3001	U01	L02	P11	0203J1P1P01	Dirección Comercial	Jefatura Dirección Comercial	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1828	Las Palmas, S.A.	7	30	3002	U01	L00	P00	0201P1S1M01	Dirección Comercial	Ventas Gerencia	Oficinas centrales	No definido	No definido	Gerencia General
1829	Las Palmas, S.A.	7	30	3002	U01	L01	P01	0204A1P1P01	Dirección Comercial	Ventas Gerencia	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1830	Las Palmas, S.A.	7	30	3002	U01	L02	P11	0203J1P1P01	Dirección Comercial	Ventas Gerencia	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1831	Las Palmas, S.A.	7	30	3003	U01	L00	P00	0201P1S1M01	Dirección Comercial	Ventas Institucional-Industria	Oficinas centrales	No definido	No definido	Gerencia General
1832	Las Palmas, S.A.	7	30	3003	U01	L01	P01	0204A1P1P01	Dirección Comercial	Ventas Institucional-Industria	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1833	Las Palmas, S.A.	7	30	3003	U01	L02	P11	0203J1P1P01	Dirección Comercial	Ventas Institucional-Industria	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1834	Las Palmas, S.A.	7	30	3003	U01	L01	P01	0202A1S2S02	Dirección Comercial	Ventas Institucional-Industria	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Eduardo De Leon
1835	Las Palmas, S.A.	7	30	3003	U01	L02	P11	0202A1S2S02	Dirección Comercial	Ventas Institucional-Industria	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Eduardo De Leon
1836	Las Palmas, S.A.	7	30	3004	U01	L00	P00	0201P1S1M01	Dirección Comercial	Ventas Mayoristas	Oficinas centrales	No definido	No definido	Gerencia General
1837	Las Palmas, S.A.	7	30	3004	U01	L01	P01	0204A1P1P01	Dirección Comercial	Ventas Mayoristas	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1838	Las Palmas, S.A.	7	30	3004	U01	L02	P11	0203J1P1P01	Dirección Comercial	Ventas Mayoristas	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1839	Las Palmas, S.A.	7	30	3005	U01	L00	P00	0201P1S1M01	Dirección Comercial	Ventas al Detalle	Oficinas centrales	No definido	No definido	Gerencia General
1840	Las Palmas, S.A.	7	30	3005	U01	L01	P01	0204A1P1P01	Dirección Comercial	Ventas al Detalle	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1841	Las Palmas, S.A.	7	30	3005	U01	L02	P11	0203J1P1P01	Dirección Comercial	Ventas al Detalle	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1842	Las Palmas, S.A.	7	30	3006	U01	L00	P00	0201P1S1M01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	No definido	No definido	Gerencia General
1843	Las Palmas, S.A.	7	30	3006	U01	L01	P01	0204A1P1P01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1844	Las Palmas, S.A.	7	30	3006	U01	L02	P11	0203J1P1P01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1845	Las Palmas, S.A.	7	30	3006	U01	L00	P00	0202A1S2S01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	No definido	No definido	Mario Martinez
1846	Las Palmas, S.A.	7	30	3006	U01	L01	P01	0202A1S2S01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Mario Martinez
1847	Las Palmas, S.A.	7	30	3006	U01	L02	P11	0202A1S2S01	Dirección Comercial	Ventas Supermercados	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Mario Martinez
1848	Las Palmas, S.A.	7	30	3007	U01	L01	P01	0201P1S1M04	Dirección Comercial	Ventas Canal Exportación	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Exportacion
1849	Las Palmas, S.A.	7	31	3101	U01	L00	P00	0201P1S1M01	Mercadeo	Jefatura Mercadeo	Oficinas centrales	No definido	No definido	Gerencia General
1850	Las Palmas, S.A.	7	31	3101	U01	L01	P01	0204A1P1P01	Mercadeo	Jefatura Mercadeo	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1851	Las Palmas, S.A.	7	31	3101	U01	L02	P11	0203J1P1P01	Mercadeo	Jefatura Mercadeo	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1852	Las Palmas, S.A.	7	31	3102	U01	L00	P00	0201P1S1M01	Mercadeo	Ventas Gerencia	Oficinas centrales	No definido	No definido	Gerencia General
1853	Las Palmas, S.A.	7	31	3102	U01	L01	P01	0204A1P1P01	Mercadeo	Ventas Gerencia	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1854	Las Palmas, S.A.	7	31	3102	U01	L02	P11	0203J1P1P01	Mercadeo	Ventas Gerencia	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1855	Las Palmas, S.A.	7	31	3103	U01	L00	P00	0201P1S1M01	Mercadeo	Ventas Institucional-Industria	Oficinas centrales	No definido	No definido	Gerencia General
1856	Las Palmas, S.A.	7	31	3103	U01	L01	P01	0204A1P1P01	Mercadeo	Ventas Institucional-Industria	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1857	Las Palmas, S.A.	7	31	3103	U01	L02	P11	0203J1P1P01	Mercadeo	Ventas Institucional-Industria	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1858	Las Palmas, S.A.	7	31	3104	U01	L00	P00	0201P1S1M01	Mercadeo	Ventas Mayoristas	Oficinas centrales	No definido	No definido	Gerencia General
1859	Las Palmas, S.A.	7	31	3104	U01	L01	P01	0204A1P1P01	Mercadeo	Ventas Mayoristas	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1860	Las Palmas, S.A.	7	31	3104	U01	L02	P11	0203J1P1P01	Mercadeo	Ventas Mayoristas	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1861	Las Palmas, S.A.	7	31	3105	U01	L00	P00	0201P1S1M01	Mercadeo	Ventas al Detalle	Oficinas centrales	No definido	No definido	Gerencia General
1862	Las Palmas, S.A.	7	31	3105	U01	L01	P01	0204A1P1P01	Mercadeo	Ventas al Detalle	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1863	Las Palmas, S.A.	7	31	3105	U01	L02	P11	0203J1P1P01	Mercadeo	Ventas al Detalle	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1864	Las Palmas, S.A.	7	31	3106	U01	L00	P00	0201P1S1M01	Mercadeo	Ventas Supermercados	Oficinas centrales	No definido	No definido	Gerencia General
1865	Las Palmas, S.A.	7	31	3106	U01	L01	P01	0204A1P1P01	Mercadeo	Ventas Supermercados	Oficinas centrales	Grasas y Aceites	Aceites a Granel	Aceite
1866	Las Palmas, S.A.	7	31	3106	U01	L02	P11	0203J1P1P01	Mercadeo	Ventas Supermercados	Oficinas centrales	Jabones y Detergentes	Jabones de Lavandería	Jabon
1867	Las Palmas, S.A.	7	32	3201	U01	L00	P00	0201P1S1M01	IDI	Jefatura IDI	Oficinas centrales	No definido	No definido	Gerencia General
1868	Las Palmas, S.A.	6	90	9001	U90	L90	P90	0204A1P1P01	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Aceite
1869	Las Palmas, S.A.	6	90	9001	U90	L90	P90	0201P1S1M01	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Aceite crudo de palma	Gerencia General
1870	Las Palmas, S.A.	6	91	9101	U91	L91	P91	0204A1P1P01	Aceite de palmiste	Aceite de palmiste	Aceite de palmiste	Aceite de palmiste	Aceite de Palmiste	Aceite
1871	Las Palmas, S.A.	6	92	9201	U92	L92	P92	0203J1P1P01	Jabón	Jabón	Jabón	Jabón	Jabón	Jabon
1872	Acacias, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
1873	Acacias, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
1874	Acacias, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
1875	Acacias, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
1876	Acacias, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
1877	Acacias, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
1878	Acacias, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
1879	Acacias, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
1880	Acacias, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1881	Acacias, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
1882	Acacias, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
1883	Acacias, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
1884	Acacias, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
1885	Acacias, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1886	Acacias, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
1887	Acacias, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
1888	Acacias, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
1889	Acacias, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
1890	Acacias, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
1891	Acacias, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
1892	Acacias, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
1893	Acacias, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
1894	Acacias, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
1895	Acacias, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
1896	Acacias, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
1897	Acacias, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
1898	Acacias, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
1899	Acacias, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
1900	Acacias, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
1901	Acacias, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
1902	Acacias, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
1903	Acacias, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
1904	Acacias, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
1905	Acacias, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
1906	Acacias, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
1907	Acacias, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
1908	Alfa, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
1909	Alfa, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
1910	Alfa, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
1911	Alfa, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
1912	Alfa, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
1913	Alfa, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
1914	Alfa, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
1915	Alfa, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
1916	Alfa, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1917	Alfa, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
1918	Alfa, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
1919	Alfa, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
1920	Alfa, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
1921	Alfa, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1922	Alfa, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
1923	Alfa, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
1924	Alfa, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
1925	Alfa, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
1926	Alfa, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
1927	Alfa, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
1928	Alfa, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
1929	Alfa, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
1930	Alfa, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
1931	Alfa, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
1932	Alfa, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
1933	Alfa, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
1934	Alfa, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
1935	Alfa, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
1936	Alfa, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
1937	Alfa, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
1938	Alfa, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
1939	Alfa, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
1940	Alfa, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
1941	Alfa, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
1942	Alfa, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
1943	Alfa, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
1944	Quirica, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
1945	Quirica, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
1946	Quirica, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
1947	Quirica, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
1948	Quirica, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
1949	Quirica, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
1950	Quirica, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
1951	Quirica, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
1952	Quirica, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1953	Quirica, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
1954	Quirica, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
1955	Quirica, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
1956	Quirica, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
1957	Quirica, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1958	Quirica, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
1959	Quirica, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
1960	Quirica, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
1961	Quirica, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
1962	Quirica, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
1963	Quirica, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
1964	Quirica, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
1965	Quirica, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
1966	Quirica, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
1967	Quirica, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
1968	Quirica, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
1969	Quirica, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
1970	Quirica, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
1971	Quirica, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
1972	Quirica, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
1973	Quirica, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
1974	Quirica, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
1975	Quirica, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
1976	Quirica, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
1977	Quirica, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
1978	Quirica, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
1979	Quirica, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
1980	San Antonio, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
1981	San Antonio, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
1982	San Antonio, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
1983	San Antonio, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
1984	San Antonio, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
1985	San Antonio, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
1986	San Antonio, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
1987	San Antonio, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
1988	San Antonio, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1989	San Antonio, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
1990	San Antonio, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
1991	San Antonio, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
1992	San Antonio, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
1993	San Antonio, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
1994	San Antonio, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
1995	San Antonio, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
1996	San Antonio, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
1997	San Antonio, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
1998	San Antonio, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
1999	San Antonio, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
2000	San Antonio, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
2001	San Antonio, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
2002	San Antonio, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
2003	San Antonio, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
2004	San Antonio, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
2005	San Antonio, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
2006	San Antonio, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
2007	San Antonio, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
2008	San Antonio, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
2009	San Antonio, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
2010	San Antonio, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
2011	San Antonio, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
2012	San Antonio, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
2013	San Antonio, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
2014	San Antonio, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
2015	San Antonio, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
2016	San Francisco, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
2017	San Francisco, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
2018	San Francisco, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
2019	San Francisco, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
2020	San Francisco, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
2021	San Francisco, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
2022	San Francisco, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
2023	San Francisco, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
2024	San Francisco, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
2025	San Francisco, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
2026	San Francisco, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
2027	San Francisco, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
2028	San Francisco, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
2029	San Francisco, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
2030	San Francisco, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
2031	San Francisco, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
2032	San Francisco, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
2033	San Francisco, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
2034	San Francisco, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
2035	San Francisco, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
2036	San Francisco, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
2037	San Francisco, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
2038	San Francisco, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
2039	San Francisco, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
2040	San Francisco, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
2041	San Francisco, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
2042	San Francisco, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
2043	San Francisco, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
2044	San Francisco, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
2045	San Francisco, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
2046	San Francisco, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
2047	San Francisco, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
2048	San Francisco, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
2049	San Francisco, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
2050	San Francisco, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
2051	San Francisco, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
2052	San Jorge Los Magueyes, S.A.	7	00	0001	U01	L00	P00	PAL01001	Administración	Directorio	Oficinas centrales	No definido	No definido	Fruta de Palma
2053	San Jorge Los Magueyes, S.A.	7	00	0002	U01	L00	P00	PAL01001	Administración	Gerencia General	Oficinas centrales	No definido	No definido	Fruta de Palma
2054	San Jorge Los Magueyes, S.A.	7	00	0004	U01	L00	P00	PAL01001	Administración	Asesoría Legal	Oficinas centrales	No definido	No definido	Fruta de Palma
2055	San Jorge Los Magueyes, S.A.	7	01	0101	U01	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Oficinas centrales	No definido	No definido	Fruta de Palma
2056	San Jorge Los Magueyes, S.A.	7	02	0201	U01	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Oficinas centrales	No definido	No definido	Fruta de Palma
2057	San Jorge Los Magueyes, S.A.	7	03	0301	U01	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Oficinas centrales	No definido	No definido	Fruta de Palma
2058	San Jorge Los Magueyes, S.A.	7	03	0305	U01	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Oficinas centrales	No definido	No definido	Fruta de Palma
2106	Ganaderia Rio Seco	6	20	2002	U09	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 1	SAL	SAL A GRANEL	SAL
2059	San Jorge Los Magueyes, S.A.	7	04	0401	U01	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Oficinas centrales	No definido	No definido	Fruta de Palma
2060	San Jorge Los Magueyes, S.A.	7	04	0402	U01	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Oficinas centrales	No definido	No definido	Fruta de Palma
2061	San Jorge Los Magueyes, S.A.	7	04	0403	U01	L00	P00	PAL01001	Gerencia Financiera	Créditos	Oficinas centrales	No definido	No definido	Fruta de Palma
2062	San Jorge Los Magueyes, S.A.	7	04	0404	U01	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Oficinas centrales	No definido	No definido	Fruta de Palma
2063	San Jorge Los Magueyes, S.A.	7	05	0501	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Oficinas centrales	No definido	No definido	Fruta de Palma
2064	San Jorge Los Magueyes, S.A.	7	05	0502	U01	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Oficinas centrales	No definido	No definido	Fruta de Palma
2065	San Jorge Los Magueyes, S.A.	7	06	0601	U01	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Oficinas centrales	No definido	No definido	Fruta de Palma
2066	San Jorge Los Magueyes, S.A.	7	10	1001	U01	L00	P00	PAL01001	Compras	Jefatura Compras	Oficinas centrales	No definido	No definido	Fruta de Palma
2067	San Jorge Los Magueyes, S.A.	7	11	1101	U01	L00	P00	PAL01001	IT	Jefatura IT	Oficinas centrales	No definido	No definido	Fruta de Palma
2068	San Jorge Los Magueyes, S.A.	7	13	1301	U01	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Oficinas centrales	No definido	No definido	Fruta de Palma
2069	San Jorge Los Magueyes, S.A.	7	13	1302	U01	L00	P00	PAL01001	Seguridad	Ejecutiva	Oficinas centrales	No definido	No definido	Fruta de Palma
2070	San Jorge Los Magueyes, S.A.	7	00	0001	U02	L00	P00	PAL01001	Administración	Directorio	Planta	No definido	No definido	Fruta de Palma
2071	San Jorge Los Magueyes, S.A.	7	00	0002	U02	L00	P00	PAL01001	Administración	Gerencia General	Planta	No definido	No definido	Fruta de Palma
2072	San Jorge Los Magueyes, S.A.	7	00	0004	U02	L00	P00	PAL01001	Administración	Asesoría Legal	Planta	No definido	No definido	Fruta de Palma
2073	San Jorge Los Magueyes, S.A.	7	01	0101	U02	L00	P00	PAL01001	Auditoría Interna	Jefatura Auditoría	Planta	No definido	No definido	Fruta de Palma
2074	San Jorge Los Magueyes, S.A.	7	02	0201	U02	L00	P00	PAL01001	Dirección de Proyectos	Jefatura Proyectos	Planta	No definido	No definido	Fruta de Palma
2075	San Jorge Los Magueyes, S.A.	7	03	0301	U02	L00	P00	PAL01001	Gerencia Administrativa	Jefatura Admon	Planta	No definido	No definido	Fruta de Palma
2076	San Jorge Los Magueyes, S.A.	7	03	0305	U02	L00	P00	PAL01001	Gerencia Administrativa	Conserjería	Planta	No definido	No definido	Fruta de Palma
2077	San Jorge Los Magueyes, S.A.	7	04	0401	U02	L00	P00	PAL01001	Gerencia Financiera	Jefatura Finanzas	Planta	No definido	No definido	Fruta de Palma
2078	San Jorge Los Magueyes, S.A.	7	04	0402	U02	L00	P00	PAL01001	Gerencia Financiera	Contabilidad	Planta	No definido	No definido	Fruta de Palma
2079	San Jorge Los Magueyes, S.A.	7	04	0403	U02	L00	P00	PAL01001	Gerencia Financiera	Créditos	Planta	No definido	No definido	Fruta de Palma
2080	San Jorge Los Magueyes, S.A.	7	04	0404	U02	L00	P00	PAL01001	Gerencia Financiera	Tesorería	Planta	No definido	No definido	Fruta de Palma
2081	San Jorge Los Magueyes, S.A.	7	05	0501	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Jefatura Gestión Humana	Planta	No definido	No definido	Fruta de Palma
2082	San Jorge Los Magueyes, S.A.	7	05	0502	U02	L00	P00	PAL01001	Gerencia de Gestión Humana	Nóminas	Planta	No definido	No definido	Fruta de Palma
2083	San Jorge Los Magueyes, S.A.	7	06	0601	U02	L00	P00	PAL01001	Gerencia Garantía de Calidad	Jefatura Garantia de Calidad	Planta	No definido	No definido	Fruta de Palma
2084	San Jorge Los Magueyes, S.A.	7	10	1001	U02	L00	P00	PAL01001	Compras	Jefatura Compras	Planta	No definido	No definido	Fruta de Palma
2085	San Jorge Los Magueyes, S.A.	7	11	1101	U02	L00	P00	PAL01001	IT	Jefatura IT	Planta	No definido	No definido	Fruta de Palma
2086	San Jorge Los Magueyes, S.A.	7	13	1301	U02	L00	P00	PAL01001	Seguridad	Jefatura Seguridad	Planta	No definido	No definido	Fruta de Palma
2087	San Jorge Los Magueyes, S.A.	7	13	1302	U02	L00	P00	PAL01001	Seguridad	Ejecutiva	Planta	No definido	No definido	Fruta de Palma
2088	Gas Biologico	6	20	2001	U02	L00	P000	TRA01001	PRODUCCION	TRATAMIENTO DE AGUAS	PLANTA	No definido	No definido	TRATAMIENTO DE AGUAS
2089	Gas Biologico	6	20	2002	U02	L00	P000	ENE01001	PRODUCCION	GENERACION ENERGIA	PLANTA	No definido	No definido	GENERACION ENERGIA
2090	Gas Biologico	6	20	2001	U01	L00	P000	TRA01001	PRODUCCION	TRATAMIENTO DE AGUAS	OFICINAS CENTRALES	No definido	No definido	TRATAMIENTO DE AGUAS
2091	Gas Biologico	7	05	0502	U01	L00	P000	ADM01001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2092	Gas Biologico	7	10	1001	U01	L00	P000	ADM01001	COMPRAS	JEFATURA COMPRAS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2093	Gas Biologico	7	01	0101	U01	L00	P000	ADM01001	AUDITORÍA INTERNA	JEFATURA AUDITORÍA	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2094	Gas Biologico	7	04	0404	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	Tesorería	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2095	Gas Biologico	7	03	0302	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	BODEGAS DE INSUMOS	PLANTA	No definido	No definido	ADMINISTRACIÓN
2096	Gas Biologico	7	04	0402	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2097	Gas Biologico	7	00	0002	U01	L00	P000	SER01001	ADMINISTRACIÓN	GERENCIA GENERAL	OFICINAS CENTRALES	No definido	No definido	OTROS SERVICIOS
2098	Gas Biologico	7	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ADMINISTRACIÓN
2099	Gas Biologico	7	03	0302	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	BODEGAS DE INSUMOS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2100	Gas Biologico	7	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2101	Gas Biologico	8	00	0002	U01	L00	P000	ADM01001	ADMINISTRACIÓN	GERENCIA GENERAL	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2102	Gas Biologico	8	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACIÓN
2103	Ganaderia Rio Seco	6	20	2002	U15	L02	P103	SAL01001	PRODUCCION	SAL	SAL EMPACADA	SAL	SAL EMPACADA	SAL
2104	Ganaderia Rio Seco	6	20	2001	U02	L01	P000	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	SIN PRODUCTO	GANADO
2108	Ganaderia Rio Seco	6	20	2001	U08	L01	P000	GAN01001	PRODUCCION	PECUARIO	TRES ARROLLOS	PECUARIO	SIN PRODUCTO	GANADO
2109	Ganaderia Rio Seco	6	20	2001	U07	L01	P000	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	SIN PRODUCTO	GANADO
2110	Ganaderia Rio Seco	6	03	0304	U16	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	BODEGAS DE REPUESTOS	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2111	Ganaderia Rio Seco	6	20	2001	U18	L01	P040	GAN01001	PRODUCCION	PECUARIO	DERIVADOS PECUARIOS	PECUARIO	 OTROS DERIVADOS PECUARIOS	GANADO
2112	Ganaderia Rio Seco	6	20	2001	U02	L01	P003	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUFALOS	GANADO
2113	Ganaderia Rio Seco	6	20	2001	U02	L01	P001	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUCERROS	GANADO
2114	Ganaderia Rio Seco	6	20	2001	U07	L01	P003	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUFALOS	GANADO
2115	Ganaderia Rio Seco	6	20	2001	U18	L01	P030	GAN01001	PRODUCCION	PECUARIO	DERIVADOS PECUARIOS	PECUARIO	OTROS PRODUCTOS PECUARIOS	GANADO
2116	Ganaderia Rio Seco	6	20	2001	U02	L01	P021	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUFALAS	GANADO
2117	Ganaderia Rio Seco	6	20	2002	U12	L02	P101	SAL01001	PRODUCCION	SAL	LA LAGUNA	SAL	SAL A GRANEL	SAL
2118	Ganaderia Rio Seco	6	20	2001	U08	L01	P003	GAN01001	PRODUCCION	PECUARIO	TRES ARROLLOS	PECUARIO	BUFALOS	GANADO
2119	Ganaderia Rio Seco	6	20	2001	U08	L01	P002	GAN01001	PRODUCCION	PECUARIO	TRES ARROLLOS	PECUARIO	BUVILLOS EN CRECIMIENTO	GANADO
2120	Ganaderia Rio Seco	6	20	2001	U07	L01	P021	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUFALAS	GANADO
2121	Ganaderia Rio Seco	6	20	2001	U02	L02	P021	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	SAL	BUFALAS	GANADO
2122	Ganaderia Rio Seco	6	20	2002	U02	L02	P101	SAL01001	PRODUCCION	SAL	RAMA BLANCA	SAL	SAL A GRANEL	SAL
2123	Ganaderia Rio Seco	6	20	2001	U02	L00	P000	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	SIN LINEA	SIN PRODUCTO	GANADO
2124	Ganaderia Rio Seco	6	20	2002	U02	L02	P000	SAL01001	PRODUCCION	SAL	RAMA BLANCA	SAL	SIN PRODUCTO	SAL
2125	Ganaderia Rio Seco	6	20	2002	U09	L01	P101	SAL01001	PRODUCCION	SAL	SALINA 1	PECUARIO	SAL A GRANEL	SAL
2126	Ganaderia Rio Seco	6	20	2000	U12	L00	P000	SER01001	PRODUCCION	JEFATURA GENERAL PRODUCCION	LA LAGUNA	SIN LINEA	SIN PRODUCTO	SERVICIOS
2127	Ganaderia Rio Seco	6	20	2001	U18	L03	P003	GAN01001	PRODUCCION	PECUARIO	DERIVADOS PECUARIOS	PROCESOS AGROPECUARIOS	BUFALOS	GANADO
2128	Ganaderia Rio Seco	6	20	2001	U07	L02	P000	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	SAL	SIN PRODUCTO	GANADO
2129	Ganaderia Rio Seco	6	20	2001	U02	L01	P002	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUVILLOS EN CRECIMIENTO	GANADO
2130	Ganaderia Rio Seco	6	20	2001	U02	L02	P002	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	SAL	BUVILLOS EN CRECIMIENTO	GANADO
2131	Ganaderia Rio Seco	6	20	2002	U15	L02	P101	SAL01001	PRODUCCION	SAL	SAL EMPACADA	SAL	SAL A GRANEL	SAL
2132	Ganaderia Rio Seco	6	20	2001	U02	L01	P030	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	OTROS PRODUCTOS PECUARIOS	GANADO
2133	Ganaderia Rio Seco	6	20	2001	U02	L01	P040	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	 OTROS DERIVADOS PECUARIOS	GANADO
2134	Ganaderia Rio Seco	6	20	2002	U02	L01	P000	SAL01001	PRODUCCION	SAL	RAMA BLANCA	PECUARIO	SIN PRODUCTO	SAL
2135	Ganaderia Rio Seco	6	20	2001	U18	L00	P040	GAN01001	PRODUCCION	PECUARIO	DERIVADOS PECUARIOS	SIN LINEA	 OTROS DERIVADOS PECUARIOS	GANADO
2136	Ganaderia Rio Seco	6	20	2002	U02	L01	P101	SAL01001	PRODUCCION	SAL	RAMA BLANCA	PECUARIO	SAL A GRANEL	SAL
2137	Ganaderia Rio Seco	6	20	2001	U07	L01	P002	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUVILLOS EN CRECIMIENTO	GANADO
2138	Ganaderia Rio Seco	6	20	2001	U07	L01	P001	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUCERROS	GANADO
2139	Ganaderia Rio Seco	6	20	2001	U02	L01	P001	SAL01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUCERROS	SAL
2140	Ganaderia Rio Seco	6	20	2001	U08	L01	P001	SAL01001	PRODUCCION	PECUARIO	TRES ARROLLOS	PECUARIO	BUCERROS	SAL
2141	Ganaderia Rio Seco	6	20	2001	U07	L01	P001	SAL01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUCERROS	SAL
2142	Ganaderia Rio Seco	6	20	2001	U07	L01	P020	GAN01001	PRODUCCION	PECUARIO	PERLA NEGRA	PECUARIO	BUVILLAS EN SERVICIO	GANADO
2143	Ganaderia Rio Seco	6	20	2001	U15	L01	P040	GAN01001	PRODUCCION	PECUARIO	SAL EMPACADA	PECUARIO	 OTROS DERIVADOS PECUARIOS	GANADO
2144	Ganaderia Rio Seco	6	20	2002	U15	L02	P030	SAL01001	PRODUCCION	SAL	SAL EMPACADA	SAL	OTROS PRODUCTOS PECUARIOS	SAL
2145	Ganaderia Rio Seco	6	20	2001	U02	L01	P020	GAN01001	PRODUCCION	PECUARIO	RAMA BLANCA	PECUARIO	BUVILLAS EN SERVICIO	GANADO
2146	Ganaderia Rio Seco	6	20	2001	U08	L01	P021	GAN01001	PRODUCCION	PECUARIO	TRES ARROLLOS	PECUARIO	BUFALAS	GANADO
2147	Ganaderia Rio Seco	7	13	1303	U12	L00	P000	SER01001	SEGURIDAD	PERIMETRAL	LA LAGUNA	SIN LINEA	SIN PRODUCTO	SERVICIOS
2148	Ganaderia Rio Seco	7	03	0303	U01	L00	P000	SER01001	GERENCIA ADMINISTRATIVA	SEGURIDAD	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	SERVICIOS
2149	Ganaderia Rio Seco	7	13	1302	U01	L00	P000	SER01001	SEGURIDAD	EJECUTIVA	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	SERVICIOS
2150	Ganaderia Rio Seco	7	03	0301	U16	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2151	Ganaderia Rio Seco	7	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	RAMA BLANCA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2152	Ganaderia Rio Seco	7	03	0301	U07	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PERLA NEGRA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2153	Ganaderia Rio Seco	7	05	0502	U16	L00	P000	ADM01001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2154	Ganaderia Rio Seco	7	04	0404	U16	L00	P000	ADM01001	GERENCIA FINANCIERA	TESORERÍA	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2155	Ganaderia Rio Seco	7	10	1001	U16	L00	P000	ADM01001	COMPRAS	JEFATURA COMPRAS	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2156	Ganaderia Rio Seco	7	00	0001	U13	L00	P000	ADM01001	ADMINISTRACIÓN	DIRECTORIO	CASA PATRONAL	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2157	Ganaderia Rio Seco	7	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2158	Ganaderia Rio Seco	7	04	0402	U16	L00	P000	ADM01001	GERENCIA FINANCIERA	CONTABILIDAD	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2159	Ganaderia Rio Seco	7	00	0002	U01	L00	P000	ADM01001	ADMINISTRACIÓN	GERENCIA GENERAL	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2160	Ganaderia Rio Seco	7	10	1001	U01	L00	P000	ADM01001	COMPRAS	JEFATURA COMPRAS	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2161	Ganaderia Rio Seco	7	01	0101	U01	L00	P000	ADM01001	AUDITORÍA INTERNA	JEFATURA AUDITORÍA	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2162	Ganaderia Rio Seco	7	04	0404	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	TESORERÍA	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2163	Ganaderia Rio Seco	7	04	0402	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2164	Ganaderia Rio Seco	7	03	0301	U13	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	CASA PATRONAL	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2165	Ganaderia Rio Seco	7	03	0304	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	BODEGAS DE REPUESTOS	RAMA BLANCA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2166	Ganaderia Rio Seco	7	03	0301	U12	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	LA LAGUNA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2167	Ganaderia Rio Seco	7	03	0304	U16	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	BODEGAS DE REPUESTOS	ADMINISTRACION	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2168	Ganaderia Rio Seco	7	03	0301	U13	L00	P000	SER01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	CASA PATRONAL	SIN LINEA	SIN PRODUCTO	SERVICIOS
2169	Ganaderia Rio Seco	7	00	0001	U13	L00	P000	SER01001	ADMINISTRACIÓN	DIRECTORIO	CASA PATRONAL	SIN LINEA	SIN PRODUCTO	SERVICIOS
2170	Ganaderia Rio Seco	7	00	0001	U13	L01	P000	SER01001	ADMINISTRACIÓN	DIRECTORIO	CASA PATRONAL	PECUARIO	SIN PRODUCTO	SERVICIOS
2171	Ganaderia Rio Seco	7	03	0303	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	SEGURIDAD	RAMA BLANCA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2172	Ganaderia Rio Seco	8	00	0002	U01	L00	P000	ADM01001	ADMINISTRACIÓN	GERENCIA GENERAL	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2173	Ganaderia Rio Seco	8	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	RAMA BLANCA	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2174	Ganaderia Rio Seco	8	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2175	Ganaderia Rio Seco	8	00	0301	U01	L00	P000	ADM01001	ADMINISTRACIÓN	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	SIN LINEA	SIN PRODUCTO	ADMINISTRATIVO
2176	Ganaderia Rio Seco	9	20	2002	U10	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 2	SAL	SAL A GRANEL	SAL
2177	Ganaderia Rio Seco	9	20	2002	U09	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 1	SAL	SAL A GRANEL	SAL
2178	Ganaderia Rio Seco	9	20	2002	U11	L02	P101	SAL01001	PRODUCCION	SAL	SALINA 3	SAL	SAL A GRANEL	SAL
2179	Ganaderia Rio Seco	9	20	2002	U02	L02	P101	SAL01001	PRODUCCION	SAL	RAMA BLANCA	SAL	SAL A GRANEL	SAL
2180	Ganaderia Rio Seco	9	20	2002	U02	L02	P000	SAL01001	PRODUCCION	SAL	RAMA BLANCA	SAL	SIN PRODUCTO	SAL
2181	Ganaderia Rio Seco	9	20	2004	U02	L04	P401	SAN01001	PRODUCCION	PROCESOS AGRICOLAS	RAMA BLANCA	PROCESOS AGRICOLAS	SANDIA	SANDIA
2182	La Antartida	7	01	0101	U01	L00	P000	ADM01001	AUDITORÍA INTERNA	JEFATURA AUDITORÍA	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2183	La Antartida	7	04	0404	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	TESORERÍA	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2184	La Antartida	7	04	0402	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2185	La Antartida	7	20	2000	U02	L00	P000	MAN01001	PRODUCCION	JEFATURA GENERAL PRODUCCION	PLANTA	No definido	No definido	MANUFACTURA LA ANTARTIDA
2186	La Antartida	7	03	0301	U01	L00	P000	OFI01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ARRENDAMIENTO OFICINAS
2187	La Antartida	7	04	0401	U01	L00	P000	SER01001	GERENCIA FINANCIERA	JEFATURA FINANZAS	OFICINAS CENTRALES	No definido	No definido	OTROS SERVICIOS
2188	La Antartida	7	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ADMINISTRACION
2189	La Antartida	7	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2190	La Antartida	7	03	0301	U02	L00	P000	OFI01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ARRENDAMIENTO OFICINAS
2191	La Antartida	8	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2192	Fundacion M.E.M.E.	6	03	0301	U01	L00	P000	RSC01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	RESPONSABILIDAD SOCIAL COMUNIDAD
2193	Fundacion M.E.M.E.	6	03	0301	U01	L00	P000	EDU01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	EDUCACIÓN
2194	Fundacion M.E.M.E.	7	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ADMINISTRACION
2195	Fundacion M.E.M.E.	7	05	0501	U01	L00	P000	ADM01001	GERENCIA DE GESTIÓN HUMANA	JEF GERENCIA DE GESTIÓN HUMANA	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2196	Fundacion M.E.M.E.	7	03	0301	U02	L00	P000	EDU01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	EDUCACIÓN
2197	Fundacion M.E.M.E.	7	01	0101	U01	L00	P000	ADM01001	AUDITORÍA INTERNA	JEFATURA AUDITORÍA	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2198	Fundacion M.E.M.E.	7	04	0402	U01	L00	P000	ADM01001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2199	Fundacion M.E.M.E.	7	03	0301	U02	L00	P000	ESC01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ESCUELA ACACIAS
2200	Fundacion M.E.M.E.	7	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2201	Fundacion M.E.M.E.	7	03	0301	U02	L00	P000	RSC01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	RESPONSABILIDAD SOCIAL COMUNIDAD
2202	Fundacion M.E.M.E.	7	03	0301	U01	L00	P000	RSC01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	RESPONSABILIDAD SOCIAL COMUNIDAD
2203	Fundacion M.E.M.E.	7	03	0301	U01	L00	P000	EDU01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	EDUCACIÓN
2204	Fundacion M.E.M.E.	8	03	0301	U01	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2205	Fundacion M.E.M.E.	8	00	0301	U01	L00	P000	ADM01001	ADMINISTRACIÓN	JEFATURA GERENCIA ADMINIS	OFICINAS CENTRALES	No definido	No definido	ADMINISTRACION
2206	Fundacion M.E.M.E.	8	03	0301	U02	L00	P000	ADM01001	GERENCIA ADMINISTRATIVA	JEFATURA GERENCIA ADMINIS	PLANTA	No definido	No definido	ADMINISTRACION
2207	Metalmecanica	7	00	0001	U01	L00	P000	TE030001	ADMINISTRACION	DIRECTORIO	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TERCEROS
2208	Metalmecanica	7	00	0002	U01	L00	P000	TA010001	ADMINISTRACION	GERENCIA GENERAL	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2209	Metalmecanica	7	00	0002	U01	L00	P000	COELAB01	ADMINISTRACION	GERENCIA GENERAL	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	COMERCIALIZACION EQUIPOS DE LABORATORIO
2210	Metalmecanica	7	00	0002	U02	L00	P000	TA010001	ADMINISTRACION	GERENCIA GENERAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2211	Metalmecanica	7	01	0101	U01	L00	P000	TA010001	AUDITORIA INTERNA	JEFATURA AUDITORIA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2212	Metalmecanica	7	01	0101	U02	L00	P000	TA010001	AUDITORIA INTERNA	JEFATURA AUDITORIA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2213	Metalmecanica	7	02	0201	U01	L00	P000	TA010001	DIRECCIÓN DE PROYECTOS	JEFATURA PROYECTOS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2214	Metalmecanica	7	03	0301	U01	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2215	Metalmecanica	7	03	0301	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2216	Metalmecanica	6	03	0302	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE INSUMOS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2217	Metalmecanica	6	03	0303	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE MATERIALES	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2218	Metalmecanica	6	03	0304	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE REPUESTOS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2219	Metalmecanica	7	03	0305	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	CONSERJERÍA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2220	Metalmecanica	6	03	0306	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	SEGURIDAD INDUSTRIAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2221	Metalmecanica	7	03	0307	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	TRANSPORTE DE PERSONAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2222	Metalmecanica	7	04	0401	U01	L00	P000	TA010001	GERENCIA FINANCIERA	JEFATURA GERENCIA FINANCIERA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2223	Metalmecanica	7	04	0402	U01	L00	P000	TA010001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2224	Metalmecanica	7	04	0403	U01	L00	P000	TA010001	GERENCIA FINANCIERA	CRÉDITOS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2225	Metalmecanica	7	04	0404	U01	L00	P000	TA010001	GERENCIA FINANCIERA	TESORERÍA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2226	Metalmecanica	7	05	0501	U01	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	JEFATURA GESTION HUMANA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2227	Metalmecanica	7	05	0501	U02	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	JEFATURA GESTION HUMANA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2228	Metalmecanica	7	05	0502	U01	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2229	Metalmecanica	7	05	0502	U02	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2230	Metalmecanica	7	10	1001	U01	L00	P000	TA010001	COMPRAS	JEFATURA COMPRAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2231	Metalmecanica	7	11	1101	U01	L00	P000	TA010001	SISTEMAS	JEFATURA SISTEMAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2232	Metalmecanica	6	20	2000	U02	L00	P000	TA010001	PRODUCCIÓN	JEFATURA GENERAL PRODUCCION	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2233	Metalmecanica	6	20	2001	U02	L01	P000	TA010001	PRODUCCIÓN	AUTOMOTRIZ	PLANTA	AUTOMOTRIZ	SIN PRODUCTO	PROYECTOS TASINSA
2234	Metalmecanica	6	20	2001	U04	L01	P000	TA010001	PRODUCCIÓN	AUTOMOTRIZ	SUPREMA	AUTOMOTRIZ	SIN PRODUCTO	PROYECTOS TASINSA
2235	Metalmecanica	6	20	2002	U02	L02	P000	TA010001	PRODUCCIÓN	SOLDADURA	PLANTA	SOLDADURA	SIN PRODUCTO	PROYECTOS TASINSA
2236	Metalmecanica	6	20	2002	U04	L02	P000	TA010001	PRODUCCIÓN	SOLDADURA	SUPREMA	SOLDADURA	SIN PRODUCTO	PROYECTOS TASINSA
2237	Metalmecanica	6	20	2003	U02	L03	P000	TA010001	PRODUCCIÓN	TORNOS	PLANTA	TORNOS	SIN PRODUCTO	PROYECTOS TASINSA
2238	Metalmecanica	6	20	2003	U04	L03	P000	TA010001	PRODUCCIÓN	TORNOS	SUPREMA	TORNOS	SIN PRODUCTO	PROYECTOS TASINSA
2239	Metalmecanica	6	20	2004	U02	L04	P000	TA010001	PRODUCCIÓN	ELECTRICO	PLANTA	ELECTRICO	SIN PRODUCTO	PROYECTOS TASINSA
2240	Metalmecanica	6	20	2004	U04	L04	P000	TA010001	PRODUCCIÓN	ELECTRICO	SUPREMA	ELECTRICO	SIN PRODUCTO	PROYECTOS TASINSA
2241	Metalmecanica	6	20	2005	U02	L05	P000	TA010001	PRODUCCIÓN	MANTENIMIENTO INDUSTRIAL	PLANTA	MANTENIMIENTO INDUSTRIAL	SIN PRODUCTO	PROYECTOS TASINSA
2242	Metalmecanica	6	20	2005	U04	L05	P000	TA010001	PRODUCCIÓN	MANTENIMIENTO INDUSTRIAL	SUPREMA	MANTENIMIENTO INDUSTRIAL	SIN PRODUCTO	PROYECTOS TASINSA
2243	Metalmecanica	6	20	2006	U02	L06	P401	TA010001	PRODUCCIÓN	MOVIMIENTO MAQUINARIA PESADA	PLANTA	MOVIMIENTO MAQUINARIA PESADA	GRUA	PROYECTOS TASINSA
2244	Metalmecanica	6	20	2006	U04	L06	P401	TA010001	PRODUCCIÓN	MOVIMIENTO MAQUINARIA PESADA	SUPREMA	MOVIMIENTO MAQUINARIA PESADA	GRUA	PROYECTOS TASINSA
2245	Metalmecanica	6	20	2006	U02	L06	P402	TA010001	PRODUCCIÓN	MOVIMIENTO MAQUINARIA PESADA	PLANTA	MOVIMIENTO MAQUINARIA PESADA	OTROS EQUIPOS	PROYECTOS TASINSA
2246	Metalmecanica	9	20	2009	U03	L09	P009	TE030001	PRODUCCIÓN	TRABAJOS EXTERNOS	TERCEROS	TRABAJOS EXTERNOS	TERCEROS	PROYECTOS TERCEROS
2247	Metalmecanica	7	21	2101	U02	L00	P000	TA010001	CONTROL DE CALIDAD	CONTROL DE CALIDAD	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2248	Inovatalent	7	00	0001	U03	L00	P00	0201P1S1M01	ADMINISTRACION	DIRECTORIO	ACACIAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2249	Inovatalent	7	00	0001	U06	L00	P00	0201P1S1M01	ADMINISTRACION	DIRECTORIO	SAN FRANCISCO	NO DEFINIDO	NO DEFINIDO	Gerencia General
2250	Inovatalent	7	00	0001	U12	L00	P00	0201P1S1M01	ADMINISTRACION	DIRECTORIO	INNOVATALENT	NO DEFINIDO	NO DEFINIDO	Gerencia General
2251	Inovatalent	7	00	0002	U02	L00	P00	0201P1S1M01	ADMINISTRACION	GERENCIA GENERAL	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2252	Inovatalent	7	00	0002	U12	L00	P00	0201P1S1M01	ADMINISTRACION	GERENCIA GENERAL	INNOVATALENT	NO DEFINIDO	NO DEFINIDO	Gerencia General
2253	Inovatalent	7	01	0101	U02	L00	P00	0201P1S1M01	AUDITORIA INTERNA	JEFATURA AUDITORIA	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2254	Inovatalent	7	01	0101	U01	L00	P00	0201P1S1M01	AUDITORIA INTERNA	JEFATURA AUDITORIA	LAS PALMAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2255	Inovatalent	7	02	0201	D11	L00	P00	0201P1S1M01	DIRECCIÓN DE PROYECTOS	JEFATURA PROYECTOS	PROYECTOS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2256	Inovatalent	7	03	0301	D01	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	AGRICOLA ADMINISTRACIÓN GENERA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2257	Inovatalent	7	03	0301	U03	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	ACACIAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2258	Inovatalent	7	03	0301	U04	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	SAN JORGE	NO DEFINIDO	NO DEFINIDO	Gerencia General
2259	Inovatalent	7	03	0301	U05	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	SAN ANTONIO	NO DEFINIDO	NO DEFINIDO	Gerencia General
2260	Inovatalent	7	03	0301	U06	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	SAN FRANCISCO	NO DEFINIDO	NO DEFINIDO	Gerencia General
2261	Inovatalent	7	03	0301	U08	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	ALFA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2262	Inovatalent	7	03	0301	U12	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	INNOVATALENT	NO DEFINIDO	NO DEFINIDO	Gerencia General
2263	Inovatalent	7	03	0302	D06	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	BODEGA DE MP E INSUMOS	BODEGA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2264	Inovatalent	7	03	0303	D06	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	BODEGA DE ACEITES A GRANEL	BODEGA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2265	Inovatalent	7	03	0304	D06	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	BODEGA MATERIALES Y REPUESTOS	BODEGA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2266	Inovatalent	7	03	0305	D01	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	CONSERJERÍA	AGRICOLA ADMINISTRACIÓN GENERA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2267	Inovatalent	7	03	0305	D10	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	CONSERJERÍA	SERVICIOS GENERALES 1	NO DEFINIDO	NO DEFINIDO	Gerencia General
2268	Inovatalent	7	03	0305	U03	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	CONSERJERÍA	ACACIAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2269	Inovatalent	7	03	0306	U01	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	SEGURIDAD INDUSTRIAL	LAS PALMAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2270	Inovatalent	7	03	0307	U01	L00	P00	0201P1S1M01	GERENCIA ADMINISTRATIVA	TRANSPORTE DE PERSONAL	LAS PALMAS	NO DEFINIDO	NO DEFINIDO	Gerencia General
2271	Inovatalent	7	04	0401	U02	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	JEFATURA FINANZAS	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2272	Inovatalent	7	04	0402	U02	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	CONTABILIDAD	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2273	Inovatalent	7	04	0402	U12	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	CONTABILIDAD	INNOVATALENT	NO DEFINIDO	NO DEFINIDO	Gerencia General
2274	Inovatalent	7	04	0403	U02	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	CRÉDITOS	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2275	Inovatalent	7	04	0404	U02	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	TESORERÍA	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2276	Inovatalent	7	04	0404	U12	L00	P00	0201P1S1M01	GERENCIA FINANCIERA	TESORERÍA	INNOVATALENT	NO DEFINIDO	NO DEFINIDO	Gerencia General
2277	Inovatalent	7	05	0501	D12	L00	P00	0201P1S1M01	GERENCIA DE GESTIÓN HUMANA	JEFATURA GESTION HUMANA	ADMINISTRACION GESTIÓN HUMANA1	NO DEFINIDO	NO DEFINIDO	Gerencia General
2278	Inovatalent	7	05	0502	D02	L00	P00	0201P1S1M01	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	AGRICOLA ADMINISTRACIÓN AREA 1	NO DEFINIDO	NO DEFINIDO	Gerencia General
2279	Inovatalent	7	05	0502	D09	L00	P00	0201P1S1M01	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	ADMINISTRACION NOMINA 1	NO DEFINIDO	NO DEFINIDO	Gerencia General
2280	Inovatalent	7	06	0601	D08	L00	P00	0201P1S1M01	GERENCIA GARANTÍA DE CALIDAD	JEFATURA GARANTIA DE CALIDAD	GARANTÍA DE CALIDAD	NO DEFINIDO	NO DEFINIDO	Gerencia General
2281	Inovatalent	7	10	1001	U02	L00	P00	0201P1S1M01	COMPRAS	JEFATURA COMPRAS	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2282	Inovatalent	7	11	1101	U02	L00	P00	0201P1S1M01	IT	JEFATURA IT	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2283	Inovatalent	7	12	1201	U02	L00	P00	0201P1S1M01	LOGÍSTICA	LOGISTICA	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2284	Inovatalent	7	12	1202	U02	L00	P00	0201P1S1M01	LOGÍSTICA	BODEGA PT	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2285	Inovatalent	7	12	1203	U02	L00	P00	0201P1S1M01	LOGÍSTICA	TRANSPORTE	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2286	Inovatalent	7	13	1301	U02	L00	P00	0201P1S1M01	SEGURIDAD	JEFATURA SEGURIDAD	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2287	Inovatalent	7	13	1302	D01	L00	P00	0201P1S1M01	SEGURIDAD	SEGURIDAD EJECUTIVA	AGRICOLA ADMINISTRACIÓN GENERA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2288	Inovatalent	7	13	1303	U02	L00	P00	0201P1S1M01	SEGURIDAD	SEGURIDAD PERIMETRAL	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2289	Inovatalent	7	13	1304	U02	L00	P00	0201P1S1M01	SEGURIDAD	SEGURIDAD DE RUTA	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2290	Inovatalent	7	20	2001	U02	L00	P00	0201P1S1M01	PRODUCCIÓN	JEFATURA GENERAL PRODUCCION	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2291	Inovatalent	7	20	2002	D01	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	AGRICOLA ADMINISTRACIÓN GENERA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2292	Inovatalent	7	20	2002	D02	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	AGRICOLA ADMINISTRACIÓN AREA 1	NO DEFINIDO	NO DEFINIDO	Gerencia General
2293	Inovatalent	7	20	2002	D03	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	AGRICOLA ADMINISTRACIÓN AREA 2	NO DEFINIDO	NO DEFINIDO	Gerencia General
2294	Inovatalent	7	20	2002	D04	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	AGRICOLA MAQUINARIA PESADA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2295	Inovatalent	7	20	2002	D05	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	AGRICOLA TRANSPORTES	NO DEFINIDO	NO DEFINIDO	Gerencia General
2296	Inovatalent	7	20	2002	D07	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	ADMINISTRACIÓN IND./GENERACIÓN	NO DEFINIDO	NO DEFINIDO	Gerencia General
2297	Inovatalent	7	20	2002	U13	L00	P00	0201P1S1M01	PRODUCCIÓN	PRODUCCION	GAS BIOLOGICO, S.A.	NO DEFINIDO	NO DEFINIDO	Gerencia General
2298	Inovatalent	7	20	2022	U02	L00	P00	0201P1S1M01	PRODUCCIÓN	CALDERAS	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2299	Inovatalent	7	21	2101	D01	L00	P00	0201P1S1M01	CONTROL DE CALIDAD	JEFATURA CONTROL DE CALIDAD	AGRICOLA ADMINISTRACIÓN GENERA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2300	Inovatalent	7	21	2102	U02	L00	P00	0201P1S1M01	CONTROL DE CALIDAD	LABORATORIO	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2301	Inovatalent	7	30	3001	U02	L00	P00	0201P1S1M01	DIRECCIÓN COMERCIAL	JEFATURA DIRECCION COMERCIAL	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2302	Inovatalent	7	31	3101	U02	L00	P00	0201P1S1M01	MERCADEO	JEFATURA MERCADEO	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2303	Inovatalent	7	32	3201	U02	L00	P00	0201P1S1M01	IDI	JEFATURA IDI	SUPREMA	NO DEFINIDO	NO DEFINIDO	Gerencia General
2304	Tasinsa	7	03	0308	U03	L00	P000	TD020002	GERENCIA ADMINISTRATIVA	TERMINAL DE DISTRIBUCION	TERMINAL DE DISTRIBUCION	NO DEFINIDO	SIN PRODUCTO	COMERCIALIZACION ZOLIC ACEITES A GRANEL
2305	Tasinsa	7	00	0002	U01	L00	P000	TA010001	ADMINISTRACION	GERENCIA GENERAL	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2306	Tasinsa	7	00	0002	U02	L00	P000	TA010001	ADMINISTRACION	GERENCIA GENERAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2307	Tasinsa	7	01	0101	U01	L00	P000	TA010001	AUDITORIA INTERNA	JEFATURA AUDITORIA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2308	Tasinsa	7	01	0101	U02	L00	P000	TA010001	AUDITORIA INTERNA	JEFATURA AUDITORIA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2309	Tasinsa	7	02	0201	U01	L00	P000	TA010001	DIRECCIÓN DE PROYECTOS	JEFATURA PROYECTOS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2310	Tasinsa	7	03	0301	U01	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2311	Tasinsa	7	03	0301	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	JEFATURA ADMON	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2312	Tasinsa	6	03	0302	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE INSUMOS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2313	Tasinsa	6	03	0303	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE MATERIALES	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2314	Tasinsa	6	03	0304	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	BODEGA DE REPUESTOS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2315	Tasinsa	7	03	0305	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	CONSERJERÍA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2316	Tasinsa	6	03	0306	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	SEGURIDAD INDUSTRIAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2317	Tasinsa	7	03	0307	U02	L00	P000	TA010001	GERENCIA ADMINISTRATIVA	TRANSPORTE DE PERSONAL	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2318	Tasinsa	7	04	0401	U01	L00	P000	TA010001	GERENCIA FINANCIERA	JEFATURA GERENCIA FINANCIERA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2319	Tasinsa	7	04	0402	U01	L00	P000	TA010001	GERENCIA FINANCIERA	CONTABILIDAD	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2320	Tasinsa	7	04	0403	U01	L00	P000	TA010001	GERENCIA FINANCIERA	CRÉDITOS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2321	Tasinsa	7	04	0404	U01	L00	P000	TA010001	GERENCIA FINANCIERA	TESORERÍA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2322	Tasinsa	7	05	0501	U01	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	JEFATURA GESTION HUMANA	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2323	Tasinsa	7	05	0501	U02	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	JEFATURA GESTION HUMANA	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2324	Tasinsa	7	05	0502	U01	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2325	Tasinsa	7	05	0502	U02	L00	P000	TA010001	GERENCIA DE GESTIÓN HUMANA	NÓMINAS	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2326	Tasinsa	7	10	1001	U01	L00	P000	TA010001	COMPRAS	JEFATURA COMPRAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2327	Tasinsa	7	11	1101	U01	L00	P000	TA010001	SISTEMAS	JEFATURA SISTEMAS	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2328	Tasinsa	6	20	2000	U02	L00	P000	TA010001	PRODUCCIÓN	JEFATURA GENERAL PRODUCCION	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2329	Tasinsa	6	20	2001	U02	L01	P000	TA010001	PRODUCCIÓN	AUTOMOTRIZ	PLANTA	AUTOMOTRIZ	SIN PRODUCTO	PROYECTOS TASINSA
2330	Tasinsa	6	20	2002	U02	L02	P000	TA010001	PRODUCCIÓN	SOLDADURA	PLANTA	SOLDADURA	SIN PRODUCTO	PROYECTOS TASINSA
2331	Tasinsa	6	20	2003	U02	L03	P000	TA010001	PRODUCCIÓN	TORNOS	PLANTA	TORNOS	SIN PRODUCTO	PROYECTOS TASINSA
2332	Tasinsa	6	20	2004	U02	L04	P000	TA010001	PRODUCCIÓN	ELECTRICO	PLANTA	ELECTRICO	SIN PRODUCTO	PROYECTOS TASINSA
2333	Tasinsa	6	20	2005	U02	L05	P000	TA010001	PRODUCCIÓN	MANTENIMIENTO INDUSTRIAL	PLANTA	MANTENIMIENTO INDUSTRIAL	SIN PRODUCTO	PROYECTOS TASINSA
2334	Tasinsa	6	20	2006	U02	L06	P401	TA010001	PRODUCCIÓN	MOVIMIENTO MAQUINARIA PESADA	PLANTA	MOVIMIENTO MAQUINARIA PESADA	GRUA	PROYECTOS TASINSA
2335	Tasinsa	6	20	2006	U02	L06	P402	TA010001	PRODUCCIÓN	MOVIMIENTO MAQUINARIA PESADA	PLANTA	MOVIMIENTO MAQUINARIA PESADA	OTROS EQUIPOS	PROYECTOS TASINSA
2336	Tasinsa	7	21	2101	U02	L00	P000	TA010001	CONTROL DE CALIDAD	CONTROL DE CALIDAD	PLANTA	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TASINSA
2337	Tasinsa	7	00	0001	U01	L00	P000	TE030001	ADMINISTRACION	DIRECTORIO	OFICINAS CENTRALES	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TERCEROS
2338	Tasinsa	6	20	2009	U04	L09	P009	TE030001	PRODUCCIÓN	TRABAJOS EXTERNOS	TERCEROS	TRABAJOS EXTERNOS	TERCEROS	PROYECTOS TERCEROS
2339	Tasinsa	7	03	0308	U03	L00	P000	TD020001	GERENCIA ADMINISTRATIVA	TERMINAL DE DISTRIBUCION	TERMINAL DE DISTRIBUCION	NO DEFINIDO	SIN PRODUCTO	PROYECTOS TERMINAL DE DISTRIBUCION ZOLIC
\.


--
-- Data for Name: niveles_aprobacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.niveles_aprobacion (codigo, nombre, orden, alcance, descripcion, activo) FROM stdin;
N1	Aprobador de la empresa	1	empresa	Primera autorización. Solo ve solicitudes de su empresa.	t
N2	Aprobador de operaciones	2	todas	Segunda autorización. Ve solicitudes de todas las empresas.	t
N3	Dirección	3	todas	Tercera autorización para montos que superan el tope.	t
\.


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.parametros (id, z, meses, lt_std, ajuste, margen, periodo, dias) FROM stdin;
1	1.65	3	15	0	0	T4-2026	91
\.


--
-- Data for Name: sap_post_lines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sap_post_lines (id, doc_num, payload, created_at, empresa, bodega_codigo, tipo_documento, numero_documento, company_db) FROM stdin;
1	SC-2026-0001	{"DocNum": "SC-2026-0001", "DocDate": "2026-11-10", "Empresa": "SUPREMA", "Comments": "Consolidado bodega", "ItemCode": "RE0301029", "Quantity": 8, "Requester": "Marta Solís", "Validacion": "Correctamente", "AccountCode": "61302804", "CostingCode": "03", "LineTotal_Q": 12021.79, "ProjectCode": "0201P1S1M01", "UnitPrice_Q": 1502.7237, "CostingCode2": "0302", "CostingCode3": "U02", "CostingCode4": "L08", "CostingCode5": "P50", "NombreCuenta": "REPARACION Y MANTENIMIENTO MAQUINARIA Y EQUIPO-COSTO", "RequiredDate": "2026-11-25", "DetalleCompra": "", "ObraEnProceso": "", "PlacaVehiculo": "", "WarehouseCode": "SUPREMA", "ItemDescription": "REFRIGERANTE R-438A MARCA DUPONT ISCEON MO99DE (CILINDRO DE 25 LIBRAS)", "TipoDocRespaldo": "", "NoObraEspecifica": "", "SolicitudesOrigen": "SC-2026-0002"}	2026-11-10 02:15:22.859127+00					
2	SC-2026-0001	{"DocNum": "SC-2026-0001", "DocDate": "2026-11-10", "Empresa": "SUPREMA", "Comments": "Consolidado bodega", "ItemCode": "RE0302046", "Quantity": 7, "Requester": "Marta Solís", "Validacion": "Correctamente", "AccountCode": "61302804", "CostingCode": "03", "LineTotal_Q": 1121.22, "ProjectCode": "0201P1S1M01", "UnitPrice_Q": 160.1749, "CostingCode2": "0302", "CostingCode3": "U02", "CostingCode4": "L08", "CostingCode5": "P50", "NombreCuenta": "REPARACION Y MANTENIMIENTO MAQUINARIA Y EQUIPO-COSTO", "RequiredDate": "2026-11-25", "DetalleCompra": "", "ObraEnProceso": "", "PlacaVehiculo": "", "WarehouseCode": "SUPREMA", "ItemDescription": "COJINETE 6309 ZZ/C3 SKF", "TipoDocRespaldo": "", "NoObraEspecifica": "", "SolicitudesOrigen": "SC-2026-0001"}	2026-11-10 02:15:22.864605+00					
3	SUPREMA-SC-00001	{"Bodega": "01", "DocNum": "SUPREMA-SC-00001", "DocDate": "2026-11-10", "Empresa": "SUPREMA", "Comments": "Consolidado bodega", "ItemCode": "MA0108005", "Quantity": 1, "CompanyDB": "SBO_SUPREMA", "ObjetoSap": "PurchaseRequests", "Requester": "Admin Pide Justo", "Validacion": "Correctamente", "AccountCode": "61300101", "CostingCode": "03", "LineTotal_Q": 4.75, "ProjectCode": "0201P1S1M01", "UnitPrice_Q": 4.7489, "CostingCode2": "0302", "CostingCode3": "U02", "CostingCode4": "L08", "CostingCode5": "P50", "NombreCuenta": "MATERIALES E INSUMOS-COSTO", "RequiredDate": "2026-11-22", "DetalleCompra": "", "ObraEnProceso": "", "PlacaVehiculo": "", "TipoDocumento": "SC", "WarehouseCode": "01", "ItemDescription": "TORNILLO 1/2 X 2 1/2 HEXA COMPLETO", "TipoDocRespaldo": "", "NoObraEspecifica": "", "SolicitudesOrigen": "SC-2026-0006"}	2026-11-10 14:45:48.154786+00	SUPREMA	01	SC	SUPREMA-SC-00001	SBO_SUPREMA
4	SUPREMA-SC-00002	{"Bodega": "01", "DocNum": "SUPREMA-SC-00002", "DocDate": "2026-11-10", "Empresa": "SUPREMA", "Comments": "Consolidado bodega", "ItemCode": "MA0108041", "Quantity": 3, "CompanyDB": "SBO_SUPREMA", "ObjetoSap": "PurchaseRequests", "Requester": "Admin Pide Justo", "Validacion": "Correctamente", "AccountCode": "61300101", "CostingCode": "03", "LineTotal_Q": 9.51, "ProjectCode": "0201P1S1M01", "UnitPrice_Q": 3.1696, "CostingCode2": "0302", "CostingCode3": "U02", "CostingCode4": "L08", "CostingCode5": "P50", "NombreCuenta": "MATERIALES E INSUMOS-COSTO", "RequiredDate": "2026-11-22", "DetalleCompra": "", "ObraEnProceso": "", "PlacaVehiculo": "", "TipoDocumento": "SC", "WarehouseCode": "01", "ItemDescription": "TORNILLO HILTING DE 1/2 x 4", "TipoDocRespaldo": "", "NoObraEspecifica": "", "SolicitudesOrigen": "SC-2026-0007"}	2026-11-10 16:18:57.53076+00	SUPREMA	01	SC	SUPREMA-SC-00002	SBO_SUPREMA
\.


--
-- Data for Name: sequences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sequences (name, value) FROM stdin;
doc	1
req	7
\.


--
-- Data for Name: series_documento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.series_documento (id, empresa, tipo_codigo, bodega_codigo, prefijo, siguiente, digitos, activo) FROM stdin;
3	ACACIAS	SC		ACACIAS-SC-	1	5	t
4	ALFA	SC		ALFA-SC-	1	5	t
5	QUIRICA	SC		QUIRICA-SC-	1	5	t
6	SAN ANTONIO	SC		SANANTONIO-SC-	1	5	t
7	SAN FRANCISCO	SC		SANFRANCISCO-SC-	1	5	t
8	SAN JORGE	SC		SANJORGE-SC-	1	5	t
9	TASINSA	SC		TASINSA-SC-	1	5	t
10	METALMECANICA	SC		METALMECANICA-SC-	1	5	t
11	GRS	SC		GRS-SC-	1	5	t
12	GABIOSA	SC		GABIOSA-SC-	1	5	t
2	PALMAS	SC		PALMAS-SC-	3	5	t
1	SUPREMA	SC		SUPREMA-SC-	3	5	t
\.


--
-- Data for Name: solicitud_lineas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solicitud_lineas (id, solicitud_id, empresa, item_code, item_name, categoria, qty, price, total, sug, alerta, justificacion, disp, min, max, contable) FROM stdin;
1	SC-2026-0001	SUPREMA	RE0302046	COJINETE 6309 ZZ/C3 SKF	Repuestos y componentes mecánicos	7	160.1749	1121.22	7	En rango		6	7	13	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P50", "ok": true, "cta": "61302804", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0201P1S1M01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-Costo-Centros Serv", "proyN": "Gerencia General", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
2	SC-2026-0002	SUPREMA	RE0301029	REFRIGERANTE R-438A MARCA DUPONT ISCEON MO99DE (CILINDRO DE 25 LIBRAS)	Repuestos y componentes mecánicos	8	1502.7237	12021.79	8	En rango	demo	2	5	10	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P50", "ok": true, "cta": "61302804", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0201P1S1M01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-Costo-Centros Serv", "proyN": "Gerencia General", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
3	SC-2026-0003	SUPREMA	MP0201002	ACEITE CRUDO DE PALMA	Materia prima	3	8.7227	26.17	4515718	Cantidad corta		1848953	2314671	6364671	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P50", "ok": true, "cta": "61300101", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0201P1S1M01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-Costo-Centros Serv", "proyN": "Gerencia General", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
4	SC-2026-0004	PALMAS	IN0104001	ETIQUETA BULTO No. 4 VERDE	Material de empaque	1	0.1488	0.15	17381	En rango		6387	5768	23768	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P20", "ok": true, "cta": "61300101", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0204A1P1P01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-costo-Beneficio", "proyN": "Aceite", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
5	SC-2026-0005	PALMAS	MP0201005	FRUTA DE PALMA AFRICANA	Materia prima	1	1.1823	1.18	52275101	Cantidad corta		6100074	14254627	58375175	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P20", "ok": true, "cta": "61300101", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0204A1P1P01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-costo-Beneficio", "proyN": "Aceite", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
6	SC-2026-0006	SUPREMA	MA0108005	TORNILLO 1/2 X 2 1/2 HEXA COMPLETO	Ferretería general	1	4.7489	4.75	30	En rango		42	32	72	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P50", "ok": true, "cta": "61300101", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0201P1S1M01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-Costo-Centros Serv", "proyN": "Gerencia General", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
7	SC-2026-0007	SUPREMA	MA0108041	TORNILLO HILTING DE 1/2 x 4	Ferretería general	3	3.1696	9.51	17	En rango		30	22	47	{"d1": "03", "d2": "0302", "d3": "U02", "d4": "L08", "d5": "P50", "ok": true, "cta": "61300101", "depN": "Gerencia Administrativa", "linN": "Procesos Productivos", "proy": "0201P1S1M01", "subN": "Bodega de MP e Insumos", "ubiN": "Planta", "placa": "", "prodN": "No definido-Costo-Centros Serv", "proyN": "Gerencia General", "detalle": "", "obraEsp": "", "tipoDoc": "", "obraProc": "", "validacion": "Correctamente"}
\.


--
-- Data for Name: solicitudes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solicitudes (id, empresa, solicitante_id, solicitante_nombre, estado, total, dentro_presupuesto, ruta, bud, required_date, comentario, doc_num, created_at, approved_at, sent_at, bodega_codigo, tipo_documento, sap_doc_num, company_db) FROM stdin;
SC-2026-0002	SUPREMA	U01	Ana Morales	Enviada a SAP	12021.79	f	{"desc": "Excede presupuesto y supera Q10,000: aprueba gerente y Dirección de Operaciones", "regla": "R3", "niveles": "N1+N2"}	{"cats": [{"cat": "Repuestos y componentes mecánicos", "disp": 5528.960999999924, "monto": 12021.79, "dentro": false}], "total": 12021.79, "dentro": false}	2026-11-25	excede	SC-2026-0001	2026-11-10 02:15:22.634457+00	2026-11-10 02:15:22.749+00	2026-11-10 02:15:22.872+00		SC	\N	
SC-2026-0001	SUPREMA	U01	Ana Morales	Enviada a SAP	1121.22	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "AUTO"}	{"cats": [{"cat": "Repuestos y componentes mecánicos", "disp": 6650.180999999924, "monto": 1121.22, "dentro": true}], "total": 1121.22, "dentro": true}	2026-11-25	demo auto	SC-2026-0001	2026-11-10 02:15:12.232081+00	2026-11-10 02:15:12.228+00	2026-11-10 02:15:22.88+00		SC	\N	
SC-2026-0003	SUPREMA	U01	Ana Morales	Aprobada	26.17	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "AUTO"}	{"cats": [{"cat": "Materia prima", "disp": 40444001.26525, "monto": 26.17, "dentro": true}], "total": 26.17, "dentro": true}	2026-11-22		\N	2026-11-10 02:25:37.557787+00	2026-11-10 02:25:37.554+00	\N		SC	\N	
SC-2026-0004	PALMAS	ADMIN	Admin Pide Justo	Aprobada	0.15	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "AUTO"}	{"cats": [{"cat": "Material de empaque", "disp": 625086.5879875, "monto": 0.15, "dentro": true}], "total": 0.15, "dentro": true}	2026-11-22		PALMAS-SC-00001	2026-11-10 13:55:57.188988+00	2026-11-10 13:55:57.184+00	\N	01	SC	\N	SBO_PALMAS
SC-2026-0005	PALMAS	ADMIN	Admin Pide Justo	Aprobada	1.18	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "N1+N2+N3"}	{"cats": [{"cat": "Materia prima", "disp": 57427638.060049996, "monto": 1.18, "dentro": true}], "total": 1.18, "dentro": true}	2026-11-20	Prueba de tres niveles	PALMAS-SC-00002	2026-11-10 14:25:35.446865+00	2026-11-10 14:28:31.286+00	\N	01	SC	\N	SBO_PALMAS
SC-2026-0006	SUPREMA	U01	Ana Morales	Enviada a SAP	4.75	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "AUTO"}	{"cats": [{"cat": "Ferretería general", "disp": 351030.4659999998, "monto": 4.75, "dentro": true}], "total": 4.75, "dentro": true}	2026-11-22		SUPREMA-SC-00001	2026-11-10 14:42:05.613374+00	2026-11-10 14:42:05.611+00	2026-11-10 14:45:48.159+00	01	SC	SUPREMA-SC-00001	SBO_SUPREMA
SC-2026-0007	SUPREMA	RONALDMASELLI	Ronald	Enviada a SAP	9.51	t	{"desc": "Dentro de presupuesto: aprobación automática, pasa directo a Bodega o Compras", "regla": "R1", "niveles": "AUTO"}	{"cats": [{"cat": "Ferretería general", "disp": 351025.7159999998, "monto": 9.51, "dentro": true}], "total": 9.51, "dentro": true}	2026-11-22		SUPREMA-SC-00002	2026-11-10 14:50:22.264326+00	2026-11-10 14:50:22.261+00	2026-11-10 16:18:57.536+00	01	SC	SUPREMA-SC-00002	SBO_SUPREMA
\.


--
-- Data for Name: tipos_documento; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipos_documento (codigo, nombre, objeto_sap, activo) FROM stdin;
SC	Solicitud de compra	PurchaseRequests	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, nombre, rol, empresa, puesto, azure_oid, activo, created_at) FROM stdin;
U01	u01@grupo-meme.demo	Ana Morales	Solicitante	SUPREMA	Jefa de Mantenimiento	\N	t	2026-11-10 02:13:05.543373+00
U02	u02@grupo-meme.demo	Carlos Pérez	Solicitante	PALMAS	Supervisor de Taller	\N	t	2026-11-10 02:13:05.543373+00
U03	u03@grupo-meme.demo	Luisa Ramírez	Solicitante	SAN ANTONIO	Administradora de Finca	\N	t	2026-11-10 02:13:05.543373+00
U10	u10@grupo-meme.demo	Héctor Cano	Solicitante	TASINSA	Supervisor de Planta	\N	t	2026-11-10 02:13:05.543373+00
U04	u04@grupo-meme.demo	Jorge Castillo	Aprobador N1	SUPREMA	Gerente de Planta	\N	t	2026-11-10 02:13:05.543373+00
U05	u05@grupo-meme.demo	Sofía Herrera	Aprobador N1	PALMAS	Gerente de Planta	\N	t	2026-11-10 02:13:05.543373+00
U06	u06@grupo-meme.demo	Diego Monterroso	Aprobador N1	SAN ANTONIO	Gerente Agrícola	\N	t	2026-11-10 02:13:05.543373+00
U09	u09@grupo-meme.demo	Pedro Juárez	Aprobador N1	TASINSA	Gerente de Planta	\N	t	2026-11-10 02:13:05.543373+00
U07	u07@grupo-meme.demo	Roberto Aldana	Aprobador N2	TODAS	Director de Operaciones	\N	t	2026-11-10 02:13:05.543373+00
U08	u08@grupo-meme.demo	Marta Solís	Bodega	TODAS	Encargada de Bodega Central	\N	t	2026-11-10 02:13:05.543373+00
U11	u11@grupo-meme.demo	Lucía Ortiz	Compras	TODAS	Compras Corporativas (servicios)	\N	t	2026-11-10 02:13:05.543373+00
ADMIN	admin@grupo-meme.demo	Admin Pide Justo	Admin	TODAS	Administrador del sistema	\N	t	2026-11-10 02:13:05.550352+00
DIR	direccion@grupo-meme.demo	Dirección de Operaciones	Aprobador N3	TODAS	Dirección	\N	t	2026-11-10 14:22:13.919916+00
RONALDMASELLI	ronald.maselli@grupomeme.com.gt	Ronald	Solicitante	SUPREMA	Solicitante de TI	\N	t	2026-11-10 14:47:27.310389+00
\.


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: -
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 3, true);


--
-- Name: articulos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.articulos_id_seq', 1793, true);


--
-- Name: bitacora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bitacora_id_seq', 33, true);


--
-- Name: bodegas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bodegas_id_seq', 12, true);


--
-- Name: consumo_trimestral_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.consumo_trimestral_id_seq', 1793, true);


--
-- Name: ejecucion_presupuesto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ejecucion_presupuesto_id_seq', 2, true);


--
-- Name: existencias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.existencias_id_seq', 1793, true);


--
-- Name: homologacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.homologacion_id_seq', 417, true);


--
-- Name: matriz_aprobacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.matriz_aprobacion_id_seq', 3, true);


--
-- Name: matriz_contable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.matriz_contable_id_seq', 2339, true);


--
-- Name: parametros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.parametros_id_seq', 1, true);


--
-- Name: sap_post_lines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sap_post_lines_id_seq', 4, true);


--
-- Name: series_documento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.series_documento_id_seq', 12, true);


--
-- Name: solicitud_lineas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solicitud_lineas_id_seq', 7, true);


--
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: -
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- Name: articulos articulos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articulos
    ADD CONSTRAINT articulos_pkey PRIMARY KEY (id);


--
-- Name: bitacora bitacora_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bitacora
    ADD CONSTRAINT bitacora_pkey PRIMARY KEY (id);


--
-- Name: bodegas bodegas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT bodegas_pkey PRIMARY KEY (id);


--
-- Name: categoria_cuenta categoria_cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria_cuenta
    ADD CONSTRAINT categoria_cuenta_pkey PRIMARY KEY (categoria);


--
-- Name: consumo_trimestral consumo_trimestral_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_trimestral
    ADD CONSTRAINT consumo_trimestral_pkey PRIMARY KEY (id);


--
-- Name: cuentas_contables cuentas_contables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cuentas_contables
    ADD CONSTRAINT cuentas_contables_pkey PRIMARY KEY (codigo);


--
-- Name: ejecucion_presupuesto ejecucion_presupuesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ejecucion_presupuesto
    ADD CONSTRAINT ejecucion_presupuesto_pkey PRIMARY KEY (id);


--
-- Name: empresas empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_pkey PRIMARY KEY (codigo);


--
-- Name: existencias existencias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.existencias
    ADD CONSTRAINT existencias_pkey PRIMARY KEY (id);


--
-- Name: homologacion homologacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.homologacion
    ADD CONSTRAINT homologacion_pkey PRIMARY KEY (id);


--
-- Name: matriz_aprobacion matriz_aprobacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriz_aprobacion
    ADD CONSTRAINT matriz_aprobacion_pkey PRIMARY KEY (id);


--
-- Name: matriz_contable matriz_contable_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriz_contable
    ADD CONSTRAINT matriz_contable_pkey PRIMARY KEY (id);


--
-- Name: niveles_aprobacion niveles_aprobacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.niveles_aprobacion
    ADD CONSTRAINT niveles_aprobacion_pkey PRIMARY KEY (codigo);


--
-- Name: parametros parametros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parametros
    ADD CONSTRAINT parametros_pkey PRIMARY KEY (id);


--
-- Name: sap_post_lines sap_post_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sap_post_lines
    ADD CONSTRAINT sap_post_lines_pkey PRIMARY KEY (id);


--
-- Name: sequences sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (name);


--
-- Name: series_documento series_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_documento
    ADD CONSTRAINT series_documento_pkey PRIMARY KEY (id);


--
-- Name: solicitud_lineas solicitud_lineas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solicitud_lineas
    ADD CONSTRAINT solicitud_lineas_pkey PRIMARY KEY (id);


--
-- Name: solicitudes solicitudes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solicitudes
    ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id);


--
-- Name: tipos_documento tipos_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_documento
    ADD CONSTRAINT tipos_documento_pkey PRIMARY KEY (codigo);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: articulos_emp_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX articulos_emp_code ON public.articulos USING btree (empresa, item_code);


--
-- Name: bodegas_emp_codigo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX bodegas_emp_codigo ON public.bodegas USING btree (empresa, codigo);


--
-- Name: consumo_emp_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX consumo_emp_code ON public.consumo_trimestral USING btree (empresa, item_code);


--
-- Name: existencias_emp_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX existencias_emp_code ON public.existencias USING btree (empresa, item_code);


--
-- Name: series_emp_tipo_bod; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX series_emp_tipo_bod ON public.series_documento USING btree (empresa, tipo_codigo, bodega_codigo);


--
-- PostgreSQL database dump complete
--

\unrestrict af2xOIEeNufV0iDfuvxUAry9xbQ1iArh4SSjEAJcr6kdx19TOEml0Ubo67IffkM

