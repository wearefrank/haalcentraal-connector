<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
    xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
    xmlns:ax25="http://objecten.zoekpersoon.diensten.procura.nl/xsd"
    xmlns:ns0="http://zoekpersoonws.ws.procura.nl/xsd"
    xmlns:ns1="http://objecten.zoekpersoon.diensten.procura.nl/xsd"
    xmlns:str="http://exslt.org/strings"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    
    <!-- Template to match the root element and replace it -->
    <xsl:template match="BG:npsLa01">
        <BG:Lk01>
            <!-- Copy all child elements of the old root -->
            <xsl:apply-templates select="node()|@*" />
        </BG:Lk01>
    </xsl:template>
    
    <!-- Template to match <StUF:berichtcode> and update its value -->
    <xsl:template match="StUF:berichtcode">
        <xsl:copy>
            <xsl:text>Lk01</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <!-- Identity template to copy other nodes unchanged -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>