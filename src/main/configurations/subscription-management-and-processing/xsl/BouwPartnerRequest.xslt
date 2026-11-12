<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsl:template match="/">
        <root>
            <type>RaadpleegMetBurgerservicenummer</type>
            <fields>burgerservicenummer</fields>
            <fields>overlijden.datum</fields>
            <burgerservicenummer><xsl:value-of select="normalize-space(/partnerBsn)"/></burgerservicenummer>
        </root>
    </xsl:template>
</xsl:stylesheet>