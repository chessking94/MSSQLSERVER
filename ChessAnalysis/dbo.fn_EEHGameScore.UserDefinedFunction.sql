USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_EEHGameScore] (@GameID int, @Color varchar(5))
RETURNS decimal(5,2)

AS

BEGIN
	DECLARE @value decimal(5,2)

	SET @value =
	(SELECT
		ROUND(100*SUM(v.Score)/SUM(gp.ScoreWeight*s.Points), 2) AS Score
		FROM vwEEHMoveScores v
		JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
		JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
		WHERE v.GameID = @GameID
		AND v.Color = @Color
	)

	RETURN @value
END
GO
