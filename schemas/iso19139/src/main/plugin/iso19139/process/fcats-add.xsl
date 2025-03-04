<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<!--
Stylesheet used to update metadata for a service and
attached it to the metadata for data.
-->
<xsl:stylesheet xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gfc="http://www.isotc211.org/2005/gfc"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:param name="uuidref"/>
  <xsl:param name="siteUrl"/>
  <xsl:param name="fcatsUrl" select="''"/>
  <xsl:param name="fcatsTitle" select="''"/>
  <!-- VL - 'select' is for default values, don't pass it and it becomes a required param -->
  <xsl:param name="versionDate" select="''"/>
  <xsl:param name="versionNumber" select="''"/>

  <xsl:template match="/gmd:MD_Metadata|*[@gco:isoType='gmd:MD_Metadata']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:copy-of
        select="gmd:fileIdentifier|
                gmd:language|
                gmd:characterSet|
                gmd:parentIdentifier|
                gmd:hierarchyLevel|
                gmd:hierarchyLevelName|
                gmd:contact|
                gmd:dateStamp|
                gmd:metadataStandardName|
                gmd:metadataStandardVersion|
                gmd:dataSetURI|
                gmd:locale|
                gmd:spatialRepresentationInfo|
                gmd:referenceSystemInfo|
                gmd:metadataExtensionInfo|
                gmd:identificationInfo"/>


      <xsl:variable name="citationWithRef"
                    select="gmd:contentInfo/*/gmd:featureCatalogueCitation[@uuidref = $uuidref]"/>
      <xsl:choose>
        <!-- Check if featureCatalogueCitation for uuidref -->
        <xsl:when test="$citationWithRef">
          <gmd:contentInfo>
            <gmd:MD_FeatureCatalogueDescription>
              <xsl:copy-of select="$citationWithRef/../gmd:complianceCode|
                                   $citationWithRef/../gmd:language|
                                   $citationWithRef/../gmd:includedWithDataset|
                                   $citationWithRef/../gmd:featureTypes"/>

              <xsl:call-template name="make-fcats-link"/>

            </gmd:MD_FeatureCatalogueDescription>
          </gmd:contentInfo>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="gmd:contentInfo[
                                 count(*/gmd:featureCatalogueCitation) > 0 and
                                 normalize-space(*/gmd:featureCatalogueCitation/@uuidref) != ''
                               ]"/>
          <gmd:contentInfo>
            <gmd:MD_FeatureCatalogueDescription>
              <gmd:includedWithDataset>
                <gco:Boolean>true</gco:Boolean>
              </gmd:includedWithDataset>
              <xsl:call-template name="make-fcats-link"/>
            </gmd:MD_FeatureCatalogueDescription>
          </gmd:contentInfo>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:copy-of select="gmd:distributionInfo|
                            gmd:dataQualityInfo|
                            gmd:portrayalCatalogueInfo|
                            gmd:metadataConstraints|
                            gmd:applicationSchemaInfo|
                            gmd:metadataMaintenance|
                            gmd:series|
                            gmd:describes|
                            gmd:propertyType|
                            gmd:featureType|
                            gmd:featureAttribute"/>


      <xsl:apply-templates select="*[namespace-uri()!='http://www.isotc211.org/2005/gmd' and
                                     namespace-uri()!='http://www.isotc211.org/2005/srv']"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="make-fcats-link">
    <gmd:featureCatalogueCitation uuidref="{$uuidref}">
      <xsl:if test="$fcatsTitle != ''">
        <xsl:attribute name="xlink:title" select="$fcatsTitle"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$fcatsUrl != ''">
          <xsl:attribute name="xlink:href" select="$fcatsUrl"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="xlink:href"
                         select="concat($siteUrl, 'csw?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=http://www.isotc211.org/2005/gfc&amp;elementSetName=full&amp;id=', $uuidref)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="add-citation"/>
    </gmd:featureCatalogueCitation>
  </xsl:template>

  <xsl:template name="add-citation">
    <gmd:CI_Citation>
      <gmd:title>
        <gco:CharacterString>
          <xsl:value-of select="$fcatsTitle"/>
        </gco:CharacterString>
      </gmd:title>
      <gmd:date>
        <gmd:CI_Date>
          <gmd:date>
            <gco:Date>
              <xsl:value-of select="$versionDate"/>
            </gco:Date>
          </gmd:date>
          <gmd:dateType>
            <gmd:CI_DateTypeCode codeListValue="revision"
                                 codeList="https://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode"/>
          </gmd:dateType>
        </gmd:CI_Date>
      </gmd:date>
      <gmd:edition>
        <gco:CharacterString>
          <xsl:value-of select="$versionNumber"/>
        </gco:CharacterString>
      </gmd:edition>
    </gmd:CI_Citation>
  </xsl:template>

  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>
