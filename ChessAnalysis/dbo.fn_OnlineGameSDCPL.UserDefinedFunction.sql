USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[fn_OnlineGameSDCPL] (@GameID int, @Color varchar(5))
RETURNS decimal(5,2)

AS

BEGIN
	DECLARE @value decimal(5,2)

	DECLARE @mx_acpl float
	SET @mx_acpl = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingName = 'Max Eval') AS float)

	SET @value =
	(SELECT
		STDEV(CONVERT(float, m.CP_Loss))
		
		FROM OnlineMoves m
		
		WHERE m.GameID = @GameID
		AND m.Color = @Color
		AND m.IsTheory = 0
		AND m.CP_Loss IS NOT NULL
		AND ABS(CONVERT(float, m.T1_Eval)) < @mx_acpl
		AND ABS(CONVERT(float, m.Move_Eval)) < @mx_acpl
	)

	RETURN ISNULL(@value, 0)
END
GO
