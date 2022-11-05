﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[ECO](
	[ECOID] [smallint] IDENTITY(1,1) NOT NULL,
	[ECO_Code] [char](3) NOT NULL,
	[Opening_Name] [varchar](25) NULL,
	[Variation_Name] [varchar](25) NULL,
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