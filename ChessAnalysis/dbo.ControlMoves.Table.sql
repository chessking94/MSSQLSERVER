USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ControlMoves](
	[MoveID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[MoveNumber] [int] NOT NULL,
	[Color] [varchar](5) NOT NULL,
	[IsTheory] [tinyint] NULL,
	[IsTablebase] [tinyint] NULL,
	[Move] [varchar](10) NOT NULL,
	[T1] [varchar](10) NULL,
	[T2] [varchar](10) NULL,
	[T3] [varchar](10) NULL,
	[T4] [varchar](10) NULL,
	[T5] [varchar](10) NULL,
	[T6] [varchar](10) NULL,
	[T7] [varchar](10) NULL,
	[T8] [varchar](10) NULL,
	[T9] [varchar](10) NULL,
	[T10] [varchar](10) NULL,
	[T11] [varchar](10) NULL,
	[T12] [varchar](10) NULL,
	[T13] [varchar](10) NULL,
	[T14] [varchar](10) NULL,
	[T15] [varchar](10) NULL,
	[T16] [varchar](10) NULL,
	[T17] [varchar](10) NULL,
	[T18] [varchar](10) NULL,
	[T19] [varchar](10) NULL,
	[T20] [varchar](10) NULL,
	[T21] [varchar](10) NULL,
	[T22] [varchar](10) NULL,
	[T23] [varchar](10) NULL,
	[T24] [varchar](10) NULL,
	[T25] [varchar](10) NULL,
	[T26] [varchar](10) NULL,
	[T27] [varchar](10) NULL,
	[T28] [varchar](10) NULL,
	[T29] [varchar](10) NULL,
	[T30] [varchar](10) NULL,
	[T31] [varchar](10) NULL,
	[T32] [varchar](10) NULL,
	[Move_Eval] [varchar](6) NULL,
	[T1_Eval] [varchar](6) NULL,
	[T2_Eval] [varchar](6) NULL,
	[T3_Eval] [varchar](6) NULL,
	[T4_Eval] [varchar](6) NULL,
	[T5_Eval] [varchar](6) NULL,
	[T6_Eval] [varchar](6) NULL,
	[T7_Eval] [varchar](6) NULL,
	[T8_Eval] [varchar](6) NULL,
	[T9_Eval] [varchar](6) NULL,
	[T10_Eval] [varchar](6) NULL,
	[T11_Eval] [varchar](6) NULL,
	[T12_Eval] [varchar](6) NULL,
	[T13_Eval] [varchar](6) NULL,
	[T14_Eval] [varchar](6) NULL,
	[T15_Eval] [varchar](6) NULL,
	[T16_Eval] [varchar](6) NULL,
	[T17_Eval] [varchar](6) NULL,
	[T18_Eval] [varchar](6) NULL,
	[T19_Eval] [varchar](6) NULL,
	[T20_Eval] [varchar](6) NULL,
	[T21_Eval] [varchar](6) NULL,
	[T22_Eval] [varchar](6) NULL,
	[T23_Eval] [varchar](6) NULL,
	[T24_Eval] [varchar](6) NULL,
	[T25_Eval] [varchar](6) NULL,
	[T26_Eval] [varchar](6) NULL,
	[T27_Eval] [varchar](6) NULL,
	[T28_Eval] [varchar](6) NULL,
	[T29_Eval] [varchar](6) NULL,
	[T30_Eval] [varchar](6) NULL,
	[T31_Eval] [varchar](6) NULL,
	[T32_Eval] [varchar](6) NULL,
	[CP_Loss] [varchar](6) NULL,
	[Engine] [varchar](25) NULL,
	[Depth] [varchar](6) NULL,
	[AnalysisTime] [decimal](7, 4) NULL,
	[FEN] [varchar](92) NULL,
	[DateAdded] [datetime] NULL,
	[TotalMoves] [int] NULL,
	[CandidateMoves] [int] NULL,
	[AvgCandidateError] [decimal](6, 4) NULL,
	[StDevCandidate] [decimal](6, 4) NULL,
	[PcntCandidatesWithin10CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin20CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin30CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin40CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin50CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin60CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin70CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin80CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin90CP] [decimal](6, 4) NULL,
	[PcntCandidatesWithin100CP] [decimal](6, 4) NULL,
	[Move_Rank] [int] NULL,
	[MaterialWhite] [int] NULL,
	[MaterialBlack] [int] NULL,
	[TotalPieceCount] [int] NULL,
	[PhaseID]  AS (case when [MoveNumber]<=(10) then (1) when [TotalPieceCount]<=(18) then (3) else (2) end) PERSISTED NOT NULL,
 CONSTRAINT [PK_CM_MoveID] PRIMARY KEY CLUSTERED 
(
	[MoveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_CM_GameID] ON [dbo].[ControlMoves]
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_CM_MoveEval] ON [dbo].[ControlMoves]
(
	[Move_Eval] ASC
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
CREATE NONCLUSTERED INDEX [IDX_CM_PhaseID] ON [dbo].[ControlMoves]
(
	[PhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_CM_T1Eval] ON [dbo].[ControlMoves]
(
	[T1_Eval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ControlMoves] ADD  CONSTRAINT [CSR_CM_DateAdded]  DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[ControlMoves]  WITH CHECK ADD  CONSTRAINT [FK_CM_GameID] FOREIGN KEY([GameID])
REFERENCES [dbo].[ControlGames] ([GameID])
GO
ALTER TABLE [dbo].[ControlMoves] CHECK CONSTRAINT [FK_CM_GameID]
GO
ALTER TABLE [dbo].[ControlMoves]  WITH CHECK ADD  CONSTRAINT [FK_CM_PhaseID] FOREIGN KEY([PhaseID])
REFERENCES [dbo].[GamePhases] ([PhaseID])
GO
ALTER TABLE [dbo].[ControlMoves] CHECK CONSTRAINT [FK_CM_PhaseID]
GO
