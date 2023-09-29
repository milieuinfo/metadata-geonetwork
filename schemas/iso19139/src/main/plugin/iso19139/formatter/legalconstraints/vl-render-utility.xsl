<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                version="2.0"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">

  <xsl:template name="render-row">
    <xsl:param name="label" as="xs:string"/>
    <xsl:param name="content"/>
    <tr>
      <th>
        <xsl:value-of select="$label"/>
      </th>
      <td>
        <xsl:copy-of select="$content"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="render-anchor-as-row">
    <xsl:param name="label" as="xs:string"/>
    <xsl:param name="link" as="xs:string"/>
    <xsl:param name="value" as="xs:string"/>
    <xsl:call-template name="render-row">
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="content">
        <a href="{$link}" target="_blank">
          <xsl:value-of select="$value"/>
        </a>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="render-url-as-row">
    <xsl:param name="label" as="xs:string"/>
    <xsl:param name="url" as="xs:string"/>
    <xsl:param name="prefix" as="xs:string" select="''"/>
    <xsl:if test="$url!=''">
      <xsl:call-template name="render-row">
        <xsl:with-param name="label" select="$label"/>
        <xsl:with-param name="content">
          <a class="gn-break" href="{concat($prefix, $url)}" target="_blank">
            <xsl:value-of select="$url"/>
          </a>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="render-text-as-row">
    <xsl:param name="label" as="xs:string"/>
    <xsl:param name="value"/>
    <xsl:if test="normalize-space($value)">
      <xsl:call-template name="render-row">
        <xsl:with-param name="label" select="$label"/>
        <xsl:with-param name="content" select="$value"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="render-block">
    <xsl:param name="header" required="no"/>
    <xsl:param name="block" as="node()"/>
    <xsl:if test="normalize-space($block)">
      <xsl:if test="$header">
        <h3 class="view-header gp-header">
          <xsl:value-of select="$header"/>
        </h3>
      </xsl:if>
      <table class="table table-striped">
        <tbody>
          <xsl:copy-of select="$block"/>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <xsl:template name="render-row-with-colspan">
    <xsl:param name="header" as="xs:string"/>
    <xsl:param name="content"/>
    <tr>
      <td colspan="2" class="gp-nest-row">
        <h3 class="view-header gp-header">
          <xsl:value-of select="$header"/>
        </h3>
        <xsl:copy-of select="$content"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="render-block-as-row-with-header">
    <xsl:param name="header" as="xs:string"/>
    <xsl:param name="block" as="node()"/>
    <xsl:if test="normalize-space($block)">
      <xsl:call-template name="render-row-with-colspan">
        <xsl:with-param name="header" select="$header"/>
        <xsl:with-param name="content">
          <xsl:call-template name="render-block">
            <xsl:with-param name="block" select="$block"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
