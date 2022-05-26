USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GameSDCPL] (@GameID int, @Color varchar(5))
RETURNS decimal(5,4)

AS

BEGIN
	DECLARE @value decimal(5,4)

	DECLARE @mx_acpl float
	SET @mx_acpl = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max ACPL') AS float)

	SET @value =
	(SELECT
		STDEV(CONVERT(float, CP_Loss))
		
		FROM ControlMoves
		
		WHERE GameID = @GameID
		AND Color = @Color
		AND IsTheory = 0
		AND CP_Loss IS NOT NULL
		AND ABS(CONVERT(float, T1_Eval)) < @mx_acpl
		AND ABS(CONVERT(float, Move_Eval)) < @mx_acpl
	)

	RETURN ISNULL(@value, 0)
END
GO
