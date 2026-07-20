---
type: system-doc
version: 2.0.0
created: 2026-06-10
updated: 2026-06-11
os: arch-linux
---

# WasakaAI — Guía de Instalación en Arch Linux

## Estado actual del sistema

| Componente | Estado | Versión |
|-----------|--------|---------|
| OS | ✅ Arch Linux | KDE Plasma 6 + Wayland |
| Git | ✅ Instalado | 2.54.0 |
| Python | ✅ Instalado | 3.14.5 |
| Node.js | ✅ Instalado | 26.2.0 |
| Obsidian | ✅ Instalado | 1.12.7 (Flatpak) |
| WasakaAI repo | ✅ Clonado | `~/WasakaAI/` |
| OpenCode Cloud | ✅ Configurado | model: opencode/hy3-free |
| ChromaDB | ❌ Pendiente | — |
| Plugins Obsidian | ❌ Pendiente | — |

---

## Paso 1 — OpenCode Cloud (LLM)

Los modelos LLM corren en la nube vía OpenCode. No requiere instalación local.

**Configuración** en `opencode.jsonc`:
```jsonc
{
  "model": "opencode/hy3-free"
}
```

Para tareas pesadas usar `opencode-go/qwen3.7-max`. Requiere conexión a internet.

---

## Paso 2 — ChromaDB

```bash
# Instalar vía pip
pip install chromadb

# Herramientas adicionales
pip install pymupdf              # Lectura de PDFs
pip install python-frontmatter   # Parsing de YAML en notas

# Verificar
python -c "import chromadb; print('ChromaDB OK')"
```

**Opcional — Transcripción de voz:**
```bash
pip install openai-whisper       # Transcripción local
```

---

## Paso 3 — WasakaAI Vault en Obsidian

```bash
# El vault ya está clonado en ~/WasakaAI/
ls ~/WasakaAI/

# Abrir Obsidian
# 1. Settings → Vault → Open folder as vault
# 2. Seleccionar ~/WasakaAI/
# 3. Confiamos en el autor del plugin (nosotros mismos, es nuestro vault)
```

---

## Paso 4 — Obsidian Plugins

Abrir Obsidian → Settings → Community Plugins → **Turn on community plugins** → Browse

### Esenciales (instalar en este orden)

1. **Smart Connections**
   - Buscar "Smart Connections" → Install → Enable
   - Settings → Embeddings Provider: "Cloud"
   - Settings → Embedding Model: modelo de embeddings en la nube

2. **Copilot**
   - Buscar "Copilot" → Install → Enable
   - Settings → Model Provider: "OpenCode Cloud"
   - Settings → Default Model: `opencode/hy3-free`

3. **Templater**
   - Buscar "Templater" → Install → Enable
   - Settings → Template folder path: `7-Templates`

4. **Calendar**
   - Buscar "Calendar" → Install → Enable
   - Settings → New note location: `5-Daily`
   - Settings → Format: `YYYY-MM-DD`

5. **Dataview**
   - Buscar "Dataview" → Install → Enable

6. **Obsidian Web Clipper**
   - Instalar extensión de navegador desde obsidian.md
   - Configurar para guardar en `0-Inbox`

### Opcionales pero recomendados

7. **Excalidraw** — Diagramas
8. **Kanban** — Tableros de proyectos
9. **Tag Wrangler** — Gestión de tags
10. **Linter** — Formato consistente

---

## Paso 5 — Verificación

```bash
# Verificar ChromaDB
python -c "import chromadb; print('OK')"

# Verificar vault
ls ~/WasakaAI/6-Maps/MOC-Home.md
```

En Obsidian:
1. Verificar que Smart Connections indexa las notas
2. Verificar que Copilot responde
3. Crear una nota de prueba en `0-Inbox`
4. Abrir graph view — debe mostrar conexiones

---

## Estructura en Arch Linux

```
/home/wasakabe/
├── WasakaAI/                    ← Vault (clonado de GitHub)
├── .local/share/opencode/       ← OpenCode Go
└── .local/share/chromadb/       ← Base vectorial (auto)
```

---

## Sincronización

```bash
# Antes de cada sesión:
cd ~/WasakaAI && git pull

# Al terminar cambios:
cd ~/WasakaAI && git add -A && git commit -m "update: descripción" && git push
```

---

## Troubleshooting

| Problema | Solución |
|----------|----------|
| Modelos lentos | Usar modelo más ligero o `opencode/hy3-free` |
| Smart Connections no indexa | Verificar conexión al proveedor de embeddings en la nube |
| Copilot no conecta | Verificar conexión a OpenCode Cloud |
| Git push rechazado | `git pull --rebase && git push` |
| Flatpak Obsidian no accede a ~/WasakaAI | `flatpak override --filesystem=home md.obsidian.Obsidian` |