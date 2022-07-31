USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadLog](
	[DownloadID] [int] IDENTITY(1,1) NOT NULL,
	[DownloadDate] [datetime] NOT NULL,
	[DownloadStatus] [varchar](10) NOT NULL,
	[DownloadSeconds] [smallint] NULL,
	[DownloadGames] [int] NOT NULL,
	[Player] [varchar](50) NULL,
	[Site] [varchar](9) NULL,
	[TimeControl] [varchar](14) NULL,
	[Color] [varchar](5) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[OutPath] [varchar](75) NULL,
 CONSTRAINT [IDX_DLL_DownloadID] PRIMARY KEY CLUSTERED 
(
	[DownloadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  DEFAULT (getdate()) FOR [DownloadDate]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  DEFAULT ('Incomplete') FOR [DownloadStatus]
GO
ALTER TABLE [dbo].[DownloadLog] ADD  DEFAULT ((0)) FOR [DownloadGames]
GO
