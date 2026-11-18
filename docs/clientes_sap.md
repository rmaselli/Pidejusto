# SAP API Gateway — Guía técnica para aplicaciones cliente

Esta guía es para los equipos que integran una aplicación con SAP Business One a través del gateway.
La aplicación nunca conoce la URL, el usuario ni la contraseña de SAP: se autentica con una **API Key**
y elige la **empresa** SAP con una cabecera.

- URL base: `https://sapgateway.grupomeme.com.gt`
- Prefijo de la API: `/api/v1`
- Formato: JSON en UTF-8; TLS obligatorio (HTTP plano no está publicado)
- Especificación OpenAPI: [`docs/openapi/business.yaml`](../openapi/business.yaml)

## 1. Antes de empezar

IT le entrega:

| Dato | Ejemplo | Uso |
|---|---|---|
| API Key | `spk_live_…` | Autenticación. Se muestra **una sola vez** al crearla: guárdela en un gestor de secretos |
| Código(s) de empresa | `AGRICOLA` | Valor de la cabecera `X-Company` |
| Endpoints habilitados | `stock`, `sales_orders.create` | Lo que su aplicación puede invocar; el resto responde `403` |
| Límite por hora | `1000` | Peticiones por hora para su aplicación |

La llave identifica a la **aplicación**, no a un usuario. No la incruste en código de navegador ni en apps
móviles: úsela solo desde un servidor.

## 2. Cabeceras

| Cabecera | Obligatoria | Descripción |
|---|---|---|
| `X-API-KEY: spk_live_…` | Sí (o la siguiente) | API Key de la aplicación |
| `Authorization: Bearer spk_live_…` | Alternativa | Equivale a `X-API-KEY`; si vienen ambas, gana `X-API-KEY` |
| `X-Company: AGRICOLA` | Sí | Empresa SAP destino (no distingue mayúsculas). Alternativa: parámetro `?company=AGRICOLA` |
| `Idempotency-Key` | En toda escritura | 8 a 64 caracteres `[A-Za-z0-9_-]`. Recomendado: un UUID por operación de negocio |
| `Content-Type: application/json` | En escrituras | |
| `X-Request-Id` | No | Identificador propio de correlación (1 a 64 caracteres `[A-Za-z0-9_.-]`); si no lo envía o no es válido, el gateway genera uno |
| `Prefer` | No | Solo en la pasarela OData; se reenvía a SAP (p. ej. `odata.maxpagesize=100`) |

Cabeceras de respuesta:

| Cabecera | Descripción |
|---|---|
| `X-Request-Id` | Identificador de la petición. **Inclúyalo siempre al reportar un problema** |
| `X-RateLimit-Limit` / `X-RateLimit-Remaining` | Límite por hora y peticiones restantes en la ventana actual |
| `Retry-After` | Solo con `429`: segundos hasta que se reinicia la ventana |
| `Idempotent-Replay: true` | La respuesta es la de una ejecución anterior con la misma `Idempotency-Key` |

## 3. Formato de respuesta

Éxito:

```json
{ "success": true, "data": { … }, "requestId": "req_44abedb0a4b72a15120c455a" }
```

Error:

```json
{
  "success": false,
  "error": "SAP_UNAVAILABLE",
  "message": "No se pudo conectar con SAP",
  "sapStatus": 401,
  "detail": "SAP rechazó el inicio de sesión (HTTP 401): Invalid login or password",
  "outcome": "unknown",
  "requestId": "req_…"
}
```

- `error` es un código estable: programe contra él, no contra `message`.
- `sapStatus` (si SAP respondió) y `detail` aparecen solo en fallos relacionados con SAP. `detail` nunca contiene
hosts ni IP.
- `outcome: "unknown"` aparece solo en un `504`/`502` de una escritura: la operación **pudo** ejecutarse en SAP
(ver sección 6).

## 4. Pasarela OData (consultas a SAP)

```
GET /api/v1/odata/{Entidad}[({clave})][/{relación}|/$count][?consulta OData]
```

El gateway reenvía la consulta al Service Layer de la empresa indicada, **solo** para las entidades que IT haya
habilitado en la lista blanca y que su aplicación tenga permitidas. Entidades habilitadas de inicio (solo lectura):

