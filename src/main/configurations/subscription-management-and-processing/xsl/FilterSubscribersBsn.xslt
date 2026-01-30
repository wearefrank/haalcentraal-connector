<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <!-- Match the root element -->
  <xsl:template match="/results">
    <burgerservicesnummers>
      <!-- Iterate over all field elements that are not empty -->
      <xsl:for-each select=".//field[string-length(normalize-space()) > 0]">
        <bsn>
          <xsl:value-of select="."/>
        </bsn>
      </xsl:for-each>
    </burgerservicesnummers>
  </xsl:template>

</xsl:stylesheet>
