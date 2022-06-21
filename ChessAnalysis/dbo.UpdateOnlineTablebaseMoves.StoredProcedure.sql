USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOnlineTablebaseMoves]

AS

DECLARE @fpath varchar(100)
DECLARE @fname varchar(100)
DECLARE @filetest nvarchar(200)
DECLARE @fileexists int = 0
DECLARE @command varchar(250)

TRUNCATE TABLE tempAnalysisContents

SET @fpath = (SELECT SettingValue FROM DynamicSettings WHERE SettingID = 4)
IF RIGHT(@fpath, 1) = '\' SET @fpath = (CASE RIGHT(@fpath, 1) WHEN '\' THEN LEFT(@fpath, LEN(@fpath) - 1) ELSE @fpath END)
SET @fname = (SELECT SettingValue FROM DynamicSettings WHERE SettingID = 6)

SET @filetest = @fpath + '\' + @fname
EXEC master.dbo.xp_fileexist @filetest, @fileexists OUTPUT

IF @fileexists = 0
BEGIN
	PRINT 'File does not exist: ' + @filetest
	RETURN
END

SET @command = 'BULK INSERT tempAnalysisContents FROM ''' + @filetest + ''' WITH (ROWTERMINATOR = ''\n'')'
EXECUTE (@command)

UPDATE m
SET
	m.MoveNumber = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'MoveNum')),
	m.Color = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Color')),
	m.IsTheory = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'IsTheory')),
	m.IsTablebase = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'IsTablebase')),
	m.Move = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Move')),
	m.T1 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T1')),
	m.T2 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T2')),
	m.T3 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T3')),
	m.T4 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T4')),
	m.T5 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T5')),
	m.T6 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T6')),
	m.T7 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T7')),
	m.T8 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T8')),
	m.T9 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T9')),
	m.T10 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T10')),
	m.T11 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T11')),
	m.T12 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T12')),
	m.T13 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T13')),
	m.T14 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T14')),
	m.T15 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T15')),
	m.T16 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T16')),
	m.T17 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T17')),
	m.T18 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T18')),
	m.T19 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T19')),
	m.T20 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T20')),
	m.T21 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T21')),
	m.T22 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T22')),
	m.T23 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T23')),
	m.T24 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T24')),
	m.T25 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T25')),
	m.T26 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T26')),
	m.T27 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T27')),
	m.T28 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T28')),
	m.T29 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T29')),
	m.T30 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T30')),
	m.T31 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T31')),
	m.T32 = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T32')),
	m.Move_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Move_Eval')),
	m.T1_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T1_Eval')),
	m.T2_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T2_Eval')),
	m.T3_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T3_Eval')),
	m.T4_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T4_Eval')),
	m.T5_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T5_Eval')),
	m.T6_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T6_Eval')),
	m.T7_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T7_Eval')),
	m.T8_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T8_Eval')),
	m.T9_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T9_Eval')),
	m.T10_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T10_Eval')),
	m.T11_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T11_Eval')),
	m.T12_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T12_Eval')),
	m.T13_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T13_Eval')),
	m.T14_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T14_Eval')),
	m.T15_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T15_Eval')),
	m.T16_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T16_Eval')),
	m.T17_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T17_Eval')),
	m.T18_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T18_Eval')),
	m.T19_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T19_Eval')),
	m.T20_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T20_Eval')),
	m.T21_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T21_Eval')),
	m.T22_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T22_Eval')),
	m.T23_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T23_Eval')),
	m.T24_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T24_Eval')),
	m.T25_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T25_Eval')),
	m.T26_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T26_Eval')),
	m.T27_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T27_Eval')),
	m.T28_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T28_Eval')),
	m.T29_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T29_Eval')),
	m.T30_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T30_Eval')),
	m.T31_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T31_Eval')),
	m.T32_Eval = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T32_Eval')),
	m.CP_Loss = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'CP_Loss')),
	m.Engine = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Engine')),
	m.Depth = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Depth')),
	m.AnalysisTime = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Time')),
	m.FEN = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'FEN')),
	m.CandidateMoves = NULL,
	m.AvgCandidateError = NULL,
	m.StDevCandidate = NULL,
	m.Move_Rank = NULL,
	m.MaterialWhite = NULL,
	m.MaterialBlack = NULL,
	m.TotalPieceCount = NULL,
	m.TotalMoves = NULL

FROM tempAnalysisContents py
JOIN OnlineMoves m ON m.MoveID = TRIM((SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'GameID'))

--update misc fields
UPDATE OnlineMoves
SET Move_Rank = dbo.OnlineMovePlayedRanking(MoveID),
	CandidateMoves = dbo.CountOnlineMovesCandidates(MoveID)
WHERE TotalMoves IS NULL

EXEC UpdateOnlineAvgCandidateError

UPDATE OnlineMoves
SET	StDevCandidate = dbo.SDOnlineCandidateMoves(MoveID),
	MaterialWhite = dbo.CountMaterialWhite(FEN),
	MaterialBlack = dbo.CountMaterialBlack(FEN),
	TotalPieceCount = dbo.CountPieces(FEN)
WHERE TotalMoves IS NULL

UPDATE OnlineMoves SET TotalMoves = dbo.CountOnlineMoves(MoveID) WHERE TotalMoves IS NULL

SET @command = 'MOVE "' + @fpath + '\' + @fname + '" "' + @fpath + '\Archive\' + @fname + '"'
EXEC master..xp_cmdshell @command
GO
