# Seleccion del Modelo de Inteligencia Artificial

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026

---

## 1. ¿Que necesita la IA en este proyecto?

La IA recibe una pregunta en español del usuario y genera una consulta SQL para obtener los datos de las bases de datos. Luego devuelve los resultados en un reporte .html descargable.

**Ejemplo:**
- Usuario: *"Dame las ventas de autos por región en marzo"*
- IA genera: `SELECT región, SUM(ventas) FROM ventas_autos WHERE mes = 3 GROUP BY región`
- Sistema ejecuta la consulta y crea un reporte

---

## 2. ¿Por que no hacerlo localmente?

Tenemos dos opciones principales: usar un servidor local con un modelo de IA, o usar servicios en la nube.

| Opcion | Ventaja | Desventaja |
|---|---|---|
| **Servidor local** | Los datos no salen de la empresa | Costo inicial $500-2000 en GPU + complejidad |
| **Servicio en la nube** | Sin costo inicial, facil de usar, mejor calidad | Los datos salen hacia servidores externos |

---

## 3. La propuesta: OpenCode Zen + OpenCode Go

En lugar de elegir UNO, usamos un **servicio que da acceso a muchos modelos** con una sola API key.

**OpenCode Zen** = Gateway (puerta de entrada) que ofrece:
- Modelos gratuitos (DeepSeek Flash Free, MiMo Free, Big Pickle)
- Modelos de pago (Claude Sonnet, GPT, Gemini, DeepSeek Pro, etc.)

**OpenCode Go** = Suscripcion de bajo costo ($10/mes) que da acceso a modelos open source de buena calidad

---

## 4. La estrategia: Usar el modelo correcto para cada consulta

No todas las preguntas son iguales. Las simples se resuelven rápido y barato. Las complejas necesitan modelos mejores.

| Tipo de consulta | Ejemplo | Modelo a usar | Costo |
|---|---|---|---|
| Simple (60% de los reportes) | "Ventas totales de marzo" | DeepSeek V4 Flash Free | $0 |
| Simple | "¿Cuantas unidades se vendieron ayer?" | MiMo V2.5 Free | $0 |
| Compleja (30% de reportes) | "Compara ventas marzo vs febrero por región" | DeepSeek V4 Pro (via Go) | ~$0.01-0.05 |
| Muy compleja (10%) | "Analisis de tendencias + proyecciones" | Claude Sonnet (via Zen) | ~$0.05-0.15 |

**El truco:** Las consultas baratas (gratis) se resuelven con modelos simples. Las consultas cara (complejas) justifican pagar por modelos mejores.

---

## 5. Costo estimado mensual

Asumiendo que generan **30 reportes diarios** (18 simples + 12 complejos):

| Concepto | Costo estimado |
|---|---|
| OpenCode Go (suscripcion) | $10 USD |
| Consultas simples (18/dia = 540/mes) | $0 |
| Consultas complejas moderadas (9/dia = 270/mes) | $20 USD |
| Consultas complejas con Claude (3/dia = 90/mes) | $15 USD |
| **Total mensual** | **$45 USD** |

Si usan menos reportes, el costo baja. Si usan más, el costo sube proporcionalmente.

---

## 6. Ventajas de esta propuesta

1. **Costo muy bajo** — El 60% de consultas no cuestan nada
2. **Sin inversion inicial** — No necesita comprar hardware (GPU)
3. **Facil de implementar** — Solo obtiene una API key y listo
4. **Sin lock-in** — Puede cambiar de proveedor cuando quiera
5. **Calidad donde importa** — Las consultas complejas usan modelos premium
6. **Escalable** — Si crece el volumen, paga solo lo adicional
7. **Modelos probados** — OpenCode ya evaluo que funcionan bien

---

## 7. Lo que necesita decidir la empresa

Antes de avanzar, necesitamos respuestas a 2 preguntas clave:

| # | Pregunta | Responde |
|---|---|---|
| 1 | **¿Los datos de ventas/inventario pueden enviarse a servidores externos para procesamiento de IA?** | Direccion / Area de Sistemas |
| 2 | **¿Hay presupuesto disponible? (estimado $40-60 USD/mes)** | Direccion / Finanzas |

**Si responden SI a ambas:** Avanzamos con OpenCode Zen + Go.

**Si responden NO a la pregunta 1:** Necesitariamos un modelo local en servidor propio (costo inicial de hardware).

---

## 8. Proximos pasos

Una vez aprobado por Direccion:

1. Crear cuenta en OpenCode Zen (opencode.ai)
2. Obtener API key y configurar metodo de pago
3. Suscribirse a OpenCode Go ($10/mes)
4. Probar los modelos gratuitos con consultas de ejemplo
5. Evaluar calidad de respuestas
6. Ajustar configuracion segun resultados
7. Integrar con el backend FastAPI

---

## 9. Resumen para la presentacion

> Vamos a usar OpenCode Zen + Go para acceder a multiples modelos de IA por una sola API key. Los reportes simples se resuelven gratis. Los reportes complejos pagan por uso. Costo estimado: $45 USD/mes. Sin hardware adicional, sin lock-in, facil de cambiar si cambia de opinion.

---

*Documento generado como parte de la Fase 1 — Investigacion Tecnologica*
