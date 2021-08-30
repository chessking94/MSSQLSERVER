﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOnlineAvgCandidateError] AS

DECLARE @acpl_window float
SET @acpl_window = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'ACPL Window') AS float)

update em
SET em.AvgCandidateError = ae.AvgCandErr
FROM OnlineMoves em
JOIN
(SELECT
	MoveID,
	CASE WHEN CandidateMoves = 0 THEN NULL ELSE
	(CASE WHEN T1_Eval IS NULL OR T1_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float)) END +
	CASE WHEN T2_Eval IS NULL OR T2_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T2_Eval LIKE '#+%' THEN 100.00 WHEN T2_Eval LIKE '#-%' THEN -100.00 ELSE T2_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T2_Eval LIKE '#+%' THEN 100.00 WHEN T2_Eval LIKE '#-%' THEN -100.00 ELSE T2_Eval END) AS float)) END +
	CASE WHEN T3_Eval IS NULL OR T3_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T3_Eval LIKE '#+%' THEN 100.00 WHEN T3_Eval LIKE '#-%' THEN -100.00 ELSE T3_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T3_Eval LIKE '#+%' THEN 100.00 WHEN T3_Eval LIKE '#-%' THEN -100.00 ELSE T3_Eval END) AS float)) END +
	CASE WHEN T4_Eval IS NULL OR T4_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T4_Eval LIKE '#+%' THEN 100.00 WHEN T4_Eval LIKE '#-%' THEN -100.00 ELSE T4_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T4_Eval LIKE '#+%' THEN 100.00 WHEN T4_Eval LIKE '#-%' THEN -100.00 ELSE T4_Eval END) AS float)) END +
	CASE WHEN T5_Eval IS NULL OR T5_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T5_Eval LIKE '#+%' THEN 100.00 WHEN T5_Eval LIKE '#-%' THEN -100.00 ELSE T5_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T5_Eval LIKE '#+%' THEN 100.00 WHEN T5_Eval LIKE '#-%' THEN -100.00 ELSE T5_Eval END) AS float)) END +
	CASE WHEN T6_Eval IS NULL OR T6_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T6_Eval LIKE '#+%' THEN 100.00 WHEN T6_Eval LIKE '#-%' THEN -100.00 ELSE T6_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T6_Eval LIKE '#+%' THEN 100.00 WHEN T6_Eval LIKE '#-%' THEN -100.00 ELSE T6_Eval END) AS float)) END +
	CASE WHEN T7_Eval IS NULL OR T7_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T7_Eval LIKE '#+%' THEN 100.00 WHEN T7_Eval LIKE '#-%' THEN -100.00 ELSE T7_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T7_Eval LIKE '#+%' THEN 100.00 WHEN T7_Eval LIKE '#-%' THEN -100.00 ELSE T7_Eval END) AS float)) END +
	CASE WHEN T8_Eval IS NULL OR T8_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T8_Eval LIKE '#+%' THEN 100.00 WHEN T8_Eval LIKE '#-%' THEN -100.00 ELSE T8_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T8_Eval LIKE '#+%' THEN 100.00 WHEN T8_Eval LIKE '#-%' THEN -100.00 ELSE T8_Eval END) AS float)) END +
	CASE WHEN T9_Eval IS NULL OR T9_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T9_Eval LIKE '#+%' THEN 100.00 WHEN T9_Eval LIKE '#-%' THEN -100.00 ELSE T9_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T9_Eval LIKE '#+%' THEN 100.00 WHEN T9_Eval LIKE '#-%' THEN -100.00 ELSE T9_Eval END) AS float)) END +
	CASE WHEN T10_Eval IS NULL OR T10_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T10_Eval LIKE '#+%' THEN 100.00 WHEN T10_Eval LIKE '#-%' THEN -100.00 ELSE T10_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T10_Eval LIKE '#+%' THEN 100.00 WHEN T10_Eval LIKE '#-%' THEN -100.00 ELSE T10_Eval END) AS float)) END +
	CASE WHEN T11_Eval IS NULL OR T11_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T11_Eval LIKE '#+%' THEN 100.00 WHEN T11_Eval LIKE '#-%' THEN -100.00 ELSE T11_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T11_Eval LIKE '#+%' THEN 100.00 WHEN T11_Eval LIKE '#-%' THEN -100.00 ELSE T11_Eval END) AS float)) END +
	CASE WHEN T12_Eval IS NULL OR T12_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T12_Eval LIKE '#+%' THEN 100.00 WHEN T12_Eval LIKE '#-%' THEN -100.00 ELSE T12_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T12_Eval LIKE '#+%' THEN 100.00 WHEN T12_Eval LIKE '#-%' THEN -100.00 ELSE T12_Eval END) AS float)) END +
	CASE WHEN T13_Eval IS NULL OR T13_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T13_Eval LIKE '#+%' THEN 100.00 WHEN T13_Eval LIKE '#-%' THEN -100.00 ELSE T13_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T13_Eval LIKE '#+%' THEN 100.00 WHEN T13_Eval LIKE '#-%' THEN -100.00 ELSE T13_Eval END) AS float)) END +
	CASE WHEN T14_Eval IS NULL OR T14_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T14_Eval LIKE '#+%' THEN 100.00 WHEN T14_Eval LIKE '#-%' THEN -100.00 ELSE T14_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T14_Eval LIKE '#+%' THEN 100.00 WHEN T14_Eval LIKE '#-%' THEN -100.00 ELSE T14_Eval END) AS float)) END +
	CASE WHEN T15_Eval IS NULL OR T15_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T15_Eval LIKE '#+%' THEN 100.00 WHEN T15_Eval LIKE '#-%' THEN -100.00 ELSE T15_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T15_Eval LIKE '#+%' THEN 100.00 WHEN T15_Eval LIKE '#-%' THEN -100.00 ELSE T15_Eval END) AS float)) END +
	CASE WHEN T16_Eval IS NULL OR T16_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T16_Eval LIKE '#+%' THEN 100.00 WHEN T16_Eval LIKE '#-%' THEN -100.00 ELSE T16_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T16_Eval LIKE '#+%' THEN 100.00 WHEN T16_Eval LIKE '#-%' THEN -100.00 ELSE T16_Eval END) AS float)) END +
	CASE WHEN T17_Eval IS NULL OR T17_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T17_Eval LIKE '#+%' THEN 100.00 WHEN T17_Eval LIKE '#-%' THEN -100.00 ELSE T17_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T17_Eval LIKE '#+%' THEN 100.00 WHEN T17_Eval LIKE '#-%' THEN -100.00 ELSE T17_Eval END) AS float)) END +
	CASE WHEN T18_Eval IS NULL OR T18_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T18_Eval LIKE '#+%' THEN 100.00 WHEN T18_Eval LIKE '#-%' THEN -100.00 ELSE T18_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T18_Eval LIKE '#+%' THEN 100.00 WHEN T18_Eval LIKE '#-%' THEN -100.00 ELSE T18_Eval END) AS float)) END +
	CASE WHEN T19_Eval IS NULL OR T19_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T19_Eval LIKE '#+%' THEN 100.00 WHEN T19_Eval LIKE '#-%' THEN -100.00 ELSE T19_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T19_Eval LIKE '#+%' THEN 100.00 WHEN T19_Eval LIKE '#-%' THEN -100.00 ELSE T19_Eval END) AS float)) END +
	CASE WHEN T20_Eval IS NULL OR T20_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T20_Eval LIKE '#+%' THEN 100.00 WHEN T20_Eval LIKE '#-%' THEN -100.00 ELSE T20_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T20_Eval LIKE '#+%' THEN 100.00 WHEN T20_Eval LIKE '#-%' THEN -100.00 ELSE T20_Eval END) AS float)) END +
	CASE WHEN T21_Eval IS NULL OR T21_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T21_Eval LIKE '#+%' THEN 100.00 WHEN T21_Eval LIKE '#-%' THEN -100.00 ELSE T21_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T21_Eval LIKE '#+%' THEN 100.00 WHEN T21_Eval LIKE '#-%' THEN -100.00 ELSE T21_Eval END) AS float)) END +
	CASE WHEN T22_Eval IS NULL OR T22_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T22_Eval LIKE '#+%' THEN 100.00 WHEN T22_Eval LIKE '#-%' THEN -100.00 ELSE T22_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T22_Eval LIKE '#+%' THEN 100.00 WHEN T22_Eval LIKE '#-%' THEN -100.00 ELSE T22_Eval END) AS float)) END +
	CASE WHEN T23_Eval IS NULL OR T23_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T23_Eval LIKE '#+%' THEN 100.00 WHEN T23_Eval LIKE '#-%' THEN -100.00 ELSE T23_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T23_Eval LIKE '#+%' THEN 100.00 WHEN T23_Eval LIKE '#-%' THEN -100.00 ELSE T23_Eval END) AS float)) END +
	CASE WHEN T24_Eval IS NULL OR T24_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T24_Eval LIKE '#+%' THEN 100.00 WHEN T24_Eval LIKE '#-%' THEN -100.00 ELSE T24_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T24_Eval LIKE '#+%' THEN 100.00 WHEN T24_Eval LIKE '#-%' THEN -100.00 ELSE T24_Eval END) AS float)) END +
	CASE WHEN T25_Eval IS NULL OR T25_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T25_Eval LIKE '#+%' THEN 100.00 WHEN T25_Eval LIKE '#-%' THEN -100.00 ELSE T25_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T25_Eval LIKE '#+%' THEN 100.00 WHEN T25_Eval LIKE '#-%' THEN -100.00 ELSE T25_Eval END) AS float)) END +
	CASE WHEN T26_Eval IS NULL OR T26_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T26_Eval LIKE '#+%' THEN 100.00 WHEN T26_Eval LIKE '#-%' THEN -100.00 ELSE T26_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T26_Eval LIKE '#+%' THEN 100.00 WHEN T26_Eval LIKE '#-%' THEN -100.00 ELSE T26_Eval END) AS float)) END +
	CASE WHEN T27_Eval IS NULL OR T27_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T27_Eval LIKE '#+%' THEN 100.00 WHEN T27_Eval LIKE '#-%' THEN -100.00 ELSE T27_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T27_Eval LIKE '#+%' THEN 100.00 WHEN T27_Eval LIKE '#-%' THEN -100.00 ELSE T27_Eval END) AS float)) END +
	CASE WHEN T28_Eval IS NULL OR T28_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T28_Eval LIKE '#+%' THEN 100.00 WHEN T28_Eval LIKE '#-%' THEN -100.00 ELSE T28_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T28_Eval LIKE '#+%' THEN 100.00 WHEN T28_Eval LIKE '#-%' THEN -100.00 ELSE T28_Eval END) AS float)) END +
	CASE WHEN T29_Eval IS NULL OR T29_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T29_Eval LIKE '#+%' THEN 100.00 WHEN T29_Eval LIKE '#-%' THEN -100.00 ELSE T29_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T29_Eval LIKE '#+%' THEN 100.00 WHEN T29_Eval LIKE '#-%' THEN -100.00 ELSE T29_Eval END) AS float)) END +
	CASE WHEN T30_Eval IS NULL OR T30_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T30_Eval LIKE '#+%' THEN 100.00 WHEN T30_Eval LIKE '#-%' THEN -100.00 ELSE T30_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T30_Eval LIKE '#+%' THEN 100.00 WHEN T30_Eval LIKE '#-%' THEN -100.00 ELSE T30_Eval END) AS float)) END +
	CASE WHEN T31_Eval IS NULL OR T31_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T31_Eval LIKE '#+%' THEN 100.00 WHEN T31_Eval LIKE '#-%' THEN -100.00 ELSE T31_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T31_Eval LIKE '#+%' THEN 100.00 WHEN T31_Eval LIKE '#-%' THEN -100.00 ELSE T31_Eval END) AS float)) END +
	CASE WHEN T32_Eval IS NULL OR T32_Eval LIKE '#%' OR ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T32_Eval LIKE '#+%' THEN 100.00 WHEN T32_Eval LIKE '#-%' THEN -100.00 ELSE T32_Eval END) AS float)) > @acpl_window THEN 0 ELSE ABS(CAST((CASE WHEN T1_Eval LIKE '#+%' THEN 100.00 WHEN T1_Eval LIKE '#-%' THEN -100.00 ELSE T1_Eval END) AS float) - CAST((CASE WHEN T32_Eval LIKE '#+%' THEN 100.00 WHEN T32_Eval LIKE '#-%' THEN -100.00 ELSE T32_Eval END) AS float)) END)/CandidateMoves END AS AvgCandErr

	FROM OnlineMoves

	WHERE TotalMoves IS NULL
) ae ON em.MoveID = ae.MoveID
GO
