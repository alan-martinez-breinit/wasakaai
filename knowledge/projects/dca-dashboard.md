# Dca Dashboard

Frontend React + Vite del ecosistema DCA (reportes One Page: Autos Nuevos/Seminuevos, Taller, H&P, Refacciones, Experto). Repo: `alan-martinez-breinit/dca-dashboard`.

## Deploy (producción)
- URL: `https://dcadealerapp.com/desarrollo/alan/` — **subcarpeta**, no raíz del sitio (WordPress).
- Método: **FileZilla** (subir contenido de `dist/`). No se usa Vercel en producción.
- Build obligatorio: `npm run build:filezilla` (define `VITE_BASE_URL=/desarrollo/alan/` + `VITE_ROUTER_BASENAME=/desarrollo/alan`). Nunca `npm run build` (quita basename/base).
- `vite.config.ts`: `base: process.env.VITE_BASE_URL ?? "/"`.
- `public/.htaccess`: SPA fallback → `/desarrollo/alan/index.html` (CRÍTICO para recargas de deep links).

## Backend
- `https://breinit-backend-dca.onrender.com/api` (cross-origin). `VITE_API_BASE_URL` en `.env`.
- Auth: `VITE_API_KEY` (bearer) para endpoints one-page; JWT de sesión para Experto.
- `VITE_TURNSTILE_SITE_KEY` definido pero backend NO verifica token Turnstile (gap de seguridad conocido).

## Arquitectura caché (frontend)
- `src/lib/report-cache.ts`: caché multi-tier (memoria + sessionStorage, TTL 30 min, SWR 5 min, deduplicación).
- Hooks `use-one-page-report`, `use-workshop-report`, `use-hp-report`, `use-refacciones-report`: al montar usan `refrescar=false` (no bustean caché server).
- `src/lib/one-page-export/fetch-sections.ts`: export Completo lee caché client-first, fetchea solo lo faltante en paralelo.

## Fixes aplicados (2026-07-14)
| Commit | Cambio |
|---|---|
| `5bb2ab5` | Analytics/Speed Insights tras flag `VITE_VERCEL_ANALYTICS`. |
| `67e1b5d` | Router `basename` env-driven (`VITE_ROUTER_BASENAME`). |
| `039c381` | Script `build:filezilla`. |
| `f63e918` | Imágenes con `BASE_URL` + switch de reportes sin force-refresh. |
| `59a98b0` | Iconos Lucide (`LuCar`/`LuHistory`) en Autos; logo Ceslo `h-11`. |
| `8108a55` | Export OnePage Completo usa caché client-first (no refetch total). |
| `a296ec6` | `.htaccess` SPA fallback correcto a `/desarrollo/alan/index.html`. |

## Feature activa: diseños self-service (subida de OnePage rediseñado por cliente)
- **Objetivo**: el cliente (logueado) sube su HTML de OnePage rediseñado por IA para publicarlo en la nube y verlo, **sin que Breinit pase el archivo por FTP**. Solo "pintura" (estilos), sin lógica.
- **Ramas**: `feature/one-page-disenos` en `dca-dashboard` y `breinit-backend-dca` (NO se tocó `main`). Pendiente: abrir PR / revisar / mergear.
- **Backend** (`C:\Users\Breinit\Downloads\breinit-backend-dca`):
  - Router `/api/one-page/disenos` (`src/routes/one_page/one_page_diseno_route.py`), protegido con `require_session` (JWT); tenant = `codigo_cliente` del token (nunca del body). Endpoints: `POST /`, `GET /`, `GET /{id}`, `DELETE /{id}`.
  - `src/services/one_page_diseno_service.py`: sanitiza con `nh3` (allowlist de etiquetas/atributos), depura CSS (quita `url()`, `expression`, `@import`, `javascript:`), inyecta CSP `script-src 'none'` + charset en `<head>`, y guarda en tabla `disenos_one_page` (MySQL, LONGTEXT; creada idempotentemente).
  - `requirements.txt`: agregado `nh3`.
  - `src/middlewares/body_size_limit.py`: soporte `exclude_prefixes`/`exclude_max_bytes`; `main.py` permite 5 MB solo en `/api/one-page/disenos` (el global sigue en 10 KB).
- **Frontend** (`C:\Users\Breinit\Downloads\dca-dashboard`):
  - `src/lib/diseno-service.ts`: `listDisenos/saveDiseno/getDiseno/deleteDiseno` con JWT de sesión (`getAuth().token`).
  - `src/pages/DisenosPage.tsx`: carga HTML (archivo/textarea), lista, elimina, y vizualiza en `<iframe srcDoc sandbox="">` aislado (sin scripts ni sesión).
  - Ruta `/disenos` en `src/routes/index.tsx`; item "Mis diseños" en sidebar (`src/lib/modules.tsx`, icono `FiLayout`).
- **Modelo de seguridad**: sanitización server-side (defensa en profundidad) + render en iframe `sandbox=""` (garantía final: no ejecuta JS ni formularios). El cliente debe subir HTML autocontenido con `<style>`, sin `<script>` ni CDNs JS.
- **Siguiente fase (Path B)**: botón in-app "Mejorar con IA" (LLM server-side, key en Render env, prompt estricto conservar números/texto). El "conector Claude Code" quedó descartado (es herramienta de dev, no runtime).

## Pendiente
- Abrir PR y revisar `feature/one-page-disenos` (backend + frontend) antes de mergear a `main`.
- Backend: instalar `nh3` en Render (requirements.txt ya incluido).
- CORS en Render: confirmar `CORS_ORIGINS` incluye `https://dcadealerapp.com` (y `http://localhost:5173` para dev). → El app ya funciona en navegador, por lo que CORS está resuelto en la práctica.
- ~~Verificar `AllowOverride` para `.htaccess` en `desarrollo/alan/`~~ → **RESUELTO** (usuario validó recarga de deep link tras subir `.htaccess`).
