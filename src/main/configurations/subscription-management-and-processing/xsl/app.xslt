<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!-- Parameter for appIds -->
    <xsl:param name="appIds" as="node()?" />

    <xsl:template match="/">
        <root>
            <!-- Loop through each Applications node -->
            <xsl:for-each select="/root/Applications">
                <xsl:variable name="currentAppId" select="./appId"/>

                <!-- Check if currentAppId matches any appId in $appIds -->
                <xsl:if test="$appIds/root/appId = $currentAppId">
                    <!-- Output the URL of the matching Applications -->
                    <app>
                        <url><xsl:value-of select="./url"/></url>
                        <organisatie><xsl:value-of select="./organisatie"/></organisatie>
                        <applicatie><xsl:value-of select="./applicatie"/></applicatie>
                        <gebruiker><xsl:value-of select="./gebruiker"/></gebruiker>
                        <referentienummer><xsl:value-of select="./referentienummer"/></referentienummer>
                    </app>
                </xsl:if>
            </xsl:for-each>
        </root>
    </xsl:template>
</xsl:stylesheet>
