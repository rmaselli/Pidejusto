# Prompt maestro · "Pide Justo" · Hakatón 2026 · Reto 1 · Equipo 1 The Disruptors

> Copia este prompt completo en Claude para reconstruir, ampliar o explicar el MVP.

---

## 1. Rol y contexto

Actúa como desarrollador full-stack y analista de procesos de compras de **Grupo MEME** (Guatemala), grupo con varias plantas: **Suprema (SUP), Palmas (PAL), Metalmecánica (MET) y Tasinsa (TAS)**. Trabajamos con **SAP Business One** y tenemos pocas licencias.

Estamos en un hakatón de un día. Hay que construir un **MVP funcional** con demo en vivo del flujo completo y con datos reales de prueba. Una maqueta sin lógica no cuenta.

**Problema actual**

- Cada planta pide en su propio Excel. Luego bodega consolida todo y lo digita en SAP, porque hay pocas licencias.
- Nadie ve existencias, mínimos ni máximos reales al pedir, así que se pide de más.
- Compras no sabe si lo pedido está en presupuesto ni si está aprobado.

**Objetivo del MVP**

Un portal de solicitud de materiales que:

- Muestra el inventario de SAP al momento de pedir.
- Evita sobrepedidos.
- Valida contra presupuesto.
- Aprueba en 2 niveles según monto.
- Entrega a bodega un consolidado listo para SAP.

Todo esto **sin licencia SAP para el solicitante**.

**Resultado mínimo que el jurado debe ver:**
Solicitud digital → alerta de existencia → validación de presupuesto → aprobación N1/N2 → consolidado "enviado" a SAP.

## 2. Reglas del hakatón (restricciones obligatorias)

1. SAP B1 y presupuesto se simulan con un **Excel que hace de API**: hojas de lectura más una hoja de salida.
2. La **capa de datos debe estar desacoplada**: mañana se cambia el Excel por SAP B1 **Service Layer** sin rehacer pantallas.
3. **Claude es obligatorio y visible** en al menos un punto del flujo.
4. No se usan licencias SAP adicionales por usuario.
5. Criterios de evaluación: reducción de tiempo 30%, costos 30%, uso de IA 20%, presentación 20%.

## 3. Entregables

1. **Excel "SAP_API_Simulada_Equipo1.xlsx"** con 7 hojas (ver sección 4), con datos realistas y escenarios de demo preparados.
2. **Aplicación web de un solo archivo HTML**, con CSS y JS en línea y **SheetJS** (xlsx 0.18.5 desde cdnjs) para leer y escribir Excel. Debe funcionar en escritorio y celular (≈400 px), en tema claro y oscuro, y en español.

## 4. Modelo de datos (Excel = API simulada)

| Hoja | Columnas | Uso |
|---|---|---|
| **Articulos** | ItemCode, ItemName, Familia, UM, CostoPromedio_Q, CuentaPresupuesto, NombreCuenta, LeadTimeDias, MultiploCompra | Catálogo SAP (GET) |
| **Existencias** | ItemCode, WhsCode, Planta, Existencia, EnPedido, Comprometido, Minimo, Maximo | Stock por planta (GET) |
| **Consumo** | ItemCode, WhsCode, Mes (YYYY-MM), Cantidad | 6 meses de consumo para sugerir cantidad (GET) |
| **Presupuesto** | WhsCode, Planta, CentroCosto, CuentaPresupuesto, NombreCuenta, Periodo, Presupuestado_Q, Ejecutado_Q, Comprometido_Q | Validación por planta + cuenta + mes (GET) |
| **Usuarios** | UserId, Nombre, Rol (Solicitante / Aprobador N1 / Aprobador N2 / Bodega), WhsCode (o TODAS), Puesto, Email | Roles (GET) |
| **MatrizAprobacion** | Regla, MontoDesde_Q, MontoHasta_Q, DentroPresupuesto (SI/NO/CUALQUIERA), NivelesRequeridos (N1 / N1+N2), Descripcion | Reglas de aprobación (GET) |
| **SolicitudCompra_POST** | DocNum, DocDate, RequiredDate, Requester, ItemCode, ItemDescription, Quantity, UoM, WarehouseCode, CostingCode, AccountCode, UnitPrice_Q, LineTotal_Q, SolicitudesOrigen, Comments | Hoja de salida hacia SAP (POST) |

**Datos de ejemplo**

- ~30 artículos MRO en 5 cuentas presupuestarias: 6101 Repuestos, 6102 Lubricantes, 6103 EPP, 6104 Limpieza y 6105 Ferretería.
- Precios en quetzales.
- 4 plantas.
- Presupuesto de sep a dic 2026.
- 10 usuarios ficticios.

