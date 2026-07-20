# ADR-004: WasakaAI Identity

## Context

JARVIS was the initial identity for the AI assistant system. As the system evolved to incorporate ECC v2.0.0 (262 skills, 25 subagents, 35 commands), it outgrew the generic JARVIS branding. The user (Alan de Jesus Martinez) owns the Wasaka Be brand and wants the AI assistant to carry his personal brand identity.

## Decision

**Rebrand from JARVIS to WasakaAI.**

WasakaAI is:
- The same system prompt personality (British composure, senior engineering rigor)
- The same knowledge graph (migrated from `~/jarvis/` to `~/WasakaAI/knowledge/`)
- Enhanced with ECC v2.0.0 as the capability layer
- Branded under the Wasaka ecosystem
- Hosted at `https://github.com/wasakabeofficial/WasakaAI`

## Consequences

- **Positive**: Personal brand alignment, professional identity, public repo for portfolio
- **Positive**: All JARVIS knowledge preserved verbatim — no data loss
- **Positive**: ECC integration adds 262 skills and 25 subagents to the same personality
- **Neutral**: Knowledge path changes from `~/jarvis/` to `~/WasakaAI/knowledge/`
- **Risk**: Any hardcoded references to "jarvis" in scripts or configs need updating

## Migration Map

| Before (JARVIS) | After (WasakaAI) |
|-----------------|-------------------|
| `~/jarvis/` | `~/WasakaAI/knowledge/` |
| `~/.opencode/agent/jarvis.md` | `~/.opencode/agent/wasakaai.md` |
| JARVIS identity | WasakaAI identity (same personality, new name) |
| Standalone agent | ECC-powered (262 skills, 25 subagents) |

## Date

2026-06-11