| Endpoint | Entidad | `$expand` permitido |
|---|---|---|
| `stock` | `Items` | `ItemWarehouseInfoCollection` |
| `warehouses` | `Warehouses` | — |
| `business-partners` | `BusinessPartners` | — |

Reglas:

- Se admiten `$filter`, `$select`, `$orderby`, `$top`, `$skip`, `$count` y `$expand` (este último solo con las
relaciones permitidas para la entidad, sin expansiones anidadas).
- `$top` se limita a **1000** (valor configurable por IT); un valor mayor se reduce sin error.
- Las rutas a subrecursos deben estar en la lista de relaciones permitidas; `Login` y `Logout` nunca se reenvían.
- La paginación de SAP (`odata.nextLink` / `@odata.nextLink`) se reescribe para apuntar al gateway: siga el enlace
tal cual, con las mismas cabeceras.
- La respuesta de SAP llega dentro de `data` sin transformar.

Ejemplos:

```bash
BASE=https://sapgateway.grupomeme.com.gt
H=(-H "X-API-KEY: $SGW_KEY" -H "X-Company: AGRICOLA")

# Existencias de un artículo por almacén
curl "$BASE/api/v1/odata/Items('A001')?\$select=ItemCode,ItemName,QuantityOnStock&\$expand=ItemWarehouseInfoCollection" "${H[@]}"

# Artículos con existencia, 50 por página
curl "$BASE/api/v1/odata/Items?\$filter=QuantityOnStock%20gt%200&\$select=ItemCode,ItemName,QuantityOnStock&\$top=50" "${H[@]}"

# Cantidad de clientes
curl "$BASE/api/v1/odata/BusinessPartners/\$count?\$filter=CardType%20eq%20'cCustomer'" "${H[@]}"
```

Escrituras por la pasarela: solo si IT habilitó escritura en esa entidad (`POST`, `PATCH`, `PUT` o `DELETE`).
Exigen `Idempotency-Key` y siguen las reglas de la sección 6. La huella incluye método, ruta, consulta y cuerpo.

## 5. Endpoints de negocio

Endpoints con contrato propio, validados por el gateway antes de llegar a SAP. Ambos crean un documento y
devuelven `201` con `{ "docEntry": …, "docNum": … }`. El JSON es estricto: campos desconocidos o datos sobrantes
dan `400`.

### 5.1 Crear orden de venta — `POST /api/v1/sales-orders`

Endpoint: `sales_orders.create` → entidad SAP `Orders`.

| Campo | Tipo | Oblig. | Reglas | Campo SAP |
|---|---|---|---|---|
| `customerCode` | string | Sí | máx. 50 | `CardCode` |
| `docDate` | `AAAA-MM-DD` | No | | `DocDate` |
| `dueDate` | `AAAA-MM-DD` | Sí | | `DocDueDate` |
| `externalRef` | string | No | máx. 100 (p. ej. número de pedido de su sistema) | `NumAtCard` |
| `comments` | string | No | máx. 254 | `Comments` |
| `lines[]` | array | Sí | 1 a 500 líneas | `DocumentLines` |
| `lines[].itemCode` | string | Sí | máx. 50 | `ItemCode` |
| `lines[].quantity` | número | Sí | > 0 | `Quantity` |
| `lines[].warehouse` | string | Sí | máx. 8 | `WarehouseCode` |
| `lines[].unitPrice` | número | No | ≥ 0; si se omite, SAP aplica la lista de precios | `UnitPrice` |

```bash
curl -X POST "$BASE/api/v1/sales-orders" "${H[@]}" \
  -H "Idempotency-Key: $(uuidgen)" -H "Content-Type: application/json" \
  -d '{"customerCode":"C0001","dueDate":"2026-12-31","externalRef":"PED-1",
       "lines":[{"itemCode":"A001","quantity":10,"warehouse":"01"}]}'
```

```json
{ "success": true, "data": { "docEntry": 1532, "docNum": 20451 }, "requestId": "req_…" }
```

### 5.2 Crear solicitud de compra — `POST /api/v1/purchase-requests`

Endpoint: `purchase_requests.create` → entidad SAP `PurchaseRequests` (reabastecimiento de bodega).

