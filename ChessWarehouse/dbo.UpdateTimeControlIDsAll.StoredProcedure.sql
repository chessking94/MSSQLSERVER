USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTimeControlIDsAll]

AS

UPDATE dim.TimeControlDetail SET TimeControlID = dbo.GetTimeControlID(TimeControlDetail)
GO
