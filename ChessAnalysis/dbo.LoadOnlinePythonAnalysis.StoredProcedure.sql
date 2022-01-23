USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadOnlinePythonAnalysis] as

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
DECLARE @dte datetime

OPEN vfiles
FETCH NEXT FROM vfiles INTO @vfilename
WHILE @@FETCH_STATUS = 0 --loop through all files
BEGIN
	SET @dte = GETDATE()

	TRUNCATE TABLE tempAnalysisContentsPK
	SET @command = 'BULK INSERT vwtempAnalysisContentsPK FROM ''C:\FileProcessing\Import\' + @vFileName + ''' WITH (ROWTERMINATOR = ''\n'')'
	EXECUTE (@command)

	SET @ctr = (SELECT MAX(ID) FROM tempAnalysisContentsPK)

	--Record01 (game data)
	INSERT INTO OnlineGames (WhiteLast, WhiteFirst, WhiteElo, BlackLast, BlackFirst, BlackElo, ECO, GameDate, Tournament, RoundNum, Result, Moves, CorrFlag, Source, SourceID, TimeControl)
	SELECT
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'WhiteLast') AS WhiteLast,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'WhiteFirst') AS WhiteFirst,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'WhiteElo') AS WhiteElo,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'BlackLast') AS BlackLast,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'BlackFirst') AS BlackFirst,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'BlackElo') AS BlackElo,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'ECO') AS ECO,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'GameDate') AS GameDate,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'Tournament') AS Tournament,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'RoundNum') AS RoundNum,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'Result') AS Result,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'Moves') AS Moves,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'CorrFlag') AS CorrFlag,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'Source') AS Source,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'SourceID') AS SourceID,
	(SELECT substring(py.oneline, r1.StartChar, r1.FieldLength) FROM Record01 r1 WHERE r1.Field = 'TimeControl') AS TimeControl

	FROM tempAnalysisContentsPK py
	WHERE LEFT(py.oneline,2) = '01'

	ORDER BY py.ID

	UPDATE OnlineGames
	SET WhiteLast = TRIM(WhiteLast),
		WhiteFirst = TRIM(WhiteFirst),
		BlackLast = TRIM(BlackLast),
		BlackFirst = TRIM(BlackFirst),
		ECO = TRIM(ECO),
		Tournament = TRIM(Tournament),
		RoundNum = TRIM(RoundNum),
		Source = TRIM(Source),
		SourceID = TRIM(SourceID),
		TimeControl = TRIM(TimeControl)
	WHERE DateAdded >= @dte


	--Record02 (game moves)
	INSERT INTO OnlineMoves (GameID, MoveNumber, Color, IsTheory, IsTablebase, Move,
		T1, T2, T3, T4, T5, T6, T7, T8,
		T9, T10, T11, T12, T13, T14, T15, T16,
		T17, T18, T19, T20, T21, T22, T23, T24,
		T25, T26, T27, T28, T29, T30, T31, T32, Move_Eval,
		T1_Eval, T2_Eval, T3_Eval, T4_Eval, T5_Eval, T6_Eval, T7_Eval, T8_Eval,
		T9_Eval, T10_Eval, T11_Eval, T12_Eval, T13_Eval, T14_Eval, T15_Eval, T16_Eval,
		T17_Eval, T18_Eval, T19_Eval, T20_Eval, T21_Eval, T22_Eval, T23_Eval, T24_Eval,
		T25_Eval, T26_Eval, T27_Eval, T28_Eval, T29_Eval, T30_Eval, T31_Eval, T32_Eval,
		CP_Loss, Engine, Depth, AnalysisTime, FEN)
	SELECT
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'GameID') AS GameID,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'MoveNum') AS MoveNumber,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Color') AS Color,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'IsTheory') AS IsTheory,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'IsTablebase') AS IsTablebase,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Move') AS Move,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T1') AS T1,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T2') AS T2,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T3') AS T3,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T4') AS T4,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T5') AS T5,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T6') AS T6,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T7') AS T7,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T8') AS T8,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T9') AS T9,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T10') AS T10,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T11') AS T11,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T12') AS T12,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T13') AS T13,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T14') AS T14,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T15') AS T15,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T16') AS T16,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T17') AS T17,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T18') AS T18,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T19') AS T19,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T20') AS T20,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T21') AS T21,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T22') AS T22,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T23') AS T23,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T24') AS T24,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T25') AS T25,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T26') AS T26,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T27') AS T27,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T28') AS T28,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T29') AS T29,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T30') AS T30,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T31') AS T31,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T32') AS T32,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Move_Eval') AS Move_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T1_Eval') AS T1_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T2_Eval') AS T2_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T3_Eval') AS T3_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T4_Eval') AS T4_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T5_Eval') AS T5_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T6_Eval') AS T6_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T7_Eval') AS T7_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T8_Eval') AS T8_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T9_Eval') AS T9_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T10_Eval') AS T10_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T11_Eval') AS T11_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T12_Eval') AS T12_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T13_Eval') AS T13_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T14_Eval') AS T14_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T15_Eval') AS T15_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T16_Eval') AS T16_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T17_Eval') AS T17_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T18_Eval') AS T18_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T19_Eval') AS T19_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T20_Eval') AS T20_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T21_Eval') AS T21_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T22_Eval') AS T22_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T23_Eval') AS T23_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T24_Eval') AS T24_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T25_Eval') AS T25_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T26_Eval') AS T26_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T27_Eval') AS T27_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T28_Eval') AS T28_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T29_Eval') AS T29_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T30_Eval') AS T30_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T31_Eval') AS T31_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'T32_Eval') AS T32_Eval,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'CP_Loss') AS CP_Loss,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Engine') AS Engine,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Depth') AS Depth,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'Time') AS AnalysisTime,
	(SELECT RTRIM(NULLIF(SUBSTRING(py.oneline, r2.StartChar, r2.FieldLength),space(r2.FieldLength))) FROM Record02 r2 WHERE r2.Field = 'FEN') AS FEN

	FROM tempAnalysisContentsPK py
	WHERE LEFT(py.oneline,2) = '02'

	ORDER BY py.ID

	UPDATE OnlineMoves
	SET Color = TRIM(Color),
		Move = TRIM(Move),
		T1 = TRIM(T1),
		T2 = TRIM(T2),
		T3 = TRIM(T3),
		T4 = TRIM(T4),
		T5 = TRIM(T5),
		T6 = TRIM(T6),
		T7 = TRIM(T7),
		T8 = TRIM(T8),
		T9 = TRIM(T9),
		T10 = TRIM(T10),
		T11 = TRIM(T11),
		T12 = TRIM(T12),
		T13 = TRIM(T13),
		T14 = TRIM(T14),
		T15 = TRIM(T15),
		T16 = TRIM(T16),
		T17 = TRIM(T17),
		T18 = TRIM(T18),
		T19 = TRIM(T19),
		T20 = TRIM(T20),
		T21 = TRIM(T21),
		T22 = TRIM(T22),
		T23 = TRIM(T23),
		T24 = TRIM(T24),
		T25 = TRIM(T25),
		T26 = TRIM(T26),
		T27 = TRIM(T27),
		T28 = TRIM(T28),
		T29 = TRIM(T29),
		T30 = TRIM(T30),
		T31 = TRIM(T31),
		T32 = TRIM(T32),
		Move_Eval = TRIM(Move_Eval),
		T1_Eval = TRIM(T1_Eval),
		T2_Eval = TRIM(T2_Eval),
		T3_Eval = TRIM(T3_Eval),
		T4_Eval = TRIM(T4_Eval),
		T5_Eval = TRIM(T5_Eval),
		T6_Eval = TRIM(T6_Eval),
		T7_Eval = TRIM(T7_Eval),
		T8_Eval = TRIM(T8_Eval),
		T9_Eval = TRIM(T9_Eval),
		T10_Eval = TRIM(T10_Eval),
		T11_Eval = TRIM(T11_Eval),
		T12_Eval = TRIM(T12_Eval),
		T13_Eval = TRIM(T13_Eval),
		T14_Eval = TRIM(T14_Eval),
		T15_Eval = TRIM(T15_Eval),
		T16_Eval = TRIM(T16_Eval),
		T17_Eval = TRIM(T17_Eval),
		T18_Eval = TRIM(T18_Eval),
		T19_Eval= TRIM(T19_Eval),
		T20_Eval= TRIM(T20_Eval),
		T21_Eval = TRIM(T21_Eval),
		T22_Eval = TRIM(T22_Eval),
		T23_Eval = TRIM(T23_Eval),
		T24_Eval = TRIM(T24_Eval),
		T25_Eval = TRIM(T25_Eval),
		T26_Eval = TRIM(T26_Eval),
		T27_Eval = TRIM(T27_Eval),
		T28_Eval = TRIM(T28_Eval),
		T29_Eval = TRIM(T29_Eval),
		T30_Eval = TRIM(T30_Eval),
		T31_Eval = TRIM(T31_Eval),
		T32_Eval= TRIM(T32_Eval),
		CP_Loss = TRIM(CP_Loss),
		Engine = TRIM(Engine),
		Depth = TRIM(Depth),
		FEN = TRIM(FEN)
	WHERE TotalMoves IS NULL

	--update misc columns
	UPDATE OnlineMoves
	SET Move_Rank = dbo.OnlineMovePlayedRanking(MoveID),
		CandidateMoves = dbo.CountOnlineMovesCandidates(MoveID)
	WHERE TotalMoves IS NULL

	EXEC UpdateOnlineAvgCandidateError

	UPDATE OnlineMoves
	SET	StDevCandidate = dbo.SDOnlineCandidateMoves(MoveID),
		PcntCandidatesWithin10CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.00, 0.09),
		PcntCandidatesWithin20CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.10, 0.19),
		PcntCandidatesWithin30CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.20, 0.29),
		PcntCandidatesWithin40CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.30, 0.39),
		PcntCandidatesWithin50CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.40, 0.49),
		PcntCandidatesWithin60CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.50, 0.59),
		PcntCandidatesWithin70CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.60, 0.69),
		PcntCandidatesWithin80CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.70, 0.79),
		PcntCandidatesWithin90CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.80, 0.89),
		PcntCandidatesWithin100CP = dbo.CalculateOnlineCandidatesPercentages(MoveID, 0.90, 1.00),
		MaterialWhite = dbo.CountMaterialWhite(FEN),
		MaterialBlack = dbo.CountMaterialBlack(FEN),
		TotalPieceCount = dbo.CountPieces(FEN)
	WHERE TotalMoves IS NULL

	UPDATE OnlineMoves SET TotalMoves = dbo.CountOnlineMoves(MoveID) WHERE TotalMoves IS NULL

	--chess.com and lichess pgn downloads do not have a PlyCount tag, need to add manually
	UPDATE g
	SET g.Moves = ISNULL(m.MaxMove, 0)
	FROM OnlineGames g
	LEFT JOIN (SELECT GameID, MAX(MoveNumber) MaxMove FROM OnlineMoves WHERE DateAdded >= @dte GROUP BY GameID) m ON g.GameID = m.GameID
	WHERE NULLIF(g.Moves, '') IS NULL
	AND DateAdded >= @dte

	--update corrflag for online games, using reference table
	UPDATE g
	SET g.CorrFlag = tc.CorrFlag
	FROM OnlineGames g
	LEFT JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
	WHERE DateAdded >= @dte

	SET @command = 'MOVE "C:\FileProcessing\Import\' + @vFileName + '" "' + 'C:\FileProcessing\Import\Archive\' + @vFileName + '"'
    EXEC master..xp_cmdshell @command

	--add data to file import log
	INSERT INTO FileImportLog (FileTypeID, Filename, DateImported, RowsImported)
	VALUES ('4', @vfilename, GETDATE(), @ctr)

	FETCH NEXT FROM vfiles INTO @vfilename
END
CLOSE vfiles
DEALLOCATE vfiles
GO
