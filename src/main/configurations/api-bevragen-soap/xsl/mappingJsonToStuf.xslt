<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:a="http://www.egem.nl/StUF/StUF0301"
                xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310"
                xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml"
                exclude-result-prefixes="xsd"
    >
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="berichtcode">La01</xsl:param>
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="varReferentienummer" />
    <xsl:param name="indicatorVervolgvraag" />
    <xsl:param name="aantalVoorkomens"><xsl:value-of select="count(/root/personen)"/></xsl:param>
    <xsl:param name="originalMessage" as='node()?'/>
    <xsl:param name="sleutelVerzendend"/>
    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>
    <xsl:variable name="authorizedApplicationsMap" select="document('authorizedApplicationsMap.xml')" as="node()?" />
    <xsl:variable name="woonplaats"><xsl:value-of
            select="root/personen/verblijfplaats/verblijfadres/woonplaats" /></xsl:variable>
    <xsl:variable name="external-data" select="document('woonplaatsen.xml')" as="node()?" />
    <xsl:param name="geslachtsnaam"><xsl:value-of select="/root/personen/naam/geslachtsnaam"/></xsl:param>
    <xsl:param name="voorvoegsel"><xsl:value-of select="count(/root/personen/naam/voorvoegsel)"/></xsl:param>
    
    <xsl:template match="/">
        <xsl:apply-templates select="$originalMessage//BG:npsLv01">
            <xsl:with-param name="personen" select="root/personen"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="BG:npsLv01">
        <xsl:param name="personen"/>
        <xsl:choose>
            <xsl:when test="$aantalVoorkomens = 0">
                <BG:npsLa01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
                    <xsl:apply-templates select="BG:stuurgegevens"/>
                    <xsl:apply-templates select="BG:parameters"/>
                    <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
                </BG:npsLa01>
            </xsl:when>
            <xsl:otherwise>
                <BG:npsLa01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
                    <xsl:apply-templates select="BG:stuurgegevens"/>
                    <xsl:apply-templates select="BG:parameters"/>
                    <BG:antwoord>
                        <xsl:for-each select="$personen">
                            <xsl:variable name="mapping">
                                <object StUF:entiteittype="NPS">
                                    <xsl:choose>
                                        <xsl:when test="burgerservicenummer/text()!=''">
                                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                                            <authentiek doNotCreate="true"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <inp.bsn doNotCreate="true"/>
                                            <authentiek/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <inp.a-nummer><xsl:copy-of select="aNummer" /></inp.a-nummer>
                                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam" /></geslachtsnaam>
                                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel" /></voorvoegselGeslachtsnaam>
                                    <voorletters><xsl:copy-of select="naam/voorletters" /></voorletters>
                                    <voornamen><xsl:copy-of select="naam/voornamen" /></voornamen>
                                    <aanduidingNaamgebruik><xsl:copy-of select="naam/aanduidingNaamgebruik/code" /></aanduidingNaamgebruik>
                                    <geslachtsnaamPartner><xsl:copy-of select="partners/naam/geslachtsnaam" /></geslachtsnaamPartner>
                                    <voorvoegselGeslachtsnaamPartner><xsl:copy-of select="partners/naam/voorvoegsel" /></voorvoegselGeslachtsnaamPartner>
                                    <aanhefAanschrijving><xsl:copy-of select="adressering/aanhef" /></aanhefAanschrijving>
                                    <voornamenAanschrijving></voornamenAanschrijving>
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
                                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
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
                                    <inp.overlijdenplaats><xsl:copy-of select="overlijden/plaats/omschrijving"/></inp.overlijdenplaats>
                                    <inp.overlijdenLand><xsl:copy-of select="overlijden/land/code"/></inp.overlijdenLand>
                                    <inp.verblijftIn StUF:entiteittype="NPSTGO">
                                        <gerelateerde StUF:entiteittype="TGO">
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
                                                <!-- <wpl.identificatie>
                                                     <xsl:copy-of select="$external-data/woonplaatsen/woonplaats[name = $woonplaats]/code" />
                                                     </wpl.identificatie> -->
                                                <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                                <aoa.woonplaatsWaarinGelegen>
                                                    <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                                </aoa.woonplaatsWaarinGelegen>
                                                <gor.identificatie></gor.identificatie>
                                                <opr.identificatie></opr.identificatie>
                                                <gor.openbareRuimteNaam><xsl:copy-of select="verblijfplaats/verblijfadres/officieleStraatnaam"/></gor.openbareRuimteNaam>
                                                <gor.straatnaam><xsl:copy-of select="verblijfplaats/verblijfadres/korteStraatnaam"/></gor.straatnaam>
                                                <aoa.postcode><xsl:copy-of select="verblijfplaats/verblijfadres/postcode"/></aoa.postcode>
                                                <aoa.huisnummer><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummer"/></aoa.huisnummer>
                                                <aoa.huisletter><xsl:copy-of select="verblijfplaats/verblijfadres/huisletter"/></aoa.huisletter>
                                                <aoa.huisnummertoevoeging><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummertoevoeging"/></aoa.huisnummertoevoeging>
                                                <ogo.locatieAanduiding><xsl:copy-of select="verblijfplaats/verblijfadres/locatiebeschrijving"/></ogo.locatieAanduiding>
                                            </adresAanduidingGrp>
                                        </gerelateerde>
                                    </inp.verblijftIn>
                                    <xsl:choose>
                                        <xsl:when test="./verblijfplaats/type/text() = &apos;Adres&apos;">
                                            <verblijfsadres>
                                                <aoa.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></aoa.identificatie>
                                                <!-- <wpl.identificatie>
                                                     <xsl:copy-of select="$external-data/woonplaatsen/woonplaats[name = $woonplaats]/code"/>
                                                     </wpl.identificatie> -->
                                                <wpl.woonplaatsNaam><xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/></wpl.woonplaatsNaam>
                                                <aoa.woonplaatsWaarinGelegen>
                                                    <wpl.identificatie></wpl.identificatie>
                                                    <wpl.woonplaatsNaam></wpl.woonplaatsNaam>
                                                </aoa.woonplaatsWaarinGelegen>
                                                <gor.identificatie></gor.identificatie>
                                                <opr.identificatie></opr.identificatie>
                                                <gor.openbareRuimteNaam><xsl:copy-of select="verblijfplaats/verblijfadres/officieleStraatnaam"/></gor.openbareRuimteNaam>
                                                <gor.straatnaam><xsl:copy-of select="verblijfplaats/verblijfadres/korteStraatnaam"/></gor.straatnaam>
                                                <aoa.postcode><xsl:copy-of select="verblijfplaats/verblijfadres/postcode"/></aoa.postcode>
                                                <aoa.huisnummer><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummer"/></aoa.huisnummer>
                                                <aoa.huisletter><xsl:copy-of select="verblijfplaats/verblijfadres/huisletter"/></aoa.huisletter>
                                                <aoa.huisnummertoevoeging><xsl:copy-of select="verblijfplaats/verblijfadres/huisnummertoevoeging"/></aoa.huisnummertoevoeging>
                                                <inp.locatiebeschrijving><xsl:copy-of select="verblijfplaats/verblijfadres/locatiebeschrijving"/></inp.locatiebeschrijving>
                                                <begindatumVerblijf>
                                                    <test>
                                                        <xsl:variable name="date" select="verblijfplaats/datumVan/datum"/>
                                                        <xsl:value-of select="translate($date, '-', '')" />
                                                    </test>
                                                </begindatumVerblijf>
                                            </verblijfsadres>
                                            <sub.verblijfBuitenland doNotCreate="true"/>
                                        </xsl:when>
                                        <xsl:when test="./verblijfplaats/type/text() = &apos;VerblijfplaatsBuitenland&apos;">
                                            <verblijfsadres doNotCreate="true"/>
                                            <sub.verblijfBuitenland>
                                                <lnd.landcode><xsl:copy-of select="verblijfplaats/verblijfadres/land/code"/></lnd.landcode>
                                                <lnd.landnaam><xsl:copy-of select="verblijfplaats/verblijfadres/land/omschrijving"/></lnd.landnaam>
                                                <sub.adresBuitenland1><xsl:copy-of select="verblijfplaats/verblijfadres/regel1"/></sub.adresBuitenland1>
                                                <sub.adresBuitenland2><xsl:copy-of select="verblijfplaats/verblijfadres/regel2"/></sub.adresBuitenland2>
                                                <sub.adresBuitenland3><xsl:copy-of select="verblijfplaats/verblijfadres/regel3"/></sub.adresBuitenland3>
                                            </sub.verblijfBuitenland>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:choose>
                                                <xsl:when test="exists(./adressering/land)">
                                                    <verblijfsadres doNotCreate="true"/>
                                                    <sub.verblijfBuitenland>
                                                        <lnd.landcode><xsl:copy-of select="adressering/land/code"/></lnd.landcode>
                                                        <lnd.landnaam><xsl:copy-of select="adressering/land/omschrijving"/></lnd.landnaam>
                                                        <sub.adresBuitenland1><xsl:copy-of select="adressering/adresregel1"/></sub.adresBuitenland1>
                                                        <sub.adresBuitenland2><xsl:copy-of select="adressering/adresregel2"/></sub.adresBuitenland2>
                                                        <sub.adresBuitenland3><xsl:copy-of select="adressering/adresregel3"/></sub.adresBuitenland3>
                                                    </sub.verblijfBuitenland>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <verblijfsadres>
                                                        <aoa.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></aoa.identificatie>
                                                        <wpl.woonplaatsNaam><test><xsl:value-of select="substring-after(substring-after(adressering/adresregel2, ' '), ' ')"/></test></wpl.woonplaatsNaam>
                                                        <aoa.woonplaatsWaarinGelegen>
                                                            <wpl.identificatie></wpl.identificatie>
                                                            <wpl.woonplaatsNaam></wpl.woonplaatsNaam>
                                                        </aoa.woonplaatsWaarinGelegen>
                                                        <gor.identificatie/>
                                                        <opr.identificatie/>
                                                        <gor.openbareRuimteNaam><test><xsl:value-of select="replace(adressering/adresregel1, '\s*\d.*', '')"/></test></gor.openbareRuimteNaam>
                                                        <gor.straatnaam/>
                                                        <aoa.postcode>
                                                            <test>
                                                                <xsl:value-of select="replace(adressering/adresregel2, '(\d{4} [A-Z]{2}).*', '$1')"/>
                                                            </test>
                                                        </aoa.postcode>
                                                        <aoa.huisnummer><test><xsl:value-of select="replace(adressering/adresregel1, '\D', '')"/></test></aoa.huisnummer>
                                                        <aoa.huisletter><test><xsl:value-of select="substring-after(normalize-space(substring-after(adressering/adresregel1, ' ')), ' ')"/></test></aoa.huisletter>
                                                        <aoa.huisnummertoevoeging/>
                                                        <inp.locatiebeschrijving/>
                                                        <begindatumVerblijf/>
                                                    </verblijfsadres>
                                                    <sub.verblijfBuitenland doNotCreate="true"/>                                                    
                                                </xsl:otherwise>
                                            </xsl:choose>                                            
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <inp.adresHerkomst><xsl:copy-of select="verblijfplaats/functieAdres/code"/></inp.adresHerkomst>
                                    <xsl:choose>
                                        
                                        <xsl:when test="adressering/text()!=''">
                                            <sub.correspondentieAdres>
                                                <aoa.identificatie></aoa.identificatie>
                                                <authentiek doNotCreate="true"/>
                                            </sub.correspondentieAdres>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <sub.correspondentieAdres>
                                                <aoa.identificatie doNotCreate="true"/>
                                                <authentiek/>
                                            </sub.correspondentieAdres>
                                        </xsl:otherwise>
                                        
                                    </xsl:choose>
                                    
                                    <sub.telefoonnummer></sub.telefoonnummer>
                                    <sub.faxnummer></sub.faxnummer>
                                    <sub.emailadres></sub.emailadres>
                                    <sub.url></sub.url>
                                    <sub.rekeningnummerBankGiro></sub.rekeningnummerBankGiro>
                                    <inp.burgerlijkeStaat>
                                        <number>
                                            <xsl:if test="$originalMessage//BG:inp.bsn/text() !=''">
                                                <xsl:choose>
                                                    <xsl:when test="./partners !=''">
                                                        <xsl:choose>
                                                            <xsl:when test="./partners/soortVerbintenis/code/text() ='H'">
                                                                <xsl:choose>
                                                                    <xsl:when test="not(exists(./partners/ontbindingHuwelijkPartnerschap/text()))">
                                                                        <xsl:value-of select="2" />
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="3" />
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:when test="./partners/soortVerbintenis/code/text() ='P'">
                                                                <xsl:choose>
                                                                    <xsl:when test="not(exists(./partners/ontbindingHuwelijkPartnerschap/text()))">
                                                                        <xsl:value-of select="5" />
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="6" />
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="1" />
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:if>
                                        </number>
                                    </inp.burgerlijkeStaat>
                                    <inp.gemeenteVanInschrijving><xsl:copy-of select="gemeenteVanInschrijving/code"/></inp.gemeenteVanInschrijving>
                                    <inp.datumInschrijving>
                                        <test>
                                            <xsl:variable name="date" select="datumInschrijvingInGemeente/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </inp.datumInschrijving>
                                    <vbt.aanduidingVerblijfstitel><xsl:copy-of select="verblijfstitel/aanduiding/code"/></vbt.aanduidingVerblijfstitel>
                                    <ing.datumVerkrijgingVerblijfstitel><xsl:copy-of select="verblijfstitel/datumIngang/datum"/></ing.datumVerkrijgingVerblijfstitel>
                                    <ing.datumVerliesVerblijfstitel>
                                        <test>
                                            <xsl:variable name="date" select="verblijfstitel/datumEinde/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </ing.datumVerliesVerblijfstitel>
                                    <inp.datumVestigingInNederland>
                                        <test>
                                            <xsl:variable name="date" select="immigratie/datumVestigingInNederland/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </inp.datumVestigingInNederland>
                                    <inp.immigratieLand><xsl:copy-of select="immigratie/landVanwaarIngeschreven/omschrijving"/></inp.immigratieLand>
                                    <inp.datumVertrekUitNederland>
                                        <test>
                                            <xsl:variable name="date" select="immigratie/indicatieVestigingVanuitBuitenland/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </inp.datumVertrekUitNederland>
                                    <inp.emigratieLand>
                                        <test>
                                            <xsl:if
                                                test="./opschortingBijhouding/reden/code/text()='E'">
                                                
                                                <xsl:if
                                                    test="./verblijfplaats/type/text()='VerblijfplaatsBuitenland'">
                                                    <xsl:value-of
                                                        select="./verblijfplaats/verblijfadres/land/code" />
                                                </xsl:if>
                                            </xsl:if>
                                        </test>
                                    </inp.emigratieLand>
                                    <aanduidingBijzonderNederlanderschap><xsl:copy-of select="nationaliteit/aanduidingBijzonderNederlanderschap"/></aanduidingBijzonderNederlanderschap>
                                    <ing.aanduidingEuropeesKiesrecht><xsl:copy-of select="europeesKiesrecht/aanduiding/code"/></ing.aanduidingEuropeesKiesrecht>
                                    <ing.indicatieGezagMinderjarige><xsl:copy-of select="gezagsverhouding/indicatieGezagMinderjarige"/></ing.indicatieGezagMinderjarige>
                                    <ing.indicatieCurateleRegister><xsl:copy-of select="gezagsverhouding/indicatieCurateleRegister"/></ing.indicatieCurateleRegister>
                                    <inp.datumOpschortingBijhouding>
                                        <test>
                                            <xsl:variable name="date" select="opschortingBijhouding/datum/datum"/>
                                            <xsl:value-of select="translate($date, '-', '')" />
                                        </test>
                                    </inp.datumOpschortingBijhouding>
                                    <inp.redenOpschortingBijhouding>
                                        <test>
                                            <xsl:choose>
                                                <xsl:when test="opschortingBijhouding/reden/text() != ''">
                                                    <xsl:value-of select="./opschortingBijhouding/reden" />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="./overlijden/indicatieOverleden" />
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </test>
                                    </inp.redenOpschortingBijhouding>
                                    <inp.indicatieGeheim>
                                        <test>
                                            <xsl:choose>
                                                <xsl:when test="geheimhoudingPersoonsgegevens/text() ='true'">
                                                    <xsl:value-of select="7" />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="0" />
                                                </xsl:otherwise>
                                            </xsl:choose>       
                                        </test>            
                                    </inp.indicatieGeheim>
                                </object>
                            </xsl:variable>
                            <xsl:apply-templates select="$originalMessage//BG:object">
                                <xsl:with-param name="mapping" select="$mapping" />
                                <xsl:with-param name="persoon" select="." tunnel="yes"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </BG:antwoord>
                </BG:npsLa01>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="BG:stuurgegevens">
        <xsl:element name="BG:stuurgegevens">
            <StUF:berichtcode><xsl:value-of select="$berichtcode" /></StUF:berichtcode>
            <StUF:zender>
                <!-- Copy all elements inside ontvanger -->
                <xsl:for-each select="//StUF:ontvanger/*">
                    <xsl:choose>
                        <!-- If the element has no prefix or its prefix is not StUF -->
                        <xsl:when test="not(namespace-uri()) or not(starts-with(name(), 'StUF:'))">
                            <xsl:element name="StUF:{local-name()}">
                                <xsl:copy-of select="node() | @*" />
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- If the prefix is already StUF, the element is copied as is -->
                            <xsl:copy-of select="." />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </StUF:zender>
            
            <StUF:ontvanger>
                <!-- Copy all elements inside zender -->
                <xsl:for-each select="//StUF:zender/*">
                    <xsl:choose>
                        <!-- If the element has no prefix or its prefix is not StUF -->
                        <xsl:when test="not(namespace-uri()) or not(starts-with(name(), 'StUF:'))">
                            <xsl:element name="StUF:{local-name()}">
                                <xsl:copy-of select="node() | @*" />
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- If the prefix is already StUF, the element is copied as is -->
                            <xsl:copy-of select="." />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </StUF:ontvanger>       
            <!-- <StUF:tijdstipBericht>
                <xsl:value-of
                    select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
            </StUF:tijdstipBericht> -->
            <StUF:crossRefnummer>
                <xsl:value-of select="$varReferentienummer" />
            </StUF:crossRefnummer>
            <StUF:entiteittype>NPS</StUF:entiteittype>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="BG:parameters">
        <BG:parameters>
            <StUF:indicatorVervolgvraag>
                <xsl:value-of select="$indicatorVervolgvraag" />
            </StUF:indicatorVervolgvraag>
            <!-- <StUF:indicatorAfnemerIndicatie>false</StUF:indicatorAfnemerIndicatie> -->
            <StUF:aantalVoorkomens>
                <xsl:value-of select="$aantalVoorkomens" />
            </StUF:aantalVoorkomens>     
        </BG:parameters>     
    </xsl:template>
    
    <xsl:template match="BG:object">
        <xsl:param name="mapping"/>
        <xsl:param name="persoon" tunnel="yes"/>
        <BG:object StUF:entiteittype="NPS">
            <xsl:attribute name="StUF:sleutelVerzendend" select="$sleutelVerzendend"/>
            <xsl:apply-templates select="*[not(local-name() = ('inp.heeftAlsOuders', 'inp.heeftAlsKinderen', 'inp.heeftAlsEchtgenootPartner', 'inp.heeftAlsNationaliteit'))]">
                <xsl:with-param name="mapping" select="$mapping/object"/>
                <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="$persoon/partners"/>
            <xsl:apply-templates select="$persoon/kinderen"/>
            <xsl:apply-templates select="$persoon/ouders"/>     
            <xsl:apply-templates select="$persoon/nationaliteiten"/>        
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
        <xsl:param name="authorizedApplicationsMap" as="node()?" />
        <xsl:param name="prefix">BG</xsl:param>
        
        <xsl:variable name="mappedElement" select="$mapping/*[name()=current()/local-name()]" />
        <xsl:variable name="newAuthorizedApplicationsMap" select="$authorizedApplicationsMap/*[name()=current()/local-name()]" />
        
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
            <xsl:element name="{$prefix}:{local-name()}" exclude-result-prefixes=""> <!-- Adding prefix -->
                <!-- Copy all attributes except a:entiteittype -->
                <xsl:copy-of select="@*[not(name() = 'a:entiteittype')]" />                
                <!-- Rename a:entiteittype to stuf:entiteittype -->
                <xsl:if test="@a:entiteittype">
                    <xsl:attribute name="StUF:entiteittype">
                        <xsl:value-of select="@a:entiteittype"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="*">
                    <xsl:with-param name="mapping" select="$mappedElement" />
                    <xsl:with-param name="authorizedApplicationsMap" select="$newAuthorizedApplicationsMap" />
                    <xsl:with-param name="prefix" select="$prefix" /> <!-- Passing prefix to child elements -->
                </xsl:apply-templates>
            </xsl:element>
        </xsl:if>
    </xsl:template>    
    
    <xsl:template match="BG:object//*[not(*)]">
        <xsl:param name="mapping" />
        <xsl:param name="authorizedApplicationsMap" as="node()?"/>
        <xsl:variable name="mappedElement" select="$mapping/*[name()=current()/local-name()]"/>
        <xsl:variable name="authorizedApplications" select="$authorizedApplicationsMap/*[name()=current()/local-name()]"/>
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">            
            <xsl:choose>
                <xsl:when test="not(exists($authorizedApplications/@authorizedApplications)) or contains($authorizedApplications/@authorizedApplications, $varZenderApplicatie)">
                    
                    <xsl:element name="BG:{$mappedElement/local-name()}">
                        <xsl:choose>
                            <xsl:when test="$mappedElement/*/text() != ''">
                                <xsl:value-of select="$mappedElement/*" />
                            </xsl:when>
                            <xsl:when test="$mappedElement/*/text() = ''">
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>    
                                <xsl:attribute name="xsi:nil">true</xsl:attribute>                       
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$geenWaarde" /></xsl:attribute>  
                                <xsl:attribute name="xsi:nil">true</xsl:attribute>                          
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="BG:{$mappedElement/local-name()}">
                        <xsl:attribute name="xsi:nil">true</xsl:attribute>
                        <xsl:attribute
                            name="StUF:noValue"><xsl:value-of
                                select="$nietGeautoriseerd" /></xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>            
        </xsl:if>        
    </xsl:template>
    
    <xsl:template match="partners">
        <xsl:variable name="mapping">
            <inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn />
                            <authentiek doNotCreate="true"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>  
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <geslachtsnaamPartner><test><xsl:value-of select="$geslachtsnaam"/></test></geslachtsnaamPartner>
                    <voorvoegselGeslachtsnaamPartner><test><xsl:value-of select="$voorvoegsel"/></test></voorvoegselGeslachtsnaamPartner>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
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
                                <aoa.identificatie></aoa.identificatie>
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
                            <sub.correspondentieAdres>
                                <aoa.identificatie></aoa.identificatie>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres>
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.burgerlijkeStaat>
                        <number>
                            <xsl:choose>
                                <xsl:when
                                    test=". !=''">
                                    <xsl:choose>
                                        <xsl:when
                                            test="./soortVerbintenis/code/text() ='H'">
                                            <xsl:choose>
                                                <xsl:when test="not(exists(./ontbindingHuwelijkPartnerschap/text()))">
                                                    <xsl:value-of select="2" />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="3" />
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:when
                                            test="./soortVerbintenis/code/text() ='P'">
                                            <xsl:choose>
                                                <xsl:when test="not(exists(./ontbindingHuwelijkPartnerschap/text()))">
                                                    <xsl:value-of select="5" />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="6" />
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
                </gerelateerde>
                <inp.indicatieGeheim>
                    <test>
                        <xsl:choose>
                            <xsl:when test="geheimhoudingPersoonsgegevens/text() ='true'">
                                <xsl:value-of select="7" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="0" />
                            </xsl:otherwise>
                        </xsl:choose>       
                    </test>             
                </inp.indicatieGeheim>
                <soortVerbintenis><xsl:copy-of select="soortVerbintenis/code"/></soortVerbintenis>
            </inp.heeftAlsEchtgenootPartner>
        </xsl:variable>
        <xsl:apply-templates select="$originalMessage//BG:inp.heeftAlsEchtgenootPartner">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="kinderen">
        <xsl:variable name="mapping">
            <inp.heeftAlsKinderen StUF:entiteittype="NPSNPSKND">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn />
                            <authentiek doNotCreate="true"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <aanduidingNaamgebruik></aanduidingNaamgebruik>
                    <aanhefAanschrijving></aanhefAanschrijving>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
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
                            <sub.correspondentieAdres>
                                <aoa.identificatie/>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres>
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.indicatieGeheim>
                        <test>
                            <xsl:choose>
                                <xsl:when test="geheimhoudingPersoonsgegevens/text() ='true'">
                                    <xsl:value-of select="7" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="0" />
                                </xsl:otherwise>
                            </xsl:choose>       
                        </test>                      
                    </inp.indicatieGeheim>
                </gerelateerde>
            </inp.heeftAlsKinderen>
        </xsl:variable>
        <xsl:apply-templates select="$originalMessage//BG:inp.heeftAlsKinderen">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="ouders">
        <xsl:variable name="mapping">
            <inp.heeftAlsOuders StUF:entiteittype="NPSNPSOUD">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn />
                            <authentiek doNotCreate="true"/>
                        </xsl:otherwise>
                    </xsl:choose>                    
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>  
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
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
                            <sub.correspondentieAdres>
                                <aoa.identificatie/>
                                <authentiek doNotCreate="true"/>
                            </sub.correspondentieAdres>
                        </xsl:when>
                        <xsl:otherwise>
                            <sub.correspondentieAdres>
                                <aoa.identificatie doNotCreate="true"/>
                                <authentiek/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
                    <inp.indicatieGeheim>
                        <test>
                            <xsl:choose>
                                <xsl:when test="geheimhoudingPersoonsgegevens/text() ='true'">
                                    <xsl:value-of select="7" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="0" />
                                </xsl:otherwise>
                            </xsl:choose>       
                        </test>                    
                    </inp.indicatieGeheim>
                </gerelateerde>
                <ouderAanduiding>
                    <test>
                        <xsl:value-of select="concat('Ouder',./ouderAanduiding)" />
                    </test>
                </ouderAanduiding>
                <datumIngangFamilierechtelijkeBetrekking>
                    <test>
                        <xsl:variable name="date" select="datumIngangFamilierechtelijkeBetrekking/datum"/>
                        <xsl:value-of select="translate($date, '-', '')" />
                    </test>
                </datumIngangFamilierechtelijkeBetrekking>
            </inp.heeftAlsOuders>
        </xsl:variable>
        <xsl:apply-templates select="$originalMessage//BG:inp.heeftAlsOuders">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="nationaliteiten">
        <xsl:variable name="mapping">
            <inp.heeftAlsNationaliteit StUF:entiteittype="NPSNAT" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NAT" StUF:verwerkingssoort="T">
                    <code><number><xsl:value-of select="number(nationaliteit/code)"/></number></code>
                    <omschrijving><xsl:copy-of select="nationaliteit/omschrijving"/></omschrijving>
                </gerelateerde>
                <inp.redenVerkrijging><xsl:copy-of select="redenOpname/code"/></inp.redenVerkrijging>
                <inp.datumVerkrijging>
                    <test>
                        <xsl:variable name="date" select="datumIngangGeldigheid/datum"/>
                        <xsl:value-of select="translate($date, '-', '')" />
                    </test>
                </inp.datumVerkrijging>
            </inp.heeftAlsNationaliteit>
        </xsl:variable>
        <xsl:apply-templates select="$originalMessage//BG:inp.heeftAlsNationaliteit">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>