USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeControls](
	[TimeControl] [varchar](15) NOT NULL,
	[TimeControlType] [varchar](20) NULL,
	[CorrFlag] [tinyint] NULL,
	[TimeControlRank] [tinyint] NULL,
	[Seconds]  AS (case when charindex('+',[TimeControl])>(0) then CONVERT([smallint],left([TimeControl],charindex('+',[TimeControl])-(1)))  end) PERSISTED,
	[Increment]  AS (case when charindex('+',[TimeControl])>(0) then CONVERT([smallint],substring([TimeControl],charindex('+',[TimeControl])+(1),len([TimeControl])))  end) PERSISTED,
 CONSTRAINT [PK_TC_TimeControl] PRIMARY KEY CLUSTERED 
(
	[TimeControl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
