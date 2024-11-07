<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="newSubscriptions">
        <csv>
            <record>
                <app_id>1</app_id>
                <bsn>1</bsn>
            </record>
            <record>
                <app_id>4</app_id>
                <bsn>4</bsn>
            </record>
            <record>
                <app_id>6</app_id>
                <bsn>6</bsn>
            </record>
            <record>
                <app_id>2</app_id>
                <bsn>2</bsn>
            </record>
            <record>
                <app_id>7</app_id>
                <bsn>7</bsn>
            </record>
        </csv>
    </xsl:param>
    <xsl:param name="personErrors">
        <root>
            <failure>
                <record>
                    <bsn>3</bsn>
                </record>
                <record>
                    <bsn>4</bsn>
                </record>
                <record>
                    <bsn>6</bsn>
                </record>
            </failure>
        </root>
    </xsl:param>

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
            <xsl:for-each select="$newSubscriptions/csv/record">
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
            <toBekept>
                <xsl:copy-of select="$currentSubscriptionKeys/pair[key/text() = $newSubscriptionPairs/pair/key/text()]/record"/>
            </toBekept>
            <toBeAdded>
                <xsl:copy-of select="$newSubscriptionPairs/pair[not(
                    key/text() = $currentSubscriptionKeys/pair/key/text()
                    or
                    record/bsn/text() = $personErrors/root/failure/record/bsn/text()
                )]/record"/>
            </toBeAdded>
            <toNotBeAdded>
                <xsl:copy-of select="$newSubscriptionPairs/pair[
                    not(key/text() = $currentSubscriptionKeys/pair/key/text())
                    and
                    record/bsn/text() = $personErrors/root/failure/record/bsn/text()
                ]/record"/>
            </toNotBeAdded>
        </root>
    </xsl:template>
</xsl:stylesheet>