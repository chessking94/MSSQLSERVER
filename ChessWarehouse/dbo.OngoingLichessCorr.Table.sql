USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OngoingLichessCorr](
	[GameID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Filename] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastReviewed] [datetime] NULL,
	[LastMoveAtUnix] [bigint] NULL,
	[Download] [bit] NULL,
	[Inactive] [bit] NULL,
 CONSTRAINT [PK_OngoingLichessCorr] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
