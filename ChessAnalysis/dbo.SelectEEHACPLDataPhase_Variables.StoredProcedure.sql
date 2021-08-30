USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectEEHACPLDataPhase_Variables] (@OppLastName varchar(50), @OppFirstName varchar(30), @MinOppRating int, @MaxOppRating int, @MinDate datetime, @MaxDate datetime, @ECO varchar(3), @Tmnt varchar(100))

AS

--VARIABLE VALIDATION
----Names
IF ((@OppLastName IS NOT NULL AND @OppFirstName IS NULL) OR (@OppLastName IS NULL AND @OppFirstName IS NOT NULL))
BEGIN
	SET @OppLastName = NULL
	SET @OppFirstName = NULL
END

----Ratings
IF (@MinOppRating IS NOT NULL AND @MaxOppRating IS NULL)
BEGIN
	SET @MaxOppRating = 9999
END

IF (@MinOppRating IS NULL AND @MaxOppRating IS NOT NULL)
BEGIN
	SET @MinOppRating = 0
END

IF @MinOppRating > @MaxOppRating
BEGIN
	SET @MinOppRating = NULL
	SET @MaxOppRating = NULL
END

IF @MinOppRating < 0
BEGIN
	SET @MinOppRating = 0
END

----Dates
IF (@MinDate IS NOT NULL AND @MaxDate IS NULL)
BEGIN
	SET @MaxDate = CONVERT(datetime, CONVERT(date, GETDATE()))
END

IF (@MinDate IS NULL AND @MaxDate IS NOT NULL)
BEGIN
	SET @MinDate = '1900-01-01'
END

IF @MinDate > @MaxDate
BEGIN
	SET @MinDate = NULL
	SET @MaxDate = NULL
END

----ECO
IF @ECO NOT LIKE '[A-F][0-9][0-9]' --sql server regex to the rescue!
BEGIN
	SET @ECO = NULL
END

----Tournament
IF @Tmnt NOT IN (SELECT DISTINCT Tournament FROM EEHGames)
BEGIN
	SET @Tmnt = NULL
END


SELECT
m.PhaseID,
COUNT(m.MoveID) AS 'MoveCount',
ROUND(AVG(CONVERT(float, m.CP_Loss)), 2) AS ACPL,
ROUND(ISNULL(STDEV(CONVERT(float, m.CP_Loss)), 0), 4) AS SDCPL

FROM EEHMoves m
JOIN EEHGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteLast, '') ELSE ISNULL(g.BlackLast, '') END) = 'Hunt'
AND (CASE WHEN m.Color = 'White' THEN ISNULL(g.WhiteFirst, '') ELSE ISNULL(g.BlackFirst, '') END) = 'Ethan'
--various parameter checks
AND ((CASE WHEN m.Color = 'White' THEN ISNULL(g.BlackLast, '') ELSE ISNULL(g.WhiteLast, '') END) = @OppLastName OR ISNULL(@OppLastName, 'TEST1') = 'TEST1')
AND ((CASE WHEN m.Color = 'White' THEN ISNULL(g.BlackFirst, '') ELSE ISNULL(g.WhiteFirst, '') END) = @OppFirstName OR ISNULL(@OppFirstName, 'TEST1') = 'TEST1')
AND ((CASE WHEN dbo.DetermineEEHColor(g.GameID, 'Hunt', 'Ethan') = 'White' THEN g.BlackElo ELSE g.WhiteElo END) >= @MinOppRating OR ISNULL(@MinOppRating, 9999) = 9999)
AND ((CASE WHEN dbo.DetermineEEHColor(g.GameID, 'Hunt', 'Ethan') = 'White' THEN g.BlackElo ELSE g.WhiteElo END) <= @MaxOppRating OR ISNULL(@MaxOppRating, 9999) = 9999)
AND (g.GameDate >= @MinDate OR ISNULL(@MinDate, '1900-01-01') = '1900-01-01')
AND (g.GameDate <= @MaxDate OR ISNULL(@MaxDate, '1900-01-01') = '1900-01-01')
AND (g.ECO = @ECO OR ISNULL(@ECO, 'XXX') = 'XXX')
AND (g.Tournament = @Tmnt OR ISNULL(@Tmnt, 'XXX') = 'XXX')

GROUP BY
m.PhaseID

ORDER BY
m.PhaseID
GO
