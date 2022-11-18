﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsernameXRef](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Username] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Source] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EEHFlag] [bit] NULL,
	[DownloadFlag] [bit] NULL,
	[LastActiveOnline] [datetime] NULL,
	[UserStatus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BulletRating] [int] NULL,
	[BlitzRating] [int] NULL,
	[RapidRating] [int] NULL,
	[DailyRating] [int] NULL,
	[BulletGames] [int] NULL,
	[BlitzGames] [int] NULL,
	[RapidGames] [int] NULL,
	[DailyGames] [int] NULL,
	[Note] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalGames]  AS (((isnull([BulletGames],(0))+isnull([BlitzGames],(0)))+isnull([RapidGames],(0)))+isnull([DailyGames],(0))),
 CONSTRAINT [PK_UsernameXRef] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_UsernameXRef_SourceDownload] ON [dbo].[UsernameXRef]
(
	[Source] ASC,
	[DownloadFlag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsernameXRef]  WITH CHECK ADD  CONSTRAINT [CK_UsernameXRef_UserStatus] CHECK  (([UserStatus]='DNE' OR [UserStatus]='Closed' OR [UserStatus]='Open'))
GO
ALTER TABLE [dbo].[UsernameXRef] CHECK CONSTRAINT [CK_UsernameXRef_UserStatus]
GO
