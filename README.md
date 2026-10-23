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

## Setup

1. Copy `.env.example` to `.env`
2. Add your Airtable API key to `AIRTABLE_API_KEY`
3. Run:
   npm install
   npm run dev

## Airtable sync

The app is designed to sync component metadata and package readiness into the configured Airtable base.
