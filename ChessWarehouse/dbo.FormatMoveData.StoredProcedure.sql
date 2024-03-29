﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FormatMoveData]

AS

UPDATE m
SET m.Color = c.ColorID, m.Errors = (CASE WHEN c.ColorID IS NULL THEN 'Color' ELSE NULL END)
FROM stage.Moves m
LEFT JOIN dim.Colors c ON m.Color = c.Color

UPDATE m
SET m.EngineName = e.EngineID, m.Errors = (CASE WHEN e.EngineID IS NULL THEN 'EngineName' ELSE NULL END)
FROM stage.Moves m
LEFT JOIN dim.Engines e ON m.EngineName = e.EngineName

UPDATE m
SET m.PhaseID = p.PhaseID, m.Errors = (CASE WHEN p.PhaseID IS NULL THEN 'PhaseID' ELSE NULL END)
FROM stage.Moves m
LEFT JOIN dim.Phases p ON m.PhaseID = p.PhaseID
GO
