# Herramienta de Diseno de Interfaces

**Decision:** Google Stitch
**Proveedor:** Google Labs
**URL:** https://stitch.withgoogle.com/
**Estado:** Aprobado

---

## ¿Por que Stitch?

| Criterio | Stitch |
|---|---|
| Tipo de herramienta | Generacion de UI desde lenguaje natural / voz |
| Precio | Gratuito (350 generaciones al mes) |
| Que genera | Pantallas completas para web y mobile |
| Exporta a | HTML, CSS, Tailwind, React, Vue, Angular, Flutter, Figma |
| Conexion con desarrollo | Exporta via MCP directo a Claude Code y Cursor |
| Lo que disenaremos | Portal de consulta + formato del reporte .html |

---

## Que vamos a disenar con Stitch

| Pantalla | Descripcion |
|---|---|
| **Portal de consulta** | Pagina donde el usuario escribe su pregunta en lenguaje natural y hace clic en "Generar Reporte" |
| **Vista previa del reporte** | Resultado de la consulta mostrado en pantalla antes de descargar |
| **Reporte .html descargado** | Estilo profesional del archivo final que el usuario recibe |

---

## Flujo de diseno a implementacion

```
Stitch (diseno)
    │
    ├── Diseno del portal de consulta → lo toma PHP (comapagno)
    │
    ├── Diseno del reporte .html → lo toma FastAPI (backend IA)
    │
    └── Exportacion via MCP → opcional para acelerar implementacion
```

---

## Notas

- Stitch se usa en Fase 1 (Investigacion) para definir el aspecto visual
- Los disenos finales se entregan como referencia para el equipo
- No reemplaza el desarrollo, solo guia la implementacion
