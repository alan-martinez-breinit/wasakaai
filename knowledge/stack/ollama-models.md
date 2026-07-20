# Ollama Models (local — Intel UHD, 16GB RAM, no NVIDIA GPU)

- **Server**: `localhost:11434` (Ollama v0.31.2, daemon running, 9 models pulled).
- Custom provider **`ollama-local`** (`@ai-sdk/openai-compatible`, baseURL `http://localhost:11434/v1`): shows ONLY the 5 `tools`-capable models. Custom providers don't auto-fetch `/v1/models`, so no `whitelist` needed and no cloud appears. Sends the BARE tag (`qwen2.5-coder:7b`) to Ollama → matches local server (built-in `ollama` sent `ollama/qwen2.5-coder:7b` → 404). Built-in `ollama` DISABLED via `disabled_providers` to remove Ollama Cloud (subscription). Local chat verified working (bare tag → "OK"). Picker IDs: `ollama-local/<tag>`.
- **Hardware reality**: no CUDA GPU (Intel UHD only) → CPU inference. 7B–8B is the sweet spot (~5–15 tok/s); 9B moderate; 14B (phi4) slow (~2–4 tok/s). All models are Q4 quantized GGUF.

## Capabilities (from `/api/tags` → `details.capabilities`)

| Model | Size | Capabilities | Usable as OpenCode agent? |
|-------|------|--------------|---------------------------|
| `qwen2.5-coder:7b` | 4.7GB | completion, **tools**, insert | ✅ BEST for coding |
| `llama3.1:8b` | 4.9GB | completion, **tools** | ✅ general |
| `qwen2.5:7b` | 4.7GB | completion, **tools** | ✅ general |
| `mistral:7b` | 4.4GB | completion, **tools** | ✅ |
| `llama3.2:3b` | 2.0GB | completion, **tools** | ✅ fast / light |
| `deepseek-r1:8b` | 5.2GB | completion, thinking | ❌ no `tools` → `tool_choice:auto` errors |
| `gemma2:9b` | 5.4GB | completion | ❌ no `tools` |
| `phi4:14b` | 9.1GB | completion | ❌ no `tools` + slow on CPU |
| `nomic-embed-text:latest` | 274MB | embedding | ❌ not chat (embedding only) |

## Why the split matters
OpenCode's primary agent uses `tool_choice: "auto"` for function calling. Models without the `tools` capability reject it (same class of error as NVIDIA `nemotron-3-content-safety`). `nomic-embed-text` is an embedding microservice, not a chat endpoint → 404/error if selected as a chat model.

## Recommendation
- **Primary local coding agent**: `ollama/qwen2.5-coder:7b` — purpose-built coder, tool calling + code-insert, 32K context.
- **Fast / light edits**: `ollama/llama3.2:3b`.
- **General chat**: `ollama/llama3.1:8b` or `ollama/qwen2.5:7b`.
- **Avoid as agent**: `deepseek-r1:8b` (reasoning but no tools), `gemma2:9b`, `phi4:14b` (no tools), `nomic-embed-text` (embedding).

## Note
If the user wants `deepseek-r1:8b` for non-agentic reasoning chat, remove it from the `ollama` whitelist (it will then appear in `/models` but will fail in agentic/tool-calling mode).
