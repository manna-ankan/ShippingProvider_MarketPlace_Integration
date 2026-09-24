<scraper name="{{NOTIFICATION_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd" cachehttpclient="false">
    <!-- Outbound status push on channel notifications (PACK/SHIP/DELIVER/…). -->

    <method name="pushStatus">
        <!-- endpointSuffix: PACK | SHIP | DELIVER | DELIVER_FAILED -->
        <http method="POST" url="#{#orderStatusHost}{{ORDER_STATUS_BASE_PATH}}/#{#endpointSuffix}" var="statusRes" timeout="40" fetchStatusCode="true">
            <headers map="#{#authHeaders}" />
            <body>#{#requestBody}</body>
        </http>
        <!-- On failure add to #failedNotifications; on success #successfulNotifications -->
    </method>

    <method name="main">
        <invoke method="buildBearerHeaders" script="{{UTILS_SCRIPT_NAME}}" />
        <!-- Map #notifications entities/newValues → endpoint + body per ticket field table -->
        <!-- Line rules e.g. acceptanceState ACCEPT|REFUSED; shippedQty = original qty -->
    </method>
    <invoke method="main" />
</scraper>
