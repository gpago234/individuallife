USE [ABS_LIFE]
GO
/****** Object:  StoredProcedure [dbo].[SPIL_GET_LAST_PREMIUM_PAID_DATE]    Script Date: 08/11/2015 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SPIL_GET_LAST_PREMIUM_PAID_DATE]
@pPolicyNo nvarchar(50)
AS
BEGIN
declare @Division_Result numeric(18,2),
@StartDate as datetime,
@endDate as datetime,
@Monthly_Premium numeric(18,2),
@Last_Premium_Paid_Date as datetime,
@Date_diff as int,
@Mode_of_Payment as char(1),
@Payment_Amount numeric(18,2)

SELECT @StartDate=(SELECT TBIL_POL_PRM_FROM FROM TBIL_POLICY_PREM_INFO 
WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)

SELECT @endDate=(SELECT TBIL_POL_PRM_TO FROM TBIL_POLICY_PREM_INFO 
WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)

SELECT @Mode_of_Payment=(SELECT TBIL_POL_PRM_MODE_PAYT FROM TBIL_POLICY_PREM_INFO 
 WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)
 
		 IF @Mode_of_Payment='Y'
		 BEGIN 
		 SELECT @Payment_Amount=(SELECT TBIL_POL_PRM_ANN_CONTRIB_LC FROM TBIL_POLICY_PREM_INFO 
		 WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)

			 IF @Payment_Amount > 0
					BEGIN
						SELECT @Last_Premium_Paid_Date=(SELECT
						(DATEADD(year, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount), @StartDate)) AS LAST_PREMIUM_PAID_DATE
						FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N')
						
						--SELECT @Last_Premium_Paid_Date=(SELECT
						--(DATEADD(month, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount) * 12, @StartDate)) AS LAST_PREMIUM_PAID_DATE
						--FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N')
			            
						SELECT SUM(TBFN_TRANS_TOT_AMT) AS ALLOCATION_AMOUNT, TBFN_TRANS_POLY_NO, @StartDate AS STARTDATE,
						@endDate as [END DATE], @Mode_of_Payment AS [PAYMENT_MODE],
						@Payment_Amount AS YEARLY_PREMIUM, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount) AS No_Years_Paid,
						@Last_Premium_Paid_Date AS LAST_PREMIUM_PAID_DATE
					   FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N' GROUP BY TBFN_TRANS_POLY_NO
					END
			 END
			 
		IF @Mode_of_Payment='M'
		 BEGIN 
		 SELECT @Payment_Amount=(SELECT TBIL_POL_PRM_MTH_CONTRIB_LC FROM TBIL_POLICY_PREM_INFO 
		 WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)

			  IF @Payment_Amount > 0
					BEGIN
						SELECT @Last_Premium_Paid_Date=(SELECT
						(DATEADD(MONTH, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount), @StartDate)) AS LAST_PREMIUM_PAID_DATE
						FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N')
			            
						SELECT SUM(TBFN_TRANS_TOT_AMT) AS ALLOCATION_AMOUNT, TBFN_TRANS_POLY_NO, @StartDate AS STARTDATE,
						@endDate as [END DATE], @Mode_of_Payment AS [PAYMENT_MODE],
						@Payment_Amount AS MONTHLY_PREMIUM, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount) AS No_Months_Paid,
						@Last_Premium_Paid_Date AS LAST_PREMIUM_PAID_DATE
					   FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N' GROUP BY TBFN_TRANS_POLY_NO
					END
			 END
			 
			 IF @Mode_of_Payment='Q'
		 BEGIN 
		 SELECT @Payment_Amount=(SELECT TBIL_POL_PRM_MTH_CONTRIB_LC FROM TBIL_POLICY_PREM_INFO 
		 WHERE TBIL_POL_PRM_POLY_NO=@pPolicyNo)

			  IF @Payment_Amount > 0
					BEGIN
						SELECT @Last_Premium_Paid_Date=(SELECT
						(DATEADD(MONTH, (SUM(TBFN_TRANS_TOT_AMT)/@Payment_Amount), @StartDate)) AS LAST_PREMIUM_PAID_DATE
						FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N')
			            
						SELECT SUM(TBFN_TRANS_TOT_AMT) AS ALLOCATION_AMOUNT, TBFN_TRANS_POLY_NO, @StartDate AS STARTDATE,
						@endDate as [END DATE], @Mode_of_Payment AS [PAYMENT_MODE],
						@Payment_Amount * 4 AS QUATERLY_PREMIUM, (SUM(TBFN_TRANS_TOT_AMT)/(@Payment_Amount* 4)) AS No_Quaters_Paid,
						@Last_Premium_Paid_Date AS LAST_PREMIUM_PAID_DATE
					   FROM TBFN_ALLOC_DETAIL WHERE TBFN_TRANS_POLY_NO=@pPolicyNo AND TBFN_TRANS_TYPE='N' GROUP BY TBFN_TRANS_POLY_NO
					END
			 END
END
