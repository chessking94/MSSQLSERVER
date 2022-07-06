USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheatTestGames](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[WhiteLast] [varchar](50) NOT NULL,
	[WhiteFirst] [varchar](30) NULL,
	[WhiteElo] [int] NULL,
	[BlackLast] [varchar](50) NOT NULL,
	[BlackFirst] [varchar](30) NULL,
	[BlackElo] [int] NULL,
	[ECO] [varchar](3) NULL,
	[GameDate] [date] NULL,
	[Tournament] [varchar](100) NULL,
	[RoundNum] [varchar](8) NULL,
	[Result] [decimal](2, 1) NULL,
	[Moves] [int] NULL,
	[DateAdded] [datetime] NULL,
	[CorrFlag] [tinyint] NULL,
 CONSTRAINT [PK_CTG_GameID] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CheatTestGames] ADD  DEFAULT (getdate()) FOR [DateAdded]
GO
