<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Match the root element -->
  <xsl:template match="/root">
    <!-- Create a new root element -->
    <historicBsns>
      <!-- Select all historicBsns elements and copy them -->
      <xsl:for-each select="data/historicBsns">
        <bsn><xsl:value-of select="."/></bsn>
      </xsl:for-each>
    </historicBsns>
  </xsl:template>

</xsl:stylesheet>
