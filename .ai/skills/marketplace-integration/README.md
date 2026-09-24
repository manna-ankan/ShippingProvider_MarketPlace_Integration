# Marketplace Integration Skill — Developer Guide

Canonical, **tool-agnostic** workflow for new Uniware marketplace/channel integrations.
Invoke by telling your AI agent to read this skill — it is not auto-discovered.

## Quick start — Phase A

```text
Use the canonical Marketplace Integration skill:

.ai/skills/marketplace-integration/SKILL.md

Read the skill and supporting architecture/rules/templates before doing anything else.

UNIWARE_ROOT: /Users/bharamdev/Desktop/Uniware

(Optional) Reference path: MarketPlace_Source/Trendyol/
(Optional) Also compare: MarketPlace_Source/SHOPIFY/

I will provide:
1. Jira ticket
2. Marketplace API documentation

Analyze using PHASE A only.
Do not generate production artifacts yet.
After analysis, stop and wait for my approval.

--- JIRA ---
<paste ticket>

--- API DOCUMENTATION ---
<paste endpoints / samples>
```

## Phase B — after approval

```text
Phase A is approved.

Proceed to PHASE B for this integration.

Generate artifacts into: marketplace-integrations/<SOURCE_CODE>/

Do not apply any database changes directly.
Do not modify Uniware Java or MarketPlace_Source samples.
```

## What this skill produces

- Mongo `source` document (`source.json` + `db.js`)
- Scraper XML scripts (only those in ticket scope)
- Manual review checklist + validation report
- IntegrationSpec (Phase A)

It does **not** create tenant `Channel` rows or run Mongo inserts.

## Prerequisites

- Uniware checkout (`UNIWARE_ROOT`) with `UniwareCore` + `UniwareServices`
- Jira + API docs for the marketplace
- Optional: a reference folder under `MarketPlace_Source/<CODE>/`

## Related skill

Shipping couriers use `.ai/skills/shipping-provider-integration/` — different Mongo collection
(`shippingSource`) and different scripts. Do not mix the two frameworks.
