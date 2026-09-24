# Status mapping rules

1. Prefer in-script maps for channel → Uniware statuses (sample TRUE ARCHITECTURE). Do not invent RDBMS mapping tables without Uniware evidence.
2. Use only Uniware status/event codes confirmed by `[UNIWARE-CODE]` or explicitly listed in the ticket as UC targets.
3. Log-only events must not mutate sale order / package state.
4. Duplicate inbound events: reconcile against current state when ticket requires it.
5. **Mandatory dual-option gate** when Jira mapping conflicts with Uniware event types:
   - Record in `IntegrationSpec.conflicts[]`
   - `generationGate: NEEDS_REVIEW`
   - Human chooses before generating the affected script
6. Open marketplace questions (unknown event names, unconfirmed COMPLETE meaning) stay `NEEDS_REVIEW` — never invent.
7. Outbound status sequence must match ticket (e.g. PACK then SHIP then DELIVER) — do not skip required fields.
