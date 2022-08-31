USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePhaseWeights] (@Source nvarchar(15), @TimeControlType nvarchar(20))

AS

DECLARE @phaseid tinyint
DECLARE @weight decimal(7,6)
DECLARE @vsql nvarchar(500)
DECLARE @corrflag nvarchar(1)

SET @phaseid = 1
WHILE @phaseid <= 3
BEGIN
	IF @Source = 'Control'
	BEGIN
		SET @corrflag = N'1'
		IF @TimeControlType <> 'Correspondence'
		BEGIN
			SET @corrflag = N'0'
			SET @TimeControlType = 'Classical'
		END
		SET @vsql = N'
SELECT
@weightOUT = 3*SUM(CASE WHEN m.PhaseID = ' + CAST(@phaseID AS nvarchar(1)) + N' THEN 1.0 ELSE 0.0 END)/COUNT(m.PhaseID)
FROM ' + @Source + N'Moves m
JOIN ' + @Source + 'Games g ON m.GameID = g.GameID
WHERE g.CorrFlag = ' + @corrflag
	END

	ELSE --not Control

	BEGIN
		SET @vsql = N'
SELECT
@weightOUT = 3*SUM(CASE WHEN m.PhaseID = ' + CAST(@phaseID AS nvarchar(1)) + N' THEN 1.0 ELSE 0.0 END)/COUNT(m.PhaseID)
FROM ' + @Source + N'Moves m
JOIN ' + @Source + N'Games g ON m.GameID = g.GameID
JOIN TimeControls tc ON g.TimeControl = tc.TimeControl
WHERE tc.TimeControlType = ''' + @TimeControlType + ''''
	END
	
	EXEC sp_executesql @vsql, N'@weightOUT decimal(7,6) OUTPUT', @weightOUT=@weight OUTPUT

	IF EXISTS (SELECT ScoreWeight FROM GamePhaseWeights WHERE Source = @Source AND TimeControlType = @TimeControlType AND PhaseID = @phaseid)
	BEGIN
		UPDATE GamePhaseWeights SET ScoreWeight = @weight WHERE Source = @Source AND TimeControlType = @TimeControlType AND PhaseID = @phaseid
	END
	ELSE
	BEGIN
		INSERT INTO GamePhaseWeights (Source, TimeControlType, PhaseID, ScoreWeight) VALUES (@Source, @TimeControlType, @phaseid, @weight)
	END
	
	SET @phaseid = @phaseid + 1
END
GO
