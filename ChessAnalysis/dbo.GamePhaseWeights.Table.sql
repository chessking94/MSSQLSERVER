USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GamePhaseWeights](
	[Source] [varchar](15) NOT NULL,
	[TimeControlType] [varchar](20) NOT NULL,
	[PhaseID] [int] NOT NULL,
	[ScoreWeight] [decimal](7, 6) NULL,
 CONSTRAINT [PK_GPW] PRIMARY KEY CLUSTERED 
(
	[Source] ASC,
	[TimeControlType] ASC,
	[PhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GamePhaseWeights]  WITH CHECK ADD  CONSTRAINT [FK_GPW_PhaseID] FOREIGN KEY([PhaseID])
REFERENCES [dbo].[GamePhases] ([PhaseID])
GO
ALTER TABLE [dbo].[GamePhaseWeights] CHECK CONSTRAINT [FK_GPW_PhaseID]
GO
ALTER TABLE [dbo].[GamePhaseWeights]  WITH CHECK ADD  CONSTRAINT [FK_GPW_TimeControlType] FOREIGN KEY([TimeControlType])
REFERENCES [dbo].[TimeControlTypes] ([TimeControlType])
GO
ALTER TABLE [dbo].[GamePhaseWeights] CHECK CONSTRAINT [FK_GPW_TimeControlType]
GO
