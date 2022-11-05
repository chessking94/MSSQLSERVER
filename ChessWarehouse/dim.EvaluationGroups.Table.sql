USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[EvaluationGroups](
	[EvaluationGroupID] [smallint] IDENTITY(1,1) NOT NULL,
	[LBound] [decimal](5, 2) NOT NULL,
	[UBound] [decimal](5, 2) NOT NULL,
	[Meaning] [varchar](8) NULL,
	[Range] [varchar](15) NULL,
 CONSTRAINT [PK_EvaluationGroups] PRIMARY KEY CLUSTERED 
(
	[EvaluationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
