﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StageMoves]

AS

TRUNCATE TABLE stage.Moves

INSERT INTO stage.Moves (
	SiteGameID,
	MoveNumber,
	Color,
	IsTheory,
	IsTablebase,
	EngineName,
	Depth,
	Clock,
	TimeSpent,
	FEN,
	PhaseID,
	Move,
	Move_Eval,
	Move_Rank,
	CP_Loss,
	T1,
	T1_Eval,
	T2,
	T2_Eval,
	T3,
	T3_Eval,
	T4,
	T4_Eval,
	T5,
	T5_Eval,
	T6,
	T6_Eval,
	T7,
	T7_Eval,
	T8,
	T8_Eval,
	T9,
	T9_Eval,
	T10,
	T10_Eval,
	T11,
	T11_Eval,
	T12,
	T12_Eval,
	T13,
	T13_Eval,
	T14,
	T14_Eval,
	T15,
	T15_Eval,
	T16,
	T16_Eval,
	T17,
	T17_Eval,
	T18,
	T18_Eval,
	T19,
	T19_Eval,
	T20,
	T20_Eval,
	T21,
	T21_Eval,
	T22,
	T22_Eval,
	T23,
	T23_Eval,
	T24,
	T24_Eval,
	T25,
	T25_Eval,
	T26,
	T26_Eval,
	T27,
	T27_Eval,
	T28,
	T28_Eval,
	T29,
	T29_Eval,
	T30,
	T30_Eval,
	T31,
	T31_Eval,
	T32,
	T32_Eval
)

SELECT
Field1 AS SiteGameID,
Field2 AS MoveNumber,
Field3 AS Color,
Field4 AS IsTheory,
Field5 AS IsTablebase,
Field6 AS EngineName,
Field7 AS Depth,
Field8 AS Clock,
Field9 AS TimeSpent,
Field10 AS FEN,
Field11 AS PhaseID,
Field12 AS Move,
Field13 AS Move_Eval,
Field14 AS Move_Rank,
Field15 AS CP_Loss,
Field16 AS T1,
Field17 AS T1_Eval,
Field18 AS T2,
Field19 AS T2_Eval,
Field20 AS T3,
Field21 AS T3_Eval,
Field22 AS T4,
Field23 AS T4_Eval,
Field24 AS T5,
Field25 AS T5_Eval,
Field26 AS T6,
Field27 AS T6_Eval,
Field28 AS T7,
Field29 AS T7_Eval,
Field30 AS T8,
Field31 AS T8_Eval,
Field32 AS T9,
Field33 AS T9_Eval,
Field34 AS T10,
Field35 AS T10_Eval,
Field36 AS T11,
Field37 AS T11_Eval,
Field38 AS T12,
Field39 AS T12_Eval,
Field40 AS T13,
Field41 AS T13_Eval,
Field42 AS T14,
Field43 AS T14_Eval,
Field44 AS T15,
Field45 AS T15_Eval,
Field46 AS T16,
Field47 AS T16_Eval,
Field48 AS T17,
Field49 AS T17_Eval,
Field50 AS T18,
Field51 AS T18_Eval,
Field52 AS T19,
Field53 AS T19_Eval,
Field54 AS T20,
Field55 AS T20_Eval,
Field56 AS T21,
Field57 AS T21_Eval,
Field58 AS T22,
Field59 AS T22_Eval,
Field60 AS T23,
Field61 AS T23_Eval,
Field62 AS T24,
Field63 AS T24_Eval,
Field64 AS T25,
Field65 AS T25_Eval,
Field66 AS T26,
Field67 AS T26_Eval,
Field68 AS T27,
Field69 AS T27_Eval,
Field70 AS T28,
Field71 AS T28_Eval,
Field72 AS T29,
Field73 AS T29_Eval,
Field74 AS T30,
Field75 AS T30_Eval,
Field76 AS T31,
Field77 AS T31_Eval,
Field78 AS T32,
Field79 AS T32_Eval

FROM stage.BulkInsertGameData

WHERE RecordKey = 'M'
GO
