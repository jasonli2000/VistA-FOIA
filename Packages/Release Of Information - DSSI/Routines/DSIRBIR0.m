DSIRBIR0 ;AMC/EWL - Document Storage Systems;Billing Report RPC's continued ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2056  GETS^DIQ
 Q
DIVLOAD ;Load the array DIVS with the internal division numbers passed in for multi-divisional processing.
 S MDIV=$D(^XUSEC("DSIR MDIV",DUZ)) S DIVS=$G(DIVL)]"" I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 Q
 ;
DIV(ROI) ;Determine if this request is within the Multi-Divisional logic
 N DIV,ROI6
 S ROI6=$G(^DSIR(ROI,6)),DIV=$P(ROI6,U,3)
 Q:DIV="" 1 ;No division for request, show on all reports
 I 'MDIV,DIV'=DUZ(2) Q 0 ;Multidivisional Check - No key and not in your division
 I MDIV,DIVS,'$D(DIVS(DIV)) Q 0 ;Multidivisional Check - Key holder and divisions selected and not a selected division
 Q 1 ;Valid request for the report
 ;
FEESREC(AXY,STDT,ENDT,DIV) ;RPC - DSIR FEES REC RPT
 ;Input Parameters:
 ;     STDT - Start Date (Required, FileMan format)
 ;     ENDT - End Date (Optional, FileMan format, Default = Current day)
 ;     DIVISION - String of Division or NULL for all
 ;                       
 ;Return Array:
 ;     -1^Missing Start Date!
 ;     -2^No Payment Activity Found for Date Range!
 ;     Bill IEN ^ Patient Name/FOIA ^ Requestor ^ Open Date ^ Bill Entered Date ^ Current Status ^ Payment Date ^ Payment Amount ^ Waived ^ Allowance ^ Division
 ;                       
 N RDIV,DIVT,DLIST1,DLIST,NLIST,IEN,I S AXY=$NA(^TMP("DSIRFEES",$J)) K @AXY,^TMP("DSIR",$J)
 I $G(DIV)  F I=0:1 Q:'$P(DIV,U,I+1)  S DLIST(I)=$P(DIV,U,I+1),NLIST(I)=$P(^DIC(4,DLIST(I),0),U)
 I '$G(DIV) I '$D(^XUSEC("DSIR MDIV",DUZ)) S DIV=DUZ(2),DLIST(0)=DIV,NLIST(0)=$P(^DIC(4,DIV,0),U),I=1
 I '$G(DIV) D GETDIVS^DSIROI1(.DLIST1) F I=0:1 Q:'$D(DLIST1(I))  S DLIST(I)=$P(DLIST1(I),U),NLIST(I)=$P(DLIST1(I),U,2)
 N GLRF,ROI,LODT,FIL,IEN,GET,XRF,PAY,XX,YY,BILN,BILIEN,OPDT,MDIV,DIVS,STAT,BILLS,BILDT,ALLOW,WAVE,PAYDT,PAYMT
 S YY=0,I=I-1,GLRF="DSIRFEES",STDT=+$G(STDT),ENDT=+$G(ENDT) S:'ENDT ENDT=DT
 I 'STDT S ^TMP(GLRF,$J,0)="-1^Missing Start Date!" Q
 S LODT=STDT-.1,FIL=19620.21,XRF="APD"
 F  S LODT=$O(^DSIR(FIL,XRF,LODT)) Q:'LODT!(LODT>ENDT)  S PAY=0 F  S PAY=$O(^DSIR(FIL,XRF,LODT,PAY)) Q:'PAY  D
 .K GET S IEN=PAY_"," D GETS^DIQ(FIL,IEN,"*","IE","GET")
 .S BILN=$G(GET(FIL,IEN,.01,"E")),BILIEN=+$G(GET(FIL,IEN,.01,"I")),ALLOW=$G(GET(FIL,IEN,.07,"I")),WAVE=$G(GET(FIL,IEN,.05,"I")) Q:'BILIEN
 .S BILLS=BILIEN_"," D GETS^DIQ(19620.2,BILLS,".01;.02","IE","GET") S ROI=+$G(GET(19620.2,BILLS,.01,"I"))
 .S BILDT=$G(GET(19620.2,BILLS,.02,"I")),DIVT=$$DIVTEST^DSIROI1(ROI,.DLIST) S:DIVT<0 ROI=0
 .Q:'ROI  S PAYDT=$G(GET(FIL,IEN,.06,"I")),PAYMT=$G(GET(FIL,IEN,.02,"I")) D ROIDATA(ROI)
 .S XX=BILIEN_U_BILN_U_REQTR_U_OPDT_U_BILDT_U_STAT_U_PAYDT_U_PAYMT_U_WAVE_U_ALLOW_U_DLIST(DIVT)_U_NLIST(DIVT)
 .S YY=YY+1,^TMP("DSIR",$J,BILN,YY)=XX
 S BILN="",YY=0
 F  S BILN=$O(^TMP("DSIR",$J,BILN)) Q:BILN=""  S XX=0 F  S XX=$O(^TMP("DSIR",$J,BILN,XX)) Q:'XX  S YY=YY+1,RDIV=$P(^TMP("DSIR",$J,BILN,XX),U,12),^TMP(GLRF,$J,RDIV,YY)=^TMP("DSIR",$J,BILN,XX)
 S:'YY ^TMP(GLRF,$J,0)="-2^No Payment Activity Found for Date Range!"
 K ^TMP("DSIR",$J) Q
 ;
