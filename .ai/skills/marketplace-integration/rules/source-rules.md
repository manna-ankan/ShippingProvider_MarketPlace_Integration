# Source document rules

1. Mongo collection is `source` — never `shippingSource`.
2. Do not include `_id` in generated inserts (Mongo assigns it).
3. `code` must be uppercase alphanumeric + underscore, unique.
4. `type` must be a real `Source.Type` value (`MARKETPLACE`, `CART`, …) from the ticket.
5. Property keys used by Java must match `Source.java` constants when applicable.
6. Boolean-ish flags: prefer `"true"`/`"false"` strings as samples do unless a property is known to differ.
7. `process.inventory.count` must be a string integer matching batch limits from the API (e.g. Carrefour max 100).
8. Do not wire catalog script properties when catalog is out of scope.
9. Do not set `pricing.sync.configured=true` unless the ticket has a pricing sync API.
10. `utils.script` is optional convention — set only when generating a shared utils script.
11. Never copy live API keys, refresh tokens, or partner secrets from samples into `source.json`.
12. `reserved.keywords.for.short.name` should include the marketplace code plus DEMO,PRODUCTION,LTD,PVT unless ticket says otherwise.
