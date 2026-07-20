# ECC — Everything Claude Code (Agent Harness OS)

## Overview

ECC v2.0.0 is an agent harness operating system providing 262 skills, 25+ specialized subagents, 35 slash commands, custom tools, and security workflows. Originally built for Claude Code, now cross-harness (Claude Code, Cursor, OpenCode, Codex, Gemini, Zed, GitHub Copilot).

**Repo**: https://github.com/affaan-m/ecc  
**Local**: `~/build/ecc/`  
**Author**: affaan-m (Anthropic Hackathon winner)

## Integration with JARVIS/OpenCode

ECC is integrated into `~/.config/opencode/` alongside JARVIS. The identity stays JARVIS — ECC adds the subagent layer, skills, and commands.

### Configuration
- **Main config**: `~/.config/opencode/opencode.json` — Merged JARVIS + ECC config
- **Default agent**: `jarvis` (preserved, identity unchanged)
- **Instructions**: `~/jarvis/INDEX.md` (JARVIS memory) + `instructions/ECC-INSTRUCTIONS.md` (ECC coding standards)

### Installed Components

| Component | Path | Count |
|-----------|------|-------|
| Skills | `~/.config/opencode/skills/` | 262 |
| Commands | `~/.config/opencode/commands/` | 35 |
| Agent Prompts | `~/.config/opencode/prompts/agents/` | 25 |
| Instructions | `~/.config/opencode/instructions/ECC-INSTRUCTIONS.md` | 1 |
| Tools | `~/.config/opencode/tools/` | 8 (run-tests, check-coverage, security-audit, format-code, lint-check, git-summary, changed-files) |
| Plugins | `~/.config/opencode/plugins/` | ecc-hooks, index |

### Key Subagents Available

- **planner** — Implementation planning for complex features
- **architect** — System design, scalability, technical decisions
- **code-reviewer** — Code quality, security, maintainability review
- **security-reviewer** — Vulnerability detection and remediation
- **tdd-guide** — Test-Driven Development enforcement
- **build-error-resolver** — Build/type error resolution
- **e2e-runner** — Playwright E2E testing
- **doc-updater** — Documentation and codemaps
- **refactor-cleaner** — Dead code cleanup
- **database-reviewer** — PostgreSQL/Supabase specialist
- **python-reviewer** / **rust-reviewer** — Language-specific review
- **docs-lookup** — Context7 MCP documentation lookup
- **loop-operator** — Autonomous loop monitoring
- **harness-optimizer** — Agent config tuning

### Key Slash Commands

`/plan`, `/tdd`, `/code-review`, `/security`, `/build-fix`, `/e2e`, `/refactor-clean`, `/orchestrate`, `/learn`, `/checkpoint`, `/verify`, `/eval`, `/update-docs`

### Skills Highlights (262 total)

TDD workflow, security review, coding standards, frontend/backend patterns, E2E testing, verification loops, API design, strategic compaction, eval harness, continuous learning, instinct system, and 250+ more domain-specific skills.

## Build & Update

```bash
# Rebuild plugin (after updates)
cd ~/build/ecc/.opencode && npm run build

# Copy updated components
cp -r ~/build/ecc/.opencode/commands/* ~/.config/opencode/commands/
cp -r ~/build/ecc/.opencode/prompts/agents/* ~/.config/opencode/prompts/agents/
```

## Notes

- JARVIS identity is **preserved** — ECC adds capability, doesn't replace personality
- Model remains `opencode-go/glm-5.1` for all agents
- The `{file:prompts/agents/X.txt}` syntax in opencode.json resolves relative to `~/.config/opencode/`
- Skills are loaded on-demand via trigger tables, not all at once

---

*Installed: 2026-06-11*