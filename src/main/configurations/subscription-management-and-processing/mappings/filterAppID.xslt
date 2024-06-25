<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Declare the parameter 'code' -->
    <xsl:param name="code" />

    <xsl:template match="/">
        <root>
            <!-- Apply a template to 'Applications' elements with the matching identifier -->
            <xsl:apply-templates select="root/Applications[identifier = $code]/appId" />
        </root>
    </xsl:template>

    <!-- Template for the 'appId' elements -->
    <xsl:template match="appId">
        
        <appId>
            <xsl:value-of select="." />
        </appId>
    </xsl:template>

</xsl:stylesheet>
