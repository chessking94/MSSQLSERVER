USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Players](
	[SourceID] [tinyint] NOT NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FirstName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PlayerID] [int] NULL
) ON [PRIMARY]
GO
