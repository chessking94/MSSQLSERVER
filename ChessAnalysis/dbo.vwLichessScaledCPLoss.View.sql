USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLichessScaledCPLoss]

AS

SELECT
MoveID,
CASE
	WHEN CP_Loss IS NULL OR T1_Eval LIKE '#%' THEN NULL
	ELSE CAST(CP_Loss AS decimal(5,2))/(1 + ABS(CAST(T1_Eval AS decimal(5,2))))
END AS Scaled_CPLoss

FROM LichessMoves
GO
