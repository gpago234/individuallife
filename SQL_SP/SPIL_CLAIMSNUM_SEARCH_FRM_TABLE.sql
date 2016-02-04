SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE SPIL_CLAIMSNUM_SEARCH_FRM_TABLE 
	-- Add the parameters for the stored procedure here
	@tbil_clm_rptd_clm_no nvarchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT     TBIL_CLAIM_REPTED.*
FROM         TBIL_CLAIM_REPTED
where tbil_clm_rptd_clm_no=@tbil_clm_rptd_clm_no
    
END
GO
