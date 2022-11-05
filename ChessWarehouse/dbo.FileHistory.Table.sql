USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileHistory](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileTypeID] [smallint] NOT NULL,
	[Filename] [varchar](100) NOT NULL,
	[DateStarted] [datetime] NOT NULL,
	[DateCompleted] [datetime] NULL,
	[Records] [int] NULL,
	[Errors] [int] NULL,
 CONSTRAINT [PK_FileHistory] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileHistory] ADD  CONSTRAINT [DF_FileHistory_DateStarted]  DEFAULT (getdate()) FOR [DateStarted]
GO
ALTER TABLE [dbo].[FileHistory]  WITH CHECK ADD  CONSTRAINT [FK_FileHistory_FileTypes] FOREIGN KEY([FileTypeID])
REFERENCES [dbo].[FileTypes] ([FileTypeID])
GO
ALTER TABLE [dbo].[FileHistory] CHECK CONSTRAINT [FK_FileHistory_FileTypes]
GO
