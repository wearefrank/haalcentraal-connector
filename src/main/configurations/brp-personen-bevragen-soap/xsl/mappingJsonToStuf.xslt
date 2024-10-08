<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
    xmlns:str="http://exslt.org/strings"
    xmlns:w="http://schemas.xmlsoap.org/wsdl/"
>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="berichtcode" />
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="varZenderOrganisatie" />
    <xsl:param name="varZenderGebruiker" />
    <xsl:param name="varReferentienummer" />
    <xsl:param name="varOntvangerApplicatie" />
    <xsl:param name="varOntvangerOrganisatie" />
    <xsl:param name="varEntiteittype" />
    <xsl:param name="indicatorVervolgvraag" />
    <xsl:param name="originalMessage" as="node()?" />
    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>


    <xsl:template match="/">
        <BG:npsLa01>
            <BG:stuurgegevens>
                <StUF:berichtcode>
                    <xsl:value-of select="&apos;La01&apos;" />
                </StUF:berichtcode>
                <StUF:zender>
                    <StUF:organisatie>
                        <xsl:value-of select="$varOntvangerOrganisatie" />
                    </StUF:organisatie>
                    <StUF:applicatie>
                        <xsl:value-of select="$varOntvangerApplicatie" />
                    </StUF:applicatie>
                </StUF:zender>
                <StUF:ontvanger>
                    <StUF:organisatie>
                        <xsl:value-of select="$varZenderOrganisatie" />
                    </StUF:organisatie>
                    <StUF:applicatie>
                        <xsl:value-of select="$varZenderApplicatie" />
                    </StUF:applicatie>
                    <StUF:gebruiker>
                        <xsl:value-of select="$varZenderGebruiker" />
                    </StUF:gebruiker>
                </StUF:ontvanger>
                <StUF:crossRefnummer>
                    <xsl:value-of select="$varReferentienummer" />
                </StUF:crossRefnummer>
                <StUF:entiteittype>
                    <xsl:value-of select="$varEntiteittype" />
                </StUF:entiteittype>
            </BG:stuurgegevens>
            <BG:parameters>
                <StUF:indicatorVervolgvraag>
                    <xsl:value-of select="$indicatorVervolgvraag" />
                </StUF:indicatorVervolgvraag>
                <StUF:aantalVoorkomens>
                    <xsl:value-of select="count(/root/personen)" />
                </StUF:aantalVoorkomens>
            </BG:parameters>
            <xsl:if test="count(/root/personen)=0">
                <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
            </xsl:if>
            <BG:antwoord>
                <xsl:for-each
                    select="/root/personen">
                    <BG:object>
                        <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                select="$varEntiteittype" />
                        </xsl:attribute>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.bsn)">
                            <BG:inp.bsn>
                                <xsl:choose>
                                    <xsl:when test="./burgerservicenummer/text() !=''">
                                        <xsl:value-of select="./burgerservicenummer" />
                                    </xsl:when>
                                    <xsl:when test="./burgerservicenummer/text() =''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.bsn>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.typering)">
                            <BG:sub.typering>
                                <xsl:choose>
                                    <xsl:when test="./sub.typering/text() != ''">
                                        <xsl:value-of select="./sub.typering" />
                                    </xsl:when>
                                    <xsl:when test="./sub.typering/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.typering/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.typering/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:sub.typering>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.a-nummer)">
                            <BG:inp.a-nummer>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="./aNummer/text() != ''">
                                                <xsl:value-of select="./aNummer" />
                                            </xsl:when>
                                            <xsl:when test="./aNummer/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.a-nummer>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaam)">
                            <BG:geslachtsnaam>
                                <xsl:choose>
                                    <xsl:when test="./naam/geslachtsnaam/text() != ''">
                                        <xsl:value-of select="./naam/geslachtsnaam" />
                                    </xsl:when>
                                    <xsl:when test="./naam/geslachtsnaam/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:geslachtsnaam>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaam)">
                            <BG:voorvoegselGeslachtsnaam>
                                <xsl:choose>
                                    <xsl:when test="./naam/voorvoegsel/text() != ''">
                                        <xsl:value-of select="./naam/voorvoegsel" />
                                    </xsl:when>
                                    <xsl:when test="./naam/voorvoegsel/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:voorvoegselGeslachtsnaam>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorletters)">
                            <BG:voorletters>
                                <xsl:choose>
                                    <xsl:when test="./naam/voorletters/text() != ''">
                                        <xsl:value-of select="./naam/voorletters" />
                                    </xsl:when>
                                    <xsl:when test="./naam/voorletters/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:voorletters>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamen)">
                            <BG:voornamen>
                                <xsl:choose>
                                    <xsl:when test="./naam/voornamen/text() != ''">
                                        <xsl:value-of select="./naam/voornamen" />
                                    </xsl:when>
                                    <xsl:when test="./naam/voornamen/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:voornamen>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingNaamgebruik)">
                            <BG:aanduidingNaamgebruik>
                                <xsl:choose>
                                    <xsl:when test="./naam/aanduidingNaamgebruik/code/text() != ''">
                                        <xsl:value-of select="./naam/aanduidingNaamgebruik/code" />
                                    </xsl:when>
                                    <xsl:when test="./naam/aanduidingNaamgebruik/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:aanduidingNaamgebruik>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamPartner)">
                            <BG:geslachtsnaamPartner>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="./partners/naam/geslachtsnaam/text() != ''">
                                        <xsl:value-of select="./partners/naam/geslachtsnaam" />
                                    </xsl:when>
                                    <xsl:when test="./partners/naam/geslachtsnaam/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:geslachtsnaamPartner>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaamPartner)">
                            <BG:voorvoegselGeslachtsnaamPartner>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="./partners/naam/voorvoegsel/text() != ''">
                                        <xsl:value-of select="./partners/naam/voorvoegsel" />
                                    </xsl:when>
                                    <xsl:when test="./partners/naam/voorvoegsel/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:voorvoegselGeslachtsnaamPartner>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving)">
                            <BG:aanhefAanschrijving>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="./adressering/aanhef/text() != ''">
                                        <xsl:value-of select="./adressering/aanhef" />
                                    </xsl:when>
                                    <xsl:when test="./adressering/aanhef/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:aanhefAanschrijving>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamenAanschrijving)">
                            <BG:voornamenAanschrijving>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="/text() != ''">
                                        <!-- <xsl:value-of select="" /> -->
                                    </xsl:when>
                                    <xsl:when test="/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:voornamenAanschrijving>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamAanschrijving)">
                            <BG:geslachtsnaamAanschrijving>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="./naam/aanduidingNaamgebruik/code/text() != ''">
                                        <xsl:choose>
                                            <xsl:when test="./naam/aanduidingNaamgebruik/code = 'E'">
                                                <xsl:value-of select="./naam/geslachtsnaam" />
                                            </xsl:when>
                                            <xsl:when test="./naam/aanduidingNaamgebruik/code = 'N'">
                                                <xsl:value-of
                                                    select="concat(./naam/geslachtsnaam, '-',./partners/naam/geslachtsnaam)" />
                                            </xsl:when>
                                            <xsl:when test="./naam/aanduidingNaamgebruik/code = 'P'">
                                                <xsl:value-of select="./partners/naam/geslachtsnaam" />
                                            </xsl:when>
                                            <xsl:when test="./naam/aanduidingNaamgebruik/code = 'W'">
                                                <xsl:value-of
                                                    select="concat(./partners/naam/geslachtsnaam, '-',./naam/geslachtsnaam)" />
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="./naam/aanduidingNaamgebruik/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:geslachtsnaamAanschrijving>
                        </xsl:if>

                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:adellijkeTitelPredikaat)">
                            <BG:adellijkeTitelPredikaat>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:when
                                        test="./naam/adellijkeTitelPredicaat/code/text() != ''">
                                        <xsl:value-of select="./naam/adellijkeTitelPredicaat/code" />
                                    </xsl:when>
                                    <xsl:when test="./naam/adellijkeTitelPredicaat/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:adellijkeTitelPredikaat>
                        </xsl:if>

                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsaanduiding)">
                            <BG:geslachtsaanduiding>
                                <xsl:choose>
                                    <xsl:when test="./geslachtsaanduiding/text() != ''">
                                        <xsl:value-of select="./geslachtsaanduiding" />
                                    </xsl:when>
                                    <xsl:when test="./geslachtsaanduiding/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:geslachtsaanduiding>
                        </xsl:if>

                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geboortedatum)">
                            <BG:geboortedatum>
                                <xsl:choose>
                                    <xsl:when test="./geboorte/datum/datum/text() != ''">
                                        <xsl:variable name="date" select="./geboorte/datum/datum" />
                                        <xsl:value-of
                                            select="translate($date, '-', '')" />
                                    </xsl:when>
                                    <xsl:when test="./geboorte/datum/datum/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:geboortedatum>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteplaats)">
                            <BG:inp.geboorteplaats>
                                <xsl:choose>
                                    <xsl:when test="./geboorte/plaats/omschrijving/text() != ''">
                                        <xsl:value-of select="./geboorte/plaats/omschrijving" />
                                    </xsl:when>
                                    <xsl:when test="./geboorte/plaats/omschrijving/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.geboorteplaats>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteLand)">
                            <BG:inp.geboorteLand>
                                <xsl:choose>
                                    <xsl:when test="./geboorte/land/code/text() != ''">
                                        <xsl:value-of select="./geboorte/land/code" />
                                    </xsl:when>
                                    <xsl:when test="./geboorte/land/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.geboorteLand>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:overlijdensdatum)">
                            <BG:overlijdensdatum>
                                <xsl:choose>
                                    <xsl:when
                                        test="./overlijden/datum/datum/text() != ''">
                                        <xsl:variable name="date"
                                            select="./overlijden/datum/datum" />
                                        <xsl:value-of
                                            select="translate($date, '-', '')" />
                                    </xsl:when>
                                    <xsl:when
                                        test="./overlijden/datum/datum/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:overlijdensdatum>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenplaats)">
                            <BG:inp.overlijdenplaats>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie!=&apos;GWS&apos;) or ($varZenderApplicatie!=&apos;LBA&apos;)">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./overlijden/plaats/omschrijving/text() != ''">
                                                <xsl:value-of
                                                    select="./overlijden/plaats/omschrijving" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./overlijden/plaats/omschrijving/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.overlijdenplaats>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenLand)">
                            <BG:inp.overlijdenLand>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie!=&apos;GWS&apos;) or ($varZenderApplicatie!=&apos;LBA&apos;)">
                                        <xsl:choose>
                                            <xsl:when test="./overlijden/land/code/text() != ''">
                                                <xsl:value-of select="./overlijden/land/code" />
                                            </xsl:when>
                                            <xsl:when test="./overlijden/land/code/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.overlijdenLand>
                        </xsl:if>


                        <!-- <BG:inOnderzoek>
                            <geslachtsnaam>
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/naam = Persoonsgegevens/naam]/geslachtsnaam" />
                            </geslachtsnaam>
                            <voornamen>
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/naam = Persoonsgegevens/naam]/voornamen" />
                            </voornamen>
                            <voorvoegsel>
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/naam = Persoonsgegevens/naam]/voorvoegsel" />
                            </voorvoegsel>
                        </BG:inOnderzoek>
                        <BG:inOnderzoek>
                            <datum>
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/datum" />
                            </datum>
                            <land>
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/land" />
                            </land>
                            <plaats>
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/plaats" />
                            </plaats>
                        </BG:inOnderzoek> -->

                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn)">
                            <BG:inp.verblijftIn>
                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/@StUF:entiteittype" /></xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie=&apos;GWS&apos;">
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde)">
                                            <BG:gerelateerde>
                                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/@StUF:entiteittype" /></xsl:attribute>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp)">
                                                    <BG:adresAanduidingGrp>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam)">
                                                            <BG:wpl.woonplaatsNaam>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/woonplaats/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/woonplaats" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/woonplaats/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:wpl.woonplaatsNaam>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.straatnaam)">
                                                            <BG:gor.straatnaam>
                                                                <!-- <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/officieleStraatnaam/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/officieleStraatnaam" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/officieleStraatnaam/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.straatnaam/@xsi:nil"
                                                                            /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise> -->
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.straatnaam/@xsi:nil"
                                                                            /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    <!-- </xsl:otherwise>
                                                                </xsl:choose> -->
                                                            </BG:gor.straatnaam>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode)">
                                                            <BG:aoa.postcode>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/postcode/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/postcode" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/postcode/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aoa.postcode>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer)">
                                                            <BG:aoa.huisnummer>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisnummer/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/huisnummer" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisnummer/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aoa.huisnummer>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter)">
                                                            <BG:aoa.huisletter>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisletter/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/huisletter" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisletter/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aoa.huisletter>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging)">
                                                            <BG:aoa.huisnummertoevoeging>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisnummertoevoeging/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./verblijfplaats/verblijfadres/huisnummertoevoeging" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./verblijfplaats/verblijfadres/huisnummertoevoeging/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aoa.huisnummertoevoeging>
                                                        </xsl:if>
                                                    </BG:adresAanduidingGrp>
                                                </xsl:if>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:ingangsdatumObject)">
                                                    <BG:ingangsdatumObject>
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="./verblijfplaats/datumIngangGeldigheid/datum/text() != ''">
                                                                <xsl:variable name="date"
                                                                    select="./verblijfplaats/datumIngangGeldigheid/datum" />
                                                        <xsl:value-of
                                                                    select="translate($date, '-', '')" />
                                                            </xsl:when>
                                                            <xsl:when
                                                                test="./verblijfplaats/datumIngangGeldigheid/datum/text() = ''">
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:ingangsdatumObject/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$geenWaarde" /></xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:ingangsdatumObject/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </BG:ingangsdatumObject>
                                                </xsl:if>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteCode)">
                                                    <BG:gemeenteCode>
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="./verblijfplaats/gemeenteVanInschrijving/code/text() != ''">
                                                                <xsl:value-of
                                                                    select="./verblijfplaats/gemeenteVanInschrijving/code" />
                                                            </xsl:when>
                                                            <xsl:when
                                                                test="./verblijfplaats/gemeenteVanInschrijving/code/text() = ''">
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteCode/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$geenWaarde" /></xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteCode/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </BG:gemeenteCode>
                                                </xsl:if>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteNaam)">
                                                    <BG:gemeenteNaam>
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="./verblijfplaats/gemeenteVanInschrijving/omschrijving/text() != ''">
                                                                <xsl:value-of
                                                                    select="./verblijfplaats/gemeenteVanInschrijving/omschrijving" />
                                                            </xsl:when>
                                                            <xsl:when
                                                                test="./verblijfplaats/gemeenteVanInschrijving/omschrijving/text() = ''">
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteNaam/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$geenWaarde" /></xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/BG:gerelateerde/BG:gemeenteNaam/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </BG:gemeenteNaam>
                                                </xsl:if>
                                            </BG:gerelateerde>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakRelatie)">
                                            <StUF:tijdvakRelatie>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakRelatie/StUF:beginRelatie)">
                                                    <StUF:beginRelatie>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakRelatie/StUF:beginRelatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                    </StUF:beginRelatie>
                                                </xsl:if>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakRelatie/StUF:eindRelatie)">
                                                    <StUF:eindRelatie>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakRelatie/StUF:eindRelatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                    </StUF:eindRelatie>
                                                </xsl:if>
                                            </StUF:tijdvakRelatie>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakGeldigheid)">
                                            <StUF:tijdvakGeldigheid>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakGeldigheid/StUF:beginGeldigheid)">
                                                    <StUF:beginGeldigheid>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakGeldigheid/StUF:beginGeldigheid/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                    </StUF:beginGeldigheid>
                                                </xsl:if>
                                                <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakGeldigheid/StUF:eindGeldigheid)">
                                                    <StUF:eindGeldigheid>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdvakGeldigheid/StUF:eindGeldigheid/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                    </StUF:eindGeldigheid>
                                                </xsl:if>
                                            </StUF:tijdvakGeldigheid>
                                        </xsl:if>                                      
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdstipRegistratie)">
                                            <StUF:tijdstipRegistratie>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.verblijftIn/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </StUF:tijdstipRegistratie>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil">true</xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.verblijftIn>
                        </xsl:if>

                        <xsl:if
                            test="./verblijfplaats/type = &apos;Adres&apos;">
                            <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres)">
                                <BG:verblijfsadres>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.identificatie)">
                                        <BG:aoa.identificatie>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="$varZenderApplicatie != &apos;LBA&apos;">
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/nummeraanduidingIdentificatie/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/nummeraanduidingIdentificatie" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/nummeraanduidingIdentificatie/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:aoa.identificatie>
                                    </xsl:if>
                                    <!-- <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.identificatie)">
                                        <BG:wpl.identificatie>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="$varZenderApplicatie = &apos;DEC_ZKN&apos;">
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/adresseerbaarObjectIdentificatie/text() != ''">
                                                            <xsl:value-of
                                                            select="./verblijfplaats/adresseerbaarObjectIdentificatie" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/adresseerbaarObjectIdentificatie/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.identificatie/@xsi:nil"
                                    /></xsl:attribute>
                                                                <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.identificatie/@xsi:nil"
                                    /></xsl:attribute>
                                                                <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.identificatie/@xsi:nil"
                                    /></xsl:attribute>
                                                                <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:wpl.identificatie>
                                    </xsl:if> -->
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.woonplaatsNaam)">
                                        <BG:wpl.woonplaatsNaam>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/woonplaats/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/woonplaats" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/woonplaats/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:wpl.woonplaatsNaam>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen)">
                                        <BG:aoa.woonplaatsWaarinGelegen>
                                            <xsl:if
                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.identificatie)">
                                                <BG:wpl.identificatie>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="($varZenderApplicatie = &apos;DEC_ZKN&apos;) or ($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:wpl.identificatie>
                                            </xsl:if>
                                            <xsl:if
                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.woonplaatsNaam)">
                                                <BG:wpl.woonplaatsNaam>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)
                                                        or ($varZenderApplicatie = &apos;DEC_ZKN&apos;)">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.woonplaatsWaarinGelegen/wpl.woonplaatsNaam" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:wpl.woonplaatsNaam>
                                            </xsl:if>
                                        </BG:aoa.woonplaatsWaarinGelegen>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.identificatie)">
                                        <BG:gor.identificatie>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)
                                                        or ($varZenderApplicatie = &apos;DEC_ZKN&apos;)">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:gor.identificatie>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:opr.identificatie)">
                                        <BG:opr.identificatie>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)
                                                        or ($varZenderApplicatie = &apos;DEC_ZKN&apos;)">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>

                                        </BG:opr.identificatie>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.openbareRuimteNaam)">
                                        <BG:gor.openbareRuimteNaam>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/naamOpenbareRuimte/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/naamOpenbareRuimte" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/naamOpenbareRuimte/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:gor.openbareRuimteNaam>
                                    </xsl:if>
                                    <!-- <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.straatnaam)">
                                        <BG:gor.straatnaam>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/officieleStraatnaam/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/officieleStraatnaam" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/officieleStraatnaam/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.straatnaam/@xsi:nil"
                                    /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:gor.straatnaam/@xsi:nil"
                                    /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:gor.straatnaam>
                                    </xsl:if> -->
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.postcode)">
                                        <BG:aoa.postcode>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/postcode/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/postcode" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/postcode/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:aoa.postcode>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummer)">
                                        <BG:aoa.huisnummer>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisnummer/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/huisnummer" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisnummer/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:aoa.huisnummer>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisletter)">
                                        <BG:aoa.huisletter>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisletter/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/huisletter" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisletter/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:aoa.huisletter>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummertoevoeging)">
                                        <BG:aoa.huisnummertoevoeging>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisnummertoevoeging/text() != ''">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/huisnummertoevoeging" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/verblijfadres/huisnummertoevoeging/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:aoa.huisnummertoevoeging>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:inp.locatiebeschrijving)">
                                        <BG:inp.locatiebeschrijving>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="$varZenderApplicatie != &apos;GWS&apos;">
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/locatiebeschrijving/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/locatiebeschrijving" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/locatiebeschrijving/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>

                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:inp.locatiebeschrijving>
                                    </xsl:if>
                                    <xsl:if
                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:begindatumVerblijf)">
                                        <BG:begindatumVerblijf>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/datumVan/datum/text() != ''">
                                                    <xsl:variable name="date"
                                                        select="./verblijfplaats/datumVan/datum" />
                                                <xsl:value-of
                                                        select="translate($date, '-', '')" />
                                                </xsl:when>
                                                <xsl:when
                                                    test="./verblijfplaats/datumVan/datum/text() = ''">
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:begindatumVerblijf/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:verblijfsadres/BG:begindatumVerblijf/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </BG:begindatumVerblijf>
                                    </xsl:if>
                                </BG:verblijfsadres>
                            </xsl:if>
                        </xsl:if>

                        <xsl:if
                            test="./verblijfplaats/type = &apos;VerblijfplaatsBuitenland&apos;">
                            <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland)">
                                <BG:sub.verblijfBuitenland>
                                    <xsl:choose>
                                        <xsl:when
                                            test="$varZenderApplicatie != &apos;PGAx-SG-ZVH&apos;">
                                            <xsl:if
                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landcode)">
                                                <BG:lnd.landcode>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/land/code/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/land/code" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/land/code/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landcode/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landcode/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:lnd.landcode>
                                            </xsl:if>
                                            <xsl:if
                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landnaam)">
                                                <BG:lnd.landnaam>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/land/omschrijving/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/land/omschrijving" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/land/omschrijving/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landnaam/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:lnd.landnaam/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:lnd.landnaam>
                                            </xsl:if>
                                            <xsl:if
                                                test="string-length(./verblijfplaats/verblijfadres/regel1) !=0">
                                                <BG:sub.adresBuitenland1>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel1/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/regel1" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel1/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:sub.adresBuitenland1></xsl:if>
                                                <xsl:if
                                                test="string-length(./verblijfplaats/verblijfadres/regel2) !=0">
                                                <BG:sub.adresBuitenland2>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel2/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/regel2" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel2/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:sub.adresBuitenland2>
                                            </xsl:if>
                                                <xsl:if
                                                test="string-length(./verblijfplaats/verblijfadres/regel3) !=0">
                                                <BG:sub.adresBuitenland3>
                                                    <xsl:choose>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel3/text() != ''">
                                                            <xsl:value-of
                                                                select="./verblijfplaats/verblijfadres/regel3" />
                                                        </xsl:when>
                                                        <xsl:when
                                                            test="./verblijfplaats/verblijfadres/regel3/text() = ''">
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$geenWaarde" /></xsl:attribute>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </BG:sub.adresBuitenland3></xsl:if>
                                            <!--
                                            <vertrokkenOnbekendWaarheen>True</vertrokkenOnbekendWaarheen> -->

                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute
                                                name="StUF:noValue"><xsl:value-of
                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </BG:sub.verblijfBuitenland>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.adresHerkomst)">
                            <BG:inp.adresHerkomst>
                                <xsl:choose>
                                    <xsl:when test="./verblijfplaats/functieAdres/code/text() != ''">
                                        <xsl:value-of
                                            select="./verblijfplaats/functieAdres/code" />
                                    </xsl:when>
                                    <xsl:when test="./verblijfplaats/functieAdres/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.adresHerkomst/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.adresHerkomst/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.adresHerkomst>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres)">
                            <BG:sub.correspondentieAdres>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering)">
                                    <BG:typering>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:typering>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam)">
                                    <BG:wpl.woonplaatsNaam>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:wpl.woonplaatsNaam>
                                </xsl:if>
                                <!-- <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen)">
                                    <BG:aoa.woonplaatsWaarinGelegen>
                                        <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie)">
                                            <BG:wpl.identificatie>
                                                <xsl:attribute
                                                    name="xsi:nil"><xsl:value-of
                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie/@xsi:nil"
                                /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </BG:wpl.identificatie>
                                        </xsl:if>
                                        <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam)">
                                            <BG:wpl.woonplaatsNaam>
                                                <xsl:attribute
                                                    name="xsi:nil"><xsl:value-of
                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam/@xsi:nil"
                                /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </BG:wpl.woonplaatsNaam>
                                        </xsl:if>
                                    </BG:aoa.woonplaatsWaarinGelegen>
                                </xsl:if> -->
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode)">
                                    <BG:postcode>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:postcode>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie)">
                                    <BG:aoa.identificatie>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:aoa.identificatie>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek)">
                                    <BG:authentiek>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:authentiek>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie)">
                                    <BG:wpl.identificatie>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:wpl.identificatie>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie)">
                                    <BG:opr.identificatie>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:opr.identificatie>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam)">
                                    <BG:gor.openbareRuimteNaam>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:gor.openbareRuimteNaam>
                                </xsl:if>
                                <!-- <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam)">
                                    <BG:gor.straatnaam>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam/@xsi:nil"
                                /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:gor.straatnaam>
                                </xsl:if> -->
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer)">
                                    <BG:aoa.huisnummer>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:aoa.huisnummer>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter)">
                                    <BG:aoa.huisletter>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:aoa.huisletter>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging)">
                                    <BG:aoa.huisnummertoevoeging>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:aoa.huisnummertoevoeging>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType)">
                                    <BG:sub.postadresType>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:sub.postadresType>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer)">
                                    <BG:sub.postadresNummer>
                                        <xsl:attribute
                                            name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:sub.postadresNummer>
                                </xsl:if>
                            </BG:sub.correspondentieAdres>
                        </xsl:if>

                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.telefoonnummer)">
                            <BG:sub.telefoonnummer>
                                <xsl:choose>
                                    <xsl:when
                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.telefoonnummer/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.telefoonnummer/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:sub.telefoonnummer>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.faxnummer)">
                            <BG:sub.faxnummer>
                                <xsl:if
                                    test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;LBA&apos;) or 
                                        ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.faxnummer/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                        name="StUF:noValue"><xsl:value-of
                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                </xsl:if>
                            </BG:sub.faxnummer>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.emailadres)">
                            <BG:sub.emailadres>
                                <xsl:choose>
                                    <xsl:when
                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.emailadres/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.emailadres/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:sub.emailadres>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.url)">
                            <BG:sub.url>
                                <xsl:if
                                    test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;LBA&apos;) or 
                                    ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.url/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                        name="StUF:noValue"><xsl:value-of
                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                </xsl:if>
                            </BG:sub.url>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.rekeningnummerBankGiro)">
                            <BG:sub.rekeningnummerBankGiro>
                                <xsl:if
                                    test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;LBA&apos;) or 
                                    ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:sub.rekeningnummerBankGiro/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                        name="StUF:noValue"><xsl:value-of
                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                </xsl:if>
                            </BG:sub.rekeningnummerBankGiro>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:acd.code)">
                            <BG:acd.code>
                                <xsl:attribute
                                    name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:acd.code/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:acd.code>
                        </xsl:if>
                        <!--update
                        the value-->
                        <!-- <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.burgerlijkeStaat)">
                            <BG:inp.burgerlijkeStaat>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie!=&apos;PGAx-SG-ZVH&apos;">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./partners/aangaanHuwelijkPartnerschap/text() != ''"> </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.burgerlijkeStaat/@xsi:nil"
                        /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.burgerlijkeStaat/@xsi:nil"
                        /></xsl:attribute>
                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.burgerlijkeStaat>
                        </xsl:if> -->
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.gemeenteVanInschrijving)">
                            <BG:inp.gemeenteVanInschrijving>
                                <xsl:choose>
                                    <xsl:when test="./gemeenteVanInschrijving/code/text() != ''">
                                        <xsl:value-of select="./gemeenteVanInschrijving/code" />
                                    </xsl:when>
                                    <xsl:when test="./gemeenteVanInschrijving/code/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.gemeenteVanInschrijving/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.gemeenteVanInschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.gemeenteVanInschrijving>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:datumInschrijving)">
                            <BG:datumInschrijving>
                                <xsl:choose>
                                    <xsl:when
                                        test="./datumEersteInschrijvingGBA/datum/text() != ''">
                                        <xsl:variable name="date"
                                            select="./datumEersteInschrijvingGBA/datum" />
                                        <xsl:value-of
                                            select="translate($date, '-', '')" />
                                    </xsl:when>
                                    <xsl:when
                                        test="./datumEersteInschrijvingGBA/datum/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:datumInschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:datumInschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:datumInschrijving>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:vbt.aanduidingVerblijfstitel)">
                            <BG:vbt.aanduidingVerblijfstitel>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie=&apos;GWS&apos;">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./verblijfstitel/aanduiding/code/text() != ''">
                                                <xsl:value-of
                                                    select="./verblijfstitel/aanduiding/code" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./verblijfstitel/aanduiding/code/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:vbt.aanduidingVerblijfstitel>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerkrijgingVerblijfstitel)">
                            <BG:ing.datumVerkrijgingVerblijfstitel>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie=&apos;GWS&apos;">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./verblijfstitel/datumIngang/datum/text() != ''">
                                                <xsl:variable name="date"
                                                    select="./verblijfstitel/datumIngang/datum" />
                                            <xsl:value-of
                                                    select="translate($date, '-', '')" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./verblijfstitel/datumIngang/datum/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:ing.datumVerkrijgingVerblijfstitel>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerliesVerblijfstitel)">
                            <BG:ing.datumVerliesVerblijfstitel>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie=&apos;GWS&apos;">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./verblijfstitel/datumEinde/datum/text() != ''">
                                                <xsl:variable name="date"
                                                    select="./verblijfstitel/datumEinde/datum" />
                                        <xsl:value-of
                                                    select="translate($date, '-', '')" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./verblijfstitel/datumEinde/datum/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:ing.datumVerliesVerblijfstitel>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland)">
                            <BG:inp.datumVestigingInNederland>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;)">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./immigratie/datumVestigingInNederland/datum/text() != ''">
                                                <xsl:variable name="date"
                                                    select="./immigratie/datumVestigingInNederland/datum" />
                                                <xsl:value-of
                                                    select="translate($date, '-', '')" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./immigratie/datumVestigingInNederland/datum/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.datumVestigingInNederland>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.immigratieLand)">
                            <BG:inp.immigratieLand>
                                <xsl:choose>
                                    <xsl:when test="($varZenderApplicatie=&apos;DEC_ZKN&apos;)">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./immigratie/landVanwaarIngeschreven/omschrijving/text() != ''">
                                                <xsl:value-of
                                                    select="./immigratie/landVanwaarIngeschreven/omschrijving" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./immigratie/landVanwaarIngeschreven/omschrijving/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.immigratieLand>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland)">
                            <BG:inp.datumVertrekUitNederland>
                                <xsl:choose>
                                    <xsl:when test="($varZenderApplicatie=&apos;LBA&apos;)">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./immigratie/indicatieVestigingVanuitBuitenland/datum/text() != ''">
                                                <xsl:variable name="date"
                                                    select="./immigratie/indicatieVestigingVanuitBuitenland/datum" />
                                                <xsl:value-of
                                                    select="translate($date, '-', '')" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./immigratie/indicatieVestigingVanuitBuitenland/datum/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.datumVertrekUitNederland>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.emigratieLand)">
                            <BG:inp.emigratieLand>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                        <xsl:if
                                            test="./opschortingBijhouding/reden/code/text()='E'">
                                            <xsl:choose>
                                                <xsl:when
                                                    test="./verblijfplaats/type/text()='VerblijfplaatsBuitenland'">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/land/code" />
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:if>
                                            <xsl:choose>
                                            <xsl:when
                                                test="./verblijfplaats/type/text()!='VerblijfplaatsBuitenland'">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>

                                            </xsl:when>
                                            <xsl:when
                                                test="./verblijfplaats/verblijfadres/land/code/text()=''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.emigratieLand>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.signaleringReisdocument)">
                            <BG:inp.signaleringReisdocument>
                                <xsl:attribute
                                    name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.signaleringReisdocument/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:inp.signaleringReisdocument>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingBijzonderNederlanderschap)">
                            <BG:aanduidingBijzonderNederlanderschap>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie = &apos;GWS&apos;">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./nationaliteit/aanduidingBijzonderNederlanderschap/text() != ''">
                                                <xsl:value-of
                                                    select="./nationaliteit/aanduidingBijzonderNederlanderschap" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./nationaliteit/aanduidingBijzonderNederlanderschap/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingBijzonderNederlanderschap/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingBijzonderNederlanderschap/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingBijzonderNederlanderschap/@StUF:entiteittype" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:aanduidingBijzonderNederlanderschap>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.buitenlandsReisdocument)">
                            <BG:inp.buitenlandsReisdocument>
                                <xsl:attribute
                                    name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.buitenlandsReisdocument/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:inp.buitenlandsReisdocument>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingEuropeesKiesrecht)">
                            <BG:ing.aanduidingEuropeesKiesrecht>
                                <xsl:choose>
                                    <xsl:when test="$varZenderApplicatie != &apos;DEC_ZKN&apos;">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingEuropeesKiesrecht/@StUF:entiteittype" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when
                                                test="./europeesKiesrecht/aanduiding/code/text() != ''">
                                                <xsl:value-of
                                                    select="./europeesKiesrecht/aanduiding/code" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./europeesKiesrecht/aanduiding/code/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingEuropeesKiesrecht/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingEuropeesKiesrecht/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:ing.aanduidingEuropeesKiesrecht>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingUitgeslotenKiesrecht)">
                            <BG:ing.aanduidingUitgeslotenKiesrecht>
                                <xsl:attribute
                                    name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.aanduidingUitgeslotenKiesrecht/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:ing.aanduidingUitgeslotenKiesrecht>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieGezagMinderjarige)">
                            <BG:ing.indicatieGezagMinderjarige>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;TOP&apos;)">
                                        <xsl:choose>
                                            <xsl:when
                                                test="./gezagsverhouding/indicatieGezagMinderjarige/text() != ''">
                                                <xsl:value-of
                                                    select="./gezagsverhouding/indicatieGezagMinderjarige" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./gezagsverhouding/indicatieGezagMinderjarige/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:ing.indicatieGezagMinderjarige>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieCurateleRegister)">
                            <BG:ing.indicatieCurateleRegister>
                                <xsl:choose>
                                    <xsl:when
                                        test="./gezagsverhouding/indicatieCurateleRegister/text() != ''">
                                        <xsl:value-of
                                            select="./gezagsverhouding/indicatieCurateleRegister" />
                                    </xsl:when>
                                    <xsl:when
                                        test="./gezagsverhouding/indicatieCurateleRegister/text() = ''">
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieCurateleRegister/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:ing.indicatieCurateleRegister>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumOpschortingBijhouding)">
                            <BG:inp.datumOpschortingBijhouding>
                                <xsl:choose>
                                    <xsl:when
                                        test="./opschortingBijhouding/datum/datum/text() != ''">
                                        <xsl:variable name="date"
                                            select="./opschortingBijhouding/datum/datum" />
                                        <xsl:value-of
                                            select="translate($date, '-', '')" />
                                    </xsl:when>
                                    <xsl:when
                                        test="./opschortingBijhouding/datum/datum/text() = ''">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of select="$geenWaarde" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.datumOpschortingBijhouding>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.redenOpschortingBijhouding)">
                            <BG:inp.redenOpschortingBijhouding>
                                <xsl:value-of select="./opschortingBijhouding/reden" />
                                <xsl:if test="./opschortingBijhouding/reden=0">
                                    <xsl:value-of select="./overlijden/indicatieOverleden" />
                                </xsl:if>
                            </BG:inp.redenOpschortingBijhouding>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.indicatieGeheim)">
                            <BG:inp.indicatieGeheim>
                                <xsl:choose>
                                    <xsl:when
                                        test="$varZenderApplicatie=&apos;DEC_ZKN&apos;">
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when
                                                test="./geheimhoudingPersoonsgegevens/text() != ''">
                                                <xsl:value-of
                                                    select="./geheimhoudingPersoonsgegevens" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./geheimhoudingPersoonsgegevens/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.indicatieGeheim>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieBlokkering)">
                            <BG:ing.indicatieBlokkering>
                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:ing.indicatieBlokkering/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:ing.indicatieBlokkering>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inOnderzoek)">
                            <BG:inOnderzoek>
                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inOnderzoek/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </BG:inOnderzoek>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingStrijdigheidNietigheid)">
                            <BG:aanduidingStrijdigheidNietigheid>
                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanduidingStrijdigheidNietigheid/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:metagegeven">true</xsl:attribute>
                            </BG:aanduidingStrijdigheidNietigheid>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument)">
                            <BG:brondocument>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:datum)">
                                    <BG:datum>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:datum/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:datum>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:omschrijving)">
                                    <BG:omschrijving>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:omschrijving>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:gemeente)">
                                    <BG:gemeente>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:brondocument/BG:gemeente/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </BG:gemeente>
                                </xsl:if>
                            </BG:brondocument>
                        </xsl:if>
                        <!-- <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakRelatie)">
                                    <StUF:tijdvakRelatie>
                                        <xsl:if
                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakRelatie/StUF:beginRelatie)">
                                            <StUF:beginRelatie>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakRelatie/StUF:beginRelatie/@xsi:nil"
                        /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </StUF:beginRelatie>
                                        </xsl:if>
                                        <xsl:if
                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakRelatie/StUF:eindRelatie)">
                                            <StUF:eindRelatie>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakRelatie/StUF:eindRelatie/@xsi:nil"
                        /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </StUF:eindRelatie>
                                        </xsl:if>
                                    </StUF:tijdvakRelatie>
                                </xsl:if> -->
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakGeldigheid)">
                            <StUF:tijdvakGeldigheid>
                                <StUF:beginGeldigheid>
                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakGeldigheid/StUF:beginGeldigheid/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                        name="StUF:noValue"><xsl:value-of
                                            select="$waardeOnbekend" /></xsl:attribute>
                                </StUF:beginGeldigheid>
                                <StUF:eindGeldigheid>
                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdvakGeldigheid/StUF:eindGeldigheid/@xsi:nil" /></xsl:attribute>
                                    <xsl:attribute
                                        name="StUF:noValue"><xsl:value-of
                                            select="$waardeOnbekend" /></xsl:attribute>
                                </StUF:eindGeldigheid>
                            </StUF:tijdvakGeldigheid>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdstipRegistratie)">
                            <StUF:tijdstipRegistratie>
                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>
                            </StUF:tijdstipRegistratie>
                        </xsl:if>
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:extraElementen)">
                            <StUF:extraElementen>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/StUF:extraElementen/StUF:extraElement)">
                                    <StUF:extraElement>

                                    </StUF:extraElement>
                                </xsl:if>
                            </StUF:extraElementen>
                        </xsl:if>

                        <!-- <BG:inOnderzoek>
                            <aanduidingBijzonderNederlanderschap>
                                <xsl:value-of
                                    select="./nationaliteit/inOnderzoek[/elementnaam =
                        aanduidingBijzonderNederlanderschap]/aanduidingBijzonderNederlanderschap" />
                            </aanduidingBijzonderNederlanderschap>
                            <nationaliteit>
                                <xsl:value-of
                                    select="./nationaliteit/inOnderzoek[/groepsnaam = Nationaliteit]/nationaliteit" />
                            </nationaliteit>
                            <redenOpname>True</redenOpname>
                        </BG:inOnderzoek> -->


                        <!-- <BG:Verblijfsplaats>
                            <BG:datumAanvangAdreshouding>True</BG:datumAanvangAdreshouding>
                            <BG:datumIngangGeldigheid>True</BG:datumIngangGeldigheid>
                            <BG:datumInschrijvingInGemeente>True</BG:datumInschrijvingInGemeente>
                            <BG:datumVestigingInNederland>True</BG:datumVestigingInNederland>
                            <BG:gemeenteVanInschrijving>True</BG:gemeenteVanInschrijving>
                            <StUF:InOnderzoek>
                                <huisletter>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/huisletter" />
                                </huisletter>
                                <huisnummer>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/huisnummer" />
                                </huisnummer>
                                <huisnummertoevoeging>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam =
                            Verblijfsplaats/groepsnaam]/huisnummertoevoeging" />
                                </huisnummertoevoeging>
                                <identificatiecodeNummeraanduiding>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam =
                            Verblijfsplaats/groepsnaam]/identificatiecodeNummeraanduiding" />
                                </identificatiecodeNummeraanduiding>
                                <identificatiecodeAdresseerbaarObject>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam =
                            Verblijfsplaats/groepsnaam]/identificatiecodeAdresseerbaarObject" />
                                </identificatiecodeAdresseerbaarObject>
                                <landVanwaarIngeschreven>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam =
                            Verblijfsplaats/groepsnaam]/landVanwaarIngeschreven" />
                                </landVanwaarIngeschreven>
                                <locatiebeschrijving>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/locatiebeschrijving"
                            />
                                </locatiebeschrijving>
                                <naamOpenbareRuimte>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/naamOpenbareRuimte"
                            />
                                </naamOpenbareRuimte>
                                <postcode>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/postcode" />
                                </postcode>
                                <straatnaam>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/straatnaam" />
                                </straatnaam>
                                <verblijfBuitenland>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/verblijfBuitenland"
                            />
                                </verblijfBuitenland>
                                <woonplaatsnaam>
                                    <xsl:value-of
                                        select="./verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/woonplaatsnaam" />
                                </woonplaatsnaam>
                            </StUF:InOnderzoek> 
                        </BG:Verblijfsplaats>-->


                        <!-- <BG:inOnderzoek>
                            <indicatieCurateleRegister>
                                <xsl:value-of
                                    select="./gezagsverhouding/inOnderzoek[/groepsnaam =
                        Gezagsverhouding/groepsnaam]/indicatieCurateleRegister" />
                            </indicatieCurateleRegister>
                            <indicatieGezagMinderjarige>
                                <xsl:value-of
                                    select="./gezagsverhouding/inOnderzoek[/groepsnaam =
                        Gezagsverhouding/groepsnaam]/indicatieGezagMinderjarige" />
                            </indicatieGezagMinderjarige>
                            <datumIngangOnderzoek>
                                <xsl:if
                                    test="./gezagsverhouding/inOnderzoek/groepsnaam = Gezagsverhouding/groepsnaam">
                                    <xsl:variable name="date"
                                        select="./gezagsverhouding/inOnderzoek/datumIngangOnderzoek/datum" />
                                        <xsl:value-of select="translate($date, '-', '')" />
                                </xsl:if>
                            </datumIngangOnderzoek>
                        </BG:inOnderzoek> -->


                        <xsl:for-each
                            select="./partners">
                            <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner)">
                                <BG:inp.heeftAlsEchtgenootPartner>
                                    <xsl:choose>
                                        <xsl:when
                                            test="($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                            <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/@StUF:entiteittype" /></xsl:attribute>
                                        <xsl:attribute
                                                name="xsi:nil">true</xsl:attribute>
                                        <xsl:attribute
                                                name="StUF:noValue"><xsl:value-of
                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:choose>
                                                <xsl:when test="./text() !=''">
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/@StUF:entiteittype" /></xsl:attribute>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde)">
                                                        <BG:gerelateerde>
                                                            <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/@StUF:entiteittype" />
                                                            </xsl:attribute>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.bsn)">
                                                                <BG:inp.bsn>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./burgerservicenummer/text() !=''">
                                                                                    <xsl:value-of
                                                                                        select="./burgerservicenummer" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./burgerservicenummer/text() =''">
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:anp.identificatie)">
                                                                                        <BG:anp.identificatie>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:anp.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue">
                                                                                                <xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:anp.identificatie>
                                                                                    </xsl:if>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.bsn>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:authentiek)">
                                                                <BG:authentiek>J</BG:authentiek>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.typering)">
                                                                <BG:sub.typering>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.typering/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.typering>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.a-nummer)">
                                                                <BG:inp.a-nummer>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.a-nummer>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaam)">
                                                                <BG:geslachtsnaam>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/geslachtsnaam/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/geslachtsnaam" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/geslachtsnaam/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geslachtsnaam>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorletters)">
                                                                <BG:voorletters>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voorletters/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voorletters" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voorletters/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voorletters>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voornamen)">
                                                                <BG:voornamen>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voornamen/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voornamen" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voornamen/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voornamen>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorvoegselGeslachtsnaam)">
                                                                <BG:voorvoegselGeslachtsnaam>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voorvoegsel/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voorvoegsel" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voorvoegsel/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voorvoegselGeslachtsnaam>
                                                            </xsl:if>

                                                            <!-- <BG:inOnderzoek>
                                                                <geslachtsnaam>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsnaam" />
                                                                </geslachtsnaam>
                                                                <voornamen>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voornamen" />
                                                                </voornamen>
                                                                <voorvoegsel>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voorvoegsel" />
                                                                </voorvoegsel>
                                                                <BG:datumIngangOnderzoek>
                                                                    <dag>1</dag>
                                                                    <maand>1</maand>
                                                                    <jaar>1900</jaar>
                                                                </BG:datumIngangOnderzoek>
                                                            </BG:inOnderzoek> -->
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaamPartner)">
                                                                <BG:geslachtsnaamPartner>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:geslachtsnaamPartner>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner)">
                                                                <BG:voorvoegselGeslachtsnaamPartner>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:voorvoegselGeslachtsnaamPartner>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:aanduidingNaamgebruik)">
                                                                <BG:aanduidingNaamgebruik>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:aanduidingNaamgebruik>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:aanhefAanschrijving)">
                                                                <BG:aanhefAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:aanhefAanschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voornamenAanschrijving)">
                                                                <BG:voornamenAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:voornamenAanschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaamAanschrijving)">
                                                                <BG:geslachtsnaamAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:geslachtsnaamAanschrijving>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:adellijkeTitelPredikaat)">
                                                                <BG:adellijkeTitelPredikaat>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/adellijkeTitelPredicaat/code/text() != ''">
                                                                            <xsl:value-of
                                                                                select="./naam/adellijkeTitelPredicaat/code" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/adellijkeTitelPredicaat/code/text() = ''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:adellijkeTitelPredikaat>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsaanduiding)">
                                                                <BG:geslachtsaanduiding>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="$varZenderApplicatie=&apos;TOP&apos;">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./geslachtsaanduiding/text() !=''">
                                                                                    <xsl:value-of
                                                                                        select="./geslachtsaanduiding" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./geslachtsaanduiding/text() =''">
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geslachtsaanduiding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geboortedatum)">
                                                                <BG:geboortedatum>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geboorte/datum/datum/text() !=''">
                                                                            <xsl:variable
                                                                                name="date"
                                                                                select="./geboorte/datum/datum" />
                                                                        <xsl:value-of
                                                                                select="$date" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geboorte/datum/datum/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geboortedatum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteLand)">
                                                                <BG:inp.geboorteLand>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geboorte/land/code/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./geboorte/land/code" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geboorte/land/code/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.geboorteLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteplaats)">
                                                                <BG:inp.geboorteplaats>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geboorte/plaats/omschrijving/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./geboorte/plaats/omschrijving" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geboorte/plaats/omschrijving/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.geboorteplaats>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="./verblijfplaats/type = &apos;Adres&apos;">
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres)">
                                                                    <BG:verblijfsadres>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie)">
                                                                            <BG:aoa.identificatie>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.identificatie>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:authentiek)">
                                                                            <BG:authentiek>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:authentiek>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam)">
                                                                            <BG:wpl.woonplaatsNaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:wpl.woonplaatsNaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam)">
                                                                            <BG:gor.openbareRuimteNaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:gor.openbareRuimteNaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode)">
                                                                            <BG:aoa.postcode>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.postcode>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer)">
                                                                            <BG:aoa.huisnummer>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisnummer>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter)">
                                                                            <BG:aoa.huisletter>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisletter>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging)">
                                                                            <BG:aoa.huisnummertoevoeging>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisnummertoevoeging>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving)">
                                                                            <BG:inp.locatiebeschrijving>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:inp.locatiebeschrijving>
                                                                        </xsl:if>
                                                                    </BG:verblijfsadres>
                                                                </xsl:if>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="./verblijfplaats/type = &apos;VerblijfplaatsBuitenland&apos;">
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland)">
                                                                    <BG:sub.verblijfBuitenland>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode)">
                                                                            <BG:lnd.landcode>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:lnd.landcode>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam)">
                                                                            <BG:lnd.landnaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:lnd.landnaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1)">
                                                                            <BG:sub.adresBuitenland1>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland1>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2)">
                                                                            <BG:sub.adresBuitenland2>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland2>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3)">
                                                                            <BG:sub.adresBuitenland3>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland3>
                                                                        </xsl:if>
                                                                    </BG:sub.verblijfBuitenland>
                                                                </xsl:if>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.adresHerkomst)">
                                                                <BG:inp.adresHerkomst>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.adresHerkomst/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.adresHerkomst>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn)">
                                                                <BG:inp.verblijftIn>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde)">
                                                                        <BG:gerelateerde>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie)">
                                                                                <BG:identificatie>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:identificatie>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek)">
                                                                                <BG:authentiek>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:authentiek>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering)">
                                                                                <BG:typering>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:typering>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp)">
                                                                                <BG:adresAanduidingGrp>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie)">
                                                                                        <BG:num.identificatie>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:num.identificatie>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie)">
                                                                                        <BG:oao.identificatie>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:oao.identificatie>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek)">
                                                                                        <BG:authentiek>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:authentiek>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam)">
                                                                                        <BG:wpl.woonplaatsNaam>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:wpl.woonplaatsNaam>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam)">
                                                                                        <BG:gor.openbareRuimteNaam>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:gor.openbareRuimteNaam>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode)">
                                                                                        <BG:aoa.postcode>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.postcode>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer)">
                                                                                        <BG:aoa.huisnummer>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisnummer>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter)">
                                                                                        <BG:aoa.huisletter>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisletter>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging)">
                                                                                        <BG:aoa.huisnummertoevoeging>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisnummertoevoeging>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding)">
                                                                                        <BG:ogo.locatieAanduiding>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:ogo.locatieAanduiding>
                                                                                    </xsl:if>
                                                                                </BG:adresAanduidingGrp>
                                                                            </xsl:if>
                                                                        </BG:gerelateerde>
                                                                    </xsl:if>
                                                                </BG:inp.verblijftIn>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres)">
                                                                <BG:sub.correspondentieAdres>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering)">
                                                                        <BG:typering>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:typering>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam)">
                                                                        <BG:wpl.woonplaatsNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:wpl.woonplaatsNaam>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen)">
                                                                        <BG:aoa.woonplaatsWaarinGelegen>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie)">
                                                                                <BG:wpl.identificatie>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:wpl.identificatie>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam)">
                                                                                <BG:wpl.woonplaatsNaam>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:wpl.woonplaatsNaam>
                                                                            </xsl:if>
                                                                        </BG:aoa.woonplaatsWaarinGelegen>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode)">
                                                                        <BG:postcode>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:postcode>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie)">
                                                                        <BG:aoa.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek)">
                                                                        <BG:authentiek>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:authentiek>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie)">
                                                                        <BG:wpl.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:wpl.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie)">
                                                                        <BG:opr.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:opr.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam)">
                                                                        <BG:gor.openbareRuimteNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:gor.openbareRuimteNaam>
                                                                    </xsl:if>
                                                                    <!-- <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam)">
                                                                        <BG:gor.straatnaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam/@xsi:nil"
                                                                    /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:gor.straatnaam>
                                                                    </xsl:if> -->
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer)">
                                                                        <BG:aoa.huisnummer>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummer>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter)">
                                                                        <BG:aoa.huisletter>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisletter>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging)">
                                                                        <BG:aoa.huisnummertoevoeging>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummertoevoeging>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType)">
                                                                        <BG:sub.postadresType>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:sub.postadresType>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer)">
                                                                        <BG:sub.postadresNummer>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:sub.postadresNummer>
                                                                    </xsl:if>
                                                                </BG:sub.correspondentieAdres>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.burgerlijkeStaat)">
                                                                <BG:inp.burgerlijkeStaat>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.burgerlijkeStaat/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.burgerlijkeStaat>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.gemeenteVanInschrijving)">
                                                                <BG:inp.gemeenteVanInschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.gemeenteVanInschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.gemeenteVanInschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.datumInschrijving)">
                                                                <BG:inp.datumInschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.datumInschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.datumInschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:overlijdensdatum)">
                                                                <BG:overlijdensdatum>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:overlijdensdatum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.overlijdenplaats)">
                                                                <BG:inp.overlijdenplaats>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.overlijdenplaats>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.overlijdenLand)">
                                                                <BG:inp.overlijdenLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.overlijdenLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.immigratieLand)">
                                                                <BG:inp.immigratieLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.immigratieLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.emigratieLand)">
                                                                <BG:inp.emigratieLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.emigratieLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.telefoonnummer)">
                                                                <BG:sub.telefoonnummer>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.telefoonnummer/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.telefoonnummer>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.faxnummer)">
                                                                <BG:sub.faxnummer>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.faxnummer/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.faxnummer>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.emailadres)">
                                                                <BG:sub.emailadres>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.emailadres/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.emailadres>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.url)">
                                                                <BG:sub.url>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.url/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.url>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.rekeningnummerBankGiro)">
                                                                <BG:sub.rekeningnummerBankGiro>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:sub.rekeningnummerBankGiro/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.rekeningnummerBankGiro>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:acd.code)">
                                                                <BG:acd.code>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:acd.code/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:acd.code>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel)">
                                                                <BG:vbt.aanduidingVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:vbt.aanduidingVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel)">
                                                                <BG:ing.datumVerkrijgingVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.datumVerkrijgingVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.datumVerliesVerblijfstitel)">
                                                                <BG:ing.datumVerliesVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.datumVerliesVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.signaleringReisdocument)">
                                                                <BG:inp.signaleringReisdocument>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.signaleringReisdocument/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.signaleringReisdocument>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap)">
                                                                <BG:inp.aanduidingBijzonderNederlanderschap>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.aanduidingBijzonderNederlanderschap>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.buitenlandsReisdocument)">
                                                                <BG:inp.buitenlandsReisdocument>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.buitenlandsReisdocument/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.buitenlandsReisdocument>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht)">
                                                                <BG:ing.aanduidingEuropeesKiesrecht>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.aanduidingEuropeesKiesrecht>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht)">
                                                                <BG:ing.aanduidingUitgeslotenKiesrecht>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.aanduidingUitgeslotenKiesrecht>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige)">
                                                                <BG:ing.indicatieGezagMinderjarige>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.indicatieGezagMinderjarige>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieCurateleRegister)">
                                                                <BG:ing.indicatieCurateleRegister>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieCurateleRegister/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.indicatieCurateleRegister>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.datumOpschortingBijhouding)">
                                                                <BG:inp.datumOpschortingBijhouding>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.datumOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.datumOpschortingBijhouding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.redenOpschortingBijhouding)">
                                                                <BG:inp.redenOpschortingBijhouding>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:inp.redenOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.redenOpschortingBijhouding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieBlokkering)">
                                                                <BG:ing.indicatieBlokkering>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:gerelateerde/BG:ing.indicatieBlokkering/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.indicatieBlokkering>
                                                            </xsl:if>

                                                            <!-- <StUF:extraElementen>
                                                            <StUF:extraElement></StUF:extraElement>
                                                        </StUF:extraElementen> -->


                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.indicatieGeheim)">
                                                                <BG:inp.indicatieGeheim>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geheimhoudingPersoonsgegevens/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./geheimhoudingPersoonsgegevens" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geheimhoudingPersoonsgegevens/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.indicatieGeheim>
                                                            </xsl:if>
                                                        </BG:gerelateerde>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.soortVerbintenis)">
                                                        <BG:inp.soortVerbintenis>
                                                            <xsl:choose>
                                                                <xsl:when
                                                                    test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./soortVerbintenis/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./soortVerbintenis" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./soortVerbintenis/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.soortVerbintenis/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.soortVerbintenis/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inp.soortVerbintenis/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </BG:inp.soortVerbintenis>
                                                    </xsl:if>


                                            <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumSluiting)">
                                                        <BG:datumSluiting>
                                                            <xsl:choose>
                                                                <xsl:when
                                                                    test="./aangaanHuwelijkPartnerschap/datum/datum/text() !=''">
                                                                    <xsl:variable name="date"
                                                                        select="./aangaanHuwelijkPartnerschap/datum/datum" />
                                                        <xsl:value-of
                                                                        select="translate($date, '-', '')" />
                                                                </xsl:when>
                                                                <xsl:when
                                                                    test="./aangaanHuwelijkPartnerschap/datum/datum/text() =''">
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumSluiting/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumSluiting/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </BG:datumSluiting>
                                                    </xsl:if>
                                            <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:plaatsSluiting)">
                                                        <BG:plaatsSluiting>
                                                            <BG:code>
                                                                <xsl:value-of
                                                                    select="./aangaanHuwelijkPartnerschap/plaats/code" />
                                                            </BG:code>
                                                            <BG:omschrijving>
                                                                <xsl:value-of
                                                                    select="./aangaanHuwelijkPartnerschap/plaats/omschrijving" />
                                                            </BG:omschrijving>
                                                        </BG:plaatsSluiting>
                                                    </xsl:if>
                                            <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:landSluiting)">
                                                        <BG:landSluiting>
                                                            <BG:code>
                                                                <xsl:value-of
                                                                    select="./aangaanHuwelijkPartnerschap/land" />
                                                            </BG:code>
                                                            <BG:omschrijving>
                                                                <xsl:value-of
                                                                    select="./aangaanHuwelijkPartnerschap/land/omschrijving" />
                                                            </BG:omschrijving>
                                                        </BG:landSluiting>
                                                    </xsl:if>
                                                    <!-- <BG:inOnderzoek>
                                                        <xsl:value-of
                                                            select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum"
                                                    />
                                                        <xsl:value-of
                                                            select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land"
                                                    />
                                                        <xsl:value-of
                                                            select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam =
                                                    Persoonsgegevens/groepsnaam]/plaats" />
                                                        <BG:datumIngangOnderzoek>
                                                            <dag>1</dag>
                                                            <maand>1</maand>
                                                            <jaar>1900</jaar>
                                                        </BG:datumIngangOnderzoek>
                                                    </BG:inOnderzoek> -->
                                            <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumOntbinding)">
                                                        <BG:datumOntbinding>
                                                            <xsl:choose>
                                                                <xsl:when
                                                                    test="./ontbindingHuwelijkPartnerschap/datum/datum/text() !=''">
                                                                    <xsl:variable name="date"
                                                                        select="./ontbindingHuwelijkPartnerschap/datum/datum" />
                                                        <xsl:value-of
                                                                        select="translate($date, '-', '')" />
                                                                </xsl:when>
                                                                <xsl:when
                                                                    test="./ontbindingHuwelijkPartnerschap/datum/datum/text() =''">
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumOntbinding/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:datumOntbinding/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </BG:datumOntbinding>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:plaatsOntbinding)">
                                                        <BG:plaatsOntbinding>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:plaatsOntbinding/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:plaatsOntbinding>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:landOntbinding)">
                                                        <BG:landOntbinding>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:landOntbinding/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:landOntbinding>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:redenOntbinding)">
                                                        <BG:redenOntbinding>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:redenOntbinding/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:redenOntbinding>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inOnderzoek)">
                                                        <BG:inOnderzoek>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:inOnderzoek/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:inOnderzoek>
                                                    </xsl:if>


                                                    <!-- <BG:inOnderzoek>
                                    <datum>
                                        <xsl:value-of
                                            select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                    </datum>
                                    <land>
                                        <xsl:value-of
                                            select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                    </land>
                                    <plaats>
                                        <xsl:value-of
                                            select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                    </plaats>
                                    <burgerservicenummer>
                                        <xsl:value-of
                                            select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/burgerservicenummer" />
                                    </burgerservicenummer>
                                    <geslachtsaanduiding>
                                        <xsl:value-of
                                            select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsaanduiding" />
                                    </geslachtsaanduiding>
                                    <BG:datumIngangOnderzoek>
                                        <dag>1</dag>
                                        <maand>1</maand>
                                        <jaar>1900</jaar>
                                    </BG:datumIngangOnderzoek>
                                </BG:inOnderzoek> -->

                        
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:aanduidingStrijdigheidNietigheid)">
                                                        <BG:aanduidingStrijdigheidNietigheid>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:aanduidingStrijdigheidNietigheid/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:aanduidingStrijdigheidNietigheid>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument)">
                                                        <BG:brondocument>
                                                            <!--
                                                        <BG:identificatie></BG:identificatie> -->
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:datum)">
                                                                <BG:datum>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:datum/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:datum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:omschrijving)">
                                                                <BG:omschrijving>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:omschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:gemeente)">
                                                                <BG:gemeente>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/BG:brondocument/BG:gemeente/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:gemeente>
                                                            </xsl:if>
                                                            <!-- <BG:aktegemeente></BG:aktegemeente> -->
                                                        </BG:brondocument>
                                                    </xsl:if>

                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdvakGeldigheid)">
                                                        <StUF:tijdvakGeldigheid>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdvakGeldigheid/StUF:beginGeldigheid)">
                                                                <StUF:beginGeldigheid>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdvakGeldigheid/StUF:beginGeldigheid/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </StUF:beginGeldigheid>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdvakGeldigheid/StUF:eindGeldigheid)">
                                                                <StUF:eindGeldigheid>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdvakGeldigheid/StUF:eindGeldigheid/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </StUF:eindGeldigheid>
                                                            </xsl:if>
                                                        </StUF:tijdvakGeldigheid>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdstipRegistratie)">
                                                        <StUF:tijdstipRegistratie>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </StUF:tijdstipRegistratie>
                                                    </xsl:if>

                                                    <!-- <StUF:extraElementen>
                                                    <StUF:extraElement></StUF:extraElement>
                                                </StUF:extraElementen> -->
                                                </xsl:when>
                                                <xsl:when test="./text()=''">
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/@StUF:entiteittype" /></xsl:attribute>
                                                <xsl:attribute
                                                        name="xsi:nil">true</xsl:attribute>
                                                <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsEchtgenootPartner/@StUF:entiteittype" /></xsl:attribute>
                                                <xsl:attribute
                                                        name="xsi:nil">true</xsl:attribute>
                                                <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </BG:inp.heeftAlsEchtgenootPartner>
                            </xsl:if>
                        </xsl:for-each>

                        <xsl:for-each
                            select="./kinderen">

                            <BG:inp.heeftAlsKinderen>
                                <xsl:choose>
                                    <xsl:when
                                        test="($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                        <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/@StUF:entiteittype" /></xsl:attribute>
                                    <xsl:attribute
                                            name="xsi:nil">true</xsl:attribute>
                                <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="./text() !=''">
                                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/@StUF:entiteittype" /></xsl:attribute>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde)">
                                                    <BG:gerelateerde>
                                                        <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/@StUF:entiteittype" />
                                                        </xsl:attribute>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.bsn)">
                                                            <BG:inp.bsn>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./burgerservicenummer/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./burgerservicenummer" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./burgerservicenummer/text() =''">
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:anp.identificatie)">
                                                                                    <BG:anp.identificatie>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:anp.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue">
                                                                                            <xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:anp.identificatie>
                                                                                </xsl:if>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:inp.bsn>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:authentiek)">
                                                            <BG:authentiek>J</BG:authentiek>
                                                        </xsl:if>

                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.typering)">
                                                            <BG:sub.typering>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.typering/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.typering>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.a-nummer)">
                                                            <BG:inp.a-nummer>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.a-nummer>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaam)">
                                                            <BG:geslachtsnaam>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./naam/geslachtsnaam/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./naam/geslachtsnaam" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./naam/geslachtsnaam/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:geslachtsnaam>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorletters)">
                                                            <BG:voorletters>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./naam/voorletters/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./naam/voorletters" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./naam/voorletters/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:voorletters>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamen)">
                                                            <BG:voornamen>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./naam/voornamen/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./naam/voornamen" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./naam/voornamen/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:voornamen>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaam)">
                                                            <BG:voorvoegselGeslachtsnaam>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./naam/voorvoegsel/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./naam/voorvoegsel" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./naam/voorvoegsel/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:voorvoegselGeslachtsnaam>
                                                        </xsl:if>
                                                        <!-- 
                                                        <BG:inOnderzoek>
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                                            <xsl:value-of
                                                                select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/burgerservicenummer" />
                                                        </BG:inOnderzoek> -->
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaamPartner)">
                                                            <BG:geslachtsnaamPartner>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:geslachtsnaamPartner>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner)">
                                                            <BG:voorvoegselGeslachtsnaamPartner>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue">
                                                                    <xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:voorvoegselGeslachtsnaamPartner>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:aanduidingNaamgebruik)">
                                                            <BG:aanduidingNaamgebruik>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./naam/aanduidingNaamgebruik/code/text() != ''">
                                                                                <xsl:value-of
                                                                                    select="./naam/aanduidingNaamgebruik/code" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./naam/aanduidingNaamgebruik/code/text() = ''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aanduidingNaamgebruik>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:aanhefAanschrijving)">
                                                            <BG:aanhefAanschrijving>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./adressering/aanhef/text() != ''">
                                                                                <xsl:value-of
                                                                                    select="./adressering/aanhef" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./adressering/aanhef/text() = ''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>

                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil">
                                                                            <xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:aanhefAanschrijving/@xsi:nil" />
                                                                        </xsl:attribute>
                                                                    <xsl:attribute
                                                                            name="StUF:noValue">
                                                                            <xsl:value-of
                                                                                select="$nietGeautoriseerd" />
                                                                        </xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:aanhefAanschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamenAanschrijving)">
                                                            <BG:voornamenAanschrijving>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$nietGeautoriseerd" /></xsl:attribute>
                                                            </BG:voornamenAanschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaamAanschrijving)">
                                                            <BG:geslachtsnaamAanschrijving>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$nietGeautoriseerd" /></xsl:attribute>
                                                            </BG:geslachtsnaamAanschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:adellijkeTitelPredikaat)">
                                                            <BG:adellijkeTitelPredikaat>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$nietGeautoriseerd" /></xsl:attribute>
                                                            </BG:adellijkeTitelPredikaat>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsaanduiding)">
                                                            <BG:geslachtsaanduiding>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./geslachtsaanduiding/text() !=''">
                                                                        <xsl:value-of
                                                                            select="./geslachtsaanduiding" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./geslachtsaanduiding/text() =''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:geslachtsaanduiding>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geboortedatum)">
                                                            <BG:geboortedatum>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./geboorte/datum/datum/text() !=''">
                                                                                <xsl:variable
                                                                                    name="date"
                                                                                    select="./geboorte/datum/datum" />
                                                                                <xsl:value-of
                                                                                    select="translate($date, '-', '')" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./geboorte/datum/datum/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:geboortedatum>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteLand)">
                                                            <BG:inp.geboorteLand>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./geboorte/land/code/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./geboorte/land/code" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./geboorte/land/code/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:inp.geboorteLand>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteplaats)">
                                                            <BG:inp.geboorteplaats>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="$varZenderApplicatie=&apos;TOP&apos;">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./geboorte/plaats/omschrijving/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./geboorte/plaats/omschrijving" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./geboorte/plaats/omschrijving/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:inp.geboorteplaats>
                                                        </xsl:if>
                                                        <!--
                                                        <BG:inOnderzoek>
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                                            <xsl:value-of
                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                                            <xsl:value-of
                                                                select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/burgerservicenummer" />
                                                        </BG:inOnderzoek> -->
                                                        <xsl:if
                                                            test="./verblijfplaats/type = &apos;Adres&apos;">
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres)">
                                                                <BG:verblijfsadres>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie)">
                                                                        <BG:aoa.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:authentiek)">
                                                                        <BG:authentiek>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:authentiek>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam)">
                                                                        <BG:wpl.woonplaatsNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:wpl.woonplaatsNaam>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam)">
                                                                        <BG:gor.openbareRuimteNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:gor.openbareRuimteNaam>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode)">
                                                                        <BG:aoa.postcode>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.postcode>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer)">
                                                                        <BG:aoa.huisnummer>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummer>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter)">
                                                                        <BG:aoa.huisletter>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisletter>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging)">
                                                                        <BG:aoa.huisnummertoevoeging>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummertoevoeging>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving)">
                                                                        <BG:inp.locatiebeschrijving>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:inp.locatiebeschrijving>
                                                                    </xsl:if>
                                                                </BG:verblijfsadres>
                                                            </xsl:if>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland)">
                                                            <BG:sub.verblijfBuitenland>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode)">
                                                                    <BG:lnd.landcode>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:lnd.landcode>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam)">
                                                                    <BG:lnd.landnaam>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:lnd.landnaam>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1)">
                                                                    <BG:sub.adresBuitenland1>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:sub.adresBuitenland1>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2)">
                                                                    <BG:sub.adresBuitenland2>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:sub.adresBuitenland2>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3)">
                                                                    <BG:sub.adresBuitenland3>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:sub.adresBuitenland3>
                                                                </xsl:if>
                                                            </BG:sub.verblijfBuitenland>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.adresHerkomst)">
                                                            <BG:inp.adresHerkomst>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.adresHerkomst/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.adresHerkomst>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn)">
                                                            <BG:inp.verblijftIn>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde)">
                                                                    <BG:gerelateerde>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie)">
                                                                            <BG:identificatie>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:identificatie>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek)">
                                                                            <BG:authentiek>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:authentiek>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering)">
                                                                            <BG:typering>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:typering>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp)">
                                                                            <BG:adresAanduidingGrp>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie)">
                                                                                    <BG:num.identificatie>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:num.identificatie>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie)">
                                                                                    <BG:oao.identificatie>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:oao.identificatie>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek)">
                                                                                    <BG:authentiek>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:authentiek>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam)">
                                                                                    <BG:wpl.woonplaatsNaam>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:wpl.woonplaatsNaam>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam)">
                                                                                    <BG:gor.openbareRuimteNaam>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:gor.openbareRuimteNaam>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode)">
                                                                                    <BG:aoa.postcode>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:aoa.postcode>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer)">
                                                                                    <BG:aoa.huisnummer>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:aoa.huisnummer>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter)">
                                                                                    <BG:aoa.huisletter>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:aoa.huisletter>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging)">
                                                                                    <BG:aoa.huisnummertoevoeging>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:aoa.huisnummertoevoeging>
                                                                                </xsl:if>
                                                                                <xsl:if
                                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding)">
                                                                                    <BG:ogo.locatieAanduiding>
                                                                                        <xsl:attribute
                                                                                            name="xsi:nil"><xsl:value-of
                                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding/@xsi:nil" /></xsl:attribute>
                                                                                        <xsl:attribute
                                                                                            name="StUF:noValue"><xsl:value-of
                                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                                    </BG:ogo.locatieAanduiding>
                                                                                </xsl:if>
                                                                            </BG:adresAanduidingGrp>
                                                                        </xsl:if>
                                                                    </BG:gerelateerde>
                                                                </xsl:if>
                                                            </BG:inp.verblijftIn>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres)">
                                                            <BG:sub.correspondentieAdres>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering)">
                                                                    <BG:typering>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:typering>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam)">
                                                                    <BG:wpl.woonplaatsNaam>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:wpl.woonplaatsNaam>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen)">
                                                                    <BG:aoa.woonplaatsWaarinGelegen>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie)">
                                                                            <BG:wpl.identificatie>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:wpl.identificatie>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam)">
                                                                            <BG:wpl.woonplaatsNaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:wpl.woonplaatsNaam>
                                                                        </xsl:if>
                                                                    </BG:aoa.woonplaatsWaarinGelegen>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode)">
                                                                    <BG:postcode>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:postcode>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie)">
                                                                    <BG:aoa.identificatie>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:aoa.identificatie>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek)">
                                                                    <BG:authentiek>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:authentiek>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie)">
                                                                    <BG:wpl.identificatie>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:wpl.identificatie>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie)">
                                                                    <BG:opr.identificatie>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:opr.identificatie>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam)">
                                                                    <BG:gor.openbareRuimteNaam>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:gor.openbareRuimteNaam>
                                                                </xsl:if>
                                                                <!-- <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam)">
                                                                    <BG:gor.straatnaam>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam/@xsi:nil"
                                                                /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:gor.straatnaam>
                                                                </xsl:if> -->
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer)">
                                                                    <BG:aoa.huisnummer>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:aoa.huisnummer>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter)">
                                                                    <BG:aoa.huisletter>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:aoa.huisletter>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging)">
                                                                    <BG:aoa.huisnummertoevoeging>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:aoa.huisnummertoevoeging>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType)">
                                                                    <BG:sub.postadresType>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:sub.postadresType>
                                                                </xsl:if>
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer)">
                                                                    <BG:sub.postadresNummer>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </BG:sub.postadresNummer>
                                                                </xsl:if>
                                                            </BG:sub.correspondentieAdres>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.burgerlijkeStaat)">
                                                            <BG:inp.burgerlijkeStaat>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.burgerlijkeStaat/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.burgerlijkeStaat>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.gemeenteVanInschrijving)">
                                                            <BG:inp.gemeenteVanInschrijving>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.gemeenteVanInschrijving/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.gemeenteVanInschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.datumInschrijving)">
                                                            <BG:inp.datumInschrijving>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.datumInschrijving/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.datumInschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:overlijdensdatum)">
                                                            <BG:overlijdensdatum>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./overlijden/datum/datum/text() != ''">
                                                                        <xsl:variable
                                                                            name="date"
                                                                            select="./overlijden/datum/datum" />
                                                                        <xsl:value-of
                                                                            select="translate($date, '-', '')" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./overlijden/datum/datum/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:overlijdensdatum>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.overlijdenplaats)">
                                                            <BG:inp.overlijdenplaats>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.overlijdenplaats>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.overlijdenLand)">
                                                            <BG:inp.overlijdenLand>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.overlijdenLand>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.immigratieLand)">
                                                            <BG:inp.immigratieLand>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.immigratieLand>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.emigratieLand)">
                                                            <BG:inp.emigratieLand>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.emigratieLand>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.telefoonnummer)">
                                                            <BG:sub.telefoonnummer>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.telefoonnummer/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.telefoonnummer>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.faxnummer)">
                                                            <BG:sub.faxnummer>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.faxnummer/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.faxnummer>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.emailadres)">
                                                            <BG:sub.emailadres>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.emailadres/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.emailadres>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.url)">
                                                            <BG:sub.url>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.url/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.url>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.rekeningnummerBankGiro)">
                                                            <BG:sub.rekeningnummerBankGiro>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:sub.rekeningnummerBankGiro/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:sub.rekeningnummerBankGiro>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:acd.code)">
                                                            <BG:acd.code>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:acd.code/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:acd.code>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.datumOpschortingBijhouding)">
                                                            <BG:inp.datumOpschortingBijhouding>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.datumOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.datumOpschortingBijhouding>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.redenOpschortingBijhouding)">
                                                            <BG:inp.redenOpschortingBijhouding>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.redenOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.redenOpschortingBijhouding>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel)">
                                                            <BG:vbt.aanduidingVerblijfstitel>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:vbt.aanduidingVerblijfstitel>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel)">
                                                            <BG:ing.datumVerkrijgingVerblijfstitel>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.datumVerkrijgingVerblijfstitel>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.datumVerliesVerblijfstitel)">
                                                            <BG:ing.datumVerliesVerblijfstitel>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.datumVerliesVerblijfstitel>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.signaleringReisdocument)">
                                                            <BG:inp.signaleringReisdocument>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.signaleringReisdocument/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.signaleringReisdocument>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap)">
                                                            <BG:inp.aanduidingBijzonderNederlanderschap>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.aanduidingBijzonderNederlanderschap>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.buitenlandsReisdocument)">
                                                            <BG:inp.buitenlandsReisdocument>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.buitenlandsReisdocument/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:inp.buitenlandsReisdocument>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht)">
                                                            <BG:ing.aanduidingEuropeesKiesrecht>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.aanduidingEuropeesKiesrecht>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht)">
                                                            <BG:ing.aanduidingUitgeslotenKiesrecht>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.aanduidingUitgeslotenKiesrecht>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige)">
                                                            <BG:ing.indicatieGezagMinderjarige>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="./gezagsverhouding/indicatieGezagMinderjarige/text() != ''">
                                                                        <xsl:value-of
                                                                            select="./gezagsverhouding/indicatieGezagMinderjarige" />
                                                                    </xsl:when>
                                                                    <xsl:when
                                                                        test="./gezagsverhouding/indicatieGezagMinderjarige/text() = ''">
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$geenWaarde" /></xsl:attribute>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:ing.indicatieGezagMinderjarige>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieCurateleRegister)">
                                                            <BG:ing.indicatieCurateleRegister>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieCurateleRegister/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.indicatieCurateleRegister>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieBlokkering)">
                                                            <BG:ing.indicatieBlokkering>
                                                                <xsl:attribute
                                                                    name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:ing.indicatieBlokkering/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:ing.indicatieBlokkering>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.indicatieGeheim)">
                                                            <BG:inp.indicatieGeheim>
                                                                <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;TOP&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./geheimhoudingPersoonsgegevens/text() !=''">
                                                                                <xsl:value-of
                                                                                    select="./geheimhoudingPersoonsgegevens" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./geheimhoudingPersoonsgegevens/text() =''">
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:attribute
                                                                            name="xsi:nil"><xsl:value-of
                                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                            name="StUF:noValue"><xsl:value-of
                                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </BG:inp.indicatieGeheim>
                                                        </xsl:if>
                                                    </BG:gerelateerde>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:ouderAanduiding)">
                                                    <BG:ouderAanduiding>
                                                        <xsl:attribute
                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:ouderAanduiding/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </BG:ouderAanduiding>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:datumIngangFamilierechtelijkeBetrekking)">
                                                    <BG:datumIngangFamilierechtelijkeBetrekking>
                                                        <xsl:attribute
                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:datumIngangFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </BG:datumIngangFamilierechtelijkeBetrekking>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:datumEindeFamilierechtelijkeBetrekking)">
                                                    <BG:datumEindeFamilierechtelijkeBetrekking>
                                                        <xsl:attribute
                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:datumEindeFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </BG:datumEindeFamilierechtelijkeBetrekking>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:inOnderzoek)">
                                                    <BG:inOnderzoek>
                                                        <xsl:attribute
                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:inOnderzoek/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </BG:inOnderzoek>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:aanduidingStrijdigheidNietigheid)">
                                                    <BG:aanduidingStrijdigheidNietigheid>
                                                        <xsl:attribute
                                                            name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:aanduidingStrijdigheidNietigheid/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </BG:aanduidingStrijdigheidNietigheid>
                                                </xsl:if>
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument)">
                                                    <BG:brondocument>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:identificatie)">
                                                            <BG:identificatie>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:identificatie/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:identificatie>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:datum)">
                                                            <BG:datum>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:datum/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:datum>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:omschrijving)">
                                                            <BG:omschrijving>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:omschrijving>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:gemeente)">
                                                            <BG:gemeente>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:gemeente/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:gemeente>
                                                        </xsl:if>
                                                        <xsl:if
                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:aktegemeente)">
                                                            <BG:aktegemeente>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/BG:brondocument/BG:aktegemeente/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </BG:aktegemeente>
                                                        </xsl:if>
                                                    </BG:brondocument>
                                                </xsl:if>
                                                <!-- <StUF:tijdvakGeldigheid>
                                                    <StUF:beginGeldigheid></StUF:beginGeldigheid>
                                                    <StUF:eindGeldigheid></StUF:eindGeldigheid>
                                                </StUF:tijdvakGeldigheid> -->
                                            <xsl:if
                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/StUF:tijdstipRegistratie)">
                                                    <StUF:tijdstipRegistratie>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                                        <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$waardeOnbekend" /></xsl:attribute>
                                                    </StUF:tijdstipRegistratie>
                                                </xsl:if>

                                            </xsl:when>
                                            <xsl:when
                                                test="./text()=''">
                                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/@StUF:entiteittype" /></xsl:attribute>
                                            <xsl:attribute
                                                    name="xsi:nil">true</xsl:attribute>
                                            <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsKinderen/@StUF:entiteittype" /></xsl:attribute>
                                            <xsl:attribute
                                                    name="xsi:nil">true</xsl:attribute>
                                            <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </BG:inp.heeftAlsKinderen>
                        </xsl:for-each>

                        <xsl:for-each
                            select="./ouders">
                            <xsl:if
                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders)">
                                <BG:inp.heeftAlsOuders>
                                    <xsl:choose>
                                        <xsl:when
                                            test="($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                            <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/@StUF:entiteittype" /></xsl:attribute>
                                        <xsl:attribute
                                                name="xsi:nil">true</xsl:attribute>
                                    <xsl:attribute
                                                name="StUF:noValue"><xsl:value-of
                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:choose>
                                                <xsl:when test="./text() !=''">
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/@StUF:entiteittype" /></xsl:attribute>
                
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde)">
                                                        <BG:gerelateerde>
                                                            <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                                    select="$varEntiteittype" />
                                                            </xsl:attribute>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.bsn)">
                                                                <BG:inp.bsn>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./burgerservicenummer/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./burgerservicenummer" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./burgerservicenummer/text() =''">
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:anp.identificatie)">
                                                                                <BG:anp.identificatie>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:anp.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue">
                                                                                        <xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:anp.identificatie>
                                                                            </xsl:if>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.bsn/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.bsn>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:authentiek)">
                                                                <BG:authentiek>J</BG:authentiek>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.typering)">
                                                                <BG:sub.typering>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.typering/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.typering>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.a-nummer)">
                                                                <BG:inp.a-nummer>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./aNummer/text() != ''">
                                                                                    <xsl:value-of
                                                                                        select="./aNummer" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./aNummer/text() = ''">
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.a-nummer/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.a-nummer>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaam)">
                                                                <BG:geslachtsnaam>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/geslachtsnaam/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/geslachtsnaam" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/geslachtsnaam/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geslachtsnaam>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorvoegselGeslachtsnaam)">
                                                                <BG:voorvoegselGeslachtsnaam>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voorvoegsel/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voorvoegsel" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voorvoegsel/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorvoegselGeslachtsnaam/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voorvoegselGeslachtsnaam>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorletters)">
                                                                <BG:voorletters>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voorletters/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voorletters" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voorletters/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorletters/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voorletters>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voornamen)">
                                                                <BG:voornamen>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./naam/voornamen/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./naam/voornamen" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/voornamen/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voornamen/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                                name="StUF:noValue">
                                                                                <xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:voornamen>
                                                            </xsl:if>


                                                            <!-- <BG:inOnderzoek>
                                                                <geslachtsnaam>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsnaam" />
                                                                </geslachtsnaam>
                                                                <voornamen>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voornamen" />
                                                                </voornamen>
                                                                <voorvoegsel>
                                                                    <xsl:value-of
                                                                        select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voorvoegsel" />
                                                                </voorvoegsel>
                                                                <burgerservicenummer>
                                                                    <xsl:value-of
                                                                        select="./inOnderzoek[/naam = Persoonsgegevens/naam]/burgerservicenummer" />
                                                                </burgerservicenummer>
                                                            </BG:inOnderzoek> -->
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:aanduidingNaamgebruik)">
                                                                <BG:aanduidingNaamgebruik>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:aanduidingNaamgebruik/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:aanduidingNaamgebruik>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaamPartner)">
                                                                <BG:geslachtsnaamPartner>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:geslachtsnaamPartner>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner)">
                                                                <BG:voorvoegselGeslachtsnaamPartner>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voorvoegselGeslachtsnaamPartner/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:voorvoegselGeslachtsnaamPartner>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:aanhefAanschrijving)">
                                                                <BG:aanhefAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:aanhefAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:aanhefAanschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voornamenAanschrijving)">
                                                                <BG:voornamenAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:voornamenAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:voornamenAanschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaamAanschrijving)">
                                                                <BG:geslachtsnaamAanschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsnaamAanschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue">
                                                                        <xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:geslachtsnaamAanschrijving>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:adellijkeTitelPredikaat)">
                                                                <BG:adellijkeTitelPredikaat>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;TOP&apos;) or ($varZenderApplicatie=&apos;GWS&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;) or ($varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;)">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/adellijkeTitelPredicaat/code/text() != ''">
                                                                            <xsl:value-of
                                                                                select="./naam/adellijkeTitelPredicaat/code" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./naam/adellijkeTitelPredicaat/code/text() = ''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:adellijkeTitelPredikaat/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:adellijkeTitelPredikaat>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsaanduiding)">
                                                                <BG:geslachtsaanduiding>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geslachtsaanduiding/text() !=''">
                                                                            <xsl:value-of
                                                                                select="./geslachtsaanduiding" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geslachtsaanduiding/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geslachtsaanduiding/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geslachtsaanduiding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geboortedatum)">
                                                                <BG:geboortedatum>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./geboorte/datum/datum/text() !=''">
                                                                            <xsl:variable
                                                                                name="date"
                                                                                select="./geboorte/datum/datum" />
                                                                        <xsl:value-of
                                                                                select="translate($date, '-', '')" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./geboorte/datum/datum/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:geboortedatum/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:geboortedatum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteplaats)">
                                                                <BG:inp.geboorteplaats>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;GWS&apos;)">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./geboorte/plaats/omschrijving/text() !=''">
                                                                                    <xsl:value-of
                                                                                        select="./geboorte/plaats/omschrijving" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./geboorte/plaats/omschrijving/text() =''">
                                                                                    <xsl:value-of
                                                                                        select="./geboorte/plaats/omschrijving" />
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteplaats/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.geboorteplaats>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteLand)">
                                                                <BG:inp.geboorteLand>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;GWS&apos;)">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./geboorte/land/code/text() !=''">
                                                                                    <xsl:value-of
                                                                                        select="./geboorte/land/code" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./geboorte/land/code/text() =''">
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.geboorteLand/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.geboorteLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:overlijdensdatum)">
                                                                <BG:overlijdensdatum>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./overlijden/datum/datum/text() != ''">
                                                                            <xsl:variable
                                                                                name="date"
                                                                                select="./overlijden/datum/datum" />
                                                                        <xsl:value-of
                                                                                select="translate($date, '-', '')" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./overlijden/datum/datum/text() = ''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:overlijdensdatum/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:overlijdensdatum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.overlijdenplaats)">
                                                                <BG:inp.overlijdenplaats>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.overlijdenplaats/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.overlijdenplaats>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.overlijdenLand)">
                                                                <BG:inp.overlijdenLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.overlijdenLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.overlijdenLand>
                                                            </xsl:if>

                                                            <!-- <BG:inOnderzoek>
                                                                    <geboorte>
                                                                        <datum>
                                                                            <xsl:value-of
                                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                                                        </datum>
                                                                        <land>
                                                                            <xsl:value-of
                                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                                                        </land>
                                                                        <plaats>
                                                                            <xsl:value-of
                                                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                                                        </plaats>
                                                                    </geboorte>
                                                                </BG:inOnderzoek> -->
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn)">
                                                                <BG:inp.verblijftIn>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde)">
                                                                        <BG:gerelateerde>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie)">
                                                                                <BG:identificatie>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:identificatie/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:identificatie>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek)">
                                                                                <BG:authentiek>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:authentiek>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering)">
                                                                                <BG:typering>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:typering>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp)">
                                                                                <BG:adresAanduidingGrp>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie)">
                                                                                        <BG:num.identificatie>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:num.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:num.identificatie>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie)">
                                                                                        <BG:oao.identificatie>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:oao.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:oao.identificatie>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek)">
                                                                                        <BG:authentiek>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:authentiek>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam)">
                                                                                        <BG:wpl.woonplaatsNaam>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:wpl.woonplaatsNaam>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam)">
                                                                                        <BG:gor.openbareRuimteNaam>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:gor.openbareRuimteNaam>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode)">
                                                                                        <BG:aoa.postcode>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.postcode>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer)">
                                                                                        <BG:aoa.huisnummer>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisnummer>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter)">
                                                                                        <BG:aoa.huisletter>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisletter>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging)">
                                                                                        <BG:aoa.huisnummertoevoeging>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:aoa.huisnummertoevoeging>
                                                                                    </xsl:if>
                                                                                    <xsl:if
                                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding)">
                                                                                        <BG:ogo.locatieAanduiding>
                                                                                            <xsl:attribute
                                                                                                name="xsi:nil"><xsl:value-of
                                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.verblijftIn/BG:gerelateerde/BG:adresAanduidingGrp/BG:ogo.locatieAanduiding/@xsi:nil" /></xsl:attribute>
                                                                                            <xsl:attribute
                                                                                                name="StUF:noValue"><xsl:value-of
                                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                                        </BG:ogo.locatieAanduiding>
                                                                                    </xsl:if>
                                                                                </BG:adresAanduidingGrp>
                                                                            </xsl:if>
                                                                        </BG:gerelateerde>
                                                                    </xsl:if>
                                                                </BG:inp.verblijftIn>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="./verblijfplaats/type = &apos;Adres&apos;">
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres)">
                                                                    <BG:verblijfsadres>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie)">
                                                                            <BG:aoa.identificatie>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.identificatie>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:authentiek)">
                                                                            <BG:authentiek>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:authentiek>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam)">
                                                                            <BG:wpl.woonplaatsNaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:wpl.woonplaatsNaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam)">
                                                                            <BG:gor.openbareRuimteNaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:gor.openbareRuimteNaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode)">
                                                                            <BG:aoa.postcode>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.postcode/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.postcode>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer)">
                                                                            <BG:aoa.huisnummer>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisnummer>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter)">
                                                                            <BG:aoa.huisletter>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisletter>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging)">
                                                                            <BG:aoa.huisnummertoevoeging>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:aoa.huisnummertoevoeging>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving)">
                                                                            <BG:inp.locatiebeschrijving>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:verblijfsadres/BG:inp.locatiebeschrijving/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:inp.locatiebeschrijving>
                                                                        </xsl:if>
                                                                    </BG:verblijfsadres>
                                                                </xsl:if>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="./verblijfplaats/type = &apos;VerblijfplaatsBuitenland&apos;">
                                                                <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland)">
                                                                    <BG:sub.verblijfBuitenland>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode)">
                                                                            <BG:lnd.landcode>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landcode/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:lnd.landcode>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam)">
                                                                            <BG:lnd.landnaam>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:lnd.landnaam/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:lnd.landnaam>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1)">
                                                                            <BG:sub.adresBuitenland1>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland1/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland1>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2)">
                                                                            <BG:sub.adresBuitenland2>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland2/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland2>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3)">
                                                                            <BG:sub.adresBuitenland3>
                                                                                <xsl:attribute
                                                                                    name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.verblijfBuitenland/BG:sub.adresBuitenland3/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                                            </BG:sub.adresBuitenland3>
                                                                        </xsl:if>
                                                                    </BG:sub.verblijfBuitenland>
                                                                </xsl:if>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.adresHerkomst)">
                                                                <BG:inp.adresHerkomst>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.adresHerkomst/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.adresHerkomst>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres)">
                                                                <BG:sub.correspondentieAdres>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering)">
                                                                        <BG:typering>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:typering/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:typering>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam)">
                                                                        <BG:wpl.woonplaatsNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:wpl.woonplaatsNaam>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen)">
                                                                        <BG:aoa.woonplaatsWaarinGelegen>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie)">
                                                                                <BG:wpl.identificatie>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:wpl.identificatie>
                                                                            </xsl:if>
                                                                            <xsl:if
                                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam)">
                                                                                <BG:wpl.woonplaatsNaam>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.woonplaatsWaarinGelegen/BG:wpl.woonplaatsNaam/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </BG:wpl.woonplaatsNaam>
                                                                            </xsl:if>
                                                                        </BG:aoa.woonplaatsWaarinGelegen>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode)">
                                                                        <BG:postcode>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:postcode/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:postcode>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie)">
                                                                        <BG:aoa.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek)">
                                                                        <BG:authentiek>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:authentiek/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:authentiek>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie)">
                                                                        <BG:wpl.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:wpl.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:wpl.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie)">
                                                                        <BG:opr.identificatie>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:opr.identificatie/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:opr.identificatie>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam)">
                                                                        <BG:gor.openbareRuimteNaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.openbareRuimteNaam/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:gor.openbareRuimteNaam>
                                                                    </xsl:if>
                                                                    <!-- <xsl:if
                                                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam)">
                                                                        <BG:gor.straatnaam>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:gor.straatnaam/@xsi:nil"
                                                                    /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:gor.straatnaam>
                                                                    </xsl:if> -->
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer)">
                                                                        <BG:aoa.huisnummer>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummer/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummer>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter)">
                                                                        <BG:aoa.huisletter>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisletter/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisletter>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging)">
                                                                        <BG:aoa.huisnummertoevoeging>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:aoa.huisnummertoevoeging/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:aoa.huisnummertoevoeging>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType)">
                                                                        <BG:sub.postadresType>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresType/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:sub.postadresType>
                                                                    </xsl:if>
                                                                    <xsl:if
                                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer)">
                                                                        <BG:sub.postadresNummer>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.correspondentieAdres/BG:sub.postadresNummer/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </BG:sub.postadresNummer>
                                                                    </xsl:if>
                                                                </BG:sub.correspondentieAdres>
                                                            </xsl:if>

                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.telefoonnummer)">
                                                                <BG:sub.telefoonnummer>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.telefoonnummer/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.telefoonnummer>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.faxnummer)">
                                                                <BG:sub.faxnummer>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.faxnummer/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.faxnummer>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.emailadres)">
                                                                <BG:sub.emailadres>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.emailadres/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.emailadres>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.url)">
                                                                <BG:sub.url>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.url/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.url>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.rekeningnummerBankGiro)">
                                                                <BG:sub.rekeningnummerBankGiro>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:sub.rekeningnummerBankGiro/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:sub.rekeningnummerBankGiro>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:acd.code)">
                                                                <BG:acd.code>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:acd.code/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:acd.code>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.burgerlijkeStaat)">
                                                                <BG:inp.burgerlijkeStaat>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.burgerlijkeStaat/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.burgerlijkeStaat>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.gemeenteVanInschrijving)">
                                                                <BG:inp.gemeenteVanInschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.gemeenteVanInschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.gemeenteVanInschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumInschrijving)">
                                                                <BG:inp.datumInschrijving>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumInschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.datumInschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel)">
                                                                <BG:vbt.aanduidingVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:vbt.aanduidingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:vbt.aanduidingVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel)">
                                                                <BG:ing.datumVerkrijgingVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.datumVerkrijgingVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.datumVerkrijgingVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.datumVerliesVerblijfstitel)">
                                                                <BG:ing.datumVerliesVerblijfstitel>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumVerliesVerblijfstitel/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.datumVerliesVerblijfstitel>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumVestigingInNederland)">
                                                                <BG:inp.datumVestigingInNederland>
                                                                    <!-- <xsl:choose>
                                                                    <xsl:when
                                                                        test="($varZenderApplicatie=&apos;LBA&apos;) or ($varZenderApplicatie=&apos;DEC_ZKN&apos;)">
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="./immigratie/datumVestigingInNederland/datum/text() != ''">
                                                                                <xsl:variable name="date"
                                                                                    select="./immigratie/datumVestigingInNederland/datum" />
                                                                                <xsl:value-of
                                                                                    select="translate($date, '-', '')" />
                                                                            </xsl:when>
                                                                            <xsl:when
                                                                                test="./immigratie/datumVestigingInNederland/datum/text() = ''">
                                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil"
                                                                                                    /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                    name="StUF:noValue"><xsl:value-of
                                                                                        select="$geenWaarde" /></xsl:attribute>
                                                                            </xsl:when>
                                                                            <xsl:otherwise> -->
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                    <!-- </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVestigingInNederland/@xsi:nil"
                                                                                                /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose> -->
                                                                </BG:inp.datumVestigingInNederland>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.immigratieLand)">
                                                                <BG:inp.immigratieLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.immigratieLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.immigratieLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland)">
                                                                <BG:inp.datumVertrekUitNederland>
                                                                    <!-- <xsl:choose>
                                                                        <xsl:when test="($varZenderApplicatie=&apos;LBA&apos;)">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./immigratie/indicatieVestigingVanuitBuitenland/datum/text() != ''">
                                                                                    <xsl:variable name="date"
                                                                                        select="./immigratie/indicatieVestigingVanuitBuitenland/datum" />
                                                                                    <xsl:value-of
                                                                                        select="translate($date, '-', '')" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./immigratie/indicatieVestigingVanuitBuitenland/datum/text() = ''">
                                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil"
                                                                                    /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise> -->
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                    <!-- </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.datumVertrekUitNederland/@xsi:nil"
                                                                    /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose> -->
                                                                </BG:inp.datumVertrekUitNederland>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.emigratieLand)">
                                                                <BG:inp.emigratieLand>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.emigratieLand/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.emigratieLand>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.signaleringReisdocument)">
                                                                <BG:inp.signaleringReisdocument>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.signaleringReisdocument/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.signaleringReisdocument>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap)">
                                                                <BG:inp.aanduidingBijzonderNederlanderschap>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.aanduidingBijzonderNederlanderschap/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.aanduidingBijzonderNederlanderschap>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.buitenlandsReisdocument)">
                                                                <BG:inp.buitenlandsReisdocument>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.buitenlandsReisdocument/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.buitenlandsReisdocument>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht)">
                                                                <BG:ing.aanduidingEuropeesKiesrecht>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.aanduidingEuropeesKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.aanduidingEuropeesKiesrecht>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht)">
                                                                <BG:ing.aanduidingUitgeslotenKiesrecht>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.aanduidingUitgeslotenKiesrecht/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.aanduidingUitgeslotenKiesrecht>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige)">
                                                                <BG:ing.indicatieGezagMinderjarige>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./gezagsverhouding/indicatieGezagMinderjarige/text() != ''">
                                                                            <xsl:value-of
                                                                                select="./gezagsverhouding/indicatieGezagMinderjarige" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./gezagsverhouding/indicatieGezagMinderjarige/text() = ''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.indicatieGezagMinderjarige/@xsi:nil" /></xsl:attribute>
                                                                                    <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:ing.indicatieGezagMinderjarige>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.indicatieCurateleRegister)">
                                                                <BG:ing.indicatieCurateleRegister>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:ing.indicatieCurateleRegister/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:ing.indicatieCurateleRegister>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumOpschortingBijhouding)">
                                                                <BG:inp.datumOpschortingBijhouding>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.datumOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.datumOpschortingBijhouding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.redenOpschortingBijhouding)">
                                                                <BG:inp.redenOpschortingBijhouding>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.redenOpschortingBijhouding/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:inp.redenOpschortingBijhouding>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.indicatieGeheim)">
                                                                <BG:inp.indicatieGeheim>
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="($varZenderApplicatie=&apos;TOP&apos;)">
                                                                            <xsl:choose>
                                                                                <xsl:when
                                                                                    test="./geheimhoudingPersoonsgegevens/text() !=''">
                                                                                    <xsl:value-of
                                                                                        select="./geheimhoudingPersoonsgegevens" />
                                                                                </xsl:when>
                                                                                <xsl:when
                                                                                    test="./geheimhoudingPersoonsgegevens/text() =''">
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:attribute
                                                                                        name="xsi:nil"><xsl:value-of
                                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                                <xsl:attribute
                                                                                        name="StUF:noValue"><xsl:value-of
                                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:gerelateerde/BG:inp.indicatieGeheim/@xsi:nil" /></xsl:attribute>
                                                                        <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$nietGeautoriseerd" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </BG:inp.indicatieGeheim>
                                                            </xsl:if>
                                                        </BG:gerelateerde>
                                                    </xsl:if>
                                                    <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:ouderAanduiding)">
                                                        <BG:ouderAanduiding>
                                                            <xsl:choose>
                                                                <xsl:when
                                                                    test="./ouderAanduiding/text() !=''">
                                                                    <xsl:value-of
                                                                        select="concat('Ouder',./ouderAanduiding)" />
                                                                </xsl:when>
                                                                <xsl:when
                                                                    test="./ouderAanduiding/text() =''">
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:ouderAanduiding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$geenWaarde" /></xsl:attribute>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute
                                                                        name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:ouderAanduiding/@xsi:nil" /></xsl:attribute>
                                                                <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </BG:ouderAanduiding>
                                                    </xsl:if>
                                                    <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:datumIngangFamilierechtelijkeBetrekking)">
                                                        <StUF:datumIngangFamilierechtelijkeBetrekking>
                                                            <xsl:choose>
                                                                <xsl:when
                                                                    test="($varZenderApplicatie=&apos;GWS&apos;)">
                                                                    <xsl:choose>
                                                                        <xsl:when
                                                                            test="./datumIngangFamilierechtelijkeBetrekking/datum/text() !=''">
                                                                            <xsl:variable
                                                                                name="date"
                                                                                select="./datumIngangFamilierechtelijkeBetrekking/datum" />
                                                                    <xsl:value-of
                                                                                select="translate($date, '-', '')" />
                                                                        </xsl:when>
                                                                        <xsl:when
                                                                            test="./datumIngangFamilierechtelijkeBetrekking/datum/text() =''">
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:datumIngangFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$geenWaarde" /></xsl:attribute>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:attribute
                                                                                name="xsi:nil"><xsl:value-of
                                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:datumIngangFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                                            <xsl:attribute
                                                                                name="StUF:noValue"><xsl:value-of
                                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:datumIngangFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$nietGeautoriseerd" /></xsl:attribute>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </StUF:datumIngangFamilierechtelijkeBetrekking>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:datumEindeFamilierechtelijkeBetrekking)">
                                                        <BG:datumEindeFamilierechtelijkeBetrekking>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:datumEindeFamilierechtelijkeBetrekking/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:datumEindeFamilierechtelijkeBetrekking>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:inOnderzoek)">
                                                        <BG:inOnderzoek>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:inOnderzoek/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:inOnderzoek>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:aanduidingStrijdigheidNietigheid)">
                                                        <BG:aanduidingStrijdigheidNietigheid>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:aanduidingStrijdigheidNietigheid/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </BG:aanduidingStrijdigheidNietigheid>
                                                    </xsl:if>
                                                <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument)">
                                                        <BG:brondocument>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:identificatie)">
                                                                <BG:identificatie>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:identificatie/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:identificatie>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:datum)">
                                                                <BG:datum>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:datum/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:datum>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:omschrijving)">
                                                                <BG:omschrijving>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:omschrijving>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:gemeente)">
                                                                <BG:gemeente>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:gemeente/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:gemeente>
                                                            </xsl:if>
                                                            <xsl:if
                                                                test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:aktegemeente)">
                                                                <BG:aktegemeente>
                                                                    <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/BG:brondocument/BG:aktegemeente/@xsi:nil" /></xsl:attribute>
                                                                    <xsl:attribute
                                                                        name="StUF:noValue"><xsl:value-of
                                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                                </BG:aktegemeente>
                                                            </xsl:if>
                                                        </BG:brondocument>
                                                    </xsl:if>
                                                    <xsl:if
                                                        test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:tijdstipRegistratie)">
                                                        <StUF:tijdstipRegistratie>
                                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                name="StUF:noValue"><xsl:value-of
                                                                    select="$waardeOnbekend" /></xsl:attribute>
                                                        </StUF:tijdstipRegistratie>
                                                    </xsl:if>
                                                </xsl:when>
                                                <xsl:when test="./text()=''">
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/@StUF:entiteittype" /></xsl:attribute>
                                                    <xsl:attribute
                                                        name="xsi:nil">true</xsl:attribute>
                                                    <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$geenWaarde" /></xsl:attribute>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                            select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsOuders/@StUF:entiteittype" /></xsl:attribute>
                                                    <xsl:attribute
                                                        name="xsi:nil">true</xsl:attribute>
                                                    <xsl:attribute
                                                        name="StUF:noValue"><xsl:value-of
                                                            select="$waardeOnbekend" /></xsl:attribute>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </BG:inp.heeftAlsOuders>
                            </xsl:if>

                        </xsl:for-each>


                        <!-- <BG:inOnderzoek>
                                    <geboorte>
                                        <datum>
                                            <xsl:value-of
                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                        </datum>
                                        <land>
                                            <xsl:value-of
                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                        </land>
                                        <plaats>
                                            <xsl:value-of
                                                select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                        </plaats>
                                    </geboorte>
                                </BG:inOnderzoek> -->

                        <!-- <BG:inOnderzoek>
                                <xsl:value-of
                                    select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsaanduiding" />
                            </BG:inOnderzoek> -->
                        <xsl:if
                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit)">
                            <BG:inp.heeftAlsNationaliteit>
                                <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/@StUF:entiteittype" /></xsl:attribute>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde)">
                                    <BG:gerelateerde>
                                        <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/@StUF:entiteittype" /></xsl:attribute>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:code)">
                                            <BG:code>
                                                <xsl:choose>
                                                    <xsl:when
                                                        test="($varZenderApplicatie = &apos;GWS&apos;) or ($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)">
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="./nationaliteit/nationaliteit/code/text()!=''">
                                                                <xsl:value-of
                                                                    select="./nationaliteit/nationaliteit/code" />
                                                            </xsl:when>
                                                            <xsl:when
                                                                test="./nationaliteit/nationaliteit/code/text()=''">
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:code/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$geenWaarde" /></xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:code/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:code/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </BG:code>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:omschrijving)">
                                            <BG:omschrijving>
                                                <xsl:choose>
                                                    <xsl:when
                                                        test="($varZenderApplicatie = &apos;LBA&apos;) or ($varZenderApplicatie = &apos;TOP&apos;)">
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="./nationaliteit/nationaliteit/omschrijving/text()!=''">
                                                                <xsl:value-of
                                                                    select="./nationaliteit/nationaliteit/omschrijving" />
                                                            </xsl:when>
                                                            <xsl:when
                                                                test="./nationaliteit/nationaliteit/omschrijving/text()=''">
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$geenWaarde" /></xsl:attribute>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                            <xsl:attribute
                                                                    name="StUF:noValue"><xsl:value-of
                                                                        select="$waardeOnbekend" /></xsl:attribute>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:gerelateerde/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                    <xsl:attribute
                                                            name="StUF:noValue"><xsl:value-of
                                                                select="$nietGeautoriseerd" /></xsl:attribute>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </BG:omschrijving>
                                        </xsl:if>
                                    </BG:gerelateerde>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.redenVerkrijging)">
                                    <BG:inp.redenVerkrijging>
                                        <xsl:choose>
                                            <xsl:when
                                                test="./nationaliteit/redenOpname/code/text() != ''">
                                                <xsl:value-of
                                                    select="./nationaliteit/redenOpname/code" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./nationaliteit/redenOpname/code/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.redenVerkrijging/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.redenVerkrijging/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </BG:inp.redenVerkrijging>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.datumVerkrijging)">
                                    <BG:inp.datumVerkrijging>
                                        <xsl:choose>
                                            <xsl:when
                                                test="./nationaliteit/datumIngangGeldigheid/datum/text() != ''">
                                                <xsl:variable name="date"
                                                    select="./nationaliteit/datumIngangGeldigheid/datum" />
                                                <xsl:value-of
                                                    select="translate($date, '-', '')" />
                                            </xsl:when>
                                            <xsl:when
                                                test="./nationaliteit/datumIngangGeldigheid/datum/text() = ''">
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.datumVerkrijging/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$geenWaarde" /></xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.datumVerkrijging/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </BG:inp.datumVerkrijging>
                                </xsl:if>

                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.redenVerlies)">
                                    <BG:inp.redenVerlies>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.redenVerlies/@xsi:nil" /></xsl:attribute>
                                    </BG:inp.redenVerlies>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.datumVerlies)">
                                    <BG:inp.datumVerlies>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inp.datumVerlies/@xsi:nil" /></xsl:attribute>
                                    </BG:inp.datumVerlies>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inOnderzoek)">
                                    <BG:inOnderzoek>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:inOnderzoek/@xsi:nil" /></xsl:attribute>
                                    </BG:inOnderzoek>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:aanduidingStrijdigheidNietigheid)">
                                    <BG:aanduidingStrijdigheidNietigheid>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:aanduidingStrijdigheidNietigheid/@xsi:nil" /></xsl:attribute>
                                    </BG:aanduidingStrijdigheidNietigheid>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument)">
                                    <BG:brondocument>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:datum)">
                                            <BG:datum>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:datum/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </BG:datum>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:omschrijving)">
                                            <BG:omschrijving>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:omschrijving/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </BG:omschrijving>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:gemeente)">
                                            <BG:gemeente>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/BG:brondocument/BG:gemeente/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </BG:gemeente>
                                        </xsl:if>
                                    </BG:brondocument>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakRelatie)">
                                    <StUF:tijdvakRelatie>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakRelatie/StUF:beginRelatie)">
                                            <StUF:beginRelatie>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakRelatie/StUF:beginRelatie/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </StUF:beginRelatie>
                                        </xsl:if>
                                        <xsl:if
                                            test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakRelatie/StUF:eindRelatie)">
                                            <StUF:eindRelatie>
                                                <xsl:attribute name="xsi:nil"><xsl:value-of
                                                        select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakRelatie/StUF:eindRelatie/@xsi:nil" /></xsl:attribute>
                                                <xsl:attribute
                                                    name="StUF:noValue"><xsl:value-of
                                                        select="$waardeOnbekend" /></xsl:attribute>
                                            </StUF:eindRelatie>
                                        </xsl:if>
                                    </StUF:tijdvakRelatie>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakGeldigheid)">
                                    <StUF:tijdvakGeldigheid>
                                        <StUF:beginGeldigheid>
                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakGeldigheid/StUF:beginGeldigheid/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                                name="StUF:noValue"><xsl:value-of
                                                    select="$waardeOnbekend" /></xsl:attribute>
                                        </StUF:beginGeldigheid>
                                        <StUF:eindGeldigheid>
                                            <xsl:attribute name="xsi:nil"><xsl:value-of
                                                    select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdvakGeldigheid/StUF:eindGeldigheid/@xsi:nil" /></xsl:attribute>
                                            <xsl:attribute
                                                name="StUF:noValue"><xsl:value-of
                                                    select="$waardeOnbekend" /></xsl:attribute>
                                        </StUF:eindGeldigheid>
                                    </StUF:tijdvakGeldigheid>
                                </xsl:if>
                                <xsl:if
                                    test="exists($originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdstipRegistratie)">
                                    <StUF:tijdstipRegistratie>
                                        <xsl:attribute name="xsi:nil"><xsl:value-of
                                                select="$originalMessage//BG:npsLv01/BG:scope/BG:object/BG:inp.heeftAlsNationaliteit/StUF:tijdstipRegistratie/@xsi:nil" /></xsl:attribute>
                                        <xsl:attribute
                                            name="StUF:noValue"><xsl:value-of
                                                select="$waardeOnbekend" /></xsl:attribute>
                                    </StUF:tijdstipRegistratie>
                                </xsl:if>
                            </BG:inp.heeftAlsNationaliteit>
                        </xsl:if>
                    </BG:object>
                </xsl:for-each>
            </BG:antwoord>
        </BG:npsLa01>
    </xsl:template>
</xsl:stylesheet>