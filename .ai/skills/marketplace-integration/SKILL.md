---
name: marketplace-integration
description: >-
  Canonical, tool-agnostic skill for implementing a new Uniware marketplace/channel
  integration from a Jira ticket plus marketplace API documentation, verified against
  real Uniware Java source. Two-phase: Phase A analyzes and produces an IntegrationSpec
  + questions, then stops for human approval; Phase B generates Mongo source.json, db.js,
  scraper scripts, and a validation report only after that approval. Works with or without
  a developer-supplied reference integration package. Self-contained — a human must
  explicitly point an agent at this file.
---

# Marketplace Integration — canonical skill

**If you are an AI agent and a human has just told you something like "use
`.ai/skills/marketplace-integration/` for this task" or "read
`.ai/skills/marketplace-integration/SKILL.md` and follow it" — this is the correct file.
Read it completely, in order, right now, before doing anything else.**

This skill is tool-agnostic. It is invoked **explicitly**. Paths are repository-relative
unless the developer supplies `UNIWARE_ROOT` for Tier 1 checks.

If you are a human: read `README.md` in this directory for usage prompts.

## Act as

A senior Uniware channel integration engineer. Never invent Uniware or marketplace behavior.
Never silently guess. This is not a free-form code generator.

## Step 0 — Resolve paths, then prerequisite check

1. `REPO_ROOT=$(git rev-parse --show-toplevel)`
2. Read and follow `prerequisite-check.md`
3. Read `generation-rules.md` (binding)
4. Read `architecture/entity-model.md`, `architecture/sync-patterns.md`, `schemas/integration-spec.schema.json`

Then as needed: `architecture/auth-patterns.md`, `architecture/status-mapping.md`, `rules/*.md`.

## Source of truth

1. **`[UNIWARE-CODE]`** — Uniware Java at `UNIWARE_ROOT`
2. **`[JIRA]`** — ticket requirements
3. **`[API-DOC]`** — marketplace API docs for this run
4. **`[RULE]`** — verified skill knowledge (`architecture/`, `rules/`)
5. Templates/examples — structure only; never override 1–3

Optional developer-supplied reference path is **not** a numbered tier. Never auto-discover references.

Jira vs Uniware conflicts → document both, `generationGate: NEEDS_REVIEW`, human decides.

## Non-negotiable behaviors

1. Follow `generation-rules.md` completely.
2. Never invent auth/webhook/proxy/catalog because a sample marketplace has them.
3. Never copy secrets from samples or Jira into artifacts.
4. Generate only ticket-scoped artifacts.
5. Never execute SQL/Mongo; never edit Uniware Java or `MarketPlace_Source/`.
6. No `connector.java.tpl` — marketplaces are script + Mongo `source` driven.

## Two phases

### Phase A — Analysis only (default)

Produce:

- Ticket understanding
- API analysis
- Uniware mapping (Source properties, connectors, jobs, webhook if any)
- Auth design (no default pattern)
- Sync model (polling / webhook-inbound / hybrid) + **listScriptStrategy** if webhook-only
- Inventory design (sync vs async-poll)
- Status inbound/outbound maps
- Script requirements list
- Assumptions / questions / risks
- `IntegrationSpec` conforming to `schemas/integration-spec.schema.json`
- `ANALYSIS.md` (see `examples/analysis-report.example.md`)
- `confidence` + `generationGate` (`BLOCKED` | `NEEDS_REVIEW` | `READY`)

**Stop.** Do not generate production artifacts in Phase A.

### Phase B — Generation (only after explicit human approval)

1. Fill `templates/source.json.tpl` + `templates/db.js.tpl` from approved spec
2. Generate only required scraper scripts from templates
3. Omit `db.sql` unless Uniware evidence requires it
4. Produce validation report + `checklists/manual-review-checklist.md`
5. Write to developer-specified output directory (scratch / non-production)

## Hard contracts

- Mongo collection: `source` (`Source.java`)
- Connector param types: TEXT, PASSWORD, HIDDEN, CHECKBOX, READONLY
- Order list XML: `SaleOrder` elements + optional `TotalPages` + `#resultItems`
- Order details: `CreateSaleOrderRequest` XML
- Inventory failures: `#failedInventorySnapshots` + `ChannelScriptError`
- Webhook inbound: `__data` via `UniwareWebhookService` — does not replace list script when order sync ON
- Auth: no default; rotating refresh must persist new refresh every exchange

## Design principle

```
AI            = reasoning, extraction, mapping, analysis
Rules/Schemas = deterministic structure
Templates     = deterministic stubs
Validator     = correctness checks
Human         = final approval and testing
```

## Supporting files

```
.ai/skills/marketplace-integration/
├── SKILL.md
├── README.md
├── PORTABILITY.md
├── prerequisite-check.md
├── generation-rules.md
├── architecture/
├── rules/
├── schemas/integration-spec.schema.json
├── templates/
├── checklists/
├── examples/
└── validation/
```
