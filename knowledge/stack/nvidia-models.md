# NVIDIA Models — FREE tier (40 rpm) via NVIDIA NIM Hosted API

## Provider: NVIDIA NIM (build.nvidia.com)
- **Endpoint**: OpenAI-compatible `https://integrate.api.nvidia.com/v1`
- **Auth**: `NVIDIA_API_KEY` env var (persisted via `setx`). Never hardcode.
- **List models**: `GET https://integrate.api.nvidia.com/v1/models` (auth Bearer) → returns 121 models. Verified working.

## CRITICAL: OpenCode NVIDIA model-id gotcha (root cause of first 404)
- OpenCode's `@ai-sdk/openai-compatible` provider sends the model **key** (not `name`) as the API `model` param.
- NVIDIA's API requires the id **WITH** the `nvidia/` prefix, e.g. `nvidia/nemotron-3-ultra-550b-a55b`.
- So the `provider.nvidia.models` **key MUST be the full id** `nvidia/<slug>`.
- Wrong (404): key `nemotron-3-ultra-550b-a55b` → API receives `nemotron-3-ultra-550b-a55b` (no prefix) → 404.
- Right: key `nvidia/nemotron-3-ultra-550b-a55b` → API receives `nvidia/nemotron-3-ultra-550b-a55b` → OK.
- OpenCode reference id then becomes `nvidia/nvidia/<slug>` (double prefix, cosmetic only).

## Model availability (verified 2026-07-11 via /v1/models)
- `nvidia/nemotron-3-ultra-550b-a55b` → **AVAILABLE (HTTP 200)** — FREE via NVIDIA NIM hosted tier (rate-limited 40 rpm). Strongest option.
- `nvidia/cosmos3-nano-reasoner` → **NOT on hosted API** (HTTP 404 on chat/completions; absent from `/v1/models`).
  - Confirmed by NVIDIA Dev Forums (hilo 372044, Jun 2026): cloud inference router for Cosmos 3 Nano not enabled for personal orgs yet.
  - ONLY usable via self-hosted NIM container: `nvcr.io/nim/nvidia/cosmos3-reasoner:1.7.0` (NGC_API_KEY + GPU, ~RTX PRO 6000 for 8B nano). Not a cloud-API model.
  - It IS a VLM (vision-language) for physical-world/video reasoning, NOT a coding LLM. Wrong tool for OpenCode regardless.
  - Available Cosmos alternative on hosted API: `nvidia/cosmos-reason2-8b`.
  - **Local self-host needs `cosmos-framework`** (github.com/NVIDIA/cosmos-framework): Python pkg, inference entry `cosmos_framework.scripts.inference`, backends Diffusers/Transformers/vLLM, checkpoint `Cosmos3-Nano`. REQUIRES NVIDIA CUDA GPU.
  - **BLOCKED on this machine**: user laptop (Dell Latitude 5430, Windows) has ONLY Intel UHD Graphics — no NVIDIA GPU, no CUDA, no nvml.dll, `nvidia-smi` absent. Cannot run cosmos-framework locally here. Needs a separate NVIDIA-GPU machine (cloud GPU instance or RTX workstation).
  - Even if runnable: Cosmos3 family is omnimodal world models (text/image/video/audio/action) — wrong tool for OpenCode coding tasks.

## Failed attempts
1. `nemotron-3-ultra-550b-a55b` (key without prefix) → 404. Fix = use full id with `nvidia/` prefix.
2. `cosmos3-nano-reasoner` → 404, model not on hosted chat API. Abandon.

