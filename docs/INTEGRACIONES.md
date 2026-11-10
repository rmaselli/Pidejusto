# Integraciones · Pide Justo

## Microsoft 365 (Entra ID)

1. En [portal.azure.com](https://portal.azure.com) → **Microsoft Entra ID** → **Registros de aplicaciones** → Nueva.
2. Redirect URI (Web): `http://localhost:4000/auth/callback` (y el de producción).
3. Crea un **secreto de cliente**.
4. Permisos de API: Microsoft Graph `openid`, `profile`, `email`, `User.Read` (delegados).
5. Variables:

```env
AUTH_MODE=azure
AZURE_AD_CLIENT_ID=<app-id>
AZURE_AD_CLIENT_SECRET=<secret>
AZURE_AD_TENANT_ID=<tenant-id>
AZURE_AD_REDIRECT_URI=http://localhost:4000/auth/callback
WEB_URL=http://localhost:3000
```

Flujo: el navegador va a `/auth/login` → Microsoft → `/auth/callback` → cookie de sesión → redirect a `WEB_URL`.

Si el email no existe en `users`, se crea como **Solicitante** de SUPREMA. Un **Admin** ajusta rol/empresa en `/admin/usuarios`.

Modo local sin Azure: `AUTH_MODE=demo`.

## SAP Business One Service Layer

Puerto desacoplado (`SapProvider`):

| Método | Mock (Postgres seed) | HTTP (Service Layer) |
|--------|----------------------|----------------------|
| `articulos` | tabla `articulos` | `GET /b1s/v2/Items` |
| `existencias` | `existencias` | `Items?...ItemWarehouseInfoCollection` |
| `consumo` | `consumo_trimestral` | `SQLQueries('ConsumoTrimestral')/List` |
| `presupuesto` | params + ejecución | `BudgetScenarios` |
| `contable` | cuentas + matriz | `ChartOfAccounts` |
| `matriz` | `matriz_aprobacion` | `ApprovalTemplates` |
| `postSolicitudCompra` | `sap_post_lines` + DocNum | `POST /b1s/v2/PurchaseRequests` |

```env
SAP_PROVIDER=mock   # default
# o
SAP_PROVIDER=http
SAP_BASE_URL=https://<host-en-construccion>
SAP_COMPANY_DB=...
SAP_USERNAME=...
SAP_PASSWORD=...
SAP_TIMEOUT_MS=15000
```

La URL puede estar en construcción: las peticiones están implementadas. Si el upstream no responde, la API devuelve **503** con código `SapUpstreamUnavailable` y el resto de la app sigue operativa con maestros locales.

Estado en vivo: `GET /api/sap/status` (autenticado).

## Claude (Anthropic)

```env
ANTHROPIC_API_KEY=sk-ant-...
```

Endpoints: `/api/ai/search`, `/api/ai/mrp`, `/api/ai/resumen`.  
Sin key → motor local rotulado (mismo contrato de salida que el MVP HTML).
