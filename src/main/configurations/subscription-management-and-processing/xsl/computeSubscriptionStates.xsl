<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="incomingSubscriptions"/>

    <xsl:template match="/">
        <xsl:variable name="currentSubscriptions"><xsl:copy-of select="."/></xsl:variable>
        <xsl:variable name="currentSubscriptionPairs">
            <xsl:for-each select="result/rowset/row">
                <pair>
                    <key><xsl:value-of select="concat(field[2],field[3])"/></key>
                    <record>
                        <app_id><xsl:value-of select="field[2]"/></app_id>
                        <bsn><xsl:value-of select="field[3]"/></bsn>
                    </record>
                </pair>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="incomingSubscriptionPairs">
            <xsl:for-each select="$incomingSubscriptions/csv/record">
                <pair>
                    <key><xsl:value-of select="concat(APPLICATIE,INP_BSN)"/></key>
                    <record>
                        <app_id><xsl:value-of select="APPLICATIE"/></app_id>
                        <bsn><xsl:value-of select="INP_BSN"/></bsn>
                    </record>
                </pair>
            </xsl:for-each>
        </xsl:variable>

        <root>
            <toBeEnded>
                <xsl:copy-of select="$currentSubscriptionPairs/pair[not(key/text() = $incomingSubscriptionPairs/pair/key/text())]/record"/>
            </toBeEnded>
            <alreadyExists>
                <xsl:copy-of select="$currentSubscriptionPairs/pair[key/text() = $incomingSubscriptionPairs/pair/key/text()]/record"/>
            </alreadyExists>
            <toBeAdded>
                <xsl:copy-of select="$incomingSubscriptionPairs/pair[not(
                    key/text() = $currentSubscriptionPairs/pair/key/text()
                )]/record"/>
            </toBeAdded>
        </root>
    </xsl:template>
</xsl:stylesheet>