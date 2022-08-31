USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLichessData]

AS

SELECT
m.MoveID,
m.MoveNumber,
m.Color,
m.IsTheory,
m.IsTablebase,
gp.PhaseID,
gp.Phase,
CASE WHEN m.T1_Eval LIKE '#+%' THEN 100.00 WHEN m.T1_Eval Like '#-%' THEN -100.00 ELSE m.T1_Eval END AS Eval,
ev.GroupID AS Eval_Group,
ev.Range AS Eval_Range,
CASE
    WHEN m.T1_Eval LIKE '#+%' THEN (CASE WHEN m.Move_Eval LIKE '#+%' THEN 0.00 ELSE 25.00 END)
    WHEN m.T1_Eval LIKE '#-%' THEN (CASE WHEN m.Move_Eval LIKE '#-%' THEN 0.00 ELSE 25.00 END)
    ELSE m.CP_Loss
END AS CP_Loss,
acpl.ACPL_Group,
acpl.ACPL_Range,
m.Move_Rank,
m.Clock,
m.TimeSpent,
CASE WHEN m.Color = 'White' THEN wrat.ID ELSE brat.ID END AS ToMove_RatingID,
CASE WHEN m.Color = 'White' THEN wrat.RatingGroup ELSE brat.RatingGroup END AS ToMove_RatingGroup,
g.GameID,
g.White,
g.Black,
g.WhiteElo,
wrat.ID AS White_RatingID,
wrat.RatingGroup AS White_RatingGroup,
g.BlackElo,
brat.ID AS Black_RatingID,
brat.RatingGroup AS Black_RatingGroup,
g.ECO,
g.UTCDate,
g.UTCTime,
g.Result,
g.Termination,
tc.TimeControl,
tc.TimeControlType

FROM LichessMoves m
LEFT JOIN ACPL_Ranges acpl ON m.CP_Loss >= acpl.LBound AND m.CP_Loss <= acpl.UBound
LEFT JOIN EvaluationGroups ev ON (CASE WHEN m.T1_Eval LIKE '#+%' THEN 100.00 WHEN m.T1_Eval Like '#-%' THEN -100.00 ELSE m.T1_Eval END) >= ev.LBound AND (CASE WHEN m.T1_Eval LIKE '#+%' THEN 100.00 WHEN m.T1_Eval Like '#-%' THEN -100.00 ELSE m.T1_Eval END) <= ev.UBound
JOIN LichessGames g ON m.GameID = g.GameID
JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
JOIN GamePhases gp ON m.PhaseID = gp.PhaseID
JOIN Rating_Bins wrat ON g.WhiteElo >= wrat.LBound AND g.WhiteElo <= wrat.UBound
JOIN Rating_Bins brat ON g.BlackElo >= brat.LBound AND g.BlackElo <= brat.UBound
GO
