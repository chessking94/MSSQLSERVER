USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_CalcGamePhaseWeight](@PhaseID int)
RETURNS decimal(7,6)

AS

BEGIN
	DECLARE @weight decimal(7,6)
	SET @weight = (SELECT 3*SUM(CASE WHEN PhaseID = @PhaseID THEN 1.0 ELSE 0.0 END)/COUNT(PhaseID) FROM ControlMoves)
	RETURN @weight
END
GO
