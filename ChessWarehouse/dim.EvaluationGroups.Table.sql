USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[EvaluationGroups](
	[EvaluationGroupID] [tinyint] NOT NULL,
	[LBound] [decimal](5, 2) NULL,
	[UBound] [decimal](5, 2) NULL,
	[Meaning] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Range]  AS ((CONVERT([varchar](7),[LBound])+'_')+CONVERT([varchar](7),[UBound])),
 CONSTRAINT [PK_EvaluationGroups] PRIMARY KEY CLUSTERED 
(
	[EvaluationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
