SELECT t.id "treasure_id", difficulty, terrain, (SELECT COUNT(*)
							FROM (SELECT ts.treasure_id
									FROM treasure_stages ts
									WHERE ts.treasure_id = t.id) AS size) AS size
FROM treasure t
JOIN treasure_log tl ON tl.treasure_id = t.id
WHERE tl.log_type = 2