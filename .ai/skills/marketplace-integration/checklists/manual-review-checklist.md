# Manual review checklist

## Gate

- [ ] Phase A IntegrationSpec reviewed
- [ ] `generationGate` was READY (or NEEDS_REVIEW items explicitly accepted)
- [ ] Blocking questions answered or deferred with owner

## Source / connectors

- [ ] `source` collection document (not shippingSource)
- [ ] `type` / `localization` correct
- [ ] Only required script properties wired
- [ ] Connector param types valid; secrets encrypted
- [ ] Verification PersistentParams names match connector fields

## Scripts

- [ ] Mandatory headers present on all marketplace HTTP calls
- [ ] Auth refresh persists rotated tokens if applicable
- [ ] Inventory batching ≤ API max; per-SKU errors surfaced
- [ ] Notification payloads match field table
- [ ] Webhook handler idempotent; skip rules correct
- [ ] No catalog scripts if out of scope
- [ ] List-script strategy decided for webhook-only imports

## Safety

- [ ] No live secrets in files
- [ ] Artifacts in scratch/output dir only
- [ ] SQL/Mongo not executed by agent
- [ ] Uniware Java / MarketPlace_Source untouched

## Readiness

Status: `READY` / `NEEDS_REVIEW` / `BLOCKED`

Notes:
