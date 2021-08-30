USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CountMaterialWhite] (@fen varchar(92))
RETURNS int

AS

BEGIN
	SET @fen = LEFT(@fen, CHARINDEX(' ', @fen, 1))
	DECLARE @i int = 1
	DECLARE @materialcount int = 0

	WHILE @i <= LEN(@fen)
		BEGIN
			IF SUBSTRING(@fen, @i, 1) COLLATE Latin1_General_BIN = 'P'
				BEGIN 
					SET @materialcount += 1
				END
			ELSE IF SUBSTRING(@fen, @i, 1) COLLATE Latin1_General_BIN = 'N'
				BEGIN
					SET @materialcount += 3
				END
			ELSE IF SUBSTRING(@fen, @i, 1) COLLATE Latin1_General_BIN = 'B'
				BEGIN
					SET @materialcount += 3
				END
			ELSE IF SUBSTRING(@fen, @i, 1) COLLATE Latin1_General_BIN = 'R'
				BEGIN
					SET @materialcount += 5
				END
			ELSE IF SUBSTRING(@fen, @i, 1) COLLATE Latin1_General_BIN = 'Q'
				BEGIN
					SET @materialcount += 9
				END
			ELSE
				BEGIN
					SET @materialcount = @materialcount
				END
			SET @i += 1
		END
	RETURN @materialcount
END
GO
