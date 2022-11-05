USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[PerfRatingCrossRef](
	[Score] [decimal](3, 2) NOT NULL,
	[RatingEffect] [smallint] NOT NULL
) ON [PRIMARY]
GO
