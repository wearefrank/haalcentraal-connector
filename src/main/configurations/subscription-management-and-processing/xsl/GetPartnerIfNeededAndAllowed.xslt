<!-- Geeft de BSN's van de ontbonden partners terug waarvan de overlijdensdatum nodig is en de applicatie dat gegeven mag zien:
     - inp.burgerlijkeStaat: alleen de laatst ontbonden partner
     - redenOntbinding:      elke ontbonden partner met een BSN
     Resultaat: <partners><partnerBsn>..</partnerBsn>*</partners> (leeg als er niets opgevraagd hoeft te worden) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:local="http://frankframework.org/xpath-functions"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="BG local xsd">
    <xsl:param name="varZenderApplicatie"/>
    <xsl:variable name="authMap" select="document('authorizedApplicationsMap.xml')/root"/>
    <!-- Een callback heeft geen request-scope; het npsLk01-sjabloon bepaalt welke gegevens worden verstuurd -->
    <xsl:variable name="scope" select="(document('npsLk01.xml')//BG:object)[1]"/>

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

    <xsl:function name="local:geautoriseerd" as="xsd:boolean">
        <xsl:param name="entry" as="element()?"/>
        <xsl:sequence select="normalize-space($varZenderApplicatie) != ''
                              and (not(exists($entry/@authorizedApplications))
                                   or contains($entry/@authorizedApplications, $varZenderApplicatie))"/>
    </xsl:function>

    <xsl:template match="/">
        <xsl:variable name="persoon" select="root/personen"/>
        <xsl:variable name="isEnkelePersoon" select="count($persoon) = 1"/>
        <xsl:variable name="heeftActievePartner" select="exists($persoon/partners[not(ontbindingHuwelijkPartnerschap/datum)])"/>
        <!-- Dezelfde partner als local:laatste-ontbonden in mappingJsonToStuf.xslt -->
        <xsl:variable name="laatstOntbonden" as="element()?">
            <xsl:for-each select="$persoon/partners[ontbindingHuwelijkPartnerschap/datum]">
                <xsl:sort select="local:formatteer-datum(ontbindingHuwelijkPartnerschap/datum)" order="descending"/>
                <xsl:if test="position() = 1"><xsl:sequence select="."/></xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <!-- Burgerlijke staat 3/4 of 6/7 hangt af van het overlijden van de partner. Bij een actieve partner of een
             onbekende soort verbintenis (wordt waardeOnbekend) is dat niet nodig -->
        <xsl:variable name="burgerlijkeStaatGevraagd" select="exists($scope/BG:inp.burgerlijkeStaat)"/>
        <xsl:variable name="burgerlijkeStaatGeautoriseerd" select="local:geautoriseerd($authMap/inp.burgerlijkeStaat)"/>
        <xsl:variable name="burgerlijkeStaatNodig" select="$burgerlijkeStaatGevraagd
                                                           and $burgerlijkeStaatGeautoriseerd
                                                           and not($heeftActievePartner)
                                                           and $laatstOntbonden/soortVerbintenis/code = ('H', 'P')"/>

        <!-- redenOntbinding (O of S) van elke ontbonden partner hangt af van het overlijden van die partner -->
        <xsl:variable name="redenOntbindingGevraagd" select="exists($scope/BG:inp.heeftAlsEchtgenootPartner/BG:redenOntbinding)"/>
        <xsl:variable name="redenOntbindingGeautoriseerd" select="local:geautoriseerd($authMap/inp.heeftAlsEchtgenootPartner/redenOntbinding)"/>
        <xsl:variable name="redenOntbindingNodig" select="$redenOntbindingGevraagd and $redenOntbindingGeautoriseerd"/>

        <xsl:variable name="teBevragen" as="element()*">
            <xsl:choose>
                <xsl:when test="not($isEnkelePersoon)"/>
                <xsl:when test="$redenOntbindingNodig">
                    <xsl:sequence select="$persoon/partners[ontbindingHuwelijkPartnerschap/datum]"/>
                </xsl:when>
                <xsl:when test="$burgerlijkeStaatNodig">
                    <xsl:sequence select="$laatstOntbonden"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <!-- Dubbele BSN's eruit (zelfde partner twee keer getrouwd) -->
        <xsl:variable name="bsns" select="distinct-values($teBevragen/burgerservicenummer[normalize-space()])"/>

        <!-- RaadpleegMetBurgerservicenummer accepteert max. 20 BSN's. Zijn het er meer, dan gaat de laatst ontbonden partner
             voor (nodig voor burgerlijkeStaat); de rest krijgt redenOntbinding waardeOnbekend omdat ze niet gevonden worden -->
        <partners>
            <xsl:for-each select="if (count($bsns) le 20) then $bsns
                                  else subsequence(distinct-values(($laatstOntbonden/burgerservicenummer, $bsns)), 1, 20)">
                <partnerBsn><xsl:value-of select="."/></partnerBsn>
            </xsl:for-each>
        </partners>
    </xsl:template>
</xsl:stylesheet>
