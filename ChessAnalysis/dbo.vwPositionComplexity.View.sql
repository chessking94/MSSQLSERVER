USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPositionComplexity]

AS

SELECT
m.MoveID,
m.GameID,
m.Color,
m.FEN,
CASE m.Color WHEN 'White' THEN g.WhiteElo ELSE g.BlackElo END AS Rating,
CONCAT(m.FEN, '|', CASE m.Color WHEN 'White' THEN g.WhiteElo ELSE g.BlackElo END) AS Input_String,
CASE WHEN CAST(m.CP_Loss AS decimal(5,2)) > 2 THEN 2.00 ELSE m.CP_Loss END AS CP_Loss,
--CASE m.Move_Rank WHEN 1 THEN 1 ELSE 0 END AS Best_Move
CASE WHEN CAST(m.CP_Loss AS decimal(5,2)) <= 0.30 THEN 1 ELSE 0 END AS Best_Move
FROM ControlMoves m
JOIN ControlGames g ON m.GameID = g.GameID
WHERE g.CorrFlag = 0
AND m.CP_Loss IS NOT NULL
AND ISNUMERIC(m.T1_Eval) = 1
AND CAST(m.T1_Eval AS decimal(5,2)) <= 3.5
GO
