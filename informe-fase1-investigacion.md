# Fase 1 — Investigacion y Evaluacion Tecnologica

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026
**Estado:** En progreso
**Duracion estimada:** 1 semana (40 horas)

---

## 1. Objetivo de esta fase

Investigar, evaluar y documentar las alternativas tecnologicas para la implementacion de un modulo de generacion inteligente de reportes mediante Inteligencia Artificial, sin modificar ni intervenir los entornos existentes de produccion y desarrollo.

---

## 2. Contexto del entorno actual

### 2.1 Infraestructura de base de datos

| Elemento | Detalle |
|---|---|
| Motor de BD | MySQL / MariaDB |
| Herramienta de gestion | SQLyog |
| Logica de negocio en BD | Triggers, Views, Stored Procedures, Functions |
| Entornos existentes | 2 bases de datos: Produccion y Desarrollo |
| Restriccion critica | Ambas bases son INTOCABLES — no se permite modificacion en ninguna |

### 2.2 Stack de desarrollo actual

| Componente | Tecnologia |
|---|---|
| Backend / Aplicacion | PHP |
| Base de datos | MySQL / MariaDB |
| APIs | Por clarificar — no se tiene certeza de como se manejan actualmente |
| Servidor local | XAMPP (Apache + MySQL + PHP) ya instalado |

### 2.3 Fuentes de datos del proyecto (Fase inicial)

| Fuente | Descripcion |
|---|---|
| Cubo de Ventas Autos | Datos de ventas del area automotriz |
| Cubo de Inventario Autos | Datos de inventario del area automotriz |
| Objetivos de Autos | Metas y KPIs del area |
| Permisos por usuario | Configuracion de acceso y visibilidad de datos |

### 2.4 Restricciones operativas

| Restriccion | Impacto |
|---|---|
| Produccion en vivo 24/7 | Un error puede representar perdidas millonarias |
| Respaldos gestionados por empresa tercera | Cada respaldo/restauracion tiene costo economico que se busca evitar |
| Dos bases de datos intocables | Obliga a crear un entorno sandbox independiente para desarrollo |
| Solo operaciones de lectura (SELECT) | El modulo de IA jamas debe ejecutar INSERT, UPDATE, DELETE ni disparar triggers |

---

## 3. Decisiones tecnologicas tomadas

### 3.1 Stack del nuevo modulo

| Componente | Tecnologia | Justificacion |
|---|---|---|
| Backend del modulo IA | FastAPI (Python) | Ecosistema nativo de IA (OpenAI, Anthropic, LangChain), SDKs oficiales, desarrollo rapido, tipado, docs automaticas |
| Frontend / Interfaz | PHP | Continuidad con el sistema actual, el equipo ya lo domina |
| Comunicacion | API REST (HTTP) | PHP llama al FastAPI via HTTP POST, desacoplamiento total |
| Conexion a BD | MySQL connector / SQLAlchemy | Solo lectura, usuario dedicado con permisos SELECT unicamente |
| Formato de salida | HTML descargable autocontenido | Archivo .html con CSS embebido, tablas, graficas, navegacion — se abre sin internet |

### 3.2 Justificacion tecnica de FastAPI sobre PHP para el modulo IA

| Criterio | FastAPI (Python) | PHP |
|---|---|---|
| SDK oficial OpenAI | Disponible (`pip install openai`) | No existe SDK oficial |
| SDK oficial Anthropic (Claude) | Disponible (`pip install anthropic`) | No existe |
| LangChain (cadenas IA, agentes, memoria) | Soporte completo | No existe para PHP |
| Traduccion NL a SQL | Librerias maduras disponibles | Requiere construccion manual |
| Escalabilidad futura (graficas, ML, analytics) | matplotlib, plotly, pandas, scikit-learn — nativos | Requiere wrappers o servicios externos |
| Impacto en sistema actual | Cero — es un servicio independiente | Tendria que integrarse en el codigo existente |

