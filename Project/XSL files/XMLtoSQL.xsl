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
	city_id_base VARCHAR(255),
	post VARCHAR(10),
	lat VARCHAR,
	long VARCHAR,
	country_id INT,
	PRIMARY KEY(city_id),
	FOREIGN KEY(country_id) REFERENCES Countries(country_id)
	);
	&#xa;
	</xsl:text>
	
	<xsl:for-each select="/CountryList/country">
		<xsl:text>INSERT INTO Countries(country_id, co_name, sc, lc)</xsl:text>
		<xsl:text>VALUES(</xsl:text>
		
		<xsl:variable name="counter" select="position()"/>
		
		<xsl:copy-of select="$counter"/>
		<xsl:text>, "</xsl:text>				
		<xsl:value-of select="normalize-space(./@co_name)"/>
		<xsl:text>", "</xsl:text>
		<xsl:value-of select="normalize-space(./@sc)"/>
		<xsl:text>", "</xsl:text>
		<xsl:value-of select="normalize-space(./@lc)"/>
		<xsl:text>");</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		
		<xsl:for-each select="./city">
			<xsl:text>INSERT INTO Cities(ci_name, city_id_base, post, lat, long, country_id)</xsl:text>
			<xsl:text>VALUES("</xsl:text>
			<xsl:value-of select="normalize-space(./@ci_name)"/>
			<xsl:text>", "</xsl:text>
			<xsl:value-of select="normalize-space(./@city_id)"/>
			<xsl:text>", "</xsl:text>
			<xsl:value-of select="normalize-space(./@post)"/>
			<xsl:text>", "</xsl:text>
			<xsl:value-of select="normalize-space(./geo/lat)"/>
			<xsl:text>", "</xsl:text>
			<xsl:value-of select="normalize-space(./geo/long)"/>
			<xsl:text>", </xsl:text>
			<xsl:copy-of select="$counter"/>
			<xsl:text>);</xsl:text>
			<xsl:text>&#xa;</xsl:text>
			
			<xsl:if test="position()= last()"><xsl:text>&#xa;&#xa;</xsl:text></xsl:if>
		</xsl:for-each>
		
		<xsl:if test="not(position()= last())"></xsl:if>
	</xsl:for-each>	

	<xsl:text>
	UPDATE Cities
	SET city_id = c.city_id
	FROM (	
	SELECT city_id_base, CAST(N'' AS XML).value('xs:base64Binary(sql:column("city_id_base"))', 'BINARY(255)')) AS city_id
	FROM Cities ) c
	WHERE city_id_base = c.city_id_base;
	
	ALTER TABLE Cities DROP COLUMN city_id_base;
	</xsl:text>
		
	</xsl:template>

</xsl:stylesheet>
