USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwGameScores]

AS

SELECT
g.GameID,
g.WhiteLast,
g.WhiteFirst,
g.WhiteElo,
g.BlackLast,
g.BlackFirst,
g.BlackElo,
g.ECO,
g.GameDate,
g.Tournament,
g.RoundNum,
g.Result,
g.Moves,
ISNULL(b.Book_Moves, 0) AS 'Book_Moves',
ISNULL(tb.TB_Moves, 0) AS 'Tablebase_Moves',
ROUND(sw.Score*100, 2) AS 'White_Score',
ROUND(sb.Score*100, 2) AS 'Black_Score'

FROM ControlGames g
LEFT JOIN (SELECT GameID, MAX(MoveNumber) AS 'Book_Moves' FROM ControlMoves WHERE IsTheory = 1 GROUP BY GameID) b ON g.GameID = b.GameID
LEFT JOIN (SELECT GameID, MAX(MoveNumber) - MIN(MoveNumber) + 1 AS 'TB_Moves' FROM ControlMoves WHERE IsTablebase = 1 GROUP BY GameID) tb ON g.GameID = tb.GameID
LEFT JOIN (
	SELECT
	v.GameID,
	SUM(v.Score)/SUM(gp.ScoreWeight*s.Points) AS Score
	FROM vwControlMoveScores v
	JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
	JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
	JOIN ControlMoves m ON v.MoveID = m.MoveID
	WHERE v.color = 'White'
	GROUP BY v.GameID
) sw ON g.GameID = sw.GameID
LEFT JOIN (
	SELECT
	v.GameID,
	SUM(v.Score)/SUM(gp.ScoreWeight*s.Points) AS Score
	FROM vwControlMoveScores v
	JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
	JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
	JOIN ControlMoves m ON v.MoveID = m.MoveID
	WHERE v.color = 'Black'
	GROUP BY v.GameID
) sb ON g.GameID = sb.GameID

GO
