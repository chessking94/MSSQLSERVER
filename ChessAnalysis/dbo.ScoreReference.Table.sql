USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScoreReference](
	[BestEvalGroup] [int] NOT NULL,
	[PlayedEvalGroup] [int] NOT NULL,
	[ACPL_Group] [int] NOT NULL,
	[Score] [decimal](4, 3) NULL,
	[Meaningful] [tinyint] NULL,
	[Points] [int] NULL,
 CONSTRAINT [PK_SR_ScoreKey] PRIMARY KEY CLUSTERED 
(
	[BestEvalGroup] ASC,
	[PlayedEvalGroup] ASC,
	[ACPL_Group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
