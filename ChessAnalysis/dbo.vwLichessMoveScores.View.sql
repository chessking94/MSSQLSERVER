USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLichessMoveScores]

AS

SELECT
m.MoveID,
m.GameID,
m.PhaseID,
m.Color,
m.IsTheory,
m.IsTablebase,
eg2.GroupID AS BestEvalGroup,
eg1.GroupID AS PlayedEvalGroup,
acpl.ACPL_Group,
CASE
	WHEN m.IsTheory = 1 THEN 1 * gp.ScoreWeight * s.Points
	WHEN (m.IsTablebase = 1 AND m.Move = m.T1) THEN 1 * gp.ScoreWeight * s.Points
	WHEN (m.IsTablebase = 1 AND m.Move <> m.T1 AND LEFT(m.T1_Eval, 2) = LEFT(m.Move_Eval, 2)) THEN 0.9 * gp.ScoreWeight * s.Points
	ELSE s.Score * gp.ScoreWeight * s.Points
END AS Score

FROM LichessMoves m
JOIN LichessGames g ON m.GameID = g.GameID
JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
LEFT JOIN ACPL_Ranges acpl ON 
	ABS((CASE WHEN m.T1_Eval LIKE '%#+%' THEN 300 WHEN m.T1_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.T1_Eval) END) - (CASE WHEN m.Move_Eval LIKE '%#+%' THEN 300 WHEN m.Move_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.Move_Eval) END)) >= acpl.LBound AND
	ABS((CASE WHEN m.T1_Eval LIKE '%#+%' THEN 300 WHEN m.T1_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.T1_Eval) END) - (CASE WHEN m.Move_Eval LIKE '%#+%' THEN 300 WHEN m.Move_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.Move_Eval) END)) <= acpl.UBound
LEFT JOIN EvaluationGroups eg1 ON
	(CASE WHEN m.Move_Eval LIKE '%#+%' THEN 300 WHEN m.Move_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.Move_Eval) END) >= eg1.LBound AND
	(CASE WHEN m.Move_Eval LIKE '%#+%' THEN 300 WHEN m.Move_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.Move_Eval) END) <= eg1.UBound
LEFT JOIN EvaluationGroups eg2 ON
	(CASE WHEN m.T1_Eval LIKE '%#+%' THEN 300 WHEN m.T1_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.T1_Eval) END) >= eg2.LBound AND
	(CASE WHEN m.T1_Eval LIKE '%#+%' THEN 300 WHEN m.T1_Eval LIKE '%#-%' THEN -300 ELSE CONVERT(decimal(5,2), m.T1_Eval) END) <= eg2.UBound
JOIN GamePhaseWeights gp ON m.PhaseID = gp.PhaseID AND gp.Source = 'Lichess' AND gp.TimeControlType = tc.TimeControlType
JOIN ScoreReference s ON eg2.GroupID = s.BestEvalGroup AND eg1.GroupID = s.PlayedEvalGroup AND acpl.ACPL_Group = s.ACPL_Group
GO
