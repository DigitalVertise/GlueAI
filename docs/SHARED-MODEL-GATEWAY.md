# DV-AIOS shared model gateway

## Decision

GlueAI owns the model/provider registry and routes consumers to a shared LiteLLM
proxy. LiteLLM is the compatibility and routing layer; provider gateways remain
replaceable adapters.

## Initial topology

Consumers (Claude Code adapter, Agent Zero, NemoClaw, OpenClaude, LexOS services)
  -> GlueAI service configuration
  -> LiteLLM proxy (OpenAI-compatible API)
  -> NVIDIA NIM / FreeLLMAPI / OpenRouter / Ollama

FreeLLMAPI is an optional upstream, not a hard dependency. This avoids coupling
the platform to one gateway or provider.

## Integration contract

- Base URL: http://<gateway-host>:4000/v1
- Authentication: Bearer token from LITELLM_MASTER_KEY
- API family: OpenAI Chat Completions for compatible consumers
- Anthropic Messages: use LiteLLM's Anthropic-compatible route only for clients
  that require it; validate streaming, tool calls, system prompts and long context.
- Model names are logical aliases, not claims about model capability.

## Rollout sequence

1. Deploy LiteLLM privately and validate health + chat completion.
2. Add provider credentials via secrets, one provider at a time.
3. Run tool-use, streaming, context-window and structured-output tests per model.
4. Connect one non-production coding agent as the first consumer.
5. Add remaining agents, then LexOS through a separately tested adapter.
6. Register provider/model metadata and health status in GlueAI's Components
   and Health Checks tables when the Airtable integration is implemented.

## Security and cost controls

- Keep the listener loopback/private by default.
- Use TLS and network restrictions before remote access.
- Never commit API keys; rotate any key that has entered Git history.
- Set provider-side spending limits where available.
- Treat free-tier quotas and model availability as variable; do not promise
  uninterrupted free inference.
- Record model, provider, latency, token usage, status and estimated cost for
  each request before enabling production routing.

## Current implementation boundary

This commit adds the deployable LiteLLM service configuration and integration
contract. It does not create provider accounts, populate secrets, deploy a server,
or claim any consumer is connected. Those require environment-specific access
and live validation.
