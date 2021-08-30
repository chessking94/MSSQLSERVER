USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculatePhaseIDEEH] (@MoveID int)
RETURNS int

AS

BEGIN
	DECLARE @phaseid int

	SET @phaseid =
	(SELECT
		CASE
			WHEN MoveNumber <= 10 THEN 1
			WHEN TotalPieceCount <= 18 THEN 3
			ELSE 2
		END AS PhaseID

		FROM EEHMoves

		WHERE MoveID = @MoveID
	)

	RETURN @phaseid
END
GO
