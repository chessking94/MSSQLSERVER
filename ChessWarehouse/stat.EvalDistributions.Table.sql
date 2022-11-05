USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[EvalDistributions](
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[Evaluation] [decimal](5, 2) NOT NULL,
	[PDF] [decimal](10, 9) NULL,
	[CDF] [decimal](10, 9) NULL,
 CONSTRAINT [PK_EvalDistributions] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[TimeControlID] ASC,
	[Evaluation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[EvalDistributions]  WITH CHECK ADD  CONSTRAINT [FK_EvalDistribution_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [stat].[EvalDistributions] CHECK CONSTRAINT [FK_EvalDistribution_SourceID]
GO
ALTER TABLE [stat].[EvalDistributions]  WITH CHECK ADD  CONSTRAINT [FK_EvalDistribution_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [stat].[EvalDistributions] CHECK CONSTRAINT [FK_EvalDistribution_TimeControlID]
GO
