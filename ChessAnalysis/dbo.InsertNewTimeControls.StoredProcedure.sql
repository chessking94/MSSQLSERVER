USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNewTimeControls]

AS

DECLARE @new_tc varchar(15)

CREATE TABLE #t (TimeControl varchar(15))

INSERT INTO #t
SELECT DISTINCT
g.TimeControl
FROM LichessGames g
LEFT JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
WHERE tc.TimeControl IS NULL
UNION
SELECT DISTINCT
g.TimeControl
FROM OnlineGames g
LEFT JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
WHERE tc.TimeControl IS NULL

SET @new_tc = (SELECT TOP 1 TimeControl FROM #t)
WHILE @new_tc IS NOT NULL
BEGIN
	INSERT INTO TimeControls (TimeControl) VALUES (@new_tc)

	UPDATE tc
	SET tc.TimeControlType = ISNULL(typ.TimeControlType, 'Correspondence')
	FROM TimeControls tc
	LEFT JOIN TimeControlTypes typ ON (tc.Seconds + tc.Increment) >= typ.MinSeconds AND (tc.Seconds + tc.Increment) <= typ.MaxSeconds
	WHERE tc.TimeControl = @new_tc

	DELETE FROM #t WHERE TimeControl = @new_tc
	SET @new_tc = (SELECT TOP 1 TimeControl FROM #t)
END

DROP TABLE #t
GO
