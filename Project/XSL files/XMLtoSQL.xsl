<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet 
	version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>
	
	<xsl:template match="/">
	<xsl:for-each select="/CountryList/country">
		<xsl:value-of select="normalize-space(./@co_name)"/>
		<xsl:text>;</xsl:text>
		<xsl:value-of select="normalize-space(./@sc)"/>
		<xsl:text>;</xsl:text>
		<xsl:value-of select="normalize-space(./@lc)"/>
		<xsl:text>&#xa;</xsl:text>
		
		<xsl:for-each select="./city">
			<xsl:value-of select="normalize-space(./@ci_name)"/>
			<xsl:text>;</xsl:text>
			<xsl:value-of select="normalize-space(./@city_id)"/>
			<xsl:text>;</xsl:text>
			<xsl:value-of select="normalize-space(./geo/lat)"/>
			<xsl:text>;</xsl:text>
			<xsl:value-of select="normalize-space(./geo/long)"/>
			
			<xsl:if test="not(position()= last())"></xsl:if>
		</xsl:for-each>
		
		<xsl:if test="not(position()= last())"></xsl:if>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>&#xa;</xsl:text>
	</xsl:for-each>
	
	
		
		
	</xsl:template>

</xsl:stylesheet>
