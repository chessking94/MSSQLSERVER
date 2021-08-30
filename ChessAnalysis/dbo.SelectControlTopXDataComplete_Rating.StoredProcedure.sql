USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectControlTopXDataComplete_Rating] (@Rating varchar(4))

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
CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END AS Rating,
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END AS RatingGroup,
1.00*SUM(CASE WHEN m.Move_Rank <= 1 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T1,
1.00*SUM(CASE WHEN m.Move_Rank <= 2 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T2,
1.00*SUM(CASE WHEN m.Move_Rank <= 3 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T3,
1.00*SUM(CASE WHEN m.Move_Rank <= 4 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T4,
1.00*SUM(CASE WHEN m.Move_Rank <= 5 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T5,
1.00*SUM(CASE WHEN m.Move_Rank <= 6 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T6,
1.00*SUM(CASE WHEN m.Move_Rank <= 7 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T7,
1.00*SUM(CASE WHEN m.Move_Rank <= 8 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T8,
1.00*SUM(CASE WHEN m.Move_Rank <= 9 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T9,
1.00*SUM(CASE WHEN m.Move_Rank <= 10 THEN 1 ELSE 0 END)/COUNT(m.MoveID) AS T10

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
m.GameID,
m.Color,
CASE WHEN m.Color = 'White' THEN g.WhiteElo ELSE g.BlackElo END,
CASE WHEN r.RatingGroup = 'Unr' THEN r.RatingGroup ELSE SUBSTRING(r.RatingGroup, 1, CHARINDEX('_', r.RatingGroup, 1) - 1) END

ORDER BY
m.GameID,
m.Color DESC
GO
