DSIROI7 ;AMC/EWL - Document Storage Systems;ROI ;06/25/2009 13:15
 ;;7.1;DSIR;;JUNE 25, 2009;Build 47
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10009 FILE^DICN
 Q
ADDANNO(AXY,PAT) ;RPC - DSIR ADD ANNOTATION
 ;Input Parameter
 ;       PAT - Patient Pointer (Required - FM Variable Pointer Format)
 ;                       NNNN;DPT(
 ;                       NNNN;DSIR(19620.96,
 ;                       
 ;Return Values
 ;
 ;       -1^Missing/Invalid Patient Pointer!
 ;       -2^Unable to add record!
 ;       NNNN - File Entry Number of added record in 19620.98
 ;       
 ;       
 N DIC,X,Y,FIL
 S PAT=$G(PAT),FIL=U_$P(PAT,";",2)_U I 'PAT!("^DPT(^DSIR(19620.96,^"'[FIL) S AXY="-1^Missing/Invalid Patient Pointer!" Q
 I $O(^DSIR(19620.98,"B",PAT,0)) S AXY=+$O(^DSIR(19620.98,"B",PAT,0))_U_0 Q
 S DIC="^DSIR(19620.98,",DIC(0)="L",X=PAT D FILE^DICN
 I Y<0 S AXY="-2^Unable to add record!" Q
 S AXY=+Y_U_1
 Q
ROIINQ(AXY,ROI) ;RPC - DSIR REQUEST INQUIRY
 ;Input Parameter
 ;       ROI - Internal Entry Number of ROI request (File 19620) Required
 ;       
 ;Return Array
 ;       Request Info (These occur once):
 ;               R0 ^ Patient/FOIA Name ^ ROI Clerk Name ^ Expedite Requested ^ Expedite Granted
 ;               R1 ^ Requestor Name
 ;               R2 ^ Follup Letter Date
 ;               R3 ^ Comments available  (Yes/No)
 ;               R6 ^ Division ^ SF544 ^ Request Priority
 ;               R7 ^ Drug Abuse ^ Alcoholism ^ HIV ^ Sickle Cell Anemia ^ Info Req Hospital Summary ^ Info Req
 ;                    Outpatient Notes ^ Info Req Other
 ;               R81 ^ Mail To Address Street 1 ^ Street 2 ^ Street 3 ^ City ^ State ^ Zip
 ;               R82 ^ Patient Address Street 1 ^ Street 2 ^ Street 3 ^ City ^ State ^ Zip
 ;               R9 ^ Internal Comments available (Yes/No)
 ;               R10 ^ Type of Request ^ Reason for Request ^ Authority for Request ^ Requestor Type ^ Current Status ^
 ;                         Date Received ^ First Closed Date
 ;               R11 ^ Other Reason Comment
 ;               R12 ^ Exemption 1 ^ Ex 2 ^ Ex 3 ^ Ex 4 ^ Ex 5 ^ Ex 6 ^ Ex 7a ^ Ex 7b ^ Ex 7c ^ Ex 7d ^ Ex 7e ^ 
 ;                         Ex 7f ^ Ex 8 ^ Ex 9
 ;               R13 ^ 38 USC 5701 ^ 38 USC 5705 ^ 35 USC 205 ^ 38 USC 7332 ^ Ex 3 Other 1 ^ Other 2 ^ Other 3 ^
 ;                         Other 4 ^ Other 5 ^ Other 6
 ;               CON ^ Consults From Date ^ To Date
 ;               DSCG ^ Discharge Summary From Date ^ To Date
 ;               IMM ^ Immunizations From Date ^ To Date
 ;               LAB ^ Labs From Date ^ To Date
 ;               MED ^ Medications From Date ^ To Date
 ;               POST ^ Postings From Date ^ To Date
 ;               PGN ^ Progress Notes From Date ^ To Date
 ;               RAD ^ Radiology From Date ^ To Date
 ;               SURG ^ Surgical From Date ^ To Date
 ;               VIT ^ Vitals From Date ^ To Date
 ;               Status History (These may occur multiple times):
 ;                               STH0 ^ Status Code ^ Status Date ^ Clerk ^ Date Entered ^ Closed Disposition ^ Pending Payment
 ;                               STH1 ^ Other Remarks
 ;                               
 ;               -1 ^ Missing ROI Parameter!
 ;               
 ;N R,CON,DSCG,IMM,LAB,MED,POST,PGN,RAD,SURG,VIT,STH0,STH1,STX,II,XX,YY,GLRF,IENS,GET,FIL,MAD,PAD
 ;S GLRF="DSIROI7",AXY=$NA(^TMP(GLRF,$J)),ROI=+$G(ROI),FIL=19620,YY=0 K @AXY
 ;I 'ROI S ^TMP(GLRF,$J,0)="-1^Missing ROI Parameter!" Q
 ;S IENS=ROI_"," D GETS^DIQ(FIL,IENS,"*","EI","GET")
 ;S R(0)="R0^"_$G(GET(FIL,IENS,.01,"E"))_U_$G(GET(FIL,IENS,.03,"E"))_U_$G(GET(FIL,IENS,.04,"E"))_U_$G(GET(FIL,IENS,.05,"E"))
 ;S R(1)="R1^"_$G(GET(FIL,IENS,.11,"E"))
 ;S R(2)="R2^"_$G(GET(FIL,IENS,.26,"E"))
 ;S R(3)="R3^"_$S($O(^DSIR(19620,ROI,3,0)):"Yes",1:"No")
 ;S R(6)="R6^"_$G(GET(FIL,IENS,.63,"E"))_U_$G(GET(FIL,IENS,.65,"E"))_U_$G(GET(FIL,IENS,.66,"E"))
 ;S R(7)="R7^" F II=1:1:7 S $P(R(7),U,II+1)=$G(GET(FIL,IENS,.7+(II/100),"E"))
 ;S R(9)="R9^"_$S($O(^DSIR(19620,ROI,9,0)):"Yes",1:"No")
 ;S R(10)="R10^" F II=1:1:7 S $P(R(10),U,II+1)=$G(GET(FIL,IENS,10+(II/100),"E"))
 ;S R(11)="R11^"_$G(GET(FIL,IENS,11.01,"E"))
 ;S R(12)="R12^" F II=1:1:14 S $P(R(12),U,II+1)=$G(GET(FIL,IENS,+(12+(II/100)),"E"))
 ;S R(13)="R13^" F II=1:1:10 S $P(R(13),U,II+1)=$G(GET(FIL,IENS,+(13+(II/100)),"E"))
 ;S CON="CON^"_$G(GET(FIL,IENS,109,"E"))_U_$G(GET(FIL,IENS,110,"E"))
 ;S DSCG="DSCG^"_$G(GET(FIL,IENS,113,"E"))_U_$G(GET(FIL,IENS,114,"E"))
 ;S IMM="IMM^"_$G(GET(FIL,IENS,107,"E"))_U_$G(GET(FIL,IENS,108,"E"))
 ;S LAB="LAB^"_$G(GET(FIL,IENS,117,"E"))_U_$G(GET(FIL,IENS,118,"E"))
 ;S MED="MED^"_$G(GET(FIL,IENS,101,"E"))_U_$G(GET(FIL,IENS,102,"E"))
 ;S POST="POST^"_$G(GET(FIL,IENS,111,"E"))_U_$G(GET(FIL,IENS,112,"E"))
 ;S PGN="PGN^"_$G(GET(FIL,IENS,115,"E"))_U_$G(GET(FIL,IENS,116,"E"))
 ;S RAD="RAD^"_$G(GET(FIL,IENS,105,"E"))_U_$G(GET(FIL,IENS,106,"E"))
 ;S SURG="SURG^"_$G(GET(FIL,IENS,119,"E"))_U_$G(GET(FIL,IENS,120,"E"))
 ;S VIT="VIT^"_$G(GET(FIL,IENS,103,"E"))_U_$G(GET(FIL,IENS,104,"E"))
 ;S MAD=+$G(GET(FIL,IENS,.81,"I")),PAD=$G(GET(FIL,IENS,.82,"I"))
 ;K GET S FIL=19620.92,IENS=MAD_",",R(81)="R81^" I MAD D GETS^DIQ(FIL,IENS,"*","E","GET") D
 ;.S R(81)=R(81)_$G(GET(FIL,IENS,.02,"E"))_U_$G(GET(FIL,IENS,.03,"E"))_U_$G(GET(FIL,IENS,.11,"E"))_U_$G(GET(FIL,IENS,.04,"E"))_U_$G(GET(FIL,IENS,.05,"E"))_U_$G(GET(FIL,IENS,.06,"E"))
 ;K GET S IENS=PAD_",",R(82)="R82^" I PAD D GETS^DIQ(FIL,IENS,"*","E","GET") D
 ;.S R(82)=R(82)_$G(GET(FIL,IENS,.02,"E"))_U_$G(GET(FIL,IENS,.03,"E"))_U_$G(GET(FIL,IENS,.11,"E"))_U_$G(GET(FIL,IENS,.04,"E"))_U_$G(GET(FIL,IENS,.05,"E"))_U_$G(GET(FIL,IENS,.06,"E"))
 ;F II=1:1:13 S XX=$P("0^1^2^3^6^7^81^82^9^10^11^12^13",U,II),^TMP(GLRF,$J,YY)=R(XX),YY=YY+1
 ;F II="CON","DSCG","IMM","LAB","MED","POST","PGN","RAD","SURG","VIT" S ^TMP(GLRF,$J,YY)=@II,YY=YY+1
 ;S STX=0 F  S STX=$O(^DSIR(19620.91,"B",ROI,STX)) Q:'STX  D
 ;.K GET S FIL=19620.91,IENS=STX_"," D GETS^DIQ(FIL,IENS,"*","E","GET")
 ;.S XX="STH0" F II=2:1:7 S $P(XX,U,II)=$G(GET(FIL,IENS,(II/100),"E"))
 ;.S ^TMP(GLRF,$J,YY)=XX,YY=YY+1
 ;.S ^TMP(GLRF,$J,YY)="STH1^"_$G(GET(FIL,IENS,1.01,"E")),YY=YY+1
 Q
