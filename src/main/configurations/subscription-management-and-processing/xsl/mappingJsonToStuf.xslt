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
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="aantalVoorkomens"><xsl:value-of select="count(/root/personen)"/></xsl:param>
    <xsl:param name="gebruiker" />
    <xsl:param name="administratie" />
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="referentienummer" />
    <xsl:param name="organisatie"/>
    <xsl:param name="mutatiesoort"/>
    <xsl:param name="sleutelVerzendend"/>
    <xsl:param name="sleutelOntvangend"/>
    <xsl:param name="inputnpsLk01" select="document('npsLk01.xml')" as="node()?" />
    <xsl:param name="bagkeys"/>
    <xsl:variable name="geenWaarde">geenWaarde</xsl:variable>
    <xsl:variable name="waardeOnbekend">waardeOnbekend</xsl:variable>
    <xsl:variable name="nietGeautoriseerd">nietGeautoriseerd</xsl:variable>
    <xsl:variable name="authorizedApplicationsMap" select="document('authorizedApplicationsMap.xml')" as="node()?" />
    <!-- <xsl:variable name="woonplaats"><xsl:value-of
         select="root/personen/verblijfplaats/verblijfadres/woonplaats" /></xsl:variable>
         <xsl:variable name="external-data" select="document('woonplaatsen.xml')" as="node()?" /> -->
    <xsl:param name="geslachtsnaam"><xsl:value-of select="/root/personen/naam/geslachtsnaam"/></xsl:param>
    <xsl:param name="voorvoegsel"><xsl:value-of select="count(/root/personen/naam/voorvoegsel)"/></xsl:param>    

    <!-- Include the correct namespaces for all future new elements in the mapping.
    The automatic 'BG' prefix is this in place as a fallback for existing elements without a namespace. -->
    
    <xsl:template match="/">
        <xsl:apply-templates select="$inputnpsLk01//BG:npsLk01">
            <xsl:with-param name="personen" select="root/personen"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="BG:npsLk01">
        <xsl:param name="personen"/>
        <xsl:choose>
            <xsl:when test="$aantalVoorkomens = 0">
                <BG:npsLk01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
                    <xsl:apply-templates select="BG:stuurgegevens"/>
                    <xsl:apply-templates select="BG:parameters"/>
                    <BG:melding>Er zijn geen zoekresultaten gevonden</BG:melding>
                </BG:npsLk01>
            </xsl:when>
            <xsl:otherwise>
                <BG:npsLk01 xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310">
                    <xsl:apply-templates select="BG:stuurgegevens"/>
                    <xsl:apply-templates select="BG:parameters"/>
                    <xsl:for-each select="$personen">
                        <!-- Also use a dissolved partner: with naamgebruik P/V/N the ex-partner's name is still used. -->
                        <!-- Which of several active partners is taken is not specified, the first is arbitrary but harmless. -->
                        <xsl:variable name="partner" select="(partners[not(ontbindingHuwelijkPartnerschap/datum)], partners)[1]"/>
                        <xsl:variable name="mapping">
                            <object>
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
                                <inp.a-nummer><xsl:copy-of select="aNummer" /></inp.a-nummer>
                                <geslachtsnaam><xsl:copy-of select="naam/geslachtsnaam" /></geslachtsnaam>
                                <voorvoegselGeslachtsnaam><xsl:copy-of select="naam/voorvoegsel" /></voorvoegselGeslachtsnaam>
                                <voorletters><xsl:copy-of select="naam/voorletters" /></voorletters>
                                <voornamen><xsl:copy-of select="naam/voornamen" /></voornamen>
                                <aanduidingNaamgebruik><xsl:copy-of select="naam/aanduidingNaamgebruik/code" /></aanduidingNaamgebruik>
                                <geslachtsnaamPartner><xsl:copy-of select="$partner/naam/geslachtsnaam" /></geslachtsnaamPartner>
                                <voorvoegselGeslachtsnaamPartner><xsl:copy-of select="$partner/naam/voorvoegsel" /></voorvoegselGeslachtsnaamPartner>
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
                                                    select="concat(naam/geslachtsnaam, '-',$partner/naam/geslachtsnaam)" />
                                            </xsl:when>
                                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'P'">
                                                <xsl:value-of select="$partner/naam/geslachtsnaam" />
                                            </xsl:when>
                                            <xsl:when test="naam/aanduidingNaamgebruik/code = 'V'">
                                                <xsl:value-of
                                                    select="concat($partner/naam/geslachtsnaam, '-',naam/geslachtsnaam)" />
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
                                                    <aoa.identificatie doNotCreate="true"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <num.identificatie doNotCreate="true"/>
                                                    <aoa.identificatie><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></aoa.identificatie>
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
                                    <StUF:tijdvakRelatie>
                                        <StUF:beginRelatie>
                                            <test>
                                                <xsl:value-of select="local:formatteer-datum(verblijfplaats/datumVan)" />
                                            </test>
                                        </StUF:beginRelatie>
                                        <StUF:eindRelatie>
                                            <test>
                                                <xsl:value-of select="local:formatteer-datum(verblijfplaats/datumTot)" />
                                            </test>
                                        </StUF:eindRelatie>
                                    </StUF:tijdvakRelatie>
                                </inp.verblijftIn>
                                <xsl:choose>
                                    <xsl:when test="./verblijfplaats/type/text() = &apos;Adres&apos;">
                                        <verblijfsadres>
                                            <aoa.identificatie><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></aoa.identificatie>
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
                                                    <aoa.identificatie><test><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></test></aoa.identificatie>
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
                                            <authentiek StUF:metagegeven="true"/>
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
                                        <xsl:variable name="actief" select="partners[not(ontbindingHuwelijkPartnerschap/datum)]"/>
                                        <xsl:variable name="ontbonden" select="partners[ontbindingHuwelijkPartnerschap/datum]"/>
                                        <xsl:variable name="laatste">
                                            <xsl:for-each select="$ontbonden">
                                                <xsl:sort select="local:formatteer-datum(ontbindingHuwelijkPartnerschap/datum)" order="descending"/>
                                                <xsl:if test="position() = 1"><xsl:value-of select="soortVerbintenis/code"/></xsl:if>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:choose>
                                            <xsl:when test="$actief[soortVerbintenis/code = 'H']">2</xsl:when>
                                            <xsl:when test="$actief[soortVerbintenis/code = 'P']">5</xsl:when>
                                            <xsl:when test="$actief"><xsl:attribute name="noValue">waardeOnbekend</xsl:attribute></xsl:when>
                                            <xsl:when test="$laatste = 'H'">3</xsl:when><!-- 4 bij overlijden partner -->
                                            <xsl:when test="$laatste = 'P'">6</xsl:when><!-- 7 bij overlijden partner -->
                                            <xsl:when test="$ontbonden"><xsl:attribute name="noValue">waardeOnbekend</xsl:attribute></xsl:when>
                                            <xsl:otherwise>1</xsl:otherwise>
                                        </xsl:choose>
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
                                <ing.datumVerkrijgingVerblijfstitel>
                                    <test>
                                        <xsl:variable name="date" select="verblijfstitel/datumIngang/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </ing.datumVerkrijgingVerblijfstitel>
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
                                    <test>
                                        <xsl:variable name="date" select="opschortingBijhouding/datum/datum"/>
                                        <xsl:value-of select="translate($date, '-', '')" />
                                    </test>
                                </inp.datumOpschortingBijhouding>
                                <inp.redenOpschortingBijhouding>
                                    <test>
                                        <xsl:choose>
                                            <xsl:when test="opschortingBijhouding/reden/text() != ''">
                                                <xsl:value-of select="./opschortingBijhouding/reden/code" />
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
                <StUF:applicatie>NEDMAG_OPT</StUF:applicatie>
            </StUF:zender>
            
            <StUF:ontvanger>
                <StUF:organisatie>
                    <xsl:value-of select="$organisatie" />
                </StUF:organisatie>
                <StUF:applicatie>
                    <xsl:value-of select="$varZenderApplicatie" />
                </StUF:applicatie>
                <StUF:administratie><xsl:value-of select="$administratie" /></StUF:administratie>
                <StUF:gebruiker>
                    <xsl:value-of select="$gebruiker" />
                </StUF:gebruiker> 
            </StUF:ontvanger> 
            <StUF:referentienummer>
                <xsl:value-of select="$referentienummer" />
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
            <StUF:mutatiesoort><xsl:value-of select="$mutatiesoort"/></StUF:mutatiesoort>
            <StUF:indicatorOvername>V</StUF:indicatorOvername>
        </BG:parameters>     
    </xsl:template>
    
    <xsl:template match="BG:object">
        <xsl:param name="mapping"/>
        <xsl:param name="persoon" tunnel="yes"/>
        <BG:object  StUF:entiteittype="NPS">
            <xsl:attribute name="StUF:verwerkingssoort" select="$mutatiesoort"/>
            <xsl:attribute name="StUF:sleutelVerzendend" select="$sleutelVerzendend"/>
            <xsl:attribute name="StUF:sleutelOntvangend" select="$sleutelOntvangend"/>
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
        <xsl:variable name="mappedElement" select="$mapping/*[local-name()=current()/local-name()]" />
        <xsl:variable name="newAuthorizedApplicationsMap" select="$authorizedApplicationsMap/*[name()=current()/local-name()]" />
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">
            <xsl:element name="{if (namespace-uri($mappedElement) != '') then name($mappedElement) else concat('BG:', local-name($mappedElement))}"
                         namespace="{if (namespace-uri($mappedElement) != '') then namespace-uri($mappedElement) else 'http://www.egem.nl/StUF/sector/bg/0310'}">
                <xsl:copy-of select="@*" />
                <xsl:apply-templates select="*">
                    <xsl:with-param name="mapping" select="$mappedElement" />
                    <xsl:with-param name="authorizedApplicationsMap" select="$newAuthorizedApplicationsMap" />
                </xsl:apply-templates>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="BG:object//*[not(*)]">
        <xsl:param name="mapping" />
        <xsl:param name="authorizedApplicationsMap" as="node()?"/>
        <xsl:variable name="mappedElement" select="$mapping/*[local-name()=current()/local-name()]"/>
        <xsl:variable name="authorizedApplications" select="$authorizedApplicationsMap/*[name()=current()/local-name()]"/>
        <xsl:if test="$mappedElement[not(@doNotCreate='true')]">            
            <xsl:choose>
                <xsl:when test="not(exists($authorizedApplications/@authorizedApplications)) or contains($authorizedApplications/@authorizedApplications, $varZenderApplicatie)">
                    
                    <xsl:element name="{if (namespace-uri($mappedElement) != '') then name($mappedElement) else concat('BG:', local-name($mappedElement))}"
                                 namespace="{if (namespace-uri($mappedElement) != '') then namespace-uri($mappedElement) else 'http://www.egem.nl/StUF/sector/bg/0310'}">
                        <xsl:choose>
                            <xsl:when test="$mappedElement/*/@noValue">
                                <xsl:attribute name="StUF:noValue" select="$mappedElement/*/@noValue"/>
                                <xsl:attribute name="xsi:nil">true</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="$mappedElement/*/text() != ''">
                                <xsl:value-of select="normalize-space($mappedElement/*)" />
                            </xsl:when>
                            <xsl:when test="$mappedElement/*/text() = ''">
                                <xsl:attribute name="xsi:nil">true</xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$waardeOnbekend" /></xsl:attribute>                           
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="xsi:nil">true</xsl:attribute>
                                <xsl:attribute
                                    name="StUF:noValue"><xsl:value-of
                                        select="$geenWaarde" /></xsl:attribute>                            
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="{if (namespace-uri($mappedElement) != '') then name($mappedElement) else concat('BG:', local-name($mappedElement))}"
                                 namespace="{if (namespace-uri($mappedElement) != '') then namespace-uri($mappedElement) else 'http://www.egem.nl/StUF/sector/bg/0310'}">
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
            <inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW" StUF:verwerkingssoort="T">
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
                                        <aoa.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <aoa.identificatie><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></aoa.identificatie>
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
                                <authentiek StUF:metagegeven="true"/>
                            </sub.correspondentieAdres>
                        </xsl:otherwise>                        
                    </xsl:choose>
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
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsEchtgenootPartner">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="kinderen">
        <xsl:variable name="mapping">
            <inp.heeftAlsKinderen StUF:entiteittype="NPSNPSKND" StUF:verwerkingssoort="T">
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
                                        <aoa.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <aoa.identificatie><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></aoa.identificatie>
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
                                <authentiek StUF:metagegeven="true"/>
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
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsKinderen">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="ouders">
        <xsl:variable name="mapping">
            <inp.heeftAlsOuders StUF:entiteittype="NPSNPSOUD" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="NPS">
                    <xsl:choose>
                        <xsl:when test="burgerservicenummer/text()!=''">
                            <inp.bsn><xsl:copy-of select="burgerservicenummer" /></inp.bsn>
                            <authentiek doNotCreate="true"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <inp.bsn/>
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
                    <inp.verblijftIn StUF:verwerkingssoort="T">
                        <gerelateerde>
                            <adresAanduidingGrp>
                                <xsl:choose>
                                    <xsl:when test="string-length(verblijfplaats/nummeraanduidingIdentificatie)!=0">
                                        <num.identificatie><xsl:copy-of select="verblijfplaats/nummeraanduidingIdentificatie"/></num.identificatie>
                                        <aoa.identificatie doNotCreate="true"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <num.identificatie doNotCreate="true"/>
                                        <aoa.identificatie><test><xsl:value-of select="$bagkeys/results/result/result/rowset/row[field[@name = 'IDENTIFIER'] = current()/verblijfplaats/adresseerbaarObjectIdentificatie]/field[@name = 'KEY']"/></test></aoa.identificatie>
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
                                <authentiek StUF:metagegeven="true"/>
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
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsOuders">
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
        <xsl:apply-templates select="$inputnpsLk01//BG:inp.heeftAlsNationaliteit">
            <xsl:with-param name="mapping" select="$mapping"/>
            <xsl:with-param name="authorizedApplicationsMap" select="$authorizedApplicationsMap/root"/>
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>