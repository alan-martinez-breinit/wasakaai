# Seleccion del Modelo de Inteligencia Artificial

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026
**Fase:** 1 — Investigacion y Evaluacion Tecnologica

---

## 1. ¿Que necesitamos que haga la IA?

El modelo de IA tiene una sola funcion principal en este proyecto:

> **Recibir texto en lenguaje natural → Generar una consulta SQL valida → Explicar el resultado**

Ejemplo:
- Entrada: *"Ventas de autos por region en el mes de marzo"*
- La IA debe generar algo como: `SELECT region, SUM(venta) FROM ventas_autos WHERE mes = 3 GROUP BY region`
- Y ademas ayudar a presentar los datos de forma entendible

---

## 2. Factores que determinan la eleccion

### Factor A — Privacidad de datos (el mas importante)

| Escenario | Que implica |
|---|---|
| Los datos NO pueden salir de la red interna | Modelo LOCAL obligatorio. No se puede usar OpenAI, Claude ni ningun servicio en la nube |
| Los datos SI pueden salir de la red | Podemos usar servicios en la nube (OpenAI, Claude, Google) |

**Pregunta a responder:** ¿La informacion de ventas e inventario de autos puede enviarse a servidores externos (OpenAI, Google, etc.) para ser procesada?

### Factor B — Presupuesto

| Escenario | Que implica |
|---|---|
| Sin presupuesto mensual para IA | Modelo cloud economico (Gemini Flash) — costo casi nulo |
| Presupuesto bajo ($20-50 USD/mes) | Modelo hibrido — local para consultas simples, cloud para complejas |
| Presupuesto medio ($100-300 USD/mes) | OpenAI GPT-4o mini o Claude Sonnet — buena calidad a costo moderado |
| Presupuesto alto ($500+ USD/mes) | GPT-4o, Claude Sonnet completo — maxima calidad |

### Factor C — Volumen de uso

| Cantidad de reportes diarios | Costo estimado mensual (OpenAI) |
|---|---|
| 5-10 reportes / dia | $10-30 USD / mes |
| 20-50 reportes / dia | $50-150 USD / mes |
| 100+ reportes / dia | $200-500+ USD / mes |

### Factor D — Idioma

El sistema debe funcionar en ESPAÑOL (mexicano). No todos los modelos lo hacen igual de bien.

---

## 3. Opciones disponibles

### Opcion 1 — OpenAI GPT-4o (recomendada si los datos pueden salir de la red)

| Aspecto | Detalle |
|---|---|
| Proveedor | OpenAI (creadores de ChatGPT) |
| Modelo | GPT-4o — el mas reciente y rapido |
| Calidad en español | Excelente — es el modelo mas usado globalmente |
| NL a SQL | La mejor del mercado actual. OpenAI tiene entrenamiento especifico para esto |
| Velocidad de respuesta | 1-3 segundos por consulta |
| Costo | Entrada: $2.50 USD / 1M tokens. Salida: $10 USD / 1M tokens |
| Donde corre | En servidores de Microsoft Azure (OpenAI) o directamente OpenAI |
| Datos salen de la red | SI — se envian a servidores externos |
| Ventaja clave | Es lo que mejor funcionaria y mas rapido de implementar |
| Desventaja | Dependencia de internet y servicio externo. Costo recurrente |

**Ideal para:** Presupuesto disponible, sin restriccion de privacidad, buscan la mejor calidad y menor tiempo de desarrollo.

### Opcion 2 — Anthropic Claude 3.5 Sonnet

| Aspecto | Detalle |
|---|---|
| Proveedor | Anthropic |
| Modelo | Claude 3.5 Sonnet |
| Calidad en español | Muy buena — Anthropic entrena con multilingue |
| NL a SQL | Muy buena — comparable a GPT-4o |
| Velocidad de respuesta | 1-3 segundos |
| Costo | Entrada: $3 USD / 1M tokens. Salida: $15 USD / 1M tokens |
| Datos salen de la red | SI |
| Ventaja clave | Ventana de contexto muy grande (200K tokens) — puede procesar mucha informacion de una sola vez |
| Desventaja | Similar a OpenAI en costo y dependencia externa |

**Ideal para:** Alternativa a OpenAI, equiparable en calidad.

### Opcion 4 — Google Gemini

