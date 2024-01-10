<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gfc="http://www.isotc211.org/2005/gfc"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                version="2.0" exclude-result-prefixes="#all">

  <xsl:template match="gmx:versionDate|gfc:versionDate" priority="9009">
    <xsl:choose>
      <xsl:when test="/root/env/changeDate">
        <xsl:copy>
          <gco:Date>
            <xsl:value-of select="format-dateTime(/root/env/changeDate,'[Y0001]-[M01]-[D01]')"/>
          </gco:Date>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
