USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatisticsSummary](
	[Aggregation] [varchar](10) NOT NULL,
	[Field] [varchar](5) NOT NULL,
	[Rating] [smallint] NOT NULL,
	[CorrFlag] [tinyint] NOT NULL,
	[Color] [varchar](5) NOT NULL,
	[EvalGroup] [tinyint] NOT NULL,
	[Count] [int] NULL,
	[Average] [decimal](17, 15) NULL,
	[StandardDeviation] [decimal](17, 15) NULL,
	[LowerPcnt] [decimal](17, 15) NULL,
	[LowerQuartile] [decimal](17, 15) NULL,
	[Median] [decimal](17, 15) NULL,
	[UpperQuartile] [decimal](17, 15) NULL,
	[UpperPcnt] [decimal](17, 15) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_SS] PRIMARY KEY CLUSTERED 
(
	[Aggregation] ASC,
	[Field] ASC,
	[Rating] ASC,
	[CorrFlag] ASC,
	[Color] ASC,
	[EvalGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatisticsSummary] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO
