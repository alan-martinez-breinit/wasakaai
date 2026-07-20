---
type: reference
created: 2026-06-04
updated: 2026-06-04
---

# OpenCode

## Status

- **Installed**: OpenCode 1.15
- **Role**: Primary AI-assisted editor
- **Config**: Custom system prompts (JARVIS), skill integrations

## Integration

- Connected to [[Open Design]] daemon (Tier 1 agent support)
- Loads [[JARVIS]] system prompt on startup
- Hook system: pre-tool, pre-model, post-model

## Key Config

- `compaction.auto: true` with `tail_turns: 10`
- `instructions: ["~/jarvis/INDEX.md"]`
- Skills loaded on-demand via router

## Related

- [[Alan de Jesus Martinez]]
- [[JARVIS]] (system prompt)
- [[Open Design]]
