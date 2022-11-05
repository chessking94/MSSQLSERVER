USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateMoveScores] (@fileid int)

AS

UPDATE m
SET m.MoveScored = 1
FROM lake.Moves m
JOIN lake.Games g ON
	m.GameID = g.GameID
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID

WHERE fh.FileID = @fileid
AND m.IsTheory = 0
AND m.IsTablebase = 0
AND m.CP_Loss IS NOT NULL
AND m.T1_Eval_POV IS NOT NULL
AND m.Move_Eval_POV IS NOT NULL
AND ABS(m.T1_Eval_POV) < dbo.GetSettingValue('Max Eval')
AND ABS(m.Move_Eval_POV) < dbo.GetSettingValue('Max Eval')


UPDATE m
SET m.Score = CAST(t1.PDF * CAST(POWER(t1.CDF - mp.CDF - 1, 4) AS decimal(10,9)) AS decimal(10,9)),
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
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID

WHERE fh.FileID = @fileid
AND m.MoveScored = 1
GO
