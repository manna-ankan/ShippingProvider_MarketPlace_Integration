# Self-test — Carrefour UAE

## Method

Treated Carrefour Jira as greenfield input. Ran skill Phase A → Phase B into `marketplace-integrations/CARREFOUR_UAE/`. No existing `MarketPlace_Source/CARREFOUR*` to diff.

## Match vs skill intent

| Expected from skill | Result |
|---|---|
| Mongo `source` not shippingSource | Match |
| No catalog artifacts | Match |
| Rotating refresh + User-Agent | Match in utils/verification |
| Async inventory submit+poll | Match (structure) |
| Notification PACK/SHIP/DELIVER/DELIVER_FAILED | Match (structure; product JSON NEEDS_REVIEW) |
| Inbound webhook handler | Match (event switch; create SO wiring NEEDS_REVIEW) |
| listScriptStrategy omit | Match in spec + source `order.sync.configured=false` |
| generationGate NEEDS_REVIEW | Match |

## Skill gaps found and fixed in skill package

1. Added `rotating-refresh-token` to auth architecture + schema enum
2. Split inbound `scraper-webhook-handler` vs outbound `scraper-webhook-config`
3. Documented list-script conflict for webhook-only imports
4. Async inventory pattern in inventory template + sync-patterns.md
5. Dual-host + mandatory User-Agent in generation/script rules

## Remaining (not silent-filled)

- Full CreateSaleOrderRequest emission from webhook via Java services
- Inventory DTO price field name confirmation
- Ops webhook Basic Auth binding
- JWT shopId display

## Status

**NEEDS_REVIEW** — skill usable for Phase A/B scaffolding; Carrefour artifacts need engineer completion before production.
