USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GameACPLMoveCount] (@GameID int, @Color varchar(5))
RETURNS int

AS

BEGIN
	DECLARE @mx_eval float
	SET @mx_eval = CAST((SELECT SettingValue FROM DynamicSettings WHERE SettingID = 3) AS float)

	DECLARE @value int
	SET @value =
	(SELECT 
		COUNT(MoveID)
		
		FROM ControlMoves
		
		WHERE GameID = @GameID
		AND Color = @color
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
