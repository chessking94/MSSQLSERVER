USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadOnlineCDCAccuracy] as

SET NOCOUNT ON;

TRUNCATE TABLE tempAnalysisFolder
TRUNCATE TABLE tempAnalysisContents

DECLARE @Cmd varchar(200)

SET @Cmd = 'dir "C:\FileProcessing\Import\"'

INSERT INTO tempAnalysisFolder
EXEC master..xp_cmdshell @Cmd
	
DECLARE vfiles CURSOR FOR 
	SELECT LTRIM(RTRIM(SUBSTRING(oneline,40,1000))) AS filename 
FROM tempAnalysisFolder WHERE RIGHT(RTRIM(oneline),4) = '.txt' --must be .txt file

DECLARE @vfilename varchar(100)
DECLARE @command varchar(1000)
DECLARE @ctr int

OPEN vfiles
FETCH NEXT FROM vfiles INTO @vfilename
WHILE @@FETCH_STATUS = 0 --loop through all files
BEGIN
	TRUNCATE TABLE tempAnalysisContents
	SET @command = 'BULK INSERT tempAnalysisContents FROM ''C:\FileProcessing\Import\' + @vFileName + ''' WITH (ROWTERMINATOR = ''\n'')'
	EXECUTE (@command)

	SET @ctr = (SELECT COUNT(oneline) FROM tempAnalysisContents) - 1 --there is a header

	UPDATE g
	SET g.CDCAccuracyWhite = NULLIF(dbo.sqlSplit(t.oneline, CHAR(9), 2), 'NULL'),
		g.CDCAccuracyBlack = NULLIF(dbo.sqlSplit(t.oneline, CHAR(9), 3), 'NULL')
	FROM OnlineGames g
	JOIN tempAnalysisContents t ON g.SourceID = dbo.sqlSplit(t.oneline, CHAR(9), 1) AND g.Source = 'Chess.com'
	WHERE dbo.sqlSplit(t.oneline, CHAR(9), 1) <> 'SourceID'
	AND (
		g.CDCAccuracyWhite <> NULLIF(dbo.sqlSplit(t.oneline, CHAR(9), 2), 'NULL')
		OR
		g.CDCAccuracyBlack <> NULLIF(dbo.sqlSplit(t.oneline, CHAR(9), 3), 'NULL')
	)

	SET @ctr = @@ROWCOUNT --only return number of rows that had updates

	SET @command = 'MOVE "C:\FileProcessing\Import\' + @vFileName + '" "' + 'C:\FileProcessing\Import\Archive\' + @vFileName + '"'
    EXEC master..xp_cmdshell @command

	--add data to file import log
	INSERT INTO FileImportLog (FileTypeID, Filename, DateImported, RowsImported)
	VALUES ('5', @vfilename, GETDATE(), @ctr)

	FETCH NEXT FROM vfiles INTO @vfilename
END
CLOSE vfiles
DEALLOCATE vfiles
GO
