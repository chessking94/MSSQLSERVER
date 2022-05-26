﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GameACPLMoveCount] (@GameID int, @Color varchar(5))
RETURNS int

AS

BEGIN
	DECLARE @mx_acpl float
	SET @mx_acpl = CAST((SELECT SettingValue FROM DynamicSettings WHERE SETtingName = 'Max ACPL') AS float)

	DECLARE @value int
	SET @value =
	(SELECT 
		COUNT(MoveID)
		
		FROM ControlMoves
		
		WHERE GameID = @GameID
		AND Color = @color
		AND IsTheory = 0
		AND CP_Loss IS NOT NULL
		AND ABS(CAST(CASE WHEN T1_Eval LIKE '#%' THEN '100' ELSE T1_Eval END AS float)) < @mx_acpl
		AND ABS(CAST(CASE WHEN Move_Eval LIKE '#%' THEN '100' ELSE Move_Eval END AS float)) < @mx_acpl
	)

	RETURN ISNULL(@value, 0)
END
GO
