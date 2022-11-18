USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadLog](
	[DownloadID] [int] IDENTITY(1,1) NOT NULL,
	[DownloadDate] [datetime] NOT NULL,
	[DownloadStatus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DownloadSeconds] [smallint] NULL,
	[DownloadGames] [int] NOT NULL,
	[Player] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Site] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TimeControl] [varchar](14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Color] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[OutPath] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_DownloadLog] PRIMARY KEY CLUSTERED 
(
	[DownloadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  CONSTRAINT [DF_DownloadLog_DownloadDate]  DEFAULT (getdate()) FOR [DownloadDate]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  CONSTRAINT [DF_DownloadLog_DownloadStatus]  DEFAULT ('Incomplete') FOR [DownloadStatus]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  CONSTRAINT [DF_DownloadLog_DownloadGames]  DEFAULT ((0)) FOR [DownloadGames]
GO
