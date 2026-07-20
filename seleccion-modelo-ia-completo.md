# Seleccion del Modelo de Inteligencia Artificial

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026
**Fase:** 1 — Investigacion y Evaluacion Tecnologica

---

## 1. ¿Que necesita hacer la IA en este proyecto?

Recibir texto en lenguaje natural escrito por el usuario y convertirlo en una consulta SQL valida para obtener datos de los cubos de Ventas e Inventario de Autos.

**Ejemplo real:**
- Usuario escribe: *"Ventas de autos por region en marzo"*
- La IA genera: `SELECT region, SUM(total) FROM ventas_autos WHERE mes = 3 GROUP BY region`
- El sistema ejecuta la consulta y devuelve los resultados en un reporte .html

---

## 2. Restricciones del proyecto

| Factor | Restriccion |
|---|---|
| Entorno | Produccion en vivo — un error cuesta millones |
| Bases de datos | Produccion y Desarrollo — ambas intocables |
| Backend definido | FastAPI (Python) para el modulo IA |
| Frontend definido | PHP para portal y visualizacion |
| Datos de origen | Cubos de Ventas Autos e Inventario Autos |
| Operaciones permitidas | Solo SELECT — nunca INSERT, UPDATE, DELETE |

---

## 3. Factores que determinan la eleccion del modelo

### Factor A — Privacidad de los datos

| Escenario | Implica |
|---|---|
| Los datos NO pueden salir de la red interna | Modelo LOCAL obligatorio (GPU requerida) |
| Los datos SI pueden salir de la red | Se puede usar servicios en la nube |

**Pregunta a responder por Direccion/Sistemas:**
¿Los datos de ventas e inventario de autos pueden enviarse a servidores externos para ser procesados por IA?

### Factor B — Presupuesto

| Escenario | Implica |
|---|---|
| Sin presupuesto mensual para IA | Modelos gratuitos o locales |
| Presupuesto bajo ($10-50 USD/mes) | OpenCode Go + modelos gratuitos |
| Presupuesto medio ($100-300 USD/mes) | Claude Sonnet / GPT via Zen |
| Presupuesto alto ($500+ USD/mes) | Claude Opus / GPT-5.x |

### Factor C — Volumen de uso estimado

| Reportes por dia | Costo estimado mensual |
|---|---|
| 5-10 reportes / dia | $5-30 USD / mes |
| 20-50 reportes / dia | $30-150 USD / mes |
| 100+ reportes / dia | $150-500+ USD / mes |

### Factor D — Idioma

El sistema debe funcionar en espanol mexicano. No todos los modelos lo hacen bien.

---

## 4. Propuesta oficial: Arquitectura de modelos hibrida

Se propone utilizar **OpenCode Zen** como gateway unico de modelos, combinando modelos gratuitos para consultas simples con modelos de pago para consultas complejas.

### 4.1 ¿Que es OpenCode Zen?

Es un mercado de modelos de IA seleccionados y probados por el equipo de OpenCode. Funciona con una sola API key y modelo de pago por uso. Tambien ofrece modelos gratuitos.

### 4.2 ¿Que es OpenCode Go?

Es una suscripcion de bajo costo ($5 primer mes, $10/mes despues) que da acceso a modelos open source de alta calidad como DeepSeek V4 Pro, Qwen, GLM, Kimi, entre otros.

---

## 5. Estrategia de enrutamiento inteligente

```
              Consulta del usuario
                        │
                        ▼
              ┌─────────────────────┐
              │  Clasificador        │
              │  (simple vs compleja)│
              └──────┬──────────────┘
                     │
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
  ┌─────────────────┐   ┌─────────────────┐
  │ MODELO GRATUITO  │   │ MODELO DE PAGO  │
  │ DeepSeek V4 Flash│   │ Claude Sonnet   │
  │ Free             │   │ (via Zen)       │
  │ Big Pickle       │   │ o               │
  │ MiMo V2.5 Free   │   │ DeepSeek V4 Pro │
  │                  │   │ (via Go)        │
  │ Costo: $0        │   │ Costo: variable │
  └─────────────────┘   └─────────────────┘
         │                       │
         └───────────┬───────────┘
                     ▼
              ┌─────────────────┐
              │  Reporte .html   │
              └─────────────────┘
```

