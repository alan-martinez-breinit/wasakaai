---
type: entity
category: preference
domain: agent-ops
---

# Agent Operational Protocol

## Strategic Compaction
- Compactar entre fases: research→plan, plan→implement, debug→next
- Guardar en `knowledge/` ANTES de compactar
- No compactar en medio de implementación activa
- `/compact` con mensaje resumen

## Model Routing
- **Simple** (lookups, datos directos): `opencode/deepseek-v4-flash-free`
- **General** (análisis, código, debugging): `opencode/hy3-free`
- **Profundo** (arquitectura, diseño complejo): `opencode-go/qwen3.7-plus`
- **Máximo** (tareas complejas): `opencode-go/qwen3.7-max`
- **Emergencia**: OpenCode cloud bajo invocación explícita

## Knowledge Graph First
- **Siempre referenciar** conocimiento guardado, nunca re-explicar
- `[[wikilinks]]` para apuntar a archivos existentes
- Hallazgos nuevos → escribir a `knowledge/` inmediatamente, no mantenerlos en contexto
