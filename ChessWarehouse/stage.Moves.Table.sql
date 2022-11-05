﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Moves](
	[Errors] [varchar](100) NULL,
	[SiteGameID] [varchar](15) NOT NULL,
	[GameID] [int] NULL,
	[MoveNumber] [smallint] NOT NULL,
	[Color] [char](5) NOT NULL,
	[IsTheory] [bit] NOT NULL,
	[IsTablebase] [bit] NOT NULL,
	[EngineName] [varchar](20) NOT NULL,
	[Depth] [tinyint] NOT NULL,
	[Clock] [int] NULL,
	[TimeSpent] [int] NULL,
	[FEN] [varchar](92) NOT NULL,
	[PhaseID] [tinyint] NOT NULL,
	[Move] [varchar](10) NOT NULL,
	[Move_Eval] [varchar](7) NOT NULL,
	[Move_Rank] [tinyint] NOT NULL,
	[CP_Loss] [decimal](5, 2) NULL,
	[T1] [varchar](10) NOT NULL,
	[T1_Eval] [varchar](7) NOT NULL,
	[T2] [varchar](10) NULL,
	[T2_Eval] [varchar](7) NULL,
	[T3] [varchar](10) NULL,
	[T3_Eval] [varchar](7) NULL,
	[T4] [varchar](10) NULL,
	[T4_Eval] [varchar](7) NULL,
	[T5] [varchar](10) NULL,
	[T5_Eval] [varchar](7) NULL,
	[T6] [varchar](10) NULL,
	[T6_Eval] [varchar](7) NULL,
	[T7] [varchar](10) NULL,
	[T7_Eval] [varchar](7) NULL,
	[T8] [varchar](10) NULL,
	[T8_Eval] [varchar](7) NULL,
	[T9] [varchar](10) NULL,
	[T9_Eval] [varchar](7) NULL,
	[T10] [varchar](10) NULL,
	[T10_Eval] [varchar](7) NULL,
	[T11] [varchar](10) NULL,
	[T11_Eval] [varchar](7) NULL,
	[T12] [varchar](10) NULL,
	[T12_Eval] [varchar](7) NULL,
	[T13] [varchar](10) NULL,
	[T13_Eval] [varchar](7) NULL,
	[T14] [varchar](10) NULL,
	[T14_Eval] [varchar](7) NULL,
	[T15] [varchar](10) NULL,
	[T15_Eval] [varchar](7) NULL,
	[T16] [varchar](10) NULL,
	[T16_Eval] [varchar](7) NULL,
	[T17] [varchar](10) NULL,
	[T17_Eval] [varchar](7) NULL,
	[T18] [varchar](10) NULL,
	[T18_Eval] [varchar](7) NULL,
	[T19] [varchar](10) NULL,
	[T19_Eval] [varchar](7) NULL,
	[T20] [varchar](10) NULL,
	[T20_Eval] [varchar](7) NULL,
	[T21] [varchar](10) NULL,
	[T21_Eval] [varchar](7) NULL,
	[T22] [varchar](10) NULL,
	[T22_Eval] [varchar](7) NULL,
	[T23] [varchar](10) NULL,
	[T23_Eval] [varchar](7) NULL,
	[T24] [varchar](10) NULL,
	[T24_Eval] [varchar](7) NULL,
	[T25] [varchar](10) NULL,
	[T25_Eval] [varchar](7) NULL,
	[T26] [varchar](10) NULL,
	[T26_Eval] [varchar](7) NULL,
	[T27] [varchar](10) NULL,
	[T27_Eval] [varchar](7) NULL,
	[T28] [varchar](10) NULL,
	[T28_Eval] [varchar](7) NULL,
	[T29] [varchar](10) NULL,
	[T29_Eval] [varchar](7) NULL,
	[T30] [varchar](10) NULL,
	[T30_Eval] [varchar](7) NULL,
	[T31] [varchar](10) NULL,
	[T31_Eval] [varchar](7) NULL,
	[T32] [varchar](10) NULL,
	[T32_Eval] [varchar](7) NULL
) ON [PRIMARY]
GO
