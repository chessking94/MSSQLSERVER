USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwEEHACPL]

AS

SELECT
m.GameID,
m.Color,
AVG(CONVERT(float, m.CP_Loss)) AS ACPL
		
FROM EEHMoves m
		
WHERE m.IsTheory = 0
AND m.CP_Loss IS NOT NULL
AND ISNUMERIC(m.T1_Eval) = 1
AND ISNUMERIC(m.Move_Eval) = 1
AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)
AND ABS(CONVERT(float, m.Move_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

GROUP BY
m.GameID,
m.Color
GO
