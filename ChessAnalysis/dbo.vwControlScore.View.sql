USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwControlScore]

AS

SELECT
v.GameID,
v.Color,
100*SUM(v.Score)/SUM(gp.ScoreWeight*s.Points) AS Score

FROM vwControlMoveScores v
JOIN GamePhases gp ON v.PhaseID = gp.PhaseID
JOIN ScoreReference s ON v.BestEvalGroup = s.BestEvalGroup AND v.PlayedEvalGroup = s.PlayedEvalGroup AND v.ACPL_Group = s.ACPL_Group

GROUP BY
v.GameID,
v.Color
GO
