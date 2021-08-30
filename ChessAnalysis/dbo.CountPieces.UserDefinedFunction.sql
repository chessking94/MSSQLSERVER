USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CountPieces] (@fen varchar(92))
RETURNS int

AS

BEGIN
	SET @fen = LEFT(@fen, CHARINDEX(' ', @fen, 1))
	DECLARE @i int = 1
	DECLARE @ct int = 0

	WHILE @i <= LEN(@fen)
		BEGIN
			IF SUBSTRING(@fen, @i, 1) IN ('P', 'N', 'B', 'R', 'Q', 'K')
				BEGIN 
					SET @ct += 1
				END
			ELSE
				BEGIN
					SET @ct = @ct
				END
			SET @i += 1
		END
	RETURN @ct
END
GO
