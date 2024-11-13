<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="addSubscriptionsResult" />

    <xsl:template match="/">
        <xsl:variable name="originalMessage" select="."/>
        <root>
            <subscriptionsHadError>
                <personError>
                    <xsl:copy-of select="root/toNotBeAdded/*"/>
                </personError>
                <insertError>
                    <xsl:for-each select="$addSubscriptionsResult/results/result/result/rowset/row">
                        <xsl:if test="not(rowsupdated[text()='1'])">
                            <xsl:variable name="position" select="position()"/>
                            <xsl:copy-of select="$originalMessage/root/toBeAdded/record[$position]"/>
                        </xsl:if>
                    </xsl:for-each>
                </insertError>
            </subscriptionsHadError>
            <subscriptionsAdded>
                <!--copy all records from toBeAdded if the insert was successful-->
                <xsl:for-each select="$addSubscriptionsResult/results/result/result">
                    <xsl:if test="rowsupdated[text()='1']">
                        <xsl:variable name="position" select="position()"/>
                        <xsl:copy-of select="$originalMessage/root/toBeAdded/record[$position]"/>
                    </xsl:if>
                </xsl:for-each>
            </subscriptionsAdded>
            <subscriptionsRemoved>
                <xsl:copy-of select="root/toBeRemoved/*"/>
            </subscriptionsRemoved>
        </root>
    </xsl:template>
</xsl:stylesheet>