USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[GameScores](
	[SourceID] [tinyint] NOT NULL,
	[GameID] [int] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[ScoreID] [tinyint] NOT NULL,
	[Score] [decimal](7, 4) NULL,
	[Score_Z] [decimal](9, 6) NULL,
 CONSTRAINT [PK_GameScores] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[GameID] ASC,
	[ColorID] ASC,
	[ScoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[GameScores]  WITH CHECK ADD  CONSTRAINT [FK_GameScores_FactGame] FOREIGN KEY([SourceID], [GameID], [ColorID])
REFERENCES [fact].[Game] ([SourceID], [GameID], [ColorID])
ON DELETE CASCADE
GO
ALTER TABLE [fact].[GameScores] CHECK CONSTRAINT [FK_GameScores_FactGame]
GO
ALTER TABLE [fact].[GameScores]  WITH CHECK ADD  CONSTRAINT [FK_GameScores_ScoreID] FOREIGN KEY([ScoreID])
REFERENCES [dim].[Scores] ([ScoreID])
GO
ALTER TABLE [fact].[GameScores] CHECK CONSTRAINT [FK_GameScores_ScoreID]
GO
