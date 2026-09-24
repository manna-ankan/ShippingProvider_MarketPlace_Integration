# Entity model: Source template vs Channel tenant instance

Verified against Uniware Java at `UNIWARE_ROOT` and five sample Mongo dumps under `MarketPlace_Source/`.

## Two layers — do not conflate

| Layer | Entity | Store | Scope | Created by |
|---|---|---|---|---|
| Template / global | `Source` | MongoDB collection `source` | One doc per channel product (e.g. `SHOPEE`, `TRENDYOL`, `SHOPIFY`) | Hand-authored Mongo insert (`db.js` / `source.json`). |
| Template / connector | `SourceConnector` + `SourceConnectorParameter` | Embedded in same Mongo doc | Credential fields + verification script | Same Mongo doc |
| Template / UI config | `sourceConfigurationParameters` | Embedded in same Mongo doc | Channel setup UI knobs | Same Mongo doc |
| Tenant instance | `Channel` | RDBMS | One row per tenant that enables the source | Admin UI / `ChannelServiceImpl` |
| Tenant credentials | `ChannelConnector` + `ChannelConnectorParameter` | RDBMS | Per connector declared on source | Seeded when channel is added; filled via verification |

**Consequence**: a new-marketplace task produces the Mongo `source` document and scraper scripts. It does **not** produce SQL to insert `Channel` rows — those are tenant-admin actions.

## `Source` Mongo document

`@Document(collection = "source")` — `[UNIWARE-CODE]` `UniwareCore/.../Source.java:18`

Core fields (samples + entity):

```
code, name, enabled, priority, type, localization, created, updated,
sourceProperties[], sourceConfigurationParameters[], sourceConnectors[]
```

### `Source.Type` enum

`[UNIWARE-CODE]` `Source.java` Type enum: `B2B`, `CART`, `MARKETPLACE`, `POS`, `WMS`, `QC`.

| Sample | type |
|---|---|
| SCAPIA, SHOPEE, TataCliq, Trendyol | `MARKETPLACE` |
| Shopify | `CART` |

Skill must not assume `MARKETPLACE` only. Set `type` from the ticket (`MARKETPLACE` for Carrefour UAE).

## Java-known script property keys

Constants on `Source.java` (selected — cite when asserting):

| Property key | Constant | Purpose |
|---|---|---|
| `sale.order.list.script.name` | `SALE_ORDER_LIST_SCRIPT_NAME` | Order list pull |
| `sale.order.details.script.name` | `SALE_ORDER_DETAILS_SCRIPT_NAME` | Order detail → CreateSaleOrderRequest |
| `sale.order.list.resync.script.name` | `SALE_ORDER_LIST_SCRIPT_NAME_RESYNC` | Repull (Shopify) |
| `inventory.update.script.name` | `INVENTORY_UPDATE_SCRIPT_NAME` | Inventory push |
| `inventory.update.cron.expression` | | Inventory cron |
| `sale.order.import.cron.expression` | | Order import cron |
| `sale.order.status.sync.script.name` | `SALE_ORDER_STATUS_SYNC_SCRIPT_NAME` | Status pull/reconcile |
| `sale.order.status.sync.metadata.script.name` | | Status metadata |
| `sale.order.status.sync.batch.metadata.script.name` | | Batch metadata |
| `sale.order.cancellation.script.name` | | Cancel on channel |
| `notification.script.name` | `NOTIFICATION_SCRIPT_NAME` | Outbound status/notify |
| `channel.item.type.list.script.name` | | Catalog list |
| `channel.item.type.details.script.name` | | Catalog detail |
| `channel.catalog.sync.preprocessor.script.name` | | Catalog preprocessor |
| `channel.configuration.verification.script.name` | `CHANNEL_CONFIGURATION_VERIFICATION_SCRIPT_NAME` | On enable/disable |
| `shipping.provider.allocation.script.name` | | Courier allocation |
| `dispatch.verification.script.name` | | Dispatch verify |
| `fetch.pendency.script.name` | | Pendency |
| `fetch.invoice.script.name` | | Invoice |
| `verify.order.script.name` | | Acknowledge/verify |
| `pre.configuration.script.name` / `post.configuration.script.name` | | OAuth setup (Shopee) |
| `order.sync.configured` / `inventory.sync.configured` | | Feature flags |
| `notifications.enabled` | | Enable notification processing |
| `process.inventory.count` | | Inventory batch size |
| `process.notification.count` | | Notification batch size |
| `active` / `allow.multiple.channel` | | Source flags |

### Convention-only properties (no Java constant)

| Key | Notes |
|---|---|
| `utils.script` | Free-form; scripts read via `#source.getStringifiedFieldValue('utils.script')`. Present on Shopify (+ similar helper invokes elsewhere). |
| `generic.channel.api.url` | SCAPIA adapter family |
| `api.url` / `staging.api.url` | Trendyol |
| `mcf.*` / `heartbeat.*` / `channels.*.event.process.script.name` | Shopify-specific — do not generalize |

When using a non-constant key, mark it `scriptOnly` in the IntegrationSpec with a reason.

## `SourceConnector`

`[UNIWARE-CODE]` `SourceConnector.java`:

- `sourceCode`, `name`, `displayName`, `helpText`, `priority`
- `thirdParty`
- `requiredInOrderSync`, `requiredInInventorySync`, `requiredInReconciliationSync`, `requiredInChannelWarehouseInventorySync`
- `verificationScriptName`
- `sourceConnectorParameters`

Multi-connector sources are supported (Shopify: API + WEBHOOK + MCF). Most MARKETPLACE samples use one connector.

## `SourceConnectorParameter.Type`

`[UNIWARE-CODE]` `SourceConnectorParameter.java`:

`TEXT`, `PASSWORD`, `HIDDEN`, `CHECKBOX`, `READONLY`

No `SELECT` on connector parameters. Dropdowns belong on `sourceConfigurationParameters`.

`encryptionRequired` — set `true` for secrets (password, tokens, refresh tokens).

## Configuration parameter types (channel UI)

From samples: `TEXT`, `PASSWORD`, `HIDDEN`, `CHECKBOX`, `SELECT`, `FORMULA` with `groupName` typically `ORDER` / `INVENTORY` / `GENERAL`.

## Tenant Channel (not generated)

Created via admin after the source template exists. Credentials live on `ChannelConnectorParameter`. Verification scripts may emit `<PersistentParams>` to persist rotated tokens — see `architecture/auth-patterns.md`.
