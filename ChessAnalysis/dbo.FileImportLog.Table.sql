﻿USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileImportLog](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileTypeID] [int] NULL,
	[Filename] [varchar](100) NULL,
	[DateImported] [datetime] NULL,
	[RowsImported] [int] NULL,
 CONSTRAINT [PK_FIL_FileID] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileImportLog]  WITH CHECK ADD  CONSTRAINT [FK_FIL_FileTypeID] FOREIGN KEY([FileTypeID])
REFERENCES [dbo].[FileImportCrossRef] ([FileTypeID])
GO
ALTER TABLE [dbo].[FileImportLog] CHECK CONSTRAINT [FK_FIL_FileTypeID]
GO
