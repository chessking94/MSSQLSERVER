USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_OnlineGameTxPcnt] (@GameID int, @Color varchar(5), @Rank int)
RETURNS decimal(10,9)

AS

BEGIN
	DECLARE @TxPcnt decimal(10,9)

	SET @TxPcnt = (
		SELECT
		1.00*SUM(CASE WHEN Move_Rank <= @Rank THEN 1 ELSE 0 END)/COUNT(MoveID)

		FROM OnlineMoves

		WHERE GameID = @GameID
		AND Color = @Color
		AND IsTheory = 0
		AND IsTablebase = 0
		AND T1_Eval NOT LIKE '#%'
		AND Move_Eval NOT LIKE '#%'
	)

	RETURN @TxPcnt
END
GO
