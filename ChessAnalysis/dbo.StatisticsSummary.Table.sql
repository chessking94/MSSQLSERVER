USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatisticsSummary](
	[Source] [varchar](10) NOT NULL,
	[Aggregation] [varchar](10) NOT NULL,
	[Field] [varchar](12) NOT NULL,
	[Rating] [smallint] NOT NULL,
	[TimeControlType] [varchar](20) NOT NULL,
	[Color] [varchar](5) NOT NULL,
	[EvalGroup] [tinyint] NOT NULL,
	[Count] [int] NULL,
	[Average] [decimal](18, 15) NULL,
	[StandardDeviation] [decimal](18, 15) NULL,
	[LowerPcnt] [decimal](18, 15) NULL,
	[LowerQuartile] [decimal](18, 15) NULL,
	[Median] [decimal](18, 15) NULL,
	[UpperQuartile] [decimal](18, 15) NULL,
	[UpperPcnt] [decimal](18, 15) NULL,
	[UpdateDate] [datetime] NULL,
	[MinValue] [decimal](18, 15) NULL,
	[MaxValue] [decimal](18, 15) NULL,
 CONSTRAINT [PK_SS] PRIMARY KEY CLUSTERED 
(
	[Source] ASC,
	[Aggregation] ASC,
	[Field] ASC,
	[Rating] ASC,
	[TimeControlType] ASC,
	[Color] ASC,
	[EvalGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatisticsSummary] ADD  CONSTRAINT [DF_SS_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
