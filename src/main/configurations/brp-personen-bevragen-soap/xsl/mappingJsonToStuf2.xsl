<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
                xmlns:str="http://exslt.org/strings"
                xmlns:w="http://schemas.xmlsoap.org/wsdl/"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="berichtcode" />
    <xsl:param name="varZenderApplicatie">GWS</xsl:param>
    <xsl:param name="varZenderOrganisatie" />
    <xsl:param name="administratie" />
    <xsl:param name="varZenderGebruiker" />
    <xsl:param name="varOntvangerApplicatie" />
    <xsl:param name="varOntvangerOrganisatie" />
    <xsl:param name="varOntvangerAdministratie" />
    <xsl:param name="varReferentienummer" />
    <xsl:param name="varOntvangerGebruiker" />
    <xsl:param name="varEntiteittype" />
    <xsl:param name="tijdstipBericht" />
    <xsl:param name="indicatorVervolgvraag" />
    <xsl:param name="soapMessage" as="node()?" >
        <soapenv:Envelope xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
                          xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310"
                          xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                          xmlns:xlink="http://www.w3.org/1999/xlink">
            <soapenv:Header />
            <soapenv:Body>
                <BG:npsLv01 xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                    <BG:stuurgegevens>
                        <StUF:berichtcode>Lv01</StUF:berichtcode>
                        <StUF:zender>
                            <StUF:organisatie>0518</StUF:organisatie>
                            <StUF:applicatie>LBA</StUF:applicatie>
                        </StUF:zender>
                        <StUF:ontvanger>
                            <StUF:organisatie>test1</StUF:organisatie>
                            <StUF:applicatie>test123</StUF:applicatie>
                        </StUF:ontvanger>
                        <StUF:referentienummer>af20ca23-3955-4406-89d2-3048f0017564</StUF:referentienummer>
                        <StUF:tijdstipBericht>20241014193050762</StUF:tijdstipBericht>
                        <StUF:entiteittype>NPS</StUF:entiteittype>
                    </BG:stuurgegevens>
                    <BG:parameters>
                        <StUF:sortering>1</StUF:sortering>
                        <StUF:indicatorVervolgvraag>false</StUF:indicatorVervolgvraag>
                        <StUF:maximumAantal>9</StUF:maximumAantal>
                    </BG:parameters>
                    <BG:gelijk StUF:entiteittype="NPS">
                        <BG:inp.bsn>555555021</BG:inp.bsn>
                    </BG:gelijk>
                    <BG:scope>
                        <BG:object StUF:entiteittype="NPS">
                            <BG:inp.bsn xsi:nil="true" />
                            <BG:inp.a-nummer xsi:nil="true" />
                            <BG:geslachtsnaam xsi:nil="true" />
                            <BG:voorvoegselGeslachtsnaam xsi:nil="true" />
                            <BG:voorletters xsi:nil="true" />
                            <BG:voornamen xsi:nil="true" />
                            <BG:aanduidingNaamgebruik xsi:nil="true" />
                            <BG:geslachtsnaamPartner xsi:nil="true" />
                            <BG:geslachtsaanduiding xsi:nil="true" />
                            <BG:geslachtsnaamAanschrijving xsi:nil="true" />
                            <BG:geboortedatum xsi:nil="true" />
                            <BG:inp.geboorteplaats xsi:nil="true" />
                            <BG:inp.geboorteLand xsi:nil="true" />
                            <BG:overlijdensdatum xsi:nil="true" />
                            <BG:inp.overlijdenplaats xsi:nil="true" />
                            <BG:inp.overlijdenLand xsi:nil="true" />
                            <BG:verblijfsadres>
                                <BG:aoa.identificatie xsi:nil="true" />
                                <BG:wpl.identificatie xsi:nil="true" />
                                <BG:wpl.woonplaatsNaam xsi:nil="true" />
                                <BG:aoa.woonplaatsWaarinGelegen>
                                    <BG:wpl.identificatie xsi:nil="true" />
                                    <BG:wpl.woonplaatsNaam xsi:nil="true" />
                                </BG:aoa.woonplaatsWaarinGelegen>
                                <BG:gor.identificatie xsi:nil="true" />
                                <BG:opr.identificatie xsi:nil="true" />
                                <BG:gor.openbareRuimteNaam xsi:nil="true" />
                                <BG:gor.straatnaam xsi:nil="true" />
                                <BG:aoa.postcode xsi:nil="true" />
                                <BG:aoa.huisnummer xsi:nil="true" />
                                <BG:aoa.huisletter xsi:nil="true" />
                                <BG:aoa.huisnummertoevoeging xsi:nil="true" />
                                <BG:inp.locatiebeschrijving xsi:nil="true" />
                                <BG:begindatumVerblijf xsi:nil="true" />
                            </BG:verblijfsadres>
                            <BG:inp.adresHerkomst xsi:nil="true" />
                            <BG:inp.burgerlijkeStaat xsi:nil="true" />
                            <BG:inp.gemeenteVanInschrijving xsi:nil="true" />
                            <BG:inp.datumInschrijving xsi:nil="true" />
                            <BG:inp.indicatieGeheim xsi:nil="true" />
                            <BG:ing.indicatieBlokkering xsi:nil="true" />
                            <BG:aanduidingStrijdigheidNietigheid xsi:nil="true" />
                            <StUF:tijdvakGeldigheid>
                                <StUF:beginGeldigheid xsi:nil="true" />
                                <StUF:eindGeldigheid xsi:nil="true" />
                            </StUF:tijdvakGeldigheid>
                            <StUF:tijdstipRegistratie xsi:nil="true" />
                            <BG:inp.heeftAlsNationaliteit StUF:entiteittype="NPSNAT">
                                <BG:gerelateerde StUF:entiteittype="NAT">
                                    <BG:code xsi:nil="true" />
                                    <BG:omschrijving xsi:nil="true" />
                                </BG:gerelateerde>
                                <BG:inp.redenVerkrijging xsi:nil="true" />
                                <BG:inp.datumVerkrijging xsi:nil="true" />
                                <BG:inp.redenVerlies xsi:nil="true" />
                                <BG:inp.datumVerlies xsi:nil="true" />
                            </BG:inp.heeftAlsNationaliteit>
                            <BG:inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW">
                                <BG:gerelateerde StUF:entiteittype="NPS">
                                    <BG:inp.bsn xsi:nil="true" />
                                    <BG:geslachtsnaam xsi:nil="true" />
                                    <BG:voorvoegselGeslachtsnaam xsi:nil="true" />
                                </BG:gerelateerde>
                                <BG:datumSluiting xsi:nil="true" />
                                <BG:datumOntbinding xsi:nil="true" />
                                <BG:redenOntbinding xsi:nil="true" />
                            </BG:inp.heeftAlsEchtgenootPartner>
                        </BG:object>
                    </BG:scope>
                </BG:npsLv01>
            </soapenv:Body>
        </soapenv:Envelope>
    </xsl:param>
    <xsl:variable name="originalMessage" select="."/>
    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>
    <xsl:variable name="woonplaats"><xsl:value-of
            select="root/personen/verblijfplaats/verblijfadres/woonplaats" /></xsl:variable>
    <xsl:variable name="external-data" select="document('woonplaatsen.xml')" as="node()?" />
    <xsl:variable name="woonplaatsen"><xsl:copy-of select="$external-data" /></xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates select="root/personen" mode="inputMessage"/>
    </xsl:template>

    <xsl:template match="personen" mode="inputMessage">
        <xsl:variable name="mapping">
            <object StUF:entiteittype="NPS">
                <BG:inp.bsn xsi:nil="true" />
                <BG:inp.a-nummer xsi:nil="true" />
                <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam" /></geslachtsnaam>
                <BG:voorvoegselGeslachtsnaam xsi:nil="true" />
                <voorletters><xsl:copy-of select="naam/voorletters" /></voorletters>
                <voornamen><xsl:copy-of select="naam/voornamen" /></voornamen>
                <BG:aanduidingNaamgebruik xsi:nil="true" />
                <BG:geslachtsnaamPartner xsi:nil="true" />
                <BG:geslachtsaanduiding xsi:nil="true" />
                <geslachtsnaamAanschrijving>
                    <text>
                        <xsl:choose>
                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'E'">
                                <xsl:value-of select="naam/geslachtsnaam" />
                            </xsl:when>
                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'N'">
                                <xsl:value-of
                                        select="concat(naam/geslachtsnaam, '-',partners/naam/geslachtsnaam)" />
                            </xsl:when>
                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'P'">
                                <xsl:value-of select="partners/naam/geslachtsnaam" />
                            </xsl:when>
                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'V'">
                                <xsl:value-of
                                        select="concat(partners/naam/geslachtsnaam, '-',naam/geslachtsnaam)" />
                            </xsl:when>
                        </xsl:choose>
                    </text>
                </geslachtsnaamAanschrijving>
                <BG:geboortedatum xsi:nil="true" />
                <BG:inp.geboorteplaats xsi:nil="true" />
                <BG:inp.geboorteLand xsi:nil="true" />
                <BG:overlijdensdatum xsi:nil="true" />
                <BG:inp.overlijdenplaats xsi:nil="true" />
                <BG:inp.overlijdenLand xsi:nil="true" />
                <BG:verblijfsadres>
                    <BG:aoa.identificatie xsi:nil="true" />
                    <BG:wpl.identificatie xsi:nil="true" />
                    <BG:wpl.woonplaatsNaam xsi:nil="true" />
                    <BG:aoa.woonplaatsWaarinGelegen>
                        <BG:wpl.identificatie xsi:nil="true" />
                        <BG:wpl.woonplaatsNaam xsi:nil="true" />
                    </BG:aoa.woonplaatsWaarinGelegen>
                    <BG:gor.identificatie xsi:nil="true" />
                    <BG:opr.identificatie xsi:nil="true" />
                    <BG:gor.openbareRuimteNaam xsi:nil="true" />
                    <BG:gor.straatnaam xsi:nil="true" />
                    <BG:aoa.postcode xsi:nil="true" />
                    <BG:aoa.huisnummer xsi:nil="true" />
                    <BG:aoa.huisletter xsi:nil="true" />
                    <BG:aoa.huisnummertoevoeging xsi:nil="true" />
                    <BG:inp.locatiebeschrijving xsi:nil="true" />
                    <BG:begindatumVerblijf xsi:nil="true" />
                </BG:verblijfsadres>
                <BG:inp.adresHerkomst xsi:nil="true" />
                <inp.burgerlijkeStaat>
                    <number>
                        <xsl:choose>
                            <xsl:when test="./partners !=''">
                                <xsl:choose>
                                    <xsl:when test="./partners/soortVerbintenis/code/text() ='H'">
                                        <xsl:choose>
                                            <xsl:when test="./partners/ontbindingHuwelijkPartnerschap/text() !=''">
                                                <xsl:value-of select="3" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="2" />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when test="./partners/soortVerbintenis/code/text() ='P'">
                                        <xsl:choose>
                                            <xsl:when test="./partners/ontbindingHuwelijkPartnerschap/text() !=''">
                                                <xsl:value-of select="6" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="5" />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="1" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </number>
                </inp.burgerlijkeStaat>
                <BG:inp.gemeenteVanInschrijving xsi:nil="true" />
                <BG:inp.datumInschrijving xsi:nil="true" />
                <BG:inp.indicatieGeheim xsi:nil="true" />
                <BG:ing.indicatieBlokkering xsi:nil="true" />
                <BG:aanduidingStrijdigheidNietigheid xsi:nil="true" />
                <StUF:tijdvakGeldigheid>
                    <StUF:beginGeldigheid xsi:nil="true" />
                    <StUF:eindGeldigheid xsi:nil="true" />
                </StUF:tijdvakGeldigheid>
                <StUF:tijdstipRegistratie xsi:nil="true" />
                <BG:inp.heeftAlsNationaliteit StUF:entiteittype="NPSNAT">
                    <BG:gerelateerde StUF:entiteittype="NAT">
                        <BG:code xsi:nil="true" />
                        <BG:omschrijving xsi:nil="true" />
                    </BG:gerelateerde>
                    <BG:inp.redenVerkrijging xsi:nil="true" />
                    <BG:inp.datumVerkrijging xsi:nil="true" />
                    <BG:inp.redenVerlies xsi:nil="true" />
                    <BG:inp.datumVerlies xsi:nil="true" />
                </BG:inp.heeftAlsNationaliteit>
            </object>
        </xsl:variable>
        <xsl:apply-templates select="$soapMessage//BG:npsLv01">
            <xsl:with-param name="mapping" select="$mapping" />
            <xsl:with-param name="persoon" select="." tunnel="yes"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="BG:npsLv01">
        <xsl:param name="mapping" />
        <BG:npsLa01>
            <xsl:apply-templates select="BG:scope/BG:object">
                <xsl:with-param name="mapping" select="$mapping"/>
            </xsl:apply-templates>
        </BG:npsLa01>
    </xsl:template>

    <xsl:template match="BG:object">
        <xsl:param name="mapping"/>
        <xsl:param name="persoon" tunnel="yes"/>
        <BG:object StUF:entiteittype="NPS">
            <xsl:apply-templates select="*[not(local-name() = ('inp.heeftAlsOuders', 'inp.heeftAlsKinderen', 'inp.heeftAlsEchtgenootPartner'))]">
                <xsl:with-param name="mapping" select="$mapping/object"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="$persoon/ouders"/>
            <xsl:apply-templates select="$persoon/kinderen"/>
            <xsl:apply-templates select="$persoon/partners"/>
        </BG:object>
    </xsl:template>

    <xsl:template match="*">
        <xsl:param name="mapping" />
        <xsl:copy>
            <xsl:apply-templates select="*">
                <xsl:with-param name="mapping" select="$mapping/*[name()=current()/local-name()]"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <!--This template applies to elements inside object that have child elements. Their attributes should be copied-->
    <xsl:template match="BG:object//*[*]">
        <xsl:param name="mapping" />
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="*">
                <xsl:with-param name="mapping" select="$mapping/*[name()=current()/local-name()]"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="BG:object//*[not(*)]">
        <xsl:param name="mapping" />
        <xsl:variable name="mappedElement" select="$mapping/*[name()=current()/local-name()]"/>
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="not(exists($mappedElement/@authorizedApplications)) or contains($mappedElement/@authorizedApplications, $varZenderApplicatie)">
                    <xsl:choose>
                        <xsl:when test="$mappedElement/*/text() != ''">
                            <xsl:value-of select="$mappedElement/*" />
                        </xsl:when>
                        <xsl:when test="$mappedElement/*/text() = ''">
                            <xsl:attribute name="xsi:nil">true</xsl:attribute>
                            <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                    select="$geenWaarde" /></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xsi:nil">true</xsl:attribute>
                            <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                    select="$waardeOnbekend" /></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="xsi:nil">true</xsl:attribute>
                    <xsl:attribute
                        name="StUF:noValue"><xsl:value-of
                        select="$nietGeautoriseerd" /></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="ouders">
        <xsl:variable name="mapping">

        </xsl:variable>
    </xsl:template>

    <xsl:template match="kinderen">
        <xsl:variable name="mapping">

        </xsl:variable>
    </xsl:template>

    <xsl:template match="partners">
        <xsl:variable name="mapping">
            <inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW">
                <gerelateerde StUF:entiteittype="NPS">
                    <inp.bsn authorizedApplications="TOP,GWS"><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                    <geslachtsnaam />
                    <voorvoegselGeslachtsnaam />
                </gerelateerde>
                <datumSluiting />
                <datumOntbinding />
                <redenOntbinding />
            </inp.heeftAlsEchtgenootPartner>
        </xsl:variable>
        <xsl:apply-templates select="$soapMessage//BG:inp.heeftAlsEchtgenootPartner">
            <xsl:with-param name="mapping" select="$mapping"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="BG:inp.heeftAlsEchtgenootPartner">
        <xsl:param name="mapping"/>
        <BG:inp.heeftAlsEchtgenootPartner>
            <xsl:apply-templates select="*">
                <xsl:with-param name="mapping" select="$mapping"/>
            </xsl:apply-templates>
        </BG:inp.heeftAlsEchtgenootPartner>
    </xsl:template>

</xsl:stylesheet>