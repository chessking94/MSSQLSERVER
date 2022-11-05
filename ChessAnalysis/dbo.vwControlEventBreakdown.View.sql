USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwControlEventBreakdown]

AS

SELECT
GameID,
'White' AS Color,
WhiteLast AS LastName,
WhiteFirst AS FirstName,
WhiteElo AS Elo,
BlackLast AS OppLastName,
BlackFirst AS OppFirstName,
BlackElo AS OppElo,
ECO,
GameDate,
Tournament,
RoundNum,
Result AS ColorResult,
CASE WHEN CorrFlag = 1 THEN 'Correspondence' ELSE 'Classical' END AS TimeControlType

FROM ControlGames

UNION

SELECT
GameID,
'Black' AS Color,
BlackLast AS LastName,
BlackFirst AS FirstName,
BlackElo AS Elo,
WhiteLast AS OppLastName,
WhiteFirst AS OppFirstName,
WhiteElo AS OppElo,
ECO,
GameDate,
Tournament,
RoundNum,
CASE WHEN Result = 0.5 THEN Result ELSE 1 - Result END AS ColorResult,
CASE WHEN CorrFlag = 1 THEN 'Correspondence' ELSE 'Classical' END AS TimeControlType

FROM ControlGames
GO
