DSIROIR1 ;AMC/EWL - Document Storage System;ROI Reports (continued) ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10046 $$EN^XUWORKDY
 ;2056  GETS^DIQ
 ;10060 $$GET1^DIQ(200,duz,.01)
 ;
 Q
TURN(AXY,STDT,ENDT,DIVL) ;RPC - DSIR TURNAROUND TIME REPORT
 ; INPUT PARAMETERS: 
 ;   STDT = START DATE
 ;   ENDT = END DATE
 ;   DIVL = DIVISION LIST
 ; RETURNS AN ARRAY AS FOLLOWS:
 ; Return Array '^' Delimited:
 ;   1  ROI Instance IEN (integer)
 ;   2  Patient/FOIA (text)
 ;   3  Clerk IEN (integer)
 ;   4  Clerk IEN (text)
 ;   5  Work Days to Complete (integer)
 ;   6  Median work days for this clerk (number possible 1 decimal)
 ;   7  Average work days for this clerk (number possible 2 decimals)
 ;   8  Date Request Received (external format)
 ;   9  ROI Instance Closed Date (external format) ***
 ;  10  ROI Instance Current Status (external format)
 ;  11  Division
 ;  12  Division Number
 ;  13  Median work days for this division (number possible 1 decimal)
 ;  14  Average work days for this division (number possible 2 decimals)
 ;  15  Median work days Total (number possible 1 decimal)
 ;  16  Average work days Total (number possible 2 decimals)
 ;
 S AXY=$NA(^TMP("DSIRTAT",$J)) K @AXY,^TMP("DSIRTA",$J)
 N MDIV,DIVS,OPDT,CLDT,LDT,WRKD,ROI,ROI10,ROI0,II
 N CLRK,CLRKNAM,CCNT,CWRKD
 N DIV,DCNT,DWRKD,DAVG,DMED
 N TCNT,TWRKD,TAVG,TMED
 S (CCNT,DCNT,DCNT,CWRKD,DWRKD,TWRKD)=0,MDIV=$D(^XUSEC("DSIR MDIV",DUZ))
 ;
 S STDT=+$G(STDT),ENDT=+$G(ENDT) S:'STDT STDT=0 S:'ENDT ENDT=DT
 S DIVS=$G(DIVL)]"" I DIVS F II=1:1:$L(DIVL,U) S:$P(DIVL,U,II) DIVS($P(DIVL,U,II))=""
 ;
 S LDT=0 I STDT S X1=STDT,X2=-1 D C^%DTC S LDT=X
 F  S LDT=$O(^DSIR(19620,"AFCLD",LDT)) Q:'LDT!(LDT>(ENDT))  D
 .S ROI=0 F  S ROI=$O(^DSIR(19620,"AFCLD",LDT,ROI)) Q:'ROI  D
 ..;
 ..S ROI6=$G(^DSIR(19620,ROI,6)),DIV=$P(ROI6,U,3)
 ..;Multidivisional Check - No key and not in your division
 ..I 'MDIV,DIV'=DUZ(2) Q
 ..;Multidivisional Check - Key holder and divisions selected and not a selected division
 ..I MDIV,DIVS,'$D(DIVS(DIV)) Q
 ..;
 ..S ROI10=$G(^DSIR(19620,ROI,10)),ROI0=$G(^DSIR(19620,ROI,0))
 ..S CLRK=$P(ROI0,U,3),CLRKNAM=$$GET1^DIQ(200,CLRK,.01)
 ..;
 ..S OPDT=$P(ROI10,U,6),CLDT=$P(ROI10,U,7) Q:'CLDT!(CLDT'=LDT)
 ..S WRKD=$$EN^XUWORKDY(OPDT,CLDT)-$$PNDCLR^DSIROIR0(ROI,ENDT)-$$PAYPND^DSIROIR0(ROI,ENDT)
 ..S:WRKD<1 WRKD=1
 ..;
 ..S ^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)=""
 ..S ^TMP("DSIRTA",$J,"DIV",DIV,WRKD,ROI)=""
 ..S ^TMP("DSIRTA",$J,"TOT",WRKD,ROI)=""
 ;
 I '$D(^TMP("DSIRTA",$J)) S ^TMP("DSIRTAT",$J,0)="-3^No Records Found in Date Range!" Q
 ;
 ;PROCESS TOTALS DATA
 S WRKD=0,TCNT=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"TOT",WRKD)) Q:'WRKD  D
 .S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"TOT",WRKD,ROI)) Q:'ROI  D
 ..S TCNT=TCNT+1,TWRKD=TWRKD+WRKD,^TMP("DSIRTA",$J,"T",TCNT)=WRKD
 S TAVG=((((TWRKD/TCNT)+.005)*100)\1)/100
 I (TCNT\2*2)'=TCNT S TMED=^TMP("DSIRTA",$J,"T",(TCNT\2)+1)
 I TCNT\2*2=TCNT S TMED=(^TMP("DSIRTA",$J,"T",TCNT/2)+^TMP("DSIRTA",$J,"T",(TCNT/2)+1))/2
 S ^TMP("DSIRTA",$J,"TAVG")=TAVG
 S ^TMP("DSIRTA",$J,"TMED")=TMED
 ;
 ;PROCESS DIVISION DATA
 S DIV=0 F  D:DIV>0 DIVSTATS(DIV) S DIV=$O(^TMP("DSIRTA",$J,"DIV",DIV)) Q:'DIV  S DCNT=0 D
 .S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"DIV",DIV,WRKD)) Q:'WRKD  D 
 ..S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"DIV",DIV,WRKD,ROI)) Q:'ROI  D
 ...S DCNT=DCNT+1,DWRKD=DWRKD+WRKD,^TMP("DSIRTA",$J,"D",DIV,DCNT)=WRKD
 ;
 ;PROCESS CLERK DATA
 S DIV=0 F  S DIV=$O(^TMP("DSIRTA",$J,"CLERK",DIV)) Q:'DIV  D
 .S CLRK=0 F  D:CLRK>0 CLKSTATS(DIV,CLRK) S CLRK=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK)) Q:'CLRK  S CCNT=0 D
 ..S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD)) Q:'WRKD  D
 ...S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)) Q:'ROI  D
 ....S CCNT=CCNT+1,CWRKD=CWRKD+WRKD,^TMP("DSIRTA",$J,"C",DIV,CLRK,CCNT)=WRKD
 ;
 ;PUT TOGETHER OUTPUT DATA
 S CCNT=0,DIV=0 F  S DIV=$O(^TMP("DSIRTA",$J,"CLERK",DIV)) Q:'DIV  D
 .S CLRK=0 F  S CLRK=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK)) Q:'CLRK  D
 ..S WRKD=0 F  S WRKD=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD)) Q:'WRKD  D
 ...S ROI=0 F  S ROI=$O(^TMP("DSIRTA",$J,"CLERK",DIV,CLRK,WRKD,ROI)) Q:'ROI  D
 ....S CCNT=CCNT+1,^TMP("DSIRTAT",$J,CCNT)=$$FORMTAT
 K ^TMP("DSIRTA",$J)
 Q
 ;
