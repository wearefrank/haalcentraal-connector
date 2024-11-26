<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <!-- Output format -->
    <xsl:output method="xml" indent="yes" />

    <!-- Match the root node and output a simple true result -->
    <xsl:template match="/">
        <result>true</result>
    </xsl:template>
    
</xsl:stylesheet>
