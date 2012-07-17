OCXOZ10 ;SLC/RJS,CLA - Order Check Scan ;NOV 3,2010 at 19:22
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,221,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ; ***************************************************************
 ; ** Warning: This routine is automatically generated by the   **
 ; ** Rule Compiler (^OCXOCMP) and ANY changes to this routine  **
 ; ** will be lost the next time the rule compiler executes.    **
 ; ***************************************************************
 ;
 Q
 ;
R66R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #66 'LAB RESULTS'  Relation #1 'HL7 LAB RESULTS'
 ;  Called from R66R1A+10^OCXOZ0Z.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ; NEWRULE( ---------> NEW RULE MESSAGE
 ;
 Q:$D(OCXRULE("R66R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 S OCXCMSG=""
 S OCXNMSG="Labs resulted - ["_$$GETDATA(DFN,"5^",96)_"]"
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Notification
 ;
 S (OCXDUZ,OCXDATA)="",OCXNUM=0
 I ($G(OCXOSRC)="GENERIC HL7 MESSAGE ARRAY") D
 .S OCXDATA=$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",2))_"|"_$G(^TMP("OCXSWAP",$J,"OCXODATA","ORC",3))
 .S OCXDATA=$TR(OCXDATA,"^","@"),OCXNUM=+OCXDATA
 I ($G(OCXOSRC)="CPRS ORDER PROTOCOL") D
 .I $P($G(OCXORD),U,3) S OCXDUZ(+$P(OCXORD,U,3))=""
 .S OCXNUM=+$P(OCXORD,U,2)
 S:($G(OCXOSRC)="CPRS ORDER PRESCAN") OCXNUM=+$P(OCXPSD,"|",5)
 S OCXRULE("R66R1B")=""
 I $$NEWRULE(DFN,OCXNUM,66,1,3,OCXNMSG) D  I 1
 .D:($G(OCXTRACE)<5) EN^ORB3(3,DFN,OCXNUM,.OCXDUZ,OCXNMSG,.OCXDATA)
 Q
 ;
R67R1A ; Verify all Event/Elements of  Rule #67 'GLUCOPHAGE - LAB RESULTS'  Relation #1 'GLUCOPHAGE ORDER AND GLUCOPHAGE CREATININE > 1.5'
 ;  Called from EL86+5^OCXOZ0I, and EL111+5^OCXOZ0I.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE111( ---------->  Verify Event/Element: 'GLUCOPHAGE CREATININE > 1.5'
 ; MCE86( ----------->  Verify Event/Element: 'GLUCOPHAGE ORDER'
 ;
 Q:$G(^OCXS(860.2,67,"INACT"))
 ;
 I $$MCE86 D 
 .I $$MCE111 D R67R1B
 Q
 ;
R67R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #67 'GLUCOPHAGE - LAB RESULTS'  Relation #1 'GLUCOPHAGE ORDER AND GLUCOPHAGE CREATININE > 1.5'
 ;  Called from R67R1A+12.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R67R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^28^^Metformin - Creatinine results: "_$$GETDATA(DFN,"86^111",125) I 1
 E  S OCXCMSG="Metformin - Creatinine results: "_$$GETDATA(DFN,"86^111",125)
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R67R2A ; Verify all Event/Elements of  Rule #67 'GLUCOPHAGE - LAB RESULTS'  Relation #2 'GLUCOPHAGE ORDER AND NO GLUCOPHAGE CREATININE'
 ;  Called from EL86+6^OCXOZ0I, and EL112+5^OCXOZ0I.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE112( ---------->  Verify Event/Element: 'NO GLUCOPHAGE CREATININE'
 ; MCE86( ----------->  Verify Event/Element: 'GLUCOPHAGE ORDER'
 ;
 Q:$G(^OCXS(860.2,67,"INACT"))
 ;
 I $$MCE86 D 
 .I $$MCE112 D R67R2B
 Q
 ;
R67R2B ; Send Order Check, Notication messages and/or Execute code for  Rule #67 'GLUCOPHAGE - LAB RESULTS'  Relation #2 'GLUCOPHAGE ORDER AND NO GLUCOPHAGE CREATININE'
 ;  Called from R67R2A+12.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R67R2B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^28^^Metformin - no serum creatinine within past "_$$GETDATA(DFN,"86^112",127)_" days." I 1
 E  S OCXCMSG="Metformin - no serum creatinine within past "_$$GETDATA(DFN,"86^112",127)_" days."
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
CKSUM(STR) ;  Compiler Function: GENERATE STRING CHECKSUM
 ;
 N CKSUM,PTR,ASC S CKSUM=0
 S STR=$TR(STR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 F PTR=$L(STR):-1:1 S ASC=$A(STR,PTR)-42 I (ASC>0),(ASC<51) S CKSUM=CKSUM*2+ASC
 Q +CKSUM
 ;
GETDATA(DFN,OCXL,OCXDFI) ;     This Local Extrinsic Function returns runtime data
 ;
 N OCXE,VAL,PC S VAL=""
 F PC=1:1:$L(OCXL,U) S OCXE=$P(OCXL,U,PC) I OCXE S VAL=$G(^TMP("OCXCHK",$J,DFN,OCXE,OCXDFI)) Q:$L(VAL)
 Q VAL
 ;
MCE111() ; Verify Event/Element: GLUCOPHAGE CREATININE > 1.5
 ;
 ;  OCXDF(127) -> RECENT GLUCOPHAGE CREATININE DAYS data field
 ;  OCXDF(125) -> RECENT GLUCOPHAGE CREATININE TEXT data field
 ;  OCXDF(126) -> RECENT GLUCOPHAGE CREATININE RESULT data field
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(111,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),111)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),111))
 S OCXRES(111)=0,OCXDF(126)=$P($$GLCREAT^ORKPS(OCXDF(37)),"^",3) I $L(OCXDF(126)) S OCXRES(111,126)=OCXDF(126) I (OCXDF(126)>1.5)
 E  Q 0
 S OCXDF(125)=$P($$GLCREAT^ORKPS(OCXDF(37)),"^",2),OCXDF(127)=$P($$GCDAYS^ORKPS(OCXDF(37)),"^",1),OCXRES(111)=11 M ^TMP("OCXCHK",$J,OCXDF(37),111)=OCXRES(111)
 Q +OCXRES(111)
 ;
MCE112() ; Verify Event/Element: NO GLUCOPHAGE CREATININE
 ;
 ;  OCXDF(127) -> RECENT GLUCOPHAGE CREATININE DAYS data field
 ;  OCXDF(125) -> RECENT GLUCOPHAGE CREATININE TEXT data field
 ;  OCXDF(124) -> RECENT GLUCOPHAGE CREATININE FLAG data field
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(112,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),112)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),112))
 S OCXRES(112)=0,OCXDF(124)=$P($$GLCREAT^ORKPS(OCXDF(37)),"^",1) I $L(OCXDF(124)) S OCXRES(112,124)=OCXDF(124) I '(OCXDF(124))
 E  Q 0
 S OCXDF(125)=$P($$GLCREAT^ORKPS(OCXDF(37)),"^",2),OCXDF(127)=$P($$GCDAYS^ORKPS(OCXDF(37)),"^",1),OCXRES(112)=11 M ^TMP("OCXCHK",$J,OCXDF(37),112)=OCXRES(112)
 Q +OCXRES(112)
 ;
