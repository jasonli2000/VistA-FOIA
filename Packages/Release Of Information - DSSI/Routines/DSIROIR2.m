DSIROIR2 ;AMC/EWL - Document Storage System;ROI Reports (continued) ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2056      GETS^DIQ
 ;
 Q
PRIRTY(AXY,STDT,ENDT,DIVL) ; RPC - DSIR PRIORTY REPORT
 ;Input Parameters
 ;               1 - Start Date (Required)
 ;               2 - End Date (Optional - Defaults to current date)
 ;               3 - Division(s) - Defaults to Users if they don't hold DSIR MDIV key or All if the do hold key
 ;               
 ;Return Array
 ;               -1^Missing Start Date!
 ;               -2^No Records Found!
 ;               H ^ Request IEN ^ Patient (I;E) ^ Date of Request (I;E) ^ Date First Closed (I;E)
 ;               C ^ Request IEN ^ Comment
 ;               C ^ Request IEN ^ Comment
 ;               .
 ;               (Note: Internal Comments field is word processing, C records may occur 0 to infinity.)
 ;               
 S AXY=$NA(^TMP("DSIROIR2",$J)) K @AXY,^TMP("DSIR2",$J)
 N GLRF,LODT,FIL,XX,YY,AA,BB,ROI,FCLD,MDIV,DIV,DIVS,ROI6,SORTNM S GLRF="DSIROIR2",FIL=19620,YY=0
 S STDT=$G(STDT) I 'STDT S ^TMP(GLRF,$J,0)="-1^Missing Start Date!" Q
 S MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]"" I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 S LODT=STDT-.9,ENDT=$G(ENDT),(AA,BB)=$NA(^DSIR(19620,"AOP",LODT)),BB=$P(BB,",",1,2)_"," S:'ENDT ENDT=DT S ENDT=ENDT+.3
 F  S AA=$Q(@AA) Q:AA'[BB!($QS(AA,3)>ENDT)  S ROI=+$QS(AA,4),ROI6=$G(^DSIR(FIL,ROI,6)),DIV=$P(ROI6,U,3) D:ROI
 .Q:'$P(ROI6,U,6)  ;Not High Priority
 .I 'MDIV,DIV'=DUZ(2) Q  ;Multidivisional Check - No key and not in your division
 .I MDIV,DIVS,'$D(DIVS(DIV)) Q  ;Multidivisional Check - Key holder and divisions selected and not a selected division
 .N GET,IENS,Y,ZZ S ZZ=0
 .S IENS=ROI_"," D GETS^DIQ(FIL,IENS,".01;10.06;.32","IE","GET")
 .S SORTNM=$G(GET(FIL,IENS,.01,"E"))_";"_$G(GET(FIL,IENS,.01,"I"))
 .S (Y,FCLD)=$P($$FCLOSEDT^DSIROI6(ROI),U) I Y X ^DD("DD") S FCLD=FCLD_";"_Y
 .;     1    2    |--------------------------3--------------------------|   |----------------------------4----------------------------|    5
 .S XX="H^"_ROI_U_$G(GET(FIL,IENS,.01,"I"))_";"_$G(GET(FIL,IENS,.01,"E"))_U_$G(GET(FIL,IENS,10.06,"I"))_";"_$G(GET(FIL,IENS,10.06,"E"))_U_FCLD
 .S YY=YY+1,^TMP("DSIR2",$J,SORTNM,YY)=XX ;^TMP(GLRF,$J,YY)=XX
 .F  S ZZ=$O(GET(FIL,IENS,.32,ZZ)) Q:'ZZ  D
 ..S XX="C^"_ROI_U_GET(FIL,IENS,.32,ZZ),YY=YY+1,^TMP("DSIR2",$J,SORTNM,YY)=XX ;^TMP(GLRF,$J,YY)=XX
 I 'YY S ^TMP(GLRF,$J,0)="-2^No Records Found!"
 S SORTNM="",YY=0 F  S SORTNM=$O(^TMP("DSIR2",$J,SORTNM)) Q:SORTNM=""  D
 .S XX=0 F  S XX=$O(^TMP("DSIR2",$J,SORTNM,XX)) Q:'XX  S YY=YY+1,^TMP(GLRF,$J,YY)=^TMP("DSIR2",$J,SORTNM,XX)
 K ^TMP("DSIR2",$J)
 Q
