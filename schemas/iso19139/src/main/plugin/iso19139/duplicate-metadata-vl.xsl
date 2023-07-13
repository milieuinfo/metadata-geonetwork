<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                version="2.0" exclude-result-prefixes="#all">


  <xsl:include href="update-fixed-info-keywords.xsl"/>

  <xsl:variable name="serviceUrl" select="/root/env/siteURL"/>
  <xsl:variable name="nodeUrl" select="/root/env/nodeURL"/>
  <xsl:variable name="node" select="/root/env/node"/>


  <!-- Empty description -->
  <xsl:template match="gmd:identificationInfo/*/gmd:citation/*/gmd:alternateTitle">
    <gmd:alternateTitle gco:nilReason="missing">
      <gco:CharacterString/>
    </gmd:alternateTitle>
  </xsl:template>

  <!-- Empty parent identifier -->
  <xsl:template match="gmd:parentIdentifier">
    <gmd:parentIdentifier gco:nilReason="missing">
      <gco:CharacterString/>
    </gmd:parentIdentifier>
  </xsl:template>

  <!-- Set a new RS_Identifier or gmd:MD_Identifier -->
  <xsl:template match="gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier|
                       gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*"/>
      <gmd:code gco:nilReason="missing">
        <gco:CharacterString/>
      </gmd:code>
      <xsl:if test="name() = 'gmd:RS_Identifier'">
        <gmd:codeSpace gco:nilReason="missing">
          <gco:CharacterString/>
        </gmd:codeSpace>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Reinitialize feature catalogue description -->
  <xsl:template match="gmd:MD_FeatureCatalogueDescription">
    <gmd:MD_FeatureCatalogueDescription>
      <gmd:includedWithDataset>
        <gco:Boolean>true</gco:Boolean>
      </gmd:includedWithDataset>
      <gmd:featureCatalogueCitation uuidref=""/>
    </gmd:MD_FeatureCatalogueDescription>
  </xsl:template>
</xsl:stylesheet>
