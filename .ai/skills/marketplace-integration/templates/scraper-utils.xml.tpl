<scraper name="{{UTILS_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Shared helpers: auth headers, dual-host URLs, token exchange. Placeholder-only. -->

    <method name="getHosts">
        <var name="inventoryHost" value="{{INVENTORY_OR_AUTH_BASE_URL}}" />
        <var name="orderStatusHost" value="{{ORDER_STATUS_BASE_URL}}" />
        <var value="#{#hostsOut.put('inventoryHost', #inventoryHost)}" />
        <var value="#{#hostsOut.put('orderStatusHost', #orderStatusHost)}" />
    </method>

    <!-- OPTION: rotating-refresh-token (serialize callers externally / via lock if available) -->
    <method name="exchangeRefreshToken">
        <var name="requestBody"><![CDATA[{"refreshToken":"#{#refreshToken}"}]]></var>
        <http method="POST" url="#{#inventoryHost}{{ACCESS_TOKEN_PATH}}" var="tokenRes" timeout="40" fetchStatusCode="true">
            <header name="Content-Type" value="application/json" />
            <header name="User-Agent" value="{{MANDATORY_USER_AGENT}}" />
            <header name="accept" value="*/*" />
            <body>#{#requestBody}</body>
        </http>
        <!-- Parse accessToken + rotated refreshToken into #tokenOut; on failure scriptError -->
    </method>

    <method name="buildBearerHeaders">
        <var value="#{#headersOut.put('Authorization', 'Bearer ' + #accessToken)}" />
        <var value="#{#headersOut.put('Content-Type', 'application/json')}" />
        <var value="#{#headersOut.put('User-Agent', '{{MANDATORY_USER_AGENT}}')}" />
        <var value="#{#headersOut.put('accept', '*/*')}" />
    </method>
</scraper>
