<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:local="http://frankframework.org/xpath-functions"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsl:param name="varZenderApplicatie"/>
    <xsl:variable name="geautoriseerd" select="document('authorizedApplicationsMap.xml')/root/inp.burgerlijkeStaat/@authorizedApplications"/>

    <xsl:function name="local:formatteer-datum" as="xsd:string">
        <xsl:param name="d" as="element()?"/>
        <xsl:choose>
            <xsl:when test="$d/type = 'Datum'">
                <xsl:sequence select="translate($d/datum, '-', '')"/>
            </xsl:when>
            <xsl:when test="$d/type = 'JaarMaandDatum'">
                <xsl:sequence select="concat(format-number(number($d/jaar), '0000'),
                                         format-number(number($d/maand), '00'), '00')"/>
            </xsl:when>
            <xsl:when test="$d/type = 'JaarDatum'">
                <xsl:sequence select="concat(format-number(number($d/jaar), '0000'), '0000')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="/">
        <xsl:variable name="persoon" select="root/personen"/>
        <partnerBsn>
            <xsl:if test="count($persoon) = 1
                          and contains($geautoriseerd, $varZenderApplicatie)
                          and not($persoon/partners[not(ontbindingHuwelijkPartnerschap/datum)])">
                <xsl:for-each select="$persoon/partners[ontbindingHuwelijkPartnerschap/datum]">
                    <xsl:sort select="local:formatteer-datum(ontbindingHuwelijkPartnerschap/datum)" order="descending"/>
                    <!-- Alleen opvragen als de verbintenis de burgerlijke staat bepaalt (H of P); bij een onbekende soort wordt het toch waardeOnbekend -->
                    <xsl:if test="position() = 1 and soortVerbintenis/code = ('H', 'P')"><xsl:value-of select="burgerservicenummer"/></xsl:if>
                </xsl:for-each>
            </xsl:if>
        </partnerBsn>
    </xsl:template>
</xsl:stylesheet>