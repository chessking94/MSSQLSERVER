﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCheatTestSDCPL]

AS

SELECT
m.GameID,
m.Color,
ROUND(STDEV(CONVERT(float, m.CP_Loss)), 2) AS SDCPL
		
FROM CheatTestMoves m
		
WHERE m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'
AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max Eval') AS float)
AND ABS(CONVERT(float, m.Move_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max Eval') AS float)
AND m.CP_Loss IS NOT NULL

GROUP BY
m.GameID,
m.Color
GO
