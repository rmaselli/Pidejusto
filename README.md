# Pide Justo

Portal de solicitud de materiales para Grupo M.E.M.E.  
Stack: **Next.js + shadcn/Tailwind · Express · PostgreSQL · Drizzle · MS365 OAuth · Docker**.

## Estructura

```
apps/web          Next.js (portal + app móvil /m)
apps/api          Express API
packages/shared   Tipos y reglas de negocio (portadas del MVP HTML)
packages/db       Drizzle schema, migraciones y seed (Excel v3)
```

## Arranque rápido (Docker)

```bash
cp .env.example .env
docker compose up --build
```

- Web: http://localhost:3000  
- API: http://localhost:4000  
- Postgres: localhost:5432  

Login por defecto: `AUTH_MODE=demo` (selector de usuarios sembrados).

## Desarrollo local

```bash
cp .env.example .env
docker compose up db -d
npm install
npm run build -w @pidejusto/shared
npm run migrate -w @pidejusto/db
npm run seed -w @pidejusto/db
npm run dev:api
npm run dev:web
```

## Roles

| Rol | Capacidades |
|-----|-------------|
| Solicitante | Crear solicitudes |
| Aprobador N1 | Aprobar/rechazar N1 de su empresa + presupuesto |
| Aprobador N2 | Aprobar/rechazar N2 global + presupuesto |
| Bodega | Consolidar y enviar a SAP |
| Admin | Usuarios y métricas |

## Autenticación MS365

1. Registra una app en Entra ID (redirect `http://localhost:4000/auth/callback`).
2. En `.env`:

```
AUTH_MODE=azure
AZURE_AD_CLIENT_ID=...
AZURE_AD_CLIENT_SECRET=...
AZURE_AD_TENANT_ID=...
```

Usuarios nuevos se aprovisionan como `Solicitante`; un Admin puede elevar roles en `/admin/usuarios`.

## Integración SAP

```
SAP_PROVIDER=mock   # lee maestros de Postgres (seed Excel v3)
SAP_PROVIDER=http   # llama a SAP_BASE_URL Service Layer
SAP_BASE_URL=https://...   # URL en construcción: las peticiones quedan abiertas
```

Contrato: `articulos`, `existencias`, `consumo`, `presupuesto`, `contable`, `matriz`, `postSolicitudCompra`.  
Si el upstream falla → `503 SapUpstreamUnavailable` sin tumbar el resto de la app.

## Claude

Opcional: `ANTHROPIC_API_KEY`. Si falta, los 3 puntos de IA usan motor local rotulado.
