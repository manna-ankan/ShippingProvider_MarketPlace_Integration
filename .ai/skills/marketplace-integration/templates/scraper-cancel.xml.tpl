<scraper name="{{CANCEL_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd">
    <!-- Cancel on channel when UC cancels — only if ticket has cancel API. -->
    <http method="{{HTTP_METHOD}}" url="{{CANCEL_URL}}" var="cancelRes" timeout="40" fetchStatusCode="true">
        <headers map="#{#authHeaders}" />
        <body>#{#requestBody}</body>
    </http>
</scraper>
