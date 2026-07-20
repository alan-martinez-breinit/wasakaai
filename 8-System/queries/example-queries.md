---
type: system-doc
version: 1.0.0
created: 2026-06-10
---

# WasakaAI — Queries de Ejemplo

Dataview y búsquedas semánticas para usar en Obsidian.

## Dataview Queries

### Proyectos activos

```dataview
TABLE status, deadline, updated
FROM "1-Projects"
WHERE status = "active"
SORT updated DESC
```

### Notas creadas hoy

```dataview
LIST
WHERE file.cday = date(today)
SORT file.name ASC
```

### Decisiones recientes

```dataview
TABLE status, created
FROM "4-Archive/migrated" OR "0-Inbox" OR "1-Projects" OR "2-Areas"
WHERE type = "decision"
SORT created DESC
```

### Todas las personas en Atlas

```dataview
TABLE status, tags
FROM "9-Atlas/people"
SORT file.name ASC
```

### Ideas pendientes

```dataview
TABLE status, created
FROM "0-Inbox" OR "1-Projects"
WHERE type = "idea" AND status != "implemented"
SORT created DESC
```

### Áreas por actividad

```dataview
TABLE length(rows) as "Notas"
FROM "2-Areas"
FLATTEN file.lists
GROUP BY file.folder
```

## Búsquedas Semánticas (vía Smart Connections + Copilot)

Una vez configurado Smart Connections (cloud):

- *"Encuentra notas sobre decisiones de arquitectura"*
- *"Qué he escrito sobre Wasaka Be"*
- *"Conecta esta nota con decisiones similares"*
- *"Resume mis notas de esta semana"*
- *"Qué patrones hay en mi forma de trabajar"*