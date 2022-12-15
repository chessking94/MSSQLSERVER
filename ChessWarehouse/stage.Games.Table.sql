USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Games](
	[Errors] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SourceName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SiteName] [varchar](26) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SiteGameID] [varchar](15) COLLATE Latin1_General_CS_AS NULL,
	[WhiteLast] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WhiteFirst] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WhitePlayerID] [int] NULL,
	[BlackLast] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlackFirst] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlackPlayerID] [int] NULL,
	[WhiteElo] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlackElo] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TimeControlDetail] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ECO_Code] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GameDate] [date] NULL,
	[GameTime] [time](0) NULL,
	[EventName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RoundNum] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Result] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileID] [int] NULL
) ON [PRIMARY]
GO
