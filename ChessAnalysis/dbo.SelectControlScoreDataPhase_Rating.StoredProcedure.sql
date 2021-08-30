USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectControlScoreDataPhase_Rating] (@Rating varchar(4))

AS

DECLARE @RatingGroup varchar(9)
IF @Rating = '0'
BEGIN
	SET @RatingGroup = 'Unr'
END
ELSE IF LEN(@Rating) < 3
BEGIN
	SET @RatingGroup = '1_199'
END
ELSE IF LEN(@Rating) = 3
BEGIN
	SET @Rating = LEFT(@Rating, 1) + '00'
	SET @RatingGroup = @Rating + '_' + LEFT(@Rating, 1) + '99'
END
ELSE IF LEN(@Rating) = 4
BEGIN
	SET @Rating = LEFT(@Rating, 2) + '00'
	SET @RatingGroup = @Rating + '_' + LEFT(@Rating, 2) + '99'
END

SELECT
m.GameID,
m.Color,
m.PhaseID,
CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END AS Rating,
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END AS RatingGroup,
ROUND(100*SUM(v.Score)/SUM(gp.ScoreWeight*s.Points), 2) AS Score

FROM vwControlMoveScores v
JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group
JOIN ControlMoves m ON v.MoveID = m.MoveID
JOIN ControlGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE g.CorrFlag = 0
AND (r.RatingGroup = @RatingGroup OR ISNULL(@RatingGroup, 'X') = 'X')

GROUP BY
m.GameID,
m.Color,
m.PhaseID,
CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END,
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END

ORDER BY
m.GameID,
m.Color DESC,
m.PhaseID
GO
