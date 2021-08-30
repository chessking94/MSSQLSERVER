USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sqlSplit] (@CharacterExpression varchar(8000), @Delimiter char(1), @Position int)

RETURNS varchar(8000)

AS

--function taken from the CPLS SQL database FASTRpt

BEGIN
	IF @Position<1
	BEGIN
		RETURN NULL
	END

	IF LEN(@Delimiter) <> 1
	BEGIN
		RETURN NULL
	END

	DECLARE @Start int
	DECLARE @End int

	SET @Start = 1
	WHILE @Position > 1
	BEGIN
		SET @Start = ISNULL(CHARINDEX(@Delimiter, @CharacterExpression, @Start), 0)
		IF @Start = 0
		BEGIN
			RETURN NULL
		END
		SET @Position = @Position - 1
		SET @Start = @Start + 1
	END

	SET @End = ISNULL(CHARINDEX(@Delimiter, @CharacterExpression, @Start), 0)

	IF @End = 0
	BEGIN
		SET @End = LEN(@CharacterExpression) + 1
	END

	RETURN SUBSTRING(@CharacterExpression, @Start, @End - @Start)
END
GO
