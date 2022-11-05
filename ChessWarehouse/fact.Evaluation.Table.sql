USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[Evaluation](
	[SourceID] [tinyint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[CalculationDate] [datetime] NOT NULL,
	[CPL_Moves] [int] NOT NULL,
	[CPL_1] [int] NOT NULL,
	[CPL_2] [int] NOT NULL,
	[CPL_3] [int] NOT NULL,
	[CPL_4] [int] NOT NULL,
	[CPL_5] [int] NOT NULL,
	[CPL_6] [int] NOT NULL,
	[CPL_7] [int] NOT NULL,
	[CPL_8] [int] NOT NULL,
	[MovesAnalzyed] [int] NOT NULL,
	[ACPL] [decimal](9, 6) NULL,
	[SDCPL] [decimal](9, 6) NULL,
	[ScACPL] [decimal](9, 6) NULL,
	[ScSDCPL] [decimal](9, 6) NULL,
	[T1] [decimal](7, 6) NULL,
	[T2] [decimal](7, 6) NULL,
	[T3] [decimal](7, 6) NULL,
	[T4] [decimal](7, 6) NULL,
	[T5] [decimal](7, 6) NULL,
	[Score] [decimal](7, 4) NULL,
	[ACPL_Z] [decimal](9, 6) NULL,
	[SDCPL_Z] [decimal](9, 6) NULL,
	[ScACPL_Z] [decimal](9, 6) NULL,
	[ScSDCPL_Z] [decimal](9, 6) NULL,
	[T1_Z] [decimal](9, 6) NULL,
	[T2_Z] [decimal](9, 6) NULL,
	[T3_Z] [decimal](9, 6) NULL,
	[T4_Z] [decimal](9, 6) NULL,
	[T5_Z] [decimal](9, 6) NULL,
	[Score_Z] [decimal](9, 6) NULL,
 CONSTRAINT [PK_FEvaluation] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[EvaluationGroupID] ASC,
	[TimeControlID] ASC,
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[Evaluation] ADD  CONSTRAINT [DF_FEvaluation_CalculationDate]  DEFAULT (getdate()) FOR [CalculationDate]
GO
ALTER TABLE [fact].[Evaluation]  WITH CHECK ADD  CONSTRAINT [FK_Evaluation_EvaluationGroupID] FOREIGN KEY([EvaluationGroupID])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [fact].[Evaluation] CHECK CONSTRAINT [FK_Evaluation_EvaluationGroupID]
GO
