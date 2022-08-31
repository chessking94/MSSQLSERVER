USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLichessEvalSummary]

AS

SELECT
m.MoveID,
e.GroupID,
m.Color,
r.LBound AS RatingGroup,
CONVERT(float, m.CP_Loss) AS ACPL,
CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END AS T1,
CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END AS T2,
CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END AS T3,
CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END AS T4,
CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END AS T5,
v.Score AS PointsGained,
gp.ScoreWeight*s.Points AS TotalPoints

FROM LichessMoves m
JOIN LichessGames g ON m.GameID = g.GameID
JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
JOIN vwLichessMoveScores v ON m.MoveID = v.MoveID
JOIN GamePhaseWeights gp ON m.PhaseID = gp.PhaseID AND gp.Source = 'Lichess' AND gp.TimeControlType = tc.TimeControlType
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
JOIN EvaluationGroups e ON m.T1_Eval >= e.LBound AND m.T1_Eval <= e.UBound
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE m.IsTheory = 0
AND m.IsTablebase = 0
AND m.CP_Loss IS NOT NULL
AND ISNUMERIC(m.T1_Eval) = 1
AND ISNUMERIC(m.Move_Eval) = 1
AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)
AND ABS(CONVERT(float, m.Move_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)
GO
