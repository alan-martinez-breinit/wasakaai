---
type: system-doc
version: 1.0.0
created: 2026-06-10
---

# WasakaAI — Guía de Automatizaciones

Scripts Python para automatizar WasakaAI. Se configuran en Windows después de la instalación.

## Scripts Planificados

### 1. `sync-embeddings.py`

Sincroniza todas las notas del vault con ChromaDB para búsqueda semántica.

```python
# Uso:
python sync-embeddings.py --vault C:\Users\TU_USUARIO\WasakaAI

# Funcionalidad:
# - Escanea todas las notas .md en el vault
# - Extrae contenido + frontmatter
# - Genera embeddings via servicio de embeddings en la nube
# - Almacena en ChromaDB local
# - Actualiza embeddings de notas modificadas
# - Elimina embeddings de notas eliminadas
```

### 2. `daily-note-creator.py`

Crea nota diaria automáticamente con el template.

```python
# Uso:
python daily-note-creator.py --vault C:\Users\TU_USUARIO\WasakaAI

# Funcionalidad:
# - Crea nota en 5-Daily/YYYY-MM-DD.md
# - Usa template de 7-Templates/template-daily.md
# - Si ya existe, la abre
# - Se puede ejecutar como tarea programada al inicio del día
```

### 3. `ask-jarvis.py`

Interfaz CLI para consultar WasakaAI desde terminal.

```python
# Uso:
python ask-jarvis.py "¿Qué decidí sobre el proyecto X?"

# Funcionalidad:
# - Busca en el vault por palabra clave
# - Busca semánticamente en ChromaDB
# - Retorna notas relevantes con contexto
# - PermiteAgregar notas desde terminal
```

### 4. `capture-idea.py`

Captura rápida de ideas desde terminal.

```python
# Uso:
python capture-idea.py "Idea para video sobre IA"

# Funcionalidad:
# - Crea nota en 0-Inbox/ con timestamp
# - Aplica frontmatter estándar
# - Permite especificar tags y tipo
```

## Instalación

```powershell
cd C:\Users\TU_USUARIO\WasakaAI\8-System\automations
pip install -r requirements.txt  # (por crear)
```