DSIROI8 ;AMC/EWL - DSS INC;;ROI; ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10013 ^DIK
 ;2053  UPDATE^DIE
 ;2056  GETS^DIQ / GET1^DIQ
 ;10000 NOW^%DTC
 ;2053  FILE^DIE
 ;2052  $$GET1^DID
 ;10060 $$GET1^DIQ(200,duz,.01)
 Q
ADDPROV(AXY,PROV,DEL) ;RPC - DSIR ADD/DEL SENSITIVE PROV
 ;Input Parameter(s)
 ;   PROV - Internal Number to file 200 of provider to mark as sensitive
 ;   DEL - Delete flag (1 = Delete, default to "")
 ;Return Value
 ;   -1 ^ Missing Provider Pointer!
 ;   @ - Record deleted
 ;   PROV - Internal Number to file 200 of provider marked as sensitive
 S DEL=+$G(DEL),PROV=+$G(PROV)
 I 'PROV S AXY="-1^Missing Provider Pointer!" Q
 ; DELETE A SENSITIVE PROVIDER
 I DEL N DIK,DA S DA=PROV,DIK="^DSIR(19620.94," D ^DIK S AXY="@" Q
 ; ADD A SENSITIVE PROVIDER
 N DSIR,DSIRI I $D(^DSIR(19620.94,PROV)) S AXY=PROV Q
 S DSIR(19620.94,"+1,",.01)=PROV,DSIRI(1)=PROV D UPDATE^DIE(,"DSIR","DSIRI")
 S AXY=PROV
 Q
PROVLIST(AXY) ;RPC - DSIR GET SENSITIVE PROVIDERS
 ;Input Parameter
 ;   None
 ;Return Array (^ - Delimited)
 ;   IEN - Pointer to file 200
 ;   NAME - Provider Name
 ;   TITLE - Title from field 8 in file 200
 ;   -1 ^ No Provider Found!
 N PROV,FIL,YY S FIL=19620.94,AXY=$NA(^TMP("DSIROI8",$J)) K @AXY
 S PROV=0 F YY=1:1 S PROV=$O(^DSIR(FIL,PROV)) Q:'PROV  D
 .N GET,IENS
 .S IENS=PROV_"," D GETS^DIQ(FIL,IENS,"*",,"GET"),GETS^DIQ(200,IENS,8,,"GET")
 .S @AXY@(YY)=PROV_U_$G(GET(FIL,IENS,.01))_U_$G(GET(200,IENS,8))
 I '$O(@AXY@(0)) S @AXY@(YY)="-1^No Provider Found!"
 Q
