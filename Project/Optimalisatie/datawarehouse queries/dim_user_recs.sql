use [catchem]
go

CREATE PARTITION FUNCTION [_dta_pf__9987](int) AS RANGE LEFT FOR VALUES (2)
go

CREATE PARTITION SCHEME [_dta_ps__4364] AS PARTITION [_dta_pf__9987] TO ([PRIMARY], [PRIMARY])
go

SET ANSI_PADDING ON
go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_log_5_789577851_0_K6_K4_1_3] ON [dbo].[treasure_log]
(
	[hunter_id] ASC,
	[log_type] ASC
)
INCLUDE ( 	[id],
	[log_time]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [_dta_ps__4364]([log_type])
go

CREATE STATISTICS [_dta_stat_821577965_7_1] ON [dbo].[user_table]([city_city_id], [id])
go

CREATE STATISTICS [_dta_stat_1570104634_2_6] ON [dbo].[Cities]([city_id], [country_id])
go

