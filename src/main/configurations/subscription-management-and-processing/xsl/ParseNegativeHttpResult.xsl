<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="senderPipeName" select="''" as="xs:string" />

    <xsl:template match="/">
        <error>
            <xsl:choose>
                <xsl:when test="root/status=400">
                    <code>TranslationError</code>
                    <reason>400 Bad Request from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=401">
                    <code>TechnicalError</code>
                    <reason>401 Unauthorized from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=403">
                    <code>TechnicalError</code>
                    <reason>403 Forbidden from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=404">
                    <code>TechnicalError</code>
                    <reason>404 Not Found from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=406">
                    <code>TechnicalError</code>
                    <reason>406 Not Acceptable from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=415">
                    <code>TechnicalError</code>
                    <reason>415 Unsupported Media Type from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=429">
                    <code>TechnicalError</code>
                    <reason>429 Too Many Request from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=500">
                    <code>TechnicalError</code>
                    <reason>500 Internal Server Error from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:when test="root/status=503">
                    <code>TechnicalError</code>
                    <reason>503 Service Unavailable from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:when>
                <xsl:otherwise>
                    <code>TechnicalError</code>
                    <reason>some negative response from BRP API Personen received by <xsl:value-of select="$senderPipeName" /></reason>
                </xsl:otherwise>
            </xsl:choose>
            <details>
                <xsl:value-of select="concat(/root/code, ' ', /root/title, ' ', /root/status, ' ', /root/detail)" />
            </details>
            <detailsXml>
                <xsl:copy-of select="."/>
            </detailsXml>
        </error>
    </xsl:template>
</xsl:stylesheet>
