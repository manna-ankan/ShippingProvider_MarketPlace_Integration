# Connector rules

1. Parameter types only: `TEXT`, `PASSWORD`, `HIDDEN`, `CHECKBOX`, `READONLY` (`SourceConnectorParameter.Type`).
2. Secrets: `PASSWORD` or `HIDDEN` with `encryptionRequired: true`.
3. Set `requiredInOrderSync` / `requiredInInventorySync` according to ticket capabilities.
4. Always set `verificationScriptName` when credentials need validation or token exchange.
5. Multi-connector: only when ticket needs separate credential domains (API vs webhook vs MCF). Do not copy Shopify's three connectors by default.
6. Verification script PersistentParams names must match connector parameter `name` fields exactly.
7. Re-authenticate recovery: document how seller pastes a new token when rotation fails (Carrefour).
8. Never put SELECT dropdowns on connectors — use `sourceConfigurationParameters` for SELECT.
9. Display names should be human-readable; avoid leaking internal jargon without tooltip help.
