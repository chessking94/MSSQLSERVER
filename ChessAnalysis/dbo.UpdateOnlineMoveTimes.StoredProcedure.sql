USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOnlineMoveTimes]

AS

TRUNCATE TABLE tempAnalysisFolder
TRUNCATE TABLE tempAnalysisContents

DECLARE @Cmd varchar(200)

SET @Cmd = 'DIR "C:\FileProcessing\Import\"'

INSERT INTO tempAnalysisFolder
EXEC master..xp_cmdshell @Cmd
	
DECLARE vfiles CURSOR FOR 
	SELECT LTRIM(RTRIM(SUBSTRING(oneline, 40, 1000))) AS filename 
FROM tempAnalysisFolder WHERE RIGHT(RTRIM(oneline), 4) = '.txt' --must be .txt file

DECLARE @vfilename varchar(100)
DECLARE @command varchar(1000)

OPEN vfiles
FETCH NEXT FROM vfiles INTO @vfilename
WHILE @@FETCH_STATUS = 0 --loop through all files
BEGIN
	TRUNCATE TABLE tempAnalysisContents
	SET @command = 'BULK INSERT tempAnalysisContents FROM ''C:\FileProcessing\Import\' + @vFileName + ''' WITH (ROWTERMINATOR = ''\n'')'
	EXECUTE (@command)

	--SELECT
	--m.MoveID,
	--g.GameID,
	--g.Source,
	--g.SourceID,
	--m.MoveNumber,
	--m.Color,
	--m.Move,
	--NULLIF(RTRIM(SUBSTRING(t.oneline, 51, 7)), '') AS Clock
	UPDATE m
	SET m.Clock = NULLIF(RTRIM(SUBSTRING(t.oneline, 51, 7)), '') 
	FROM OnlineMoves m
	JOIN OnlineGames g ON m.GameID = g.GameID
	JOIN tempAnalysisContents t
		ON g.Source = RTRIM(SUBSTRING(t.oneline, 1, 15))
		AND g.SourceID = RTRIM(SUBSTRING(t.oneline, 16, 20))
		AND m.MoveNumber = RTRIM(SUBSTRING(t.oneline, 36, 3))
		AND m.Color = RTRIM(SUBSTRING(t.oneline, 39, 5))

	SET @command = 'MOVE "C:\FileProcessing\Import\' + @vFileName + '" "' + 'C:\FileProcessing\Import\Archive\' + @vFileName + '"'
    EXEC master..xp_cmdshell @command

	FETCH NEXT FROM vfiles INTO @vfilename
END
CLOSE vfiles
DEALLOCATE vfiles
GO
