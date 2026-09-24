# Portability

- No absolute paths inside skill knowledge/rules/templates (except documenting that humans supply `UNIWARE_ROOT`).
- Resolve `REPO_ROOT` via git; skill paths are `$REPO_ROOT/.ai/skills/marketplace-integration/…`
- `UNIWARE_ROOT` is developer-supplied per run.
- Reference integrations optional and never auto-discovered.
- Do not commit generated `marketplace-integrations/**` scratch output or secrets.
- This directory is the canonical tool-agnostic skill (sibling to shipping-provider-integration).
