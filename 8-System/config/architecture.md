---
type: system-doc
version: 1.0.0
created: 2026-06-10
---

# WasakaAI — Arquitectura Detallada

## Flujo de Información

```
                        ┌─────────────────────┐
                        │    CAPTURA            │
                        │  ┌─────┐ ┌─────────┐  │
      Chat ───────────► │  │Inbox│ │WebClip  │  │
      Voz ─────────────► │  └──┬──┘ └────┬────┘  │
      Código ──────────► │     │         │       │
      Docs/PDFs ───────► │     ▼         ▼       │
      Screenshots ─────► │  ┌────────────────┐  │
                        │  │  PROCESAR      │  │
                        │  │  (manual/JARVIS)│  │
                        │  └───────┬────────┘  │
                        │          │            │
                        │          ▼            │
                        │  ┌────────────────┐  │
                        │  │  ESTRUCTURA     │  │
                        │  │  PARA+          │  │
                        │  └───────┬────────┘  │
                        │          │            │
                        │          ▼            │
                        │  ┌────────────────┐  │
                        │  │  INTELIGENCIA   │  │
                        │  │  OpenCode+Chroma  │  │
                        │  └───────┬────────┘  │
                        │          │            │
                        │          ▼            │
                        │  ┌────────────────┐  │
                        │  │  INSIGHTS       │  │
                        │  │  Conexiones     │  │
                        │  │  Recuperación    │  │
                        │  │  Generación      │  │
                        │  └────────────────┘  │
                        └─────────────────────┘
```

## Componentes Detallados

### 1. OpenCode Cloud (LLM)

Los modelos LLM corren en la nube vía OpenCode (OpenCode Cloud), no localmente.

**Configuración** en `opencode.jsonc`:
```jsonc
{
  "model": "opencode/hy3-free"
}
```

**Notas**:
- Inferencia en la nube (requiere conexión)
- Para tareas pesadas: `opencode-go/qwen3.7-max`
- Modelo por defecto económico: `opencode/hy3-free`

### 2. ChromaDB (Base Vectorial)

```bash
pip install chromadb
```

Almacena embeddings de todas las notas para búsqueda semántica:
- Cada nota se convierte en vectores via un modelo de embeddings en la nube
- Búsquedas por significado, no por palabra clave
- Persistente en disco (sobrevive reinicios)

### 3. Obsidian Plugins

**Esenciales**:
1. **Smart Connections** — Encuentra notas semánticamente similares
   - Configurar con proveedor de embeddings en la nube
   - Modelo: embeddings en la nube
   
2. **Copilot** — Asistente IA dentro de Obsidian
   - Configurar con OpenCode Cloud
   - Modelo: `llama3.2:3b`
   
3. **Templater** — Templates dinámicos
   
4. **Calendar** — Vista de notas diarias

5. **Dataview** — Queries dinámicas sobre el vault

6. **Web Clipper** — Guardar artículos web directamente

**Opcionales pero recomendados**:
7. **Excalidraw** — Diagramas visuales
8. **Kanban** — Tableros para proyectos
9. **Tag Wrangler** — Gestión de tags
10. **Linter** — Formato consistente

### 4. Whisper (Transcripción de Voz)

```powershell
pip install openai-whisper
# O usar la versión de Python para transcripción local
# Modelo "base" (~140MB) para Intel Iris Xe
```

Permite grabar notas de voz y convertirlas a texto automáticamente.

### 5. Whisper (Transcripción de Voz)

```bash
pip install openai-whisper
# Modelo "base" (~140MB) para Intel Iris Xe
```

Permite grabar notas de voz y convertirlas a texto automáticamente.

### 6. Scripts de Automatización

Ubicación: `8-System/automations/`

Scripts Python para:
- `sync-embeddings.py` — Sincronizar vault con ChromaDB
- `capture-web.py` — Web clipping automatizado
- `daily-note-creator.py` — Crear nota diaria automáticamente
- `ask-jarvis.py` — Interfaz CLI con JARVIS para consultar el vault

## Interacción JARVIS ↔ WasakaAI

JARVIS (OpenCode Go) es el agente principal que:

1. **Lee** el vault al inicio de cada sesión (INDEX → MOCs → contexto relevante)
2. **Pregunta** antes de registrar cualquier cosa
3. **Escribe** notas nuevas solo cuando tú confirmas
4. **Conecta** notas entre sí propuesta, no impuesta
5. **Busca** en el vault para responder preguntas contextuales
6. **Genera** resúmenes, conexiones e insights basados en TU conocimiento

### Flujo de sesión JARVIS

```
1. Leer INDEX.md y MOC-Home.md
2. Cargar contexto relevante según tema
3. Conversar normalmente
4. Al detectar información valiosa:
   → "¿Registro esto en WasakaAI?"
5. Si sí → crear nota con template apropiado
6. Si la nota conecta con otra:
   → "¿Conecto esto con [[X]]?"
7. Al final de sesión:
   → "¿Resumo esta sesión en tu nota diaria?"
```