**Escenarios preparados en Suprema**

- **Guantes de nitrilo EPP-0001:** existencia 180, en pedido 60, comprometido 20, mín 60, máx 250, múltiplo 10. Pedir 100 dispara la alerta y el sistema sugiere 30.
- **Rodamiento 6205 REP-0001:** existencia 3, comprometido 1, mín 12, máx 40, múltiplo 2. Está bajo mínimo y el sistema sugiere 38.
- **Motor 5 HP REP-0006:** Q 6,800, mín 1, máx 1. La cuenta 6101 de SUP en 2026-09 tiene presupuestado 30,000, ejecutado 20,500 y comprometido 4,200, o sea Q 5,300 disponibles. El motor excede el presupuesto y la solicitud escala a N2.

**Matriz de aprobación**

- **R1:** dentro de presupuesto, cualquier monto → **aprobación automática**, pasa directo a Bodega (materiales) o Compras (servicios).
- **R2:** excede presupuesto y el total es hasta Q 10,000 → N1.
- **R3:** excede presupuesto y el total supera Q 10,000 → N1 + N2.

## 5. Arquitectura: capa de datos desacoplada

La interfaz **solo** llama a un objeto `api` con este contrato:

```
articulos() · existencias() · consumo() · presupuesto() · usuarios() · matriz()
postSolicitudCompra(rows) → {ok, docNums}
```

- **ExcelApi** (activo): trae datos de ejemplo embebidos y permite cargar otro .xlsx con las mismas hojas. Escribe en `SolicitudCompra_POST` y exporta el libro.
- **ServiceLayerApi** (siguiente paso): tiene el mismo contrato. Así se mapea cada método:
  - `articulos()` → `GET /b1s/v2/Items`
  - `existencias()` → `Items('{code}')/ItemWarehouseInfoCollection` (InStock, Ordered, Committed, MinimalStock, MaximalStock)
  - `consumo()` → `SQLQueries('ConsumoMensual')/List`
  - `presupuesto()` → `BudgetScenarios` / `Budgets`
  - `usuarios()` → `Users` + `EmployeesInfo`
  - `matriz()` → `ApprovalTemplates`
  - `postSolicitudCompra()` → `POST /b1s/v2/PurchaseRequests`

Las solicitudes y la bitácora viven en memoria y se guardan en localStorage. Debe haber un botón para reiniciar la demo.

## 6. Reglas de negocio (fórmulas exactas)

- **Disponible** = Existencia + EnPedido − Comprometido.
- **En solicitudes abiertas** = suma de cantidades del mismo artículo y planta en solicitudes con estado Pendiente N1, Pendiente N2 o Aprobada. Esto evita pedir dos veces lo mismo. También suma lo que ya está en el carrito actual.
- **Base proyectada** = Disponible + En solicitudes abiertas.
- **Cantidad sugerida** = `floor((Máximo − Base) / Múltiplo) × Múltiplo`, con mínimo 0. Si da 0 y la base está bajo el mínimo, la sugerida es 1 múltiplo.
- **Cobertura (meses)** = Base / consumo promedio mensual de los últimos 6 meses.
- **Alerta anti-sobrepedido**:
  - Si Base + cantidad > Máximo, o si la sugerida es 0 y se pide algo → **"Sobre máximo"**. Se exige una justificación escrita o usar la sugerida.
  - Si Base + cantidad < Mínimo → **"Cantidad corta"**.
  - En cualquier otro caso → **"En rango"**.
- **Transferencia entre plantas:** si otra planta tiene Disponible > su Máximo, se muestra una sugerencia de traslado antes de comprar.
- **Presupuesto** por planta + cuenta + periodo (mes actual): Disponible = Presupuestado − Ejecutado − Comprometido SAP − lo ya comprometido en solicitudes de la app (Pendiente, Aprobada y Enviada a SAP). La solicitud está **dentro** si cada cuenta cubre su monto.
- **Ruta de aprobación:** si está fuera de presupuesto → R3. Si no, se busca por monto → R1 o R2.
- **Estados:** Pendiente N1 → (Pendiente N2) → Aprobada → Enviada a SAP, o Rechazada. Rechazar exige comentario.
- **Bitácora:** cada acción guarda fecha y hora, usuario, acción y detalle. Incluye eventos del "Sistema", como la validación de presupuesto y el escalamiento a N2.
- **Consolidación de bodega:** se agrupan las solicitudes aprobadas seleccionadas por **planta + artículo**, se suman cantidades, se toma la fecha requerida más temprana y se listan las solicitudes de origen. Se genera un **DocNum por planta** (`SC-2026-0001`…), se escriben las filas en `SolicitudCompra_POST` y las solicitudes pasan a "Enviada a SAP" con su DocNum.
- **Sobrepedido evitado (Q):** cuando el usuario escribió una cantidad sobre el máximo y terminó agregando una menor, se calcula (intento − final) × costo.