LOGFOIA(STDT,EDDT,DTLS,DIVL) ; EXTRINSIC FUNCTION
 ;THIS SUB-ROUTINE UPDATED TO SUPPORT MULTIPLE DIVISIONS 
 ;JANUARY 2007, EWL
 ;  DSIR CREATE/UPDATE FILE 19620.3 BASED ON ENDDATE AND DIVISION 
 ; INPUT PARAMETERS
 ;    STDT - START DATE
 ;    ETDT - END DATE
 ;    DTLS - ARRAY CONTAINING DATA TO BE ADDED/UPDATED
 ;    DIVL - DIVISION (optional)
 ; RETURN
 ;    IEN POINTER TO FILE 19620.3 PLUS THE END DATE AND DIVISION (IEN^EDDT^DIV)
 ;    -1 IF RECORD EXISTS AND IS LOCKED
 ;    -2 INVALID DATE(S)
 ;
 ; CHECK DATES
 N DT1,DT2,DTDIF,RET,DISR1,FDA,IEN1,FLD S FLD=0,DT1=$E(EDDT,1,3),DT2=$E(STDT,1,3),DTDIF=DT1-DT2,RET="",IEN1=""
 I ($E(EDDT,4,7)'="0930")!($E(STDT,4,7)'="1001")!(DTDIF'=1) Q "-2^INVALID DATE RANGE"
 ; CHECK DIVISION
 N DIV I $G(DIVL)  S DIV=$P(DIVL,U)
 I '$G(DIVL) S DIV=DUZ(2)
 ;
 ; DOES THE RECORD EXIST?  IF SO, GET THE IEN
 N IEN,TIEN S FIL=19620.3
 I $D(^DSIR(FIL,"AFYDIV",EDDT,DIV)) S TIEN=0 F  S TIEN=+$O(^DSIR(FIL,"AFYDIV",EDDT,DIV,TIEN))  Q:'TIEN  S IEN=TIEN
 I $G(IEN)]"" S RET=$G(^DSIR(FIL,IEN,0)) I $P(RET,"^",3) Q "-1^RECORD LOCKED"
 ;
 ; ADD A NEW RECORD
 I $G(IEN)']"" D
 .S IEN=$S(RET="":"+1,",RET'="":""""_IEN_","""),FLD=0
 .F  S FLD=$O(DTLS(FLD)) Q:'FLD  D
 ..S FDA(FIL,IEN,FLD)=DTLS(FLD)
 .D NOW^%DTC
 .S FDA(FIL,IEN,.04)=DUZ,FDA(FIL,IEN,.05)=%,FDA(FIL,IEN,.01)=EDDT
 .S FDA(FIL,IEN,.02)=STDT,FDA(FIL,IEN,.03)=0,FDA(FIL,IEN,.08)=DIV
 .D UPDATE^DIE("","FDA","IEN1") S IEN=+IEN1(1)
 ; UPDATE EXISTING DATA
 I RET'="" D 
 .S IEN=IEN_","
 .F  S FLD=$O(DTLS(FLD)) Q:'FLD  D
 ..S FDA(FIL,IEN,FLD)=DTLS(FLD)
 .D NOW^%DTC
 .S FDA(FIL,IEN,.04)=DUZ,FDA(FIL,IEN,.05)=%,DA(FIL,IEN,.01)=EDDT,FDA(FIL,IEN,.02)=STDT,FDA(FIL,IEN,.03)=0,FDA(FIL,IEN,.08)=DIV
 .D FILE^DIE(,"FDA")
 Q IEN1_U_EDDT_U_DIV
 ;
LOCKFOIA(AXY,IEN,LSTAT) ; RPC  DSIR SET LOCKED STATUS
 ;THIS SUB-ROUTINE UPDATED TO SUPPORT MULTIPLE DIVISIONS 
 ;JANUARY 2007, EWL
 ;
 ;INPUT PARAMETERS
 ; IEN
 ; LSTAT - LOCK STATUS  0 = UNLOCK, 1 = LOCK
 ;
 ;RETURN
 ; IEN POINTER TO FILE 19620.3 PLUS THE END DATE AND DIVISION (IEN^EDDT^DIV)
 ; OR "-1^RECORD NOT FOUND" 
 ; OR "-2^IEN CANNOT BE BLANK" 
 N FDA,DIV,EDDT,FIL,MSG,IENS S FIL=19620.3
 I ($G(IEN)]"")=0 S AXY="-2^IEN CANNOT BE BLANK" Q
 I ($D(^DSIR(FIL,IEN)))=0 S AXY="-1^RECORD NOT FOUND" Q
 S IENS=IEN_",",DIV=$P(^DSIR(FIL,IEN,0),U,8),EDDT=$P(^DSIR(FIL,IEN,0),U,1) S:$G(LSTAT)']"" LSTAT=1
 D NOW^%DTC S FDA(FIL,IENS,.03)=+$G(LSTAT),FDA(FIL,IENS,.06)=DUZ,FDA(FIL,IENS,.07)=%
 D FILE^DIE(,"FDA","MSG") S AXY=IEN_U_EDDT_U_DIV
 Q 
 ;
GETFOIA(AXY,IEN) ; RPC DSIR GET FOIA OFFSETS
 ;THIS SUB-ROUTINE UPDATED TO SUPPORT MULTIPLE DIVISIONS 
 ;JANUARY 2007, EWL
 ;
 ;Input Parameters
 ;     IEN
 ; RETURN
 ;   ARRAY FORMATTED AS FOLLOWS:
 ;        "FIELD#^INTERNAL VALUE^EXTERNAL VALUE^GLOBAL SUBSCRIPT"
 ;   OR "-1^RECORD NOT FOUND"
 ;   OR "-2^IEN CANNOT BE BLANK"
 N INX,FIL,RTN,TAR,TIEN,SS2,P1,P2 S FIL=19620.3
 I ($G(IEN)]"")=0 S AXY="-2^IEN CANNOT BE BLANK" Q
 I ($D(^DSIR(FIL,IEN)))=0 S AXY="-1^RECORD NOT FOUND" Q
 S TIEN=IEN_",",FLD=0
 D GETS^DIQ(FIL,TIEN,"**","IE","TAR")
 F INX=0:1 S FLD=$O(TAR(FIL,TIEN,FLD)) Q:'FLD  D:(FLD>145)!(FLD<1)
 .S P1=FLD_U_$G(TAR(FIL,TIEN,FLD,"I"))_U_$G(TAR(FIL,TIEN,FLD,"E"))_U
 .S P2=$P($$GET1^DID(FIL,FLD,,"GLOBAL SUBSCRIPT LOCATION"),";")
 .S AXY(INX)=P1_P2
 Q
 ;
IENSFOIA(AXY) ; RPC DSIR LIST FOIA OFFSETS
 ;THIS SUB-ROUTINE UPDATED TO SUPPORT MULTIPLE DIVISIONS 
 ;JANUARY 2007, EWL
 ;
 ; Input parameters: NONE
 ;
 ; Output: ARRAY 
 ;   Each element will contain the IEN, the EndDate and the DIVISION delimited with a "^"
 ; 
 N IEN,IENLIST,FIL,NODE0,EDDT,DIV S IEN=0,FIL=19620.3,IENLIST=""
 F INX=1:1 S IEN=$O(^DSIR(FIL,IEN)) Q:'IEN  D
 . S NODE0=^DSIR(FIL,IEN,0),EDDT=$P(NODE0,U,1),DIV=$P(NODE0,U,8)
 . S AXY(INX)=IEN_U_EDDT_U_DIV
 Q
 ;
