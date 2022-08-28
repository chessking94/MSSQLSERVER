USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeControlLimits](
	[TimeControlType] [varchar](20) NULL,
	[MinSeconds] [int] NULL,
	[MaxSeconds] [int] NULL,
	[TimeControlRank] [tinyint] NULL
) ON [PRIMARY]
GO