### 3.3 Separacion de responsabilidades

```
PHP (Companero)                    FastAPI (Responsable IA)
- Portal de acceso                 - Recibir texto en lenguaje natural
- Interfaz de usuario              - Interpretar con IA
- Sesiones y autenticacion         - Generar consulta SQL (SELECT)
- Mostrar resultados               - Ejecutar contra MySQL (solo lectura)
- Ofrecer descarga del .html       - Generar reporte .html
```

---

## 4. Arquitectura preliminar propuesta

```
                    Sistema actual PHP (NO SE MODIFICA)
                    +-----------------------------+
                    |  PHP + MySQL (produccion)    |
                    |  triggers, SP, views         |
                    +-------------+---------------+
                                  |
                    ==============|================
                       MURO DE SEPARACION
                    ==============|================
                                  |
                    Usuario BD SOLO LECTURA
                                  |
                    +-------------v---------------+
                    |  MODULO IA (nuevo)            |
                    |  +-------------------------+ |
                    |  | FastAPI (Python)         | |
                    |  | - Endpoints REST         | |
                    |  | - Motor IA (NL -> SQL)   | |
                    |  | - MySQL read-only        | |
                    |  | - Generador HTML/PDF     | |
                    |  +-------------------------+ |
                    +-----------------------------+
```

### Flujo de operacion

```
1. Usuario escribe en el portal PHP:
   "Quiero las ventas de autos por region en marzo"

2. PHP envia HTTP POST al FastAPI:
   POST /generar-reporte
   { "pregunta": "ventas de autos por region en marzo" }

3. FastAPI procesa:
   a. IA interpreta el texto en espanol
   b. Genera consulta SQL (solo SELECT)
   c. Ejecuta contra MySQL (usuario solo lectura)
   d. Recibe datos
   e. Renderiza plantilla HTML con datos, tablas y graficas

4. FastAPI responde con el archivo .html

5. PHP ofrece el .html al usuario para visualizar o descargar

6. Si FastAPI falla → el sistema PHP sigue funcionando sin afectacion
```

---

## 5. Evaluacion de alternativas de IA

### 5.1 Modelos candidatos

| Modelo | Ventajas | Desventajas | Costo estimado |
|---|---|---|---|
| OpenAI GPT-4o | Mejor calidad NL a SQL, excelente en espanol | Datos salen de la red interna | ~$2.50-$10 / 1M tokens |
| Azure OpenAI (GPT-4o) | Misma calidad, datos en infraestructura Microsoft | Requiere suscripcion Azure | Similar + costo Azure |
| Anthropic Claude 3.5 Sonnet | Excelente razonamiento y espanol, contexto amplio | Datos salen de la red | ~$3-$15 / 1M tokens |
| Modelos locales (Llama 3, Qwen 2.5) | Datos nunca salen de la red, sin costo por uso | Menor calidad NL a SQL, requiere GPU | Hardware + electricidad |
| Hibrido (local + cloud) | Balance costo/calidad, consultas simples local, complejas cloud | Mayor complejidad de implementacion | Variable |

### 5.2 Criterios de seleccion (pendientes de evaluar)

| Criterio | Pregunta a resolver |
|---|---|
| Privacidad de datos | Los datos de ventas/inventario pueden salir de la red? |
| Volumen de uso | Cuantos reportes se generarian por dia/semana? |
| Presupuesto | Existe presupuesto para APIs de IA o debe ser costo cero? |
| Regulacion | Los datos estan sujetos a regulaciones (CNBV, fiscal, etc.)? |
| Idioma | Todo debe funcionar en espanol mexicano |

---

## 6. Protocolo de seguridad para produccion

### 6.1 Los 5 mandamientos del proyecto

