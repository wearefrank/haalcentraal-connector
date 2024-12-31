<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml"
                exclude-result-prefixes="xsd"
    >
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="varZenderOrganisatie" />
    <xsl:param name="varZenderGebruiker" />
    <xsl:param name="varReferentienummer"/>
    <xsl:param name="aantalVoorkomens"><xsl:value-of select="count(/root/personen)"/></xsl:param>
    <xsl:param name="inputnpsLk01" select="document('npsLk01.xml')" as="node()?" />
    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>
    <xsl:variable name="woonplaats"><xsl:value-of
            select="root/personen/verblijfplaats/verblijfadres/woonplaats" /></xsl:variable>
    <xsl:variable name="external-data" select="document('woonplaatsen.xml')" as="node()?" />
    <xsl:param name="geslachtsnaam"><xsl:value-of select="/root/personen/naam/geslachtsnaam"/></xsl:param>
    <xsl:param name="voorvoegsel"><xsl:value-of select="count(/root/personen/naam/voorvoegsel)"/></xsl:param>
    
    <xsl:template match="/">
        <xsl:apply-templates select="$inputnpsLk01//BG:npsLk01">
            <xsl:with-param name="personen" select="root/personen"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="BG:npsLk01">
        <xsl:param name="personen"/>
        <xsl:choose>
            <xsl:when test="$aantalVoorkomens = 0">
                <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
            </xsl:when>
            <xsl:otherwise>
                <BG:npsLk01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
                    <xsl:apply-templates select="BG:stuurgegevens"/>
                    <xsl:apply-templates select="BG:parameters"/>
                    <xsl:for-each select="$personen">
                        <xsl:variable name="mapping">
                            <object>
                                <xsl:choose>
                                    <xsl:when test="burgerservicenummer/text()!=''">
                                        <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                                        <authentiek doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <inp.bsn doNotCreate="true"/>
                                        <authentiek StUF:metagegeven="true"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <inp.a-nummer authorizedApplications="DEC_ZKN,GWS,LBA"><xsl:copy-of select="aNummer" /></inp.a-nummer>
                                <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam" /></geslachtsnaam>
                                <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel" /></voorvoegselGeslachtsnaam>
                                <voorletters><xsl:copy-of select="naam/voorletters" /></voorletters>
                                <voornamen><xsl:copy-of select="naam/voornamen" /></voornamen>
                                <aanduidingNaamgebruik><xsl:copy-of select="naam/aanduidingNaamgebruik/code" /></aanduidingNaamgebruik>
                                <geslachtsnaamPartner authorizedApplications="DEC_ZKN,GWS"><xsl:copy-of select="partners/naam/geslachtsnaam" /></geslachtsnaamPartner>
                                <voorvoegselGeslachtsnaamPartner authorizedApplications="DEC_ZKN,GWS,TOP"><xsl:copy-of select="partners/naam/voorvoegsel" /></voorvoegselGeslachtsnaamPartner>
                                <aanhefAanschrijving authorizedApplications="DEC_ZKN,PGAx-SG-ZVH"><xsl:copy-of select="adressering/aanhef" /></aanhefAanschrijving>
                                <voornamenAanschrijving authorizedApplications="DEC_ZKN,PGAx-SG-ZVH"></voornamenAanschrijving>
                                <geslachtsnaamAanschrijving authorizedApplications="DEC_ZKN,PGAx-SG-ZVH">
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
                                <adellijkeTitelPredikaat authorizedApplications=""><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                                <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                                <geboortedatum>
                                    <test>
                                        <xsl:variable name="date" select="geboorte/datum/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </geboortedatum>
                                <inp.geboorteplaats><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
                                <inp.geboorteLand><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
                                <overlijdensdatum>
                                    <test>
                                        <xsl:variable name="date" select="overlijden/datum/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </overlijdensdatum>
                                <inp.overlijdenplaats authorizedApplications="GWS,LBA"><xsl:copy-of select="overlijden/plaats/omschrijving"/></inp.overlijdenplaats>
                                <inp.overlijdenLand authorizedApplications="GWS,LBA"><xsl:copy-of select="overlijden/land/code"/></inp.overlijdenLand>
                                <inp.verblijftIn StUF:entiteittype="NPSTGO">
                                    <gerelateerde StUF:entiteittype="TGO" authorizedApplications="GWS">
                                        <adresAanduidingGrp>
                                            <xsl:choose>
                                                <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie)!=0">
                                                    <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                                                    <oao.identificatie doNotCreate="true"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <num.identificatie doNotCreate="true"/>
                                                    <oao.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></oao.identificatie>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <wpl.identificatie authorizedApplications="DEC_ZKN">
                                                <xsl:copy-of select="$external-data/woonplaatsen/woonplaats[name = $woonplaats]/code" />
                                            </wpl.identificatie>
                                            <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                            <aoa.woonplaatsWaarinGelegen>
                                                <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                            </aoa.woonplaatsWaarinGelegen>
                                            <gor.identificatie authorizedApplications="GWS,PGAx-SG-ZVH"></gor.identificatie>
                                            <opr.identificatie authorizedApplications="GWS,PGAx-SG-ZVH"></opr.identificatie>
                                            <gor.openbareRuimteNaam><xsl:copy-of select="verblijfplaats/verblijfadres/officieleStraatnaam"/></gor.openbareRuimteNaam>
                                            <gor.straatnaam><xsl:copy-of select="verblijfplaats/verblijfadres/korteStraatnaam"/></gor.straatnaam>
                                            <aoa.postcode><xsl:copy-of select="verblijfplaats/verblijfadres/postcode"/></aoa.postcode>
                                            <aoa.huisnummer><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummer"/></aoa.huisnummer>
                                            <aoa.huisletter><xsl:copy-of select="verblijfplaats/verblijfadres/huisletter"/></aoa.huisletter>
                                            <aoa.huisnummertoevoeging><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummertoevoeging"/></aoa.huisnummertoevoeging>
                                            <ogo.locatieAanduiding authorizedApplications="DEC_ZKN,TOP,LBA,PGAx-SG-ZVH"><xsl:copy-of select="verblijfplaats/verblijfadres/locatiebeschrijving"/></ogo.locatieAanduiding>
                                        </adresAanduidingGrp>
                                    </gerelateerde>
                                </inp.verblijftIn>
                                <xsl:choose>
                                    <xsl:when test="./verblijfplaats/type/text() = &apos;Adres&apos;">
                                        <verblijfsadres>
                                            <aoa.identificatie authorizedApplications="DEC_ZKN,GWS,TOP,PGAx-SG-ZVH"><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></aoa.identificatie>
                                            <wpl.identificatie authorizedApplications="DEC_ZKN">
                                                <xsl:copy-of select="$external-data/woonplaatsen/woonplaats[name = $woonplaats]/code"/>
                                            </wpl.identificatie>
                                            <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                            <aoa.woonplaatsWaarinGelegen>
                                                <wpl.identificatie authorizedApplications="GWS,PGAx-SG-ZVH"></wpl.identificatie>
                                                <wpl.woonplaatsNaam authorizedApplications="GWS,PGAx-SG-ZVH"></wpl.woonplaatsNaam>
                                            </aoa.woonplaatsWaarinGelegen>
                                            <gor.identificatie authorizedApplications="GWS,PGAx-SG-ZVH"></gor.identificatie>
                                            <opr.identificatie authorizedApplications="GWS,PGAx-SG-ZVH"></opr.identificatie>
                                            <gor.openbareRuimteNaam><xsl:copy-of select="verblijfplaats/naamOpenbareRuimte"/></gor.openbareRuimteNaam>
                                            <gor.straatnaam><xsl:copy-of select="verblijfplaats/verblijfadres/korteStraatnaam"/></gor.straatnaam>
                                            <aoa.postcode><xsl:copy-of select="verblijfplaats/verblijfadres/postcode"/></aoa.postcode>
                                            <aoa.huisnummer><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummer"/></aoa.huisnummer>
                                            <aoa.huisletter><xsl:copy-of select="verblijfplaats/verblijfadres/huisletter"/></aoa.huisletter>
                                            <aoa.huisnummertoevoeging><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummertoevoeging"/></aoa.huisnummertoevoeging>
                                            <inp.locatiebeschrijving authorizedApplications="DEC_ZKN,TOP,LBA,PGAx-SG-ZVH"><xsl:copy-of select="verblijfplaats/verblijfadres/locatiebeschrijving"/></inp.locatiebeschrijving>
                                            <begindatumVerblijf>
                                                <test>
                                                    <xsl:variable name="date" select="verblijfplaats/datumVan/datum"/>
                                                    <xsl:value-of select="translate($date, '-', '')" />
                                                </test>
                                            </begindatumVerblijf>
                                        </verblijfsadres>
                                        <sub.verblijfBuitenland doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <verblijfsadres doNotCreate="true"/>
                                        <sub.verblijfBuitenland>
                                            <lnd.landcode authorizedApplications="DEC_ZKN,GWS,TOP,LBA"><xsl:copy-of select="verblijfplaats/verblijfadres/land/code"/></lnd.landcode>
                                            <lnd.landnaam><xsl:copy-of select="verblijfplaats/verblijfadres/land/omschrijving"/></lnd.landnaam>
                                            <sub.adresBuitenland1><xsl:copy-of select="verblijfplaats/verblijfadres/regel1"/></sub.adresBuitenland1>
                                            <sub.adresBuitenland2><xsl:copy-of select="verblijfplaats/verblijfadres/regel2"/></sub.adresBuitenland2>
                                            <sub.adresBuitenland3><xsl:copy-of select="verblijfplaats/verblijfadres/regel3"/></sub.adresBuitenland3>
                                        </sub.verblijfBuitenland>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <inp.adresHerkomst><xsl:copy-of select="verblijfplaats/functieAdres/code"/></inp.adresHerkomst>
                                <xsl:choose>
                                    
                                    <xsl:when test="adressering/text()!=''">
                                        <sub.correspondentieAdres authorizedApplications="GWS">
                                            <aoa.identificatie></aoa.identificatie>
                                            <authentiek doNotCreate="true"/>
                                        </sub.correspondentieAdres>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <sub.correspondentieAdres authorizedApplications="GWS">
                                            <aoa.identificatie doNotCreate="true"/>
                                            <authentiek StUF:metagegeven="true"/>
                                        </sub.correspondentieAdres>
                                    </xsl:otherwise>
                                    
                                </xsl:choose>
                                
                                <sub.telefoonnummer authorizedApplications="TOP"></sub.telefoonnummer>
                                <sub.faxnummer authorizedApplications=""></sub.faxnummer>
                                <sub.emailadres authorizedApplications="TOP"></sub.emailadres>
                                <sub.url authorizedApplications=""></sub.url>
                                <sub.rekeningnummerBankGiro authorizedApplications=""></sub.rekeningnummerBankGiro>
                                <inp.burgerlijkeStaat authorizedApplications="TOP,GWS">
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
                                <inp.gemeenteVanInschrijving><xsl:copy-of select="gemeenteVanInschrijving/code"/></inp.gemeenteVanInschrijving>
                                <inp.datumInschrijving>
                                    <test>
                                        <xsl:variable name="date" select="datumEersteInschrijvingGBA/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </inp.datumInschrijving>
                                <vbt.aanduidingVerblijfstitel authorizedApplications="GWS"><xsl:copy-of select="verblijfstitel/aanduiding/code"/></vbt.aanduidingVerblijfstitel>
                                <ing.datumVerkrijgingVerblijfstitel authorizedApplications="GWS"><xsl:copy-of select="verblijfstitel/datumIngang/datum"/></ing.datumVerkrijgingVerblijfstitel>
                                <ing.datumVerliesVerblijfstitel authorizedApplications="GWS">
                                    <test>
                                        <xsl:variable name="date" select="verblijfstitel/datumEinde/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </ing.datumVerliesVerblijfstitel>
                                <inp.datumVestigingInNederland authorizedApplications="LBA,DEC_ZKN">
                                    <test>
                                        <xsl:variable name="date" select="immigratie/datumVestigingInNederland/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </inp.datumVestigingInNederland>
                                <inp.immigratieLand authorizedApplications="DEC_ZKN"><xsl:copy-of select="immigratie/landVanwaarIngeschreven/omschrijving"/></inp.immigratieLand>
                                <inp.datumVertrekUitNederland authorizedApplications="LBA">
                                    <test>
                                        <xsl:variable name="date" select="immigratie/indicatieVestigingVanuitBuitenland/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </inp.datumVertrekUitNederland>
                                <inp.emigratieLand authorizedApplications="LBA,GWS">
                                    <xsl:if
                                        test="./opschortingBijhouding/reden/code/text()='E'">
                                        
                                        <xsl:if
                                            test="./verblijfplaats/type/text()='VerblijfplaatsBuitenland'">
                                            <xsl:value-of
                                                select="./verblijfplaats/verblijfadres/land/code" />
                                        </xsl:if>
                                    </xsl:if>
                                </inp.emigratieLand>
                                <aanduidingBijzonderNederlanderschap authorizedApplications="GWS"><xsl:copy-of select="nationaliteit/aanduidingBijzonderNederlanderschap"/></aanduidingBijzonderNederlanderschap>
                                <ing.aanduidingEuropeesKiesrecht authorizedApplications="DEC_ZKN"><xsl:copy-of select="europeesKiesrecht/aanduiding/code"/></ing.aanduidingEuropeesKiesrecht>
                                <ing.indicatieGezagMinderjarige authorizedApplications="LBA,GWS,TOP"><xsl:copy-of select="gezagsverhouding/indicatieGezagMinderjarige"/></ing.indicatieGezagMinderjarige>
                                <ing.indicatieCurateleRegister><xsl:copy-of select="gezagsverhouding/indicatieCurateleRegister"/></ing.indicatieCurateleRegister>
                                <inp.datumOpschortingBijhouding>
                                    <test>
                                        <xsl:variable name="date" select="opschortingBijhouding/datum/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </inp.datumOpschortingBijhouding>
                                <inp.redenOpschortingBijhouding>
                                    <xsl:choose>
                                        <xsl:when test="opschortingBijhouding/reden/text() != ''">
                                            <xsl:value-of select="./opschortingBijhouding/reden" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./overlijden/indicatieOverleden" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </inp.redenOpschortingBijhouding>
                                <inp.indicatieGeheim authorizedApplications="LBA,GWS,TOP,PGAx-SG-ZVH"><xsl:copy-of select="geheimhoudingPersoonsgegevens"/></inp.indicatieGeheim>
                                <inp.heeftAlsNationaliteit StUF:entiteittype="NPSNAT" StUF:verwerkingssoort="T">
                                    <gerelateerde StUF:entiteittype="NAT" StUF:verwerkingssoort="T">
                                        <code authorizedApplications="LBA,GWS,TOP"><xsl:copy-of select="nationaliteiten/nationaliteit/code"/></code>
                                        <omschrijving authorizedApplications="LBA,TOP"><xsl:copy-of select="nationaliteiten/nationaliteit/omschrijving"/></omschrijving>
                                    </gerelateerde>
                                    <inp.redenVerkrijging><xsl:copy-of select="nationaliteiten/redenOpname/code"/></inp.redenVerkrijging>
                                    <inp.datumVerkrijging>
                                        <test>
                                            <xsl:variable name="date" select="nationaliteiten/datumIngangGeldigheid/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </inp.datumVerkrijging>
                                </inp.heeftAlsNationaliteit>
                            </object>
                        </xsl:variable>
                        <xsl:apply-templates select="$inputnpsLk01//BG:object">
                            <xsl:with-param name="mapping" select="$mapping" />
                            <xsl:with-param name="persoon" select="." tunnel="yes"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </BG:npsLk01>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="BG:stuurgegevens">
        <xsl:element name="BG:stuurgegevens">
            <StUF:berichtcode>Lk01</StUF:berichtcode>
            <StUF:zender>                
                <StUF:organisatie>NEDGR</StUF:organisatie>
                <StUF:applicatie>NEDMAG_VnA</StUF:applicatie>
            </StUF:zender>
            
            <StUF:ontvanger>
                <StUF:organisatie>
                    <xsl:value-of select="$varZenderOrganisatie" />
                </StUF:organisatie>
                <StUF:applicatie>
                    <xsl:value-of select="$varZenderApplicatie" />
                </StUF:applicatie>
            </StUF:ontvanger> 
            <StUF:gebruiker>
                    <xsl:value-of select="$varZenderGebruiker" />
            </StUF:gebruiker>   
            <StUF:referentienummer>
                <xsl:value-of select="$varReferentienummer" />
            </StUF:referentienummer> 
            <StUF:tijdstipBericht>
                <xsl:value-of
                    select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
            </StUF:tijdstipBericht>
            <StUF:entiteittype>NPS</StUF:entiteittype>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="BG:parameters">
        <BG:parameters>
            <StUF:mutatiesoort>T</StUF:mutatiesoort>
            <StUF:indicatorOvername>V</StUF:indicatorOvername>
        </BG:parameters>     
    </xsl:template>
    
    <xsl:template match="BG:object">
        <xsl:param name="mapping"/>
        <xsl:param name="persoon" tunnel="yes"/>
        <BG:object StUF:entiteittype="NPS" StUF:verwerkingssoort="T">
            <xsl:apply-templates select="*[not(local-name() = ('inp.heeftAlsOuders', 'inp.heeftAlsKinderen', 'inp.heeftAlsEchtgenootPartner'))]">
                <xsl:with-param name="mapping" select="$mapping/object"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="$persoon/partners"/>
            <xsl:apply-templates select="$persoon/kinderen"/>
            <xsl:apply-templates select="$persoon/ouders"/>            
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
        <xsl:variable name="mappedElement" select="$mapping/*[name()=current()/local-name()]"/>
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <!-- Add attribute if the element is 'authentiek' -->
                <xsl:if test="local-name()='inp.heeftAlsNationaliteit'or local-name()='inp.verblijftIn' or local-name()='gerelateerde'">
                    <xsl:attribute name="StUF:verwerkingssoort">T</xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="*">
                    <xsl:with-param name="mapping" select="$mappedElement"/>
                </xsl:apply-templates>
            </xsl:copy>
            
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="BG:object//*[not(*)]">
        <xsl:param name="mapping" />
        <xsl:variable name="mappedElement" select="$mapping/*[name()=current()/local-name()]"/>
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
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
                                <xsl:if test="local-name()='authentiek'">
                                    <xsl:attribute name="StUF:metagegeven">true</xsl:attribute>
                                </xsl:if>
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
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="partners">
        <xsl:variable name="mapping">
            <inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn authorizedApplications="TOP,GWS"><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn doNotCreate="true"/>
                            <authentiek StUF:metagegeven="true"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>  
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <geslachtsnaamPartner authorizedApplications="DEC_ZKN,GWS"><xsl:value-of select="$geslachtsnaam"/></geslachtsnaamPartner>
                    <voorvoegselGeslachtsnaamPartner><xsl:value-of select="$voorvoegsel"/></voorvoegselGeslachtsnaamPartner>
                    <adellijkeTitelPredikaat authorizedApplications=""><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding authorizedApplications="TOP"><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                    <geboortedatum>
                        <test>
                            <xsl:variable name="date" select="geboorte/datum/datum"/>
                            <xsl:value-of select="translate($date, '-', '')" />
                        </test>
                    </geboortedatum>
                    <inp.geboorteplaats><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
                    <inp.geboorteLand><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
                    <inp.verblijftIn>
                        <gerelateerde>
                            <adresAanduidingGrp>
                                <xsl:choose>
                                    <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie)!=0">
                                        <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                                        <oao.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <oao.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></oao.identificatie>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </adresAanduidingGrp>
                        </gerelateerde>
                    </inp.verblijftIn>
                    <xsl:choose>
                        <xsl:when test="./verblijfplaats/type = &apos;Adres&apos;">
                            <verblijfsadres>
                                <aoa.identificatie authorizedApplications="DEC_ZKN,GWS,TOP,PGAx-SG-ZVH"></aoa.identificatie>
                            </verblijfsadres>
                            <sub.verblijfBuitenland doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <verblijfsadres doNotCreate="true"/>
                            <sub.verblijfBuitenland></sub.verblijfBuitenland>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <xsl:choose>                                        
                        <xsl:when test="adressering/text()!=''">
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie></aoa.identificatie>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek StUF:metagegeven="true"/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.burgerlijkeStaat authorizedApplications="TOP,GWS">
                        <xsl:choose>
                            <xsl:when
                                test=". !=''">
                                <xsl:choose>
                                    <xsl:when
                                        test="./soortVerbintenis/code/text() ='H'">
                                        <xsl:choose>
                                            <xsl:when test="./ontbindingHuwelijkPartnerschap/text() !=''">
                                                <xsl:value-of select="3" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="2" />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:when
                                        test="./soortVerbintenis/code/text() ='P'">
                                        <xsl:choose>
                                            <xsl:when test="./ontbindingHuwelijkPartnerschap/text() !=''">
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
                    </inp.burgerlijkeStaat>
                </gerelateerde>
                <soortVerbintenis authorizedApplications="GWS,TOP"><xsl:copy-of select="soortVerbintenis/code"/></soortVerbintenis>
            </inp.heeftAlsEchtgenootPartner>
        </xsl:variable>
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsEchtgenootPartner">
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
    <xsl:template match="kinderen">
        <xsl:variable name="mapping">
            <inp.heeftAlsKinderen StUF:entiteittype="NPSNPSKND" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn authorizedApplications="GWS,TOP"><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn doNotCreate="true"/>
                            <authentiek StUF:metagegeven="true"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <geslachtsnaam authorizedApplications="GWS,TOP"><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>
                    <voorvoegselGeslachtsnaam authorizedApplications="GWS,TOP"><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters authorizedApplications="GWS,TOP"><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen authorizedApplications="GWS,TOP"><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <aanduidingNaamgebruik authorizedApplications="TOP"></aanduidingNaamgebruik>
                    <aanhefAanschrijving authorizedApplications="TOP"></aanhefAanschrijving>
                    <adellijkeTitelPredikaat authorizedApplications=""><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geboortedatum authorizedApplications="GWS,TOP">
                        <test>
                            <xsl:variable name="date" select="geboorte/datum/datum"/>
                            <xsl:value-of select="translate($date, '-', '')" />
                        </test>
                    </geboortedatum>
                    <inp.geboorteplaats authorizedApplications="TOP"><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
                    <inp.geboorteLand authorizedApplications="TOP"><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
                    <inp.verblijftIn>
                        <gerelateerde>
                            <adresAanduidingGrp>
                                <xsl:choose>
                                    <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie)!=0">
                                        <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                                        <oao.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <oao.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></oao.identificatie>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </adresAanduidingGrp>
                        </gerelateerde>
                    </inp.verblijftIn>
                    <xsl:choose>
                        <xsl:when test="./verblijfplaats/type = &apos;Adres&apos;">
                            <verblijfsadres/>
                            <sub.verblijfBuitenland doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <verblijfsadres doNotCreate="true"/>
                            <sub.verblijfBuitenland/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>                                        
                        <xsl:when test="adressering/text()!=''">
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie/>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek StUF:metagegeven="true"/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.indicatieGeheim authorizedApplications="TOP"></inp.indicatieGeheim>
                </gerelateerde>
            </inp.heeftAlsKinderen>
        </xsl:variable>
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsKinderen">
            <xsl:with-param name="mapping" select="$mapping"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="BG:inp.heeftAlsKinderen">
        <xsl:param name="mapping"/>
        <BG:inp.heeftAlsKinderen>
            <xsl:apply-templates select="*">
                <xsl:with-param name="mapping" select="$mapping"/>
            </xsl:apply-templates>
        </BG:inp.heeftAlsKinderen>
    </xsl:template>
    <xsl:template match="ouders">
        <xsl:variable name="mapping">
            <inp.heeftAlsOuders StUF:entiteittype="NPSNPSOUD" StUF:verwerkingssoort="T" authorizedApplications="LBA,TOP,GWS">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn doNotCreate="true"/>
                            <authentiek StUF:metagegeven="true"/>
                        </xsl:otherwise>
                    </xsl:choose>                    
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>  
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <adellijkeTitelPredikaat authorizedApplications=""><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                    <geboortedatum>
                        <test>
                            <xsl:variable name="date" select="geboorte/datum/datum"/>
                            <xsl:value-of select="translate($date, '-', '')" />
                        </test>
                    </geboortedatum>
                    <inp.geboorteplaats authorizedApplications="GWS"><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
                    <inp.geboorteLand authorizedApplications="GWS"><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
                    <inp.verblijftIn StUF:verwerkingssoort="T">
                        <gerelateerde>
                            <adresAanduidingGrp>
                                <xsl:choose>
                                    <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie)!=0">
                                        <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                                        <oao.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <oao.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></oao.identificatie>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </adresAanduidingGrp>
                        </gerelateerde>
                    </inp.verblijftIn>
                    <xsl:choose>
                        <xsl:when test="./verblijfplaats/type = &apos;Adres&apos;">
                            <verblijfsadres/>
                            <sub.verblijfBuitenland doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <verblijfsadres doNotCreate="true"/>
                            <sub.verblijfBuitenland/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>                                        
                        <xsl:when test="adressering/text()!=''">
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie/>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres authorizedApplications="GWS">
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek StUF:metagegeven="true"/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.indicatieGeheim authorizedApplications="TOP"></inp.indicatieGeheim>
                </gerelateerde>
                <ouderAanduiding>
                    <test>
                        <xsl:value-of select="concat('Ouder',./ouderAanduiding)" />
                    </test>
                </ouderAanduiding>
                <datumIngangFamilierechtelijkeBetrekking authorizedApplications="GWS">
                    <test>
                        <xsl:variable name="date" select="datumIngangFamilierechtelijkeBetrekking/datum"/>
                        <xsl:value-of select="translate($date, '-', '')" />
                    </test>
                </datumIngangFamilierechtelijkeBetrekking>
            </inp.heeftAlsOuders>
        </xsl:variable>
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsOuders">
            <xsl:with-param name="mapping" select="$mapping"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="BG:inp.heeftAlsOuders">
        <xsl:param name="mapping"/>
        <BG:inp.heeftAlsOuders>
            <xsl:apply-templates select="*">
                <xsl:with-param name="mapping" select="$mapping"/>
            </xsl:apply-templates>
        </BG:inp.heeftAlsOuders>
    </xsl:template>
</xsl:stylesheet>