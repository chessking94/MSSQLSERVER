USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Events](
	[SourceID] [tinyint] NOT NULL,
	[EventName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EventID] [int] NULL
) ON [PRIMARY]
GO
