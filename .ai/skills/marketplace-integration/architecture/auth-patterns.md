# Authentication patterns

Grounded in five samples + Uniware connector verification. **Authentication has no default** — derive from the ticket/API docs.

## Connector verification contract

`[UNIWARE-CODE]` `ChannelServiceImpl.verifyAndSyncChannelConnector`:

1. Runs `SourceConnector.verificationScriptName`
2. Parses script XML output for:
   - `<Challenge>` — auth challenges
   - `<PersistentParams><Name/><Value/></PersistentParams>` — persisted (encrypted) connector params
   - `<TransientParams>` — non-persisted
3. Empty output can still mean success
4. No verification script → echo existing params as successful

Use PersistentParams to save rotated tokens (Shopee refresh, Carrefour rotating refresh).

## Catalogued patterns

### 1. Username/password → access token (SCAPIA, TataCliq)

- Connector: username + password (+ HIDDEN authToken)
- Verification: login API → persist `authToken`
- Calls: API key header or Bearer with stored token
- 401 paths often re-auth

### 2. Partner OAuth + HMAC sign (Shopee)

- Connector: shopID (READONLY), authToken, refreshToken, authTokenExpiresIn (HIDDEN)
- `pre.configuration` / `post.configuration` scripts for OAuth redirect
- Partner id/key on source properties (sample typo: `patner.id` / `patner.key` — do not invent new typos)
- Verification refreshes access token via utils script; PersistentParams update tokens

### 3. HTTP Basic (Trendyol)

- Connector: username, password, sellerId
- Utils script builds `Authorization: Basic {base64}`
- Channel config may add headers (e.g. `storeFrontCode`)

### 4. Private-app / API key + password (Shopify)

- Connector: hostname, apiKey, password (+ OAuth hidden fields)
- Optional `X-Shopify-Access-Token`
- Often routed through Uniware proxy (`utils.script`) — **Shopify-specific; do not assume proxy for other channels**

### 5. Rotating single-use refresh token (Carrefour — ticket-defined)

`[JIRA]` Carrefour UAE — not present in the five samples as a first-class pattern. Documented here so the skill can generate it without inventing from siblings:

- Seller pastes refresh token in connector
- `POST …/accesstoken` with body `{"refreshToken":"…"}` returns **new** refreshToken + accessToken
- Previous refresh token is invalidated — **must persist new refresh on every exchange**
- Access token ~24h
- **Serialize refresh** — concurrent inventory + order jobs must not race-refresh
- Invalid token may return **500** (not 401) with fault envelope
- Mandatory header: `User-Agent: Neptune-API-Client/1.0` (missing → hang)
- Re-authenticate action: seller pastes fresh portal token

Verification script must:

1. Exchange refresh → access
2. Decode/display shop ID + country for confirmation
3. Persist rotated refresh + access via PersistentParams
4. Fail clearly on invalid token without saving bad state

## Dual-host APIs

Some marketplaces use different hosts for different operations (Carrefour: `retail-platform.mafrservices.com` for auth/inventory; `api-prod.retailsso.com` for status push). Same access token may work on both. Encode as source properties or utils script constants — never hardcode secrets.

## Multi-connector

Shopify proves multiple connectors per source with different `verificationScriptName` and `requiredIn*` flags. Generate additional connectors only when the ticket requires them (e.g. webhook credentials connector).

## Rules

1. Never invent OAuth because a sibling marketplace uses OAuth.
2. Never copy credentials from samples into templates or generated artifacts — use `<ANGLE_BRACKET>` placeholders.
3. If the ticket does not describe token refresh, use static credentials with no refresh logic.
4. Mark auth pattern `other` in IntegrationSpec when it does not match patterns 1–4; describe fully (Carrefour = pattern 5 / `other` with description).