### 5.1 Reglas de enrutamiento

| Tipo de consulta | Ejemplo | Modelo a usar | Costo |
|---|---|---|---|
| Simple | "Ventas totales de marzo" | DeepSeek V4 Flash Free | $0 |
| Simple | "Inventario del modelo X" | DeepSeek V4 Flash Free | $0 |
| Simple | "¿Cuantas unidades se vendieron ayer?" | Big Pickle / MiMo Free | $0 |
| Compleja | "Compara ventas marzo vs febrero por region y calcula crecimiento" | Claude Sonnet (Zen) o DeepSeek V4 Pro (Go) | $0.01 - $0.05 |
| Compleja | "Top 10 autos mas vendidos con inventario disponible y rotacion" | Claude Sonnet (Zen) | $0.02 - $0.10 |
| Compleja | "Analisis de tendencia de ventas ultimos 6 meses con proyeccion" | Claude Sonnet (Zen) | $0.03 - $0.15 |

---

## 6. Costos estimados

### 6.1 Escenario basado en 30 reportes diarios

| Concepto | Costo |
|---|---|
| OpenCode Go (suscripcion mensual) | $10 USD / mes |
| Consultas simples (gratuitas) ~18 reportes/dia | $0 USD |
| Consultas complejas via Go ~9 reportes/dia | ~$15-30 USD / mes |
| Consultas complejas via Zen ~3 reportes/dia | ~$10-20 USD / mes |
| **Total estimado mensual** | **$35-60 USD / mes** |

### 6.2 Comparativa con otras opciones

| Opcion | Costo mensual | Privacidad | Complejidad |
|---|---|---|---|
| Modelo local (GPU requerida) | $0 + $500-2000 una vez | Total | Alta |
| Solo Claude via Zen | $150-400 USD | Datos salen | Baja |
| Solo OpenAI GPT | $100-300 USD | Datos salen | Baja |
| **Propuesta hibrida (Zen + Go)** | **$35-60 USD** | **Datos salen** | **Media** |
| Solo modelos gratuitos | $0 | Datos salen | Baja |

---

## 7. Ventajas de la propuesta hibrida

| Ventaja | Explicacion |
|---|---|
| **Costo drasticamente menor** | El 60% de consultas no cuestan nada |
| **Sin inversion en hardware** | No se necesita GPU ni servidor especializado |
| **Configuracion simple** | Una API key de Zen lista en minutos |
| **Modelos probados** | OpenCode ya evaluo que modelos funcionan mejor |
| **Sin lock-in** | Se puede cambiar de proveedor sin reescribir el sistema |
| **Calidad donde importa** | Las consultas complejas usan modelos premium |
| **Escalable** | Si crece el volumen, se paga solo por uso adicional |

---

## 8. Privacidad y uso de datos

Segun la documentacion oficial de OpenCode Zen:

| Proveedor | Politica de datos |
|---|---|
| Modelos gratuitos (Big Pickle, DeepSeek Free, MiMo Free) | Pueden usar datos para mejora del modelo durante periodo gratuito |
| Modelos de pago via Zen | Zero-retention — no usan datos para entrenamiento |
| Claude via Zen | Las solicitudes se conservan 30 dias (politica de Anthropic) |
| OpenAI via Zen | Las solicitudes se conservan 30 dias (politica de OpenAI) |

**Importante:** Todos los modelos pasan por servidores externos (USA/UE/Singapur). Los datos salen de la red interna de la empresa.

---

## 9. Modelos disponibles en OpenCode Zen (Catalogo completo)

