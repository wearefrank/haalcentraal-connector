<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="incomingSubscriptions"/>

    <xsl:template match="/">
        <xsl:variable name="currentSubscriptions"><xsl:copy-of select="."/></xsl:variable>
        <xsl:variable name="currentSubscriptionKeys">
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
        <xsl:variable name="newSubscriptionPairs">
            <xsl:for-each select="$incomingSubscriptions/csv/record">
                <pair>
                    <key><xsl:value-of select="concat(APPLICATION,INP_BSN)"/></key>
                    <record>
                        <app_id><xsl:value-of select="APPLICATION"/></app_id>
                        <bsn><xsl:value-of select="INP_BSN"/></bsn>
                    </record>
                </pair>
            </xsl:for-each>
        </xsl:variable>

        <root>
            <toBeRemoved>
                <xsl:copy-of select="$currentSubscriptionKeys/pair[not(key/text() = $newSubscriptionPairs/pair/key/text())]/record"/>
            </toBeRemoved>
            <alreadyExists>
                <xsl:copy-of select="$currentSubscriptionKeys/pair[key/text() = $newSubscriptionPairs/pair/key/text()]/record"/>
            </alreadyExists>
            <toBeAdded>
                <xsl:copy-of select="$newSubscriptionPairs/pair[not(
                    key/text() = $currentSubscriptionKeys/pair/key/text()
                )]/record"/>
            </toBeAdded>
        </root>
    </xsl:template>
</xsl:stylesheet>