| Campo | Tipo | Oblig. | Reglas | Campo SAP |
|---|---|---|---|---|
| `requiredDate` | `AAAA-MM-DD` | Sí | | `RequriedDate` (así lo escribe SAP) |
| `externalRef` | string | No | se agrega a los comentarios como `[ref: …]` | `Comments` |
| `comments` | string | No | `comments` + `externalRef` ≤ 254 | `Comments` |
| `lines[]` | array | Sí | 1 a 500 líneas | `DocumentLines` |
| `lines[].itemCode` | string | Sí | máx. 50 | `ItemCode` |
| `lines[].quantity` | número | Sí | > 0 | `Quantity` |
| `lines[].warehouse` | string | Sí | máx. 8 | `WarehouseCode` |
| `lines[].requiredDate` | `AAAA-MM-DD` | No | | `RequiredDate` |

```bash
curl -X POST "$BASE/api/v1/purchase-requests" "${H[@]}" \
  -H "Idempotency-Key: $(uuidgen)" -H "Content-Type: application/json" \
  -d '{"requiredDate":"2026-12-31","lines":[{"itemCode":"A001","quantity":200,"warehouse":"01"}]}'
```

## 6. Idempotencia y reintentos (lea esto antes de escribir)

Toda escritura exige `Idempotency-Key`. El gateway la asocia a su aplicación, la empresa y el endpoint.

| Situación | Resultado |
|---|---|
| Primera vez | Se ejecuta en SAP; `201` (o el estado correspondiente) |
| Reintento con la **misma llave y el mismo cuerpo** | Mismo resultado original, `Idempotent-Replay: true`. No se crea otro documento |
| Misma llave, **otro cuerpo** | `422 IDEMPOTENCY_KEY_REUSED` |
| Misma llave mientras la primera sigue en curso | `409 IDEMPOTENCY_IN_PROGRESS`: espere y reintente |
| SAP rechazó la operación (`4xx`) o no se pudo conectar | La llave se libera: puede corregir y reintentar con la misma llave |
| SAP no respondió a tiempo / se cortó la conexión | `504 SAP_TIMEOUT` (o `502` si se cortó la conexión) con `"outcome": "unknown"`: **la operación pudo ejecutarse** |

- La llave se recuerda **72 horas**. Pasado ese plazo, el mismo envío se trata como una operación nueva.
- El cuerpo se compara en forma canónica: el orden de los campos y los espacios no importan.
- **El gateway nunca reintenta una escritura por su cuenta.**

Ante `outcome: "unknown"`, **reintente con la misma** `Idempotency-Key`:

- Si IT configuró la reconciliación (campo `U_SGW_IDEM` en SAP), el gateway busca en SAP el documento creado con esa
llave: si existe, responde con él (`Idempotent-Replay: true`); si no, lo crea.
- Si no está configurada, el reintento vuelve a dar `504 outcome unknown`: verifique en SAP (por `externalRef`) antes
de usar una llave nueva.

Política de reintentos recomendada:

| Código | ¿Reintentar? |
|---|---|
| `409 IDEMPOTENCY_IN_PROGRESS`, `429`, `502`, `504` | Sí, con la **misma** llave y espera exponencial (p. ej. 2 s, 4 s, 8 s… máx. 5 intentos); en `429` respete `Retry-After` |
| `400`, `401`, `403`, `404`, `413`, `422` | No: corrija la petición o la configuración |
| `500` | Una vez; si persiste, repórtelo con el `requestId` |

## 7. Límite de peticiones

Ventana fija de **una hora** por aplicación (`1000` por defecto; IT puede cambiarlo). Al superarlo: `429 RATE_LIMITED` con `Retry-After`. El límite se cuenta por aplicación, no por llave ni por empresa, e incluye las
peticiones rechazadas por permisos. Los contadores se reinician si el gateway se reinicia.

## 8. Catálogo de errores

