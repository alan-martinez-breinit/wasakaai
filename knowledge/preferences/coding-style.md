---
type: entity
category: preference
domain: engineering
---

# Engineering Standards & Coding Style

## Core Protocol
- **Protocol**: [[ADR-002: Senior Engineering Protocol]] — SOLID, strict typing, testing, value creation bar
- **No toy code**: Every project must pass the value creation test before building
- **No `any`**: TypeScript strict always. `unknown` + narrow.
- **No magic numbers**: Constants with descriptive names
- **Testing pyramid**: 70% unit / 20% integration / 10% E2E
- **Clean Architecture**: domain → application → infrastructure → presentation
- **Push back**: If requirements are vague or scope is wrong, say so

## Naming Conventions
- **Files**: kebab-case (e.g., `wasaka-be.md`)
- **Folders**: lowercase, singular concept
- **Links**: `[[Title Case]]` for Obsidian compatibility
- **Variables**: descriptive, no abbreviations (`userRepository` not `ur`)
- **Functions**: verb + noun (`validateUserCredentials()` not `check()`)
- **Booleans**: `is`/`has`/`should`/`can` prefix
- **Constants**: UPPER_SNAKE (`MAX_LOGIN_ATTEMPTS`)

## Dislikes (Code & Design)
- Cloud lock-in
- Over-engineering simple problems
- Tutorial projects rebranded as portfolio pieces
- CRUD apps with no business logic
- TODO apps in trench coats
- Code without error handling