MANUFOIA(AXY,FOIA,DATA) ;RPC - DSIR UPDATE FOIA OFFSETS
 ;Input Parameters
 ;   FOIA - IEN to file 19620.3
 ;   DATA - Array formatted as:
 ;              Field Number ^ Data (Where field numbers are 100.02 thru 137.02 all must be .02)
 ;Return Values
 ; Successful Filing
 ;   FOIA - IEN to file 19620.3
 ; Error Message
 ;   -1 ^ Missing FOIA Pointer!
 ;   -1 ^ Nothing Updated!
 N DSIR,FIL,II,IENS S FIL=19620.3,II="",IENS=+$G(FOIA)_","
 I '$D(^DSIR(FIL,+$G(FOIA))) S AXY="-1^Missing FOIA Pointer!" Q
 F  S II=$O(DATA(II)) Q:II=""  D
 .S FLD=$P(DATA(II),U),VALUE=$P(DATA(II),U,2)
 .I FLD>144&(FLD<225)&($P(FLD,".",2)="02") S DSIR(FIL,IENS,FLD)=VALUE
 I $O(DSIR(FIL,IENS,0)) D FILE^DIE(,"DSIR") S AXY=FOIA Q
 S AXY="-1^Nothing Updated!"
 Q
STATUS(REQ,STATUS,USR,STADT) ;Update the status of a request (FUNCTION)
 ;INPUT PARAMETERS
 ; REQ - Request IEN
 ; STATUS - Status code (Alpha)
 ; USR - User ID
 ; STADT - Status date
 ;
 ;RETURN VALUES
 ;
 N DIC,X,VEJD,ERR,DATA,Y,IEN,STTIME,DISP,STATP,II,STC,QRY
 ; CHECK REQUIRED INPUT PARAMETERS
 I '$G(REQ) Q "-1^REQUEST IEN MISSING ON UPDATE STATUS"
 I '$D(^DSIR(19620,REQ)) Q "-1^INVALID REQUEST IEN, "_REQ_", ON UPDATE STATUS"
 I '$G(USR) Q "-1^USER ID MISSING ON UPDATE STATUS"
 I ($G(STATUS)="") Q "-1^STATUS CODE MISSING ON UPDATE STATUS"
 I '$D(^DSIR(19620.41,"B",STATUS)) Q "-1^INVALID STATUS CODE, "_STATUS_", ON UPDATE STATUS"
 ;
 S QRY=$NA(^DSIR(19620.41,"B",STATUS)),STC=$QS($Q(@QRY),4)
 S STADT=$G(STADT,DT),DISP=$P(STATUS,"-",2),STAT=$P(STATUS,"-") S:DISP="" DISP="@"
 I (STC=19)&($P(^DSIR(19620,REQ,10),"^",9)=1) Q "-1^THIS REQUEST HAS PREVIOUSLY BEEN IN A PENDING CLARIFICATION STATUS AND CANNOT BE CHANGED TO PENDING STATUS AGAIN"
 D NOW^%DTC S STTIME=%
 S DIC="^DSIR(19620.91,",DIC(0)="L",X=REQ D FILE^DICN
 I Y'>0 Q "-1^Unable to create status history record"
 S IEN=+Y_",",DATA(19620.91,IEN,.02)=STAT,DATA(19620.91,IEN,.03)=STADT\1,DATA(19620.91,IEN,.04)=USR
 S DATA(19620.91,IEN,.05)=STTIME
 S DATA(19620.91,IEN,.06)=DISP
 S DATA(19620.91,IEN,.08)=$O(^DSIR(19620.41,"B",STATUS,0))
 D FILE^DIE("","DATA")
 I $D(DIERR) Q "-1^STATUS HISTORY FILE UPDATE FAILED"
 N DATA S DATA(19620,REQ_",",10.05)=STAT
 I (STAT]"")&(+$P($G(^DSIR(19620,REQ,10)),U,8)'=26) D
 .S DATA(19620,REQ_",",10.07)=$S("OP"'[STAT:STADT,1:"@")
 I (STC=25)!(STC=26) S DATA(19620,REQ_",",10.12)=1
 I STC=19 S DATA(19620,REQ_",",10.09)=1
 S DATA(19620,REQ_",",10.08)=STC
 D FILE^DIE("","DATA")
 I $D(DIERR) D
 .S DIK="^DSIR(19620.91,",DA=+IEN D ^DIK
 I $D(DIERR) Q "-1^STATUS UPDATE FAILED ON INSTANCE FILE. STATUS HISTORY CHANGE BACKED OUT."
 K DATA
 Q 1
 ;
PENDCLR(RETURN,IEN) ;RPC - DSIR TEST PEND CLARIFICATION
 ; INPUT PARAMETER - IEN = INTERNAL ENTRY NUMBER FOR FILE 19620
 ; RETURN
 ;  0 OR NULL = NO 
 ;  1 = YES
 ; -1 = NO DATA FOR THIS REQUEST
 I '$D(^DSIR(19620,IEN,10)) S RETURN="-1,NO DATA FOUND FOR THIS REQUEST" Q
 S RETURN=+($P(^DSIR(19620,IEN,10),U,9)) Q
