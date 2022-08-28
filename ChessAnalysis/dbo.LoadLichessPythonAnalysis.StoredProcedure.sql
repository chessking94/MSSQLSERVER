USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadLichessPythonAnalysis]

AS

TRUNCATE TABLE tempAnalysisFolder
TRUNCATE TABLE tempAnalysisContents

DECLARE @Cmd varchar(200)

SET @Cmd = 'DIR "C:\FileProcessing\Import\"'

INSERT INTO tempAnalysisFolder
EXEC master..xp_cmdshell @Cmd
	
DECLARE vfiles CURSOR FOR 
	SELECT LTRIM(RTRIM(SUBSTRING(oneline, 40, 1000))) AS filename FROM tempAnalysisFolder WHERE RIGHT(RTRIM(oneline), 4) = '.txt'

DECLARE @vfilename varchar(100)
DECLARE @command varchar(1000)
DECLARE @ctr int

OPEN vfiles
FETCH NEXT FROM vfiles INTO @vfilename
WHILE @@FETCH_STATUS = 0
BEGIN
	TRUNCATE TABLE tempAnalysisContentsPK
	SET @command = 'BULK INSERT vwtempAnalysisContentsPK FROM ''C:\FileProcessing\Import\' + @vFileName + ''' WITH (ROWTERMINATOR = ''\n'')'
	EXECUTE (@command)

	SET @ctr = (SELECT MAX(ID) FROM tempAnalysisContentsPK)

	--Record01 (game data)
	INSERT INTO LichessGames (
		GameID,
		White,
		WhiteElo,
		Black,
		BlackElo,
		ECO,
		UTCDate,
		UTCTime,
		Event,
		Result,
		TimeControl,
		Termination,
		WhiteRatingDiff,
		BlackRatingDiff,
		WhiteTitle,
		BlackTitle
	)

	SELECT
	NULLIF(RTRIM(SUBSTRING(py.oneline, 3, 20)), '') AS GameID,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 23, 30)), '') AS White,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 53, 4)), '') AS WhiteElo,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 57, 30)), '') AS Black,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 87, 4)), '') AS BlackElo,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 91, 3)), '') AS ECO,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 94, 10)), '') AS UTCDate,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 104, 8)), '') AS UTCTime,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 112, 100)), '') AS Event,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 212, 3)), '') AS Result,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 215, 15)), '') AS TimeControl,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 230, 20)), '') AS Termination,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 250, 5)), '') AS WhiteRatingDiff,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 255, 5)), '') AS BlackRatingDiff,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 260, 3)), '') AS WhiteTitle,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 263, 3)), '') AS BlackTitle

	FROM tempAnalysisContentsPK py
	WHERE LEFT(py.oneline,2) = '01'

	ORDER BY py.ID

	EXEC InsertNewTimeControls

	--Record02 (game moves)
	INSERT INTO LichessMoves (
		GameID,
		MoveNumber,
		Color,
		IsTheory,
		IsTablebase,
		FEN,
 		Move,
		T1,
		T2,
		T3,
		T4,
		T5,
		Move_Eval,
		T1_Eval,
		T2_Eval,
		T3_Eval,
		T4_Eval,
		T5_Eval,
		CP_Loss,
		Engine,
		Depth,
		Clock,
		PGN_Eval,
		PhaseID,
		TimeSpent
	)

	SELECT
	NULLIF(RTRIM(SUBSTRING(py.oneline, 3, 20)), '') AS GameID,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 23, 3)), '') AS MoveNumber,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 26, 5)), '') AS Color,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 31, 1)), '') AS IsTheory,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 32, 1)), '') AS IsTablebase,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 33, 92)), '') AS FEN,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 125, 10)), '') AS Move,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 135, 10)), '') AS T1,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 145, 10)), '') AS T2,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 155, 10)), '') AS T3,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 165, 10)), '') AS T4,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 175, 10)), '') AS T5,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 185, 7)), '') AS Move_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 192, 7)), '') AS T1_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 199, 7)), '') AS T2_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 206, 7)), '') AS T3_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 213, 7)), '') AS T4_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 220, 7)), '') AS T5_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 227, 7)), '') AS CP_Loss,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 234, 25)), '') AS Engine,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 259, 2)), '') AS Depth,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 261, 7)), '') AS Clock,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 268, 7)), '') AS PGN_Eval,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 275, 1)), '') AS PhaseID,
	NULLIF(RTRIM(SUBSTRING(py.oneline, 276, 7)), '') AS TimeSpent

	FROM tempAnalysisContentsPK py
	WHERE LEFT(py.oneline,2) = '02'

	ORDER BY py.ID

	--move_rank
	UPDATE LichessMoves
	SET Move_Rank = (
		CASE
			WHEN Move_Eval = T1_Eval THEN 1
			WHEN Move_Eval = T2_Eval THEN 2
			WHEN Move_Eval = T3_Eval THEN 3
			WHEN Move_Eval = T4_Eval THEN 4
			WHEN Move_Eval = T5_Eval THEN 5
			ELSE 6
		END
	)
	WHERE Move_Rank IS NULL


	SET @command = 'MOVE "C:\FileProcessing\Import\' + @vFileName + '" "' + 'C:\FileProcessing\Import\Archive\' + @vFileName + '"'
    EXEC master..xp_cmdshell @command

	--add data to file import log
	INSERT INTO FileImportLog (FileTypeID, Filename, DateImported, RowsImported)
	VALUES ('6', @vfilename, GETDATE(), @ctr)

	FETCH NEXT FROM vfiles INTO @vfilename
END
CLOSE vfiles
DEALLOCATE vfiles
GO
