USE [ABS_LIFE]
GO

/****** Object:  StoredProcedure [dbo].[SPIL_GET_EFFECTED_COVER_DESC]    Script Date: 07/28/2015 10:13:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPIL_GET_EFFECTED_COVER_DESC]
(
	@PARAM_COVER_CD	nvarchar(20)
)
AS
BEGIN
	SELECT WT.TBIL_COV_DESC, WT.TBIL_COV_CD FROM TBIL_COVER_DET AS WT WHERE TBIL_COV_CD=@PARAM_COVER_CD 
END

GO


