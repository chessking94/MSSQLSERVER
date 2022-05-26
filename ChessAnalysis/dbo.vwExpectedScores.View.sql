USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwExpectedScores] AS

SELECT
r.RatingGroup AS Rating_Group,
r.ID AS Rating_Group_ID,
e.Range AS Eval_Group,
e.ID AS Eval_Group_ID,
m.Color,
m.CandidateMoves,
COUNT(m.MoveID) AS Number,
ROUND(AVG(CONVERT(float, m.CP_Loss)), 2) AS ACPL,
ROUND(ISNULL(STDEV(CONVERT(float, m.CP_Loss)), 0), 4) AS SDCPL,
ROUND(AVG(CONVERT(float, m.AVGCandidateError)), 2) AS CandidateACPL,
ROUND(AVG(CONVERT(float, m.StDevCandidate)), 4) AS CandidateSD

FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound
JOIN Evaluation_Bins e ON m.T1_Eval >= e.LBound AND m.T1_Eval <= e.UBound

where g.CorrFlag = 0
AND m.IsTheory = 0
AND m.CP_Loss IS NOT NULL

GROUP BY
r.RatingGroup,
r.ID,
e.Range,
e.ID,
m.Color,
m.CandidateMoves

GO
