﻿USE [ChessWarehouse]
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

--MovesAnalyzed
UPDATE m
SET m.MovesAnalyzed = (
	CASE
		WHEN m.T2_Eval IS NULL THEN 1
		WHEN m.T3_Eval IS NULL THEN 2
		WHEN m.T4_Eval IS NULL THEN 3
		WHEN m.T5_Eval IS NULL THEN 4
		WHEN m.T6_Eval IS NULL THEN 5
		WHEN m.T7_Eval IS NULL THEN 6
		WHEN m.T8_Eval IS NULL THEN 7
		WHEN m.T9_Eval IS NULL THEN 8
		WHEN m.T10_Eval IS NULL THEN 9
		WHEN m.T11_Eval IS NULL THEN 10
		WHEN m.T12_Eval IS NULL THEN 11
		WHEN m.T13_Eval IS NULL THEN 12
		WHEN m.T14_Eval IS NULL THEN 13
		WHEN m.T15_Eval IS NULL THEN 14
		WHEN m.T16_Eval IS NULL THEN 15
		WHEN m.T17_Eval IS NULL THEN 16
		WHEN m.T18_Eval IS NULL THEN 17
		WHEN m.T19_Eval IS NULL THEN 18
		WHEN m.T20_Eval IS NULL THEN 19
		WHEN m.T21_Eval IS NULL THEN 20
		WHEN m.T22_Eval IS NULL THEN 21
		WHEN m.T23_Eval IS NULL THEN 22
		WHEN m.T24_Eval IS NULL THEN 23
		WHEN m.T25_Eval IS NULL THEN 24
		WHEN m.T26_Eval IS NULL THEN 25
		WHEN m.T27_Eval IS NULL THEN 26
		WHEN m.T28_Eval IS NULL THEN 27
		WHEN m.T29_Eval IS NULL THEN 28
		WHEN m.T30_Eval IS NULL THEN 29
		WHEN m.T31_Eval IS NULL THEN 30
		WHEN m.T32_Eval IS NULL THEN 31
		ELSE 32
	END
)

FROM lake.Moves m
JOIN lake.Games g ON m.GameID = g.GameID
LEFT JOIN FileHistory fh ON g.FileID = fh.FileID

WHERE fh.FileID = @fileid
GO
