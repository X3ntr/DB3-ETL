use [catchem]
go
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
go

CREATE VIEW [dbo].[_dta_mv_10] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[treasure_stages].[treasure_id] as _col_1,  count_big(*) as _col_2 FROM  [dbo].[treasure_stages]  GROUP BY  [dbo].[treasure_stages].[treasure_id]  

go

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_10_c_5_46623209__K1] ON [dbo].[_dta_mv_10]
(
	[_col_1] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_log_5_789577851__K4_7] ON [dbo].[treasure_log]
(
	[log_type] ASC
)
INCLUDE ( 	[treasure_id]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_789577851_4_7] ON [dbo].[treasure_log]([log_type], [treasure_id])
go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_5_709577566__K1_2_3] ON [dbo].[treasure]
(
	[id] ASC
)
INCLUDE ( 	[difficulty],
	[terrain]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

