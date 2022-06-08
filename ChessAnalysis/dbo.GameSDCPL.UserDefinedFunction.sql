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

	DECLARE @mx_eval float
	SET @mx_eval = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

	SET @value =
	(SELECT
		STDEV(CONVERT(float, CP_Loss))
		
		FROM ControlMoves
		
		WHERE GameID = @GameID
		AND Color = @Color
		AND IsTheory = 0
		AND CP_Loss IS NOT NULL
		AND ISNUMERIC(T1_Eval) = 1
		AND ISNUMERIC(Move_Eval) = 1
		AND ABS(CONVERT(float, T1_Eval)) < @mx_eval
		AND ABS(CONVERT(float, Move_Eval)) < @mx_eval
	)

	RETURN ISNULL(@value, 0)
END
GO
