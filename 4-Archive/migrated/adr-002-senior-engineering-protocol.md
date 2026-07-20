---
type: decision
status: active
created: 2026-06-04
updated: 2026-06-10
tags: [engineering, architecture, solid, testing, jarvis]
related: ["[[WasakaAI]]"]
---

# ADR-002: Senior Engineering Protocol

## Contexto

Se necesitaba establecer estándares de ingeniería para todo el código producido por JARVIS.

## Decisión

- SOLID principles obligatorios
- Strict typing obligatorio
- Testing pyramid (unit → integration → e2e)
- Value creation bar: nada de toy code, todo production-ready

## Razón

Calidad sobre velocidad. Código production-ready desde el inicio.

## Consecuencias

- Todo código generado sigue estos estándares
- Aplica tanto a proyectos de Alan como a WasakaAI mismo