﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[BulkInsertGameData](
	[RecordKey] [varchar](3) NOT NULL,
	[Field1] [varchar](15) NULL,
	[Field2] [varchar](26) NULL,
	[Field3] [varchar](15) NULL,
	[Field4] [varchar](50) NULL,
	[Field5] [varchar](30) NULL,
	[Field6] [varchar](50) NULL,
	[Field7] [varchar](30) NULL,
	[Field8] [varchar](8) NULL,
	[Field9] [varchar](8) NULL,
	[Field10] [varchar](92) NULL,
	[Field11] [varchar](3) NULL,
	[Field12] [varchar](10) NULL,
	[Field13] [varchar](8) NULL,
	[Field14] [varchar](100) NULL,
	[Field15] [varchar](8) NULL,
	[Field16] [varchar](8) NULL,
	[Field17] [varchar](8) NULL,
	[Field18] [varchar](8) NULL,
	[Field19] [varchar](8) NULL,
	[Field20] [varchar](8) NULL,
	[Field21] [varchar](8) NULL,
	[Field22] [varchar](8) NULL,
	[Field23] [varchar](8) NULL,
	[Field24] [varchar](8) NULL,
	[Field25] [varchar](8) NULL,
	[Field26] [varchar](8) NULL,
	[Field27] [varchar](8) NULL,
	[Field28] [varchar](8) NULL,
	[Field29] [varchar](8) NULL,
	[Field30] [varchar](8) NULL,
	[Field31] [varchar](8) NULL,
	[Field32] [varchar](8) NULL,
	[Field33] [varchar](8) NULL,
	[Field34] [varchar](8) NULL,
	[Field35] [varchar](8) NULL,
	[Field36] [varchar](8) NULL,
	[Field37] [varchar](8) NULL,
	[Field38] [varchar](8) NULL,
	[Field39] [varchar](8) NULL,
	[Field40] [varchar](8) NULL,
	[Field41] [varchar](8) NULL,
	[Field42] [varchar](8) NULL,
	[Field43] [varchar](8) NULL,
	[Field44] [varchar](8) NULL,
	[Field45] [varchar](8) NULL,
	[Field46] [varchar](8) NULL,
	[Field47] [varchar](8) NULL,
	[Field48] [varchar](8) NULL,
	[Field49] [varchar](8) NULL,
	[Field50] [varchar](8) NULL,
	[Field51] [varchar](8) NULL,
	[Field52] [varchar](8) NULL,
	[Field53] [varchar](8) NULL,
	[Field54] [varchar](8) NULL,
	[Field55] [varchar](8) NULL,
	[Field56] [varchar](8) NULL,
	[Field57] [varchar](8) NULL,
	[Field58] [varchar](8) NULL,
	[Field59] [varchar](8) NULL,
	[Field60] [varchar](8) NULL,
	[Field61] [varchar](8) NULL,
	[Field62] [varchar](8) NULL,
	[Field63] [varchar](8) NULL,
	[Field64] [varchar](8) NULL,
	[Field65] [varchar](8) NULL,
	[Field66] [varchar](8) NULL,
	[Field67] [varchar](8) NULL,
	[Field68] [varchar](8) NULL,
	[Field69] [varchar](8) NULL,
	[Field70] [varchar](8) NULL,
	[Field71] [varchar](8) NULL,
	[Field72] [varchar](8) NULL,
	[Field73] [varchar](8) NULL,
	[Field74] [varchar](8) NULL,
	[Field75] [varchar](8) NULL,
	[Field76] [varchar](8) NULL,
	[Field77] [varchar](8) NULL,
	[Field78] [varchar](8) NULL,
	[Field79] [varchar](8) NULL
) ON [PRIMARY]
GO
ALTER TABLE [stage].[BulkInsertGameData]  WITH NOCHECK ADD  CONSTRAINT [FK_BulkInsertGameData_RecordKey] FOREIGN KEY([RecordKey])
REFERENCES [doc].[Records] ([RecordKey])
GO
ALTER TABLE [stage].[BulkInsertGameData] CHECK CONSTRAINT [FK_BulkInsertGameData_RecordKey]
GO
