USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvalDistributions](
	[Source] [varchar](10) NOT NULL,
	[TimeControlType] [varchar](20) NOT NULL,
	[Eval] [decimal](5, 2) NOT NULL,
	[PDF] [decimal](10, 9) NULL,
	[CDF] [decimal](10, 9) NULL,
 CONSTRAINT [PK_ED] PRIMARY KEY CLUSTERED 
(
	[Source] ASC,
	[TimeControlType] ASC,
	[Eval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