### 9.1 Modelos gratuitos (costo $0)

| Modelo | ID | Notas |
|---|---|---|
| Big Pickle | big-pickle | Gratuito por tiempo limitado |
| DeepSeek V4 Flash Free | deepseek-v4-flash-free | Gratuito por tiempo limitado |
| MiMo V2.5 Free | mimo-v2.5-free | Gratuito por tiempo limitado |
| North Mini Code Free | north-mini-code-free | Gratuito por tiempo limitado |
| Nemotron 3 Ultra Free | nemotron-3-ultra-free | Gratuito por tiempo limitado |

### 9.2 Modelos open source via Go ($10/mes)

| Modelo | Precio por 1M tokens (entrada/salida) |
|---|---|
| DeepSeek V4 Pro | $1.74 / $3.48 |
| DeepSeek V4 Flash | $0.14 / $0.28 |
| Qwen3.7 Max | $2.50 / $7.50 |
| Qwen3.7 Plus | $0.40 / $1.60 |
| GLM 5.2 | $1.40 / $4.40 |
| Kimi K2.6 | $0.95 / $4.00 |
| MiniMax M3 | $0.30 / $1.20 |
| MiMo V2.5 Pro | $1.74 / $3.48 |

### 9.3 Modelos premium via Zen (pago por uso)

| Modelo | Precio por 1M tokens (entrada/salida) |
|---|---|
| Claude Sonnet 4.6 | $3.00 / $15.00 |
| Claude Haiku 4.5 | $1.00 / $5.00 |
| Claude Opus 4.8 | $5.00 / $25.00 |
| GPT 5.4 Mini | $0.75 / $4.50 |
| GPT 5.4 Nano | $0.20 / $1.25 |
| Gemini 3 Flash | $0.50 / $3.00 |

---

## 10. Recomendacion final

Se propone la siguiente configuracion:

| Componente | Que es | Costo |
|---|---|---|
| **OpenCode Zen** | Gateway principal — una API key para todo | Pago por uso solo de consultas complejas |
| **OpenCode Go** | Suscripcion mensual para modelos open source | $10/mes |
| **Modelos gratuitos** | Para consultas simples (60-70% del total) | $0 |
| **Claude Sonnet (via Zen)** | Para consultas complejas (30-40% del total) | ~$0.01-0.10 por consulta |

**Costo estimado total mensual: $35-60 USD**

---

## 11. Proximos pasos

| # | Accion | Responsable |
|---|---|---|
| 1 | Confirmar si los datos pueden salir de la red interna | Direccion / Sistemas |
| 2 | Definir presupuesto mensual para APIs de IA | Direccion / Finanzas |
| 3 | Crear cuenta en OpenCode Zen (opencode.ai) | Desarrollo |
| 4 | Obtener API key de Zen y configurar metodos de pago | Desarrollo |
| 5 | Probar los modelos gratuitos con consultas de ejemplo | Desarrollo |
| 6 | Evaluar calidad de respuestas con datos ficticios | Desarrollo |
| 7 | Documentar resultados y ajustar configuracion | Desarrollo |

---

## 12. Preguntas para responder como equipo

| # | Pregunta | Quien responde |
|---|---|---|
| 1 | ¿Los datos de ventas/inventario pueden salir de la red hacia servidores externos? | Direccion / Sistemas |
| 2 | ¿Hay presupuesto mensual aprobado para IA? ¿De cuanto? | Direccion / Finanzas |
| 3 | ¿Se autoriza el uso de OpenCode Zen/Go como proveedor? | Direccion / Sistemas |
| 4 | ¿Hay modelos gratuitos que NO debamos usar por politicas de datos? | Seguridad / Sistemas |

---

*Documento generado como parte de la Fase 1 de Investigacion y Evaluacion Tecnologica.*
*Proyecto: Generador Inteligente de Reportes con IA*
*Propuesta: Arquitectura hibrida con OpenCode Zen + Go*
