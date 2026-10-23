<?xml version="1.0" encoding="UTF-8"?>
<!--
    mappingJsonToStuf.xslt

    Gedeelde mapping van BRP-personen (JSON omgezet naar XML, /root/personen) naar StUF-BG 0310 NPS.
    Gebruikt door:
      - brp-personen-bevragen-soap                  -> npsLa01 (antwoord op een npsLv01-vraag)
      - subscription-management-and-processing      -> npsLk01 (kennisgeving)

    De berichtsoort wordt automatisch bepaald:
      - bevat $originalMessage een BG:npsLv01  -> npsLa01, met de vraag als sjabloon
      - anders                                 -> npsLk01, met $inputnpsLk01 (default npsLk01.xml) als sjabloon

    Welke elementen in de output komen wordt bepaald door het sjabloonbericht (vraag of npsLk01.xml):
    de mapping hieronder mag dus elementen bevatten die maar in één van beide sjablonen voorkomen
    (bijv. oao.identificatie vs. aoa.identificatie in adresAanduidingGrp).
-->
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
                xmlns:local="http://frankframework.org/xpath-functions"
                exclude-result-prefixes="xsd local">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

    <!-- ===================================================================== -->
    <!-- Parameters                                                            -->
    <!-- ===================================================================== -->

    <!-- Gemeenschappelijk -->
    <xsl:param name="aantalVoorkomens"><xsl:value-of select="count(/root/personen)"/></xsl:param>
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="sleutelVerzendend"/>
    <xsl:param name="geslachtsnaam"><xsl:value-of select="/root/personen/naam/geslachtsnaam"/></xsl:param>
    <xsl:param name="voorvoegsel"><xsl:value-of select="count(/root/personen/naam/voorvoegsel)"/></xsl:param>

    <!-- Alleen voor npsLa01 (brp-personen-bevragen-soap) -->
    <xsl:param name="berichtcode">La01</xsl:param>
    <xsl:param name="varReferentienummer" />
    <xsl:param name="indicatorVervolgvraag" />
    <xsl:param name="originalMessage" as="node()?"/>

    <!-- Alleen voor npsLk01 (subscription-management-and-processing) -->
    <xsl:param name="gebruiker" />
    <xsl:param name="administratie" />
    <xsl:param name="referentienummer" />
    <xsl:param name="organisatie"/>
    <xsl:param name="mutatiesoort"/>
    <xsl:param name="sleutelOntvangend"/>
    <xsl:param name="inputnpsLk01" as="node()?"
               select="if (doc-available('npsLk01.xml')) then document('npsLk01.xml') else ()"/>
    <xsl:param name="bagkeys"/>

    <!-- ===================================================================== -->
    <!-- Variabelen                                                            -->
    <!-- ===================================================================== -->

    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>
    <!-- true = npsLa01 (antwoord op npsLv01), false = npsLk01 (kennisgeving) -->
    <xsl:variable name="isVraagAntwoord" as="xsd:boolean" select="exists($originalMessage//BG:npsLv01)"/>
    <!-- De autorisaties per berichtsoort zijn (nog) niet gelijk, daarom een map per berichtsoort -->
    <xsl:variable name="authorizedApplicationsMap" as="node()?"
                  select="if ($isVraagAntwoord) then document('authorizedApplicationsMap_npsLa01.xml') else document('authorizedApplicationsMap_npsLk01.xml')"/>
    <!-- Het sjabloonbericht waarvan de structuur gevolgd wordt -->
    <xsl:variable name="bronBericht" as="node()?"
                  select="if ($isVraagAntwoord) then $originalMessage else $inputnpsLk01"/>

    <!-- ===================================================================== -->
    <!-- Functies                                                              -->
    <!-- ===================================================================== -->

    <xsl:function name="local:formatteer-datum" as="xsd:string">
        <xsl:param name="d" as="element()?"/>
        <xsl:choose>
            <xsl:when test="$d/type = 'Datum'">
                <xsl:sequence select="translate($d/datum, '-', '')"/>
            </xsl:when>
            <xsl:when test="$d/type = 'JaarMaandDatum'">
                <xsl:sequence select="concat(format-number(number($d/jaar), '0000'),
                                         format-number(number($d/maand), '00'), '00')"/>
            </xsl:when>
            <xsl:when test="$d/type = 'JaarDatum'">
                <xsl:sequence select="concat(format-number(number($d/jaar), '0000'), '0000')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- Waarde voor aoa.identificatie:
         - zijn er bagkeys meegegeven (npsLk01), dan de KEY die bij het BAG-id hoort;
         - anders (npsLa01) het BAG-id zelf. -->
    <xsl:function name="local:aoa-identificatie" as="xsd:string">
        <xsl:param name="bagId"/>
        <xsl:sequence select="if ($bagkeys instance of node())
                              then string-join($bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = $bagId]/field[@name = 'KEY'], ' ')
                              else string($bagId[1])"/>
    </xsl:function>

    <!-- ===================================================================== -->
    <!-- Ingang                                                                -->
    <!-- ===================================================================== -->

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$isVraagAntwoord">
                <xsl:apply-templates select="$originalMessage//BG:npsLv01">
                    <xsl:with-param name="personen" select="root/personen"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="exists($inputnpsLk01//BG:npsLk01)">
                <xsl:apply-templates select="$inputnpsLk01//BG:npsLk01">
                    <xsl:with-param name="personen" select="root/personen"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">mappingJsonToStuf: geen BG:npsLv01 in $originalMessage en geen BG:npsLk01-sjabloon (npsLk01.xml / $inputnpsLk01) gevonden.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- npsLv01 -> npsLa01 -->
    <xsl:template match="BG:npsLv01">
        <xsl:param name="personen"/>
        <BG:npsLa01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
            <xsl:apply-templates select="BG:stuurgegevens"/>
            <xsl:apply-templates select="BG:parameters"/>
            <xsl:choose>
                <xsl:when test="$aantalVoorkomens = 0">
                    <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
                </xsl:when>
                <xsl:otherwise>
                    <BG:antwoord>
                        <xsl:call-template name="personen-naar-objecten">
                            <xsl:with-param name="personen" select="$personen"/>
                        </xsl:call-template>
                    </BG:antwoord>
                </xsl:otherwise>
            </xsl:choose>
        </BG:npsLa01>
    </xsl:template>

    <!-- npsLk01-sjabloon -> npsLk01 -->
    <xsl:template match="BG:npsLk01">
        <xsl:param name="personen"/>
        <BG:npsLk01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
            <xsl:apply-templates select="BG:stuurgegevens"/>
            <xsl:apply-templates select="BG:parameters"/>
            <xsl:choose>
                <xsl:when test="$aantalVoorkomens = 0">
                    <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="personen-naar-objecten">
                        <xsl:with-param name="personen" select="$personen"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </BG:npsLk01>
    </xsl:template>

    <!-- ===================================================================== -->
    <!-- Mapping persoon -> BG:object                                          -->
    <!-- ===================================================================== -->

    <xsl:template name="personen-naar-objecten">
        <xsl:param name="personen"/>
        <xsl:for-each select="$personen">
            <xsl:variable name="mapping">
                <object StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:when test="$isVraagAntwoord">
                            <!-- npsLa01: zonder BSN geen inp.bsn, wel authentiek -->
                            <inp.bsn doNotCreate="true"/>
                            <authentiek/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- npsLk01: lege inp.bsn, geen authentiek -->
                            <inp.bsn/>
                            <authentiek doNotCreate="true"/>
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
                                    <xsl:value-of select="concat(naam/geslachtsnaam, '-', partners/naam/geslachtsnaam)" />
                                </xsl:when>
                                <xsl:when test="naam/aanduidingNaamgebruik/code = 'P'">
                                    <xsl:value-of select="partners/naam/geslachtsnaam" />
                                </xsl:when>
                                <xsl:when test="naam/aanduidingNaamgebruik/code = 'V'">
                                    <xsl:value-of select="concat(partners/naam/geslachtsnaam, '-', naam/geslachtsnaam)" />
                                </xsl:when>
                            </xsl:choose>
                        </text>
                    </geslachtsnaamAanschrijving>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                    <geboortedatum>
                        <test><xsl:value-of select="translate(geboorte/datum/datum, '-', '')" /></test>
                    </geboortedatum>
                    <inp.geboorteplaats><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
                    <inp.geboorteLand><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
                    <overlijdensdatum>
                        <test><xsl:value-of select="translate(overlijden/datum/datum, '-', '')" /></test>
                    </overlijdensdatum>
                    <inp.overlijdenplaats><xsl:copy-of select="overlijden/plaats/omschrijving"/></inp.overlijdenplaats>
                    <inp.overlijdenLand><xsl:copy-of select="overlijden/land/code"/></inp.overlijdenLand>
                    <inp.verblijftIn StUF:entiteittype="NPSTGO">
                        <gerelateerde StUF:entiteittype="TGO">
                            <adresAanduidingGrp>
                                <xsl:call-template name="adres-identificatie">
                                    <xsl:with-param name="oaoAlleenIndienGevuld" select="true()"/>
                                </xsl:call-template>

                                <wpl.woonplaatsNaam>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/woonplaats)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel2)">
                                            <dummy><xsl:value-of select="substring-after(substring-after(adressering/adresregel2, ' '), ' ')"/></dummy>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </wpl.woonplaatsNaam>

                                <aoa.woonplaatsWaarinGelegen>
                                    <wpl.woonplaatsNaam>
                                        <xsl:copy-of select="verblijfplaats/verblijfadres/woonplaats"/>
                                    </wpl.woonplaatsNaam>
                                </aoa.woonplaatsWaarinGelegen>

                                <gor.identificatie/>
                                <opr.identificatie/>

                                <gor.openbareRuimteNaam>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/officieleStraatnaam)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/officieleStraatnaam"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel1)">
                                            <dummy><xsl:value-of select="replace(adressering/adresregel1, '\s*\d.*', '')"/></dummy>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </gor.openbareRuimteNaam>

                                <gor.straatnaam>
                                    <xsl:copy-of select="verblijfplaats/verblijfadres/korteStraatnaam"/>
                                </gor.straatnaam>

                                <aoa.postcode>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/postcode)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/postcode"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel2)">
                                            <dummy><xsl:value-of select="replace(adressering/adresregel2, '(\d{4}\s*[A-Za-z]{2}).*', '$1')"/></dummy>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </aoa.postcode>

                                <aoa.huisnummer>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/huisnummer)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/huisnummer"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel1)">
                                            <xsl:analyze-string select="normalize-space(adressering/adresregel1)" regex=".*\s+(\d+)\s*([a-zA-Z0-9-]+)?">
                                                <xsl:matching-substring>
                                                    <dummy><xsl:value-of select="regex-group(1)"/></dummy>
                                                </xsl:matching-substring>
                                            </xsl:analyze-string>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </aoa.huisnummer>

                                <aoa.huisletter>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/huisletter)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/huisletter"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel1)">
                                            <xsl:call-template name="huisletter-uit-adresregel"/>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </aoa.huisletter>

                                <aoa.huisnummertoevoeging>
                                    <xsl:copy-of select="verblijfplaats/verblijfadres/huisnummertoevoeging"/>
                                </aoa.huisnummertoevoeging>

                                <ogo.locatieAanduiding>
                                    <xsl:choose>
                                        <xsl:when test="string(verblijfplaats/verblijfadres/locatiebeschrijving)">
                                            <xsl:copy-of select="verblijfplaats/verblijfadres/locatiebeschrijving"/>
                                        </xsl:when>
                                        <xsl:when test="string(adressering/adresregel3)">
                                            <dummy><xsl:copy-of select="adressering/adresregel3"/></dummy>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </ogo.locatieAanduiding>
                            </adresAanduidingGrp>
                        </gerelateerde>
                        <StUF:tijdvakRelatie>
                            <StUF:beginRelatie>
                                <test><xsl:value-of select="local:formatteer-datum(verblijfplaats/datumVan)" /></test>
                            </StUF:beginRelatie>
                            <StUF:eindRelatie>
                                <test><xsl:value-of select="local:formatteer-datum(verblijfplaats/datumTot)" /></test>
                            </StUF:eindRelatie>
                        </StUF:tijdvakRelatie>
                    </inp.verblijftIn>
                    <xsl:choose>
                        <xsl:when test="./verblijfplaats/type/text() = 'Adres'">
                            <verblijfsadres>
                                <aoa.identificatie><test><xsl:value-of select="local:aoa-identificatie(verblijfplaats/adresseerbaarObjectIdentificatie)"/></test></aoa.identificatie>
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
                                    <test><xsl:value-of select="translate(verblijfplaats/datumVan/datum, '-', '')" /></test>
                                </begindatumVerblijf>
                            </verblijfsadres>
                            <sub.verblijfBuitenland doNotCreate="true"/>
                        </xsl:when>
                        <xsl:when test="./verblijfplaats/type/text() = 'VerblijfplaatsBuitenland'">
                            <verblijfsadres doNotCreate="true"/>
                            <sub.verblijfBuitenland>
                                <lnd.landcode><xsl:copy-of select="verblijfplaats/verblijfadres/land/code"/></lnd.landcode>
                                <lnd.landnaam><xsl:copy-of select="verblijfplaats/verblijfadres/land/omschrijving"/></lnd.landnaam>
                                <sub.adresBuitenland1><xsl:copy-of select="verblijfplaats/verblijfadres/regel1"/></sub.adresBuitenland1>
                                <sub.adresBuitenland2><xsl:copy-of select="verblijfplaats/verblijfadres/regel2"/></sub.adresBuitenland2>
                                <sub.adresBuitenland3><xsl:copy-of select="verblijfplaats/verblijfadres/regel3"/></sub.adresBuitenland3>
                            </sub.verblijfBuitenland>
                        </xsl:when>
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
                                <aoa.identificatie><test><xsl:value-of select="local:aoa-identificatie(verblijfplaats/adresseerbaarObjectIdentificatie)"/></test></aoa.identificatie>
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
                                    <test><xsl:value-of select="replace(adressering/adresregel2, '(\d{4} [A-Z]{2}).*', '$1')"/></test>
                                </aoa.postcode>
                                <aoa.huisnummer><test><xsl:value-of select="replace(adressering/adresregel1, '\D', '')"/></test></aoa.huisnummer>
                                <aoa.huisletter><xsl:call-template name="huisletter-uit-adresregel"/></aoa.huisletter>
                                <aoa.huisnummertoevoeging/>
                                <inp.locatiebeschrijving/>
                                <begindatumVerblijf/>
                            </verblijfsadres>
                            <sub.verblijfBuitenland doNotCreate="true"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <inp.adresHerkomst><xsl:copy-of select="verblijfplaats/functieAdres/code"/></inp.adresHerkomst>
                    <xsl:call-template name="correspondentieadres"/>
                    <sub.telefoonnummer></sub.telefoonnummer>
                    <sub.faxnummer></sub.faxnummer>
                    <sub.emailadres></sub.emailadres>
                    <sub.url></sub.url>
                    <sub.rekeningnummerBankGiro></sub.rekeningnummerBankGiro>
                    <inp.burgerlijkeStaat>
                        <number>
                            <!-- Bij npsLa01 alleen invullen als er op BSN gevraagd is -->
                            <xsl:if test="not($isVraagAntwoord) or $originalMessage//BG:inp.bsn/text() != ''">
                                <xsl:choose>
                                    <xsl:when test="./partners != ''">
                                        <xsl:call-template name="burgerlijke-staat">
                                            <xsl:with-param name="verbintenis" select="./partners"/>
                                        </xsl:call-template>
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
                        <test><xsl:value-of select="translate(datumInschrijvingInGemeente/datum, '-', '')" /></test>
                    </inp.datumInschrijving>
                    <vbt.aanduidingVerblijfstitel><xsl:copy-of select="verblijfstitel/aanduiding/code"/></vbt.aanduidingVerblijfstitel>
                    <ing.datumVerkrijgingVerblijfstitel>
                        <test><xsl:value-of select="translate(verblijfstitel/datumIngang/datum, '-', '')" /></test>
                    </ing.datumVerkrijgingVerblijfstitel>
                    <ing.datumVerliesVerblijfstitel>
                        <test><xsl:value-of select="translate(verblijfstitel/datumEinde/datum, '-', '')" /></test>
                    </ing.datumVerliesVerblijfstitel>
                    <inp.datumVestigingInNederland>
                        <test><xsl:value-of select="translate(immigratie/datumVestigingInNederland/datum, '-', '')" /></test>
                    </inp.datumVestigingInNederland>
                    <inp.immigratieLand><xsl:copy-of select="immigratie/landVanwaarIngeschreven/omschrijving"/></inp.immigratieLand>
                    <inp.datumVertrekUitNederland>
                        <test><xsl:value-of select="translate(immigratie/indicatieVestigingVanuitBuitenland/datum, '-', '')" /></test>
                    </inp.datumVertrekUitNederland>
                    <inp.emigratieLand>
                        <test>
                            <xsl:if test="./opschortingBijhouding/reden/code/text() = 'E'
                                          and ./verblijfplaats/type/text() = 'VerblijfplaatsBuitenland'">
                                <xsl:value-of select="./verblijfplaats/verblijfadres/land/code" />
                            </xsl:if>
                        </test>
                    </inp.emigratieLand>
                    <aanduidingBijzonderNederlanderschap><xsl:copy-of select="nationaliteit/aanduidingBijzonderNederlanderschap"/></aanduidingBijzonderNederlanderschap>
                    <ing.aanduidingEuropeesKiesrecht><xsl:copy-of select="europeesKiesrecht/aanduiding/code"/></ing.aanduidingEuropeesKiesrecht>
                    <!-- Check if this value is returned correctly, or if a child <code> element is expected instead -->
                    <ing.indicatieGezagMinderjarige>
                        <test>
                            <xsl:choose>
                                <xsl:when test="//gezag/type/text() = 'GezamenlijkOuderlijkGezag'">12</xsl:when>
                                <xsl:when test="//gezag/type/text() = 'GezamenlijkGezag'">
                                    <xsl:value-of select="concat(//ouders[burgerservicenummer = //gezag/ouder[1]/burgerservicenummer]/ouderAanduiding, 'D')"/>
                                </xsl:when>
                                <xsl:when test="//gezag/type/text() = 'EenhoofdigOuderlijkGezag'">
                                    <xsl:value-of select="//ouders[burgerservicenummer = //gezag/ouder[1]/burgerservicenummer]/ouderAanduiding"/>
                                </xsl:when>
                                <xsl:when test="//gezag/type/text() = 'Voogdij'">D</xsl:when>
                            </xsl:choose>
                        </test>
                    </ing.indicatieGezagMinderjarige>
                    <ing.indicatieCurateleRegister><xsl:copy-of select="gezagsverhouding/indicatieCurateleRegister"/></ing.indicatieCurateleRegister>
                    <inp.datumOpschortingBijhouding>
                        <test><xsl:value-of select="translate(opschortingBijhouding/datum/datum, '-', '')" /></test>
                    </inp.datumOpschortingBijhouding>
                    <inp.redenOpschortingBijhouding>
                        <test>
                            <xsl:choose>
                                <xsl:when test="normalize-space(opschortingBijhouding/reden/code) != ''">
                                    <xsl:value-of select="opschortingBijhouding/reden/code" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="overlijden/indicatieOverleden" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </test>
                    </inp.redenOpschortingBijhouding>
                    <xsl:call-template name="indicatie-geheim"/>
                </object>
            </xsl:variable>
            <xsl:apply-templates select="$bronBericht//BG:object">
                <xsl:with-param name="mapping" select="$mapping" />
                <xsl:with-param name="persoon" select="." tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <!-- ===================================================================== -->
    <!-- Hulptemplates voor de mapping (context = persoon/partner/kind/ouder)  -->
    <!-- ===================================================================== -->

    <!-- num.identificatie / oao.identificatie (npsLa01) / aoa.identificatie (npsLk01) binnen adresAanduidingGrp.
         Alleen de elementen die in het sjabloonbericht voorkomen komen in de output. -->
    <xsl:template name="adres-identificatie">
        <!-- persoon: oao.identificatie weglaten als er geen adresseerbaarObjectIdentificatie is;
             partner/kind/ouder: oao.identificatie altijd aanmaken (zoals in de originelen) -->
        <xsl:param name="oaoAlleenIndienGevuld" as="xsd:boolean" select="false()"/>
        <xsl:choose>
            <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie) != 0">
                <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                <oao.identificatie doNotCreate="true"/>
                <aoa.identificatie doNotCreate="true"/>
            </xsl:when>
            <xsl:otherwise>
                <num.identificatie doNotCreate="true"/>
                <xsl:choose>
                    <xsl:when test="$oaoAlleenIndienGevuld and string-length(verblijfplaats/adresseerbaarObjectIdentificatie) = 0">
                        <oao.identificatie doNotCreate="true"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <oao.identificatie><xsl:copy-of select="verblijfplaats/adresseerbaarObjectIdentificatie"/></oao.identificatie>
                    </xsl:otherwise>
                </xsl:choose>
                <aoa.identificatie><test><xsl:value-of select="local:aoa-identificatie(verblijfplaats/adresseerbaarObjectIdentificatie)"/></test></aoa.identificatie>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="huisletter-uit-adresregel">
        <xsl:analyze-string select="normalize-space(adressering/adresregel1)" regex=".*\s+\d+\s+([a-zA-Z0-9-]+)">
            <xsl:matching-substring>
                <dummy><xsl:value-of select="regex-group(1)"/></dummy>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template name="correspondentieadres">
        <xsl:choose>
            <xsl:when test="adressering/text() != ''">
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
    </xsl:template>

    <!-- 2/3 = huwelijk (actief/ontbonden), 5/6 = geregistreerd partnerschap (actief/ontbonden) -->
    <xsl:template name="burgerlijke-staat">
        <xsl:param name="verbintenis"/>
        <xsl:choose>
            <xsl:when test="$verbintenis/soortVerbintenis/code/text() = 'H'">
                <xsl:value-of select="if (not(exists($verbintenis/ontbindingHuwelijkPartnerschap/text()))) then 2 else 3"/>
            </xsl:when>
            <xsl:when test="$verbintenis/soortVerbintenis/code/text() = 'P'">
                <xsl:value-of select="if (not(exists($verbintenis/ontbindingHuwelijkPartnerschap/text()))) then 5 else 6"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="indicatie-geheim">
        <inp.indicatieGeheim>
            <test><xsl:value-of select="if (geheimhoudingPersoonsgegevens/text() = 'true') then 7 else 0"/></test>
        </inp.indicatieGeheim>
    </xsl:template>

    <xsl:template name="gerelateerde-bsn">
        <xsl:choose>
            <xsl:when test="burgerservicenummer/text() != ''">
                <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
            </xsl:when>
            <xsl:otherwise>
                <inp.bsn/>
            </xsl:otherwise>
        </xsl:choose>
        <authentiek doNotCreate="true"/>
    </xsl:template>

    <xsl:template name="gerelateerde-geboorte">
        <geboortedatum>
            <test><xsl:value-of select="translate(geboorte/datum/datum, '-', '')" /></test>
        </geboortedatum>
        <inp.geboorteplaats><xsl:copy-of select="geboorte/plaats/omschrijving"/></inp.geboorteplaats>
        <inp.geboorteLand><xsl:copy-of select="geboorte/land/code"/></inp.geboorteLand>
    </xsl:template>

    <xsl:template name="gerelateerde-verblijf">
        <!-- Alleen bij partners wordt verblijfsadres/aoa.identificatie gemapt (zoals in beide originelen) -->
        <xsl:param name="metAoaIdentificatie" as="xsd:boolean" select="false()"/>
        <inp.verblijftIn>
            <gerelateerde>
                <adresAanduidingGrp>
                    <xsl:call-template name="adres-identificatie"/>
                </adresAanduidingGrp>
            </gerelateerde>
        </inp.verblijftIn>
        <xsl:choose>
            <xsl:when test="./verblijfplaats/type = 'Adres'">
                <verblijfsadres>
                    <xsl:if test="$metAoaIdentificatie"><aoa.identificatie/></xsl:if>
                </verblijfsadres>
                <sub.verblijfBuitenland doNotCreate="true"/>
            </xsl:when>
            <xsl:otherwise>
                <verblijfsadres doNotCreate="true"/>
                <sub.verblijfBuitenland/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="correspondentieadres"/>
    </xsl:template>

    <!-- ===================================================================== -->
    <!-- Stuurgegevens en parameters                                           -->
    <!-- ===================================================================== -->

    <xsl:template match="BG:stuurgegevens">
        <xsl:element name="BG:stuurgegevens">
            <xsl:choose>
                <xsl:when test="$isVraagAntwoord">
                    <StUF:berichtcode><xsl:value-of select="$berichtcode" /></StUF:berichtcode>
                    <!-- zender en ontvanger van de vraag worden omgedraaid -->
                    <StUF:zender>
                        <xsl:call-template name="kopieer-als-stuf">
                            <xsl:with-param name="elementen" select="//StUF:ontvanger/*"/>
                        </xsl:call-template>
                    </StUF:zender>
                    <StUF:ontvanger>
                        <xsl:call-template name="kopieer-als-stuf">
                            <xsl:with-param name="elementen" select="//StUF:zender/*"/>
                        </xsl:call-template>
                    </StUF:ontvanger>
                    <StUF:crossRefnummer><xsl:value-of select="$varReferentienummer" /></StUF:crossRefnummer>
                </xsl:when>
                <xsl:otherwise>
                    <StUF:berichtcode>Lk01</StUF:berichtcode>
                    <StUF:zender>
                        <StUF:organisatie>NEDGR</StUF:organisatie>
                        <StUF:applicatie>NEDMAG_OPT</StUF:applicatie>
                    </StUF:zender>
                    <StUF:ontvanger>
                        <StUF:organisatie><xsl:value-of select="$organisatie" /></StUF:organisatie>
                        <StUF:applicatie><xsl:value-of select="$varZenderApplicatie" /></StUF:applicatie>
                        <StUF:administratie><xsl:value-of select="$administratie" /></StUF:administratie>
                        <StUF:gebruiker><xsl:value-of select="$gebruiker" /></StUF:gebruiker>
                    </StUF:ontvanger>
                    <StUF:referentienummer><xsl:value-of select="$referentienummer" /></StUF:referentienummer>
                    <StUF:tijdstipBericht>
                        <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
                    </StUF:tijdstipBericht>
                </xsl:otherwise>
            </xsl:choose>
            <StUF:entiteittype>NPS</StUF:entiteittype>
        </xsl:element>
    </xsl:template>

    <!-- Kopieert elementen naar de StUF-namespace als ze daar nog niet in zitten -->
    <xsl:template name="kopieer-als-stuf">
        <xsl:param name="elementen"/>
        <xsl:for-each select="$elementen">
            <xsl:choose>
                <xsl:when test="not(namespace-uri()) or not(starts-with(name(), 'StUF:'))">
                    <xsl:element name="StUF:{local-name()}">
                        <xsl:copy-of select="node() | @*" />
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="." />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="BG:parameters">
        <BG:parameters>
            <xsl:choose>
                <xsl:when test="$isVraagAntwoord">
                    <StUF:indicatorVervolgvraag><xsl:value-of select="$indicatorVervolgvraag" /></StUF:indicatorVervolgvraag>
                    <StUF:aantalVoorkomens><xsl:value-of select="$aantalVoorkomens" /></StUF:aantalVoorkomens>
                </xsl:when>
                <xsl:otherwise>
                    <StUF:mutatiesoort><xsl:value-of select="$mutatiesoort"/></StUF:mutatiesoort>
                    <StUF:indicatorOvername>V</StUF:indicatorOvername>
                </xsl:otherwise>
            </xsl:choose>
        </BG:parameters>
    </xsl:template>

    <!-- ===================================================================== -->
    <!-- Generieke opbouw van BG:object op basis van het sjabloonbericht       -->
    <!-- ===================================================================== -->

    <xsl:template match="BG:object">
        <xsl:param name="mapping"/>
        <xsl:param name="persoon" tunnel="yes"/>
        <BG:object StUF:entiteittype="NPS">
            <xsl:if test="not($isVraagAntwoord)">
                <xsl:attribute name="StUF:verwerkingssoort" select="$mutatiesoort"/>
            </xsl:if>
            <xsl:attribute name="StUF:sleutelVerzendend" select="$sleutelVerzendend"/>
            <xsl:if test="not($isVraagAntwoord)">
                <xsl:attribute name="StUF:sleutelOntvangend" select="$sleutelOntvangend"/>
            </xsl:if>
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

    <!-- Elementen binnen object met kindelementen: attributen worden gekopieerd -->
    <xsl:template match="BG:object//*[*]">
        <xsl:param name="mapping" />
        <xsl:param name="authorizedApplicationsMap" as="node()?" />
        <xsl:variable name="mappedElement" select="$mapping/*[local-name()=current()/local-name()]" />
        <xsl:variable name="newAuthorizedApplicationsMap" select="$authorizedApplicationsMap/*[name()=current()/local-name()]" />
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
            <xsl:element name="{if (namespace-uri($mappedElement) != '') then name($mappedElement) else concat('BG:', local-name($mappedElement))}"
                         namespace="{if (namespace-uri($mappedElement) != '') then namespace-uri($mappedElement) else 'http://www.egem.nl/StUF/sector/bg/0310'}">
                <!-- Alle attributen behalve a:entiteittype kopiëren; a:entiteittype wordt StUF:entiteittype -->
                <xsl:copy-of select="@*[not(name() = 'a:entiteittype')]" />
                <xsl:if test="@a:entiteittype">
                    <xsl:attribute name="StUF:entiteittype" select="@a:entiteittype"/>
                </xsl:if>
                <xsl:apply-templates select="*">
                    <xsl:with-param name="mapping" select="$mappedElement" />
                    <xsl:with-param name="authorizedApplicationsMap" select="$newAuthorizedApplicationsMap" />
                </xsl:apply-templates>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Bladelementen binnen object: waarde, noValue of nietGeautoriseerd -->
    <xsl:template match="BG:object//*[not(*)]">
        <xsl:param name="mapping" />
        <xsl:param name="authorizedApplicationsMap" as="node()?"/>
        <xsl:variable name="mappedElement" select="$mapping/*[local-name()=current()/local-name()]"/>
        <xsl:variable name="authorizedApplications" select="$authorizedApplicationsMap/*[name()=current()/local-name()]"/>
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
            <xsl:element name="{if (namespace-uri($mappedElement) != '') then name($mappedElement) else concat('BG:', local-name($mappedElement))}"
                         namespace="{if (namespace-uri($mappedElement) != '') then namespace-uri($mappedElement) else 'http://www.egem.nl/StUF/sector/bg/0310'}">
                <xsl:choose>
                    <xsl:when test="exists($authorizedApplications/@authorizedApplications)
                                    and not(contains($authorizedApplications/@authorizedApplications, $varZenderApplicatie))">
                        <xsl:attribute name="xsi:nil">true</xsl:attribute>
                        <xsl:attribute name="StUF:noValue" select="$nietGeautoriseerd"/>
                    </xsl:when>
                    <xsl:when test="$mappedElement/*/text() != ''">
                        <xsl:value-of select="normalize-space($mappedElement/*)" />
                    </xsl:when>
                    <xsl:when test="$mappedElement/*/text() = ''">
                        <xsl:attribute name="StUF:noValue" select="$waardeOnbekend"/>
                        <xsl:attribute name="xsi:nil">true</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="StUF:noValue" select="$geenWaarde"/>
                        <xsl:attribute name="xsi:nil">true</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- ===================================================================== -->
    <!-- Relaties                                                              -->
    <!-- ===================================================================== -->

    <xsl:template match="partners">
        <xsl:variable name="mapping">
            <inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:call-template name="gerelateerde-bsn"/>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <geslachtsnaamPartner><test><xsl:value-of select="$geslachtsnaam"/></test></geslachtsnaamPartner>
                    <voorvoegselGeslachtsnaamPartner><test><xsl:value-of select="$voorvoegsel"/></test></voorvoegselGeslachtsnaamPartner>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                    <xsl:call-template name="gerelateerde-geboorte"/>
                    <xsl:call-template name="gerelateerde-verblijf">
                        <xsl:with-param name="metAoaIdentificatie" select="true()"/>
                    </xsl:call-template>
                    <inp.burgerlijkeStaat>
                        <number>
                            <xsl:choose>
                                <xsl:when test=". != ''">
                                    <xsl:call-template name="burgerlijke-staat">
                                        <xsl:with-param name="verbintenis" select="."/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="1" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </number>
                    </inp.burgerlijkeStaat>
                </gerelateerde>
                <xsl:call-template name="indicatie-geheim"/>
                <soortVerbintenis><xsl:copy-of select="soortVerbintenis/code"/></soortVerbintenis>
                <datumSluiting>
                    <test><xsl:value-of select="local:formatteer-datum(aangaanHuwelijkPartnerschap/datum)"/></test>
                </datumSluiting>
                <datumOntbinding>
                    <test><xsl:value-of select="local:formatteer-datum(ontbindingHuwelijkPartnerschap/datum)"/></test>
                </datumOntbinding>
                <redenOntbinding> <!-- S of O uit de overlijdens-check van issue 1; anders leeg. Tijdelijk alleen S of leeg -->
                    <test><xsl:if test="ontbindingHuwelijkPartnerschap/datum">S</xsl:if></test>
                </redenOntbinding>
            </inp.heeftAlsEchtgenootPartner>
        </xsl:variable>
        <xsl:apply-templates select="$bronBericht//BG:inp.heeftAlsEchtgenootPartner">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="kinderen">
        <xsl:variable name="mapping">
            <inp.heeftAlsKinderen StUF:entiteittype="NPSNPSKND" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:call-template name="gerelateerde-bsn"/>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <aanduidingNaamgebruik></aanduidingNaamgebruik>
                    <aanhefAanschrijving></aanhefAanschrijving>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <xsl:call-template name="gerelateerde-geboorte"/>
                    <xsl:call-template name="gerelateerde-verblijf"/>
                    <xsl:call-template name="indicatie-geheim"/>
                </gerelateerde>
            </inp.heeftAlsKinderen>
        </xsl:variable>
        <xsl:apply-templates select="$bronBericht//BG:inp.heeftAlsKinderen">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ouders">
        <xsl:variable name="mapping">
            <inp.heeftAlsOuders StUF:entiteittype="NPSNPSOUD" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:call-template name="gerelateerde-bsn"/>
                    <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam"/></geslachtsnaam>
                    <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel"/></voorvoegselGeslachtsnaam>
                    <voorletters><xsl:copy-of select="naam/voorletters"/></voorletters>
                    <voornamen><xsl:copy-of select="naam/voornamen"/></voornamen>
                    <adellijkeTitelPredikaat><xsl:copy-of select="naam/adellijkeTitelPredicaat/code"/></adellijkeTitelPredikaat>
                    <geslachtsaanduiding><xsl:copy-of select="geslacht/code"/></geslachtsaanduiding>
                    <xsl:call-template name="gerelateerde-geboorte"/>
                    <xsl:call-template name="gerelateerde-verblijf"/>
                    <xsl:call-template name="indicatie-geheim"/>
                </gerelateerde>
                <ouderAanduiding>
                    <test><xsl:value-of select="concat('Ouder', ./ouderAanduiding)" /></test>
                </ouderAanduiding>
                <datumIngangFamilierechtelijkeBetrekking>
                    <test><xsl:value-of select="translate(datumIngangFamilierechtelijkeBetrekking/datum, '-', '')" /></test>
                </datumIngangFamilierechtelijkeBetrekking>
            </inp.heeftAlsOuders>
        </xsl:variable>
        <xsl:apply-templates select="$bronBericht//BG:inp.heeftAlsOuders">
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
                    <test><xsl:value-of select="translate(datumIngangGeldigheid/datum, '-', '')" /></test>
                </inp.datumVerkrijging>
            </inp.heeftAlsNationaliteit>
        </xsl:variable>
        <xsl:apply-templates select="$bronBericht//BG:inp.heeftAlsNationaliteit">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>
