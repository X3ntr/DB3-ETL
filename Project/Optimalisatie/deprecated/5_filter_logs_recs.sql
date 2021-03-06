use [catchem]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_log_5_789577851__K3_1_2_4_5_6_7] ON [dbo].[treasure_log]
(
	[log_time] ASC
)
INCLUDE ( 	[id],
	[description],
	[log_type],
	[session_start],
	[hunter_id],
	[treasure_id]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

