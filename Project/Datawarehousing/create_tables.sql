use catchem_dwh
go

CREATE TABLE dim_day
(
  DATE_SK INT
, YEAR_NUMBER INT
, MONTH_NUMBER INT
, DAY_OF_YEAR_NUMBER INT
, DAY_OF_MONTH_NUMBER INT
, DAY_OF_WEEK_NUMBER INT
, WEEK_OF_YEAR_NUMBER INT
, DAY_NAME VARCHAR(30)
, MONTH_NAME VARCHAR(30)
, QUARTER_NUMBER INT
, QUARTER_NAME VARCHAR(2)
, YEAR_QUARTER_NAME VARCHAR(32)
, WEEKEND_IND VARCHAR(1)
, DAYS_IN_MONTH_QTY INT
, DAY_DESC VARCHAR(100)
, WEEK_SK INT
, DAY_DATE DATETIME2
, WEEK_NAME VARCHAR(32)
, WEEK_OF_MONTH_NUMBER INT
, WEEK_OF_MONTH_NAME VARCHAR(100)
, YEAR_SK INT
, MONTH_SK INT
, QUARTER_SK INT
, DAY_OF_WEEK_SORT_NAME VARCHAR(60)
, YEAR_SORT_NUMBER VARCHAR(4)
, PUBLIC_HOLIDAY VARCHAR(27)
, SEASON VARCHAR(6)
, PRIMARY KEY (DATE_SK)
)
;CREATE INDEX idx_dim_day_lookup ON dim_day(DATE_SK)
;

CREATE TABLE dim_treasuretype
(
  id BIGINT PRIMARY KEY IDENTITY(0,1)
, version INT
, date_from DATETIME
, date_to DATETIME
, treasure_id VARBINARY(255) UNIQUE
, difficulty INT
, terrain INT
, "size" INT
)
;

CREATE TABLE dim_user
(
  id BIGINT PRIMARY KEY IDENTITY(0,1)
, version INT
, date_from DATETIME
, date_to DATETIME
, log_time DATETIME2(7)
, first_name VARCHAR(255)
, last_name VARCHAR(255)
, street VARCHAR(255)
, ci_name VARCHAR(255)
, co_name VARCHAR(255)
, ExperienceLevel VARCHAR(7)
, Dedicator VARCHAR(3)
, user_id VARBINARY(255)
)
;CREATE INDEX idx_dim_user_lookup ON dim_user(log_time)
;
CREATE INDEX idx_dim_user_tk ON dim_user(id)
;

CREATE TABLE dim_rain
(
  weather_id INT
, description VARCHAR(31)
, PRIMARY KEY (weather_id)
)
;CREATE INDEX idx_dim_rain_lookup ON dim_rain(weather_id, description)
;

CREATE TABLE dbo.dim_weather
(
  id BIGINT PRIMARY KEY IDENTITY(0,1)
, version INT
, date_from DATETIME
, date_to DATETIME
, city VARCHAR(100)
, weather INT
, "timestamp" DATETIME
, city_id VARBINARY(255)
)
;

CREATE TABLE fact_treasurefound
(
  log_id VARBINARY(255)
, log_date INT
, treasure_id VARBINARY(255)
, hunter_id VARBINARY(255)
, "standaard meetwaarde" INT
, duur INT
, creation_date DATETIME
, city_id VARBINARY(255)
, weather INT
, fk_dim_user BIGINT
, fk_dim_treasuretype BIGINT
, FOREIGN KEY (log_date) REFERENCES dim_day(date_sk)
, FOREIGN KEY (weather) REFERENCES dim_rain(weather_id)
, FOREIGN KEY (fk_dim_user) REFERENCES dim_user(id)
, FOREIGN KEY (fk_dim_treasuretype) REFERENCES dim_treasuretype(id)
)
;CREATE INDEX idx_fact_treasurefound_lookup ON fact_treasurefound(log_id)
;

