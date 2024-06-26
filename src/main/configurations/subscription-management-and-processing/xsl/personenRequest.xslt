<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Template to match the root element of the input XML -->
    <xsl:template match="/root">
        <root>
            <type>RaadpleegMetBurgerservicenummer</type>

            <fields>burgerservicenummer</fields>
            <fields>aNummer</fields>
            <fields>adressering</fields>
            <fields>datumInschrijvingInGemeente</fields>
            <fields>geboorte</fields>
            <fields>gemeenteVanInschrijving</fields>
            <fields>geslacht</fields>
            <fields>leeftijd</fields>
            <fields>naam</fields>
            <fields>nationaliteiten</fields>
            <fields>overlijden</fields>
            <fields>verblijfplaats</fields>
            <fields>verblijfplaatsBinnenland</fields>
            <fields>adresseringBinnenland</fields>
            <xsl:copy-of select="burgerservicenummer"/>
        </root>
    </xsl:template>
    
</xsl:stylesheet>
