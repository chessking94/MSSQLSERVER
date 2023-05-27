USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[MoveScores](
	[ScoreID] [tinyint] NOT NULL,
	[GameID] [int] NOT NULL,
	[MoveNumber] [smallint] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[ScoreValue] [decimal](10, 9) NULL,
	[MaxScoreValue] [decimal](10, 9) NULL,
 CONSTRAINT [PK_MoveScores] PRIMARY KEY CLUSTERED 
(
	[ScoreID] ASC,
	[GameID] ASC,
	[MoveNumber] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[MoveScores]  WITH CHECK ADD  CONSTRAINT [FK_MoveScores_MoveID] FOREIGN KEY([GameID], [MoveNumber], [ColorID])
REFERENCES [lake].[Moves] ([GameID], [MoveNumber], [ColorID])
ON DELETE CASCADE
GO
ALTER TABLE [stat].[MoveScores] CHECK CONSTRAINT [FK_MoveScores_MoveID]
GO
ALTER TABLE [stat].[MoveScores]  WITH CHECK ADD  CONSTRAINT [FK_MoveScores_ScoreID] FOREIGN KEY([ScoreID])
REFERENCES [dim].[Scores] ([ScoreID])
ON DELETE CASCADE
GO
ALTER TABLE [stat].[MoveScores] CHECK CONSTRAINT [FK_MoveScores_ScoreID]
GO
