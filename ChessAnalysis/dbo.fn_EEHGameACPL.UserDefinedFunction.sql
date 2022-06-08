USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_EEHGameACPL] (@GameID int, @Color varchar(5))
RETURNS decimal(5,2)

AS

BEGIN
	DECLARE @value decimal(5,2)

	DECLARE @mx_eval float
	SET @mx_eval = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

	SET @value =
	(SELECT
		AVG(CONVERT(float, m.CP_Loss))
		
		FROM EEHMoves m
		
		WHERE m.GameID = @GameID
		AND m.Color = @Color
		AND m.IsTheory = 0
		AND m.CP_Loss IS NOT NULL
		AND ISNUMERIC(m.T1_Eval) = 1
		AND ISNUMERIC(m.Move_Eval) = 1
		AND ABS(CONVERT(float, m.T1_Eval)) < @mx_eval
		AND ABS(CONVERT(float, m.Move_Eval)) < @mx_eval
	)

	RETURN ISNULL(@value, 0)
END
GO