MCE86() ; Verify Event/Element: GLUCOPHAGE ORDER
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(86,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),86)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),86))
 Q 0
 ;
NEWRULE(OCXDFN,OCXORD,OCXRUL,OCXREL,OCXNOTF,OCXMESS) ; Has this rule already been triggered for this order number
 ;
 ;
 Q:'$G(OCXDFN) 0 Q:'$G(OCXRUL) 0
 Q:'$G(OCXREL) 0  Q:'$G(OCXNOTF) 0  Q:'$L($G(OCXMESS)) 0
 S OCXORD=+$G(OCXORD),OCXDFN=+OCXDFN
 ;
 N OCXNDX,OCXDATA,OCXDFI,OCXELE,OCXGR,OCXTIME,OCXCKSUM,OCXTSP,OCXTSPL
 ;
 S OCXTIME=(+$H)
 S OCXCKSUM=$$CKSUM(OCXMESS)
 ;
 S OCXTSP=($H*86400)+$P($H,",",2)
 S OCXTSPL=($G(^OCXD(860.7,"AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM))+$G(OCXTSPI,300))
 ;
 Q:(OCXTSPL>OCXTSP) 0
 ;
 K OCXDATA
 S OCXDATA(OCXDFN,0)=OCXDFN
 S OCXDATA("B",OCXDFN,OCXDFN)=""
 S OCXDATA("AT",OCXTIME,OCXDFN,OCXRUL,+OCXORD,OCXCKSUM)=OCXTSP
 ;
 S OCXGR="^OCXD(860.7"
 D SETAP(OCXGR_")",0,.OCXDATA,OCXDFN)
 ;
 K OCXDATA
 S OCXDATA(OCXRUL,0)=OCXRUL_U_(OCXTIME)_U_(+OCXORD)
 S OCXDATA(OCXRUL,"M")=OCXMESS
 S OCXDATA("B",OCXRUL,OCXRUL)=""
 S OCXGR=OCXGR_","_OCXDFN_",1"
 D SETAP(OCXGR_")","860.71P",.OCXDATA,OCXRUL)
 ;
 K OCXDATA
 S OCXDATA(OCXREL,0)=OCXREL
 S OCXDATA("B",OCXREL,OCXREL)=""
 S OCXGR=OCXGR_","_OCXRUL_",1"
 D SETAP(OCXGR_")","860.712",.OCXDATA,OCXREL)
 ;
 S OCXELE=0 F  S OCXELE=$O(^OCXS(860.2,OCXRUL,"C","C",OCXELE)) Q:'OCXELE  D
 .;
 .N OCXGR1
 .S OCXGR1=OCXGR_","_OCXREL_",1"
 .K OCXDATA
 .S OCXDATA(OCXELE,0)=OCXELE
 .S OCXDATA(OCXELE,"TIME")=OCXTIME
 .S OCXDATA(OCXELE,"LOG")=$G(OCXOLOG)
 .S OCXDATA("B",OCXELE,OCXELE)=""
 .K ^OCXD(860.7,OCXDFN,1,OCXRUL,1,OCXREL,1,OCXELE)
 .D SETAP(OCXGR1_")","860.7122P",.OCXDATA,OCXELE)
 .;
 .S OCXDFI=0 F  S OCXDFI=$O(^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)) Q:'OCXDFI  D
 ..N OCXGR2
 ..S OCXGR2=OCXGR1_","_OCXELE_",1"
 ..K OCXDATA
 ..S OCXDATA(OCXDFI,0)=OCXDFI
 ..S OCXDATA(OCXDFI,"VAL")=^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)
 ..S OCXDATA("B",OCXDFI,OCXDFI)=""
 ..D SETAP(OCXGR2_")","860.71223P",.OCXDATA,OCXDFI)
 ;
 Q 1
 ;
SETAP(ROOT,DD,DATA,DA) ;  Set Rule Event data
 M @ROOT=DATA
 I +$G(DD) S @ROOT@(0)="^"_($G(DD))_"^"_($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 I '$G(DD) S $P(@ROOT@(0),U,3,4)=($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;
 Q
 ;
 ;
