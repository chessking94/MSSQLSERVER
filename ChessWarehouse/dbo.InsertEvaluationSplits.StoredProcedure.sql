USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEvaluationSplits]

AS

TRUNCATE TABLE fact.EvaluationSplits

INSERT INTO fact.EvaluationSplits (
	SourceID,
	TimeControlID,
	RatingID,
	EvaluationGroupID_T1,
	EvaluationGroupID_T2,
	EvaluationGroupID_T3,
	EvaluationGroupID_T4,
	EvaluationGroupID_T5,
	MovesAnalyzed,
	ACPL,
	SDCPL,
	ScACPL,
	ScSDCPL,
	T1,
	T2,
	T3,
	T4,
	T5
)

SELECT
g.SourceID,
tc.TimeControlID,
r.RatingID,
eg1.EvaluationGroupID AS EvaluationGroupID_T1,
ISNULL(eg2.EvaluationGroupID, 0) AS EvaluationGroupID_T2,
ISNULL(eg3.EvaluationGroupID, 0) AS EvaluationGroupID_T3,
ISNULL(eg4.EvaluationGroupID, 0) AS EvaluationGroupID_T4,
ISNULL(eg5.EvaluationGroupID, 0) AS EvaluationGroupID_T5,
COUNT(m.MoveNumber) AS MovesAnalyzed,
AVG(CASE when m.CP_Loss = 0 THEN NULL ELSE m.CP_Loss END) AS ACPL,
STDEV(CASE when m.CP_Loss = 0 THEN NULL ELSE m.CP_Loss END) AS SDCPL,
AVG(CASE when m.ScACPL = 0 THEN NULL ELSE m.ScACPL END) AS ScACPL,
STDEV(CASE when m.ScACPL = 0 THEN NULL ELSE m.ScACPL END) AS ScSDCPL,
AVG(CASE WHEN m.Move_Rank <= 1 THEN 1.00 ELSE 0.00 END) AS T1,
AVG(CASE WHEN m.Move_Rank <= 2 THEN 1.00 ELSE 0.00 END) AS T2,
AVG(CASE WHEN m.Move_Rank <= 3 THEN 1.00 ELSE 0.00 END) AS T3,
AVG(CASE WHEN m.Move_Rank <= 4 THEN 1.00 ELSE 0.00 END) AS T4,
AVG(CASE WHEN m.Move_Rank <= 5 THEN 1.00 ELSE 0.00 END) AS T5

FROM lake.Moves m
JOIN lake.Games g ON m.GameID = g.GameID
JOIN dim.Colors c ON m.ColorID = c.ColorID
JOIN dim.TimeControlDetail td ON g.TimeControlDetailID = td.TimeControlDetailID
JOIN dim.TimeControls tc ON td.TimeControlID = tc.TimeControlID
JOIN dim.Ratings r ON
    (CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.RatingID AND
    (CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.RatingUpperBound
JOIN dim.EvaluationGroups eg1 ON
	m.T1_Eval_POV >= eg1.LBound AND
	m.T1_Eval_POV <= eg1.UBound
LEFT JOIN dim.EvaluationGroups eg2 ON
	m.T2_Eval_POV >= eg2.LBound AND
	m.T2_Eval_POV <= eg2.UBound
LEFT JOIN dim.EvaluationGroups eg3 ON
	m.T3_Eval_POV >= eg3.LBound AND
	m.T3_Eval_POV <= eg3.UBound
LEFT JOIN dim.EvaluationGroups eg4 ON
	m.T4_Eval_POV >= eg4.LBound AND
	m.T4_Eval_POV <= eg4.UBound
LEFT JOIN dim.EvaluationGroups eg5 ON
	m.T5_Eval_POV >= eg5.LBound AND
	m.T5_Eval_POV <= eg5.UBound

WHERE g.SourceID IN (3, 4)
AND (CASE WHEN c.Color = 'White' THEN g.WhiteBerserk ELSE g.BlackBerserk END) = 0
AND m.MoveScored = 1

GROUP BY
g.SourceID,
r.RatingID,
tc.TimeControlID,
eg1.EvaluationGroupID,
eg2.EvaluationGroupID,
eg3.EvaluationGroupID,
eg4.EvaluationGroupID,
eg5.EvaluationGroupID
GO
