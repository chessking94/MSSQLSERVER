USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadUSCFGolden]

AS

TRUNCATE TABLE tempAnalysisFolder
TRUNCATE TABLE tempAnalysisContents

DECLARE @Cmd varchar(200)

SET @Cmd = 'dir "C:\FileProcessing\Import\"'

INSERT INTO tempAnalysisFolder
EXEC master..xp_cmdshell @Cmd
	
DECLARE vfiles CURSOR FOR 
	SELECT LTRIM(RTRIM(SUBSTRING(oneline,40,1000))) AS filename 
FROM tempAnalysisFolder WHERE RIGHT(RTRIM(oneline),4) = '.txt'

DECLARE @vfilename varchar(100)
DECLARE @command varchar(1000)
DECLARE @delim char(1) = CHAR(9)

OPEN vfiles
FETCH NEXT FROM vfiles INTO @vfilename
WHILE @@FETCH_STATUS = 0
BEGIN
	TRUNCATE TABLE tempAnalysisContents
	SET @command = 'BULK INSERT tempAnalysisContents FROM ''C:\FileProcessing\Import\' + @vFileName + ''' WITH (ROWTERMINATOR = ''\n'')'
	EXECUTE (@command)

	TRUNCATE TABLE USCFGolden

	INSERT INTO USCFGolden (
		Filename,
		Name,
		ID,
		ExpirationDate,
		State,
		Regular,
		RegProvGames,
		Quick,
		QkProvGames
	)

	SELECT
	@vfilename AS Filename,
	TRIM(dbo.sqlSplit(oneline, @delim, 1)) AS Name,
	TRIM(dbo.sqlSplit(oneline, @delim, 2)) AS ID,
	TRIM(dbo.sqlSplit(oneline, @delim, 3)) AS ExpirationDate,
	NULLIF(TRIM(dbo.sqlSplit(oneline, @delim, 4)), '') AS State,
	LEFT(NULLIF(TRIM(dbo.sqlSplit(oneline, @delim, 5)), ''),
		CASE 
			WHEN CHARINDEX('*', TRIM(dbo.sqlSplit(oneline, @delim, 5))) > 0 THEN CHARINDEX('*', TRIM(dbo.sqlSplit(oneline, @delim, 5))) - 1
			WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5))) - 1
			ELSE LEN(TRIM(dbo.sqlSplit(oneline, @delim, 5)))
		END)
	AS Regular,
	CASE WHEN (
		CASE 
			WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5)))
			ELSE NULL
		END
		) IS NOT NULL THEN SUBSTRING(TRIM(dbo.sqlSplit(oneline, @delim, 5)), (CASE
				WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 5)))
			END) + 1, 3)
		ELSE NULL
	END AS RegProvGames,
	LEFT(NULLIF(TRIM(dbo.sqlSplit(oneline, @delim, 6)), ''),
		CASE 
			WHEN CHARINDEX('*', TRIM(dbo.sqlSplit(oneline, @delim, 6))) > 0 THEN CHARINDEX('*', TRIM(dbo.sqlSplit(oneline, @delim, 6))) - 1
			WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6))) - 1
			ELSE LEN(TRIM(dbo.sqlSplit(oneline, @delim, 6)))
		END)
	AS Quick,
	CASE WHEN (
		CASE 
			WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6)))
			ELSE NULL
		END
		) IS NOT NULL THEN SUBSTRING(TRIM(dbo.sqlSplit(oneline, @delim, 6)), (CASE 
				WHEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6))) > 0 THEN CHARINDEX('/', TRIM(dbo.sqlSplit(oneline, @delim, 6)))
			END) + 1, 3)
		ELSE NULL
	END AS QkProvGames

	FROM tempAnalysisContents


	SET @command = 'MOVE "C:\FileProcessing\Import\' + @vFileName + '" "' + 'C:\FileProcessing\Import\Archive\' + @vFileName + '"'
    EXEC master..xp_cmdshell @command

	FETCH NEXT FROM vfiles INTO @vfilename
END
CLOSE vfiles
DEALLOCATE vfiles
GO
