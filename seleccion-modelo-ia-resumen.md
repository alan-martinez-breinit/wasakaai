# Seleccion del Modelo de IA

**Proyecto:** Generador Inteligente de Reportes
**Fecha:** 24 de junio de 2026

---

## 1. ¿Que necesita la IA?

Usuario escribe en español → IA genera una consulta SQL → Se obtienen datos → Se crea un reporte .html

---

## 2. La propuesta: Usar OpenCode como proveedor unico

OpenCode Zen y OpenCode Go son servicios que dan acceso a multiples modelos de IA con una sola API key.

**Ventaja principal:** No necesitamos GPU, no instalamos nada, solo obtenemos una clave y listo.

---

## 3. Estrategia: Mezclar modelos gratis y de pago

No todos los reportes son igual de complejos. Podemos ahorrar usando el modelo adecuado para cada caso:

| Tipo de consulta | Ejemplo | Modelo a usar | Costo |
|---|---|---|---|
| **Simple (60%)** | "Ventas totales de marzo" | DeepSeek Flash Free | **$0** |
| **Simple** | "Inventario del modelo X" | MiMo V2.5 Free | **$0** |
| **Compleja (30%)** | "Compara ventas vs febrero y calcula crecimiento" | DeepSeek V4 Pro (via Go) | ~$0.02 |
| **Compleja (10%)** | "Analisis de tendencias con proyeccion" | Claude Sonnet (via Zen) | ~$0.05 |

---

## 4. Costo estimado mensual

| Concepto | Costo |
|---|---|
| Suscripcion OpenCode Go | $10 USD / mes |
| Consultas simples | $0 |
| Consultas complejas | $25-50 USD / mes |
| **Total estimado** | **$35-60 USD / mes** |

---

## 5. Lo que necesitamos decidir como equipo

| # | Pregunta | Responde |
|---|---|---|
| 1 | ¿Los datos de ventas/inventario pueden enviarse a servidores externos? | Direccion / Sistemas |
| 2 | ¿Hay presupuesto mensual para IA? (estimado $35-60 USD) | Direccion / Finanzas |

Si la respuesta a la pregunta 1 es **NO** → esta propuesta no aplica, necesitariamos un modelo local con GPU.

Si es **SI** → avanzamos con OpenCode Zen + Go.

---

*Fin del documento*
