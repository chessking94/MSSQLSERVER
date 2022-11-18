﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[CPLossGroups](
	[CPLossGroupID] [tinyint] IDENTITY(1,1) NOT NULL,
	[LBound] [decimal](5, 2) NOT NULL,
	[UBound] [decimal](5, 2) NOT NULL,
	[CPLoss_Range] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CPLossGroups] PRIMARY KEY CLUSTERED 
(
	[CPLossGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