| # | Regla | Descripcion |
|---|---|---|
| 1 | Nunca en produccion directo | Todo desarrollo y prueba ocurre en sandbox aislado |
| 2 | Lectura antes que escritura | Primero observar y documentar, despues disenar |
| 3 | Cero acceso de escritura | Usuario MySQL dedicado con permisos SELECT unicamente |
| 4 | Validacion humana obligatoria | Todo reporte generado por IA debe poder ser verificado |
| 5 | Despliegue con kill-switch | El modulo IA se puede apagar sin afectar el sistema actual |

### 6.2 Estrategia de sandbox

```
BD Produccion        BD Desarrollo        BD Sandbox IA
[NO TOCAR]           [NO TOCAR]           [NUESTRA - SEGURA]

Intocable            Intocable            - Copia solo estructura
                                          - Datos ficticios de prueba
                                          - Se puede romper/recrear
                                          - Cero riesgo
                                          - Cero costo de respaldos
```

**Como crear el sandbox sin afectar nada:**
- Exportar solo la estructura (Structure Only) desde SQLyog — sin datos reales
- Importar en el MySQL local de XAMPP
- Poblar con datos ficticios para pruebas

---

## 7. Formato del entregable final (Reporte)

| Caracteristica | Detalle |
|---|---|
| Formato | Archivo .html descargable |
| Autocontenido | CSS embebido, no depende de archivos externos ni internet |
| Contenido | Tablas de datos, graficas, resumen, secciones navegables |
| Compatibilidad | Se abre en Chrome, Edge, Firefox sin conexion |
| Referencia visual | Estilo similar a documentacion profesional tipo release notes |
| Exportacion adicional | PDF (fase posterior) |

---

## 8. Preguntas abiertas (por resolver)

| # | Pregunta | Impacto en el proyecto | Estado |
|---|---|---|---|
| 1 | Como manejan las APIs actualmente? | Define si hay infraestructura reutilizable | Pendiente |
| 2 | El PHP es framework (Laravel, CodeIgniter) o nativo? | Define complejidad de integracion | Pendiente |
| 3 | Estructura detallada de las BDs (cubos, vistas, SP)? | Define que puede consultar la IA | Pendiente — requiere export de estructura |
| 4 | Los datos pueden salir de la red? | Define si se usa IA cloud o local | Pendiente |
| 5 | Cuantos usuarios usarian el modulo? | Define capacidad y costos | Pendiente |
| 6 | Existe presupuesto para APIs de IA? | Define modelo a usar | Pendiente |
| 7 | Hay regulaciones sobre los datos? | Define restricciones de privacidad | Pendiente |

---

## 9. Cronograma de la Fase 1

| Actividad | Horas estimadas | Estado |
|---|---|---|
| Investigacion de entorno actual (stack, BD, APIs) | 8 | En progreso |
| Evaluacion de modelos de IA | 8 | Pendiente |
| Definicion de arquitectura preliminar | 8 | En progreso |
| Analisis de estructura de cubos (requiere export) | 8 | Pendiente |
| Propuesta tecnica final | 8 | Pendiente |
| **Total** | **40** | |

---

## 10. Proximos pasos inmediatos

| # | Accion | Responsable | Prioridad |
|---|---|---|---|
| 1 | Obtener export de estructura de BD (Structure Only desde SQLyog) | Equipo | Alta |
| 2 | Clarificar como se manejan las APIs en el sistema actual | Equipo | Alta |
| 3 | Confirmar si los datos pueden salir de la red interna | Direccion / Sistemas | Alta |
| 4 | Definir presupuesto disponible para APIs de IA | Direccion | Media |
| 5 | Importar estructura en sandbox local (XAMPP) | Desarrollo | Media |
| 6 | Evaluar modelos de IA con datos ficticios | Desarrollo | Media |

---

*Documento generado como parte de la Fase 1 de Investigacion y Evaluacion Tecnologica.*
*Proyecto: Generador Inteligente de Reportes con IA*
*Fecha: 24 de junio de 2026*