## 7. Pantallas (pestañas)

Arriba a la derecha va un selector de usuario agrupado por rol, para simular personas distintas en la demo. También se muestra qué fuente de datos está activa.

1. **Solicitar** (Solicitante)
   - Buscador del catálogo con botón **"Buscar con Claude"**.
   - Ficha del artículo con: existencia, en pedido, comprometido, en solicitudes, mín/máx, consumo por mes, una barra visual de mín–máx con lo que se pide y la cobertura.
   - Botones "Usar sugerida" y **"Claude: ¿cuánto pedir?"**.
   - Carrito, panel de presupuesto por cuenta con medidor, ruta de aprobación calculada, fecha requerida, comentario y botón Enviar.
2. **Aprobar** (N1 ve su planta; N2 ve todas)
   - Tarjetas con chips de estado (con o sin presupuesto, con alerta de sobrepedido).
   - Detalle con líneas (pide / sugerido / disponible), presupuesto, ruta y bitácora.
   - Botón **"Resumen para aprobar con Claude"**, más Aprobar y Rechazar.
3. **Bodega → SAP**: casillas para elegir solicitudes aprobadas, consolidado por artículo, botón "Enviar a SAP", tabla de la hoja de salida, descarga .xlsx y copia en formato TSV.
4. **Seguimiento**: lista de todas o solo las mías, con la ruta visual por pasos y la bitácora completa.
5. **Métricas**: tiempo de solicitud a SAP (real, contra una línea base editable de 4 días), horas de consolidación liberadas (línea base editable de 6 h/semana × 52), % validado contra presupuesto (meta 100%), Q de sobrepedido evitado y conteo por estado.
6. **Datos y API**: fuente activa, filas por hoja, carga de otro Excel, descarga del libro actualizado, contrato y mapeo a Service Layer, y reinicio de la demo.

## 8. Uso de Claude (3 puntos visibles)

Claude se llama desde la página y responde en JSON cuando la respuesta es un dato. Si Claude no está disponible, la búsqueda por texto normal sigue funcionando.

1. **Búsqueda en lenguaje natural.** Se envía el catálogo (`código|descripción|familia|UM`) y el texto del usuario. Respuesta esperada: `{"items":[{"itemCode","cantidad"|null,"motivo"}]}`, con un máximo de 5 artículos. Ejemplo: *"necesito algo para limpiar el piso de la línea 2"*.
2. **Cantidad sugerida con explicación (MRP).** Se envían existencia, en pedido, comprometido, abiertas, mín, máx, los 6 meses de consumo, el lead time, el múltiplo y la fórmula base. Respuesta esperada: `{"cantidad", "explicacion" (máx. 2 frases con números)}`. Claude no debe superar el máximo salvo que la tendencia lo justifique.
3. **Resumen para el aprobador.** Se envían las líneas, las alertas, las justificaciones y el presupuesto. Claude responde con 4 viñetas de riesgo y termina con "Recomendación: Aprobar / Aprobar con ajuste / Rechazar". La respuesta aparece en pantalla mientras se escribe.

## 9. Guion de demo (5 min)

1. Ana (SUP) pide 100 cajas de guantes → alerta de sobrepedido → usa la sugerida (30) → **Q 6,650 evitados**.
2. Rodamiento 6205 bajo mínimo → sugerida 38 → Claude explica cuánto pedir.
3. Motor 5 HP (Q 6,800 contra Q 5,300 disponibles) → excede presupuesto → **escala a N2** (R3).
4. Jorge (N1) aprueba → Roberto (N2) lee el resumen de Claude y aprueba → la bitácora muestra cada paso.
5. Marta (Bodega) consolida → "Enviar a SAP" → DocNum SC-2026-000X → descarga `SolicitudCompra_POST.xlsx`.
6. Cierre en Métricas: tiempo de solicitud a SAP, horas de bodega liberadas, 100% validado y Q evitado.

## 10. Criterios de aceptación

