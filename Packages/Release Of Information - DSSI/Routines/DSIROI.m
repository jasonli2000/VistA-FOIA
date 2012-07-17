DSIROI ;EWL/AMC - Document Storage Systems Inc;ROI RPC's ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2056  GETS^DIQ
 ;10061 DEM^VADPT
 ;10009 FILE^DICN
 ;2053  FILE^DIE
 ;
 Q
GETLIST(AXY,TYPE,STAT,IEN,CLIEN,RQIEN) ;RPC - DSIR GET ROIS
 ;Input: TYPE: Set of Codes:
 ;            "P"  : Get list by patient
 ;            "C"  : Get list by clerk
 ;            "O"  : Get all open or pending requests.
 ;                   Defaults to all requests for a given status
 ;            "R"  : Gel list by requestor
 ;
 ;        STAT: '^' Delimited (Defaults to '*')
 ;            "*"  : Get all requests of a given type
 ;            "O"  : Get only the open requests of this type
 ;            "C"  : "          " closed "                " (-D,-G,-P,-R
 ;                                                           NOTE THAT -R IS PENDING PAYMENT RELEASED)
 ;            "P"  : "          " pending "               " (-P,-H,-C)
 ;            "N"  : "          " other nondisclosure     " (-NR,-RF,-ND,-NV,-RC,-NF,-NU,
 ;                                                           -NP,-MS,-PD,-PA,-G,-SL)
 ;            "E"  : "          " entered in error "      "
 ;            "X"  : "          " cancelled "             "
 ;            "A"  : "          " appealed "              " (-RV,-PR)
 ;
 ;        IEN: IFN of patient, requestor or clerk.
 ;                 If not for requestor or clerk IEN should be one of the following formats
 ;                               nnnn;DPT( - VA Patient file entry
 ;                               nnnn;DSIR(19620.96, - DSIR NON-COMPUTERIZED RECORDS PATIENT
 ;                               1;DSIR(19620.95, - True FOIA requests
 ;
 ; Return: Array of:
 ;     IEN^Patient Name^External Date Entered^Status^Requestor^SSN^Priority^FMDT^Exemptions^
 ;             Expedite Reqstd^Expedite Granted^Clerk Name^Opened by Clerk Name^Internal Open Date^
 ;             External Open Date^Last Closed by Clerk Name^Internal Last Closed Date^
 ;             External Last Closed Date^Last Reopened by Clerk Name^Internal Last Closed Date^
 ;             External Last Closed Date
 ;     
 K ^TMP("DSIROI",$J) S AXY=$NA(^TMP("DSIROI",$J)),STAT=$TR(STAT,"~","U")
 N ROI,INDX,XX,ST S XX=0,CLIEN=+$G(CLIEN),RQIEN=+$G(RQIEN)
 I $G(STAT)=""!($G(STAT)="*") S STAT="ALL"
 S TYPE=$G(TYPE,"O"),IEN=$G(IEN) I "PR"[TYPE,'IEN S ^TMP("DSIROI",$J,0)="-1^Invalid Input!" Q
 S:TYPE="O" STAT="O^P^P-P^P-H^C-R^P-C" D LDSTAR^DSIROIR(.STAT)
 S (STAT,ST)="" F  S ST=$O(STAT(ST)) Q:ST=""  S:STAT'[$E(ST) STAT=STAT_$E(ST)
 D @TYPE
 I '$O(^TMP("DSIROI",$J,0)) S ^TMP("DSIROI",$J,0)="-1^No Requests Found!"
 Q
P ;Patient lookup
 N CSTAT,CDISP,STCODE
 S ROI=0 F  S ROI=$O(^DSIR(19620,"B",IEN,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .Q:'$D(^DSIR(19620,ROI,10))
 .S CSTAT=$P(^DSIR(19620,ROI,10),U,5),STCODE=$P(^DSIR(19620,ROI,10),U,8)
 .S CDISP=$P(^DSIR(19620.41,STCODE,0),U) D:$D(STAT(CDISP)) FOUND
 Q
C ;Clerk lookup
 N II
 I 'IEN D  Q
 .S IEN=0 F  S IEN=$O(^DSIR(19620,"AE",IEN)) Q:'IEN  F II=1:1:$L(STAT) D
 ..S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"AE",IEN,INDX,ROI)) Q:'ROI  D 
 ...Q:'$D(^DSIR(19620,ROI,0))
 ...Q:'$D(^DSIR(19620,ROI,10))
 ...D:$$CST FOUND
 F II=1:1:$L(STAT) S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"AE",IEN,INDX,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .D:$$CST FOUND
 Q
CST() ;
 I $D(STAT($P($$CURSTAT^DSIROI6(ROI),":"))) Q 1
 Q 0
O ;Open/Pending only
 N II
 F II=1:1:$L(STAT) S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"ACST",INDX,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .Q:'$D(^DSIR(19620,ROI,10))
 .I $D(STAT($P($$CURSTAT^DSIROI6(ROI),":"))) D FOUND
 Q
R ;Requestor lookup
 N CSTAT
 S ROI=0 F  S ROI=$O(^DSIR(19620,"AREQ",IEN,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .Q:'$D(^DSIR(19620,ROI,10))
 .S CSTAT=$P($$CURSTAT^DSIROI6(ROI),":") I CSTAT]"" D:$D(STAT(CSTAT)) FOUND
 Q
FOUND ;
 N GET,IENS,DFN,SSN,DTENT,STAT,REQTR,PRI,PAT,VADM,FOIA,FLE,EXRQ,EXGR,STATSQ
 S FLE=19620,IENS=ROI_"," D GETS^DIQ(FLE,IENS,".01;.03;.04;.05;.11;.66;10.05;10.06;10.08","IE","GET")
 Q:'$G(GET(FLE,IENS,.01,"I"))
 I CLIEN Q:$G(GET(FLE,IENS,.03,"I"))'=CLIEN
 I RQIEN Q:$G(GET(FLE,IENS,.11,"I"))'=RQIEN
 S FOIA=$P(GET(FLE,IENS,.01,"I"),".",2)
 S DFN=+GET(FLE,IENS,.01,"I") D:'FOIA DEM^VADPT S SSN=$S('FOIA:$P(VADM(2),U),FOIA=95:"N/A",1:$P($G(^DSIR(FLE+.96,+GET(FLE,IENS,.01,"I"),0)),U,9)),PAT=$G(GET(FLE,IENS,.01,"E"))
 S REQTR=$G(GET(FLE,IENS,.11,"E")),EXRQ=$G(GET(FLE,IENS,.04,"I")),EXGR=$G(GET(FLE,IENS,.05,"I"))
 S DTENT=$G(GET(FLE,IENS,10.06,"E")),STAT=$P($$CURSTAT^DSIROI6(+IENS),":"),PRI=$G(GET(FLE,IENS,.66,"E")) S:PRI="" PRI="HIGH"
 S STATSQ=$$STATSEQ^DSIROI6(ROI)
 S XX=XX+1,^TMP("DSIROI",$J,XX)=ROI_U_PAT_U_DTENT_U_STAT_U_REQTR_U_SSN_U_PRI_U_$G(GET(FLE,IENS,10.06,"I"))_U_$TR($G(^DSIR(19620,ROI,12)),U,";")_U_EXRQ_U_EXGR_U_$G(GET(FLE,IENS,.03,"E"))_U_STATSQ
 Q
UPDATE(AXY,DATA) ;RPC - DSIR ADD/EDIT ROI
 ;Create new or update existing ROI Instance
 ; Input: DATA: Array
 ;             (1): Patient DFN
 ;             (2): Purpose
 ;             (3): ROI Clerk (IFN)
 ;             (4): Requestor (IFN)
 ;             (5): Received Date (FM Format)
 ;             (6): Authority for request (Pointer to 19620.51)
 ;             (7): Type of request (Pointer to 19620.61)
 ;             (8): Requestor type (Pointer to 19620.71)
 ;             (9): Other Reason Comment
 ;             (10): Priority (0 - Normal , 1 - High)
 ;             (11): Release Drug Abuse Info?                     (0 - Don't Release , 1 - Release)
 ;             (12): '     ' Alcoholism Info?                               '            '
 ;             (13): '     ' HIV Info?                                      '            '
 ;             (14): '     ' Sickle Cell Anemia                             '            '
 ;             (15): '     ' Copy of Hospital Summary?                      '            '
 ;             (16): '     ' Copy of Outpatient Treatment Notes?            '            '
 ;             (17): '     ' Other info?                                    '            '
 ;             (18): Mail to address (Pointer to 19620.92)
 ;             (19): Patient address (Pointer to 19620.92)
 ;             (20): ROI IEN (Add new if null)
 ;             (21): Status (Default to Open if (20) is null)
 ;             (22): Exemptions 1 thru 9
 ;                               This is a multi-piece value delimited by ; with the following exemption order
 ;                               1;2;3;4;5;6;7a;7b;7c;7d;7e;7f;8;9
 ;                               A one in the above positions means that exemption was used
 ;             (23): Expedite Requested (0 = No, 1 = Yes)
 ;             (24): Expedite Granted (0 = No, 1 = Yes)
 ;             (25): 38 USC 5701  (0 = No, 1 = Yes)
 ;             (26): 38 USC 5705  (0 = No, 1 = Yes)
 ;             (27): 35 USC 205   (0 = No, 1 = Yes)
 ;             (28): 38 USC 7332  (0 = No, 1 = Yes)
 ;             (29): OTHER EXEMPTION  (Free text)
 ;             (30): Document Print Order (Free text)
 ;             (31): Document Print Order Continuation (Free text)
 ;             (32): No Exceptions Required (0=N/A, 1=No Exceptions Required)
 ;             (33): Date Expedited Requested (FM Format)
 ;             (34): Expedited Adjudicated
 ;             (35): Date Expedited Adjudicated (FM Format)
 ;             (36): 41 USC 253B  (0 = No, 1 = Yes)
 ;             (37): 5 USC APP 3  (0 = No, 1 = Yes)
 ;             (38): Fee Waiver Requested (0 = No, 1 = Yes)
 ;             (39): Fee Waiver Requested Date 
 ;             (40): Fee Waiver Adjudicated (0 = No, 1 = Yes)
 ;             (41): Fee Waiver Adjudicated Date 
 ;             (42): Fee Waiver Granted (0 = No, 1 = Yes)
 ;             !!!!!!!!!!!!!!!             !!!!!!!!!!!!!!
 ;             VVVVVVVVVVVVVVV NEW ENTRIES VVVVVVVVVVVVVV
 ;             (43): No Records (0 = No, 1 = Yes)
 ;             (44): Referral (0 = No, 1 = Yes)
 ;             (45): Records Not Reasonably Described (0 = No, 1 = Yes)
 ;             (46): Not an Agency Record (0 = No, 1 = Yes)
 ;             (47): Duplicate Request (0 = No, 1 = Yes)
 ;
 ; Return: AXY
 ;         Successful Creation/Update: 1^IFN of file 19620
 ;       Unsuccessful Creation/Update: -1^Error Message
 ;       
 N ROI,Y,X,II,DIC,IENS,DSIR,NEW,FLE S DATA(1)=$G(DATA(1)),NEW='$G(DATA(20)),FLE=19620 S:NEW DATA(21)="O"
 I DATA(1)'?1.N1";"3.4A1"(".E S AXY="-1^Invalid Input - Missing Patient!" Q
 I NEW D  I ROI<0 S AXY="-1^Unable to create ROI Instance!" Q
 .S X=DATA(1),DIC="^DSIR(19620,",DIC(0)="L" D FILE^DICN S ROI=+Y Q:Y<0
 S ROI=$G(ROI,$G(DATA(20))),IENS=ROI_","
 S:$G(DATA(2))]"" DSIR(FLE,IENS,10.02)=DATA(2)
 S:$G(DATA(3)) DSIR(FLE,IENS,.03)=DATA(3)
 S:$G(DATA(4)) DSIR(FLE,IENS,.11)=DATA(4)
 S:$G(DATA(5)) DSIR(FLE,IENS,10.06)=DATA(5)\1
 S:$G(DATA(6)) DSIR(FLE,IENS,10.03)=DATA(6)
 S:$G(DATA(7)) DSIR(FLE,IENS,10.01)=DATA(7)
 S:$G(DATA(8)) DSIR(FLE,IENS,10.04)=DATA(8)
 S:$G(DATA(9))]"" DSIR(FLE,IENS,11.01)=DATA(9)
 S:$G(DATA(10))]"" DSIR(FLE,IENS,.66)=DATA(10)
 F II=11:1:17 S:$G(DATA(II))]"" DSIR(FLE,IENS,II+60/100)=DATA(II)
 S:$G(DATA(18)) DSIR(FLE,IENS,.81)=DATA(18)
 S:$G(DATA(19)) DSIR(FLE,IENS,.82)=DATA(19)
 S:$G(DATA(23))]"" DSIR(FLE,IENS,.04)=DATA(23)
 S:$G(DATA(25))]"" DSIR(FLE,IENS,13.01)=DATA(25)
 S:$G(DATA(26))]"" DSIR(FLE,IENS,13.02)=DATA(26)
 S:$G(DATA(27))]"" DSIR(FLE,IENS,13.03)=DATA(27)
 S:$G(DATA(28))]"" DSIR(FLE,IENS,13.04)=DATA(28)
 S DSIR(FLE,IENS,200)=$G(DATA(30))
 S DSIR(FLE,IENS,201)=$G(DATA(31))
 S DSIR(FLE,IENS,202)=$G(DATA(32))
 ; CODE FOR THE EXPEDITED PROCESSING FIELDS
 ; IF EXPEDITED REQUESTED
 I +DATA(23) D
 .S DSIR(FLE,IENS,.04)=1
 .S DSIR(FLE,IENS,.06)=$G(DATA(33))
 .;IS THIS EXPEDITED REQUEST ADJUDICATED
 .I +DATA(34) D
 ..S DSIR(FLE,IENS,.07)=1
 ..S DSIR(FLE,IENS,.08)=$G(DATA(35))
 ..S DSIR(FLE,IENS,.05)=+$G(DATA(24))
 ..; NOT ACJUDICATED
 .I +DATA(34)=0 D
 ..S DSIR(FLE,IENS,.07)=0
 ..S DSIR(FLE,IENS,.08)=""
 ..S DSIR(FLE,IENS,.05)=0
 ; EXPEDITED NOT REQUESTED 
 I +DATA(23)=0 D
 .S DSIR(FLE,IENS,.04)=0
 .S DSIR(FLE,IENS,.06)=""
 .S DSIR(FLE,IENS,.07)=0
 .S DSIR(FLE,IENS,.08)=""
 .S DSIR(FLE,IENS,.05)=0
 ;
 S DSIR(FLE,IENS,13.11)=$G(DATA(36))
 S DSIR(FLE,IENS,13.12)=$G(DATA(37))
 I +$G(DATA(29)) D:$D(DATA(29))
 .F II=1:1:6 S DSIR(FLE,IENS,+(13.04+(II/100)))=$P(DATA(29),U,II)
 ;FEE WAIVER PROCESSING
 S DSIR(FLE,IENS,4.01)=$G(DATA(38))
 I +$G(DATA(38)) D
 .S DSIR(FLE,IENS,4.02)=$G(DATA(39))
 .S DSIR(FLE,IENS,4.03)=$G(DATA(40))
 .I +$G(DATA(40)) D
 ..S DSIR(FLE,IENS,4.04)=$G(DATA(41))
 ..S DSIR(FLE,IENS,4.05)=$G(DATA(42))
 .I +$G(DATA(40))=0 D
 ..S DSIR(FLE,IENS,4.04)=""
 ..S DSIR(FLE,IENS,4.05)=0
 I +$G(DATA(38))=0 D
 .S DSIR(FLE,IENS,4.02)=""
 .S DSIR(FLE,IENS,4.03)=0
 .S DSIR(FLE,IENS,4.04)=""
 .S DSIR(FLE,IENS,4.05)=0
 S DSIR(FLE,IENS,12.5)=$G(DATA(43))
 S DSIR(FLE,IENS,12.51)=$G(DATA(44))
 S DSIR(FLE,IENS,12.52)=$G(DATA(45))
 S DSIR(FLE,IENS,12.53)=$G(DATA(46))
 S DSIR(FLE,IENS,12.54)=$G(DATA(47))
 ;
 ;check for exemptions
 D:$G(DATA(22))]""  I $G(AXY)<0 Q:'NEW  N DA,DIK S DA=ROI,DIK="^DSIR(19620," D ^DIK K DIK Q
 .I DATA(22)["12." S AXY="-1^Exemption Data Invalid!" Q
 .N I,FLD F I=1:1:14 S FLD=12+(I/100),DSIR(FLE,IENS,FLD)=+$P(DATA(22),";",I)
 ;Save division
 S DSIR(FLE,IENS,.63)=$G(DUZ(2))
 D FILE^DIE("","DSIR")
 D:$G(DATA(21))]""
 .N STAT
 .S STAT=$$STATUS^DSIROI8(ROI,DATA(21),DUZ,DATA(5))
 .; IF STATUS UPDATE FAILS
 .I (+STAT)<0 S AXY=STAT
 I '$G(AXY) S AXY="1^"_ROI
 Q
GETREQST(RET,IEN) ; RPC - DSIR GET ROI REQUEST DATA
 ;  ADDED IN VERSION 6.1 BY EWL
 D GETS^DIQ(19620,IEN_",","*","IE","RET","EMSG")
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
