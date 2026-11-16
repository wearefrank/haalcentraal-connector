<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <root>
            <type>RaadpleegMetBurgerservicenummer</type>
            <fields>burgerservicenummer</fields>
            <fields>overlijden.datum</fields>
            <xsl:for-each select="/partners/partnerBsn[normalize-space() != '']">
                <burgerservicenummer><xsl:value-of select="normalize-space()"/></burgerservicenummer>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>
