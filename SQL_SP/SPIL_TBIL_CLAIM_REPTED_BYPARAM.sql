
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE SPIL_TBIL_CLAIM_REPTED_BYPARAM
@TBIL_CLM_RPTD_POLY_NO nvarchar(35)=null,
@TBIL_CLM_RPTD_CLM_NO nvarchar(35)=null,
@TBIL_INSRD_SURNAME varchar(50)=null,
@sType int



AS
BEGIN

	SET NOCOUNT ON;
	if @sType=0 
	begin
	select * from View_TBIL_CLAIM_REPTED
end	
	else if @sType=1
	begin
	select * from View_TBIL_CLAIM_REPTED where TBIL_CLM_RPTD_CLM_NO=@TBIL_CLM_RPTD_CLM_NO
	end
	
 else if @sType=2
 begin
	select * from View_TBIL_CLAIM_REPTED where TBIL_CLM_RPTD_POLY_NO=@TBIL_CLM_RPTD_POLY_NO
 
 end
  else if @sType=3
 begin
	select * from View_TBIL_CLAIM_REPTED where TBIL_INSRD_SURNAME=@TBIL_INSRD_SURNAME
 
 end 
END
GO
