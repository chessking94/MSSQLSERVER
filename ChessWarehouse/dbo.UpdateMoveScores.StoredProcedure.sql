USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateMoveScores] (@fileid int)

AS

;WITH cte AS (
	SELECT
	m.GameID,
	m.MoveNumber,
	m.ColorID,
	ROW_NUMBER() OVER (PARTITION BY m.GameID, m.ColorID, LEFT(m.FEN, CHARINDEX(' ', m.FEN) - 1) ORDER BY m.MoveNumber) AS Position_Count

	FROM lake.Moves m
	JOIN lake.Games g ON
		m.GameID = g.GameID
	LEFT JOIN FileHistory fh ON
		g.FileID = fh.FileID

	WHERE fh.FileID = @fileid
)

UPDATE m
SET m.TraceKey = (
	CASE
		WHEN m.IsTheory = 1 THEN 'b'
		WHEN m.IsTablebase = 1 THEN 't'
		WHEN (m.T1_Eval_POV IS NULL OR ABS(m.T1_Eval_POV) > CAST(s.Value AS decimal(5,2))) OR (m.Move_Eval_POV IS NULL OR ABS(m.Move_Eval_POV) > CAST(s.Value AS decimal(5,2))) THEN 'e'
		WHEN cte.Position_Count > 1 THEN 'r'
		WHEN m.T2_Eval IS NULL OR ABS(CAST(m.T1_Eval AS decimal(5,2)) - (CASE WHEN LEFT(m.T2_Eval, 1) = '#' THEN 100 ELSE CAST(m.T2_Eval AS decimal(5,2)) END)) > 2.00 THEN 'f'
		WHEN m.Move_Rank = 1 THEN 'M'
		ELSE '0'
	END
)

FROM lake.Moves m
JOIN lake.Games g ON
	m.GameID = g.GameID
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID
JOIN dim.Colors c ON
    m.ColorID = c.ColorID
CROSS JOIN Settings s
JOIN cte ON
	m.GameID = cte.GameID AND
	m.MoveNumber = cte.MoveNumber AND
	m.ColorID = cte.ColorID

WHERE s.ID = 3
AND fh.FileID = @fileid


UPDATE m
SET m.MoveScored = 1

FROM lake.Moves m
JOIN dim.Traces t ON
	m.TraceKey = t.TraceKey
JOIN lake.Games g ON
	m.GameID = g.GameID
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID

WHERE t.Scored = 1
AND fh.FileID = @fileid

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
LEFT JOIN FileHistory fh ON
	g.FileID = fh.FileID

WHERE m.MoveScored = 1
AND fh.FileID = @fileid

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
AND fh.FileID = @fileid
AND t1.SourceID = dbo.GetSettingValue('ScoreEqual Source')
AND t1.TimeControlID = dbo.GetSettingValue('ScoreEqual Time Control')
GO
