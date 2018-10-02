<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet 
	version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>
	
	<xsl:template match="/">
	
	<xsl:text>
	CREATE TABLE Countries (
	country_id INT,
	co_name NVARCHAR(255),
	sc CHAR(2),
	lc CHAR(3),
	PRIMARY KEY(country_id)
	);

	CREATE TABLE Cities (
	ci_name NVARCHAR(255),
	city_id BINARY(255),
	city_id_base VARCHAR(MAX),
	post VARCHAR(10),
	lat VARCHAR(25),
	long VARCHAR(25),
	country_id INT,
	FOREIGN KEY(country_id) REFERENCES Countries(country_id)
	);
	SET ANSI_WARNINGS OFF;
	&#xa;
	</xsl:text>
	
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
			<xsl:text>INSERT INTO Cities(ci_name, city_id_base, post, lat, long, country_id)</xsl:text>
			<xsl:text>VALUES('</xsl:text>
			<xsl:variable name="city_name" select="./@ci_name" />
			<xsl:value-of select='replace($city_name, "&apos;", "&apos;&apos;")'/>
			<xsl:text>', '</xsl:text>
			<xsl:value-of select="normalize-space(./@city_id)"/>
			<xsl:text>', '</xsl:text>
			<xsl:value-of select="normalize-space(./@post)"/>
			<xsl:text>', '</xsl:text>
			<xsl:value-of select="normalize-space(./geo/lat)"/>
			<xsl:text>', '</xsl:text>
			<xsl:value-of select="normalize-space(./geo/long)"/>
			<xsl:text>', </xsl:text>
			<xsl:copy-of select="$counter"/>
			<xsl:text>);</xsl:text>
			<xsl:text>&#xa;</xsl:text>
			
			<xsl:if test="position()= last()"><xsl:text>&#xa;&#xa;</xsl:text></xsl:if>
		</xsl:for-each>
		
		<xsl:if test="not(position()= last())"></xsl:if>
	</xsl:for-each>	

	<xsl:text>
	SET ANSI_WARNINGS ON;
	&#xa;
	UPDATE Cities
	SET city_id = CAST(N'' AS XML).value('xs:base64Binary(sql:column("city_id_base"))', 'BINARY(255)');

	ALTER TABLE Cities ALTER COLUMN city_id BINARY(255) NOT NULL;
	ALTER TABLE Cities ADD PRIMARY KEY (city_id);
	ALTER TABLE Cities DROP COLUMN city_id_base;
	</xsl:text>
		
	</xsl:template>

</xsl:stylesheet>
