USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateControlRatings]

AS

--update White ratings
UPDATE g
SET WhiteElo = m.Mx_Elo

FROM ControlGames g
JOIN (
	SELECT
	mx.LastName,
	mx.FirstName,
	mx.Tournament,
	MAX(mx.Mx_Elo) Mx_Elo

	FROM (
		SELECT
		WhiteLast AS LastName,
		WhiteFirst AS FirstName,
		Tournament,
		MAX(WhiteElo) Mx_Elo

		FROM ControlGames

		GROUP BY
		WhiteLast,
		WhiteFirst,
		Tournament

		UNION

		SELECT
		BlackLast AS LastName,
		BlackFirst AS FirstName,
		Tournament,
		MAX(BlackElo) Mx_Elo

		FROM ControlGames

		GROUP BY
		BlackLast,
		BlackFirst,
		Tournament
	) mx

	GROUP BY
	mx.LastName,
	mx.FirstName,
	mx.Tournament
) m ON g.WhiteLast = m.LastName AND g.WhiteFirst = m.FirstName AND g.Tournament = m.Tournament

WHERE g.WhiteElo <> m.Mx_Elo

--update Black ratings
UPDATE g
SET BlackElo = m.Mx_Elo

FROM ControlGames g
JOIN (
	SELECT
	mx.LastName,
	mx.FirstName,
	mx.Tournament,
	MAX(mx.Mx_Elo) Mx_Elo

	FROM (
		SELECT
		WhiteLast AS LastName,
		WhiteFirst AS FirstName,
		Tournament,
		MAX(WhiteElo) Mx_Elo

		FROM ControlGames

		GROUP BY
		WhiteLast,
		WhiteFirst,
		Tournament

		UNION

		SELECT
		BlackLast AS LastName,
		BlackFirst AS FirstName,
		Tournament,
		MAX(BlackElo) Mx_Elo

		FROM ControlGames

		GROUP BY
		BlackLast,
		BlackFirst,
		Tournament
	) mx

	GROUP BY
	mx.LastName,
	mx.FirstName,
	mx.Tournament
) m ON g.BlackLast = m.LastName AND g.BlackFirst = m.FirstName AND g.Tournament = m.Tournament

WHERE g.BlackElo <> m.Mx_Elo
GO
