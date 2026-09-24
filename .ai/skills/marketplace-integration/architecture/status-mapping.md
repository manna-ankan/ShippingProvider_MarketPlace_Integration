# Status mapping: order, return, cancellation

## Where mapping lives

Across the five samples, status mapping is **in-script** (HashMaps / switch logic inside status-sync or notification scripts), **not** a shipping-style RDBMS `shipment_tracking_status_mapping` table.

`[UNKNOWN]` Whether a general channel status-mapping DB table exists for marketplaces — do not invent `db.sql` status rows unless Uniware source for this ticket confirms it.

## Status sync script contract

`[UNIWARE-CODE]` `ChannelOrderStatusSyncServiceImpl`:

- Emits `SaleOrderItem` elements with `StatusCode` values that map to `ChannelOrderStatusChangeEvent.Type`
- Observed UC statuses in samples: `CANCELLED`, `DELIVERED`, `DISPATCHED`, `RETURN_EXPECTED`, `RETURN_EXPECTED_CANCEL_EXISTING`, `RETURN_EXPECTED_COURIER_ALLOCATION`, `COURIER_RETURN`, `RETURNED`, `RETURN_CANCELLED`, etc.

**Rule:** Only use Uniware status codes confirmed by ticket + Uniware event types. Mark unknown codes `NEEDS_REVIEW`.

## Inbound vs outbound

| Direction | Typical mechanism | Samples |
|---|---|---|
| Channel → UC (pull) | `sale.order.status.sync.script.name` | All five |
| Channel → UC (push/webhook) | Inbound webhook script / event processing | Shopify hybrid; Carrefour ticket |
| UC → Channel | `notification.script.name` on package/order notifications | SCAPIA, TataCliq, Shopify |

## Cancellation

- Script: `sale.order.cancellation.script.name`
- May include reason enums on source properties (Shopee)
- Inbound CANCELLED events may be handled in status sync / webhook without a separate cancel API (Carrefour)

## Returns / RTO

- Often mapped inside status sync (TataCliq numeric codes → `RETURN_EXPECTED` / `COURIER_RETURN`)
- Shopify notification can create returns on channel panel — marketplace-specific
- Carrefour: receive-only via events (`RECEIVING` → `RETURN_EXPECTED`, `RECEIVED` → `RETURN_ACKNOWLEDGED`, `RETURN_COMPLETED` → `RETURNED`); no returns API

## Idempotency / reconcile

`[JIRA]` Carrefour: events may repeat statuses already applied (seller acts in portal). Transitions must reconcile against current UC state — do not re-apply blindly.

Samples show similar care in Shopify status sync (qty reconciliation). Treat reconcile-before-apply as a generation rule when ticket says so.

## Dual-option conflict gate

When Jira status mapping conflicts with Uniware-allowed event types:

1. Document both options in `IntegrationSpec.conflicts[]`
2. Set `generationGate: NEEDS_REVIEW`
3. Do not silently pick either side

## Carrefour event map (ticket — generate from this, do not invent)

| Carrefour event | UC action |
|---|---|
| READY | Create SO + package CREATED |
| EXPORTED | Log only |
| PACKING_COMPLETE | Reconcile → PACKED |
| DISPATCHED | Reconcile → DISPATCHED |
| DELIVERED | Apply DELIVERED |
| DELIVERY_FAILED | RETURN_EXPECTED |
| CANCELLED | CANCELLED (stop fulfilment) |
| RECEIVING | RETURN_EXPECTED |
| APPROVING, WAIT | Log only |
| RECEIVED | RETURN_ACKNOWLEDGED |
| RETURN_COMPLETED | RETURNED |
| COMPLETED | Log only (unconfirmed meaning) |
| TAX_*/PAYMENT_* reversal events | Log only |

Open with Carrefour (block confidence, not silent guesses): rejection event name; pack status repeatability; consignment split behavior.
