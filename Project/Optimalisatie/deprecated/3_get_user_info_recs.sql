use [catchem]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_5_709577566__K5] ON [dbo].[treasure]
(
	[owner_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_709577566_1_5] ON [dbo].[treasure]([id], [owner_id])
go

