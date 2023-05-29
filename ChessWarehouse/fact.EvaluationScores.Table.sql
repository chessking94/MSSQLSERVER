USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[EvaluationScores](
	[SourceID] [tinyint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[ScoreID] [tinyint] NOT NULL,
	[Score] [decimal](7, 4) NULL,
	[Score_Z] [decimal](9, 6) NULL,
 CONSTRAINT [PK_EvaluationScores] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[EvaluationGroupID] ASC,
	[TimeControlID] ASC,
	[RatingID] ASC,
	[ScoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[EvaluationScores]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationScores_FactEvaluation] FOREIGN KEY([SourceID], [EvaluationGroupID], [TimeControlID], [RatingID])
REFERENCES [fact].[Evaluation] ([SourceID], [EvaluationGroupID], [TimeControlID], [RatingID])
ON DELETE CASCADE
GO
ALTER TABLE [fact].[EvaluationScores] CHECK CONSTRAINT [FK_EvaluationScores_FactEvaluation]
GO
ALTER TABLE [fact].[EvaluationScores]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationScores_ScoreID] FOREIGN KEY([ScoreID])
REFERENCES [dim].[Scores] ([ScoreID])
GO
ALTER TABLE [fact].[EvaluationScores] CHECK CONSTRAINT [FK_EvaluationScores_ScoreID]
GO
