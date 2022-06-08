USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_EEHACPLRangeCount] (@GameID int, @Color varchar(5), @LBound decimal(5,2), @UBound decimal(5,2))

RETURNS int

BEGIN
	DECLARE @value int

	DECLARE @mx_eval float
	SET @mx_eval = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

	SET @value =
	(SELECT 
		COUNT(m.MoveID)
		
		FROM EEHMoves m
		
		WHERE m.GameID = @GameID
		AND m.Color = @Color
		AND m.IsTheory = 0
		AND m.CP_Loss IS NOT NULL
		AND CONVERT(float, m.CP_Loss) BETWEEN @LBound AND @UBound
		AND ISNUMERIC(m.T1_Eval) = 1
		AND ISNUMERIC(m.Move_Eval) = 1
		AND ABS(CONVERT(float, m.T1_Eval)) < @mx_eval
		AND ABS(CONVERT(float, m.Move_Eval)) < @mx_eval
	)

	RETURN @value
END
GO
