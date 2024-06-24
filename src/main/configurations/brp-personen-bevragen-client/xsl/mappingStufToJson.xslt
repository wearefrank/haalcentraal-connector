<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:param name="varZenderOrganisatie" />
    <xsl:template match="/">
        <root>
            <xsl:choose>
                <xsl:when test="((boolean(//*[contains(name(),'bsn')]/text())) and not(//*[contains(name(),'huisnummer')])) ">
                    <type>RaadpleegMetBurgerservicenummer</type>
                   
                <fields>burgerservicenummer</fields>
                <fields>aNummer</fields>
                <fields>adressering</fields>
                <fields>datumInschrijvingInGemeente</fields>
                <fields>geboorte</fields>
                <fields>gemeenteVanInschrijving</fields>
                <fields>geslacht</fields>
                <fields>leeftijd</fields>
                <fields>naam</fields>
                <fields>nationaliteiten</fields>
                <fields>overlijden</fields>
                <fields>verblijfplaats</fields>
                <fields>verblijfplaatsBinnenland</fields>
                <fields>adresseringBinnenland</fields>
                <gemeenteVanInschrijving>
                        <xsl:value-of
                            select="$varZenderOrganisatie" />
                    </gemeenteVanInschrijving>
                    <xsl:choose>
                        <xsl:when test="count(//*[contains(name(),'bsn')]/text()) > 1">
                            <!-- <xsl:for-each
                                select="">
                                <burgerservicenummer>
                                    <xsl:variable name="counter"
                                        select="(//*[local-name() = 'inp.bsn'])[1]" />
                                    <xsl:value-of select="$counter" />
                                </burgerservicenummer>
                            </xsl:for-each> -->
                        </xsl:when>
                        <xsl:otherwise>
                            <burgerservicenummer>
                                <xsl:value-of select="//*[contains(name(),'bsn')]/text()" />
                            </burgerservicenummer>
                            <!-- 
                            <burgerservicenummer>
                                999990044
                            </burgerservicenummer> -->
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:when>
                <xsl:when
                    test="((boolean(//*[contains(name(),'geslachtsnaam')]/text())) and (boolean(//*[contains(name(),'geboortedatum')]/text())))">
                    <type>ZoekMetGeslachtsnaamEnGeboortedatum</type>
                    <fields>burgerservicenummer</fields>
                    <fields>adressering</fields>
                    <fields>geboorte</fields>
                    <fields>geslacht</fields>
                    <fields>leeftijd</fields>
                    <fields>naam</fields>
                    <fields>adresseringBinnenland</fields>
                    <gemeenteVanInschrijving>
                        <xsl:value-of
                            select="$varZenderOrganisatie" />
                    </gemeenteVanInschrijving>
                    <inclusiefOverledenPersonen>
                        <xsl:value-of
                            select="//*[contains(name(),'inclusiefOverledenPersonen')]/text()" />
                    </inclusiefOverledenPersonen>
                    <geboortedatum>
                        <xsl:value-of
                            select="//*[local-name()='geboortedatum']/text()" />
                    </geboortedatum>
                    <geslachtsnaam>
                        <xsl:value-of
                            select="//*[local-name()='geslachtsnaam']/text()" />
                    </geslachtsnaam>
                    <geslacht>
                        <xsl:value-of
                            select="//*[local-name()='geslacht']" />
                    </geslacht>
                    <voorvoegsel>
                        <xsl:value-of
                            select="//*[local-name()='voorvoegselGeslachtsnaam']/text()" />
                    </voorvoegsel>
                    <voornamen>
                        <xsl:value-of
                            select="//*[local-name()='voornamen']/text()" />
                    </voornamen>
                </xsl:when>

                <xsl:when
                    test="((boolean(//*[contains(name(),'geslachtsnaam')]/text())) and (boolean(//*[contains(name(),'voornamen')]/text())) and (boolean(//*[contains(name(),'woonplaatsnaam')]/text())))">
                    <type>ZoekMetNaamEnGemeenteVanInschrijving</type>
                    <fields>burgerservicenummer</fields>
                    <fields>adressering</fields>
                    <fields>geboorte</fields>
                    <fields>geslacht</fields>
                    <fields>leeftijd</fields>
                    <fields>naam</fields>
                    <fields>adresseringBinnenland</fields>
                    <gemeenteVanInschrijving>
                        <xsl:value-of
                            select="$varZenderOrganisatie" />
                    </gemeenteVanInschrijving>
                    <inclusiefOverledenPersonen>
                        <xsl:value-of
                            select="//*[contains(name(),'inclusiefOverledenPersonen')]/text()" />
                    </inclusiefOverledenPersonen>
                    <geslacht>
                        <xsl:value-of
                            select="//*[local-name()='geslacht']" />
                    </geslacht>
                    <geslachtsnaam>
                        <xsl:value-of
                            select="//*[local-name()='geslachtsnaam']/text()" />
                    </geslachtsnaam>
                    <voorvoegsel>
                        <xsl:value-of
                            select="//*[local-name()='voorvoegselGeslachtsnaam']/text()" />
                    </voorvoegsel>
                    <voornamen>
                        <xsl:value-of
                            select="//*[local-name()='voornamen']/text()" />
                    </voornamen>
                </xsl:when>

                <xsl:when
                    test="((boolean(//*[contains(name(),'postcode')]/text())) and (boolean(//*[contains(name(),'huisnummer')]/text())))">
                    <type>ZoekMetPostcodeEnHuisnummer</type>
                    <fields>burgerservicenummer</fields>
                    <fields>adressering</fields>
                    <fields>geboorte</fields>
                    <fields>geslacht</fields>
                    <fields>leeftijd</fields>
                    <fields>naam</fields>
                    <fields>adresseringBinnenland</fields>
                    <gemeenteVanInschrijving>
                        <xsl:value-of
                            select="$varZenderOrganisatie" />
                    </gemeenteVanInschrijving>
                    <!-- <inclusiefOverledenPersonen>
                        <xsl:value-of
                            select="//*[contains(name(),'inclusiefOverledenPersonen')]/text()" />
                    </inclusiefOverledenPersonen>
                    <huisletter>
                        <xsl:value-of
                            select="//*[contains(name(),'huisletter')]/text()" />
                    </huisletter> -->
                    <huisnummer>
                        <xsl:value-of
                            select="//*[local-name()='aoa.huisnummer']/text()" />
                    </huisnummer>
                    <!-- <huisnummertoevoeging>
                        <xsl:value-of
                            select="//*[contains(name(),'huisnummertoevoeging')]/text()" />
                    </huisnummertoevoeging> -->
                    <postcode>
                        <xsl:value-of
                            select="//*[local-name()='aoa.postcode']/text()" />
                    </postcode>
                </xsl:when>
                <xsl:when
                    test="((boolean(//*[contains(name(),'straatnaam')]/text())) and (boolean(//*[contains(name(),'woonplaatsNaam')]/text())) and (boolean(//*[contains(name(),'huisnummer')]/text())))">
                    <type>ZoekMetStraatHuisnummerEnGemeenteVanInschrijving</type>
                    <fields>burgerservicenummer</fields>
                    <fields>adressering</fields>
                    <fields>geboorte</fields>
                    <fields>geslacht</fields>
                    <fields>leeftijd</fields>
                    <fields>naam</fields>
                    <fields>adresseringBinnenland</fields>
                    <gemeenteVanInschrijving>
                        <xsl:value-of
                            select="$varZenderOrganisatie" />
                    </gemeenteVanInschrijving>
                    <inclusiefOverledenPersonen>
                        <xsl:value-of
                            select="//*[contains(name(),'inclusiefOverledenPersonen')]/text()" />
                    </inclusiefOverledenPersonen>
                    <huisletter>
                        <xsl:value-of
                            select="//*[local-name()='aoa.huisletter']/text()" />
                    </huisletter>
                    <huisnummer>
                        <xsl:value-of
                            select="//*[local-name()='aoa.huisnummer']/text()" />
                    </huisnummer>
                    <huisnummertoevoeging>
                        <xsl:value-of
                            select="//*[local-name()='aoa.huisnummertoevoeging']/text()" />
                    </huisnummertoevoeging>
                    <straat>
                        <xsl:value-of
                            select="//*[local-name()='gor.straatnaam']/text()" />
                    </straat>
                </xsl:when>
            </xsl:choose>
        </root>
    </xsl:template>
</xsl:stylesheet>