use [catchem]
go

SET QUOTED_IDENTIFIER ON
go

SET ARITHABORT ON
go

SET CONCAT_NULL_YIELDS_NULL ON
go

SET ANSI_NULLS ON
go

SET ANSI_PADDING ON
go

SET ANSI_WARNINGS ON
go

SET NUMERIC_ROUNDABORT OFF
go

CREATE VIEW [dbo].[_dta_mv_5] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[treasure].[difficulty] as _col_1,  [dbo].[treasure].[terrain] as _col_2,  [dbo].[Cities].[ci_name] as _col_3,  [dbo].[treasure].[id] as _col_4,  [dbo].[treasure].[city_city_id] as _col_5,  [dbo].[treasure].[owner_id] as _col_6,  [dbo].[Cities].[city_id] as _col_7,  [dbo].[Cities].[post] as _col_8,  [dbo].[Cities].[lat] as _col_9,  [dbo].[Cities].[long] as _col_10,  [dbo].[Cities].[country_id] as _col_11 FROM  [dbo].[treasure],  [dbo].[Cities]   WHERE  [dbo].[treasure].[city_city_id] = [dbo].[Cities].[city_id]  

go

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

go

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_5_c_5_1762105318__K1_K2_K3_K4] ON [dbo].[_dta_mv_5]
(
	[_col_1] ASC,
	[_col_2] ASC,
	[_col_3] ASC,
	[_col_4] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_stages_5_741577680__K1] ON [dbo].[treasure_stages]
(
	[treasure_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_1570104634_2_1] ON [dbo].[Cities]([city_id], [ci_name])
go

CREATE STATISTICS [_dta_stat_709577566_4_2] ON [dbo].[treasure]([city_city_id], [difficulty])
go

CREATE STATISTICS [_dta_stat_709577566_3_1] ON [dbo].[treasure]([terrain], [id])
go

CREATE STATISTICS [_dta_stat_709577566_2_3_4] ON [dbo].[treasure]([difficulty], [terrain], [city_city_id])
go

CREATE STATISTICS [_dta_stat_709577566_1_4_2] ON [dbo].[treasure]([id], [city_city_id], [difficulty])
go

CREATE STATISTICS [_dta_stat_709577566_1_2_3_4] ON [dbo].[treasure]([id], [difficulty], [terrain], [city_city_id])
go