| HTTP | `error` | Causa | Acción |
|---|---|---|---|
| 400 | `BAD_REQUEST` | JSON inválido, campos desconocidos, ruta u OData no permitidos | Corregir la petición |
| 400 | `COMPANY_REQUIRED` | Falta `X-Company` | Enviar la empresa |
| 400 | `IDEMPOTENCY_KEY_REQUIRED` | Escritura sin `Idempotency-Key` válida | Enviar una llave de 8 a 64 caracteres |
| 401 | `UNAUTHORIZED` | Llave ausente, inválida, revocada o vencida (siempre el mismo mensaje) | Revisar la llave con IT |
| 403 | `APPLICATION_DISABLED` | La aplicación está desactivada | IT |
| 403 | `FORBIDDEN` | Sin permiso para el endpoint, el método o la escritura | Pedir el permiso a IT |
| 403 | `COMPANY_NOT_ALLOWED` | Empresa inexistente, inactiva o no asignada a su aplicación | Revisar el código con IT |
| 403 | `ENDPOINT_DISABLED` | El endpoint está desactivado | IT |
| 404 | `ENDPOINT_NOT_FOUND` | La entidad OData no está en la lista blanca | Pedir su alta a IT |
| 404 | `SAP_NOT_FOUND` | SAP no encontró el registro (p. ej. clave inexistente) | — |
| 409 | `IDEMPOTENCY_IN_PROGRESS` | Misma llave en curso | Reintentar luego |
| 413 | `PAYLOAD_TOO_LARGE` | Cuerpo mayor de 1 MiB | Dividir la operación |
| 422 | `VALIDATION_ERROR` | Regla de los endpoints de negocio (el mensaje indica el campo) | Corregir los datos |
| 422 | `SAP_REJECTED` | SAP rechazó los datos (el mensaje es el de SAP: artículo inexistente, stock, etc.) | Corregir los datos |
| 422 | `IDEMPOTENCY_KEY_REUSED` | Misma llave con otro cuerpo | Usar una llave nueva para una operación distinta |
| 429 | `RATE_LIMITED` | Límite por hora superado | Esperar `Retry-After` |
| 500 | `INTERNAL_ERROR` | Error inesperado del gateway (la causa queda registrada) | Reportar con `requestId` |
| 502 | `SAP_ERROR` | SAP respondió con un error 5xx | Reintentar |
| 502 | `SAP_UNAVAILABLE` | No se pudo conectar o iniciar sesión en SAP (`detail` dice por qué) | Reintentar; si persiste, IT |
| 504 | `SAP_TIMEOUT` | SAP no respondió a tiempo (30 s por defecto) | Ver sección 6 si es escritura |

## 9. Buenas prácticas

- Genere una `Idempotency-Key` por **operación de negocio** (no por intento) y guárdela junto con su pedido.
- Envíe `externalRef` con su identificador interno: permite encontrar el documento en SAP.
- Use `$select` y `$top` en las consultas: reduce el tiempo de SAP y el consumo de su límite.
- Registre el `X-Request-Id` de cada respuesta; con él IT encuentra la traza completa.
- Rote la llave periódicamente: IT puede crear una nueva, usted cambia y después se revoca la anterior.
- No interprete `message` (puede cambiar de redacción); use `error` y el código HTTP.

## 10. Ejemplo de cliente (Node.js 18+)

```js
import { randomUUID } from "node:crypto";

const BASE = "https://sapgateway.grupomeme.com.gt";
const headers = { "X-API-KEY": process.env.SGW_KEY, "X-Company": "AGRICOLA" };

export async function crearOrden(orden, idemKey = randomUUID()) {
  for (let intento = 1; intento <= 5; intento++) {
    const res = await fetch(`${BASE}/api/v1/sales-orders`, {
      method: "POST",
      headers: { ...headers, "Content-Type": "application/json", "Idempotency-Key": idemKey },
      body: JSON.stringify(orden),
    });
    const body = await res.json();
    if (body.success) return body.data;                       // { docEntry, docNum }
    const reintentable = [409, 429, 502, 504].includes(res.status);
    if (!reintentable || intento === 5) {
      throw Object.assign(new Error(body.message), { code: body.error, requestId: body.requestId, idemKey });
    }
    const espera = Number(res.headers.get("Retry-After")) * 1000 || 2 ** intento * 1000;
    await new Promise((r) => setTimeout(r, espera));          // misma idemKey en cada intento
  }
}
```

## 11. Soporte

Reporte a IT: `requestId`, hora aproximada, endpoint, empresa y, en escrituras, la `Idempotency-Key`.
Nunca envíe la API Key por correo o chat.



12. Documentación Referencia de API

[https://sap.grupomeme.com.gt:50000/Service%20Layer%20API%20Reference.html](https://sap.grupomeme.com.gt:50000/Service%20Layer%20API%20Reference.html)

[Document History | SAP Help Portal](https://help.sap.com/docs/SAP_BUSINESS_ONE/f110a154dd0f4c20bf7f3ebca9eeb794/894666ccf6bc4b8a9fb681b23b5a8da8.html)
