USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lake].[Moves](
	[GameID] [int] NOT NULL,
	[MoveNumber] [smallint] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[IsTheory] [bit] NOT NULL,
	[IsTablebase] [bit] NOT NULL,
	[EngineID] [tinyint] NOT NULL,
	[Depth] [tinyint] NOT NULL,
	[Clock] [int] NULL,
	[TimeSpent] [int] NULL,
	[FEN] [varchar](92) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PhaseID] [tinyint] NOT NULL,
	[Move] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Move_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Move_Rank] [tinyint] NOT NULL,
	[T1_Eval_POV]  AS (case when [T1_Eval] like '#%' then NULL else CONVERT([decimal](5,2),[T1_Eval])*isnull(nullif(CONVERT([smallint],[ColorID]),(2)),(-1)) end) PERSISTED,
	[Move_Eval_POV]  AS (case when [Move_Eval] like '#%' then NULL else CONVERT([decimal](5,2),[Move_Eval])*isnull(nullif(CONVERT([smallint],[ColorID]),(2)),(-1)) end) PERSISTED,
	[CP_Loss] [decimal](5, 2) NULL,
	[T1] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[T1_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[T2] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T2_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T3] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T3_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T4] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T4_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T5] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T5_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T6] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T6_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T7] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T7_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T8] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T8_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T9] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T9_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T10] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T10_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T11] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T11_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T12] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T12_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T13] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T13_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T14] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T14_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T15] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T15_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T16] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T16_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T17] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T17_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T18] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T18_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T19] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T19_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T20] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T20_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T21] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T21_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T22] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T22_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T23] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T23_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T24] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T24_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T25] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T25_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T26] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T26_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T27] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T27_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T28] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T28_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T29] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T29_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T30] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T30_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T31] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T31_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T32] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T32_Eval] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ScACPL]  AS (case when [CP_Loss] IS NULL OR left([T1_Eval],(1))='#' then NULL else CONVERT([decimal](5,2),[CP_Loss])/((1)+abs(CONVERT([decimal](5,2),[T1_Eval]))) end) PERSISTED,
	[MoveScored] [bit] NOT NULL,
	[TraceKey] [char](1) COLLATE Latin1_General_CS_AS NULL,
	[MovesAnalyzed] [tinyint] NULL,
 CONSTRAINT [PK_LMoves] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC,
	[MoveNumber] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_ColorID] ON [lake].[Moves]
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_CPLoss] ON [lake].[Moves]
(
	[CP_Loss] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_EngineID] ON [lake].[Moves]
(
	[EngineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_Evals] ON [lake].[Moves]
(
	[T1_Eval_POV] ASC,
	[Move_Eval_POV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_GameID] ON [lake].[Moves]
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_IsTT] ON [lake].[Moves]
(
	[IsTheory] ASC,
	[IsTablebase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_MoveScored] ON [lake].[Moves]
(
	[MoveScored] ASC
)
INCLUDE ( 	[Move_Rank],
	[CP_Loss],
	[ScACPL]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_PhaseID] ON [lake].[Moves]
(
	[PhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_LMoves_TraceKey] ON [lake].[Moves]
(
	[TraceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [lake].[Moves] ADD  CONSTRAINT [DF_LMoves_MoveScored]  DEFAULT ((0)) FOR [MoveScored]
GO
ALTER TABLE [lake].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_LMoves_ColorID] FOREIGN KEY([ColorID])
REFERENCES [dim].[Colors] ([ColorID])
GO
ALTER TABLE [lake].[Moves] CHECK CONSTRAINT [FK_LMoves_ColorID]
GO
ALTER TABLE [lake].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_LMoves_EngineID] FOREIGN KEY([EngineID])
REFERENCES [dim].[Engines] ([EngineID])
GO
ALTER TABLE [lake].[Moves] CHECK CONSTRAINT [FK_LMoves_EngineID]
GO
ALTER TABLE [lake].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_LMoves_GameID] FOREIGN KEY([GameID])
REFERENCES [lake].[Games] ([GameID])
ON DELETE CASCADE
GO
ALTER TABLE [lake].[Moves] CHECK CONSTRAINT [FK_LMoves_GameID]
GO
ALTER TABLE [lake].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_LMoves_PhaseID] FOREIGN KEY([PhaseID])
REFERENCES [dim].[Phases] ([PhaseID])
GO
ALTER TABLE [lake].[Moves] CHECK CONSTRAINT [FK_LMoves_PhaseID]
GO
ALTER TABLE [lake].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_LMoves_Traces] FOREIGN KEY([TraceKey])
REFERENCES [dim].[Traces] ([TraceKey])
GO
ALTER TABLE [lake].[Moves] CHECK CONSTRAINT [FK_LMoves_Traces]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [lake].[trg_InsertMoveScores] ON [lake].[Moves]

AFTER INSERT

AS

INSERT INTO stat.MoveScores (
	ScoreID,
	GameID,
	MoveNumber,
	ColorID
)

SELECT
sc.ScoreID,
i.GameID,
i.MoveNumber,
i.ColorID

FROM inserted i
CROSS JOIN dim.Scores sc
WHERE sc.ScoreActive = 1
GO
ALTER TABLE [lake].[Moves] ENABLE TRIGGER [trg_InsertMoveScores]
GO
