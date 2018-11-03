/*Welke rol hebben datumparameters (dagen, weken, maanden, seizoen) op het aantal caches?*/
SELECT dd.day_name, "aantal caches dag" = (SELECT COUNT(*)
									FROM fact_treasurefound tf2
									JOIN dim_day d ON tf2.log_date = d.DATE_SK
									WHERE d.DAY_NAME = dd.DAY_NAME)
, dd.WEEK_NAME, "aantal caches week" = (SELECT COUNT(*)
										FROM fact_treasurefound tf2
										JOIN dim_day d ON tf2.log_date = d.DATE_SK
										WHERE d.WEEK_NAME = dd.WEEK_NAME)
, dd.MONTH_NAME, "aantal caches month" = (SELECT COUNT(*)
										  FROM fact_treasurefound tf2
										  JOIN dim_day d ON tf2.log_date = d.DATE_SK
										  WHERE d.MONTH_NAME = dd.MONTH_NAME)
, dd.SEASON, "aantal caches season" = (SELECT COUNT(*)
									   FROM fact_treasurefound tf2
									   JOIN dim_day d ON tf2.log_date = d.DATE_SK
									   WHERE d.SEASON = dd.SEASON)
FROM fact_treasurefound tf1
JOIN dim_day dd ON tf1.log_date = dd.DATE_SK
GROUP BY dd.day_name, dd.WEEK_NAME, dd.MONTH_NAME, dd.SEASON
ORDER BY dd.day_name, dd.week_name, dd.MONTH_NAME, dd.SEASON



/*Wat is de invloed van het type user op de duur van de treasurehunt? Doet een beginner er langer over?*/
SELECT du1.ExperienceLevel, "gemiddelde duur" = (SELECT AVG(duur)
											 FROM fact_treasurefound tf2
											 JOIN dim_user du2 ON tf2.fk_dim_user = du2.id
											 WHERE du2.ExperienceLevel = du1.ExperienceLevel)
FROM fact_treasurefound tf1
JOIN dim_user du1 ON tf1.fk_dim_user = du1.id
GROUP BY du1.ExperienceLevel



/*Vinden users de cache gemiddeld sneller in de regen?*/
SELECT AVG(duur) AS 'gemiddelde duur regen', "gemiddelde duur droog" = (SELECT AVG(duur)
																		FROM fact_treasurefound tf1
																		WHERE tf1.weather = 1)
FROM fact_treasurefound
WHERE weather <> 1 AND weather <> 0



/*Zoeken beginnende users gemiddeld naar grotere caches?*/
SELECT du1.ExperienceLevel, (SELECT AVG(size)
		 FROM fact_treasurefound tf2
 	     JOIN dim_user du2 ON du2.id = tf2.fk_dim_user
		 JOIN dim_treasuretype dt1 ON dt1.id = tf2.fk_dim_treasuretype
		 WHERE du2.ExperienceLevel IN ('Newbie', 'Amature') AND du1.ExperienceLevel IN ('Newbie', 'Amature')) AS 'grootte beginner',

		(SELECT AVG(size)
		 FROM fact_treasurefound tf2
		 JOIN dim_user du2 ON du2.id = tf2.fk_dim_user
		 JOIN dim_treasuretype dt1 ON dt1.id = tf2.fk_dim_treasuretype
		 WHERE du2.ExperienceLevel IN ('Regular', 'Expert') AND du1.ExperienceLevel IN ('Regular', 'Expert')) AS 'grootte gevorderden'
FROM fact_treasurefound ft1
JOIN dim_user du1 ON du1.id = ft1.fk_dim_user
GROUP BY du1.ExperienceLevel




/*Worden er gemiddeld minder caches gezocht op moeilijker terrein als het regent?*/
SELECT weather, "gemiddeld aantal caches op moeilijk terrein" = (SELECT COUNT(*) / 2
																 FROM fact_treasurefound ft2
																 JOIN dim_treasuretype dt ON dt.id = ft2.fk_dim_treasuretype
																 WHERE dt.terrain IN (3,4) AND ft2.weather = ft1.weather)
				,"gemiddeld aantal caches op makkelijk terrein" = (SELECT COUNT(*) /3
																   FROM fact_treasurefound ft2
																   JOIN dim_treasuretype dt ON dt.id = ft2.fk_dim_treasuretype
																   WHERE dt.terrain IN (0,1,2) AND ft2.weather = ft1.weather)
FROM fact_treasurefound ft1
WHERE ft1.weather <> 0
GROUP BY ft1.weather



/*Worden er in weekends meer moeilijkere caches gedaan?*/
SELECT dd.WEEKEND_IND, "aantal moeilijke caches" = (SELECT COUNT(*)
													FROM fact_treasurefound ft2
													JOIN dim_day d ON ft2.log_date = d.DATE_SK
													JOIN dim_treasuretype dt ON dt.id = ft2.fk_dim_treasuretype
													WHERE d.WEEKEND_IND = dd.WEEKEND_IND AND dt.difficulty IN (2,3,4))
FROM fact_treasurefound ft1
JOIN dim_day dd ON ft1.log_date = dd.DATE_SK
GROUP by dd.WEEKEND_IND



/*Worden er in weekends meer moeilijke dan makkelijke caches gedaan?*/
SELECT dd.WEEKEND_IND, "aantal moeilijke caches" = (SELECT COUNT(*)
													FROM fact_treasurefound ft2
													JOIN dim_day d ON ft2.log_date = d.DATE_SK
													JOIN dim_treasuretype dt ON dt.id = ft2.fk_dim_treasuretype
													WHERE d.WEEKEND_IND = dd.WEEKEND_IND AND dt.difficulty IN (2,3,4))
					 , "aantal makkelijke caches" = (SELECT COUNT(*)
													FROM fact_treasurefound ft2
													JOIN dim_day d ON ft2.log_date = d.DATE_SK
													JOIN dim_treasuretype dt ON dt.id = ft2.fk_dim_treasuretype
													WHERE d.WEEKEND_IND = dd.WEEKEND_IND AND dt.difficulty IN (0,1))
FROM fact_treasurefound ft1
JOIN dim_day dd ON ft1.log_date = dd.DATE_SK
WHERE dd.WEEKEND_IND = 'Y'
GROUP BY WEEKEND_IND