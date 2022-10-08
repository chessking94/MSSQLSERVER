USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USCFGolden](
	[Filename] [varchar](25) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ID] [int] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
	[State] [varchar](15) NULL,
	[Regular] [varchar](8) NULL,
	[RegProvGames] [tinyint] NULL,
	[Quick] [varchar](8) NULL,
	[QkProvGames] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
