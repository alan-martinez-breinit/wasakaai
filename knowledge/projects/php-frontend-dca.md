# php_frontend (DCA Analytics)

PHP BFF que consume FastAPI (breinit-backend-dca.onrender.com) vía cURL servidor-a-servidor. Token JWT solo en $_SESSION.

## Estructura
- `lib/api_client.php` — GET/POST/paralelo con guarda SSRF
- `includes/auth.php` — sesión, CSRF, rate-limit, headers, logging
- `components/` sidebar, tabla, topbar (tríada PHP/CSS/JS)
- `pages/` dashboard, cxc, modulo, objetivos_servicio, one_page, one_page_taller

## Hallazgos (2026-07-07)
1. [MEDIO] Rate-limit en $_SESSION → ineficaz vs brute-force anónimo. Usar store persistente IP+email.
2. [BAJO] `.htaccess` no bloquea `.json` → session-snapshot-*.json descargable.
3. [BAJO] `renderTabla` html=>true escupe crudo del backend (confiar en que es estructurado).
4. [BUG] `apiGetParalelo` reasigna $resultados=[] en línea 124, borra errores de endpoints inválidos.
5. [MENOR] FILTER_SANITIZE_EMAIL deprecado PHP 8.1+. remember-me es feature muerta.

## Fortalezas
Cookies HttpOnly+SameSite=Strict, session_regenerate_id en login, CSP+nonce, SSL verify, inputs sanitizados, error handlers sin fuga.

## Pendiente
Sidebar en modulo/cxc/dashboard; Topbar JS/CSS en objetivos_servicio/dashboard; Tabla en one_page_taller.

## Fixes aplicadas (2026-07-07)
- Rate-limit movido de $_SESSION a almacenamiento en archivo (`data/rate_limit.json` + lock). Ahora efectivo vs brute-force anónimo.
- `.htaccess`: añadido `json` a bloqueo y protector de `/data/`.
- `api_client.php`: corregido bug en apiGetParalelo (reset de $resultados borraba errores de endpoints inválidos); añadida caché en disco (TTL 60s, bypass con refrescar=true).
- `tabla.php`: `sanitizeHtmlFragment()` en columnas html=>true (defense-in-depth sobre CSP).
- Verificado con php -l (sin errores).

## Sidebar de detalle (2026-07-07)
- Helper `includes/sidebar_detail.php`: `sidebarDetalleVisible()`, `sidebarDetalleHeadLink()`, `renderSidebarDetalle($titulo)`.
- Aplicado en cxc, modulo, one_page_taller, objetivos_servicio, dashboard. EXCLUIDO one_page.php (ya tiene su propio sidebar de edición de columnas).
- Regla de seguridad: el panel se oculta cuando `$_SERVER['QUERY_STRING']` no está vacío (vistas filtradas/paginadas/enlaces compartidos no exponen el panel).
- JS: clic en `<tbody tr>` de cualquier `table` con `thead` → muestra etiqueta/valor por columna en `#rowContext`. Contenido escapado (esc) → sin XSS.
- Panel es SOLO LECTURA (detalle). Backend no expone endpoints PUT/PATCH de edición; para edición real hay que añadirlos primero.
- cxc.php refactorizado para usar el helper (eliminado bloque manual duplicado).

## Pendiente
Sidebar en modulo/cxc/dashboard; Topbar JS/CSS en objetivos_servicio/dashboard; Tabla en one_page_taller. (Nota: sidebar ya cubierto vía helper; objetivos_servicio/dashboard ya tienen sidebar de detalle).
