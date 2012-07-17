OCXOZ0V ;SLC/RJS,CLA - Order Check Scan ;NOV 3,2010 at 19:22
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
R50R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #50 'BIOCHEM ABNORMALITIES/CONTRAST MEDIA CHE...'  Relation #1 'CONTRAST MEDIA ORDER AND ABNORMAL RENAL RESULTS'
 ;  Called from R50R1A+12^OCXOZ0U.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R50R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^9^^Procedure uses intravenous contrast media - abnormal biochem result:  "_$$GETDATA(DFN,"129^130",58) I 1
 E  S OCXCMSG="Procedure uses intravenous contrast media - abnormal biochem result:  "_$$GETDATA(DFN,"129^130",58)
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R50R2A ; Verify all Event/Elements of  Rule #50 'BIOCHEM ABNORMALITIES/CONTRAST MEDIA CHE...'  Relation #2 'CONTRAST MEDIA ORDER AND NO CREAT RESULTS W/IN X D...'
 ;  Called from EL130+6^OCXOZ0H, and EL133+5^OCXOZ0H.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE130( ---------->  Verify Event/Element: 'CONTRAST MEDIA ORDER'
 ; MCE133( ---------->  Verify Event/Element: 'NO CREAT RESULTS W/IN X DAYS'
 ;
 Q:$G(^OCXS(860.2,50,"INACT"))
 ;
 I $$MCE130 D 
 .I $$MCE133 D R50R2B
 Q
 ;
R50R2B ; Send Order Check, Notication messages and/or Execute code for  Rule #50 'BIOCHEM ABNORMALITIES/CONTRAST MEDIA CHE...'  Relation #2 'CONTRAST MEDIA ORDER AND NO CREAT RESULTS W/IN X D...'
 ;  Called from R50R2A+12.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R50R2B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^9^^Procedure uses intravenous contrast media - no creatinine results within "_$$GETDATA(DFN,"130^133",154)_" days" I 1
 E  S OCXCMSG="Procedure uses intravenous contrast media - no creatinine results within "_$$GETDATA(DFN,"130^133",154)_" days"
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R51R1A ; Verify all Event/Elements of  Rule #51 'RECENT CHOLECYSTOGRAM ORDER'  Relation #1 'RECENT CHOLECGRM'
 ;  Called from EL63+5^OCXOZ0H.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE63( ----------->  Verify Event/Element: 'PATIENT HAS RECENT CHOLECYSTOGRAM'
 ;
 Q:$G(^OCXS(860.2,51,"INACT"))
 ;
 I $$MCE63 D R51R1B
 Q
 ;
R51R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #51 'RECENT CHOLECYSTOGRAM ORDER'  Relation #1 'RECENT CHOLECGRM'
 ;  Called from R51R1A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R51R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^15^^Recent Cholecystogram: "_$$GETDATA(DFN,"63^",61)_" ["_$$GETDATA(DFN,"63^",122)_"]" I 1
 E  S OCXCMSG="Recent Cholecystogram: "_$$GETDATA(DFN,"63^",61)_" ["_$$GETDATA(DFN,"63^",122)_"]"
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R53R1A ; Verify all Event/Elements of  Rule #53 'RENAL FUNCTIONS OVER AGE 65 CHECK'  Relation #1 'PHARM PAT OVER 65'
 ;  Called from EL64+5^OCXOZ0H.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE64( ----------->  Verify Event/Element: 'PHARMACY PATIENT OVER 65'
 ;
 Q:$G(^OCXS(860.2,53,"INACT"))
 ;
 I $$MCE64 D R53R1B
 Q
 ;
R53R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #53 'RENAL FUNCTIONS OVER AGE 65 CHECK'  Relation #1 'PHARM PAT OVER 65'
 ;  Called from R53R1A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R53R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^21^^Patient >65. Renal Results: "_$$GETDATA(DFN,"64^",64) I 1
 E  S OCXCMSG="Patient >65. Renal Results: "_$$GETDATA(DFN,"64^",64)
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R54R1A ; Verify all Event/Elements of  Rule #54 'CONCURRENT LAB ORDERS FOR ANGIOGRAM, CAT...'  Relation #1 'ANGIOGRAM'
 ;  Called from EL65+5^OCXOZ0H.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE65( ----------->  Verify Event/Element: 'SESSION ORDER FOR ANGIOGRAM'
 ;
 Q:$G(^OCXS(860.2,54,"INACT"))
 ;
 I $$MCE65 D R54R1B
 Q
 ;
R54R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #54 'CONCURRENT LAB ORDERS FOR ANGIOGRAM, CAT...'  Relation #1 'ANGIOGRAM'
 ;  Called from R54R1A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R54R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^22^^Missing Labs for Angiogram: "_$$GETDATA(DFN,"65^",68) I 1
 E  S OCXCMSG="Missing Labs for Angiogram: "_$$GETDATA(DFN,"65^",68)
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
R55R1A ; Verify all Event/Elements of  Rule #55 'ALLERGY - CONTRAST MEDIA REACTION'  Relation #1 'ALLERGY'
 ;  Called from EL66+5^OCXOZ0H.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; MCE66( ----------->  Verify Event/Element: 'CONTRAST MEDIA ALLERGY'
 ;
 Q:$G(^OCXS(860.2,55,"INACT"))
 ;
 I $$MCE66 D R55R1B
 Q
 ;
R55R1B ; Send Order Check, Notication messages and/or Execute code for  Rule #55 'ALLERGY - CONTRAST MEDIA REACTION'  Relation #1 'ALLERGY'
 ;  Called from R55R1A+10.
 ;
 Q:$G(OCXOERR)
 ;
 ;      Local Extrinsic Functions
 ; GETDATA( ---------> GET DATA FROM THE ACTIVE DATA FILE
 ;
 Q:$D(OCXRULE("R55R1B"))
 ;
 N OCXNMSG,OCXCMSG,OCXPORD,OCXFORD,OCXDATA,OCXNUM,OCXDUZ,OCXQUIT,OCXLOGS,OCXLOGD
 I ($G(OCXOSRC)="CPRS ORDER PRESCAN") S OCXCMSG=(+OCXPSD)_"^4^^Patient allergic to contrast media. ("_$$GETDATA(DFN,"66^",159)_") This procedure uses: "_$$GETDATA(DFN,"66^",66) I 1
 E  S OCXCMSG="Patient allergic to contrast media. ("_$$GETDATA(DFN,"66^",159)_") This procedure uses: "_$$GETDATA(DFN,"66^",66)
 S OCXNMSG=""
 ;
 Q:$G(OCXOERR)
 ;
 ; Send Order Check Message
 ;
 S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG
 Q
 ;
GETDATA(DFN,OCXL,OCXDFI) ;     This Local Extrinsic Function returns runtime data
 ;
 N OCXE,VAL,PC S VAL=""
 F PC=1:1:$L(OCXL,U) S OCXE=$P(OCXL,U,PC) I OCXE S VAL=$G(^TMP("OCXCHK",$J,DFN,OCXE,OCXDFI)) Q:$L(VAL)
 Q VAL
 ;
MCE130() ; Verify Event/Element: CONTRAST MEDIA ORDER
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(130,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),130)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),130))
 Q 0
 ;
MCE133() ; Verify Event/Element: NO CREAT RESULTS W/IN X DAYS
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(133,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),133)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),133))
 Q 0
 ;
MCE63() ; Verify Event/Element: PATIENT HAS RECENT CHOLECYSTOGRAM
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(63,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),63)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),63))
 Q 0
 ;
MCE64() ; Verify Event/Element: PHARMACY PATIENT OVER 65
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(64,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),64)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),64))
 Q 0
 ;
MCE65() ; Verify Event/Element: SESSION ORDER FOR ANGIOGRAM
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(65,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),65)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),65))
 Q 0
 ;
MCE66() ; Verify Event/Element: CONTRAST MEDIA ALLERGY
 ;
 ;  OCXDF(37) -> PATIENT IEN data field
 ;
 N OCXRES
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXRES(66,37)=OCXDF(37)
 Q:'(OCXDF(37)) 0 I $D(^TMP("OCXCHK",$J,OCXDF(37),66)) Q $G(^TMP("OCXCHK",$J,OCXDF(37),66))
 Q 0
 ;
