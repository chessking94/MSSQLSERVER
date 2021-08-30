USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwControlGameStats] AS

SELECT
GameID,
WhiteElo,
BlackElo,
dbo.GameACPL(GameID, 'White') AS White_ACPL,
dbo.GameACPL(GameID, 'Black') AS Black_ACPL,
dbo.GameACPLMoveCount(GameID, 'White') AS White_Move_Count,
dbo.GameACPLMoveCount(GameID, 'Black') AS Black_Move_Count

FROM ControlGames

GO
