# ADR 005 — H&P Company Filter: Full-Page Client-Side Scoping

**Date**: 2026-07-10
**Status**: Accepted (supersedes the earlier hybrid attempt)
**Context**: DCA is multitenant. The H&P "One Page" report's company filter did not change the data.
Verified against live client `0003`: the backend's `/one-page/reporte-hp` **accepts** a `compania`
query param (200) but **ignores it** (identical full report regardless), and per-day/per-status
tables carry no `compania` on their rows. `HpBranch.compania` IS populated (4 companies), and all
tables share the same `sucursal` strings as `report.sucursales`.

**Decision**: Implement **pure client-side, full-page filtering**:
1. New `src/lib/hp-report-filter.ts` — `filterHpReportByCompania(report, compania)` filters
   `report.sucursales` by `compania`, and the day tables (`ordenes_recibidas`,
   `ordenes_facturadas`) and status cards (`ordenes_estatus`) by a `sucursal -> compania` map
   built from `report.sucursales`. Totals are recomputed per table (sum additive fields; percentage
   fields recomputed from summed totals; ticket/pct averages left null).
2. `HpPage` drives every table from the filtered report via `useMemo`.
3. The `compania` query param was removed from `fetchHpReport`/`useHpReport` — it caused a wasteful
   refetch + CORS preflight on every selection with no effect. The hook still owns `selectedCompania`
   and `allCompanias` (cached from the full report so the dropdown never shrinks).

**Rationale**:
- The backend does not honor `compania`, so server-side scoping is impossible without a backend
  change. Client-side is the only working path.
- Full-page filtering matches Autos Nuevos (the user's reference for "working"), not Taller's
  Venta-only filter. The `sucursal -> compania` map makes every table filterable.
- Recomputing totals keeps the page internally consistent (rows + totals agree).

**Alternatives considered**:
- Server-side `compania` param (hybrid): rejected — backend ignores it; the refetch only added
  latency and a CORS preflight.
- Venta-only client filter (Taller-style): rejected — user expects all tables to react.

**Consequences**:
- Selecting a company now scopes every H&P table. If the backend is later fixed to honor `compania`,
  the client filter remains correct (idempotent on already-filtered data) and the param can be
  re-added for true server-side scoping.
- If the backend ever returns day/status `sucursal` values not present in `report.sucursales`, those
  rows would be dropped by the filter (verified not the case for client `0003`).
