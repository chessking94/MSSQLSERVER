USE [ChessWarehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dim].[TimeControlDetail](
	[TimeControlDetailID] [smallint] IDENTITY(1,1) NOT NULL,
	[TimeControlDetail] [varchar](15) NOT NULL,
	[TimeControlID] [tinyint] NOT NULL,
	[Seconds]  AS (case when charindex('+',[TimeControlDetail])>(0) then CONVERT([smallint],left([TimeControlDetail],charindex('+',[TimeControlDetail])-(1)))  end) PERSISTED,
	[Increment]  AS (case when charindex('+',[TimeControlDetail])>(0) then CONVERT([smallint],substring([TimeControlDetail],charindex('+',[TimeControlDetail])+(1),len([TimeControlDetail])))  end) PERSISTED,
 CONSTRAINT [PK_TimeControlDetail] PRIMARY KEY CLUSTERED 
(
	[TimeControlDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_TimeControlDetail_TimeControlDetail] UNIQUE NONCLUSTERED 
(
	[TimeControlDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dim].[TimeControlDetail]  WITH CHECK ADD  CONSTRAINT [FK_TimeControlDetail_TimeControlID] FOREIGN KEY([TimeControlID])
REFERENCES [dim].[TimeControls] ([TimeControlID])
GO
ALTER TABLE [dim].[TimeControlDetail] CHECK CONSTRAINT [FK_TimeControlDetail_TimeControlID]
GO
