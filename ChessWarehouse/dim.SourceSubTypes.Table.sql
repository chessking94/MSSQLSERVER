﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[SourceSubTypes](
	[SourceSubTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[SourceSubTypeName] [varchar](26) NOT NULL,
 CONSTRAINT [PK_SourceSubTypes] PRIMARY KEY CLUSTERED 
(
	[SourceSubTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
