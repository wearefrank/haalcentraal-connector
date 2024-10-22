<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:param name="subscribedAppids" as="node()?" />
    <!-- Match the root element and copy it -->
    <xsl:template match="/root">
        <xsl:copy>
            <!-- Apply the template to filter applications -->
            <xsl:apply-templates select="Applications"/>
        </xsl:copy>
    </xsl:template>

    <!-- Match the Applications element -->
    <xsl:template match="Applications">
        <!-- Check if the appId exists in result/rowset/row/field[@name='APP_ID'] -->
        <xsl:variable name="appId" select="appId" />
        <xsl:if test="$subscribedAppids/result/rowset/row/field[@name='APP_ID' and text()=$appId]">
            <!-- Copy the Applications element if the condition is true -->
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