| Aspecto | Detalle |
|---|---|
| Proveedor | Google |
| Modelo | Gemini 1.5 Pro / Flash |
| Calidad en español | Buena — Google tiene experiencia en multilingue |
| NL a SQL | Buena, aunque un paso detras de GPT-4o |
| Velocidad | Rapida |
| Costo | Gemini Flash es MUY economico (casi gratuito). Gemini Pro es competitivo |
| Datos salen de la red | SI |
| Ventaja clave | Gemini Flash es extremadamente barato |
| Desventaja | Menor calidad en NL a SQL que OpenAI/Claude |

**Ideal para:** Presupuesto limitado pero quieren calidad cloud.

### Opcion 5 — Modelo Hibrido (recomendacion personal)

| Componente | Que hace | Donde corre |
|---|---|---|
| Modelo economico (Gemini Flash) | Consultas simples: "dame las ventas totales" | Cloud |
| Modelo potente (GPT-4o mini) | Consultas complejas: "compara ventas por region vs inventario disponible y dame los top 5" | Cloud |
| Logica de decision | El sistema decide si la consulta es simple o compleja | En el backend |

**Ventaja:** Balance entre costo y calidad. Las consultas baratas usan el modelo economico, solo las complejas usan el potente.

**Desventaja:** Mayor complejidad tecnica al tener que mantener dos modelos y la logica de decision.

---

## 4. Tabla comparativa resumen

| Criterio | GPT-4o | Claude 3.5 | Gemini | Hibrido |
|---|---|---|---|---|
| NL a SQL | Excelente | Excelente | Buena | Buena-Excelente |
| Espanol | Excelente | Excelente | Buena | Buena-Excelente |
| Velocidad | 1-3s | 1-3s | 1-3s | Variable |
| Costo mensual* | $50-300 USD | $60-400 USD | $5-50 USD | $10-100 USD |
| Datos salen de red | SI | SI | SI | Parcial |
| Requiere GPU | NO | NO | NO | NO |
| Implementacion | Rapida (dias) | Rapida (dias) | Rapida (dias) | Media (1-2 semanas) |
| Dependencia externa | Alta | Alta | Alta | Media |

*Estimado para 20-50 reportes diarios

---

## 5. Preguntas que debemos responder como equipo

Para poder elegir, necesitamos respuestas concretas a estas preguntas:

| # | Pregunta | Quien responde |
|---|---|---|
| 1 | ¿Los datos de ventas e inventario pueden enviarse a servidores externos (OpenAI, Google, Anthropic)? | Direccion / Sistemas |
| 2 | ¿Hay presupuesto mensual para el uso de APIs de IA? | Direccion / Finanzas |
| 3 | Si hay presupuesto, ¿de cuanto disponemos aprox? ($0, $100, $500 USD/mes)? | Direccion |
| 4 | ¿Tenemos un servidor disponible con tarjeta grafica (GPU) para correr un modelo local? | Sistemas |
| 5 | ¿Cuantos reportes diarios estiman que se generaran al inicio? | Usuarios / Producto |
| 6 | ¿Hay fecha limite para tener el modulo funcionando? | Direccion |

---

## 6. Opciones recomendadas segun cada escenario

### Escenario B: Datos sensibles + Con presupuesto
**Recomendacion:** GPT-4o mini (hibrido con Gemini Flash para consultas simples)
- Costo controlado para consultas complejas
- Consultas simples resueltas con modelo economico

### Escenario C: Datos no sensibles + Presupuesto bajo
**Recomendacion:** Gemini Flash
- Costo casi nulo
- Buena calidad en espanol
- Rapido de implementar

### Escenario D: Datos no sensibles + Presupuesto disponible (RECOMENDADO)
**Recomendacion:** OpenAI GPT-4o
- Mejor calidad NL a SQL del mercado
- Implementacion en dias
- Costo predecible y controlable

---

## 7. Preparacion de un piloto

Independientemente del modelo que se elija, proponemos lo siguiente:

1. **Crear el sandbox** con estructura de BD y datos ficticios
2. **Probar 3 modelos** con las mismas consultas de ejemplo
3. **Comparar resultados** (que consulta SQL generaron, que tan correcta fue)
4. **Medir velocidad y costo** de cada uno
5. **Presentar resultados** al equipo para decision final

Esto se puede hacer sin tocar produccion y sin invertir dinero (los modelos cloud tienen creditos gratuitos para pruebas: OpenAI regala $5-18, Google tiene capa gratuita).
