<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ax25="http://objecten.zoekpersoon.diensten.procura.nl/xsd"
    xmlns:ns0="http://zoekpersoonws.ws.procura.nl/xsd"
    xmlns:ns1="http://objecten.zoekpersoon.diensten.procura.nl/xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
    xmlns:str="http://exslt.org/strings">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="varZenderOrganisatie" />
    <xsl:param name="varZenderGebruiker" />
    <xsl:param name="varReferentienummer" />
    <xsl:param name="varOntvangerApplicatie" />
    <xsl:param name="varOntvangerOrganisatie" />

    <xsl:template name="NillIfEmpty">
        <xsl:param name="source" />
        <!-- template code starts-->
    <xsl:choose>
            <xsl:when test="string($source)">
                <xsl:value-of select="$source" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="xsi:nil" namespace="http://www.w3.org/2001/XMLSchema-instance">true</xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <!-- template code ends-->
    </xsl:template>
    <xsl:template match="/"><BG:npsLa01>
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
                <StUF:referentienummer>
                    <xsl:value-of
                        select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
                </StUF:referentienummer>
                <StUF:tijdstipBericht>
                    <xsl:value-of
                        select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01]')" />
                </StUF:tijdstipBericht>
                <StUF:crossRefnummer>
                    <xsl:value-of select="$varReferentienummer" />
                </StUF:crossRefnummer>
                <StUF:entiteittype>
                    <xsl:value-of select="&apos;NPS&apos;" />
                </StUF:entiteittype>
            </BG:stuurgegevens>
            <BG:parameters>
                <StUF:indicatorVervolgvraag>
                    <xsl:value-of select="&apos;false&apos;" />
                </StUF:indicatorVervolgvraag>
                <StUF:aantalVoorkomens>
                    
                </StUF:aantalVoorkomens>
            </BG:parameters>
            <BG:antwoord>
                <BG:object>
                    <xsl:attribute name="StUF:entiteittype"><xsl:value-of
                            select="&apos;NPS&apos;" />
                    </xsl:attribute>
                    <BG:inp.bsn>
                        <xsl:value-of select="/root/personen/burgerservicenummer" />
                    </BG:inp.bsn>
                    <BG:inp.indicatieGeheim>
                        <xsl:value-of
                            select="/root/personen/geheimhoudingPersoonsgegevens" />
                    </BG:inp.indicatieGeheim>
                    <BG:geslachtsnaam>
                        <xsl:value-of select="/root/personen/naam/geslachtsnaam" />
                    </BG:geslachtsnaam>
                    <BG:voorvoegselGeslachtsnaam>
                        <xsl:value-of select="/root/personen/naam/voorvoegsel" />
                    </BG:voorvoegselGeslachtsnaam>
                    <BG:voorletters>
                        <xsl:value-of select="/root/personen/naam/voorletters" />
                    </BG:voorletters>
                    <BG:voornamen>
                        <xsl:value-of select="/root/personen/naam/voornamen" />
                    </BG:voornamen>
                    <BG:inOnderzoek>
                        <geslachtsnaam>
                            <xsl:value-of
                                select="/root/personen/naam/inOnderzoek[/naam = Persoonsgegevens/naam]/geslachtsnaam" />
                        </geslachtsnaam>
                        <voornamen>
                            <xsl:value-of
                                select="/root/personen/naam/inOnderzoek[/naam = Persoonsgegevens/naam]/voornamen" />
                        </voornamen>
                        <voorvoegsel>
                            <xsl:value-of
                                select="/root/personen/naam/inOnderzoek[/naam = Persoonsgegevens/naam]/voorvoegsel" />
                        </voorvoegsel>
                    </BG:inOnderzoek>

                    <BG:aanduidingNaamgebruik>
                        <xsl:value-of
                            select="/root/personen/naam/aanduidingNaamgebruik" />
                    </BG:aanduidingNaamgebruik>

                    <BG:geboortedatum>
                        <xsl:variable name="date" select="/root/personen/geboorte/datum/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:geboortedatum>

                    <BG:inp.geboorteplaats>
                        <code>
                            <xsl:value-of select="/root/personen/geboorte/plaats/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of select="/root/personen/geboorte/plaats/omschrijving" />
                        </omschrijving>
                    </BG:inp.geboorteplaats>

                    <BG:inp.geboorteLand>
                        <code>
                            <xsl:value-of select="/root/personen/geboorte/land/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of select="/root/personen/geboorte/land/omschrijving" />
                        </omschrijving>
                    </BG:inp.geboorteLand>
                    <BG:inOnderzoek>
                        <datum>
                            <xsl:value-of
                                select="/root/personen/geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/datum" />
                        </datum>
                        <land>
                            <xsl:value-of
                                select="/root/personen/geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/land" />
                        </land>
                        <plaats>
                            <xsl:value-of
                                select="/root/personen/geboorte/inOnderzoek[/naam = Persoonsgegevens/naam]/plaats" />
                        </plaats>
                    </BG:inOnderzoek>
                    <BG:geslachtsaanduiding>
                        <xsl:value-of select="/root/personen/geslachtsaanduiding" />
                    </BG:geslachtsaanduiding>
                    <BG:datumInschrijving>
                        <xsl:variable name="date"
                            select="/root/personen/datumEersteInschrijvingGBA/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:datumInschrijving>
                    <BG:ing.aanduidingEuropeesKiesrecht>

                    </BG:ing.aanduidingEuropeesKiesrecht>
                    <BG:aanduidingBijzonderNederlanderschap>
                        <xsl:value-of
                            select="/root/personen/nationaliteit/aanduidingBijzonderNederlanderschap" />
                    </BG:aanduidingBijzonderNederlanderschap>
                    <BG:inp.datumVerkrijging>
                        <xsl:variable name="date"
                            select="/root/personen/nationaliteit/datumIngangGeldigheid/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:inp.datumVerkrijging>
                    <BG:gerelateerde>
                        <code>
                            <xsl:value-of select="/root/personen/nationaliteit/nationaliteit/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of
                                select="/root/personen/nationaliteit/nationaliteit/omschrijving" />
                        </omschrijving>
                    </BG:gerelateerde>
                    <BG:inp.redenVerkrijging>
                        <code>
                            <xsl:value-of select="/root/personen/nationaliteit/redenOpname/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of
                                select="/root/personen/nationaliteit/redenOpname/omschrijving" />
                        </omschrijving>
                    </BG:inp.redenVerkrijging>
                    <BG:inOnderzoek>
                        <aanduidingBijzonderNederlanderschap>
                            <xsl:value-of
                                select="/root/personen/nationaliteit/inOnderzoek[/elementnaam = aanduidingBijzonderNederlanderschap]/aanduidingBijzonderNederlanderschap" />
                        </aanduidingBijzonderNederlanderschap>
                        <nationaliteit>
                            <xsl:value-of
                                select="/root/personen/nationaliteit/inOnderzoek[/groepsnaam = Nationaliteit]/nationaliteit" />
                        </nationaliteit>
                        <redenOpname>True</redenOpname>
                    </BG:inOnderzoek>
                    <BG:inp.redenOpschortingBijhouding>
                        <xsl:value-of select="/root/personen/opschortingBijhouding/reden" />
                        <xsl:if test="/root/personen/opschortingBijhouding/reden=0">
                            <xsl:value-of select="/root/personen/overlijden/indicatieOverleden" />
                        </xsl:if>
                    </BG:inp.redenOpschortingBijhouding>
                    <BG:inp.datumOpschortingBijhouding>
                        <xsl:variable name="date"
                            select="/root/personen/opschortingBijhouding/datum/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:inp.datumOpschortingBijhouding>
                    <BG:overlijdensdatum>
                        <xsl:variable name="date"
                            select="/root/personen/overlijden/datum/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:overlijdensdatum>

                    <BG:inp.overlijdenplaats>
                        <code>
                            <xsl:value-of select="/root/personen/overlijden/plaats/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of select="/root/personen/overlijden/plaats/omschrijving" />
                        </omschrijving>
                    </BG:inp.overlijdenplaats>

                    <BG:inp.overlijdenLand>
                        <code>
                            <xsl:value-of select="/root/personen/overlijden/land/code" />
                        </code>
                        <omschrijving>
                            <xsl:value-of select="/root/personen/overlijden/land/omschrijving" />
                        </omschrijving>
                    </BG:inp.overlijdenLand>


                    <BG:verblijfsadres>
                        <BG:aoa.identificatie>
                            <xsl:value-of
                                select="/root/personen/verblijfplaats/identificatiecodeNummeraanduiding" />
                        </BG:aoa.identificatie>

                        <BG:aoa.huisletter>
                            <xsl:value-of select="/root/personen/verblijfplaats/huisletter" />
                        </BG:aoa.huisletter>
                        <BG:aoa.huisnummer>
                            <xsl:value-of select="/root/personen/verblijfplaats/huisnummer" />
                        </BG:aoa.huisnummer>

                        <BG:aoa.huisnummertoevoeging>
                            <xsl:value-of
                                select="/root/personen/verblijfplaats/huisnummertoevoeging" />
                        </BG:aoa.huisnummertoevoeging>
                        <BG:aoa.postcode>
                            <xsl:value-of select="/root/personen/verblijfplaats/postcode" />
                        </BG:aoa.postcode>
                        <BG:gor.openbareRuimteNaam>
                            <xsl:value-of select="/root/personen/verblijfplaats/naamOpenbareRuimte" />
                        </BG:gor.openbareRuimteNaam>
                        <BG:wpl.identificatie>
                            <xsl:value-of
                                select="/root/personen/verblijfplaats/identificatiecodeAdresseerbaarObject" />
                        </BG:wpl.identificatie>
                        <BG:wpl.woonplaatsNaam>
                            <xsl:value-of select="/root/personen/verblijfplaats/woonplaatsnaam" />
                        </BG:wpl.woonplaatsNaam>
                        <BG:indicatieVestigingVanuitBuitenland>True</BG:indicatieVestigingVanuitBuitenland>

                        <BG:inp.locatiebeschrijving>
                            <xsl:value-of select="/root/personen/verblijfplaats/locatiebeschrijving" />
                        </BG:inp.locatiebeschrijving>


                        <BG:gor.straatnaam>
                            <xsl:value-of select="/root/personen/verblijfplaats/straatnaam" />
                        </BG:gor.straatnaam>
                        <BG:vanuitVertrokkenOnbekendWaarheen>True</BG:vanuitVertrokkenOnbekendWaarheen>

                        <BG:begindatumVerblijf>
                            <xsl:variable name="date"
                                select="/root/personen/verblijfplaats/datumAanvangAdreshouding/datum" />
                            <StUF:datum>
                                <xsl:value-of select="$date" />
                            </StUF:datum>
                            <StUF:dag>
                                <xsl:value-of select="format-date($date, '[D01]')" />
                            </StUF:dag>
                            <StUF:maand>
                                <xsl:value-of select="format-date($date, '[MNn]')" />
                            </StUF:maand>
                            <StUF:jaar>
                                <xsl:value-of select="format-date($date, '[Y0001]')" />
                            </StUF:jaar>
                        </BG:begindatumVerblijf>
                    </BG:verblijfsadres>
                    <BG:inp.verblijftIn>
                        <BG:gerelateerde>
                            <BG:ingangsdatumObject>
                                <xsl:variable name="date"
                                    select="/root/personen/verblijfplaats/datumIngangGeldigheid/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </BG:ingangsdatumObject>
                            <BG:gemeenteCode>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/gemeenteVanInschrijving/code" />
                            </BG:gemeenteCode>
                            <BG:gemeenteNaam>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/gemeenteVanInschrijving/omschrijving" />
                            </BG:gemeenteNaam>
                        </BG:gerelateerde>
                    </BG:inp.verblijftIn>

                    <BG:sub.verblijfBuitenland>
                        <xsl:if
                            test="string-length(/root/personen/verblijfplaats/verblijfBuitenland/adresRegel1) !=0">
                            <BG:sub.adresBuitenland1>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/verblijfBuitenland/adresRegel1" />
                            </BG:sub.adresBuitenland1></xsl:if>
                        <xsl:if
                            test="string-length(/root/personen/verblijfplaats/verblijfBuitenland/adresRegel2) !=0">
                            <BG:sub.adresBuitenland2>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/verblijfBuitenland/adresRegel2" />
                            </BG:sub.adresBuitenland2></xsl:if>
                        <xsl:if
                            test="string-length(/root/personen/verblijfplaats/verblijfBuitenland/adresRegel3) !=0">
                            <BG:sub.adresBuitenland3>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/verblijfBuitenland/adresRegel3" />
                            </BG:sub.adresBuitenland3></xsl:if>
                        <vertrokkenOnbekendWaarheen>True</vertrokkenOnbekendWaarheen>
                        <BG:lnd.landcode>
                            <code>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/verblijfBuitenland/land/code" />
                            </code>
                            <omschrijving>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/verblijfBuitenland/land/omschrijving" />
                            </omschrijving>
                        </BG:lnd.landcode>

                    </BG:sub.verblijfBuitenland>

                    <BG:Verblijfsplaats>
                        <BG:datumAanvangAdreshouding>True</BG:datumAanvangAdreshouding>
                        <BG:datumIngangGeldigheid>True</BG:datumIngangGeldigheid>
                        <BG:datumInschrijvingInGemeente>True</BG:datumInschrijvingInGemeente>
                        <BG:datumVestigingInNederland>True</BG:datumVestigingInNederland>
                        <BG:gemeenteVanInschrijving>True</BG:gemeenteVanInschrijving>
                        <StUF:InOnderzoek>
                            <huisletter>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/huisletter" />
                            </huisletter>
                            <huisnummer>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/huisnummer" />
                            </huisnummer>
                            <huisnummertoevoeging>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/huisnummertoevoeging" />
                            </huisnummertoevoeging>
                            <identificatiecodeNummeraanduiding>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/identificatiecodeNummeraanduiding" />
                            </identificatiecodeNummeraanduiding>
                            <identificatiecodeAdresseerbaarObject>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/identificatiecodeAdresseerbaarObject" />
                            </identificatiecodeAdresseerbaarObject>
                            <landVanwaarIngeschreven>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/landVanwaarIngeschreven" />
                            </landVanwaarIngeschreven>
                            <locatiebeschrijving>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/locatiebeschrijving" />
                            </locatiebeschrijving>
                            <naamOpenbareRuimte>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/naamOpenbareRuimte" />
                            </naamOpenbareRuimte>
                            <postcode>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/postcode" />
                            </postcode>
                            <straatnaam>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/straatnaam" />
                            </straatnaam>
                            <verblijfBuitenland>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/verblijfBuitenland" />
                            </verblijfBuitenland>
                            <woonplaatsnaam>
                                <xsl:value-of
                                    select="/root/personen/verblijfplaats/inOnderzoek[/groepsnaam = Verblijfsplaats/groepsnaam]/woonplaatsnaam" />
                            </woonplaatsnaam>
                        </StUF:InOnderzoek>
                    </BG:Verblijfsplaats>
                    <BG:ing.indicatieCurateleRegister>
                        <xsl:value-of
                            select="/root/personen/gezagsverhouding/indicatieCurateleRegister" />
                    </BG:ing.indicatieCurateleRegister>
                    <BG:ing.indicatieGezagMinderjarige>
                        <xsl:value-of
                            select="/root/personen/gezagsverhouding/indicatieGezagMinderjarige" />
                    </BG:ing.indicatieGezagMinderjarige>
                    <BG:inp.gemeenteVanInschrijving>
                    </BG:inp.gemeenteVanInschrijving>
                    <BG:vbt.aanduidingVerblijfstitel>
                        <xsl:value-of select="/root/personen/verblijfstitel/aanduiding/code" />
                    </BG:vbt.aanduidingVerblijfstitel>
                    <BG:inOnderzoek>
                        <indicatieCurateleRegister>
                            <xsl:value-of
                                select="/root/personen/gezagsverhouding/inOnderzoek[/groepsnaam = Gezagsverhouding/groepsnaam]/indicatieCurateleRegister" />
                        </indicatieCurateleRegister>
                        <indicatieGezagMinderjarige>
                            <xsl:value-of
                                select="/root/personen/gezagsverhouding/inOnderzoek[/groepsnaam = Gezagsverhouding/groepsnaam]/indicatieGezagMinderjarige" />
                        </indicatieGezagMinderjarige>
                        <datumIngangOnderzoek>
                            <xsl:if
                                test="/root/personen/gezagsverhouding/inOnderzoek/groepsnaam = Gezagsverhouding/groepsnaam">
                                <xsl:variable name="date"
                                    select="/root/personen/gezagsverhouding/inOnderzoek/datumIngangOnderzoek/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </xsl:if>
                        </datumIngangOnderzoek>
                    </BG:inOnderzoek>
                    <BG:ing.datumVerliesVerblijfstitel>
                        <xsl:variable name="date"
                            select="/root/personen/verblijfstitel/datumEinde/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:ing.datumVerliesVerblijfstitel>
                    <BG:ing.datumVerkrijgingVerblijfstitel>
                        <xsl:variable name="date"
                            select="/root/personen/verblijfstitel/datumIngang/datum" />
                        <StUF:datum>
                            <xsl:value-of select="$date" />
                        </StUF:datum>
                        <StUF:dag>
                            <xsl:value-of select="format-date($date, '[D01]')" />
                        </StUF:dag>
                        <StUF:maand>
                            <xsl:value-of select="format-date($date, '[MNn]')" />
                        </StUF:maand>
                        <StUF:jaar>
                            <xsl:value-of select="format-date($date, '[Y0001]')" />
                        </StUF:jaar>
                    </BG:ing.datumVerkrijgingVerblijfstitel>

                    <xsl:for-each select="/root/personen/partners">
                        <BG:inp.heeftAlsEchtgenootPartner StUF:entiteittype="NPSNPSHUW">
                            <BG:inp.bsn>
                                <xsl:value-of select="./burgerservicenummer" />
                            </BG:inp.bsn>
                            <BG:geslachtsaanduiding>
                                <xsl:value-of select="./geslachtsaanduiding" />
                            </BG:geslachtsaanduiding>
                            <BG:inp.soortVerbintenis>
                                <xsl:value-of select="./soortVerbintenis" />
                            </BG:inp.soortVerbintenis>
                            <BG:gerelateerde StUF:entiteittype="NPS">

                                <BG:geslachtsnaam>
                                    <xsl:value-of select="./naam/geslachtsnaam" />
                                </BG:geslachtsnaam>
                                <BG:voorletters>
                                    <xsl:value-of select="./naam/voorletters" />
                                </BG:voorletters>
                                <BG:voornamen>
                                    <xsl:value-of select="./naam/voornamen" />
                                </BG:voornamen>
                                <BG:voorvoegselGeslachtsnaam>
                                    <xsl:value-of select="./naam/voorvoegsel" />
                                </BG:voorvoegselGeslachtsnaam>
                            </BG:gerelateerde>
                            <BG:inOnderzoek>
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
                            </BG:inOnderzoek>

                            <BG:geboortedatum>
                                <xsl:variable name="date" select="./geboorte/datum/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </BG:geboortedatum>
                            <BG:inp.geboorteLand>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/land/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/land/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteLand>
                            <BG:inp.geboorteplaats>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/plaats/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/plaats/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteplaats>
                            <BG:inOnderzoek>
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
                            </BG:inOnderzoek>

                            <BG:datumSluiting>
                                <xsl:variable name="date"
                                    select="./aangaanHuwelijkPartnerschap/datum/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </BG:datumSluiting>
                            <BG:plaatsSluiting>
                                <BG:code>
                                    <xsl:value-of select="./aangaanHuwelijkPartnerschap/plaats/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of
                                        select="./aangaanHuwelijkPartnerschap/plaats/omschrijving" />
                                </BG:omschrijving>
                            </BG:plaatsSluiting>
                            <BG:landSluiting>
                                <BG:code>
                                    <xsl:value-of select="./aangaanHuwelijkPartnerschap/land" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of
                                        select="./aangaanHuwelijkPartnerschap/land/omschrijving" />
                                </BG:omschrijving>
                            </BG:landSluiting>
                            <BG:inOnderzoek>
                                <xsl:value-of
                                    select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                <xsl:value-of
                                    select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                <xsl:value-of
                                    select="./aangaanHuwelijkPartnerschap/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                <BG:datumIngangOnderzoek>
                                    <dag>1</dag>
                                    <maand>1</maand>
                                    <jaar>1900</jaar>
                                </BG:datumIngangOnderzoek>
                            </BG:inOnderzoek>
                            <BG:inp.indicatieGeheim>
                                <xsl:value-of select="./geheimhoudingPersoonsgegevens" />
                            </BG:inp.indicatieGeheim>
                        </BG:inp.heeftAlsEchtgenootPartner>
                    </xsl:for-each>

                    <xsl:for-each select="/root/personen/kinderen">
                        <BG:inp.heeftAlsKinderen StUF:entiteittype="NPSNPSKND">
                            <BG:inp.bsn>
                                <xsl:value-of select="./burgerservicenummer" />
                            </BG:inp.bsn>
                            <BG:inp.indicatieGeheim>
                                <xsl:value-of select="./geheimhoudingPersoonsgegevens" />
                            </BG:inp.indicatieGeheim>
                            <BG:geslachtsnaam>
                                <xsl:value-of select="./naam/geslachtsnaam" />
                            </BG:geslachtsnaam>
                            <BG:voorletters>
                                <xsl:value-of select="./naam/voorletters" />
                            </BG:voorletters>
                            <BG:voornamen>
                                <xsl:value-of select="./naam/voornamen" />
                            </BG:voornamen>
                            <BG:voorvoegselGeslachtsnaam>
                                <xsl:value-of select="./naam/voorvoegsel" />
                            </BG:voorvoegselGeslachtsnaam>
                            <BG:inOnderzoek>
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsnaam" />
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voornamen" />
                                <xsl:value-of
                                    select="./naam/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/voorvoegsel" />
                            </BG:inOnderzoek>
                            <BG:geboortedatum>
                                <xsl:variable name="date" select="./geboorte/datum/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </BG:geboortedatum>
                            <BG:inp.geboorteLand>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/land/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/land/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteLand>
                            <BG:inp.geboorteplaats>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/plaats/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/plaats/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteplaats>
                            <BG:inOnderzoek>
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/datum" />
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/land" />
                                <xsl:value-of
                                    select="./geboorte/inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/plaats" />
                                <xsl:value-of
                                    select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/burgerservicenummer" />
                            </BG:inOnderzoek>
                        </BG:inp.heeftAlsKinderen>
                    </xsl:for-each>

                    <xsl:for-each select="/root/personen/ouders">
                        <BG:inp.heeftAlsOuders StUF:entiteittype="NPSNPSOUD">
                            <BG:inp.bsn>
                                <xsl:value-of select="./burgerservicenummer" />
                            </BG:inp.bsn>
                            <BG:geslachtsaanduiding>
                                <xsl:value-of select="./geslachtsaanduiding" />
                            </BG:geslachtsaanduiding>
                            <BG:ouderAanduiding>
                                <xsl:value-of select="./ouderAanduiding" />
                            </BG:ouderAanduiding>
                            <StUF:datumIngangFamilierechtelijkeBetrekking>
                                <xsl:variable name="date"
                                    select="./datumIngangFamilierechtelijkeBetrekking/datum" />
                                <StUF:datum>
                                    <xsl:value-of select="$date" />
                                </StUF:datum>
                                <StUF:dag>
                                    <xsl:value-of select="format-date($date, '[D01]')" />
                                </StUF:dag>
                                <StUF:maand>
                                    <xsl:value-of select="format-date($date, '[MNn]')" />
                                </StUF:maand>
                                <StUF:jaar>
                                    <xsl:value-of select="format-date($date, '[Y0001]')" />
                                </StUF:jaar>
                            </StUF:datumIngangFamilierechtelijkeBetrekking>

                            <BG:gerelateerde StUF:entiteittype="NPS">
                                <BG:geslachtsnaam>
                                    <xsl:value-of select="./naam/geslachtsnaam" />
                                </BG:geslachtsnaam>
                                <BG:voorletters>
                                    <xsl:value-of select="./naam/voorletters" />
                                </BG:voorletters>
                                <BG:voornamen>
                                    <xsl:value-of select="./naam/voornamen" />
                                </BG:voornamen>
                                <BG:voorvoegselGeslachtsnaam>
                                    <xsl:value-of select="./naam/voorvoegsel" />
                                </BG:voorvoegselGeslachtsnaam>
                            </BG:gerelateerde>
                            <BG:inOnderzoek>
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
                            </BG:inOnderzoek>
                            <BG:geboortedatum>
                                <xsl:value-of select="./geboorte/datum/datum" />
                            </BG:geboortedatum>
                            <BG:inp.geboorteLand>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/land/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/land/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteLand>
                            <BG:inp.geboorteplaats>
                                <BG:code>
                                    <xsl:value-of select="./geboorte/plaats/code" />
                                </BG:code>
                                <BG:omschrijving>
                                    <xsl:value-of select="./geboorte/plaats/omschrijving" />
                                </BG:omschrijving>
                            </BG:inp.geboorteplaats>
                            <BG:inOnderzoek>
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
                            </BG:inOnderzoek>
                            <BG:inp.indicatieGeheim>
                                <xsl:value-of select="./geheimhoudingPersoonsgegevens" />
                            </BG:inp.indicatieGeheim>
                        </BG:inp.heeftAlsOuders>
                        <BG:inOnderzoek>
                            <xsl:value-of
                                select="./inOnderzoek[/groepsnaam = Persoonsgegevens/groepsnaam]/geslachtsaanduiding" />
                        </BG:inOnderzoek>
                    </xsl:for-each>
                </BG:object>
            </BG:antwoord>
        </BG:npsLa01></xsl:template>
</xsl:stylesheet>