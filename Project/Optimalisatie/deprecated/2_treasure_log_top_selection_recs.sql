use [catchem]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_log_5_789577851__K7_K3D_2] ON [dbo].[treasure_log]
(
	[treasure_id] ASC,
	[log_time] DESC
)
INCLUDE ( 	[description]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_789577851_3_7] ON [dbo].[treasure_log]([log_time], [treasure_id])
go

