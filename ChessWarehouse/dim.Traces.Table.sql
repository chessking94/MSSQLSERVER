﻿USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[Traces](
	[TraceKey] [char](1) COLLATE Latin1_General_CS_AS NOT NULL,
	[TraceDescription] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Scored] [bit] NULL,
 CONSTRAINT [PK_Traces] PRIMARY KEY CLUSTERED 
(
	[TraceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dim].[Traces] ADD  DEFAULT ((0)) FOR [Scored]
GO