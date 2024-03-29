﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectTestingACPLDataComplete_LastFirst] (@LastName varchar(50), @FirstName varchar(30))

AS

SELECT
COUNT(m.MoveID) AS 'MoveCount',
ROUND(AVG(CONVERT(float, m.CP_Loss)), 2) AS ACPL,
ROUND(ISNULL(STDEV(CONVERT(float, m.CP_Loss)), 0), 4) AS SDCPL

FROM CheatTestMoves m
JOIN CheatTestGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE m.IsTheory = 0
AND m.CP_Loss IS NOT NULL
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteLast, '') ELSE ISNULL(g.BlackLast, '') END) = @LastName
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteFirst, '') ELSE ISNULL(g.BlackFirst, '') END) = ISNULL(@FirstName, '')
GO
