USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SelectControlACPLDataComplete_Rating] (@Rating varchar(4))

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
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END AS RatingGroup,
COUNT(m.MoveID) AS 'MoveCount',
ROUND(AVG(CONVERT(float, m.CP_Loss)), 2) AS ACPL,
ROUND(ISNULL(stdev(CONVERT(float, m.CP_Loss)), 0), 4) AS SDCPL

FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
JOIN Rating_Bins r ON (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) >= r.LBound AND (CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END) <= r.UBound

WHERE g.CorrFlag = 0
AND m.IsTheory = 0
AND m.IsTablebase = 0
AND m.T1_Eval NOT LIKE '#%'
AND m.Move_Eval NOT LIKE '#%'
AND (r.RatingGroup = @RatingGroup OR ISNULL(@RatingGroup, 'X') = 'X')

GROUP BY
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END,
r.ID

ORDER BY
r.ID

GO
