CREATE TABLE Countries (
co_name NVARCHAR(255),
sc CHAR(2),
lc CHAR(3),
PRIMARY KEY(lc)
);

CREATE TABLE Cities (
ci_name NVARCHAR(255),
city_id BINARY(255),
post VARCHAR(10),
lat VARCHAR(25),
long VARCHAR(25),
country_id CHAR(3),
PRIMARY KEY (city_id),
FOREIGN KEY(country_id) REFERENCES Countries(lc)
);

CREATE PROCEDURE Base64Decode
@city_id_base VARCHAR(MAX),
@result BINARY(255) OUTPUT
AS
SELECT @result = CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@city_id_base"))', 'BINARY(255)');