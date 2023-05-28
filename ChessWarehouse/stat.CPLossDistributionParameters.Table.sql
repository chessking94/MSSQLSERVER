USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[CPLossDistributionParameters](
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Alpha] [decimal](19, 15) NOT NULL,
	[Beta] [decimal](19, 15) NOT NULL,
	[PrevAlpha] [decimal](19, 15) NULL,
	[PrevBeta] [decimal](19, 15) NULL,
 CONSTRAINT [PK_CPLossDistributionParameters] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[TimeControlID] ASC,
	[RatingID] ASC,
	[EvaluationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[CPLossDistributionParameters] ADD  CONSTRAINT [DF_CPLossDistributionParameters_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [stat].[CPLossDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributionParameters_EvaluationGroupID] FOREIGN KEY([EvaluationGroupID])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [stat].[CPLossDistributionParameters] CHECK CONSTRAINT [FK_CPLossDistributionParameters_EvaluationGroupID]
GO
ALTER TABLE [stat].[CPLossDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributionParameters_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [stat].[CPLossDistributionParameters] CHECK CONSTRAINT [FK_CPLossDistributionParameters_RatingID]
GO
ALTER TABLE [stat].[CPLossDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributionParameters_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [stat].[CPLossDistributionParameters] CHECK CONSTRAINT [FK_CPLossDistributionParameters_SourceID]
GO
ALTER TABLE [stat].[CPLossDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_CPLossDistributionParameters_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [stat].[CPLossDistributionParameters] CHECK CONSTRAINT [FK_CPLossDistributionParameters_TimeControlID]
GO
