USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectTestingScoreDataPhase_LastFirst] (@LastName varchar(50), @FirstName varchar(30))

AS

SELECT
m.GameID,
m.Color,
m.PhaseID,
ROUND(100*SUM(v.Score)/SUM(gp.ScoreWeight*s.Points), 2) AS Score

FROM vwCheatTestMoveScores v
JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
JOIN CheatTestMoves m ON v.MoveID = m.MoveID
JOIN CheatTestGames g ON m.GameID = g.GameID

WHERE g.CorrFlag = 0
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteLast, '') ELSE ISNULL(g.BlackLast, '') END) = @LastName
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteFirst, '') ELSE ISNULL(g.BlackFirst, '') END) = @FirstName

GROUP BY
m.GameID,
m.Color,
m.PhaseID

ORDER BY
m.GameID,
m.PhaseID
GO
