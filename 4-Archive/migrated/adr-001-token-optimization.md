---
type: decision
status: active
created: 2026-06-04
updated: 2026-06-10
tags: [architecture, tokens, optimization, jarvis]
related: ["[[WasakaAI]]"]
---

# ADR-001: Token Optimization

## Contexto

JARVIS gastaba tokens repetiendo contexto en cada sesión. Se需要一个 sistema que persistiera conocimiento sin desperdiciar tokens.

## Decisión

- System prompts condensados
- Knowledge graph para contexto persistente (Markdown + YAML + wikilinks)
- Obsidian-compatible para interfaz visual
- Leer INDEX.md al inicio y solo cargar lo relevante

## Razón

47% ahorro de tokens. Contexto persistente sin repetición. Interfaz visual con Obsidian.

## Consecuencias

- Este knowledge baseEVOLUCIONÓ a WasakaAI
- La estructura PARA+ es más robusta que el formato original
- Los wikilinks se mantienen compatibles