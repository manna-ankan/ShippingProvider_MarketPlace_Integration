# Self-test regression — Trendyol

## Method

Reconstructed a minimal ticket from `MarketPlace_Source/Trendyol/` behavior and compared what the skill would generate vs the real sample.

## Expected skill Phase B set (polling MARKETPLACE)

- source.json type MARKETPLACE, INTERNATIONAL
- Connector: username/password/sellerId, Basic auth
- Scripts: order list, details, inventory, status sync, cancel, user verification, shipping allocation, dispatch verification, item type list/detail, pendency, invoice
- utils via trendyolUtilsScript (sample references utils not always in folder)
- notifications.enabled false → no notification script required

## Match vs `MarketPlace_Source/Trendyol/`

| Area | Match? | Notes |
|---|---|---|
| Source type MARKETPLACE | Yes | |
| Polling order list + details | Yes | Skill templates cover SaleOrders + CreateSaleOrderRequest |
| Inventory push barcode+qty | Yes | Sync pattern (not Carrefour async) |
| Basic auth | Yes | auth-patterns pattern 3 |
| Status sync in-script maps | Yes | |
| storeFrontCode config | Variation | Marketplace-specific — ticket must supply |
| Hardcoded apigw URL overrides in scripts | Diverge | Sample quirk; skill should use source `api.url` unless ticket hardcodes — correctly NOT copied as TRUE ARCHITECTURE |
| process.inventory.count=1000 | Variation | Ticket/config |
| Empty notification.script.name | Match | capability notification=false |

## Skill gaps

None blocking. Optional: add note in script-rules that international storefront headers are ticket-specific.

## Status

**Pass** — skill does not force Carrefour/Shopify patterns onto Trendyol.
