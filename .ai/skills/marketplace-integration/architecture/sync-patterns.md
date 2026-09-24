# Sync patterns: polling, jobs, webhooks, notifications

## Baseline: polling (TRUE ARCHITECTURE)

All five samples set:

- `order.sync.configured=true`
- `sale.order.import.cron.expression` (~ every 10 minutes)
- `inventory.sync.configured=true`
- `inventory.update.cron.expression` (~ every 10 minutes)

### Order import job path

`[UNIWARE-CODE]`

1. `ThirdPartySaleOrderImportTask` → filters channels → `IChannelOrderSyncService.syncChannelOrders`
2. `ChannelOrderSyncServiceImpl` loads **list** and **details** scripts with `required=true`
3. List script → XML with `SaleOrder` elements (+ optional `TotalPages`) + `#resultItems` map
4. Per code → details script → `CreateSaleOrderRequest` XML → `createB2CSaleOrder`

**Hard fact:** omitting `sale.order.list.script.name` causes periodic/manual order sync to throw. There is no Java branch that skips list script when webhooks exist.

### Inventory job path

`[UNIWARE-CODE]` `ChannelInventorySyncServiceImpl.syncInventoryOnChannel`:

- Context: `#inventorySnapshot` (DTO or list), `#failedInventorySnapshots` (`Map<String,ChannelScriptError>`), success maps
- Scripts report per-SKU failures into `failedInventorySnapshots`
- Batch size from `process.inventory.count`
- Thrown script errors may remap via `SourceErrorMapping` (`Type.CHANNEL`)

### Status sync job path

`[UNIWARE-CODE]` `ChannelOrderStatusSyncServiceImpl`:

- Script: `sale.order.status.sync.script.name`
- Output: `SaleOrderItem` + `StatusCode` → channel status change events
- Optional metadata / batch metadata scripts

### Notification (outbound) path

`[UNIWARE-CODE]` `NotificationServiceImpl.processPendingChannelNotifications`:

- Requires channel notifications enabled + `notification.script.name`
- Context maps: `notifications`, `failedNotifications`, `successfulNotifications`, `retryableNotifications`
- Used for push status to channel (pack/ship/deliver) — TataCliq, SCAPIA, Shopify; disabled on Shopee/Trendyol samples

## Webhooks

### Inbound Uniware webhook (platform)

`[UNIWARE-CODE]` `UniwareWebhookService.execute(webhookId, data)`:

- Loads Mongo webhook by id → runs `scriptName`
- Context: `__data` (raw body), `__applicationContext`
- HTTP: `POST …/webhook/{webhookId}` (tenant API auth)
- VO fields confirmed: `id`, `scriptName` (exact collection schema partially UNKNOWN)

A webhook script **can** create/reconcile orders via application services. It does **not** replace the list script inside `ChannelOrderSyncServiceImpl`.

For **webhook-only order import** (Carrefour):

1. Implement inbound webhook script that creates/reconciles sale orders
2. Register UniwareWebhook document (mark registration steps NEEDS_REVIEW if ticket does not specify ops process)
3. Either omit list script and keep **order sync OFF** for the channel, **or** provide a no-op/stub list script — document the conflict and require human choice (`IntegrationSpec.conflicts[]`)
4. Shopify's `shopifyWebhookScript` configures **outbound** Shopify subscriptions via proxy — different pattern from Carrefour inbound callback

### Outbound webhook registration (Shopify)

- Connector `SHOPIFY_WEBHOOK` + `shopifyWebhookScript` / `shopifyChannelConfigurationScript`
- Calls proxy `PUT …/connectors/events/configure`
- Optional `realTimeSync` YES/NO
- Do not assume Carrefour uses this pattern

## Async inventory (Carrefour)

`[JIRA]` Carrefour:

1. `POST …/inventory-update` with up to 100 SKUs → returns `transactionId`
2. `POST …/inventory-update/status` with transactionId → per-SKU `SUCCESS` / `IMPORT_ERROR`
3. Surface per-SKU errors without failing the whole batch
4. Price mandatory; omit `posId` (default POS); no discount fields

Extend inventory template for submit+poll when ticket requires it.

## Catalog sync

Optional. Wired via item type list/detail scripts when present. Carrefour: **no catalog API** — do not generate catalog scripts. Shopify has async catalog + preprocessor — generate only if ticket asks.

## Price sync

Samples typically have `pricing.sync.configured=false`. Carrefour pushes price **inside** inventory update — not a separate pricing sync capability.

## Utils script convention

Optional shared helper (`utils.script` property). Invoked as `<invoke method="…" script="…">`. Use for token exchange, headers, dual-host URLs, rate limits. Present on Shopify; similar helpers on Shopee/Trendyol/SCAPIA (sometimes missing from sample folders).
