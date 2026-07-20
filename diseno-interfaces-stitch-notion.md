# Diseno de Interfaces

**Proyecto:** Generador Inteligente de Reportes con IA
**Fecha:** 24 de junio de 2026

---

## 1. Herramienta seleccionada

| Decision | Detalle |
|---|---|
| **Herramienta** | Google Stitch |
| **Proveedor** | Google Labs |
| **URL** | https://stitch.withgoogle.com/ |
| **Precio** | Gratuito (350 generaciones al mes) |
| **¿Que hace?** | Genera interfaces de usuario (UI) desde texto en lenguaje natural |

---

## 2. ¿Por que Google Stitch?

| Criterio | Stitch |
|---|---|
| Como se usa | Escribes en texto lo que quieres y la IA genera el diseno |
| Que genera | Pantallas completas para web y mobile |
| Exporta a | HTML, CSS, Tailwind, React, Vue, Angular, Flutter, Figma |
| Conexion con desarrollo | Tiene exportacion via MCP a Claude Code |
| Costo | Gratis — solo necesitas una cuenta de Gmail |
| Requisito | Ninguno — se usa desde el navegador |

---

## 3. Que se va a disenar

Vamos a disenar **3 pantallas clave** del sistema:

### Pantalla 1: Portal de consulta

Es la pagina principal donde el usuario escribe su pregunta.

```
+----------------------------------------------------+
|  [Logo]  Generador de Reportes                      |
|                                                     |
|  Escribe tu pregunta:                               |
|  +----------------------------------------------+  |
|  | Ventas de autos por region en marzo            |  |
|  +----------------------------------------------+  |
|                                                     |
|  [  Generar Reporte  ]                              |
|                                                     |
|  Reportes recientes:                                |
|  - Ventas por region (hace 2 dias)                  |
|  - Inventario actual (hace 5 dias)                  |
+----------------------------------------------------+
```

**Elementos:**
- Titulo del sistema
- Campo de texto donde el usuario escribe su pregunta
- Boton "Generar Reporte"
- Historial de reportes recientes
- Selector de idioma / ayuda

### Pantalla 2: Vista previa del reporte

Lo que el usuario ve despues de generar el reporte, antes de descargar.

```
+----------------------------------------------------+
|  Reporte generado exitosamente                      |
|                                                     |
|  Pregunta: Ventas de autos por region en marzo      |
|  Fecha: Marzo 2026                                  |
|  Fuente: Cubo de Ventas Autos                       |
|                                                     |
|  +------------------------------------------------+ |
|  |  Tabla: Ventas por region                       | |
|  |  Region    | Unidades | Total    | %            | |
|  |  Norte     | 1,250    | $12.5M   | 35%         | |
|  |  Centro    | 980      | $9.8M    | 27%         | |
|  |  Sur       | 750      | $7.5M    | 21%         | |
|  |  Occidente | 620      | $6.2M    | 17%         | |
|  +------------------------------------------------+ |
|                                                     |
|  [  Descargar .html  ]   [  Nuevo Reporte  ]       |
+----------------------------------------------------+
```

**Elementos:**
- Confirmacion de que el reporte se genero
- La pregunta original del usuario
- Fecha y fuente de los datos
- Tabla con los resultados
- Botones: Descargar y Nuevo Reporte

### Pantalla 3: Reporte .html descargado

El archivo final que el usuario descarga. Es **autocontenido** (se abre sin internet).

```
+----------------------------------------------------+
|  REPORTE DE VENTAS                                 |
|  Generado: 24 de junio de 2026                     |
|  Periodo: Marzo 2026                               |
|                                                     |
|  +------------------------------------------------+ |
|  |  Grafica de barras (ventas por region)         | |
|  |  [Insertar grafica aqui]                       | |
|  +------------------------------------------------+ |
|                                                     |
|  Resumen Ejecutivo:                                 |
|  La region Norte lidero las ventas de marzo         |
|  con $12.5M, seguida por Centro con $9.8M.         |
|  El total del mes fue de $36M.                     |
|                                                     |
|  +------------------------------------------------+ |
|  |  Tabla detallada                               | |
|  +------------------------------------------------+ |
|                                                     |
|  [Imprimir]  [Exportar PDF]                        |
+----------------------------------------------------+
```

**Elementos:**
- Titulo del reporte
- Fecha de generacion
- Grafica de los datos
- Resumen ejecutivo (explicacion de los numeros)
- Tabla detallada
- Opciones de impresion o exportacion

---

## 4. Flujo de diseno a implementacion

```
Usted (Google Stitch)              Equipo (implementacion)
───────────────────────             ──────────────────────

Disena Pantalla 1       ─────►     Companero: PHP
(Portal de consulta)               (frontend del portal)

Disena Pantalla 2       ─────►     Companero: PHP
(Vista previa)                     (frontend del portal)

Disena Pantalla 3       ─────►     Usted: FastAPI
(Reporte .html)                    (backend genera el .html)

Exporta via MCP         ─────►     Opcional: acelerar
(Stitch a Claude Code)             implementacion
```

---

## 5. Proceso de trabajo con Stitch

| Paso | Actividad |
|---|---|
| 1 | Usted abre Stitch en el navegador (stitch.withgoogle.com) |
| 2 | Describe la pantalla que quiere en texto: *"Portal de consulta con campo de texto y boton"* |
| 3 | Stitch genera el diseno visual |
| 4 | Usted ajusta y refina hasta que quede como quiere |
| 5 | Exporta el diseno o toma captura de pantalla |
| 6 | Comparte la referencia con el equipo |

---

## 6. Notas importantes

- Los disenos de Stitch son una **guia visual**, no el producto final
- El companero de PHP tomara los disenos como referencia para programar el portal
- Usted tomara el diseno del reporte .html y lo implementara en FastAPI
- Stitch no reemplaza la programacion — solo acelera la definicion de como se ve

---

*Documento de definicion de Diseno de Interfaces*
*Herramienta seleccionada: Google Stitch*
