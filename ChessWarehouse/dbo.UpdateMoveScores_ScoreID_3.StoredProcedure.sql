USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMoveScores_ScoreID_3] (@FileID int = NULL)

AS

UPDATE ms
SET ms.ScoreValue = (
	1 - (
	CASE m.Move_Rank 
		WHEN 1 THEN sp.T1
		WHEN 2 THEN sp.T2
		WHEN 3 THEN sp.T3
		WHEN 4 THEN sp.T4
		WHEN 5 THEN sp.T5
		ELSE 1
	END)
),
	ms.MaxScoreValue = (1 - sp.T1)

FROM stat.MoveScores ms
JOIN lake.Moves m ON
	ms.GameID = m.GameID AND
	ms.MoveNumber = m.MoveNumber AND
	ms.ColorID = m.ColorID
JOIN lake.Games g ON m.GameID = g.GameID
JOIN dim.TimeControlDetail td ON g.TimeControlDetailID = td.TimeControlDetailID
JOIN dim.Colors c ON m.ColorID = c.ColorID
JOIN dim.Ratings r ON
	(CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.RatingID AND
	(CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.RatingUpperBound
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID
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
LEFT JOIN fact.EvaluationSplits sp ON
	g.SourceID = sp.SourceID AND --TODO: Review how this impacts Personal and PersonalOnline
	td.TimeControlID = sp.TimeControlID AND
	r.RatingID = sp.RatingID AND
	eg1.EvaluationGroupID = sp.EvaluationGroupID_T1 AND
	ISNULL(eg2.EvaluationGroupID, 0) = sp.EvaluationGroupID_T2 AND
	ISNULL(eg3.EvaluationGroupID, 0) = sp.EvaluationGroupID_T3 AND
	ISNULL(eg4.EvaluationGroupID, 0) = sp.EvaluationGroupID_T4 AND
	ISNULL(eg5.EvaluationGroupID, 0) = sp.EvaluationGroupID_T5

WHERE m.MoveScored = 1
AND (fh.FileID = @FileID OR ISNULL(@FileID, -1) = -1)
AND ms.ScoreID = 3


GO
