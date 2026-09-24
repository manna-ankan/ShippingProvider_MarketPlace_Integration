# Prerequisite check

Run before Phase A of any generation task.

## Procedure

1. `REPO_ROOT=$(git rev-parse --show-toplevel)`
2. Resolve `UNIWARE_ROOT` from the developer prompt, or environment variable `UNIWARE_ROOT`.
   If unset, stop and ask — do not guess a path.
3. Check Tier 1 files below. Any missing → hard stop.
4. Tier 2 reference package: only if developer explicitly provides a path.

## Tier 1 — Uniware source (hard requirement)

Relative to `UNIWARE_ROOT`:

```
UniwareCore/src/main/java/com/uniware/core/entity/Source.java
UniwareCore/src/main/java/com/uniware/core/entity/SourceConnector.java
UniwareCore/src/main/java/com/uniware/core/entity/SourceConnectorParameter.java
UniwareCore/src/main/java/com/uniware/core/entity/Channel.java
UniwareCore/src/main/java/com/uniware/core/api/channel/GetSaleOrderListScriptResponse.java
UniwareCore/src/main/java/com/uniware/core/vo/UniwareWebhook.java
UniwareServices/src/main/java/com/uniware/services/configuration/SourceConfiguration.java
UniwareServices/src/main/java/com/uniware/services/channel/saleorder/impl/ChannelOrderSyncServiceImpl.java
UniwareServices/src/main/java/com/uniware/services/channel/impl/ChannelInventorySyncServiceImpl.java
UniwareServices/src/main/java/com/uniware/services/channel/saleorder/status/impl/ChannelOrderStatusSyncServiceImpl.java
UniwareServices/src/main/java/com/uniware/services/channel/impl/ChannelServiceImpl.java
UniwareServices/src/main/java/com/uniware/services/notification/impl/NotificationServiceImpl.java
UniwareServices/src/main/java/com/uniware/services/webhook/impl/UniwareWebhookService.java
UniwareServices/src/main/java/com/uniware/services/tasks/imports/ThirdPartySaleOrderImportTask.java
```

If missing:

```
Required Uniware source file is missing.

Expected:
<UNIWARE_ROOT>/<path>

This is a prerequisite for reliable analysis — please confirm UNIWARE_ROOT points to a
complete Uniware checkout before proceeding.
```

Do not proceed with reduced confidence.

## Tier 2 — Reference integration (optional)

Never auto-discover. If no path provided, state in analysis:

```
No reference integration path was provided for this run.
Analysis used Uniware source + skill architecture/rules + ticket/API docs only.
```

If provided (e.g. `MarketPlace_Source/SHOPIFY/`), read only that path; cite files actually opened.
Never copy secrets.

## Typical local default (example only — still require explicit UNIWARE_ROOT)

Developers often use `/Users/bharamdev/Desktop/Uniware` — only when the human sets it in the prompt.
