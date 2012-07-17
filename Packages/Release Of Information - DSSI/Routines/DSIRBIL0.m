DSIRBIL0 ;AMC/EWL - Document Storage System;Billing RPC's and other ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2056  GETS^DIQ
 ;2055  $$EXTERNAL^DILFD
 ;2052  $$GET1^DID
 ;      
 Q
BILLHIST(AXY,BILN) ;RPC - DSIR BILL HISTORY
 ;       Input Parameter(s)
 ;               1 - Bill IEN
 ;               
 ;       Return Array '^' delimited
 ;               1 - Date of Edit Internal ; External (I ; E)
 ;               2 - Edited By (I ; E)
 ;               3 - Field Edited (I ; E)
 ;               4 - Old Value Internal (I ; E)
 ;               5 - New Value Internal (I ; E)
 ;
 N GLRF,HIST,HISTC,FLD,FLDN,FIL,GET,XX,YY,OLDV,NEWV S GLRF="DSIRBIL0",FIL=19620.29,YY=0
 S AXY=$NA(^TMP(GLRF,$J))
 I '$G(BILN) S ^TMP(GLRF,$J,0)="-1^Invalid Input - Missing Bill Number!" Q
 S HIST=0 F  S HIST=$O(^DSIR(FIL,"B",BILN,HIST)) Q:'HIST  D
 .S HISTC=HIST_"," D GETS^DIQ(FIL,HIST,"*","EI","GET")
 .S FLD=$G(GET(FIL,HISTC,.04,"I")),FLDN=$$GET1^DID(19620.2,FLD,"","LABEL"),OLDV=$G(GET(FIL,HISTC,.05,"I")),NEWV=$G(GET(FIL,HISTC,.06,"I"))
 .S OLDV=OLDV_";"_$$EXTERNAL^DILFD(19620.2,FLD,"",OLDV),NEWV=NEWV_";"_$$EXTERNAL^DILFD(19620.2,FLD,"",NEWV),FLDN=FLD_";"_FLDN
 .S XX=$G(GET(FIL,HISTC,.02,"I"))_";"_$G(GET(FIL,HISTC,.02,"E"))_U_$G(GET(FIL,HISTC,.03,"I"))_";"_$G(GET(FIL,HISTC,.03,"E"))
 .S $P(XX,U,3)=FLDN,$P(XX,U,4)=OLDV,$P(XX,U,5)=NEWV
 .S YY=YY+1,^TMP(GLRF,$J,YY)=XX K GET
 I 'YY S ^TMP(GLRF,$J,0)="-2^No Audit History Records Found!"
 Q
DEVCLNUP ;Development Clean-up INTERNAL USE ONLY
 ;
 N A S A=$P(^DSIR(19620.2,0),U,1,2) K ^DSIR(19620.2) S ^DSIR(19620.2,0)=A
 S A=$P(^DSIR(19620.21,0),U,1,2) K ^DSIR(19620.21) S ^DSIR(19620.21,0)=A
 K ^DD(19620.2)
 Q
 ;
KILLBILL(AXY,BIEN,ADMIN) ;RPC - DSIR KILL BILL
 ;Input Parameters
 ;               BIEN - Bill Internal Entry Number (File 19620.2, Required)
 ;               ADMIN - Flag to allow delete of a bill with payments, deletes payment history also (Optional - default = 0)
 ;               
 ;Return Values
 ;
 ;               1 - Successful deletion
 ;               -1^Missing Bill Number!
 ;               -2^No Bill on file for Bill IEN!
 ;               -3^Payment(s) received for $  nnn.nn. Unable to delete!
 ;               
 ;               
 N DA,DIK,PNTR,FIL,FILE,PAID
 S BIEN=+$G(BIEN),ADMIN=+$G(ADMIN) I 'BIEN S AXY="-1^Missing Bill Number!" Q
 I '$D(^DSIR(19620.2,BIEN,0)) S AXY="-2^No Bill on file for Bill IEN!" Q
 S PAID=$$PAYM(BIEN,ADMIN) I PAID S AXY="-3^Payment(s) received for $"_$J(PAID,8,2)_". Unable to delete!" Q
 F FIL=29,21 S PNTR=0,FILE=19620+(FIL/100) F  S PNTR=$O(^DSIR(FILE,"B",BIEN,PNTR)) Q:'PNTR  S DA=PNTR,DIK="^DSIR("_FILE_"," D ^DIK K DIK
 S DA=BIEN,DIK="^DSIR(19620.2," D ^DIK
 S AXY=1
 Q
PAYM(IEN,DEL) ;
 N PAY,PAY0,AMT,DIK,DA,HIST S (PAY,AMT)=0
 F  S PAY=$O(^DSIR(19620.21,"B",IEN,PAY)) Q:'PAY  D
 .I DEL S DIK="^DSIR(19620.21,",DA=PAY D ^DIK K DIK Q
 .S PAY0=$G(^DSIR(19620.21,PAY,0))
 .I $P(PAY0,U,2),'$P(PAY0,U,5),'$P(PAY0,U,7) S AMT=AMT+$P(PAY0,U,2)
 I DEL S HIST=0 F  S HIST=$O(^DSIR(19620.29,"B",IEN,HIST)) Q:'HIST  S DIK="^DSIR(19620.29,",DA=HIST D ^DIK K DIK
 Q AMT
UPDATEFW(AXY,IEN,FWCLERK,FWRQST,FWRQSTDT,FWADJ,FWADJDT,FWGRANT) ; RPC - DSIR UPDATE FEE WAIVER
 ; Input parameters
 ;      IEN      from 19620
 ;      FWCLERK  ID from 200
 ;      FWRQST   Fee Waiver Requested 1=true 0=false
 ;      FWRQSTDT Fee Waiver Requested Date in Fileman format
 ;      FWADJ    Fee Waiver Adjudicated 1=true 0=false
 ;      FWADJDT  Fee Waiver Adjudicated Date in Fileman format
 ;      FWGRANT  Fee Waiver Granted
 ; Return Values
 ;      IEN      from 19620 if successful
 ;      -1       If Unsuccessful
 N FDA,IENS
 I $D(^DSIR(19620,IEN)) D  Q
 .S IENS=IEN_","
 .S FDA("19620",IENS,4.01)=FWRQST
 .S FDA("19620",IENS,4.02)=FWRQSTDT
 .S FDA("19620",IENS,4.03)=FWADJ
 .S FDA("19620",IENS,4.04)=FWADJDT
 .S FDA("19620",IENS,4.05)=FWGRANT
 .S FDA("19620",IENS,4.06)=FWCLERK
 .D FILE^DIE(,"FDA","EMSG")
 .I $D(EMSG) S AXY="-1,"_EMSG("DIERR",1,"TEXT",1) Q
 .S AXY=IEN
 Q "-1,IEN/REQUEST NOT ON FILE"
