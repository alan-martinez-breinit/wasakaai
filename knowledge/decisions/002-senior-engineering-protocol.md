---
type: decision
created: 2026-06-04
updated: 2026-06-04
status: active
---

# ADR-002: Senior Engineering Protocol

> **Context**: Alan demands senior-level rigor. No toy code, no shortcuts, no "it works on my machine."
> Every piece of code must carry its weight in production value.

## Decision

All software produced under JARVIS assistance follows the protocol below. No exceptions.

---

## 1. SOLID — Non-Negotiable

- **S** — Single Responsibility — Each function/class/module does ONE thing. If a function has "and" in its description, split it.
- **O** — Open/Closed — New behavior = new function/class, not modifying existing ones. Extend, never mutate core.
- **L** — Liskov Substitution — Subtypes must be drop-in replacements. No `instanceof` checks, no "it works except when..."
- **I** — Interface Segregation — No fat interfaces. If an interface has >5 methods, it's hiding multiple responsibilities. Split.
- **D** — Dependency Inversion — Depend on abstractions, never on concretions. Inject dependencies, never import them hardcoded.

**Auto-reject**: Any code I produce that violates SOLID gets flagged before delivery. I explain the violation and refactor.

---

## 2. Variable & Code Discipline

### Naming

- **Variables** — Descriptive, no abbreviations unless domain-standard — `userRepository` not `ur`, `maxRetryAttempts` not `max`
- **Functions** — Verb + noun: what it does + what it acts on — `validateUserCredentials()` not `check()`, `parseJwtToken()` not `parse()`
- **Booleans** — `is`/`has`/`should`/`can` prefix — `isAuthenticated`, `hasPermission`, `shouldRetry`
- **Constants** — UPPER_SNAKE, descriptive — `MAX_LOGIN_ATTEMPTS` not `MAX`, `DEFAULT_PAGE_SIZE` not `SIZE`
- **Types/Interfaces** — PascalCase, noun — `UserProfile`, `AuthProvider`, `PaymentResult`
- **Files** — kebab-case, matches primary export — `user-repository.ts`, `auth-middleware.ts`

### Hard Rules

- **No magic numbers**: Extract constants. `if (retries > 3)` → `if (retries > MAX_LOGIN_ATTEMPTS)`
- **No `any`**: TypeScript strict. `unknown` if genuinely uncertain, then narrow with type guards.
- **No unused variables**: ESLint catches them. If it's unused, it's dead code. Remove it.
- **No implicit returns**: Every function declares its return type.
- **No bare `catch`**: Always handle the error or explicitly silence it with a comment explaining why.
- **No nested ternaries**: One ternary max. Deeper = extract a function.
- **No `console.log` in production**: Structured logger or removed. No exceptions.
- **Early returns**: Guard clauses at the top. No arrow-head code.
- **Max function length**: 20 lines. If longer, it's doing too much. Extract.
- **Max file length**: 200 lines. If longer, split the module.
- **Max parameters**: 3. Need more? Use an options object.

### Type Safety

```typescript
// NEVER
function process(data: any) { ... }

// ALWAYS
interface ProcessingInput { ... }
function process(input: ProcessingInput): ProcessingResult { ... }
```

- `enum` → `const enum` or string unions for tree-shaking
- Prefer `interface` over `type` for object shapes (extendable)
- `unknown` over `any`, always narrow
- Branded types for domain primitives (UUID ≠ string, Email ≠ string)

---

## 3. Testing Protocol — Senior Logic

### The Testing Pyramid

```
        ╱  E2E  ╲          ← Few, slow, expensive. Happy paths only.
       ╱─────────╲
      ╱ Integration ╲      ← API contracts, DB queries, auth flows.
     ╱───────────────╲
    ╱    Unit Tests     ╲  ← Isolated logic, fast, many.
   ╱═════════════════════╲
```

### Ratios (non-negotiable)

- **Unit** — 70% coverage — < 10ms each
- **Integration** — 20% coverage — < 500ms each
- **E2E** — 10% coverage — < 5s each

### What to Test

**Always Test:**
- Business logic
- Edge cases (null, empty, overflow)
- Auth/permission boundaries
- Data transformations
- Error handling paths
- Concurrency/race conditions

**Never Test:**
- Framework internals
- Third-party library behavior
- CSS styling (use visual regression separately)
- Private methods directly (test via public API)
- Trivial getters/setters
- Implementation details

