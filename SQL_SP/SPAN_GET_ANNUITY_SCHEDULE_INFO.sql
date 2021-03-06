USE [ABS_LIFE_STAGING]
GO
/****** Object:  StoredProcedure [dbo].[SPAN_GET_ANNUITY_SCHEDULE_INFO]    Script Date: 08/24/2015 16:13:31 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER proc  [dbo].[SPAN_GET_ANNUITY_SCHEDULE_INFO]
(		
	

		@pPolicyNo  nvarchar(50)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	

 )
 --with encryption
AS
/***************************************
	    Author      : James C. Nnannah
	    Create date : 18th  August 2015
	    Description : Used to return the information needed on the various documents to be issued in the annuity module
	    Version     : 1
	    
	    Modification: By Femi, set names to columns that returns (no column name = Assured_Email and Assured_PhoneNumber), ADDED ASSURED_ADDRESS TO THE QUERY
	    
    ******************************************/
    
     /***************************************
	    Modified by      : Adebayo A. Azeez
	    Modified date : 20th  August 2015
	    Added Columns : [TBIL_ANN_POLY_PRPSAL_ISSUE_DATE], [TBIL_ANN_POLY_ASSRD_BDATE, POLICY_PERIOD], TBIL_PRDCT_DTL_DESC, TBIL_PREM_PAYABLE_WORD
	    Version     : 1.1
    ******************************************/
		
		set @pParam1 = REPLACE(@pParam1,N'''',N'--');
		set @pParam1 = REPLACE(@pParam1,N'--',N'--');		
		set @pParam1 = REPLACE(@pParam1,N';',N'--');				
		set @pParam1 = REPLACE(@pParam1,N'/* ... */',N'--');	
		set @pParam1 = REPLACE(@pParam1,N'xp_',N'--');

		set @pParam2 = REPLACE(@pParam2,N'''',N'--');
		set @pParam2 = REPLACE(@pParam2,N'--',N'--');		
		set @pParam2 = REPLACE(@pParam2,N';',N'--');				
		set @pParam2 = REPLACE(@pParam2,N'/* ... */',N'--');	
		set @pParam2 = REPLACE(@pParam2,N'xp_',N'--');

		set @pParam3 = REPLACE(@pParam3,N'''',N'--');
		set @pParam3 = REPLACE(@pParam3,N'--',N'--');		
		set @pParam3 = REPLACE(@pParam3,N';',N'--');				
		set @pParam3 = REPLACE(@pParam3,N'/* ... */',N'--');	
		set @pParam3 = REPLACE(@pParam3,N'xp_',N'--');
	
		
		
	BEGIN
		
		SELECT 
			 [TBIL_ANN_POLY_FILE_NO]
			,[TBIL_ANN_POLY_PROPSAL_NO]
			,[TBIL_ANN_POLY_POLICY_NO]
			,[TBIL_ANN_POLY_PRDCT_CD]
			,[TBIL_ANN_POLY_PLAN_CD]
			,[TBIL_ANN_POLY_COVER_CD]
			,[TBIL_ANN_POLY_PROPSL_ACCPT_DT]
			,i.[TBIL_ANN_POL_PRM_FROM] as TBIL_POLICY_COMMENCEMENT_DT
			,[TBIL_ANN_POLY_ASSRD_AGE]
			,[TBIL_ANN_POLY_GENDER]
			,'ASSURED_GENDER' = CASE WHEN [TBIL_ANN_POLY_GENDER] = 'M' THEN 'MALE' WHEN [TBIL_ANN_POLY_GENDER] = 'F' THEN 'FEMALE' END
			,[TBIL_ANN_POLY_MARITAL]
			,[TBIL_ANN_POLY_OCCUPATN]
			,[TBIL_ANN_POLY_PRPSAL_ISSUE_DATE]
			,[TBIL_ANN_POLY_ASSRD_BDATE]
			,i.[TBIL_ANN_POL_PRM_TO] AS [TBIL_POLICY_END_DT]
			,'POLICY_PERIOD'= DATEDIFF(YEAR, i.[TBIL_ANN_POL_PRM_FROM], i.[TBIL_ANN_POL_PRM_TO])
			,dbo.Cifn_FormattedDate(i.[TBIL_ANN_POL_PRM_FROM]) as FORMATTED_COMMENCEMENT_DT
			,dbo.Cifn_FormattedDate(GETDATE()) as TODAYS_DATE
			,dbo.Cifn_FormattedDate([TBIL_ANN_POLY_PRPSAL_ISSUE_DATE]) as FORMATTED_PROPOSAL_DT
			,(select  isnull(b.TBIL_INSRD_SURNAME,'') + ' ' + ISNULL( b.TBIL_INSRD_FIRSTNAME,'') 
			  from tbil_ins_detail b where b.TBIL_INSRD_CODE = p.TBIL_ANN_POLY_ASSRD_CD AND b.TBIL_INSRD_MDLE IN ('ANN','A')) as Assured_Name
		 ,(SELECT  ISNULL([TBIL_INSRD_PHONE1],'') + ', ' + ISNULL(TBIL_INSRD_PHONE2,'')  FROM [TBIL_INS_DETAIL] b 
	       WHERE b.TBIL_INSRD_CODE = p.tbil_ann_poly_assrd_cd AND b.TBIL_INSRD_MDLE IN ('ANN','A')) AS 'ASSURED_PHONE_NUMBER'
    	  , (SELECT  ISNULL([TBIL_INSRD_EMAIL1],'') + ', ' + ISNULL(TBIL_INSRD_EMAIL2,'') 
  			FROM [TBIL_INS_DETAIL] b WHERE b.TBIL_INSRD_CODE = p.tbil_ann_poly_assrd_cd AND b.TBIL_INSRD_MDLE IN ('ANN','A')) AS 'ASSURED_EMAIL'	
  	, (SELECT  ISNULL([TBIL_INSRD_ADRES1],'') + ', ' + ISNULL([TBIL_INSRD_ADRES2],'') 
  			FROM [TBIL_INS_DETAIL] b WHERE b.TBIL_INSRD_CODE = p.tbil_ann_poly_assrd_cd AND b.TBIL_INSRD_MDLE IN ('ANN','A')) AS 'ASSURED_ADDRESS'							
			,i.[TBIL_ANN_POL_PRM_SA_LC] as TBIL_PREM_PAYABLE
			,[dbo].[udf_NumberToEnglishWords](i.[TBIL_ANN_POL_PRM_SA_LC]) as TBIL_PREM_PAYABLE_WORD
			--,i.[TBIL_ANN_POL_PRM_ANN_CONTRIB_LC] as TBIL_ANNUAL_PREM
			,i.[TBIL_ANN_POL_PRM_MTH_CONTRIB_LC] as TBIL_MONTH_PREM
			,[TBIL_ANN_POLY_LAST_EMPLOYER]
			,[TBIL_ANN_POLY_LAST_EMPLOYER_ADRES]
			,[TBIL_ANN_POLY_RETIREE_PFA]
			,[TBIL_ANN_POLY_RETIREE_PIN_NO]
			,[TBIL_ANN_POLY_RETIREE_OCCUP]
			,[TBIL_ANN_POLY_RETIREMENT_DATE]
			,[TBIL_ANN_POLY_ACCOUNT_NAME]
			,[TBIL_ANN_POLY_ACCOUNT_NO]
			,[TBIL_ANN_POLY_BANK_NAME]
			,[TBIL_ANN_POLY_BANK_ADRES]
			,[TBIL_ANN_POLY_BANK_SORT_CODE]			
			,i.[TBIL_ANN_POL_PRM_SA_CURRCY]
			,PROD_DTL.TBIL_PRDCT_DTL_DESC

	FROM [TBIL_ANN_POLICY_DET] p
	INNER JOIN [TBIL_ANN_POLICY_PREM_INFO] i ON p.[TBIL_ANN_POLY_POLICY_NO] = i.[TBIL_ANN_POL_PRM_POLY_NO]
	LEFT JOIN [TBIL_PRODUCT_DETL]  PROD_DTL
    ON (PROD_DTL.TBIL_PRDCT_DTL_CODE = p.TBIL_ANN_POLY_PRDCT_CD AND PROD_DTL.TBIL_PRDCT_DTL_CAT IN('ANN','A'))
	WHERE p.[TBIL_ANN_POLY_POLICY_NO] = RTRIM(LTRIM(@pPolicyNo))
				  						  			
		END	
				 
return 0


