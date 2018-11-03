SELECT TOP 1000 u.id 'user_id', u.first_name, u.last_name, u.street, c.ci_name, co.co_name, tl.log_time, "ExperienceLevel" = CASE 
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) = NULL THEN 'Newbie'
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) > 0 AND (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) <= 3 THEN 'Amature'
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) > 3 AND (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) <= 10 THEN 'Regular'
																		ELSE 'Expert' END
												, "Dedicator" = CASE
																	WHEN hunter_id IN (SELECT owner_id
																					   FROM treasure) THEN 'Yes'
																	ELSE 'No'
																END
												
FROM treasure_log tl
JOIN user_table u ON u.id = tl.hunter_id
JOIN Cities c ON c.city_id = u.city_city_id
JOIN Countries co ON co.lc = c.country_id
WHERE log_type = 2