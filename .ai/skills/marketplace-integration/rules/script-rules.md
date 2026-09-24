# Script rules

## General

1. Use scraper XML (`<scraper name="…">`) with Uniware scraper DSL.
2. Mask secrets; never embed live tokens.
3. Log at info/debug with marketplace tag prefixes for supportability.
4. Use `#source`, `#channel`, connector params as injected by Uniware — do not invent context vars not documented in architecture.

## Order list (when generated)

5. Emit `<SaleOrders>` with `<SaleOrder>` text = order code; populate `#resultItems`.
6. Optional `<TotalPages>` for pagination (`GetSaleOrderListScriptResponse`).
7. Periodic sync requires this script if order sync is ON (`required=true` in Java).

## Order details

8. Emit `CreateSaleOrderRequest` XML (`xmlns="http://uniware.unicommerce.com/services/"`).
9. Map fields only from ticket/API — do not invent billing lines if API does not send them (copy shipping → billing when ticket says so).

## Inventory

10. Iterate `#inventorySnapshot`; write failures to `#failedInventorySnapshots` with `ChannelScriptError`.
11. Honor `process.inventory.count` / API max batch size.
12. Async patterns: submit → poll status; map per-SKU SUCCESS/IMPORT_ERROR without failing siblings.

## Status sync

13. Emit SaleOrderItem StatusCode values that Uniware understands.
14. Prefer reconcile-over-blind-apply when ticket warns about duplicate events.

## Notification (outbound)

15. Handle only notification entities/statuses in ticket scope (e.g. PACK/SHIP/DELIVER).
16. Line refuse rules must follow ticket (Carrefour: full line ACCEPT/REFUSED; shippedQty = original qty).

## User verification

17. Persist rotated tokens via `<ConnectorParams><PersistentParams>`.
18. Fail clearly on invalid credentials; do not persist bad refresh tokens.

## Utils

19. Centralize auth headers, User-Agent, dual-host base URLs, serialized refresh.
20. Invoke with `<invoke method="…" script="{{UTILS_SCRIPT_NAME}}">`.

## Webhook handler (inbound)

21. Read payload from `__data` (UniwareWebhookService).
22. Filter fulfilment modes / skip rules from ticket.
23. Create or reconcile sale orders idempotently.
24. Do not assume Shopify outbound registration pattern.

## Mandatory headers

25. If ticket mandates a header (e.g. `User-Agent: Neptune-API-Client/1.0`), every HTTP call to that API must include it.
