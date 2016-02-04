SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE SPIL_CLAIMSNUM_SEARCH
	--@TBIL_CLM_RPTD_CLM_NO nvarchar(40),
	@sValue varchar(max),
	@sType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


if @sType = 1 

  SELECT TBIL_CLM_RPTD_POLY_NO,[TBIL_INSRD_SURNAME]
      ,[TBIL_INSRD_FIRSTNAME], TBIL_CLM_RPTD_CLM_NO
  FROM [ABS_LIFE].[dbo].[TBIL_POLICY_DET]  
  inner join tbil_ins_detail on tbil_ins_detail.tbil_insrd_code=TBIL_POLICY_DET.tbil_poly_cust_code
  inner join TBIL_CLAIM_REPTED on TBIL_CLAIM_REPTED.TBIL_CLM_RPTD_POLY_NO=TBIL_POLICY_DET.TBIL_POLY_POLICY_NO
    
  where TBIL_CLM_RPTD_CLM_NO=@sValue
  else
  
  SELECT TBIL_CLM_RPTD_POLY_NO,[TBIL_INSRD_SURNAME]
      ,[TBIL_INSRD_FIRSTNAME], TBIL_CLM_RPTD_CLM_NO
  FROM [ABS_LIFE].[dbo].[TBIL_POLICY_DET]  
  inner join tbil_ins_detail on tbil_ins_detail.tbil_insrd_code=TBIL_POLICY_DET.tbil_poly_cust_code
  inner join TBIL_CLAIM_REPTED on TBIL_CLAIM_REPTED.TBIL_CLM_RPTD_POLY_NO=TBIL_POLICY_DET.TBIL_POLY_POLICY_NO
    
  where TBIL_INSRD_SURNAME like '%'+@sValue+'%'
  
  




END
GO
