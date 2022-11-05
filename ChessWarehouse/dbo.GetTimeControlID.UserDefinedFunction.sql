USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTimeControlID] (@TimeControlDetail varchar(15))

RETURNS tinyint

BEGIN
	DECLARE @rtnval tinyint
	DECLARE @sec int

	--check if correspondence first
	IF CHARINDEX('/', @TimeControlDetail) > 0
	BEGIN
		SELECT @rtnval = TimeControlID FROM dim.TimeControls WHERE TimeControlName = 'Correspondence'
	END

	--not correspondence, parse time control to determine where it falls
	IF @rtnval IS NULL
	BEGIN
		SET @sec = CAST(LEFT(@TimeControlDetail, CHARINDEX('+', @TimeControlDetail) - 1) AS int) + 60*(CAST(SUBSTRING(@TimeControlDetail, CHARINDEX('+', @TimeControlDetail) + 1, LEN(@TimeControlDetail)) AS int))
		SELECT @rtnval = TimeControlID FROM dim.TimeControls WHERE @sec >= MinSeconds and @sec <= MaxSeconds
	END

	RETURN @rtnval
END
GO
