<scraper name="{{INVENTORY_UPDATE_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Push inventory. Supports sync batch OR async submit+poll. Fill from ticket. -->

    <method name="markFailed">
        <var name="error" value="#{new com.uniware.core.script.error.ChannelScriptError('CHANNEL_ERROR', #errorMessage)}" />
        <var value="#{#failedInventorySnapshots.put(#channelProductId, #error)}" />
    </method>

    <!-- PATTERN A: sync single POST (Trendyol-like) -->
    <!-- PATTERN B: async — POST update → receive transactionId → POST status → map per-SKU SUCCESS/IMPORT_ERROR -->

    <method name="pushBatchAsync">
        <!-- Build priceAndStockUpdates from #inventorySnapshot: offerSku, price, quantity -->
        <!-- Max {{MAX_SKU_PER_REQUEST}} per request; split loops as needed -->
        <http method="POST" url="#{#inventoryHost}{{INVENTORY_UPDATE_PATH}}" var="submitRes" timeout="40" fetchStatusCode="true">
            <headers map="#{#authHeaders}" />
            <body>#{#requestBody}</body>
        </http>
        <!-- Extract transactionId; poll {{INVENTORY_STATUS_PATH}}; per IMPORT_ERROR call markFailed -->
    </method>

    <method name="main">
        <invoke method="buildBearerHeaders" script="{{UTILS_SCRIPT_NAME}}" />
        <invoke method="pushBatchAsync" />
    </method>
    <invoke method="main" />
</scraper>
