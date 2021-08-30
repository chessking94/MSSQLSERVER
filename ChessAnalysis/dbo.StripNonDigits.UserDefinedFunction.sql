USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StripNonDigits] (@Input VARCHAR(8000))
RETURNS VARCHAR(8000)
WITH SCHEMABINDING

AS

--function taken from the CPLS SQL database FastArgus

BEGIN
	IF @Input IS NULL
	BEGIN
		RETURN NULL
	END

	DECLARE @Pos INTEGER
	DECLARE @Output VARCHAR(8000)
	DECLARE @Ascii INTEGER

	SET @Pos = 1
	SET @Output = ''

	WHILE @Pos <= LEN(@Input)
	BEGIN
		SET @Ascii = ASCII(SUBSTRING(@Input, @Pos, 1))
		IF @Ascii >= 48 AND @Ascii <= 57
		BEGIN
			SET @Output = @Output + CHAR(@Ascii)
		END
		SET @Pos = @Pos + 1
	END

	RETURN @Output
END
GO