- [ ] Los 8 obligatorios funcionan con datos: catálogo SAP, existencia/en pedido/mín/máx al pedir, alerta con cantidad sugerida, validación de presupuesto, aprobación en 2 niveles por monto, consolidado a hoja de salida, estados y trazabilidad, y Claude.
- [ ] La UI no lee el Excel directamente; todo pasa por `api`.
- [ ] Deseables incluidos: dashboard de métricas, sugerencia de transferencia entre plantas y capa lista para Service Layer.
- [ ] Sin errores en consola; se ve bien en celular y en tema oscuro.
- [ ] **Fuera de alcance:** órdenes de compra, cotizaciones, proveedores, recepción, pagos y módulo de presupuesto.

## 11. Siguientes pasos (para el pitch)

- Conectar ServiceLayerApi con SAP real (PurchaseRequests).
- Base de datos compartida para que solicitantes y aprobadores usen distintos dispositivos.
- Notificación a aprobadores.
- Reorden predictivo con estacionalidad.

---

# ADENDA v3 · Datos reales, contabilidad, dashboard y app móvil

> Esta adenda **reemplaza** lo que contradiga a las secciones 1–11: usa el Excel `SAP_API_Simulada_Equipo1_v3.xlsx` (datos reales por **Empresa**, consumo **trimestral**, Mín/Máx calculados). Los artículos de ejemplo de la sección 4 (EPP-0001, REP-0001, REP-0006) ya no existen; los escenarios de demo son los de 12.6.

## 12. Modelo de datos v3

- **Empresas:** SUPREMA, PALMAS, ACACIAS, ALFA, QUIRICA, SAN ANTONIO, SAN FRANCISCO, SAN JORGE, TASINSA, METALMECANICA, GRS, GABIOSA (hoja `Empresas` traduce cada una al nombre de las hojas del Anexo 2).
- **Hojas de lectura:** `Parametros`, `Articulos`, `Existencias`, `Consumo_Trimestral`, `EjecucionPresupuesto`, `Homologacion`, `Usuarios`, `MatrizAprobacion`, y las contables `Cuentas_Contables`, `Matriz_Contable`, `CategoriaCuenta`.
- **Mín/Máx** (idénticos a la hoja `MinMax_Trimestral`): clasificación por trimestres con compra (≥3 trimestres con compra = Regular; 2 = Intermitente; menos de 2 = Esporádico, sin Mín/Máx, “contra pedido”); `Mín = ROUNDUP(demanda diaria × lead time + Z × desv.est. × √(LT/91))`; `Máx = ROUNDUP(Mín + consumo prom. × MesesCobertura / 3)`.
- **Presupuesto** por Empresa + Categoría + `PeriodoPresupuesto`: Presupuestado = Σ(consumo prom. × precio); Disponible = Presupuestado − Ejecutado − Comprometido en solicitudes (Pendiente N1/N2, Aprobada, Enviada a SAP).
- **Matriz de aprobación:** R1 dentro de presupuesto → **aprobación automática** (pasa a Bodega); R2 fuera de presupuesto y ≤ Q 10,000 → N1; R3 fuera de presupuesto y > Q 10,000 → N1 + N2.
- **Hoja de salida** `SolicitudCompra_POST` (27 columnas) alineada a `PurchaseRequests.DocumentLines`: `AccountCode`, `CostingCode` (Dim1) … `CostingCode5` (Dim5), `ProjectCode`, más `PlacaVehiculo`, `ObraEnProceso`, `NoObraEspecifica`, `DetalleCompra`, `Validacion`.

## 13. Procedimiento contable (Instructivo + Anexo 1 + Anexo 2)

Cada línea del carrito lleva una **imputación contable** que debe pasar la misma validación del Anexo 1:

1. **Cuenta de mayor:** sugerida desde `CategoriaCuenta` (columna 6 = costo, 7 = gasto) y editable con la lista del Anexo 2. El prefijo 6 o 7 se elige según las combinaciones que existan para la empresa en la matriz.
2. **Centro de costos:** listas en cascada Departamento → Subdepartamento → (Ubicación · Línea/Producto · Proyecto) que solo ofrecen combinaciones permitidas en `Matriz_Contable` de la empresa.
3. **Validación (fórmula del Anexo 1):** llave = `1.er dígito de la cuenta + Depto + Subdepto + Línea + Producto + Proyecto + Empresa` buscada en `Matriz_Contable.Llave`. **La ubicación no forma parte de la llave.** Resultado: “✅ Correctamente” o “❌ Información incorrecta”. Con ❌ no se puede enviar.
4. **Campos condicionales:** `Placa` obligatoria si la cuenta es de vehículos (p. ej. 61302807 / 71302807); `Nº obra en proceso` y `Nº obra específica` obligatorios si la cuenta empieza por 1210 (Construcciones en proceso).
5. **Detalles específicos**, **Tipo de documento de respaldo** y **fecha requerida ≥ 10–15 días** (aviso, no bloqueo).
6. La validación contable se muestra en Solicitar, en el detalle del aprobador y en la hoja de salida; la consolidación de Bodega agrupa por **empresa + artículo + cuenta + dimensiones + proyecto** (no mezcla imputaciones distintas).
7. **Amarre presupuesto ↔ cuenta:** cada categoría presupuestaria apunta a una familia de cuenta (`CategoriaCuenta`); el dashboard puede agruparse y filtrarse por cuenta contable.

