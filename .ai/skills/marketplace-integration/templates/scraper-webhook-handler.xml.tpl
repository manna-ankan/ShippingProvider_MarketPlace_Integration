<scraper name="{{WEBHOOK_HANDLER_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd" cachehttpclient="false">
    <!-- Inbound UniwareWebhook: raw body in #__data. Create/reconcile sale orders. -->
    <!-- NOT Shopify outbound registration — that is scraper-webhook-config.xml.tpl -->

    <var name="payloadJson" value="#{T(com.unifier.core.utils.JsonUtils).stringToJson(#__data)}" />
    <!-- OR payload is already string; parse carefully with try/catch -->

    <method name="shouldSkip">
        <!-- e.g. skip fulfilmentMode != SELF_FULFILMENT -->
    </method>

    <method name="createOrReconcile">
        <!-- Map ticket fields → CreateSaleOrderRequest OR reconcile status against current UC state -->
        <!-- Idempotent: repeated events must not duplicate transitions -->
        <!-- Billing from shipping when ticket says billing absent -->
        <!-- Facility from connector defaultFacility -->
    </method>

    <method name="main">
        <invoke method="shouldSkip" />
        <invoke method="createOrReconcile" />
    </method>
    <invoke method="main" />
</scraper>
