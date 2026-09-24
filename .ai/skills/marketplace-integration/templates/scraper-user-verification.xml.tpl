<scraper name="{{VERIFICATION_SCRIPT_NAME}}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.unicommerce.com/schema/scraper-1.0.xsd" cachehttpclient="false">
    <!-- Exchange credentials / refresh token; persist via PersistentParams. -->

    <if condition="#{T(com.unifier.core.utils.StringUtils).isBlank(#refreshToken)}">
        <scriptError message="Refresh token is required. Generate it in the seller portal and paste it here." />
    </if>

    <invoke method="exchangeRefreshToken" script="{{UTILS_SCRIPT_NAME}}">
        <param name="refreshToken" value="#{#refreshToken}" />
        <param name="tokenOut" value="#{#tokenOut}" />
    </invoke>

    <!-- OPTIONAL: decode JWT / response for shopId + country display -->

    <startTag name="ConnectorParams" />
    <startTag name="PersistentParams" />
    <valueTag name="Name" value="refreshToken" />
    <valueTag name="Value" value="#{#tokenOut.get('refreshToken')}" />
    <endTag name="PersistentParams" />
    <startTag name="PersistentParams" />
    <valueTag name="Name" value="accessToken" />
    <valueTag name="Value" value="#{#tokenOut.get('accessToken')}" />
    <endTag name="PersistentParams" />
    <!-- OPTIONAL PersistentParams: shopId, country, accessTokenExpiresIn -->
    <endTag name="ConnectorParams" />
</scraper>
