<scraper name="{{STATUS_SYNC_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Poll channel for status; emit SaleOrderItem StatusCode. Optional if webhook handles inbound. -->

    <var name="channelToUcStatus" value="#{new java.util.HashMap()}" />
    <!-- #{#channelToUcStatus.put('CHANNEL_STATUS','UC_STATUS')} — only ticket-confirmed rows -->

    <startTag name="SaleOrder" />
    <startTag name="SaleOrderItems" />
    <!-- Emit SaleOrderItem Code + StatusCode; reconcile don't blind-apply if ticket requires -->
    <endTag name="SaleOrderItems" />
    <endTag name="SaleOrder" />
</scraper>
