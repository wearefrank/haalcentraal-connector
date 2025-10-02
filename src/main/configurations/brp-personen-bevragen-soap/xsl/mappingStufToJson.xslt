<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" />
    <xsl:param name="varZenderApplicatie" />
    <xsl:param name="apps_requestwithAdres" />
    <xsl:param name="gemeenteVanInschrijving" />
    <xsl:param name="inclusiefOverledenPersonen" />
    <xsl:param name="fields" as="node()?" />
    <xsl:template match="/">
        <xsl:param name="vanafBSN" select="//BG:vanaf//*[local-name() = 'inp.bsn']" />
        <xsl:param
            name="totEnMetBSN" select="//BG:totEnMet//*[local-name() = 'inp.bsn']" />
        <root>
            <xsl:choose>
                <xsl:when test="boolean(//*[contains(name(),'bsn')]/text())">
                    <type>RaadpleegMetBurgerservicenummer</type>
                    <xsl:choose>
                        <xsl:when test="$varZenderApplicatie=&apos;DEC_ZKN&apos;">
                            <xsl:for-each select="$fields/root/DEC_ZKN/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$varZenderApplicatie=&apos;TOP&apos;">
                            <xsl:for-each select="$fields/root/TOP/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$varZenderApplicatie=&apos;GWS&apos;">
                            <xsl:for-each select="$fields/root/GWS/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$varZenderApplicatie=&apos;LBA&apos;">
                            <xsl:for-each select="$fields/root/LBA/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$varZenderApplicatie=&apos;PGAx-SG-ZVH&apos;">
                            <xsl:for-each select="$fields/root/PGAx/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                    <!-- <xsl:choose>
                         <xsl:when test="$gemeenteVanInschrijving !=''">
                         <gemeenteVanInschrijving>
                         <xsl:value-of
                         select="$gemeenteVanInschrijving" />
                         </gemeenteVanInschrijving>
                         </xsl:when>
                         <xsl:otherwise></xsl:otherwise>
                         </xsl:choose> -->
                    <xsl:choose>
                        <xsl:when test="count(//*[contains(name(),'bsn')]/text()) > 1">
                            <xsl:call-template
                                name="generateRangeForBSN">
                                <xsl:with-param name="vanafBSN" select="$vanafBSN" />
                                <xsl:with-param name="totEnMetBSN" select="$totEnMetBSN" />
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <burgerservicenummer>
                                <xsl:value-of select="//*[contains(name(),'bsn')]/text()" />
                            </burgerservicenummer>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                
                <xsl:when
                    test="((boolean(//*[contains(name(),'geslachtsnaam')][1]/text())) and
                            (boolean(//*[contains(name(),'geboortedatum')][1]/text())))">
                    <type>ZoekMetGeslachtsnaamEnGeboortedatum</type>
                    <xsl:for-each
                        select="$fields/root/zoekMet/fields">
                        <fields>
                            <xsl:value-of select="." />
                        </fields>
                    </xsl:for-each>
                    <!-- <xsl:choose>
                         <xsl:when test="$gemeenteVanInschrijving !=''">
                         <gemeenteVanInschrijving>
                         <xsl:value-of
                         select="$gemeenteVanInschrijving" />
                         </gemeenteVanInschrijving>
                         </xsl:when>
                         <xsl:otherwise></xsl:otherwise>
                         </xsl:choose> -->
                    <inclusiefOverledenPersonen>
                        <xsl:value-of select="$inclusiefOverledenPersonen" />
                    </inclusiefOverledenPersonen>
                    <geboortedatum>
                        <xsl:variable name="geboortedatum"><xsl:value-of
                                select="//*[local-name()='geboortedatum'][1]/text()" />
                        </xsl:variable>
                        <xsl:value-of
                            select="concat(substring($geboortedatum, 1, 4), '-', substring($geboortedatum, 5, 2), '-', substring($geboortedatum, 7, 2))" />
                    </geboortedatum>
                    <geslachtsnaam>
                        <xsl:value-of
                            select="//*[local-name()='geslachtsnaam'][1]/text()" />
                    </geslachtsnaam>
                    <xsl:choose>
                        <xsl:when test="//*[local-name()='geslacht'][1] !=''">
                            <geslacht>
                                <xsl:value-of
                                    select="//*[local-name()='geslacht'][1]" />
                            </geslacht>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="//*[local-name()='voorvoegselGeslachtsnaam'][1]/text() !=''">
                            <voorvoegsel>
                                <xsl:value-of
                                    select="//*[local-name()='voorvoegselGeslachtsnaam'][1]/text()" />
                            </voorvoegsel>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="//*[local-name()='voornamen'][1]/text()">
                            <voornamen>
                                <xsl:value-of
                                    select="//*[local-name()='voornamen'][1]/text()" />
                            </voornamen>
                            
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when
                    test="((boolean(//*[contains(name(),'geslachtsnaam')][1]/text())) and
                            (boolean(//*[contains(name(),'voornamen')][1]/text())) and
                            ($gemeenteVanInschrijving !='') and
                            (boolean(//*[contains(name(),'woonplaatsNaam')][1]/text())))">
                    <xsl:choose>
                        <xsl:when test="contains($apps_requestwithAdres, $varZenderApplicatie)">
                            <type>ZoekMetNaamEnGemeenteVanInschrijving</type>                    
                            <xsl:for-each
                                select="$fields/root/zoekMet/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>                        
                            <xsl:choose>
                                <xsl:when test="$gemeenteVanInschrijving !=''">
                                    <gemeenteVanInschrijving>
                                        <xsl:value-of
                                            select="$gemeenteVanInschrijving" />
                                    </gemeenteVanInschrijving>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <inclusiefOverledenPersonen>
                                <xsl:value-of select="$inclusiefOverledenPersonen" />
                            </inclusiefOverledenPersonen>
                            <xsl:choose>
                                <xsl:when test="//*[local-name()='geslacht'][1] !=''">
                                    <geslacht>
                                        <xsl:value-of
                                            select="//*[local-name()='geslacht'][1]" />
                                    </geslacht>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            
                            <geslachtsnaam>
                                <xsl:value-of
                                    select="//*[local-name()='geslachtsnaam'][1]
                                    /text()" />
                            </geslachtsnaam>
                            <xsl:choose>
                                <xsl:when test="//*[local-name()='voorvoegselGeslachtsnaam'][1]/text() !=''">
                                    <voorvoegsel>
                                        <xsl:value-of
                                            select="//*[local-name()='voorvoegselGeslachtsnaam'][1]/text()" />
                                    </voorvoegsel>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <voornamen>
                                <xsl:value-of
                                    select="//*[local-name()='voornamen'][1]/text()" />
                            </voornamen>
                        </xsl:when>
                        <xsl:otherwise>
                            <text>The app <xsl:value-of select="$varZenderApplicatie"/> is not allowed for this request</text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                
                <xsl:when
                    test="((boolean(//*[contains(name(),'postcode')][1]/text())) and
                            (boolean(//*[contains(name(),'huisnummer')][1]/text())))">
                    <xsl:choose>
                        <xsl:when test="contains($apps_requestwithAdres, $varZenderApplicatie)">
                            <type>ZoekMetPostcodeEnHuisnummer</type>
                            <xsl:for-each
                                select="$fields/root/zoekMet/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                            <!-- <xsl:choose>
                                 <xsl:when test="$gemeenteVanInschrijving !=''">
                                 <gemeenteVanInschrijving>
                                 <xsl:value-of
                                 select="$gemeenteVanInschrijving" />
                                 </gemeenteVanInschrijving>
                                 </xsl:when>
                                 <xsl:otherwise></xsl:otherwise>
                                 </xsl:choose> -->
                            <inclusiefOverledenPersonen>
                                <xsl:value-of select="$inclusiefOverledenPersonen" />
                            </inclusiefOverledenPersonen>
                            <xsl:choose>
                                <xsl:when test="//*[contains(name(),'huisletter')][1]/text() !=''">
                                    <huisletter>
                                        <xsl:value-of
                                            select="//*[contains(name(),'huisletter')][1]/text()" />
                                    </huisletter>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <huisnummer>
                                <xsl:value-of
                                    select="//*[local-name()='aoa.huisnummer'][1]/text()" />
                            </huisnummer>
                            <xsl:choose>
                                <xsl:when test="//*[contains(name(),'huisnummertoevoeging')][1]/text() !=''">
                                    <huisnummertoevoeging>
                                        <xsl:value-of
                                            select="//*[contains(name(),'huisnummertoevoeging')][1]/text()" />
                                    </huisnummertoevoeging>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <postcode>
                                <xsl:value-of
                                    select="//*[local-name()='aoa.postcode'][1]/text()" />
                            </postcode>
                        </xsl:when>
                        <xsl:otherwise>
                            <text>The app <xsl:value-of select="$varZenderApplicatie"/> is not allowed for this request</text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when
                    test="((boolean(//*[contains(name(),'straatnaam')][1]/text())) and
                            (boolean(//*[contains(name(),'woonplaatsNaam')][1]/text())) and
                            ($gemeenteVanInschrijving !='') and
                            (boolean(//*[contains(name(),'huisnummer')][1]/text())))">
                    <xsl:choose>
                        <xsl:when test="contains($apps_requestwithAdres, $varZenderApplicatie)">
                            <type>ZoekMetStraatHuisnummerEnGemeenteVanInschrijving</type>
                            <xsl:for-each
                                select="$fields/root/zoekMet/fields">
                                <fields>
                                    <xsl:value-of select="." />
                                </fields>
                            </xsl:for-each>
                            <xsl:choose>
                                <xsl:when test="$gemeenteVanInschrijving !=''">
                                    <gemeenteVanInschrijving>
                                        <xsl:value-of
                                            select="$gemeenteVanInschrijving" />
                                    </gemeenteVanInschrijving>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <inclusiefOverledenPersonen>
                                <xsl:value-of select="$inclusiefOverledenPersonen" />
                            </inclusiefOverledenPersonen>
                            <xsl:choose>
                                <xsl:when test="//*[contains(name(),'huisletter')][1]/text() !=''">
                                    <huisletter>
                                        <xsl:value-of
                                            select="//*[contains(name(),'huisletter')][1]/text()" />
                                    </huisletter>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <huisnummer>
                                <xsl:value-of
                                    select="//*[local-name()='aoa.huisnummer'][1]/text()" />
                            </huisnummer>
                            <xsl:choose>
                                <xsl:when test="//*[contains(name(),'huisnummertoevoeging')][1]/text() !=''">
                                    <huisnummertoevoeging>
                                        <xsl:value-of
                                            select="//*[contains(name(),'huisnummertoevoeging')][1]/text()" />
                                    </huisnummertoevoeging>
                                </xsl:when>
                                <xsl:otherwise></xsl:otherwise>
                            </xsl:choose>
                            <straat>
                                <xsl:value-of
                                    select="//*[local-name()='gor.straatnaam'][1]/text()" />
                            </straat>
                        </xsl:when>
                        <xsl:otherwise>
                            <text>The app <xsl:value-of select="$varZenderApplicatie"/> is not allowed for this request</text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </root>
    </xsl:template>
    <xsl:template name="generateRangeForBSN">
        <xsl:param name="vanafBSN" />
        <xsl:param name="totEnMetBSN" />
        <!-- Output the current number -->
        <burgerservicenummer>
            <xsl:variable name="unpaddedBSN" select="format-number($vanafBSN, '0')" />
            <xsl:value-of select="concat(if (string-length($unpaddedBSN) = 8) then '0' else '', $unpaddedBSN)"/>
        </burgerservicenummer>
        <xsl:if
            test="$vanafBSN != $totEnMetBSN">
            <!-- Recursive call to generate the next number -->
            <xsl:call-template name="generateRangeForBSN">
                <xsl:with-param name="vanafBSN" select="$vanafBSN + 1" />
                <xsl:with-param name="totEnMetBSN" select="$totEnMetBSN" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>