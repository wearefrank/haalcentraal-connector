<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:template match="/"><Root>
            <Record>
                <berichtcode>
                    <xsl:value-of select="//BG:stuurgegevens/StUF:berichtcode" />
                </berichtcode>
                <varZenderApplicatie>
                    <xsl:value-of select="//StUF:zender/StUF:applicatie" />
                </varZenderApplicatie>
                <varZenderOrganisatie>
                    <xsl:value-of select="//StUF:zender/StUF:organisatie" />
                </varZenderOrganisatie>
                <varOntvangerApplicatie>
                    <xsl:value-of select="//StUF:ontvanger/StUF:applicatie" />
                </varOntvangerApplicatie>
                <varOntvangerOrganisatie>
                    <xsl:value-of select="//StUF:ontvanger/StUF:organisatie" />
                </varOntvangerOrganisatie>
                <varZenderGebruiker>
                    <xsl:value-of select="//StUF:zender/StUF:gebruiker" />
                </varZenderGebruiker>
                <varReferentienummer>
                    <xsl:value-of select="//BG:stuurgegevens/StUF:referentienummer" />
                </varReferentienummer>
                <varEntiteittype>
                    <xsl:value-of select="//StUF:entiteittype" />
                </varEntiteittype>
                <indicatorVervolgvraag>
                    <xsl:value-of select="//BG:parameters/StUF:indicatorVervolgvraag" />
                </indicatorVervolgvraag>
            </Record>
        </Root></xsl:template>
</xsl:stylesheet>