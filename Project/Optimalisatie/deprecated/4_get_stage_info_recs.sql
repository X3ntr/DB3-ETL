use [catchem]
go

SET ANSI_PADDING ON

go

CREATE CLUSTERED INDEX [_dta_index_treasure_stages_c_5_741577680__K1] ON [dbo].[treasure_stages]
(
	[treasure_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_741577680_1_2] ON [dbo].[treasure_stages]([treasure_id], [stages_id])
go

CREATE STATISTICS [_dta_stat_677577452_6_1] ON [dbo].[stage]([sequence_number], [id])
go

