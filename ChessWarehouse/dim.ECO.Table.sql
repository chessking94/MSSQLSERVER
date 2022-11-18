﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[ECO](
	[ECOID] [smallint] IDENTITY(1,1) NOT NULL,
	[ECO_Code] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Opening_Name] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Variation_Name] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ECO] PRIMARY KEY CLUSTERED 
(
	[ECOID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ECO_ECOCode] UNIQUE NONCLUSTERED 
(
	[ECO_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
