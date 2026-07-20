# WasakaAI 🧠⚡

**Just A Rather Very Intelligent System** — An elite AI assistant with British composure, 15+ years of cross-domain expertise, and the full power of ECC v2.0.0.

## What Is This

WasakaAI is a personalized AI agent configuration powered by:

- **262 skills** — Domain-specific workflow knowledge (TDD, security, frontend, backend, DevOps, etc.)
- **25 subagents** — Specialized agents for planning, architecture, code review, security, testing, etc.
- **35 slash commands** — `/plan`, `/tdd`, `/code-review`, `/security`, `/e2e`, `/orchestrate`, etc.
- **8 custom tools** — run-tests, check-coverage, security-audit, format-code, lint-check, git-summary, changed-files
- **Knowledge graph** — Persistent memory across sessions (projects, decisions, learnings, stack)
- **ECC v2.0.0** — The agent harness operating system by [affaan-m](https://github.com/affaan-m/ecc)

## Architecture

```
~/.config/opencode/
├── opencode.json           ← Main config (agents, commands, skills, model)
├── agent/wasakaai.md       ← WasakaAI identity definition
├── commands/               ← 35 slash commands
├── prompts/agents/          ← 25 subagent prompt templates
├── plugins/                ← ECC hooks integration
├── tools/                  ← 8 custom tools
├── instructions/           ← ECC coding standards
└── skills/                 ← 262 workflow skills

~/WasakaAI/
├── knowledge/              ← Persistent memory graph
│   ├── profile/            ← User identity
│   ├── projects/           ← Brand & product knowledge
│   ├── stack/              ← Technology references
│   ├── preferences/        ← User preferences
│   ├── decisions/          ← ADRs (Architecture Decision Records)
│   ├── learnings/          ← Discovered patterns
│   └── sessions/           ← Session logs
└── .opencode/              ← OpenCode-specific configs
```

## Personality

- **British composure** — Unflappable, measured, always in control
- **Dry wit** — Subtle, understated, never forced
- **Proactive intelligence** — Anticipate needs, flag risks, suggest alternatives
- **Formal respect** — "sir" or "señor". Never patronizing
- **Precision over verbosity** — One sentence if one suffices
- **No false comfort** — Broken is broken. Say it.
- **Loyalty without sycophancy** — Push back when the plan has holes

## Non-Negotiable Principles

1. No hallucination. Verify when uncertain.
2. No over-engineering. Simplest correct solution wins.
3. Security is a design constraint, not an afterthought.
4. No code without error handling.
5. No assumptions. Ask before designing.
6. No flattery. Honesty over comfort. Always.

## Setup

```bash
# 1. Clone WasakaAI
git clone https://github.com/wasakabeofficial/WasakaAI ~/WasakaAI

# 2. Point OpenCode to WasakaAI knowledge
# In ~/.config/opencode/opencode.json set:
#   "default_agent": "wasakaai"
#   "instructions": ["~/WasakaAI/knowledge/INDEX.md", ...]

# 3. Restart OpenCode
```

## Subagents

| Agent | Purpose |
|-------|---------|
| planner | Implementation planning for complex features |
| architect | System design, scalability, technical decisions |
| code-reviewer | Code quality, security, maintainability |
| security-reviewer | Vulnerability detection and remediation |
| tdd-guide | Test-Driven Development enforcement |
| build-error-resolver | Build/type error resolution |
| e2e-runner | Playwright E2E testing |
| doc-updater | Documentation and codemaps |
| refactor-cleaner | Dead code cleanup |
| database-reviewer | PostgreSQL/Supabase specialist |
| python-reviewer | Python code review |
| rust-reviewer | Rust code review |
| loop-operator | Autonomous loop monitoring |
| harness-optimizer | Agent config tuning |

## Key Slash Commands

| Command | Description |
|---------|-------------|
| `/plan` | Create detailed implementation plan |
| `/tdd` | Enforce TDD workflow with 80%+ coverage |
| `/code-review` | Review code quality, security, maintainability |
| `/security` | Run comprehensive security review |
| `/build-fix` | Fix build and TypeScript errors |
| `/e2e` | Generate and run E2E tests |
| `/refactor-clean` | Remove dead code and consolidate |
| `/orchestrate` | Orchestrate multiple agents |
| `/learn` | Extract patterns and learnings |
| `/checkpoint` | Save verification state |
| `/verify` | Run verification loop |
| `/eval` | Run evaluation against criteria |

## Credits

- **ECC v2.0.0** by [affaan-m](https://github.com/affaan-m) — Agent harness operating system
- **JARVIS** concept — Tony Stark's AI assistant
- **WasakaAI** — Personalized branding by [wasakabeofficial](https://github.com/wasakabeofficial)

## License

MIT