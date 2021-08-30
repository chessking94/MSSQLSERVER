USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_csv] (@CharacterExpression varchar(8000), @Position int)

RETURNS VARCHAR(8000)

AS

BEGIN
	SET @CharacterExpression = REPLACE(@CharacterExpression, '""', '''')

	DECLARE @Delimiter varchar(1)
	DECLARE @Ret varchar(8000)

	SET @Delimiter = ','
	IF @Position < 1
	BEGIN
		RETURN NULL
	END

	DECLARE @Start int

	SET @Start = 1

	WHILE @Position > 1
	BEGIN
		SET @Start = ISNULL(CHARINDEX(@Delimiter, @CharacterExpression, @Start), 0)
		IF @Start = 0
		BEGIN
			RETURN NULL
		END
	
		SET @Position = @Position - 1
	
		IF SUBSTRING(@CharacterExpression, @Start + 1, 1) = '"' AND @Position > 1
		BEGIN
			SET @Start = ISNULL(CHARINDEX('"', @CharacterExpression, @Start + 2), 0)
		END
		ELSE
		BEGIN
			SET @Start = @Start + 1
		END
	END

	DECLARE @End int

	IF SUBSTRING(@CharacterExpression, @Start, 1) = '"'
	BEGIN
		SET @End = ISNULL(CHARINDEX('"', @CharacterExpression, @Start + 1), 0) + 1
	END
	ELSE
	BEGIN
		SET @End = ISNULL(CHARINDEX(@Delimiter, @CharacterExpression, @Start), 0)
	END

	IF @End = 0
	BEGIN
		SET @End = LEN(@CharacterExpression) + 1
	END
	SET @Ret = RTRIM(LTRIM(SUBSTRING(@CharacterExpression, @Start, @End - @Start)))
	IF LEN(@Ret) > 1 AND LEFT(@Ret, 1) = '"'
	BEGIN
		SET @Ret = SUBSTRING(@Ret, 2, LEN(@Ret))
	END
	IF RIGHT(@Ret, 1) = '"'
	BEGIN
		SET @Ret = LEFT(@Ret, LEN(@Ret) - 1)
	END
	SET @Ret = LTRIM(RTRIM(@Ret))

	RETURN @Ret
END
GO
