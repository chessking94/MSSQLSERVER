USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SDOnlineCandidateMoves] (@MoveID int)
RETURNS decimal(6,4)

AS

BEGIN
	DECLARE @SD float
	DECLARE @ct int

	SET @ct = (SELECT CandidateMoves FROM OnlineMoves WHERE MoveID = @MoveID)

	IF @ct = 0
	BEGIN
		SET @SD = NULL
	END
	ELSE IF @ct = 1
	BEGIN
		SET @SD = 0.0000
	END
	ELSE
	BEGIN
		SET @SD =
		(SELECT
			STDEV(CASE WHEN LEFT(sd.value, 2) = '#+' THEN 100.00 WHEN LEFT(sd.value, 2) = '#-' THEN -100.00 ELSE sd.value END)

			FROM
			(SELECT TOP (@ct)
				*
				FROM
				(SELECT
					MoveID, 
					T1_Eval,
					T2_Eval,
					T3_Eval,
					T4_Eval,
					T5_Eval,
					T6_Eval,
					T7_Eval,
					T8_Eval,
					T9_Eval,
					T10_Eval,
					T11_Eval,
					T12_Eval,
					T13_Eval,
					T14_Eval,
					T15_Eval,
					T16_Eval,
					T17_Eval,
					T18_Eval,
					T19_Eval,
					T20_Eval,
					T21_Eval,
					T22_Eval,
					T23_Eval,
					T24_Eval,
					T25_Eval,
					T26_Eval,
					T27_Eval,
					T28_Eval,
					T29_Eval,
					T30_Eval,
					T31_Eval,
					T32_Eval

					FROM OnlineMoves
				) tbl

				UNPIVOT

				(
					VALUE
					FOR t_eval IN (T1_Eval,T2_Eval,T3_Eval,T4_Eval,T5_Eval,T6_Eval,T7_Eval,T8_Eval,
									T9_Eval,T10_Eval,T11_Eval,T12_Eval,T13_Eval,T14_Eval,T15_Eval,T16_Eval,
									T17_Eval,T18_Eval,T19_Eval,T20_Eval,T21_Eval,T22_Eval,T23_Eval,T24_Eval,
									T25_Eval,T26_Eval,T27_Eval,T28_Eval,T29_Eval,T30_Eval,T31_Eval,T32_Eval)
				) unpiv

				WHERE unpiv.MoveID = @MoveID
			) sd
		)
	END
	SET @SD = ROUND(@SD,4)

	RETURN @SD
END
GO
