---
type: decision
created: 2026-06-04
status: accepted
---

# ADR-001: Token Optimization for OpenCode LLM Sessions

## Context

OpenCode loads system prompts, skills, and MCP metadata on every session. Original configuration consumed ~43,000 tokens before any user input:

- **jarvis.md** — 46 KB (~11,500 tokens) → 5 KB (~1,300 tokens) — **89% savings**
- **ryas-gremori.md** — 42 KB (~10,500 tokens) → 2.7 KB (~680 tokens) — **93% savings**
- **zabuza.md** — 1 KB (~250 tokens) → Unchanged — 0%
- **Skills (7)** — 82 KB (~20,500 tokens) → Unchanged — 0%
- **MCP Docker** — ~500 tokens → Unchanged — 0%

**Total before**: ~43,000 tokens per session  
**Total after**: ~23,000 tokens per session  
**Savings**: ~20,000 tokens per session (~47%)

## Decision

1. **Condensed system prompts**: Removed full reference lists (URLs, descriptions, checklists). The model already knows these sources. References are now one-liners listing key names only (e.g., "Refs: Fowler, 12-Factor, Kleppmann DDIA" instead of 15 full paragraphs with URLs).

2. **Eliminated duplication**: JARVIS and Ryas Gremori had ~90% overlapping content. Now they share a condensed domain knowledge format with only the personality layer different.

3. **Knowledge graph for context**: Moved user-specific data (profile, preferences, projects) to `~/jarvis/` knowledge base. The INDEX.md bootstraps context on demand instead of embedding it in the system prompt.

4. **OpenCode config optimizations**:
   - `compaction.auto: true` with `tail_turns: 10` — auto-compacts conversation after 10 turns, keeping only the tail
   - `tool_output.max_lines: 150` and `max_bytes: 4096` — truncates verbose tool outputs
   - `share: disabled` — no telemetry data sent
   - `instructions: ["~/jarvis/INDEX.md"]` — explicit instruction file reference

5. **Skills remain unchanged**: Skills are loaded on-demand by the skill router (only when matching a task), so they don't contribute to every session's base token cost. They're efficient as-is.

## Strategies Not Applied (Yet)

- **`small_model` routing** — Use cheaper/lighter model for subagents and simple tasks — 60-80% on subagent calls — Needs model availability
- **Skill pruning** — Disable skills never used (canvas-design, smithery-ai-cli) — ~15 KB (~3,800 tokens) — Needs user decision
- **MCP Docker conditional** — Start MCP Docker only when needed — ~500 tokens + startup time — Needs testing
- **Dynamic prompt loading** — Load domain-specific references only when task matches — ~5,000 tokens/task — Requires custom plugin
- **Conversation summarization** — Summarize long conversations proactively — Variable — Built-in via compaction

## Consequences

- **Positive**: ~47% token savings per session. System prompts are denser and more actionable.
- **Positive**: Knowledge graph provides persistent context without inflating system prompt.
- **Risk**: Condensed reference lists mean less explicit guidance on checklist items. The model must rely on its training data for detailed checklists.
- **Mitigation**: For tasks requiring detailed checklists (backend, security, DevOps), the skills system provides on-demand context via the skill router.

## Related

- [[Arch Linux]]
- [[Arch Packages]]
- [[Preferences]]
