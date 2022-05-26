USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwCheatTestMovesAnalyzed]

AS

SELECT
pt.GameID,
pt.Color,
pt.[0.00_0.00],
pt.[0.01_0.10],
pt.[0.11_0.25],
pt.[0.26_0.50],
pt.[0.51_1.00],
pt.[1.01_2.00],
pt.[2.01_5.00],
pt.[5.01+]

FROM (
	SELECT
	m.GameID,
	m.Color,
	acpl.ACPL_Range,
	COUNT(m.MoveID) ACPL_Counts
		
	FROM CheatTestMoves m
	JOIN ACPL_Ranges acpl ON m.CP_Loss >= acpl.LBound AND m.CP_Loss <= acpl.UBound
		
	WHERE m.IsTheory = 0
	AND m.CP_Loss IS NOT NULL
	AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max Eval') AS float)
	AND ABS(CONVERT(float, m.Move_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max Eval') AS float)

	GROUP BY
	m.GameID,
	m.Color,
	acpl.ACPL_Range
) m
PIVOT (
	SUM(m.ACPL_Counts)
	FOR m.ACPL_Range IN (
		[0.00_0.00],
		[0.01_0.10],
		[0.11_0.25],
		[0.26_0.50],
		[0.51_1.00],
		[1.01_2.00],
		[2.01_5.00],
		[5.01+]
	)
) AS pt
GO
