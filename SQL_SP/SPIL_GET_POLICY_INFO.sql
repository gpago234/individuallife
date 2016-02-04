USE [ABS_LIFE]
GO
/****** Object:  StoredProcedure [dbo].[SPIL_GET_POLICY_INFO]    Script Date: 08/05/2015 10:15:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SPIL_GET_POLICY_INFO]
(
	@PARAM_POL_NO	nvarchar(50)
)
AS
BEGIN
	
	SELECT WK.[TBIL_POLY_ASSRD_CD], WK.TBIL_POLY_STATUS, 
		   WK.TBIL_POLY_AGCY_CODE, WK.TBIL_POLY_LAPSE_DT,
		   WV.TBIL_INSRD_SURNAME, WV.TBIL_INSRD_FIRSTNAME,
		   WS.TBIL_POL_PRM_PRDCT_CD, WS.TBIL_POL_PRM_FROM,
		   WS.TBIL_POL_PRM_TO, WU.TBIL_PRDCT_DTL_DESC,
		  WP.TBIL_AGCY_AGENT_NAME,
		   WAIVERCODE=
			CASE WK.TBIL_POLY_STATUS
			WHEN 'W' THEN 
			(SELECT TOP 1 WT.TBIL_POL_ADD_COVER_CD FROM TBIL_POLICY_ADD_PREM AS WT WHERE TBIL_POL_ADD_POLY_NO=@PARAM_POL_NO )
			END,
		   WAIVER_DT=
			CASE WK.TBIL_POLY_STATUS
			WHEN 'W' THEN 
			(SELECT WT.TBIL_POLY_WAIVER_DT FROM TBIL_POLICY_DET AS WT WHERE TBIL_POLY_POLICY_NO=@PARAM_POL_NO )
			END,
			PAIDUP_DT=
			CASE WK.TBIL_POLY_STATUS
			WHEN 'P' THEN 
			(SELECT WT.TBIL_POLY_PAIDUP_DT FROM TBIL_POLICY_DET AS WT WHERE TBIL_POLY_POLICY_NO=@PARAM_POL_NO )
			END,
			REACTIVATE_DT=
			CASE WK.TBIL_POLY_STATUS
			WHEN 'R' THEN 
			(SELECT WT.TBIL_POLY_REACTIVATE_DT FROM TBIL_POLICY_DET AS WT WHERE TBIL_POLY_POLICY_NO=@PARAM_POL_NO )
			END, 
			CANCEL_DT=
			CASE WK.TBIL_POLY_STATUS
			WHEN 'C' THEN 
			(SELECT WT.TBIL_POLY_CANCEL_DT FROM TBIL_POLICY_DET AS WT WHERE TBIL_POLY_POLICY_NO=@PARAM_POL_NO )
			END
	FROM TBIL_POLICY_DET AS WK 
	INNER JOIN tbil_ins_detail AS WV ON WK.TBIL_POLY_ASSRD_CD=WV.TBIL_INSRD_CODE
    INNER JOIN TBIL_POLICY_PREM_INFO AS WS ON WK.TBIL_POLY_POLICY_NO=WS.TBIL_POL_PRM_POLY_NO
	INNER JOIN TBIL_PRODUCT_DETL AS WU ON WS.TBIL_POL_PRM_PRDCT_CD=WU.TBIL_PRDCT_DTL_CODE
	LEFT OUTER JOIN TBIL_AGENCY_CD AS WP ON WK.TBIL_POLY_AGCY_CODE=WP.TBIL_AGCY_AGENT_CD
	WHERE TBIL_POLY_POLICY_NO=@PARAM_POL_NO
END

