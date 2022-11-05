USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[Event](
	[EventID] [int] NOT NULL,
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[RatingID] [smallint] NOT NULL,
	[CalculationDate] [datetime] NOT NULL,
	[GameCount] [tinyint] NOT NULL,
	[CPL_Moves] [int] NOT NULL,
	[CPL_1] [int] NOT NULL,
	[CPL_2] [int] NOT NULL,
	[CPL_3] [int] NOT NULL,
	[CPL_4] [int] NOT NULL,
	[CPL_5] [int] NOT NULL,
	[CPL_6] [int] NOT NULL,
	[CPL_7] [int] NOT NULL,
	[CPL_8] [int] NOT NULL,
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
 CONSTRAINT [PK_FEvent] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[SourceID] ASC,
	[TimeControlID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [fact].[Event] ADD  CONSTRAINT [DF_FEvent_CalculationDate]  DEFAULT (getdate()) FOR [CalculationDate]
GO
ALTER TABLE [fact].[Event]  WITH CHECK ADD  CONSTRAINT [FK_FEvent_EventID] FOREIGN KEY([EventID])
REFERENCES [dim].[Events] ([EventID])
GO
ALTER TABLE [fact].[Event] CHECK CONSTRAINT [FK_FEvent_EventID]
GO
ALTER TABLE [fact].[Event]  WITH CHECK ADD  CONSTRAINT [FK_FEvent_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dim].[Players] ([PlayerID])
GO
ALTER TABLE [fact].[Event] CHECK CONSTRAINT [FK_FEvent_PlayerID]
GO
ALTER TABLE [fact].[Event]  WITH CHECK ADD  CONSTRAINT [FK_FEvent_RatingID] FOREIGN KEY([RatingID])
REFERENCES [dim].[Ratings] ([RatingID])
GO
ALTER TABLE [fact].[Event] CHECK CONSTRAINT [FK_FEvent_RatingID]
GO
ALTER TABLE [fact].[Event]  WITH CHECK ADD  CONSTRAINT [FK_FEvent_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [fact].[Event] CHECK CONSTRAINT [FK_FEvent_SourceID]
GO
ALTER TABLE [fact].[Event]  WITH CHECK ADD  CONSTRAINT [FK_FEvent_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [fact].[Event] CHECK CONSTRAINT [FK_FEvent_TimeControlID]
GO
