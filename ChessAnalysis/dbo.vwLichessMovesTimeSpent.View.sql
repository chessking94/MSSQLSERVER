USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwLichessMovesTimeSpent]

AS

SELECT
m.MoveID,
g.GameID,
tc.TimeControl,
tc.Seconds,
tc.Increment,
m.MoveNumber,
m.Color,
m.Clock,
CASE
	WHEN (LAG(m.Clock, 1) OVER (PARTITION BY g.GameID, m.Color ORDER BY m.MoveNumber) - m.Clock + tc.Increment) >= 0 THEN (LAG(m.Clock, 1) OVER (PARTITION BY g.GameID, m.Color ORDER BY m.MoveNumber) - m.Clock + tc.Increment)
	ELSE 0
END AS TimeSpent
FROM LichessMoves m
JOIN LichessGames g ON m.GameID = g.GameID
JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
GO
