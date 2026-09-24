# Generation rules (binding)

These rules bind every future run of this skill. Violating them is a skill failure.

## Traceability

1. Every generated artifact must trace to at least one of: `[JIRA]`, `[API-DOC]`, `[UNIWARE-CODE]` (cited in `architecture/`).
2. Tag non-trivial claims with their source tag.
3. Templates/examples never override tiers 1–3.

## No guessing

4. No invented marketplace behavior. Anything not in the target marketplace's API docs / Jira → `UNKNOWN` / `NEEDS_REVIEW`.
5. No invented Uniware behavior. Anything not confirmed in Uniware source → `UNKNOWN` / `NEEDS_REVIEW`.
6. Never copy a sibling marketplace's auth, endpoints, status names, or SKU formats onto a new marketplace.
7. Never invent OAuth/webhook/proxy because Shopify or Shopee use them.

## Scope

8. Generate only artifacts required by the ticket. Do not emit the full template set by default.
9. If catalog is out of scope, do not generate catalog scripts or wire catalog properties.
10. If order import is webhook-only, document the list-script conflict (see `architecture/sync-patterns.md`) and require human choice before generating a stub/omit decision.

## Safety

11. Never execute generated SQL/Mongo scripts.
12. Never modify production Uniware code or live databases.
13. Write artifacts only to a developer-specified or clearly scratch output directory.
14. Never modify this skill's sample folders (`MarketPlace_Source/`) or the shipping-provider skill.
15. Mask all secrets with `<ANGLE_BRACKET>` placeholders. Never copy live tokens from samples/Jira into artifacts.

## Conflict handling

16. Jira vs Uniware conflicts → document both options, `generationGate: NEEDS_REVIEW`, human picks. No silent resolution.
17. Missing info labels only: `Missing`, `Assumption`, `Requires Developer Confirmation`.

## Phase gate

18. Phase A produces IntegrationSpec + ANALYSIS.md and **stops**.
19. Phase B runs only after explicit human approval of Phase A.
20. Always emit a manual review checklist and readiness status: `READY` / `NEEDS_REVIEW` / `BLOCKED`.

## Auth / sync specifics

21. Authentication has no default pattern.
22. Rotating refresh tokens must persist the new refresh on every exchange and document serialization.
23. Mandatory headers from the ticket (e.g. Carrefour User-Agent) are hard contracts in scripts.
24. Webhook-only import does not remove the need to decide how periodic order sync is disabled or stubbed.
