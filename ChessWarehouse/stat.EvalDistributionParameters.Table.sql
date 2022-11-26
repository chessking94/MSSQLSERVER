USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stat].[EvalDistributionParameters](
	[SourceID] [tinyint] NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[Mean] [decimal](18, 15) NOT NULL,
	[StandardDeviation] [decimal](18, 15) NOT NULL,
 CONSTRAINT [PK_EvalDistributionParameters] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[TimeControlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [stat].[EvalDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_EvalDistributionParameters_SourceID] FOREIGN KEY([SourceID])
REFERENCES [dim].[Sources] ([SourceID])
GO
ALTER TABLE [stat].[EvalDistributionParameters] CHECK CONSTRAINT [FK_EvalDistributionParameters_SourceID]
GO
ALTER TABLE [stat].[EvalDistributionParameters]  WITH CHECK ADD  CONSTRAINT [FK_EvalDistributionParameters_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [stat].[EvalDistributionParameters] CHECK CONSTRAINT [FK_EvalDistributionParameters_TimeControlID]
GO
