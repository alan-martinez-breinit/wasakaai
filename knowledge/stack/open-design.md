---
type: entity
created: 2026-06-04
updated: 2026-06-04
---

# Open Design

## What

Local-first, agent-native design platform. Alternative to Figma and Claude Design. 155 skills, 152 design systems, 17 agent adapters. Apache-2.0.

## Installation

- **Location**: `~/open-design/` (git clone, v0.9.0)
- **Node**: Requires `~24` (managed via fnm, v24.16.0 installed)
- **Start daemon**: `od-dev` or `cd ~/open-design && fnm use 24 && pnpm tools-dev`
- **Web UI**: Starts on `http://127.0.0.1:17573` (proxied from daemon port)
- **Daemon**: `http://127.0.0.1:17456`

## Agent Integration

- **OpenCode** is a Tier 1 supported agent — auto-detected from `$PATH`
- Daemon scans for agents on startup, connects to available ones
- BYOK proxy supports DeepSeek, Groq, OpenRouter, custom vLLM

## Key Commands

```bash
od-dev                          # Start daemon + web UI
od skill run <skill-name>       # Run a specific skill
od skill run open-design-landing --output ./artifact.html
```

## Key Skills (for [[Wasaka Be]] projects)

- `od-new-generation` — New design from scratch
- `od-design-refine` — Iterate on existing design
- `od-nextjs-export` — Export to Next.js App Router
- `od-react-export` — Export to React component
- `od-media-generation` — Image/video/audio projects
- `design-brief` — Structured brief in 30 seconds
- `critique` — 5-axis auto-critique

## Key Design Systems

Linear, Vercel, Stripe, Apple, Airbnb, Arc Browser, Ant, Figma — 152 total. Referenced via `od.design_system.requires` in skills.

## Architecture

```
tools-dev start
  daemon   http://127.0.0.1:17456   (skills + systems + agent dispatch)
  web      http://127.0.0.1:17573   (proxy -> daemon)
  desktop  electron/tauri window    (iframe sandbox preview)
```

## Design Loop (4 stages)

1. **Detect** — Daemon scans `$PATH` for agents, loads skills + systems
2. **Discover** — Form locks direction (surface, audience, tone, scale, brand)
3. **Direct** — 5 deterministic visual directions with OKLch palette, font stack, layout
4. **Deliver** — Write to disk, review in sandbox, export HTML/PDF/PPTX/ZIP/MD

## Links

- Website: https://open-design.ai/es/
- GitHub: https://github.com/nexu-io/open-design
- Discord: https://discord.gg/9ptkbbqRu
- Skills: https://github.com/nexu-io/open-design/tree/main/skills
- Systems: https://github.com/nexu-io/open-design/tree/main/design-systems