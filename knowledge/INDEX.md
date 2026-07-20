# WasakaAI — Knowledge Index

> Persistent memory for the DCA project work. Bootstrapped 2026-07-14.
> Convention: `[[Title Case]]` wikilinks map to kebab-case filenames under `knowledge/`.

## User
- Breinit / Alan (cliente DCA). Despliega frontend vía **FileZilla** (no Vercel en producción). Trabaja en Windows. Idioma: español.

## Active Projects
- [[Dca Dashboard]] — frontend React + Vite (reporte One Page, Taller, H&P, Refacciones, Experto).
- [[Breinit Backend Dca]] — FastAPI en Render (reportes, caché server-side).

## Sessions
- [[2026-07-14]] — fixes: iconos Lucide Autos, logo Ceslo, export OnePage lento, reload 404 SPA fallback.

## Key Decisions
- Deploy producción: `https://dcadealerapp.com/desarrollo/alan/` (subcarpeta, NO raíz). Build con `npm run build:filezilla`.
- Backend en `onrender.com` (cross-origin desde dcadealerapp.com); CORS debe permitir `https://dcadealerapp.com`.
- Vercel solo para previews; no se usa en el sitio de cliente.
