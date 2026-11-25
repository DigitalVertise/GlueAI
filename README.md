# GlueAI

GlueAI is the reusable component operating layer for DV-AIOS.

It provides:
- component registry across the DV-AIOS workspace
- plug-and-play AI building blocks
- MCP + A2A-ready orchestration
- self-healing lifecycle management
- Airtable-backed operational memory
- package-ready delivery pipeline from discovery to ship

## Workspace configuration

- Workspace: Digital Vertise AIOS
- Canonical base: DVOS-AIOS
- Base ID: appyhvy0UPaOXdCcB
- Registry tables:
  - Components
  - Repositories
  - Packages
  - Pipelines
  - Health Checks

## Shared model gateway

A LiteLLM proxy foundation is provided at [gateway/litellm](gateway/litellm/README.md).
It gives DV-AIOS consumers one OpenAI-compatible model endpoint and supports
optional FreeLLMAPI, NVIDIA NIM, OpenRouter and local Ollama upstreams.
FreeLLMAPI is optional; provider credentials are configured outside Git in
`gateway/litellm/.env`.

See [the shared gateway architecture and rollout contract](docs/SHARED-MODEL-GATEWAY.md).

## Setup

1. Copy `.env.example` to `.env`
2. Add your Airtable API key to `AIRTABLE_API_KEY`
3. Run:
   npm install
   npm run dev

## Airtable sync

The app is designed to sync component metadata and package readiness into the configured Airtable base.