FEESOUT(AXY,DIV) ;RPC - DSIR FEES OUT RPT
 ;Input Parameters
 ;     Divisions
 ;
 ;Return Array:
 ;     -1^No Fees Outstanding Found!
 ;     Bill IEN ^ Patient Name/FOIA ^ Requestor ^ Open Date ^ Bill Entered Date ^ Current Status ^ Current Balance Due ^ Division ^ Division Name
 ;
 S AXY=$NA(^TMP("DSIRFEES",$J)) K @AXY,^TMP("DSIR",$J) N DLIST,DLIST1,I,NLIST
 I $G(DIV)  F I=0:1 Q:'$P(DIV,U,I+1)  S DLIST(I)=$P(DIV,U,I+1),NLIST(I)=$P(^DIC(4,DLIST(I),0),U)
 I '$G(DIV) I '$D(^XUSEC("DSIR MDIV",DUZ)) S DIV=DUZ(2),DLIST(0)=DIV,NLIST(0)=$P(^DIC(4,DIV,0),U),I=1
 I '$G(DIV) D GETDIVS^DSIROI1(.DLIST1) F I=0:1 Q:'$D(DLIST1(I))  S DLIST(I)=$P(DLIST1(I),U),NLIST(I)=$P(DLIST1(I),U,2)
 N DIVT,RDIV,GLRF,ROI,BAL,BILN,BILIEN,IEN,FIL,GET,XRF,MDIV,DIVS,OPDT,BILDT,REQTR,STAT
 S I=I-1,GLRF="DSIRFEES",FIL=19620.2,XRF="ACBD",(BAL,YY)=0
 F  S BAL=$O(^DSIR(FIL,XRF,BAL)) Q:'BAL  S BILIEN=0 F  S BILIEN=$O(^DSIR(FIL,XRF,BAL,BILIEN)) Q:'BILIEN  D
 .I BAL>0.00999 D
 ..K GET S IEN=BILIEN_"," D GETS^DIQ(FIL,IEN,".01;.02","IE","GET") S ROI=+$G(GET(FIL,IEN,.01,"I")) Q:'ROI
 ..S DIVT=$$DIVTEST^DSIROI1(ROI,.DLIST) Q:DIVT<0 
 ..D ROIDATA(ROI) S BILN=$G(GET(FIL,IEN,.01,"E")),BILDT=$G(GET(FIL,IEN,.02,"I"))
 ..S YY=YY+1,XX=BILIEN_U_BILN_U_REQTR_U_OPDT_U_BILDT_U_STAT_U_BAL_U_DLIST(DIVT)_U_NLIST(DIVT),^TMP("DSIR",$J,BILN,YY)=XX
 S BILN="",YY=0 F  S BILN=$O(^TMP("DSIR",$J,BILN)) Q:BILN=""  S XX=0 F  S XX=$O(^TMP("DSIR",$J,BILN,XX)) Q:'XX  S RDIV=$P(^TMP("DSIR",$J,BILN,XX),U,9),YY=YY+1,^TMP(GLRF,$J,RDIV,YY)=^TMP("DSIR",$J,BILN,XX)
 S:'YY ^TMP(GLRF,$J,0)="-1^No Fees Outstanding Found!"
 K ^TMP("DSIR",$J) Q
 ;
