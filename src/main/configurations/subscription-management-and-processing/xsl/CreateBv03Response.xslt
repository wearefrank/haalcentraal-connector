<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="referentienummer" />
   
	<xsl:template match="/">
        <StUF:Bv03Bericht>
            <StUF:stuurgegevens>
                <StUF:berichtcode>Bv03</StUF:berichtcode>
                <StUF:zender>
                    <StUF:organisatie><xsl:value-of select="$Stuurgegevens//stuurgegevens/ontvanger/organisatie"/></StUF:organisatie>
                    <StUF:applicatie><xsl:value-of select="$Stuurgegevens//stuurgegevens/ontvanger/applicatie"/></StUF:applicatie>
                </StUF:zender>
                <StUF:ontvanger>
                    <StUF:organisatie><xsl:value-of select="$Stuurgegevens//stuurgegevens/zender/organisatie"/></StUF:organisatie>
                    <StUF:applicatie><xsl:value-of select="$Stuurgegevens//stuurgegevens/zender/applicatie"/></StUF:applicatie>
                </StUF:ontvanger>
                <StUF:referentienummer><xsl:value-of select="$referentienummer"/></StUF:referentienummer>
                <StUF:tijdstipBericht>
                    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
                </StUF:tijdstipBericht>
                <StUF:crossRefnummer><xsl:value-of select="$Stuurgegevens//stuurgegevens/referentienummer"/></StUF:crossRefnummer>
            </StUF:stuurgegevens>
        </StUF:Bv03Bericht>
	</xsl:template>
</xsl:stylesheet>