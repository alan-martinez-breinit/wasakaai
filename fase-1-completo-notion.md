# Fase 1 — Investigacion y Evaluacion Tecnologica

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026
**Duracion estimada:** 1 semana (40 horas)

---

## Tabla de Contenido

1. [Objetivo de la Fase](#1-objetivo-de-la-fase)
2. [Contexto del Entorno Actual](#2-contexto-del-entorno-actual)
3. [Stack Tecnologico Definido](#3-stack-tecnologico-definido)
4. [Justificacion: FastAPI vs PHP para la IA](#4-justificacion-fastapi-vs-php-para-la-ia)
5. [Arquitectura Propuesta](#5-arquitectura-propuesta)
6. [Seleccion del Modelo de IA](#6-seleccion-del-modelo-de-ia)
7. [Herramienta de Diseno de Interfaces](#7-herramienta-de-diseno-de-interfaces)
8. [Protocolo de Seguridad para Produccion](#8-protocolo-de-seguridad-para-produccion)
9. [Preguntas Pendientes por Resolver](#9-preguntas-pendientes-por-resolver)
10. [Proximos Pasos](#10-proximos-pasos)

---

## 1. Objetivo de la Fase

Investigar, evaluar y documentar las alternativas tecnologicas para la implementacion de un modulo de generacion inteligente de reportes mediante Inteligencia Artificial, **sin modificar ni intervenir** los entornos existentes de produccion y desarrollo.

---

## 2. Contexto del Entorno Actual

### 2.1 Base de datos

| Elemento | Detalle |
|---|---|
| Motor de BD | MySQL / MariaDB |
| Herramienta de gestion | SQLyog |
| Logica de negocio en BD | Triggers, Views, Stored Procedures, Functions |
| Entornos existentes | **Produccion** (en vivo) y **Desarrollo** — ambas INTOCABLES |
| Restriccion critica | No se permite modificar ninguna de las dos |
| Respaldos | Gestionados por empresa tercera — cada restauracion cuesta $$ |

### 2.2 Stack actual

| Componente | Tecnologia |
|---|---|
| Aplicacion actual | PHP |
| Base de datos | MySQL / MariaDB |
| APIs actuales | Por clarificar |
| Servidor local disponible | XAMPP (Apache + MySQL + PHP + phpMyAdmin) ya instalado |

### 2.3 Fuentes de datos del proyecto

| Fuente | Descripcion |
|---|---|
| Cubo de Ventas Autos | Datos de ventas del area automotriz |
| Cubo de Inventario Autos | Datos de inventario del area automotriz |
| Objetivos de Autos | Metas y KPIs del area |
| Permisos por usuario | Configuracion de acceso y visibilidad de datos |

### 2.4 Restricciones operativas

| Restriccion | Impacto |
|---|---|
| Produccion en vivo 24/7 | Un error = perdidas millonarias |
| Respaldos de empresa tercera | Cada restauracion tiene costo |
| Dos bases de datos intocables | Obliga a crear un sandbox independiente |
| Solo operaciones SELECT | La IA nunca debe escribir en la BD |

---

## 3. Stack Tecnologico Definido

| Componente | Tecnologia | Quien lo hace |
|---|---|---|
| **Backend del modulo IA** | FastAPI (Python) | Usted |
| **Frontend / Portal** | PHP (sistema actual) | Companero |
| **Comunicacion** | API REST (HTTP) | PHP llama a FastAPI |
| **Conexion a BD** | MySQL connector / SQLAlchemy (solo SELECT) | Backend IA |
| **Diseno de UI** | Google Stitch | Usted |
| **Formato de salida** | .html descargable autocontenido | Backend IA genera |
| **Entorno de desarrollo** | XAMPP local (sandbox) | Ambos |

---

## 4. Justificacion: FastAPI vs PHP para la IA

### Aclaracion importante

No se reemplaza PHP. PHP se queda como el sistema principal. FastAPI es un **servicio nuevo e independiente** que solo maneja la parte de Inteligencia Artificial.

```
PHP (sistema actual)  →  Frontend, login, permisos, mostrar resultados
FastAPI (nuevo)       →  Interpretar texto, generar SQL consultar BD, crear reportes
```

### SDKs oficiales de IA

| Proveedor | SDK oficial para Python | SDK oficial para PHP |
|---|---|---|
| OpenAI | ✅ Si — mantenido por OpenAI | ❌ No existe |
| Anthropic (Claude) | ✅ Si — mantenido por Anthropic | ❌ No existe |
| Google (Gemini) | ✅ Si — mantenido por Google | ❌ No existe |

En PHP solo se puede conectar con llamadas manuales (curl) o paquetes de terceros. En Python los SDKs son oficiales, con soporte y actualizaciones.

### Comparacion de esfuerzo

| Aspecto | FastAPI (Python) | PHP |
|---|---|---|
| Lineas para conectar IA | 5-12 | 25-40 |
| Manejo de errores | Incluido en SDK | Manual |
| Documentacion del API | Automatica (Swagger) | Manual |
| Tiempo de integrar IA | 1-2 dias | 1-2 semanas |
| Cambiar de proveedor IA | 3 lineas de codigo | Reescribir integracion |

### Separacion de responsabilidades

| PHP (Companero) | FastAPI (Usted) |
|---|---|
| Portal de acceso | Recibir texto en lenguaje natural |
| Interfaz de usuario | Interpretar con IA |
| Sesiones y autenticacion | Generar consulta SQL |
| Mostrar resultados | Ejecutar contra MySQL (solo SELECT) |
| Ofrecer descarga .html | Generar el archivo .html |

### Riesgos y mitigacion

| Riesgo | Mitigacion |
|---|---|
| El equipo no conoce Python | Usted tiene experiencia. Se documenta todo |
| Servicio nuevo que mantener | FastAPI es ligero, corre en el mismo servidor |
| Dependencia de una persona | Documentacion completa del codigo |

---

## 5. Arquitectura Propuesta

```
+--------------------------------------------------+
|              SISTEMA ACTUAL (PHP)                 |
|  NO SE MODIFICA                                   |
|  - Portal web                                     |
|  - Login de usuario                               |
|  - Permisos                                       |
|  - Mostrar resultados                             |
+-----------------------+--------------------------+
                        |
                        |  LLAMADA HTTP
                        |
+-----------------------v--------------------------+
|              MODULO IA (FastAPI - Python)          |
|  SERVICIO NUEVO E INDEPENDIENTE                   |
|                                                    |
|  Recibe: texto del usuario                         |
|  Hace:   IA interpreta -> genera SQL SELECT        |
|          -> consulta BD -> crea reporte .html      |
|  Responde: archivo .html listo                    |
+----------------------------------------------------+
                        |
                        |  SOLO LECTURA (SELECT)
                        |
+-----------------------v--------------------------+
|              BASE DE DATOS MYSQL                   |
|  Cubos: Ventas Autos, Inventario Autos             |
|  Usuario dedicado con permisos SOLO SELECT         |
+----------------------------------------------------+
```

### Flujo de operacion

1. El usuario escribe en el portal PHP: *"Ventas de autos por region en marzo"*
2. PHP envia un HTTP POST a FastAPI con el texto
3. FastAPI recibe, la IA interpreta y genera una consulta SQL
4. FastAPI ejecuta la consulta contra MySQL (solo lectura)
5. Con los datos, FastAPI genera un archivo .html con tablas y graficas
6. FastAPI devuelve el .html a PHP
7. PHP muestra el reporte al usuario y ofrece descargarlo
8. **Si FastAPI falla** → el sistema PHP sigue funcionando sin problemas

---

## 6. Seleccion del Modelo de IA

### 6.1 ¿Que necesita hacer la IA?

Recibir texto en español y convertirlo en una consulta SQL valida.

**Ejemplo:**
- Usuario: *"Dame las ventas de autos por region en marzo"*
- IA genera: `SELECT region, SUM(ventas) FROM ventas_autos WHERE mes = 3 GROUP BY region`

### 6.2 Decision: OpenCode Zen + OpenCode Go

Se eligio usar **OpenCode** como proveedor unico de modelos de IA, combinando modelos gratuitos y de pago segun la complejidad de cada consulta.

**¿Que es OpenCode Zen?**
Un servicio que da acceso a multiples modelos de IA (gratuitos y de pago) con una sola API key.

**¿Que es OpenCode Go?**
Una suscripcion de $10/mes que da acceso a modelos open source de buena calidad.

### 6.3 Estrategia: Modelo segun complejidad

| Tipo de consulta | % del total | Ejemplo | Modelo | Costo |
|---|---|---|---|---|
| Simple | 60% | "Ventas totales de marzo" | DeepSeek V4 Flash Free | $0 |
| Simple | — | "Inventario del modelo X" | MiMo V2.5 Free | $0 |
| Compleja | 30% | "Compara ventas marzo vs febrero por region" | DeepSeek V4 Pro (via Go) | ~$0.01-0.05 |
| Muy compleja | 10% | "Analisis de tendencias + proyeccion" | Claude Sonnet (via Zen) | ~$0.05-0.15 |

### 6.4 Costo estimado mensual (30 reportes diarios)

| Concepto | Costo |
|---|---|
| OpenCode Go (suscripcion) | $10 USD |
| Consultas simples (540/mes) | $0 |
| Consultas complejas (270/mes) | $20 USD |
| Consultas muy complejas (90/mes) | $15 USD |
| **Total** | **~$45 USD/mes** |

### 6.5 Ventajas de la propuesta

1. **Costo muy bajo** — 60% de consultas sin costo
2. **Sin inversion en hardware** — No necesita GPU ni servidor especial
3. **Facil de implementar** — Solo una API key
4. **Sin lock-in** — Se puede cambiar de proveedor cuando se quiera
5. **Calidad donde importa** — Lo complejo usa modelos premium
6. **Escalable** — Se paga solo por lo que se usa

### 6.6 Lo que necesita decidir la empresa

| # | Pregunta | Responde |
|---|---|---|
| 1 | ¿Los datos de ventas/inventario pueden enviarse a servidores externos? | Direccion / Sistemas |
| 2 | ¿Hay presupuesto de ~$45 USD/mes para IA? | Direccion / Finanzas |

**Si responden NO a la pregunta 1:** Se necesitaria un modelo local con GPU (costo inicial de $500-2000 USD).

### 6.7 Proximos pasos para implementar

1. Crear cuenta en OpenCode Zen (opencode.ai)
2. Obtener API key y configurar metodo de pago
3. Suscribirse a OpenCode Go ($10/mes)
4. Probar modelos gratuitos con consultas de ejemplo
5. Evaluar calidad de respuestas
6. Integrar con FastAPI

---

## 7. Herramienta de Diseno de Interfaces

| Decision | Detalle |
|---|---|
| **Herramienta** | Google Stitch |
| **URL** | https://stitch.withgoogle.com/ |
| **Precio** | Gratuito (350 generaciones al mes) |
| **Que genera** | Pantallas completas para web desde texto |
| **Exporta a** | HTML, CSS, Tailwind, React, Figma |
| **Conexion con desarrollo** | Exporta directo a Claude Code via MCP |

### Que se va a disenar

| Pantalla | Descripcion |
|---|---|
| **Portal de consulta** | Pagina donde el usuario escribe su pregunta y hace clic en "Generar Reporte" |
| **Vista previa del reporte** | Resultado mostrado en pantalla antes de descargar |
| **Reporte .html descargado** | Estilo profesional del archivo final |

### Flujo diseno → implementacion

```
Stitch (diseno) → PHP toma el diseno del portal
                → FastAPI toma el diseno del reporte .html
                → Exportacion MCP opcional para acelerar
```

---

## 8. Protocolo de Seguridad para Produccion

### 8.1 Los 5 mandamientos

| # | Regla | Descripcion |
|---|---|---|
| 1 | **Nunca en produccion directo** | Todo el desarrollo se hace en el sandbox local |
| 2 | **Lectura antes que escritura** | Primero observar y documentar, despues disenar |
| 3 | **Cero acceso de escritura** | Usuario MySQL dedicado con permisos SOLO SELECT |
| 4 | **Validacion humana obligatoria** | Todo reporte de IA debe poder verificarse |
| 5 | **Despliegue con kill-switch** | El modulo IA se apaga sin afectar el sistema actual |

### 8.2 Estrategia de sandbox

```
BD Produccion     → INTOCABLE
BD Desarrollo     → INTOCABLE
BD Sandbox (nueva) → Creada en XAMPP local
                     - Copia solo estructura (sin datos reales)
                     - Datos ficticios de prueba
                     - Se puede romper y recrear
                     - Cero riesgo y cero costo de respaldos
```

**Como crear el sandbox:**
1. Exportar solo la estructura desde SQLyog (Structure Only, sin datos)
2. Importar en el MySQL de XAMPP
3. Poblar con datos ficticios para pruebas

---

## 9. Preguntas Pendientes por Resolver

| # | Pregunta | Depende de |
|---|---|---|
| 1 | ¿Como manejan las APIs actualmente? | Equipo |
| 2 | ¿El PHP es framework (Laravel, CodeIgniter) o nativo? | Equipo |
| 3 | ¿Estructura detallada de las BDs (vistas, SP del cubo)? | Requiere export desde SQLyog |
| 4 | ¿Los datos pueden salir de la red? | Direccion / Sistemas |
| 5 | ¿Cuantos usuarios usarian el modulo? | Direccion |
| 6 | ¿Hay presupuesto para APIs de IA? | Direccion / Finanzas |
| 7 | ¿Los datos tienen regulaciones (CNBV, fiscal)? | Direccion |

---

## 10. Proximos Pasos

| Prioridad | Accion | Responsable |
|---|---|---|
| 🔴 Alta | Obtener export de estructura BD (SQLyog, Structure Only) | Equipo |
| 🔴 Alta | Confirmar si datos pueden salir de la red | Direccion / Sistemas |
| 🔴 Alta | Definir presupuesto mensual para IA | Direccion / Finanzas |
| 🟡 Media | Importar estructura en sandbox de XAMPP | Desarrollo |
| 🟡 Media | Crear cuenta en OpenCode Zen | Desarrollo |
| 🟡 Media | Probar modelos gratuitos con consultas de ejemplo | Desarrollo |
| 🟢 Baja | Definir contrato API entre PHP y FastAPI | Ambos |
| 🟢 Baja | Disenar mockups en Google Stitch | Usted |

---

## Resumen Ejecutivo

- **Backend IA:** FastAPI (Python)
- **Frontend:** PHP (se mantiene)
- **Modelo IA:** OpenCode Zen + Go (hibrido gratuito/pago)
- **Costo IA:** ~$45 USD/mes
- **Diseno:** Google Stitch
- **Sandbox:** MySQL local en XAMPP
- **Regla de oro:** Solo SELECT, nunca escribir en BD
- **Riesgo cero:** Todo se desarrolla en sandbox, nunca en produccion

---

*Documento completo de la Fase 1 — Investigacion y Evaluacion Tecnologica*
*Proyecto: Generador Inteligente de Reportes con IA*
*Ultima actualizacion: 24 de junio de 2026*
