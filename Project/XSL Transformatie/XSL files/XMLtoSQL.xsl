<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet 
	version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>
	
	<xsl:template match="/">

	<xsl:text>DECLARE @city_id BINARY(255);&#xa;</xsl:text>
	<xsl:for-each select="/CountryList/country">
	<xsl:text>INSERT INTO Countries(co_name, sc, lc)</xsl:text>
	<xsl:text>VALUES('</xsl:text>				
	<xsl:value-of select="normalize-space(./@co_name)"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="normalize-space(./@sc)"/>
	<xsl:text>', '</xsl:text>
	<xsl:value-of select="normalize-space(./@lc)"/>
	<xsl:text>');</xsl:text>
	<xsl:text>&#xa;</xsl:text>
		
		<xsl:for-each select="./city">
		<xsl:text>EXEC Base64Decode '</xsl:text>
		<xsl:value-of select="normalize-space(./@city_id)"/>
		<xsl:text>', @city_id OUTPUT&#xa;</xsl:text>
		<xsl:text>INSERT INTO Cities(ci_name, city_id, post, lat, long, country_id)</xsl:text>
		<xsl:text>VALUES('</xsl:text>
		<xsl:variable name="city_name" select="./@ci_name" />
		<xsl:value-of select='replace($city_name, "&apos;", "&apos;&apos;")'/>
		<xsl:text>', @city_id, '</xsl:text>
		<xsl:value-of select="normalize-space(./@post)"/>
		<xsl:text>', '</xsl:text>
		<xsl:value-of select="normalize-space(./geo/lat)"/>
		<xsl:text>', '</xsl:text>
		<xsl:value-of select="normalize-space(./geo/long)"/>
		<xsl:text>', '</xsl:text>
		<xsl:value-of select="./../@lc"/>
		<xsl:text>');</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:if test="position()= last()"><xsl:text>&#xa;</xsl:text></xsl:if>
		</xsl:for-each>	
		<xsl:if test="not(position()= last())"></xsl:if>
	</xsl:for-each>		
	</xsl:template>

</xsl:stylesheet>
