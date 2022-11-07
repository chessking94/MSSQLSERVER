USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[Covariances](
	[SourceID] [tinyint] NOT NULL,
	[AggregationID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[MeasurementID1] [tinyint] NOT NULL,
	[MeasurementID2] [tinyint] NOT NULL,
	[Covariance] [decimal](18, 10) NULL,
 CONSTRAINT [PK_Covariances] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[AggregationID] ASC,
	[RatingID] ASC,
	[TimeControlID] ASC,
	[ColorID] ASC,
	[EvaluationGroupID] ASC,
	[MeasurementID1] ASC,
	[MeasurementID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_AggregationID] FOREIGN KEY([AggregationID])
REFERENCES [dim].[Aggregations] ([AggregationID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_AggregationID]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_ColorID] FOREIGN KEY([ColorID])
REFERENCES [dim].[Colors] ([ColorID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_ColorID]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_EvaluationGroupID] FOREIGN KEY([EvaluationGroupID])
REFERENCES [dim].[EvaluationGroups] ([EvaluationGroupID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_EvaluationGroupID]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_MeasurementID1] FOREIGN KEY([MeasurementID1])
REFERENCES [dim].[Measurements] ([MeasurementID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_MeasurementID1]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_MeasurementID2] FOREIGN KEY([MeasurementID2])
REFERENCES [dim].[Measurements] ([MeasurementID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_MeasurementID2]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_RatingID]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_SourceID]
GO
ALTER TABLE [stat].[Covariances]  WITH CHECK ADD  CONSTRAINT [FK_Covariances_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [stat].[Covariances] CHECK CONSTRAINT [FK_Covariances_TimeControlID]
GO
