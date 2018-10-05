<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet 
	version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>
	
	<xsl:template match="/">
	
<xsl:text>CREATE TABLE Countries (
country_id INT,
co_name NVARCHAR(255),
sc CHAR(2),
lc CHAR(3),
PRIMARY KEY(country_id)
);
CREATE TABLE Cities (
ci_name NVARCHAR(255),
city_id BINARY(255),
post VARCHAR(10),
lat VARCHAR(25),
long VARCHAR(25),
country_id INT,
PRIMARY KEY (city_id),
FOREIGN KEY(country_id) REFERENCES Countries(country_id)
);

USE catchem;
GO
CREATE PROCEDURE Base64Decode
@city_id_base VARCHAR(MAX),
@result BINARY(255) OUTPUT
AS
SELECT @result = CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@city_id_base"))', 'BINARY(255)')
GO
&#xa;</xsl:text>

	<xsl:text>DECLARE @city_id BINARY(255)&#xa;</xsl:text>
	<xsl:for-each select="/CountryList/country">
	<xsl:text>INSERT INTO Countries(country_id, co_name, sc, lc)</xsl:text>
	<xsl:text>VALUES(</xsl:text>	
	<xsl:variable name="counter" select="position()"/>	
	<xsl:copy-of select="$counter"/>
	<xsl:text>, '</xsl:text>				
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
		<xsl:text>', </xsl:text>
		<xsl:copy-of select="$counter"/>
		<xsl:text>);</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:if test="position()= last()"><xsl:text>&#xa;</xsl:text></xsl:if>
		</xsl:for-each>	
		<xsl:if test="not(position()= last())"></xsl:if>
	</xsl:for-each>		
	</xsl:template>

</xsl:stylesheet>
