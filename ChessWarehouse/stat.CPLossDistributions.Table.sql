USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[CPLossDistributions](
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[CP_Loss] [decimal](5, 2) NOT NULL,
	[DistributionID] [tinyint] NOT NULL,
	[PDF] [decimal](10, 9) NULL,
	[CDF] [decimal](10, 9) NULL,
 CONSTRAINT [PK_CPLossDistributions] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[TimeControlID] ASC,
	[RatingID] ASC,
	[EvaluationGroupID] ASC,
	[CP_Loss] ASC,
	[DistributionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[CPLossDistributions]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributions_DistributionID] FOREIGN KEY([DistributionID])
REFERENCES [stat].[DistributionTypes] ([DistributionID])
GO
ALTER TABLE [stat].[CPLossDistributions] CHECK CONSTRAINT [FK_CPLossDistributions_DistributionID]
GO
ALTER TABLE [stat].[CPLossDistributions]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributions_EvaluationGroupID] FOREIGN KEY([EvaluationGroupID])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [stat].[CPLossDistributions] CHECK CONSTRAINT [FK_CPLossDistributions_EvaluationGroupID]
GO
ALTER TABLE [stat].[CPLossDistributions]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributions_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [stat].[CPLossDistributions] CHECK CONSTRAINT [FK_CPLossDistributions_RatingID]
GO
ALTER TABLE [stat].[CPLossDistributions]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributions_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [stat].[CPLossDistributions] CHECK CONSTRAINT [FK_CPLossDistributions_SourceID]
GO
ALTER TABLE [stat].[CPLossDistributions]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributions_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [stat].[CPLossDistributions] CHECK CONSTRAINT [FK_CPLossDistributions_TimeControlID]
GO
