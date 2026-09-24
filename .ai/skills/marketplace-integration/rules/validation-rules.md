# Validation rules

Before marking Phase B complete, check:

1. Every generated file is listed in the validation report with purpose.
2. Every wired `*.script.name` property has a matching generated (or explicitly deferred) script.
3. No secrets in plaintext — only placeholders.
4. Connector parameter names match verification PersistentParams names.
5. Inventory batch size ≤ API max and equals `process.inventory.count` unless ticket explains otherwise.
6. Catalog scripts absent when out of scope.
7. Auth pattern matches ticket (not a sibling marketplace).
8. User-Agent / mandatory headers present on all relevant HTTP calls.
9. Status maps cover READY/create and all apply/reconcile/log-only rows from ticket; open rows marked.
10. Webhook-only import: conflict about list script documented and resolution recorded.
11. Manual review checklist attached.
12. `generationGate` / readiness status set: `READY` | `NEEDS_REVIEW` | `BLOCKED`.
13. Output directory is scratch/non-production.
14. No edits to Uniware Java or MarketPlace_Source samples.
