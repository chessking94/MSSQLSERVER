﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwEEHTop10]

AS

SELECT
GameID,
Color,
1.00*SUM(CASE WHEN Move_Rank <= 1 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T1,
1.00*SUM(CASE WHEN Move_Rank <= 2 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T2,
1.00*SUM(CASE WHEN Move_Rank <= 3 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T3,
1.00*SUM(CASE WHEN Move_Rank <= 4 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T4,
1.00*SUM(CASE WHEN Move_Rank <= 5 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T5,
1.00*SUM(CASE WHEN Move_Rank <= 6 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T6,
1.00*SUM(CASE WHEN Move_Rank <= 7 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T7,
1.00*SUM(CASE WHEN Move_Rank <= 8 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T8,
1.00*SUM(CASE WHEN Move_Rank <= 9 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T9,
1.00*SUM(CASE WHEN Move_Rank <= 10 THEN 1 ELSE 0 END)/COUNT(MoveID) AS T10

FROM EEHMoves

WHERE IsTheory = 0
AND CP_Loss IS NOT NULL

GROUP BY
GameID,
Color
GO