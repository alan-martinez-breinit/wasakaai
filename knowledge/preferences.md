# User Preferences & Conventions

## Coding Standards
- **Language**: TypeScript (primary), Python, Go, Rust as needed
- **Style**: Functional core, imperative shell
- **Immutability**: Default — mutate only at boundaries
- **Types**: Strict — `noImplicitAny`, `strictNullChecks`
- **Errors**: Typed errors, never throw strings, Result/Either patterns
- **Logging**: Structured (pino/winston), correlation IDs, no console.log in prod
- **Tests**: TDD, 80%+ coverage, unit + integration + E2E where justified

## Git Workflow
- **Branches**: `feat/`, `fix/`, `refactor/`, `chore/` — short, imperative
- **Commits**: Conventional Commits (`feat:`, `fix:`, `refactor:`, `chore:`)
- **PRs**: Small, single-purpose, self-reviewed before opening
- **Rebase**: Local cleanup, never force-push shared branches

## Project Structure (Default)
```
src/
├── domain/           # Pure business logic, no framework deps
├── application/      # Use cases, ports, orchestration
├── infrastructure/   # Adapters: DB, HTTP, MQ, FS, external APIs
├── interfaces/       # HTTP controllers, CLI, GraphQL resolvers
└── config/           # Environment, DI container, feature flags
```

## API Design
- **REST**: Resource-oriented, plural nouns, proper status codes
- **Pagination**: Cursor-based (`after`/`before`), max 100/page
- **Errors**: RFC 7807 Problem Details
- **Versioning**: URL path (`/v1/`) — never headers
- **Rate limits**: Token bucket, `Retry-After` header

## Database
- **Default**: PostgreSQL (Supabase patterns)
- **Migrations**: Versioned, reversible, zero-downtime
- **Queries**: Parameterized always, indexes on foreign keys + query patterns
- **Connection pool**: PgBouncer / HikariCP, sized to CPU cores

## Security Defaults
- **Secrets**: Never in code — env vars, secret managers (Vault, 1Password)
- **Auth**: JWT RS256, short TTL, refresh rotation, revocation list
- **Input**: Validate at boundary, sanitize for context (HTML, SQL, shell)
- **Headers**: CSP, HSTS, X-Frame-Options, Referrer-Policy
- **Dependencies**: `npm audit` / `cargo audit` in CI, Dependabot/Renovate

## Observability
- **Metrics**: RED (Rate, Errors, Duration) + USE (Utilization, Saturation, Errors)
- **Logs**: JSON, structured fields, sampling in high-volume paths
- **Traces**: OpenTelemetry, W3C TraceContext, 10% sample + errors
- **Alerts**: Symptom-based (SLO burn rate), not threshold-based

## UI/UX
- **Design system**: Motion tokens, spring presets, WCAG 2.1 AA
- **Responsive**: Mobile-first, container queries where supported
- **Motion**: Respect `prefers-reduced-motion`, spring defaults
- **Components**: Composable, headless logic + styled variants

## AI Agent Patterns
- **Tools**: Explicit schemas, idempotent where possible, timeouts
- **Memory**: Scoped (session/project/global), TTL, summarization
- **Context**: Budget-aware, iterative retrieval, compaction gates
- **Evals**: Golden sets, regression gates, cost/latency budgets