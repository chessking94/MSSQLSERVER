USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ControlMovePlayedRanking] (@MoveID int)
RETURNS int

AS

Begin
	DECLARE @rank int

	SET @rank =
	(SELECT
		CASE
			WHEN Move_Eval = T1_Eval THEN 1
			WHEN Move_Eval = T2_Eval THEN 2
			WHEN Move_Eval = T3_Eval THEN 3
			WHEN Move_Eval = T4_Eval THEN 4
			WHEN Move_Eval = T5_Eval THEN 5
			WHEN Move_Eval = T6_Eval THEN 6
			WHEN Move_Eval = T7_Eval THEN 7
			WHEN Move_Eval = T8_Eval THEN 8
			WHEN Move_Eval = T9_Eval THEN 9
			WHEN Move_Eval = T10_Eval THEN 10
			WHEN Move_Eval = T11_Eval THEN 11
			WHEN Move_Eval = T12_Eval THEN 12
			WHEN Move_Eval = T13_Eval THEN 13
			WHEN Move_Eval = T14_Eval THEN 14
			WHEN Move_Eval = T15_Eval THEN 15
			WHEN Move_Eval = T16_Eval THEN 16
			WHEN Move_Eval = T17_Eval THEN 17
			WHEN Move_Eval = T18_Eval THEN 18
			WHEN Move_Eval = T19_Eval THEN 19
			WHEN Move_Eval = T20_Eval THEN 20
			WHEN Move_Eval = T21_Eval THEN 21
			WHEN Move_Eval = T22_Eval THEN 22
			WHEN Move_Eval = T23_Eval THEN 23
			WHEN Move_Eval = T24_Eval THEN 24
			WHEN Move_Eval = T25_Eval THEN 25
			WHEN Move_Eval = T26_Eval THEN 26
			WHEN Move_Eval = T27_Eval THEN 27
			WHEN Move_Eval = T28_Eval THEN 28
			WHEN Move_Eval = T29_Eval THEN 29
			WHEN Move_Eval = T30_Eval THEN 30
			WHEN Move_Eval = T31_Eval THEN 31
			WHEN Move_Eval = T32_Eval THEN 32
			ELSE 33
		END AS move_ranking

		FROM ControlMoves

		WHERE MoveID = @MoveID
	)

	Return @rank
END
GO
