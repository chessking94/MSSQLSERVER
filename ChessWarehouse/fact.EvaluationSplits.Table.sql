USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[EvaluationSplits](
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[EvaluationGroupID_T1] [tinyint] NOT NULL,
	[EvaluationGroupID_T2] [tinyint] NOT NULL,
	[EvaluationGroupID_T3] [tinyint] NOT NULL,
	[EvaluationGroupID_T4] [tinyint] NOT NULL,
	[EvaluationGroupID_T5] [tinyint] NOT NULL,
	[CalculationDate] [datetime] NOT NULL,
	[MovesAnalyzed] [int] NOT NULL,
	[ACPL] [decimal](9, 6) NULL,
	[SDCPL] [decimal](9, 6) NULL,
	[ScACPL] [decimal](9, 6) NULL,
	[ScSDCPL] [decimal](9, 6) NULL,
	[T1] [decimal](7, 6) NULL,
	[T2] [decimal](7, 6) NULL,
	[T3] [decimal](7, 6) NULL,
	[T4] [decimal](7, 6) NULL,
	[T5] [decimal](7, 6) NULL,
 CONSTRAINT [PK_EvaluationSplits] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[TimeControlID] ASC,
	[RatingID] ASC,
	[EvaluationGroupID_T1] ASC,
	[EvaluationGroupID_T2] ASC,
	[EvaluationGroupID_T3] ASC,
	[EvaluationGroupID_T4] ASC,
	[EvaluationGroupID_T5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[EvaluationSplits] ADD  CONSTRAINT [DF_EvaluationSplits_CalculationDate]  DEFAULT (getdate()) FOR [CalculationDate]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT1] FOREIGN KEY([EvaluationGroupID_T1])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT1]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT2] FOREIGN KEY([EvaluationGroupID_T2])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT2]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT3] FOREIGN KEY([EvaluationGroupID_T3])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT3]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT4] FOREIGN KEY([EvaluationGroupID_T4])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT4]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT5] FOREIGN KEY([EvaluationGroupID_T5])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_EvaluationGroupIDT5]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_RatingID]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_SourceID]
GO
ALTER TABLE [fact].[EvaluationSplits]  WITH CHECK ADD  CONSTRAINT [FK_EvaluationSplits_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [fact].[EvaluationSplits] CHECK CONSTRAINT [FK_EvaluationSplits_TimeControlID]
GO
