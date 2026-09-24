<scraper name="{{WEBHOOK_CONFIG_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd" cachehttpclient="false">
    <!-- OPTIONAL: Outbound webhook *registration* with marketplace/proxy (Shopify-like). -->
    <!-- Do not generate for Carrefour-style inbound-only callbacks unless ticket requires registration API. -->

    <method name="configureEvents">
        <http method="PUT" url="#{#serviceBaseUrl}/connectors/events/configure" var="configureRes" timeout="180" fetchStatusCode="true">
            <headers map="#{#serviceRequestHeaders}" />
            <body>#{#stringifyWebhookConfigureRequest}</body>
        </http>
    </method>
</scraper>
