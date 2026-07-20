---
type: entity
created: 2026-06-23
updated: 2026-07-07
---

# BREINIT

## General

- **Nombre**: BREINIT
- **Rol**: Empleador de [[Alan de Jesus Martinez]]
- **Contexto**: Nueva empresa donde Alan trabaja actualmente
- **Relación**: WasakaAI opera bajo su dominio corporativo

## Equipo Corporativo

- **Laptop**: Dell Latitude 5430 (asignada por la empresa)
- **Etiqueta**: `LAPBREINIT22`
- **SO**: Windows 11 Pro (Build 22631) — instalado el 19/06/2026
- **Serial**: 9JP8NN3
- **Propiedad**: Corporativa — no es equipo personal

## Políticas Aplicables

- **Modo de operación**: WasakaAI opera en **solo lectura** por defecto
- **Sin autorización explícita, no se ejecutan modificaciones** de ningún tipo:
  - No crear, editar ni eliminar archivos
  - No ejecutar comandos con efectos secundarios
  - No modificar configuración del sistema
  - No instalar/desinstalar software
  - No escribir en el registro
  - No realizar cambios de red
- El analisis, diagnóstico y consulta están siempre permitidos

## Contacto / Links

- (Pendiente de recopilar — sitio web, redes corporativas, etc.)

## Frontend PHP Dashboard (v1 — Prototipo Original)

- **Ubicación**: `C:\xampp\htdocs\breinit_frontend_php`
- **Tipo**: Dashboard de gestión automotriz (DCA - Desarrollo)
- **Stack**: PHP nativo + HTML/CSS/JS vanilla, XAMPP
- **Estado**: Prototipo visual / mockup funcional (junio 2026)
- **Análisis completo**: Sesión 2026-07-01 (sesión anterior)

## Frontend PHP Dashboard (v2 — MVC Refactor)

- **Ubicación**: `C:\xampp\htdocs\breinit_php`
- **Tipo**: Dashboard de gestión automotriz refactorizado a MVC
- **Stack**: PHP nativo MVC + HTML/CSS/JS vanilla, XAMPP
- **Estado**: Funcional con datos dummy — seguridad completa implementada
- **Arquitectura**: 
  - Front controller (`index.php`) con `spl_autoload_register`
  - Controladores: `AuthController`, `DashboardController`
  - Core: `Security` (CSRF, sanitización, validación), `RateLimiter` (file-based)
  - Vistas: login, dashboard, sidebar component, filter component
  - Datos: `dummy_users.php` (10 usuarios), `user_menu_items.php` (multi-tenant)
- **Seguridad implementada**:
  - CSRF tokens (generación/verificación/regeneración post-login)
  - Sanitización de entrada (emails, genérico)
  - Detección de SQL injection en inputs
  - Validación de email y longitudes
  - `hash_equals()` para comparación de contraseñas (preparado para bcrypt)
  - `session_regenerate_id()` post-login
  - Rate limiting (5 fallos/email, 10/IP, 15 min lockout, file-based JSON)
  - HTTP 429 response con `remaining_min`
- **Ruteo**: Limpio via `.htaccess` + `REQUEST_URI`, sin `?route=`
- **BASE_URI**: Auto-detección dinámica desde `$_SERVER['SCRIPT_NAME']`
- **Usuarios dummy**: 10 usuarios con fotos i.pravatar.cc
- **Módulos**: 5 (AUTOS_NUEVOS, SEMINUEVOS, TALLER, H_P, REFACCIONES) × 2 tipos ($/#) = 10 tablas
- **Multi-tenant**: Menú por usuario según permisos por módulo
- **UI**: Pure CSS (sin Tailwind), bento grid dashboard, donut chart, sidebar con iconos, toasts, filtros reutilizables
- **Bug encontrado y corregido**: Variable `$type` sobrescrita por `filters.php` (foreach usaba `$type` como variable del filtro, pisando el `$type` del módulo `$`/`#`). Fix: renombrar a `$filterType`.
- **Pendiente**: BD real MySQL, hashing bcrypt, migración a PDO, logs de actividad

## Frontend PHP Dashboard (v3 — FastAPI Gateway)

- **Ubicación**: `C:\xampp\htdocs\php_frontend`
- **Tipo**: Dashboard de gestión automotriz (DCA - Desarrollo) conectado a backend real
- **Stack**: PHP nativo 8+ + HTML/CSS/JS vanilla, XAMPP, cURL
- **Backend**: FastAPI en `https://breinit-backend-dca.onrender.com`
- **Estado**: Funcional con backend productivo (julio 2026)
- **Arquitectura**:
  - Entry point `index.php` → redirección a login o dashboard
  - `lib/` → configuración (`config.php`) y cliente API (`api_client.php`) con cURL/cURL multi
  - `includes/` → autenticación/seguridad (`auth.php`), módulos por cliente (`modulos.php`), logos (`logos.php`)
  - `auth/` → login/logout
  - `pages/` → dashboard, módulos genéricos, objetivos de servicio, one-page autos (nuevos/usados), one-page taller
  - `assets/` → CSS/JS por vista, fuentes Google, iconos Material Symbols
- **Seguridad implementada**:
  - CSRF tokens con `hash_equals()`
  - Rate limiting por IP/email en sesión (5 fallos → 15 min bloqueo)
  - Headers OWASP: CSP con nonce, HSTS, X-Frame-Options, etc.
  - Cookie params: HttpOnly, Secure según HTTPS, SameSite Strict
  - `session_regenerate_id(true)` post-login
  - Validación SSRF en endpoints de API, verificación SSL, no redirects
  - Sanitización de emails, fechas, enteros, strings
  - Protección de logos contra path traversal
  - `.htaccess` bloquea listado de directorios, archivos sensibles y acceso a `/logs`, `/includes`, `/lib`
- **Clientes soportados**: `0003`, `0579` con menús de módulos hardcodeados
- **Módulos**: CXC, Industria, Inventario Autos/Refacciones, Objetivo Autos/Servicio, Ventas Autos, Venta Servicio Refacciones, Finanzas (0579)
- **Observaciones desde análisis 2026-07-07**:
  - No usa Composer ni autoloading
  - No hay tests automatizados
  - Lógica de presentación mezclada con HTML
  - Configuración backend hardcodeada en `lib/config.php`
  - Rate limiting basado en sesión (no Redis/memcached)
  - Dashboard hace llamadas secuenciales a `/count` en lugar de usar `apiGetParalelo`

## Related

- [[Alan de Jesus Martinez]]
- [[Dell Latitude 5430]]
- [[Windows 11]]