FORMTAT() ;GETS ROI INFORMATION FOR DISPLAY
 Q:'$G(ROI) ""
 N GETS,FIL,IEN,FLDS,II,FCLD,CURST,XX,Y S XX="",FIL=19620,IEN=ROI_","
 S FLDS=".01;.03;10.06;10.07;.63"
 D GETS^DIQ(FIL,ROI,FLDS,"E","GETS")
 S FCLD=+$$LASTCLDT^DSIROI6(ROI) S:'FCLD FCLD="" I FCLD S Y=FCLD D DD^%DT S FCLD=Y
 S XX=ROI_U_$G(GETS(FIL,IEN,.01,"E"))_U_$P(^DSIR(19620,ROI,0),U,3)_U
 S XX=XX_$G(GETS(FIL,IEN,.03,"E"))_U_WRKD_U
 S XX=XX_^TMP("DSIRTA",$J,"CMED",DIV,CLRK)_U_^TMP("DSIRTA",$J,"CAVG",DIV,CLRK)_U
 S XX=XX_$G(GETS(FIL,IEN,10.06,"E"))_U_$G(GETS(FIL,IEN,10.07,"E"))_U_$P($$STONDAT^DSIROI6(ROI,DT),U,2)_U
 S XX=XX_DIV_U_$G(GETS(FIL,IEN,.63,"E"))_U_^TMP("DSIRTA",$J,"DMED",DIV)_U_^TMP("DSIRTA",$J,"DAVG",DIV)_U
 S XX=XX_^TMP("DSIRTA",$J,"TMED")_U_^TMP("DSIRTA",$J,"TAVG")
 Q XX
 ;
DIVSTATS(DIVSN) ;
 S DAVG=((((DWRKD/DCNT)+.005)*100)\1)/100
 S ^TMP("DSIRTA",$J,"DAVG",DIVSN)=DAVG
 I (DCNT\2*2)'=DCNT S DMED=^TMP("DSIRTA",$J,"D",DIVSN,(DCNT\2)+1)
 I DCNT\2*2=DCNT S DMED=(^TMP("DSIRTA",$J,"D",DIVSN,DCNT/2)+^TMP("DSIRTA",$J,"D",DIVSN,(DCNT/2)+1))/2
 S ^TMP("DSIRTA",$J,"DMED",DIVSN)=DMED
 S DCNT=0,DWRKD=0
 Q
CLKSTATS(DIVSN,CLERK) ;
 S CAVG=((((CWRKD/CCNT)+.005)*100)\1)/100
 S ^TMP("DSIRTA",$J,"CAVG",DIVSN,CLERK)=CAVG
 I (CCNT\2*2)'=CCNT S CMED=^TMP("DSIRTA",$J,"C",DIVSN,CLERK,(CCNT\2)+1)
 I CCNT\2*2=CCNT S CMED=(^TMP("DSIRTA",$J,"C",DIVSN,CLERK,CCNT/2)+^TMP("DSIRTA",$J,"C",DIVSN,CLERK,CCNT/2+1))/2
 S ^TMP("DSIRTA",$J,"CMED",DIVSN,CLERK)=CMED
 S CCNT=0,CWRKD=0
 Q
 ;
CAS(AXY,PAT,STDT,ENDT) ;RPC - DSIR COMP ACCOUNTING SUMMARY
 S AXY=$NA(^TMP("DSIRCAS",$J)),PAT=+$G(PAT),STDT=+$G(STDT),ENDT=+$G(ENDT) S:'ENDT ENDT=DT K @AXY
 I 'PAT S ^TMP("DSIRCAS",$J,0)="-1^Must have patient pointer!" Q
 I '$D(^DSIR(19620,"APTDT",PAT_";DPT(")) S ^TMP("DSIRCAS",$J,0)="-2^No records found for patient!"
 N ROI,II,LDT,PTRF S II=0,LDT=STDT\1,ENDT=ENDT+.3,PTRF=PAT_";DPT("
 F  S LDT=$O(^DSIR(19620,"APTDT",PTRF,LDT)) Q:'LDT!(LDT>ENDT)  D
 .S ROI=0 F  S ROI=$O(^DSIR(19620,"APTDT",PTRF,LDT,ROI)) Q:'ROI  S ^TMP("DSIRCAS",$J,II)=ROI,II=II+1
 Q 
