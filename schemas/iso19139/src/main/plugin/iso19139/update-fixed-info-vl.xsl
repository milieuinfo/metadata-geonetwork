<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:gml320="http://www.opengis.net/gml"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:java="java:org.fao.geonet.util.XslUtil"
                version="2.0" exclude-result-prefixes="#all">
  <xsl:include href="../iso19139/convert/functions.xsl"/>
  <xsl:include href="layout/utility-fn.xsl"/>


  <!--  only accept the pointOfContact role code for a gmd:contact element -->
  <xsl:template match="gmd:role[name(../..)='gmd:contact']" priority="9000">
    <gmd:role>
      <gmd:CI_RoleCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact"/>
    </gmd:role>
  </xsl:template>


  <xsl:template match="gmd:dateTime" priority="9000">
    <xsl:variable name="child" select="gco:Date|gco:DateTime"/>
    <xsl:copy copy-namespaces="no">
      <xsl:if test="normalize-space($child) = ''">
        <xsl:attribute name="gco:nilReason" select="'missing'"/>
      </xsl:if>
      <xsl:if test="not(normalize-space($child) = '')">
        <gco:DateTime>
          <xsl:value-of select="$child"/>
        </gco:DateTime>
      </xsl:if>
    </xsl:copy>
  </xsl:template>


  <!-- Only gmd:referenceSystemIdentifier can have a gmd:RS_Identifier child element, all other RS_Identifier elements
      must be transformed to a MD:Identifier and existing child elements gmd:codeSpace and gmd:version must be removed -->
  <xsl:template match="gmd:RS_Identifier[not(name(..)='gmd:referenceSystemIdentifier')]" priority="9000">
    <gmd:MD_Identifier>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*[not(name(.)='gmd:codeSpace' or name(.)='gmd:version')]"/>
    </gmd:MD_Identifier>
  </xsl:template>


  <xsl:template match="*[not(name() = ('gmd:dateStamp', 'gmd:dateTime')) and gco:DateTime]" priority="9000">
    <xsl:variable name="child" select="gco:DateTime"/>
    <xsl:copy copy-namespaces="no">
      <xsl:if test="normalize-space($child) = ''">
        <xsl:attribute name="gco:nilReason" select="'missing'"/>
      </xsl:if>
      <xsl:if test="not(normalize-space($child) = '')">
        <xsl:apply-templates select="@*|node()"/>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[not(name() = ('gmd:dateStamp', 'gmd:dateTime')) and gco:Date]" priority="9000">
    <xsl:variable name="child" select="gco:Date"/>
    <xsl:copy copy-namespaces="no">
      <xsl:if test="normalize-space($child) = ''">
        <xsl:attribute name="gco:nilReason" select="'missing'"/>
      </xsl:if>
      <xsl:if test="not(normalize-space($child) = '')">
        <xsl:apply-templates select="@*|node()"/>
      </xsl:if>
    </xsl:copy>
  </xsl:template>


  <!-- @Override -->
  <!-- uuidref is always the dataset identifier and never the fileIdentifier. We should not use it for building the xlink:href -->
  <!-- Commit ref: 32ecb677b27ebfdfd709364acfc0e4cee4d57dd0 -->
  <!-- TODO: Check with François dataset-add.xsl "TODO" => issue to fix in the core ? -->
  <xsl:template match="srv:operatesOn|gmd:featureCatalogueCitation" priority="9000">
    <xsl:copy>
      <xsl:copy-of select="@*[name() != 'xlink:href']"/>
      <xsl:choose>
        <xsl:when test="@uuidref or @xlink:href">
          <xsl:copy-of select="@xlink:href"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="node()" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="gmd:pass" priority="9000">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="not(gco:Boolean) or normalize-space(gco:Boolean) = ''">
          <xsl:attribute name="gco:nilReason" select="'unknown'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@*[not(name() = 'gco:nilReason')]|*"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>


  <!-- Commit cdcb4310eb95f47de5be5fc35fb30a0482720376 not picked back for custom  -->
  <!-- Commit 52737e71bd72b3429a9a005965abf6bd78a91d28 not picked back for custom  -->

  <!-- TODO: Continue incrementatl check on update-fixed-info diff: http://gitlab.gim.be/gim-geonetwork/core-geonetwork/-/commits/clients/aiv/main/schemas/iso19139/src/main/plugin/iso19139/update-fixed-info.xsl   -->
<!--   TODO: Stopped at commit: "#108005 - Remove nilReason on non empty gmd:pass" -> 21a5246e72e3517e88ba4a00985d624e91e1296f -->
</xsl:stylesheet>