**Límites conocidos (decir en el pitch):** la matriz del Anexo 2 no tiene prefijo 1, así que 12100901 nunca valida; Acacias, Alfa, Quirica, San Antonio, San Francisco y San Jorge solo tienen cuentas 7; GABIOSA se asumió como la hoja “Gas Biologico”; el amarre Categoría → Cuenta es una **propuesta** a validar con Contabilidad; “Valor del documento” usa precio promedio SAP, no la cotización; salidas de mercadería, activos fijos y servicios quedan para la siguiente fase.

## 14. Dashboard de presupuesto (solo aprobadores N1 y N2)

- Pestaña visible **solo** para Aprobador N1 y N2 (se oculta para Solicitante, Bodega y Compras, y la vista está protegida aunque se fuerce). N1 queda fijado a su empresa; N2 ve todas.
- **Filtros dinámicos:** empresa, categoría, cuenta contable, estado de las solicitudes que comprometen, uso mínimo (%), y agrupación por categoría / empresa / cuenta. Clic en una barra filtra.
- **KPIs:** presupuesto, ejecutado (SAP), comprometido (solicitudes de la app), disponible, % consumido. Barras apiladas (ejecutado / comprometido / disponible, con marca de 100% si se excede), dona por estado de categorías (sana <70%, atención, crítica, excedida), solicitudes que más comprometen y tabla detalle presupuesto ↔ cuenta.

## 15. App móvil solo para aprobadores

- Archivo aparte, mobile-first. Solo permite entrar a usuarios N1/N2 (Solicitante y Bodega no aparecen).
- Pestañas: **Pendientes** (tarjetas con monto, ruta, alertas) → detalle a pantalla completa (líneas, presupuesto, imputación contable, bitácora) con **Resumen con Claude** y acciones **Aprobar / Rechazar** (rechazar exige comentario); **Presupuesto** (mismos filtros); **Historial**; **Cuenta**.
- Comparte el estado con la app de escritorio mediante la misma llave de `localStorage` (mismo sitio). Cada app recuerda su propio usuario activo. Entre dispositivos distintos se necesita base de datos compartida (siguiente paso) o el botón Exportar/Importar estado.

## 16. Identidad visual (Brandbook Grupo M.E.M.E. 2025)

Verde oscuro `#10312B` / `#255441`, verde `#006937` `#4C9C2E`, lima `#76BC21`, crema `#FFF3D9`, dorado `#B78B1E`. Tipografías **Bricolage Grotesque** (títulos) y **Montserrat** (texto), con fallback del sistema. Logo oficial en blanco sobre fondo verde (sin deformar, girar ni aplicar efectos), etiquetas tipo “pill” lima, esquinas redondeadas. Tono: directo, seguro, cercano (“Cada proceso cuenta”).

## 17. Claude en 3 puntos (sin cambios) + reglas de fallback

Si la llamada falla, cada punto cae a un **motor local rotulado** (“Motor local · sin conexión a Claude”) con el mismo formato de salida; nunca se hace pasar por Claude. Fuera de claude.ai se requiere API key en `Datos y API`.

## 18. Escenarios de demo con datos reales

1. **PALMAS · Guantes de cuero (MA0101022):** disponible 33, mín 62, máx 226. Pedir 400 → “Sobre máximo” → usar sugerida **193** → **Q 8,948.13 evitados**. Excede el presupuesto de EPP (Q 7,056.92) → R2 → N1.
2. **SUPREMA · Cojinete 6309 (RE0302046):** bajo mínimo, sugerida 7 (Q 1,121.22), dentro de presupuesto → **R1 aprobación automática**.
3. **SUPREMA · Refrigerante R-438A (RE0301029):** 8 unidades = Q 12,021.79 > Q 6,650 disponibles en Repuestos → **R3: N1 + N2**.
4. **PALMAS · Diésel (MA0105017):** presupuesto casi agotado (Q 12,450 disponibles) → R3, y el dashboard lo marca como excedido.
5. **SUPREMA · Llanta 7.50-16 (RE0102014):** cuenta de vehículos → exige **placa**.
