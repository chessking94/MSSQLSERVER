USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGameFacts]

AS

--add z-scores
DECLARE @mid tinyint = 1
DECLARE @mname varchar(15)
WHILE @mid <= 11
BEGIN
	SELECT @mname = MeasurementName FROM dim.Measurements WHERE MeasurementID = @mid
	EXEC UpdateZScores @AggregationName = 'Game', @MeasurementName = @mname
	EXEC UpdateZScores @AggregationName = 'Game', @MeasurementName = @mname, @src = 'Personal', @src_stats = 'Control'
	--EXEC UpdateZScores @AggregationName = 'Game', @MeasurementName = @mname, @src = 'PersonalOnline', @src_stats = 'Control'
	SET @mid = @mid + 1
END


--add composite z-score
/*
	Methodology: Essentially a weighted average divided by the overall standard deviation
	Mathematics taken from https://stats.stackexchange.com/questions/348192/combining-z-scores-by-weighted-average-sanity-check-please
*/
DECLARE @T1_Weight decimal(5,4) = 0.2
DECLARE @ScACPL_Weight decimal(5,4) = 0.35
DECLARE @Score_Weight decimal(5,4) = 0.45

UPDATE fact.Game
SET Composite_Z = (T1_Z*@T1_Weight + ScACPL_Z*@ScACPL_Weight + Score_Z*@Score_Weight)/SQRT(POWER(@T1_Weight, 2) + POWER(@ScACPL_Weight, 2) + POWER(@Score_Weight, 2)),
	Composite_Z_Equal = (T1_Z*@T1_Weight + ScACPL_Z*@ScACPL_Weight + ScoreEqual_Z*@Score_Weight)/SQRT(POWER(@T1_Weight, 2) + POWER(@ScACPL_Weight, 2) + POWER(@Score_Weight, 2))
GO
