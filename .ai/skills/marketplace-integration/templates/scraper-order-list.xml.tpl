<scraper name="{{ORDER_LIST_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Polling order list. Omit when webhook-only AND order sync OFF (human-approved). -->

    <method name="fetchPage">
        <http method="GET" url="{{ORDER_LIST_URL_WITH_PARAMS}}" var="listRes" timeout="160" fetchStatusCode="true">
            <headers map="#{#authHeaders}" />
        </http>
    </method>

    <startTag name="SaleOrders" />
    <!-- For each order: <valueTag name="SaleOrder" value="#{#orderCode}" /> and #resultItems.put -->
    <!-- Optional: <valueTag name="TotalPages" value="#{#totalPages}" /> -->
    <endTag name="SaleOrders" />
</scraper>
