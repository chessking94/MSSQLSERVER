USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DupCheckStagedGames]

AS

/*
	Duplicate critera:
	Same source ID
	Same first and last names for White
	Same first and last names for Black
	Same game date
	Same event name
	Same round number
*/

UPDATE stg
SET stg.Errors = ISNULL(stg.Errors + '|', '') + 'Dup_' + CONVERT(varchar(10), g.GameID)
FROM lake.Games g
JOIN dim.Players w ON
	g.SourceID = w.SourceID AND
	g.WhitePlayerID = w.PlayerID
JOIN dim.Players b ON
	g.SourceID = b.SourceID AND
	g.BlackPlayerID = b.PlayerID
JOIN dim.Events e ON
	g.SourceID = e.SourceID AND
	g.EventID = e.EventID
JOIN stage.Games stg ON
	g.SourceID = stg.SourceName AND
	w.LastName = stg.WhiteLast AND
	ISNULL(w.FirstName, '') = ISNULL(stg.WhiteFirst, '') AND
	b.LastName = stg.BlackLast AND
	ISNULL(B.FirstName, '') = ISNULL(stg.BlackFirst, '') AND
	g.GameDate = stg.GameDate AND
	e.EventName = stg.EventName AND
	g.RoundNum = stg.RoundNum
GO
