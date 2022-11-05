USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[StatisticsSummary](
	[SourceID] [tinyint] NOT NULL,
	[AggregationID] [tinyint] NOT NULL,
	[MeasurementID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[EvaluationGroupID] [tinyint] NOT NULL,
	[AggregationDate] [datetime] NOT NULL,
	[RecordCount] [int] NULL,
	[Average] [decimal](18, 15) NULL,
	[StandardDeviation] [decimal](18, 15) NULL,
	[MinValue] [decimal](18, 15) NULL,
	[LowerPcnt] [decimal](18, 15) NULL,
	[LowerQuartile] [decimal](18, 15) NULL,
	[Median] [decimal](18, 15) NULL,
	[UpperQuartile] [decimal](18, 15) NULL,
	[UpperPcnt] [decimal](18, 15) NULL,
	[MaxValue] [decimal](18, 15) NULL,
 CONSTRAINT [PK_StatisticsSummary] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[AggregationID] ASC,
	[MeasurementID] ASC,
	[RatingID] ASC,
	[TimeControlID] ASC,
	[ColorID] ASC,
	[EvaluationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[StatisticsSummary] ADD  CONSTRAINT [DF_StatisticsSummary_AggregationDate]  DEFAULT (getdate()) FOR [AggregationDate]
GO
ALTER TABLE [fact].[StatisticsSummary]  WITH CHECK ADD  CONSTRAINT [FK_StatisticsSummary_AggregationID] FOREIGN KEY([AggregationID])
REFERENCES [dim].[Aggregations] ([AggregationID])
GO
ALTER TABLE [fact].[StatisticsSummary] CHECK CONSTRAINT [FK_StatisticsSummary_AggregationID]
GO
ALTER TABLE [fact].[StatisticsSummary]  WITH CHECK ADD  CONSTRAINT [FK_StatisticsSummary_MeasurementID] FOREIGN KEY([MeasurementID])
REFERENCES [dim].[Measurements] ([MeasurementID])
GO
ALTER TABLE [fact].[StatisticsSummary] CHECK CONSTRAINT [FK_StatisticsSummary_MeasurementID]
GO
ALTER TABLE [fact].[StatisticsSummary]  WITH CHECK ADD  CONSTRAINT [FK_StatisticsSummary_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [fact].[StatisticsSummary] CHECK CONSTRAINT [FK_StatisticsSummary_RatingID]
GO
ALTER TABLE [fact].[StatisticsSummary]  WITH CHECK ADD  CONSTRAINT [FK_StatisticsSummary_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [fact].[StatisticsSummary] CHECK CONSTRAINT [FK_StatisticsSummary_SourceID]
GO
ALTER TABLE [fact].[StatisticsSummary]  WITH CHECK ADD  CONSTRAINT [FK_StatisticsSummary_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [fact].[StatisticsSummary] CHECK CONSTRAINT [FK_StatisticsSummary_TimeControlID]
GO
