USE [ChessAnalysis]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [varchar](256) NOT NULL,
	[EventType] [varchar](50) NOT NULL,
	[ObjectName] [varchar](256) NOT NULL,
	[ObjectType] [varchar](25) NOT NULL,
	[SqlCommand] [varchar](max) NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[LoginName] [varchar](256) NOT NULL,
 CONSTRAINT [PK_AL_LogID] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF_AL_EventDate]  DEFAULT (getdate()) FOR [EventDate]
GO
