USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [lake].[vwEvaluationSummary]

AS

SELECT
s.SourceID,
m.ColorID,
tc.TimeControlID,
r.RatingID,
eg.EvaluationGroupID,
CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END AS T1,
CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END AS T2,
CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END AS T3,
CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END AS T4,
CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END AS T5,
m.CP_Loss AS ACPL,
m.ScACPL,
m.Score,
m.MaxScore

FROM lake.Moves m
JOIN lake.Games g ON
	m.GameID = g.GameID
JOIN dim.Sources s ON
	g.SourceID = s.SourceID
JOIN dim.TimeControlDetail td ON
	g.TimeControlDetailID = td.TimeControlDetailID
JOIN dim.TimeControls tc ON
	td.TimeControlID = tc.TimeControlID
JOIN dim.Colors c ON m.ColorID = c.ColorID
JOIN dim.Ratings r ON
	(CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.RatingID AND
	(CASE WHEN c.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.RatingUpperBound
JOIN dim.EvaluationGroups eg ON
	m.T1_Eval_POV >= eg.LBound AND
	m.T1_Eval_POV <= eg.UBound

WHERE m.MoveScored = 1
GO
