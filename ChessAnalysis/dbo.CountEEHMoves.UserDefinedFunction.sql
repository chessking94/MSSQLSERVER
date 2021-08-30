﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CountEEHMoves] (@MoveID int)
RETURNS int

AS

BEGIN
	DECLARE @ct int

	SET @ct =
	(SELECT
		CASE WHEN T1_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T2_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T3_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T4_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T5_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T6_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T7_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T8_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T9_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T10_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T11_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T12_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T13_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T14_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T15_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T16_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T17_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T18_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T19_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T20_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T21_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T22_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T23_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T24_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T25_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T26_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T27_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T28_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T29_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T30_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T31_Eval IS NULL THEN 0 ELSE 1 END +
		CASE WHEN T32_Eval IS NULL THEN 0 ELSE 1 END

		FROM EEHMoves

		WHERE MoveID = @MoveID
	)

	RETURN @ct
END
GO