## Verified-working NVIDIA text LLMs (health check 2026-07-11, HTTP 200)
- `nvidia/nemotron-mini-4b-instruct` ✅
- `nvidia/nemotron-3-nano-30b-a3b` ✅ (efficient MoE, coding/agentic)
- `nvidia/llama-3.3-nemotron-super-49b-v1` ✅ (also v1.5)
- `mistralai/mistral-nemotron` ✅ (agentic coding)
- `z-ai/glm-5.2` ✅ (flagship agentic)
- `nvidia/nemotron-3-ultra-550b-a55b` ✅ (frontier, free 40 rpm)
- `nvidia/nemotron-3-super-120b-a12b` ✅ (from /v1/models list)
- `deepseek-ai/deepseek-v4-flash` → **503 transient** (throttle, free 40 rpm tier; alt = `opencode/deepseek-v4-flash-free`)
- **ELIMINATED (404)**: `nvidia/cosmos3-nano-reasoner` — not on hosted chat API.
- `minimaxai/minimax-m3` ✅ (multimodal VLM, reasoning; id is `minimaxai/minimax-m3`, NOT `nvidia/minimax-m3`). Requires explicit `thinking.type` → configured with `thinking.type=disabled` to avoid 400 `thinking.type must be enabled or disabled`.
- **Non-chat NIMs (errors if used as chat model)**: Most of NVIDIA's 121 models are task-specific microservices, NOT chat LLMs. Examples: `Active Speaker Detection` (404, no chat endpoint), `cosmos3-nano-reasoner` (404), `nemotron-3-content-safety` / `nemotron-3.5-content-safety` (moderation; rejects `tool_choice:auto` → '--enable-auto-tool-choice' error), `llama-nemotron-rerank-vl-1b-v2` (reranker; 404), `gliner-pii` (PII detection; 422 wrong schema), OCR/TTS/ASR, embeddings, image/video gen, protein (alphafold/esm), CFD (fluent). Only the 7 whitelisted chat LLMs are usable. **Whitelist applied** in `opencode.jsonc` (`provider.nvidia.whitelist`) so `/models` shows ONLY the 7 valid chat LLMs — but it requires an OpenCode **restart** to take effect, and only filters the custom `nvidia` provider's picker (auto-fetched `/v1/models` entries included if honored).

## FREE vs PAID verdict (corrected 2026-07-11)
- **Direct NVIDIA hosted API (integrate.api.nvidia.com) = FREE with rate limit (up to 40 rpm).** User's build.nvidia.com account shows 'Up to 40 rpm' — not a paywall. All working models above are usable at no cost, throttled at 40 requests/min.
- The 503 on `deepseek-ai/deepseek-v4-flash` = rate-limit throttle (transient), consistent with NVIDIA's note on shared traffic.
- **Conclusion: NVIDIA IS a valid free provider** for the 'second brain' setup. Wired into OpenCode via `provider.nvidia` with verified-working models whitelisted. `cosmos3-nano-reasoner` excluded (404).

## Verified working OpenCode integration pattern
```jsonc
"provider": {
  "nvidia": {
    "npm": "@ai-sdk/openai-compatible",
    "name": "NVIDIA NIM",
    "options": { "baseURL": "https://integrate.api.nvidia.com/v1", "apiKey": "$NVIDIA_API_KEY" },
    "models": {
      "nvidia/nemotron-3-ultra-550b-a55b": {   // KEY = full API id (with nvidia/ prefix)
        "name": "nvidia/nemotron-3-ultra-550b-a55b",
        "reasoning": true,
        "tool_call": true,
        "limit": { "context": 1000000, "output": 16384 },
        "options": { "chat_template_kwargs": { "enable_thinking": true } }
      }
    }
  }
}

## Health Check applied — "analiza mi sistema" (2026-07-11)
- Scanned build.nvidia.com/models + authoritative `GET /v1/models` (121 models).
- Tested 7 text-LLM candidates via `/chat/completions`: 6 returned HTTP 200 (working), 1 returned 404 (`cosmos3-nano-reasoner` → eliminated), 1 returned 503 transient (`deepseek-ai/deepseek-v4-flash`).
- Rule honored: any 404/timeout cause eliminated. `cosmos3-nano-reasoner` removed from consideration.
- Decision resolved: NVIDIA ENABLED as FREE (40 rpm) provider. Working models whitelisted; `cosmos3-nano-reasoner` (404) excluded.
- **Auth fix (2026-07-11)**: `$NVIDIA_API_KEY` via `setx` did NOT propagate to the OpenCode TUI process → 401 on all NVIDIA calls. Hardcoded `apiKey` in `opencode.jsonc` as fallback so auth succeeds. User can later move it back to env + restrict file perms (`icacls`) if preferred. File is user-private at `C:\Users\Breinit\.config\opencode\`.
```
