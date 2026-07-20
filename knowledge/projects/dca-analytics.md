# DCA Analytics (Grupo Continental Automotriz)

## Estado
- Proyecto en desarrollo activo (local en XAMPP, ruta: `C:\xampp\htdocs\php_frontend\`)
- Login funcional con sesiones PHP y 4 usuarios dummy
- Dashboard con sidebar de 18 KPIs, navegación por secciones (hash-based)
- Migrado de `breinit_frontend_php` a `php_frontend`
- Pendiente despliegue a servidor producción

## Servidores
- **Hosting**: cPanel, servidor compartido
- **FTP**: `ftp.dcadealerapp.com` (o `162.215.121.103:21`)
- **FTP User**: `desarrollo@dcadealerapp.com`
- **FTP Pass**: `DesaDCA2026*`
- **Ruta servidor**: `/home2/dca/public_html/desarrollo/`
- **URL pública**: `https://dcadealerapp.com/desarrollo/`

## Base de Datos
- **Host**: `162.215.121.103:3306`
- **User**: `dca_desarrollo`
- **Pass**: `DesaDCA2026*`
- **BD**: `dca_desarrollo_bd`
- **Motor**: MySQL 5.7.23-23
- **Estado**: Vacía (sin tablas)

## Stack Actual (Local)
- **PHP 8+** con sesiones para autenticación
- **Pure CSS** — sin Tailwind, sin frameworks
- **Componentes reutilizables**: Topbar, Tabla, Sidebar
- Archivos separados: CSS, JS por página
- CSP con nonce para scripts y styles inline

## Estructura de Archivos (2026-07-07)
```
C:\xampp\htdocs\php_frontend\
├── login.php                    ← Auth, logout
├── dashboard.php                ← Layout + includes
├── one_page.php                 ← Reporte unificado (one page)
├── one_page_taller.php          ← Reporte taller
├── modulo.php                   ← Módulo general
├── cxc.php                      ← CxC
├── objetivos_servicio.php       ← Objetivos servicio
├── Documentation.md             ← Componentes API docs
├── components/
│   ├── topbar.php               ← Topbar reutilizable (3 modos)
│   ├── tabla.php                ← Tabla genérica con columnas definidas
│   └── sidebar.php              ← Sidebar deslizable (overlay + panel + form)
├── includes/
│   ├── auth.php                 ← Auth, CSP headers (con nonce fix)
│   └── logos.php
├── lib/
│   ├── config.php
│   └── api_client.php
├── assets/
│   ├── css/
│   │   ├── one_page.css, one_page_taller.css, dashboard.css, modulo.css
│   │   ├── sidebar.css, tabla.css, topbar.css, login.css, objetivos_servicio.css
│   └── js/
│       ├── one_page.js, topbar.js, sidebar.js, dashboard.js
└── dummy/
    └── users.json               ← 4 usuarios (plain-text passwords)
```

## Componentes de UI

### Topbar (`components/topbar.php`)
- 3 modos: `completo` (filtros + perfil), `sencillo` (solo perfil), `dashboard`
- Clase `.topbar-comp` para evitar conflicto con `.topbar` nativo del dashboard
- CSS: `assets/css/topbar.css`, JS: `assets/js/topbar.js`

### Tabla (`components/tabla.php`)
- Función `renderTabla(array $params): void`
- Parámetros: `columnas` (id, label, clase, raw_id, html, formato, formula, clase_campo), `filas`, `totales`, `clase_tabla`, `clase_tfoot`, `vacio`, `click`
- Genera `<div class="tabla-wrap"><table class="tabla">`
- Soporta: `data-col-id`, `data-col-formato`, `data-col-formula` en `<th>`

### Sidebar (`components/sidebar.php`)
- Función `renderSidebar(string $titulo, callable $contentCallback): void`
- Genera overlay + panel con header + body
- Botón cerrar, click outside cierra
- JS global: `window.openSidebar()`, `window.closeSidebar()`

## Column Formulas (one_page.php — tablaVentaDinero)

| Backend ID | Label | Formato | Fórmula |
|-----------|-------|---------|---------|
| sucursal | Sucursal | texto | — |
| venta | Venta | $#,##0 | — |
| obj_dia | Obj al Día | $#,##0 | — |
| alc_ritmo | %Alcance Ritmo | #,##0% | {(22) MARGEN BRUTO} / {(32) OBJETIVO AL DIA} |
| obj_mes | Obj Ventas | $#,##0 | — |
| alc_obj | %Alcance Objetivo | #,##0% | {(2) VENTA} / {(20) OBJETIVO VENTAS} |
| margen | Margen Bruto | $#,##0 | — |
| pct_margen | %Margen | #,##0% | {(22) MARGEN BRUTO} / {(2) VENTA} |
| obj_margen_dia | Obj Margen/Día | $#,##0 | — |
| alc_ritmo_margen | %Alcance Ritmo | #,##0% | — |
| obj_margen_mes | Obj Margen | $#,##0 | — |
| alc_obj_margen | %Alcance Objetivo | #,##0% | {(22) MARGEN BRUTO} / {(24) OBJETIVO MARGEN} |
| cartera | Cartera | $#,##0 | — |
| inv_uds | Inventario | #,##0 | — |
| inv_valor | Inventario $ | $#,##0 | — |
| mv | MV | #,##0 | {(28) INVENTARIO} / {(34) Obj Vta Uds Mensual} |

## Inventario %Part. Formulas (one_page.php — tablaInventario)
- Cada rango genera fórmula automática: `{(2|4|6|...) [Label]} / {(19) [Label]}`
- Label: "Uds Existencia" o "Inventario $" según `$esMoneda`
- Total %Part. NO lleva fórmula

## Secciones
- **Autos Nuevos** → títulos dicen "Autos". Sidebar funcionando con formulario (Modelo, Título, Formato, Fórmula)
- **Autos SemiNuevos** → títulos dicen "SemiNuevos". Mismas fórmulas y mismo sidebar. Formulario puede diferir (pendiente info del usuario)

## Mapa de Componentes por Página
- `one_page.php` → Topbar completo ✅, Tabla ✅, Sidebar ✅ (click en headers)
- `one_page_taller.php` → Topbar ✅ (pendiente Tabla)
- `modulo.php` → Topbar ✅, Tabla ✅
- `cxc.php` → Topbar ✅, Tabla ✅
- `objetivos_servicio.php` → Topbar (require agregado, CSS/JS pendientes)
- `dashboard.php` → Topbar parcial (CSS adaptado, requiere más ajustes)

## Historial de Sesiones
- 2026-07-07: Refactor completo a componentes (Topbar, Tabla, Sidebar). CSP fix. Sidebar con fórmulas dinámicas por columna. Separación Nuevos/SemiNuevos.

## Pendientes (2026-07-07)
- [ ] Despliegue a producción via FTP
- [ ] Migrar autenticación a BD MySQL
- [ ] Conectar tablas a datos reales de la BD
- [ ] Definir páginas post-login si se requieren más vistas
- [ ] Completar Topbar en objetivos_servicio.php (CSS+JS)
- [ ] Completar Topbar en dashboard.php
- [ ] Aplicar Tabla en one_page_taller.php
- [ ] Formulario sidebar para SemiNuevos (info pendiente del usuario)

## Contacto
- **Cynthia** — proporcionó accesos. +52 1 81 8088 9987

## Decisiones Técnicas
- Pure CSS (no Tailwind) — req del proyecto
- Componentes vía PHP includes (no framework SPA)
- Hash routing en JS (sin page reload, sin AJAX, solo dashboard legacy)
- Secciones cargadas todas en DOM, visibilidad por CSS/JS (legacy dashboard)
- CSP con nonce para scripts y styles inline
- Sidebar con posición fixed (no afectado por overflow de contenedores)
