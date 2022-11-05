USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[Game](
	[SourceID] [tinyint] NOT NULL,
	[GameID] [varchar](10) NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[ColorID] [tinyint] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[CalculationDate] [datetime] NOT NULL,
	[CPL_Moves] [smallint] NOT NULL,
	[CPL_1] [smallint] NOT NULL,
	[CPL_2] [smallint] NOT NULL,
	[CPL_3] [smallint] NOT NULL,
	[CPL_4] [smallint] NOT NULL,
	[CPL_5] [smallint] NOT NULL,
	[CPL_6] [smallint] NOT NULL,
	[CPL_7] [smallint] NOT NULL,
	[CPL_8] [smallint] NOT NULL,
	[MovesAnalyzed] [smallint] NOT NULL,
	[ACPL] [decimal](9, 6) NULL,
	[SDCPL] [decimal](9, 6) NULL,
	[ScACPL] [decimal](9, 6) NULL,
	[ScSDCPL] [decimal](9, 6) NULL,
	[T1] [decimal](7, 6) NULL,
	[T2] [decimal](7, 6) NULL,
	[T3] [decimal](7, 6) NULL,
	[T4] [decimal](7, 6) NULL,
	[T5] [decimal](7, 6) NULL,
	[Score] [decimal](7, 4) NULL,
	[ACPL_Z] [decimal](9, 6) NULL,
	[SDCPL_Z] [decimal](9, 6) NULL,
	[ScACPL_Z] [decimal](9, 6) NULL,
	[ScSDCPL_Z] [decimal](9, 6) NULL,
	[T1_Z] [decimal](9, 6) NULL,
	[T2_Z] [decimal](9, 6) NULL,
	[T3_Z] [decimal](9, 6) NULL,
	[T4_Z] [decimal](9, 6) NULL,
	[T5_Z] [decimal](9, 6) NULL,
	[Score_Z] [decimal](9, 6) NULL,
 CONSTRAINT [PK_FGame] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[GameID] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[Game] ADD  CONSTRAINT [DF_FGame_CalculationDate]  DEFAULT (getdate()) FOR [CalculationDate]
GO
ALTER TABLE [fact].[Game]  WITH CHECK ADD  CONSTRAINT [FK_FGame_ColorID] FOREIGN KEY([ColorID])
REFERENCES [dim].[Colors] ([ColorID])
GO
ALTER TABLE [fact].[Game] CHECK CONSTRAINT [FK_FGame_ColorID]
GO
ALTER TABLE [fact].[Game]  WITH CHECK ADD  CONSTRAINT [FK_FGame_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dim].[Players] ([PlayerID])
GO
ALTER TABLE [fact].[Game] CHECK CONSTRAINT [FK_FGame_PlayerID]
GO
ALTER TABLE [fact].[Game]  WITH CHECK ADD  CONSTRAINT [FK_FGame_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [fact].[Game] CHECK CONSTRAINT [FK_FGame_RatingID]
GO
ALTER TABLE [fact].[Game]  WITH CHECK ADD  CONSTRAINT [FK_FGame_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [fact].[Game] CHECK CONSTRAINT [FK_FGame_SourceID]
GO
ALTER TABLE [fact].[Game]  WITH CHECK ADD  CONSTRAINT [FK_FGame_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [fact].[Game] CHECK CONSTRAINT [FK_FGame_TimeControlID]
GO
