USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Events](
	[SourceID] [tinyint] NOT NULL,
	[EventName] [varchar](100) NOT NULL,
	[EventID] [int] NULL
) ON [PRIMARY]
GO
