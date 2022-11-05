USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Games](
	[Errors] [varchar](100) NULL,
	[SourceName] [varchar](15) NULL,
	[SiteName] [varchar](26) NULL,
	[SiteGameID] [varchar](15) NULL,
	[WhiteLast] [varchar](50) NULL,
	[WhiteFirst] [varchar](30) NULL,
	[WhitePlayerID] [int] NULL,
	[BlackLast] [varchar](50) NULL,
	[BlackFirst] [varchar](30) NULL,
	[BlackPlayerID] [int] NULL,
	[WhiteElo] [varchar](4) NULL,
	[BlackElo] [varchar](4) NULL,
	[TimeControlDetail] [varchar](15) NULL,
	[ECO_Code] [char](3) NULL,
	[GameDate] [date] NULL,
	[GameTime] [time](0) NULL,
	[EventName] [varchar](100) NULL,
	[RoundNum] [varchar](7) NULL,
	[Result] [char](3) NULL,
	[FileID] [int] NULL
) ON [PRIMARY]
GO
