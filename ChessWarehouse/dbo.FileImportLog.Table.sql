USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileImportLog](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileTypeID] [smallint] NOT NULL,
	[Filename] [varchar](100) NOT NULL,
	[DateImported] [datetime] NOT NULL,
	[Records] [int] NULL,
	[Errors] [int] NULL,
 CONSTRAINT [PK_FileImportLog] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileImportLog] ADD  CONSTRAINT [DF_FileImportLog_DateImported]  DEFAULT (getdate()) FOR [DateImported]
GO
ALTER TABLE [dbo].[FileImportLog]  WITH CHECK ADD  CONSTRAINT [FK_FileImportLog_FileTypes] FOREIGN KEY([FileTypeID])
REFERENCES [dbo].[FileTypes] ([FileTypeID])
GO
ALTER TABLE [dbo].[FileImportLog] CHECK CONSTRAINT [FK_FileImportLog_FileTypes]
GO
