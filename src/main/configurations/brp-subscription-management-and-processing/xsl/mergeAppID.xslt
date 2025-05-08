<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Declare the parameters 'sleutelVerzendend', 'code', 'appid', and 'verwerkingsoort' -->
    <xsl:param name="sleutelVerzendend"/>
    <xsl:param name="code"/>
    <xsl:param name="appid"/>
    <xsl:param name="verwerkingssoort"/>

    <xsl:template match="/">
        <Applications>
            <xsl:choose>
                <!-- Handle processing when verwerkingsoort = 'T' -->
                <xsl:when test="$verwerkingssoort = 'T'">
                    <!-- Output appid elements from the parameter -->
                    <xsl:if test="count($appid/root)">
                        <xsl:for-each select="$appid/root/appid">
                            <appid>
                                <xsl:value-of select="."/>
                            </appid>
                        </xsl:for-each>
                    </xsl:if>
                    <!-- Output appId elements based on conditions -->
                    <xsl:apply-templates select="root/Applications[identifier = $code and sleutelVerzendend = $sleutelVerzendend]/appId" />
                </xsl:when>
                <!-- Handle processing when verwerkingsoort = 'V' -->
                <xsl:otherwise>
                    <xsl:variable name="input" select="/"/>
                    <xsl:if test="count($appid/root)">
                        <xsl:for-each select="$appid/root/appid">
                            <!-- Check if the current item is not in the list of appId elements under the specified conditions -->
                            <xsl:if test="not($input/root/Applications[identifier = $code and sleutelVerzendend = $sleutelVerzendend]/appId = .)">
                                <appid>
                                    <xsl:value-of select="."/>
                                </appid>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </Applications>
    </xsl:template>

    <!-- Template for the 'appId' elements for 'T' verwerkingsoort -->
    <xsl:template match="appId">
        <xsl:if test="not(. = $appid/root/appid)">
            <appid>
                <xsl:value-of select="." />
            </appid>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
