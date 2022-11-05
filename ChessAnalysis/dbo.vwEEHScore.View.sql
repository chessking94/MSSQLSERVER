USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwEEHScore]

AS

SELECT
v.GameID,
v.Color,
100*SUM(v.Score1)/SUM(gp.ScoreWeight*s.Points) AS Score1,
CASE WHEN ISNULL(100*SUM(v.Score)/NULLIF(SUM(v.MaxScore), 0), 100) > 100 THEN 100 ELSE ISNULL(100*SUM(v.Score)/NULLIF(SUM(v.MaxScore), 0), 100) END AS Score

FROM vwEEHMoveScores v
JOIN EEHMoves m ON v.MoveID = m.MoveID
JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group

WHERE m.IsTheory = 0
AND m.IsTablebase = 0
AND ISNUMERIC(m.T1_Eval) = 1
AND ISNUMERIC(m.Move_Eval) = 1
AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

GROUP BY
v.GameID,
v.Color
GO
