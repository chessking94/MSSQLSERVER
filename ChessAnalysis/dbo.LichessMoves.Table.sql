﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichessMoves](
	[MoveID] [int] IDENTITY(1,1) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[GameID] [varchar](20) NOT NULL,
	[MoveNumber] [smallint] NOT NULL,
	[Color] [char](5) NOT NULL,
	[IsTheory] [tinyint] NOT NULL,
	[IsTablebase] [tinyint] NOT NULL,
	[FEN] [varchar](92) NOT NULL,
	[PhaseID] [tinyint] NOT NULL,
	[Move] [varchar](10) NOT NULL,
	[T1] [varchar](10) NOT NULL,
	[T2] [varchar](10) NULL,
	[T3] [varchar](10) NULL,
	[T4] [varchar](10) NULL,
	[T5] [varchar](10) NULL,
	[Move_Eval] [varchar](7) NOT NULL,
	[T1_Eval] [varchar](7) NOT NULL,
	[T2_Eval] [varchar](7) NULL,
	[T3_Eval] [varchar](7) NULL,
	[T4_Eval] [varchar](7) NULL,
	[T5_Eval] [varchar](7) NULL,
	[CP_Loss] [decimal](5, 2) NULL,
	[Move_Rank] [tinyint] NULL,
	[Engine] [varchar](25) NULL,
	[Depth] [tinyint] NULL,
	[Clock] [int] NULL,
	[PGN_Eval] [varchar](7) NULL,
	[TimeSpent] [int] NULL,
 CONSTRAINT [PK_LM_MoveID] PRIMARY KEY CLUSTERED 
(
	[MoveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LM_Clock] ON [dbo].[LichessMoves]
(
	[Clock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LM_CPLoss] ON [dbo].[LichessMoves]
(
	[CP_Loss] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_LM_GameID] ON [dbo].[LichessMoves]
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_LM_MoveEval] ON [dbo].[LichessMoves]
(
	[Move_Eval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LM_MoveRank] ON [dbo].[LichessMoves]
(
	[Move_Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LM_PhaseID] ON [dbo].[LichessMoves]
(
	[PhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_LM_T1Eval] ON [dbo].[LichessMoves]
(
	[T1_Eval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LM_TimeSpent] ON [dbo].[LichessMoves]
(
	[TimeSpent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LichessMoves] ADD  CONSTRAINT [CNSTRNT_LM_DateAdded]  DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[LichessMoves]  WITH CHECK ADD  CONSTRAINT [FK_LM_GameID] FOREIGN KEY([GameID])
REFERENCES [dbo].[LichessGames] ([GameID])
GO
ALTER TABLE [dbo].[LichessMoves] CHECK CONSTRAINT [FK_LM_GameID]
GO
