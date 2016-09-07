USE [ABS_LIFE]
GO
/****** Object:  StoredProcedure [dbo].[TBIL_SELECT_CLAIMREQSEARCH]    Script Date: 07/28/2015 15:16:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[TBIL_SELECT_CLAIMREQSEARCH]
	@qryOption int,
	@qryValue varchar(50)
AS
BEGIN

	SET NOCOUNT ON;
if @qryOption = 1 
   select  * from View_TBIL_SELECT_CLAIMREQSEARCH where TBIL_POLY_POLICY_NO like ''+@qryValue+'%'
else if @qryOption=2
   select  * from View_TBIL_SELECT_CLAIMREQSEARCH where TBIL_INSRD_SURNAME like '%'+@qryValue+'%' or TBIL_INSRD_FIRSTNAME like '%'+@qryValue+'%'
else if @qryOption=3
   select  * from View_TBIL_SELECT_CLAIMREQSEARCH where TBIL_CLM_RPTD_CLM_NO = ''+@qryValue+''
     
END
