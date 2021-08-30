USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwBlackPerformance]

AS

SELECT
a.Color,
a.RatingGroup,
a.BestEvalGroup,
a.ACPL_Group,
a.Meaning,
a.ACPL_Range,
a.Move_Count,
SUM(a.Move_Count) OVER (PARTITION BY a.RatingGroup, a.BestEvalGroup) AS Total_Count,
1.0*a.Move_Count/(SUM(a.Move_Count) OVER (PARTITION BY a.RatingGroup, a.BestEvalGroup)) AS Pcnt

FROM
(
	SELECT
	m.Color,
	r.RatingGroup,
	v.BestEvalGroup,
	v.ACPL_Group,
	eg.Meaning,
	acpl.ACPL_Range,
	COUNT(m.MoveID) Move_Count

	FROM vwControlMoveScores v
	JOIN ControlMoves m ON v.MoveID = m.MoveID
	JOIN ControlGames g ON m.GameID = g.GameID
	JOIN EvaluationGroups eg ON v.BestEvalGroup = eg.GroupID
	JOIN ACPL_Ranges acpl ON v.ACPL_Group = acpl.ACPL_Group
	JOIN Rating_Bins r ON g.BlackElo >= r.LBound AND g.BlackElo <= r.UBound

	WHERE m.Color = 'Black'

	GROUP BY
	m.Color,
	r.RatingGroup,
	v.BestEvalGroup,
	v.ACPL_Group,
	eg.Meaning,
	acpl.ACPL_Range
) a
GO
