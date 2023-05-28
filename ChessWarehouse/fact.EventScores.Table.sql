USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[EventScores](
	[EventID] [int] NOT NULL,
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[ScoreID] [tinyint] NOT NULL,
	[Score] [decimal](7, 4) NULL,
	[Score_Z] [decimal](9, 6) NULL,
 CONSTRAINT [PK_EventScores] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[SourceID] ASC,
	[TimeControlID] ASC,
	[PlayerID] ASC,
	[ScoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[EventScores]  WITH CHECK ADD  CONSTRAINT [FK_EventScores_FactEvent] FOREIGN KEY([EventID], [SourceID], [TimeControlID], [PlayerID])
REFERENCES [fact].[Event] ([EventID], [SourceID], [TimeControlID], [PlayerID])
GO
ALTER TABLE [fact].[EventScores] CHECK CONSTRAINT [FK_EventScores_FactEvent]
GO
ALTER TABLE [fact].[EventScores]  WITH CHECK ADD  CONSTRAINT [FK_EventScores_ScoreID] FOREIGN KEY([ScoreID])
REFERENCES [dim].[Scores] ([ScoreID])
GO
ALTER TABLE [fact].[EventScores] CHECK CONSTRAINT [FK_EventScores_ScoreID]
GO
