USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwControlEventSummary]

AS

SELECT
CASE WHEN g.CorrFlag = 1 THEN 'Correspondence' ELSE 'Classical' END AS TimeControlType,
CASE WHEN m.Color = 'White' THEN g.WhiteLast ELSE g.BlackLast END AS LastName,
CASE WHEN m.Color = 'White' THEN g.WhiteFirst ELSE g.BlackFirst END AS FirstName,
r.LBound AS RatingGroup,
g.Tournament,
COUNT(m.MoveID) AS MoveCount,
AVG(CONVERT(float, m.CP_Loss)) AS ACPL,
ISNULL(STDEV(CONVERT(float, m.CP_Loss)), 0) AS SDCPL,
AVG(sc.Scaled_CPLoss) AS Scaled_ACPL,
ISNULL(STDEV(sc.Scaled_CPLoss), 0) AS Scaled_SDCPL,
1.00*SUM(CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T1,
1.00*SUM(CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T2,
1.00*SUM(CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T3,
1.00*SUM(CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T4,
1.00*SUM(CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T5,
--100*SUM(v.Score)/SUM(gp.ScoreWeight*s.Points) AS Score
CASE WHEN ISNULL(100*SUM(v.Score)/NULLIF(SUM(v.MaxScore), 0), 100) > 100 THEN 100 ELSE ISNULL(100*SUM(v.Score)/NULLIF(SUM(v.MaxScore), 0), 100) END AS Score

FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
JOIN vwControlMoveScores v ON m.MoveID = v.MoveID
JOIN GamePhaseWeights gp ON m.PhaseID = gp.PhaseID AND gp.Source = 'Control' AND gp.TimeControlType = (CASE WHEN g.CorrFlag = 1 THEN 'Correspondence' ELSE 'Classical' END)
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound
JOIN vwControlScaledCPLoss sc ON m.MoveID = sc.MoveID

WHERE m.IsTheory = 0
AND m.IsTablebase = 0
AND m.CP_Loss IS NOT NULL
AND ISNUMERIC(m.T1_Eval) = 1
AND ISNUMERIC(m.Move_Eval) = 1
AND ABS(CONVERT(float, m.T1_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)
AND ABS(CONVERT(float, m.Move_Eval)) < CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

GROUP BY
CASE WHEN g.CorrFlag = 1 THEN 'Correspondence' ELSE 'Classical' END,
CASE WHEN m.Color = 'White' THEN g.WhiteLast ELSE g.BlackLast END,
CASE WHEN m.Color = 'White' THEN g.WhiteFirst ELSE g.BlackFirst END,
r.LBound,
g.Tournament
GO
