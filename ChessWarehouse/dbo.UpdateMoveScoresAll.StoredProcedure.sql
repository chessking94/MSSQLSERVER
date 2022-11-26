USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMoveScoresAll]

AS

--primary score
UPDATE m
SET m.Score = CAST(t1.PDF * CAST(POWER(t1.CDF - ISNULL(mp.CDF, 0) - 1, 4) AS decimal(10,9)) AS decimal(10,9)),
	m.MaxScore = t1.PDF

FROM lake.Moves m
JOIN lake.Games g ON m.GameID = g.GameID
JOIN dim.TimeControlDetail td ON g.TimeControlDetailID = td.TimeControlDetailID
LEFT JOIN stat.EvalDistributions t1 ON
	g.SourceID = t1.SourceID AND
	td.TimeControlID = t1.TimeControlID AND
	m.T1_Eval_POV = t1.Evaluation
LEFT JOIN stat.EvalDistributions mp ON
	g.SourceID = mp.SourceID AND
	td.TimeControlID = mp.TimeControlID AND
	m.Move_Eval_POV = mp.Evaluation

WHERE m.MoveScored = 1


--related score
UPDATE m
SET m.ScoreEqual = CAST(t1.PDF * CAST(POWER(t1.CDF - ISNULL(mp.CDF, 0) - 1, 4) AS decimal(10,9)) AS decimal(10,9)),
	m.MaxScoreEqual = t1.PDF

FROM lake.Moves m
JOIN lake.Games g ON m.GameID = g.GameID
JOIN dim.TimeControlDetail td ON g.TimeControlDetailID = td.TimeControlDetailID
LEFT JOIN stat.EvalDistributions t1 ON
	m.T1_Eval_POV = t1.Evaluation
LEFT JOIN stat.EvalDistributions mp ON
	t1.SourceID = mp.SourceID AND
	t1.TimeControlID = mp.TimeControlID AND
	m.Move_Eval_POV = mp.Evaluation
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID

WHERE m.MoveScored = 1
AND t1.SourceID = dbo.GetSettingValue('ScoreEqual Source')
AND t1.TimeControlID = dbo.GetSettingValue('ScoreEqual Time Control')
GO
