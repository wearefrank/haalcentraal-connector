<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310"
version="2.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="errorReason" select="''" as="xs:string" />
    <xsl:param name="errorCode" select="''" as="xs:string" />
    <xsl:param name="errorDetailText" select="''" as="xs:string" />
    <xsl:param name="errorDetailXML" as="node()?" />
    <xsl:param name="referentienummer" />

    <xsl:template match="/">
        <StUF:Fo03Bericht>
            <StUF:stuurgegevens>
                <StUF:berichtcode>Fo03</StUF:berichtcode>

                <StUF:zender>
                    <StUF:organisatie>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='ontvanger']/*[local-name()='organisatie']"/>
                    </StUF:organisatie>
                    <StUF:applicatie>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='ontvanger']/*[local-name()='applicatie']"/>
                    </StUF:applicatie>
                </StUF:zender>

                <StUF:ontvanger>
                    <StUF:organisatie>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='zender']/*[local-name()='organisatie']"/>
                    </StUF:organisatie>
                    <StUF:applicatie>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='zender']/*[local-name()='applicatie']"/>
                    </StUF:applicatie>
                    <StUF:administratie>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='zender']/*[local-name()='administratie']"/>
                    </StUF:administratie>
                    <StUF:gebruiker>
                        <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='zender']/*[local-name()='gebruiker']"/>
                    </StUF:gebruiker>
                </StUF:ontvanger>

                <StUF:referentienummer>
                    <xsl:value-of select="$referentienummer"/>
                </StUF:referentienummer>

                <StUF:tijdstipBericht>
                    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
                </StUF:tijdstipBericht>

                <StUF:crossRefnummer>
                    <xsl:value-of select="$Stuurgegevens//*[local-name()='stuurgegevens']/*[local-name()='referentienummer']"/>
                </StUF:crossRefnummer>

            </StUF:stuurgegevens>

            <StUF:body>
                <StUF:code>
                    <xsl:value-of select="$errorCode"/>
                </StUF:code>
                <StUF:plek>server</StUF:plek>
                <StUF:omschrijving>
                    <xsl:value-of select="$errorReason"/>
                </StUF:omschrijving>
                <StUF:details>
                    <xsl:value-of select="$errorDetailText"/>
                </StUF:details>
                <StUF:detailsXML>
                    <xsl:copy-of select="$errorDetailXML"/>
                </StUF:detailsXML>
            </StUF:body>

        </StUF:Fo03Bericht>
    </xsl:template>
</xsl:stylesheet>