USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DetermineEEHColor] (@GameID int, @Last varchar(50), @First varchar(30))
RETURNS varchar(5)

AS

BEGIN
	DECLARE @colorresult varchar(5) = NULL

	IF (@Last = (SELECT WhiteLast FROM EEHGames WHERE GameID = @GameID) AND @First = (SELECT WhiteFirst FROM EEHGames WHERE GameID = @GameID))
	BEGIN
		SET @colorresult = 'White'
	END
	ELSE IF (@Last = (SELECT BlackLast FROM EEHGames WHERE GameID = @GameID) AND @First = (SELECT BlackFirst FROM EEHGames WHERE GameID = @GameID))
	BEGIN
		SET @colorresult = 'Black'
	END

	RETURN @colorresult
END
GO
