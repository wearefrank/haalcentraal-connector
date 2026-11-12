<!-- Geeft het BSN van de laatst ontbonden partner terug als de overlijdensdatum van die partner nodig is
     (voor inp.burgerlijkeStaat of redenOntbinding in de callback) en de applicatie dat gegeven mag zien; anders een lege partnerBsn -->
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
        <xsl:variable name="partnerBsn" select="string($laatstOntbonden/burgerservicenummer)"/>

        <!-- Burgerlijke staat 3/4 of 6/7 hangt af van het overlijden van de partner. Bij een actieve partner of een
             onbekende soort verbintenis (wordt waardeOnbekend) is dat niet nodig -->
        <xsl:variable name="burgerlijkeStaatGevraagd" select="exists($scope/BG:inp.burgerlijkeStaat)"/>
        <xsl:variable name="burgerlijkeStaatGeautoriseerd" select="local:geautoriseerd($authMap/inp.burgerlijkeStaat)"/>
        <xsl:variable name="burgerlijkeStaatNodig" select="$burgerlijkeStaatGevraagd
                                                           and $burgerlijkeStaatGeautoriseerd
                                                           and not($heeftActievePartner)
                                                           and $laatstOntbonden/soortVerbintenis/code = ('H', 'P')"/>

        <!-- redenOntbinding (O of S) van de laatst ontbonden partner hangt af van het overlijden van die partner -->
        <xsl:variable name="redenOntbindingGevraagd" select="exists($scope/BG:inp.heeftAlsEchtgenootPartner/BG:redenOntbinding)"/>
        <xsl:variable name="redenOntbindingGeautoriseerd" select="local:geautoriseerd($authMap/inp.heeftAlsEchtgenootPartner/redenOntbinding)"/>
        <xsl:variable name="redenOntbindingNodig" select="$redenOntbindingGevraagd and $redenOntbindingGeautoriseerd"/>

        <partnerBsn>
            <xsl:if test="$isEnkelePersoon and $partnerBsn != '' and ($burgerlijkeStaatNodig or $redenOntbindingNodig)">
                <xsl:value-of select="$partnerBsn"/>
            </xsl:if>
        </partnerBsn>
    </xsl:template>
</xsl:stylesheet>
