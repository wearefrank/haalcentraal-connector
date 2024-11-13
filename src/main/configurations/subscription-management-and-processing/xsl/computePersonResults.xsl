<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="newSubscriptions" />

    <xsl:template match="/">
        <root>
            <failure>
                <xsl:for-each select="result/rowset/row">
                    <xsl:if test="not(text() = ('true', 'false'))">
                        <xsl:copy-of select="$newSubscriptions/csv/record[current()/position()]"/>
                    </xsl:if>
                </xsl:for-each>
            </failure>
        </root>
    </xsl:template>
</xsl:stylesheet>