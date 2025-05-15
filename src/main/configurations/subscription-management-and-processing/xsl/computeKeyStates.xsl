<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="incomingRecords"/>

    <xsl:template match="/">
        <xsl:variable name="currentPairs">
            <xsl:for-each select="result/rowset/row">
                <pair>
                    <key><xsl:value-of select="concat(field[@name='IDENTIFIER'],field[@name='ID'])"/></key>
                    <record>
                        <identifier><xsl:value-of select="field[@name='IDENTIFIER']"/></identifier>
                        <key><xsl:value-of select="field[@name='ID']"/></key>
                    </record>
                </pair>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="incomingPairs">
            <xsl:for-each select="$incomingRecords/csv/record">
                <pair>
                    <key><xsl:value-of select="concat(ID,Identificatie)"/></key>
                    <record>
                        <identifier><xsl:value-of select="Identificatie"/></identifier>
                        <key><xsl:value-of select="ID"/></key>
                    </record>
                </pair>
            </xsl:for-each>
        </xsl:variable>

        <root>
            <toBeEnded>
                <xsl:copy-of select="$currentPairs/pair[not(key/text() = $incomingPairs/pair/key/text())]/record"/>
            </toBeEnded>
            <toBeAdded>
                <xsl:copy-of select="$incomingPairs/pair[not(
                    key/text() = $currentPairs/pair/key/text()
                )]/record"/>
            </toBeAdded>
        </root>
    </xsl:template>
</xsl:stylesheet>