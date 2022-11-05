USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetSettingValue] (@Key varchar(30))

RETURNS varchar(100)

BEGIN
	DECLARE @rtnval varchar(100) = NULL

	--use table key first
	IF ISNUMERIC(@Key) = 1 SELECT @rtnval = Value FROM Settings WHERE ID = @Key

	--if no hits, try using name instead
	IF @rtnval IS NULL SELECT @rtnval = Value FROM Settings WHERE Name = @Key

	RETURN @rtnval
END
GO
