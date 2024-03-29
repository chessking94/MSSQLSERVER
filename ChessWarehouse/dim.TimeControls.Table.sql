﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[TimeControls](
	[TimeControlID] [tinyint] IDENTITY(1,1) NOT NULL,
	[TimeControlName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MinSeconds] [int] NULL,
	[MaxSeconds] [int] NULL,
 CONSTRAINT [PK_TC] PRIMARY KEY CLUSTERED 
(
	[TimeControlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_TimeControls_TimeControlName] UNIQUE NONCLUSTERED 
(
	[TimeControlName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
