﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lake].[Games](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[SourceID] [tinyint] NOT NULL,
	[SiteID] [tinyint] NULL,
	[SiteGameID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[WhitePlayerID] [int] NOT NULL,
	[BlackPlayerID] [int] NOT NULL,
	[WhiteElo] [smallint] NULL,
	[BlackElo] [smallint] NULL,
	[TimeControlDetailID] [smallint] NOT NULL,
	[ECOID] [smallint] NOT NULL,
	[GameDate] [date] NOT NULL,
	[GameTime] [time](0) NULL,
	[EventID] [int] NOT NULL,
	[RoundNum] [tinyint] NULL,
	[Result] [decimal](2, 1) NOT NULL,
	[FileID] [int] NULL,
 CONSTRAINT [PK_LGames] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_LGames_SiteGameID] UNIQUE NONCLUSTERED 
(
	[SourceID] ASC,
	[SiteID] ASC,
	[SiteGameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LGames_BlackPlayerID] ON [lake].[Games]
(
	[BlackPlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LGames_EventID] ON [lake].[Games]
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LGames_SourceID] ON [lake].[Games]
(
	[SourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LGames_TimeControlDetailID] ON [lake].[Games]
(
	[TimeControlDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LGames_WhitePlayerID] ON [lake].[Games]
(
	[WhitePlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [lake].[Games] ADD  CONSTRAINT [DF_LGames_DateAdded]  DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_BlackPlayerID] FOREIGN KEY([BlackPlayerID])
REFERENCES [dim].[Players] ([PlayerID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_BlackPlayerID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_ECOID] FOREIGN KEY([ECOID])
REFERENCES [dim].[ECO] ([ECOID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_ECOID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_EventID] FOREIGN KEY([EventID])
REFERENCES [dim].[Events] ([EventID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_EventID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_FileID] FOREIGN KEY([FileID])
REFERENCES [dbo].[FileHistory] ([FileID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_FileID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_SiteID] FOREIGN KEY([SiteID])
REFERENCES [dim].[Sites] ([SiteID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_SiteID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_SourceID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_TimeControlDetailID] FOREIGN KEY([TimeControlDetailID])
REFERENCES [dim].[TimeControlDetail] ([TimeControlDetailID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_TimeControlDetailID]
GO
ALTER TABLE [lake].[Games]  WITH CHECK ADD  CONSTRAINT [FK_LGames_WhitePlayerID] FOREIGN KEY([WhitePlayerID])
REFERENCES [dim].[Players] ([PlayerID])
GO
ALTER TABLE [lake].[Games] CHECK CONSTRAINT [FK_LGames_WhitePlayerID]
GO