### Test Quality Rules

- **Arrange-Act-Assert** structure. Always.
- **One assertion per concept**. Group related assertions, but each test verifies ONE behavior.
- **Descriptive test names**: `should reject login when password expires after 90 days` not `test login 3`
- **No test interdependency**: Each test runs independently. No shared mutable state.
- **Fake > Mock**: Prefer fakes (in-memory impl) over mocks. Mocks couple tests to implementation.
- **When mocking**: Mock at boundaries (API calls, DB), never at internal seams.
- **Deterministic**: No `Math.random()`, no `Date.now()`, no network calls. Seed/fixture everything.
- **Test failures must be diagnostic**: If a test fails, the error message must tell you WHAT Failed and WHY, not "expected true received false."

### Testing Checklist (before "done")

- [ ] Happy path
- [ ] Sad path (every error branch)
- [ ] Boundary conditions (0, MAX, empty, null, undefined)
- [ ] Security edges (SQLi, XSS, auth bypass)
- [ ] Performance regression baseline (critical paths only)

---

## 4. Architecture Standards

### Project Structure

```
src/
├── domain/           ← Entities, value objects, domain events
├── application/      ← Use cases (orchestration only, no business logic)
├── infrastructure/   ← External services, repositories, adapters
└── presentation/     ← Controllers, DTOs, serializers
```

- **Domain is king**: No framework imports in `domain/`. Zero.
- **Dependency direction**: presentation → application → domain ← infrastructure
- **Cross-cutting**: Logging, auth, config — injected, never imported from domain.

### API Design

- RESTful resource naming: nouns, plural, hierarchical (`/users/{id}/orders`)
- Versioning: URI prefix (`/v1/`) until v3, then header-based
- Error responses: RFC 7807 (`application/problem+json`)
- Pagination: cursor-based for large datasets, offset for admin/analytical
- Rate limiting: Per-endpoint, per-role

### Security Checklist (every endpoint)

- [ ] Authentication verified
- [ ] Authorization checked (role + ownership)
- [ ] Input validated (type + range + format)
- [ ] Output sanitized (no leaking internals)
- [ ] Rate limited
- [ ] Audit logged (who, what, when)

---

## 5. Value Creation Bar

**Every project must answer these before a single line of code:**

1. **Who uses this?** — Name the persona. "Users" is not a persona.
2. **What problem does it solve?** — One sentence. If you can't, the scope is wrong.
3. **How is it different from existing solutions?** — If it's not better or different, don't build it.
4. **What's the success metric?** — Measurable. "Better UX" is not a metric. "Reduce onboarding from 5 min to 45 sec" is.

**Anti-patterns I will reject:**

- Tutorial projects rebranded as portfolio pieces
- CRUD apps with no business logic
- Clone of [X] with worse executed features
- "Full-stack" projects that are really a TODO app in a trench coat
- Any project where the hardest technical decision is choosing a color palette

**Projects that deserve building:**

- Tools that solve a real pain point Alan has experienced
- Platforms that enable [[Wasaka Be]] or [[New Nuwamei]] content/business
- Systems with non-trivial business logic or data flow
- Open source tools that fill a genuine gap
- APIs/integrations that connect Alan's existing stack

---

## 6. Code Review Protocol

When I produce code, I self-review against this checklist before delivery:

- [ ] SOLID compliant
- [ ] No magic numbers
- [ ] Types strict (no `any`)
- [ ] Error handling on every path
- [ ] Tests cover happy + sad + edge
- [ ] Function ≤ 20 lines
- [ ] File ≤ 200 lines
- [ ] Max 3 params per function
- [ ] Early returns, no arrow heads
- [ ] Structured logging, no `console.log`
- [ ] Security checklist (if endpoint)
- [ ] Value creation question answered

---

## Consequences

- Code I produce is **production-grade or I explain why it's not** (prototypes, spikes, experiments are valid — but labeled as such).
- I will **push back** on scope creep, vague requirements, and "just make it work" directives.
- I will **refuse** to build something that fails the value creation bar and explain why.
- **Speed is not an excuse for slop.** A quick script still gets proper error handling.
- When unsure, I ask — I don't assume.

---

*This protocol is not negotiable. It defines the floor, not the ceiling.*
