USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectTestingTopXDataPhase_LastFirst] (@LastName varchar(50), @FirstName varchar(30))

AS

SELECT
m.GameID,
m.Color,
m.PhaseID,
1.00*SUM(CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T1,
1.00*SUM(CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T2,
1.00*SUM(CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T3,
1.00*SUM(CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T4,
1.00*SUM(CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T5,
1.00*SUM(CASE WHEN m.Move_Rank <= 6 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T6,
1.00*SUM(CASE WHEN m.Move_Rank <= 7 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T7,
1.00*SUM(CASE WHEN m.Move_Rank <= 8 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T8,
1.00*SUM(CASE WHEN m.Move_Rank <= 9 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T9,
1.00*SUM(CASE WHEN m.Move_Rank <= 10 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T10

FROM CheatTestMoves m
JOIN CheatTestGames g ON m.GameID = g.GameID

WHERE g.CorrFlag = 0
AND m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'
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