AMTBILD(AXY,STDT,ENDT,DIV) ;RPC - DSIR AMOUNT BILLED RPT
 ;Input Parameters:
 ;     Start Date - Required (FM fromat)
 ;     End Date - Optional (FM format, default = Current date)
 ;     Divisions
 ;                               
 ;Return Array:
 ;     -1^Missing Start Date!
 ;     -2^No bills entered in selected date range!
 ;     Bill IEN ^ Patient Name/FOIA ^ Requestor ^ Open Date ^ Bill Entered Date ^ Current Status ^ Amount Billed ^ Division
 ;                               
 S AXY=$NA(^TMP("DSIRAMTB",$J)) K @AXY,^TMP("DSIR",$J)  N DLIST,DLIST1,I,NLIST
 I $G(DIV)  F I=0:1 Q:'$P(DIV,U,I+1)  S DLIST(I)=$P(DIV,U,I+1),NLIST(I)=$P(^DIC(4,DLIST(I),0),U)
 I '$G(DIV) I '$D(^XUSEC("DSIR MDIV",DUZ)) S DIV=DUZ(2),DLIST(0)=DIV,NLIST(0)=$P(^DIC(4,DIV,0),U),I=1
 I '$G(DIV) D GETDIVS^DSIROI1(.DLIST1) F I=0:1 Q:'$D(DLIST1(I))  S DLIST(I)=$P(DLIST1(I),U),NLIST(I)=$P(DLIST1(I),U,2)
 S STDT=+$G(STDT),ENDT=$S(+$G(ENDT):ENDT,1:DT)+.3
 I 'STDT S ^TMP("DSIRAMTB",$J,0)="-1^Missing Start Date!" Q
 N GLRF,DIVT,RDIV,ROI,BAL,BIL,BILN,IEN,FIL,GET,XRF,MDIV,DIVS,OPDT,BILDT,REQTR,LODT,AA,BB
 S I=I-1,GLRF="DSIRAMTB",FIL=19620.2,XRF="ADENT",YY=0,LODT=STDT-.1
 F  S LODT=$O(^DSIR(FIL,XRF,LODT)) Q:'LODT!(LODT>ENDT)  S BIL=0 F  S BIL=$O(^DSIR(FIL,XRF,LODT,BIL)) Q:'BIL  D
 .S IEN=BIL_"," K GET D GETS^DIQ(FIL,IEN,".01;2.01","IE","GET")
 .S ROI=+$G(GET(FIL,IEN,.01,"I")) Q:'ROI
 .S DIVT=$$DIVTEST^DSIROI1(ROI,.DLIST) Q:DIVT<0
 .D ROIDATA(ROI)
 .S BILN=$G(GET(FIL,IEN,.01,"E")),BILDT=LODT\1,BAL=$G(GET(FIL,IEN,2.01,"I")) I BAL>0.00999 D
 ..S XX=$G(GET(FIL,IEN,.01,"I"))_U_BILN_U_REQTR_U_OPDT_U_BILDT_U_STAT_U_BAL_U_DLIST(DIVT)_U_NLIST(DIVT),YY=YY+1,^TMP("DSIR",$J,BILN,YY)=XX
 .K GET
 S (AA,BB)=$NA(^TMP("DSIR",$J)),BB=$P(BB,")")_",",YY=0
 F  S AA=$Q(@AA) Q:AA'[BB  S RDIV=$P(@AA,U,9),YY=YY+1,^TMP(GLRF,$J,RDIV,YY)=@AA
 I 'YY S ^TMP(GLRF,$J,0)="-2^No bills entered in selected date range!"
 K ^TMP("DSIR",$J) Q
 ;
ROIDATA(ROI) ;Get the instance level data, Current Status, Open Date & Requestor
 N GET,ROIS,FIL S FIL=19620,ROIS=ROI_","
 D GETS^DIQ(FIL,ROIS,"10.06;.11","IE","GET")
 S OPDT=$G(GET(FIL,ROIS,10.06,"I")),REQTR=$G(GET(FIL,ROIS,.11,"E")),STAT=$P($$STONDAT^DSIROI6(ROI,DT),U,2)
 Q
