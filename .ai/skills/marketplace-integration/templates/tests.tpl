# Test checklist template (sanitized)

Do not copy live credentials from `TestShopify.java` or any sample.

## Unit / sandbox script checks

- [ ] Load verification script in scraper sandbox with placeholder connector params
- [ ] Access token exchange succeeds with valid refresh; fails clearly with invalid
- [ ] Rotated refresh persisted (PersistentParams) after verification
- [ ] Inventory batch ≤ API max; per-SKU error does not fail siblings
- [ ] Notification PACK/SHIP/DELIVER payloads match field table
- [ ] Webhook handler skips non-self-fulfilment; creates order for READY
- [ ] Duplicate webhook event does not double-apply status

## Integration checks (staging)

- [ ] Source document loaded; SourceConfiguration cache refreshed
- [ ] Channel connector save + verify
- [ ] Inventory sync job
- [ ] Inbound webhook with Basic Auth (if applicable)
- [ ] End-to-end pack → ship → deliver on channel panel

## Security

- [ ] No real tokens committed
- [ ] User-Agent / mandatory headers present
