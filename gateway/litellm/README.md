# Digital Vertise shared model gateway

LiteLLM is the OpenAI-compatible front door for DV-AIOS. Claude Code, coding agents,
GlueAI services and application backends should use this gateway rather than each
embedding provider-specific credentials.

## Start

```bash
cd gateway/litellm
cp .env.example .env
# Edit .env: set LITELLM_MASTER_KEY and credentials for at least one provider.
docker compose up -d
docker compose logs -f litellm
```

The gateway listens on `127.0.0.1:4000` by default. Do not expose it publicly
without TLS, firewall rules and a strong master key.

## OpenAI-compatible API

```bash
curl http://127.0.0.1:4000/v1/models \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY"

curl http://127.0.0.1:4000/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"nvidia/fast","messages":[{"role":"user","content":"Reply with OK"}]}'
```

Use one of these model names in client configuration:
- `freellmapi/auto`
- `nvidia/fast`
- `openrouter/auto`
- `local/ollama`

Only configure credentials for providers you actually use. FreeLLMAPI is optional;
it is not required for the gateway to run. Remove unused provider entries from
`config.yaml` if you want a smaller deployment or your LiteLLM version validates
all model entries at startup.

## Claude Code adapter

Claude Code expects Anthropic Messages semantics, not the OpenAI chat-completions
API. Route it through LiteLLM's Anthropic-compatible endpoint only after verifying
that the selected LiteLLM release exposes `/v1/messages` and that the chosen
underlying model supports tools and streaming. Do not point Claude Code's
`ANTHROPIC_BASE_URL` at `/v1/chat/completions`. A successful chat-completions
test alone does not prove Claude Code compatibility.

## Operations

- Health: `GET /health/liveliness`
- Model listing: `GET /v1/models`
- Logs: `docker compose logs -f litellm`
- Stop: `docker compose down`

Provider credentials and the gateway master key belong in the untracked `.env`
file or a secrets manager, never in Git. The default bind address is loopback.
