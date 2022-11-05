USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Players](
	[SourceID] [tinyint] NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[FirstName] [varchar](30) NULL,
	[PlayerID] [int] NULL
) ON [PRIMARY]
GO
