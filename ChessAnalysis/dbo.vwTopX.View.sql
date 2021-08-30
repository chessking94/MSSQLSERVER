USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwTopX] AS

SELECT
r.RatingGroup,
r.ID AS RatingGroupID,
m.Color,
COUNT(DISTINCT g.GameID) AS Number,
1.00*SUM(CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top1,
1.00*SUM(CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top2,
1.00*SUM(CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top3,
1.00*SUM(CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top4,
1.00*SUM(CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top5,
1.00*SUM(CASE WHEN m.Move_Rank <= 6 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top6,
1.00*SUM(CASE WHEN m.Move_Rank <= 7 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top7,
1.00*SUM(CASE WHEN m.Move_Rank <= 8 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top8,
1.00*SUM(CASE WHEN m.Move_Rank <= 9 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top9,
1.00*SUM(CASE WHEN m.Move_Rank <= 10 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS Top10

FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE g.CorrFlag = 0
AND m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'

GROUP BY
m.Color,
r.RatingGroup,
r.ID
GO
