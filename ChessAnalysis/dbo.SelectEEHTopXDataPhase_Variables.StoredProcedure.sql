USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectEEHTopXDataPhase_Variables] (@OppLastName varchar(50), @OppFirstName varchar(30), @MinOppRating int, @MaxOppRating int, @MinDate datetime, @MaxDate datetime, @ECO varchar(3), @Tmnt varchar(100))

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

FROM EEHMoves m
JOIN EEHGames g ON m.GameID = g.GameID

WHERE g.CorrFlag = 0
AND m.IsTheory = 0
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
m.GameID,
m.Color,
m.PhaseID

ORDER BY
m.GameID,
m.PhaseID
GO
