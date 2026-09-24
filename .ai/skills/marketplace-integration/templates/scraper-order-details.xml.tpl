<scraper name="{{ORDER_DETAILS_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Map channel order JSON → CreateSaleOrderRequest XML. -->

    <startTag name="CreateSaleOrderRequest">
        <attribute name="xmlns" value="http://uniware.unicommerce.com/services/" />
    </startTag>
    <startTag name="SaleOrder" />
    <valueTag name="Code" value="{{ORDER_CODE_EXPR}}" cdata="true" />
    <valueTag name="DisplayOrderCode" value="{{DISPLAY_ORDER_CODE_EXPR}}" cdata="true" />
    <!-- Addresses, SaleOrderItems — fill from ticket field mapping only -->
    <endTag name="SaleOrder" />
    <endTag name="CreateSaleOrderRequest" />
</scraper>
