USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwExpectedScoresRaw] AS

SELECT
m.MoveID,
m.Color,
CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END AS Rating,
m.T1_Eval,
m.CP_Loss,
m.CandidateMoves,
m.AvgCandidateError,
m.StDevCandidate,
r.RatingGroup AS Rating_Group,
e.Range AS Eval_Group

FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound
JOIN Evaluation_Bins e ON m.T1_Eval >= e.LBound AND m.T1_Eval <= e.UBound

WHERE g.CorrFlag = 0
AND m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'

GO
