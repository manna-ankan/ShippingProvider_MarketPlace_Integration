# Self-test regression — Shopify

## Method

Compared skill templates/architecture to `MarketPlace_Source/SHOPIFY/` for CART + hybrid webhook + multi-connector.

## Expected skill recognition

- sourceType CART (not MARKETPLACE)
- syncModel hybrid (polling + optional webhook registration)
- connectors: API + WEBHOOK (+ MCF only if ticket asks — default false)
- utils.script, catalog preprocessor, order repull, channel configuration — conditional templates exist
- Do NOT require MCF by default

## Match vs sample

| Area | Match? | Notes |
|---|---|---|
| CART type supported | Yes | entity-model + schema |
| Multi-connector | Yes | connector-rules |
| Outbound webhook config template | Yes | scraper-webhook-config.xml.tpl |
| Inbound UniwareWebhook vs Shopify registration | Distinguished | architecture/sync-patterns.md |
| utils.script | Yes | |
| Proxy URLs | ONE-OFF | Correctly flagged not generalizable |
| MCF | Optional capability default false | Match skill rule |
| channels.*.event.process.script.name="true" | UNKNOWN/legacy | Flagged in mining; skill must not invent |
| TestShopify.java pattern | tests.tpl checklist | Sanitized; no credential copy |

## Skill gaps

- Shopify proxy base URL selection remains marketplace-specific (correct)
- Event-process properties as `"true"` strings stay UNKNOWN — do not auto-generate

## Status

**Pass** — Carrefour inbound webhook template did not overwrite Shopify outbound registration pattern; both coexist.
