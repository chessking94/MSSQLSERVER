USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwOnlineMoveScores]

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
END AS Score1,
CASE WHEN m.IsTheory + m.IsTablebase = 0 THEN ed2.PDF ELSE 0 END AS MaxScore,
--POWER((CASE WHEN m.Color = 'Black' THEN 1 - ed2.CDF ELSE ed2.CDF END) - (CASE WHEN m.Color = 'Black' THEN 1 - ed1.CDF ELSE ed1.CDF END) - 1, 4) AS LossWeight,
CAST((CASE WHEN m.IsTheory + m.IsTablebase = 0 THEN ed2.PDF ELSE 0 END) * CAST(POWER((CASE WHEN m.Color = 'Black' THEN 1 - ed2.CDF ELSE ed2.CDF END) - (CASE WHEN m.Color = 'Black' THEN 1 - ed1.CDF ELSE ed1.CDF END) - 1, 4) AS decimal(10,9)) AS decimal(10,9)) AS Score
--double-cast in Score_2 is required to maintain the same precision

FROM OnlineMoves m
JOIN OnlineGames g ON m.GameID = g.GameID
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
JOIN GamePhaseWeights gp ON m.PhaseID = gp.PhaseID AND gp.Source = 'Online' AND gp.TimeControlType = tc.TimeControlType
JOIN ScoreReference s ON eg2.GroupID = s.BestEvalGroup AND eg1.GroupID = s.PlayedEvalGroup AND acpl.ACPL_Group = s.ACPL_Group
JOIN EvalDistributions ed1 ON
	(CASE WHEN m.Move_Eval LIKE '%#+%' THEN 100 WHEN m.Move_Eval LIKE '%#-%' THEN -100 ELSE CONVERT(decimal(5,2), m.Move_Eval) END) = ed1.Eval
	AND ed1.Source = 'Control'
	AND ed1.TimeControlType = 'Classical'
JOIN EvalDistributions ed2 ON
	(CASE WHEN m.T1_Eval LIKE '%#+%' THEN 100 WHEN m.T1_Eval LIKE '%#-%' THEN -100 ELSE CONVERT(decimal(5,2), m.T1_Eval) END) = ed2.Eval
	AND ed2.Source = 'Control'
	AND ed2.TimeControlType = 'Classical'
GO
