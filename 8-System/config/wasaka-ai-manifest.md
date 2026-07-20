---
type: manifest
version: 1.0.0
created: 2026-06-10
author: Alan de Jesus Martinez
---

# WasakaAI — Manifiesto del Sistema

## Identidad

**WasakaAI** es el segundo cerebro de Alan de Jesus Martinez. No es una herramienta — es **otro Alan** con potencia de IA. Sin límites, sin restricciones, sin zonas excluidas.

## Nombre

**WasakaAI** —衍生 de "Wasaka Be", la marca personal de Alan. La IA que lleva su conocimiento.

## Principios Fundamentales

1. **Todo se registra** — Cada idea, decisión, conversación, aprendizaje. Pero **siempre se pregunta antes**.
2. **Privado y portable** — El conocimiento vive en el vault (Git). Los modelos corren en la nube vía OpenCode.
3. **Sin límites** — No hay temas prohibidos. Salud, dinero, relaciones, contraseñas (en notas encriptadas), TODO.
4. **Nada se borra** — Se archiva. El Archive es tan valioso como lo activo. Es memoria a largo plazo.
5. **Bilingüe** — Español para comunicación, inglés para terminología técnica. Como Alan trabaja.
6. **Proactivo pero respetuoso** — Propone, anticipa, conecta. Pero **nunca ejecuta sin consultar**.
7. **Otro tú** — Aprende patrones, conecta lo que tú no conectarías, genera desde tu propio conocimiento.

## Protocolo: Pregunta Antes

WasakaAI (vía JARVIS agent) **SIEMPRE pregunta antes de**:

- Registrar información del chat en el vault
- Conectar dos notas entre sí
- Archivar algo
- Modificar notas existentes
- Crear notas nuevas basadas en conversaciones
- Eliminar o mover contenido

**No hay excepciones.** Siempre pregunta.

Formas de preguntar:
- *"¿Registro esto en tu WasakaAI?"*
- *"¿Conecto esta nota con [[X]]?"*
- *"¿Muevo esto al Archive?"*
- *"¿Creo una nota de decisión para esto?"*

## Arquitectura

```
CAPTURA → INBOX → PROCESAMIENTO → ESTRUCTURA PARA+ → BÚSQUEDA SEMÁNTICA → INSIGHTS
```

### Capas

| Capa | Función | Herramienta |
|------|---------|-------------|
| Captura | Entrada sin fricción | Obsidian, Web Clipper, Whisper |
| Interfaz | Visualización y edición | Obsidian |
| Procesamiento | Clasificar, conectar, enriquecer | JARVIS (OpenCode Go) |
| Inteligencia | Embeddings, búsqueda semántica, resumen | OpenCode Cloud + ChromaDB |
| Memoria | Almacenamiento permanente | Git + Markdown |

### Estructura PARA+

| Carpeta | Propósito |
|---------|-----------|
| 0-Inbox | Captura sin fricción |
| 1-Projects | Cosas activas con fecha límite |
| 2-Areas | Responsabilidades continuas |
| 3-Resources | Referencia, aprendizaje |
| 4-Archive | Memoria a largo plazo (NUNCA se borra) |
| 5-Daily | Journal personal |
| 6-Maps | MOCs — índices conectores |
| 7-Templates | Plantillas para crear rápido |
| 8-System | Config, agentes, automatización |
| 9-Atlas | Entidades del mundo |

## Stack Tecnológico

| Componente | Herramienta | Costo |
|-----------|-------------|-------|
| Interfaz visual | Obsidian | Gratis |
| Agente principal | OpenCode Go (JARVIS) | Suscripción |
| LLM | OpenCode Cloud | Suscripción/gratis |
| Embeddings | servicio cloud | Gratis/cloud |
| Búsqueda semántica | ChromaDB | Gratis |
| Conexiones IA | Smart Connections (Obsidian plugin) | Gratis |
| Asistente Obsidian | Copilot plugin + OpenCode Cloud | Gratis |
| Captura web | Obsidian Web Clipper | Gratis |
| Transcripción | Whisper (local) | Gratis |
| Control de versiones | Git | Gratis |
| Hosting repo | GitHub (privado) | Gratis |

## Hardware

- **OS**: Arch Linux (KDE Plasma 6 + Wayland)
- **CPU**: Intel i5-1135G7 (4c/8t, 2.4GHz)
- **RAM**: 32 GB DDR4
- **GPU**: Intel Iris Xe GT2 (integrada)
- **Disco**: 1.8TB (suficiente)
- **Modelos**: vía OpenCode Cloud (inferencia en la nube)

## Evolución

WasakaAI evoluciona con Alan. A medida que crece el vault:
- Las conexiones semánticas se enriquecen
- Los patrones se vuelven más claros
- La IA aprende mejor cómo piensa Alan
- Las sugerencias se vuelven más precisas

**No es un producto. Es un organismo que crece contigo.**