GET ;
 S IENS=IEN_"," D GETS^DIQ(FIL,IENS,"*","EI","GET")
 S RQIEN=+$G(GET(FIL,IENS,.01,"I"))_"," Q:'RQIEN  D GETS^DIQ(19620,RQIEN,"10.06;10.07","EI","GET")
 Q
SET() ;
 ; |-----------1-----------|   |-----------2-----------|   |--------------3-------------|   |--------------4-------------|   |-----------5-----------|   |-----------6-----------|   |-----------7-----------|
 Q $G(GET(FIL,IENS,.04,"E"))_U_$G(GET(FIL,IENS,.01,"E"))_U_$G(GET(19620,RQIEN,10.06,"E"))_U_$G(GET(19620,RQIEN,10.07,"E"))_U_$G(GET(FIL,IENS,.02,"E"))_U_$G(GET(FIL,IENS,.03,"E"))_U_$G(GET(FIL,IENS,.05,"E"))
 ;
STATDISC(AXY,STDT,ENDT,CLRK) ;RPC - DSIR STATUS DISCREPANCY RPT
 ;Input Variables
 ;       Start Date - FileMan Format (Required)
 ;       End Date - FileMan Format (Optional - Defaults to current day)
 ;       Clerk(s) - Array, each element set to the file 200 pointer (DUZ) of selected clerks
 ;       
 ;Return Array
 ;       -1 ^ Missing Start Date!
 ;       -2 ^ No Records Found For Specified Clerk(s)!
 ;       Clerk Name ^ Request Name ^ Open Date ^ Closed Date ^ Status Code ^ Status Date ^ Date User Entered Status
 ;       
 S AXY=$NA(^TMP("DSIROIR2",$J)) K @AXY
 N IEN,FIL,XX,YY,LOOP,XREF,GLRF,CLRKS,ALLCLRK S YY=0,FIL=19620.91,GLRF="DSIROIR2",XREF="AST"
 I '$G(STDT) S ^TMP(GLRF,$J,0)="-1^Missing Start Date!" Q
 S ALLCLRK=$O(CLRK(""))="",ENDT=$G(ENDT) S:'ENDT ENDT=DT
 I 'ALLCLRK S XX=0 F  S XX=$O(CLRK(XX)) Q:XX=""  S CLRKS(CLRK(XX))=""
 S XREF=XREF_$S(ALLCLRK:"DTCL",1:"CLDT")
 I 'ALLCLRK D  S:'YY ^TMP(GLRF,$J,0)="-2^No Records Found For Specified Clerk(s)!" Q
 .S CL=0 F  S CL=$O(CLRKS(CL)) Q:'CL  D
 ..S LODT=STDT-.3 F  S LODT=$O(^DSIR(FIL,XREF,"C",CL,LODT)) Q:'LODT!(LODT>ENDT)  S IEN=0 F  S IEN=$O(^DSIR(FIL,XREF,"C",CL,LODT,IEN)) Q:'IEN  D
 ...Q:$P($G(^DSIR(FIL,IEN,0)),U,3)=$P($P($G(^DSIR(FIL,IEN,0)),U,5),".")
 ...N CSTAT S CSTAT=$E($$CURSTAT^DSIROI6($P($G(^DSIR(FIL,IEN,0)),U))) Q:"CEX"'[CSTAT
 ...N GET,IENS,RQIEN D GET
 ...S ^TMP(GLRF,$J,YY)=$$SET(),YY=YY+1
 S LODT=STDT-.3 F  S LODT=$O(^DSIR(FIL,XREF,"C",LODT)) Q:'LODT!(LODT>ENDT)  D
 .S CL=0 F  S CL=$O(^DSIR(FIL,XREF,"C",LODT,CL)) Q:'CL  D
 ..S IEN=0 F  S IEN=$O(^DSIR(FIL,XREF,"C",LODT,CL,IEN)) Q:'IEN  D
 ...Q:$P($G(^DSIR(FIL,IEN,0)),U,3)=$P($P($G(^DSIR(FIL,IEN,0)),U,5),".")
 ...N GET,IENS,RQIEN D GET
 ...S ^TMP(GLRF,$J,YY)=$$SET(),YY=YY+1
 Q
