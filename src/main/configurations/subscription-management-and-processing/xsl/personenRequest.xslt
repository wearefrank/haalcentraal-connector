<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310">
    
    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="burgerservicenummer"/>
    
    <!-- Template to match the root element of the input XML -->
    <xsl:template match="/">
        <root>
            <type>RaadpleegMetBurgerservicenummer</type>

            <fields>aNummer</fields>
            <fields>adressering</fields>
            <fields>burgerservicenummer</fields>
            <fields>datumEersteInschrijvingGBA</fields>
            <fields>datumInschrijvingInGemeente</fields>
            <fields>europeesKiesrecht</fields>
            <fields>geboorte</fields>
            <fields>gemeenteVanInschrijving</fields>
            <fields>geslacht</fields>
            <fields>gezag</fields>
            <fields>immigratie</fields>
            <fields>indicatieCurateleRegister</fields>
            <fields>kinderen</fields>
            <fields>leeftijd</fields>
            <fields>naam</fields>
            <fields>nationaliteiten</fields>
            <fields>ouders</fields>
            <fields>overlijden</fields>
            <fields>partners</fields>
            <fields>uitsluitingKiesrecht</fields>
            <fields>verblijfplaats</fields>
            <fields>verblijfstitel</fields>
            <fields>verblijfplaatsBinnenland</fields>
            <fields>adresseringBinnenland</fields>

            <burgerservicenummer><xsl:value-of select="$burgerservicenummer"/></burgerservicenummer>
        </root>
    </xsl:template>
    
</xsl:stylesheet>
