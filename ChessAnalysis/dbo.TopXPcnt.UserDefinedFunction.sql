USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TopXPcnt] (@GameID int, @Color varchar(6), @N int)
RETURNS float

AS

BEGIN
	DECLARE @Pcnt float

	SET @Pcnt =
	(SELECT
		1.00*SUM(CASE WHEN m.Move_Rank <= @N THEN 1 ELSE 0 END)/COUNT(m.MoveID)
		FROM ControlMoves m
		WHERE m.GameID = @GameID
		AND m.Color = @Color
		AND m.IsTheory = 0
		AND m.IsTablebase = 0
		AND m.T1_Eval NOT LIKE '#%'
		AND m.Move_Eval NOT LIKE '#%'
	)
	
	RETURN ISNULL(@Pcnt, 1.00)
END
GO
