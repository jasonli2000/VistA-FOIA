IBCECSA6 ;ALB/CXW - VIEW EOB SCREEN ;01-OCT-1999
 ;;2.0;INTEGRATED BILLING;**137,135,155**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLD ;build EOB data display
 D GETEOB(IBCNT,0)
 Q
 ;
GETEOB(IBCNT,IBSRC,IBFULL,IBJTIBLN) ; Get EOB data in display format
 ; IBCNT = the ien of the entry in file 361.1
 ; IBSRC = 1 if called from AR, 0 if List Manager format needed
 ;       = 2 if called from AR and header data is desired
 ;   If IBSRC > 0  ^TMP("PRCA_EOB",$J,IBCNT,n)=line n's text is ret'd
 ; IBFULL = 1 if no check should be made to eliminate a fld whose value=0
 ; IBJTIBLN = line number to start VALMCNT with (optional)
 ;            used by IBJTBA1
 ;
 N IBREC,IBTYP,CNT,IBREM
 S IBFULL=$G(IBFULL),IBSRC=$G(IBSRC)
 I IBSRC N VALMBG,VALMCNT
 S VALMCNT=0,VALMBG=1,CNT=0
 I $G(IBJTIBLN)>0 S VALMCNT=IBJTIBLN
 S IBREC=$G(^IBM(361.1,IBCNT,0)),IBTYP=$P(IBREC,U,4)
 I IBSRC K ^TMP("PRCA_EOB",$J,IBCNT)
 ; Once we're displaying a single EOB, remove the multiple EOB header of
 ; the View EOB screen that was set in HDR^IBCEOB2 - VALMHDR(4).
 I 'IBSRC,$G(VALMHDR(4))'="" S VALMHDR(4)=""
 D GEN,PAY,ARCP^IBCECSA7,CLVL,CLVLA,MIN^IBCECSA5,MOUT,LLVLA^IBCECSA7,RDATA^IBCECSA7
 Q
 ;
SEL(IB,ONE) ;
 N IBDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 S IBDA=$O(VALMY(IBDA)) Q:'IBDA  D
 . S IB=$P($G(^TMP("IBCECSD",$J,IBDA)),U,2)
 . S IBONE=1
 Q
 ;
ACT ; Reposition display using actions
 I '$G(IBONE) D SEL(.IBCNT,1) D BLD:$G(IBCNT)
 S VALMBG=$G(^TMP("IBCECSD",$J,"X",+$G(IBACT))) S:'VALMBG VALMBG=1
 S VALMBCK="R"
 Q
 ;
SET(IBSRC,X,CNT,IBCNT) ;set list manager arrays
 S VALMCNT=VALMCNT+1,IBSRC=$G(IBSRC)
 ;
 I IBSRC D  Q
 . S ^TMP("PRCA_EOB",$J,IBCNT,VALMCNT)=X
 ;
 S ^TMP("IBCECSD",$J,VALMCNT,0)=X
 S ^TMP("IBCECSD",$J,"IDX",VALMCNT,CNT)=""
 S ^TMP("IBCECSD",$J,CNT)=VALMCNT_U_IBCNT
 Q
 ;
GEN ;
 S IBSRC=$G(IBSRC) Q:IBSRC=1
 N IBREC1,IBTMP,IBSPL
 S IBSPL=+$O(^IBM(361.1,IBCNT,8,0)),IBSPL=(+$O(^(IBSPL))'=IBSPL)
 S IB=$$SETSTR^VALM1("EOB GENERAL INFORMATION:","",1,50)
 D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBSRC D
 . D CNTRL^VALM10(VALMCNT,1,24,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",1)=VALMCNT
 S IB=$$SETSTR^VALM1("Type        : "_$S(IBTYP:"MEDICARE MRA",1:"NORMAL EOB")_$S(IBSPL:" (SPLIT IN A/R)",1:""),"",2,39)
 S IB=$$SETSTR^VALM1("EOB Paid DT  : "_$$DAT1^IBOUTL($P(IBREC,U,6),1),IB,41,38)
 D SET(IBSRC,IB,CNT,IBCNT)
 I IBSRC D
 . S IB=$$SETSTR^VALM1($S(IBSRC:"Entry Dt/Tm :"_$$DAT1^IBOUTL($P(IBREC,U,5),1),1:""),"",2,39)
 . S IBTMP=$P(IBREC,U,13)
 . S IB=$$SETSTR^VALM1("Claim Status : "_$$EXTERNAL^DILFD(361.1,.13,"",IBTMP),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 . S IBTMP=$P(IBREC,U,16)
 . S IB=$$SETSTR^VALM1("Review Status: "_$$EXTERNAL^DILFD(361.1,.16,"",IBTMP),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 . S IB=$$SETSTR^VALM1("Entered By  : "_$P($G(^VA(200,+$P(IBREC,U,18),0)),U),"",2,39)
 . S IBTMP=$P(IBREC,U,15)
 . S IB=$$SETSTR^VALM1("Insurance Seq: "_$$EXTERNAL^DILFD(361.1,.15,"",IBTMP),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBSRC D
 . S IB=$$SETSTR^VALM1($S($P(IBREC,U,17):"Manual Entry: YES",1:""),"",2,39)
 . S IBTMP=$P(IBREC,U,13)
 . S IB=$$SETSTR^VALM1("Claim Status : "_$$EXTERNAL^DILFD(361.1,.13,"",IBTMP),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 . S IBTMP=$P(IBREC,U,15)
 . S IB=$$SETSTR^VALM1("Insurance Seq: "_$$EXTERNAL^DILFD(361.1,.15,"",IBTMP),"",41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 S IBREC1=$G(^IBM(361.1,IBCNT,100))
 I $S($G(IBFULL):1,1:$P(IBREC1,U,4)'=""!($P(IBREC1,U,3)'="")) D
 . S IB=$$SETSTR^VALM1("Last Edited : "_$$DAT1^IBOUTL($P(IBREC1,U,4),1),"",2,39)
 . S IB=$$SETSTR^VALM1("Last Edit By : "_$P($G(^VA(200,+$P(IBREC1,U,3),0)),U),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 ;
 D INSINF^IBCECSA7(+IBREC,CNT,IBCNT)
 ;
 I $S($G(IBFULL):1,1:$P($G(^IBM(361.1,IBCNT,6)),U)'=""!($P($G(^IBM(361.1,IBCNT,6)),U,2)'="")) D
 . S IB=$$SETSTR^VALM1("New Pat. Nm.: "_$P($G(^IBM(361.1,IBCNT,6)),U),"",2,39)
 . S IB=$$SETSTR^VALM1("New Pat. Id  : "_$P($G(^IBM(361.1,IBCNT,6)),U,2),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 D:IBSRC SET(IBSRC,"",CNT,IBCNT)
 Q
 ;
PAY ;
 S IBSRC=$G(IBSRC) Q:IBSRC=1
 N IBREC1,IBTMP
 S IB=$$SETSTR^VALM1("PAYER INFORMATION:","",1,50)
 D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBSRC D
 . D CNTRL^VALM10(VALMCNT,1,18,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",2)=VALMCNT
 S IB=$$SETSTR^VALM1("Payer Name   : "_$P($G(^DIC(36,+$P(IBREC,U,2),0)),U),"",2,39)
 S IB=$$SETSTR^VALM1("Payer Id    : "_$P(IBREC,U,3),IB,41,38)
 D SET(IBSRC,IB,CNT,IBCNT)
 S IB=$$SETSTR^VALM1("ICN          : "_$P(IBREC,U,14),"",2,39)
 D SET(IBSRC,IB,CNT,IBCNT)
 I $P(IBREC,U,9)'=""!($P(IBREC,U,8)'="") D
 . S IB=$$SETSTR^VALM1("Cross Ovr ID : "_$P(IBREC,U,9),"",2,39)
 . S IB=$$SETSTR^VALM1("Cross Ovr Nm: "_$P(IBREC,U,8),IB,41,38)
 . D SET(IBSRC,IB,CNT,IBCNT)
 D:IBSRC SET(IBSRC,"",CNT,IBCNT)
 Q
 ;
CLVL ;
 N IBREC1,IBTMP,IBRL
 S IB=$$SETSTR^VALM1("CLAIM LEVEL PAY STATUS:","",1,50),IBSRC=$G(IBSRC)
 D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBSRC D
 . D CNTRL^VALM10(VALMCNT,1,23,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",3)=VALMCNT
 I '$D(^IBM(361.1,IBCNT,2)),'$D(^IBM(361.1,IBCNT,1)) D SET(IBSRC," NONE",CNT,IBCNT) Q
 S IB=$$SETSTR^VALM1("Tot Submitted Chrg: "_$$A10($P($G(^IBM(361.1,IBCNT,2)),U,4)),"",2,39)
 S IBREC1=$G(^IBM(361.1,IBCNT,1))
 S IB=$$SETSTR^VALM1("Covered Amt       : "_$$A10($P(IBREC1,U,3)),IB,41,38)
 D SET(IBSRC,IB,CNT,IBCNT)
 S IB=$$SETSTR^VALM1("Payer Paid Amt    : "_$$A10($P(IBREC1,U)),"",2,39)
 S IB=$$SETSTR^VALM1("Patient Resp. Amt : "_$$A10($S(IBSRC:$P(IBREC1,U,2),$$FT^IBCEF(+IBREC)=3:$$PTRESPI^IBCECOB1(IBCNT),1:$P($G(^IBM(361.1,IBCNT,1)),"^",2))),IB,41,38)
 D SET(IBSRC,IB,CNT,IBCNT)
 S (IB,IBRL)=""
 I $S(IBFULL:1,1:$P(IBREC1,U,4)) S IB=$$SETSTR^VALM1("Discount Amt      : "_$$A10($P(IBREC1,U,4)),"",2,39),IBRL=1
 I $S(IBFULL:1,1:$P(IBREC1,U,5)) S IB=$$SETSTR^VALM1("Per Day Limit Amt : "_$$A10($P(IBREC1,U,5)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P(IBREC1,U,8)) S IB=$$SETSTR^VALM1("Tax Amt           : "_$$A10($P(IBREC1,U,8)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P(IBREC1,U,9)) S IB=$$SETSTR^VALM1("Tot Before Tax Amt: "_$$A10($P(IBREC1,U,9)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P($G(^IBM(361.1,IBCNT,2)),U,3)) S IB=$$SETSTR^VALM1("Total Allowed Amt : "_$$A10($P($G(^IBM(361.1,IBCNT,2)),U,3)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P($G(^IBM(361.1,IBCNT,2)),U,5)) S IB=$$SETSTR^VALM1("Negative Reimb Amt: "_$$A10($P($G(^IBM(361.1,IBCNT,2)),U,5)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $G(IBSRC) I $S(IBFULL:1,1:$P(IBREC,U,12)) S IB=$$SETSTR^VALM1("Discharge Fraction: "_$$A10($P(IBREC,U,12)),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P(IBREC,U,10)) S IB=$$SETSTR^VALM1("DRG Code Used     :"_$$RJ^XLFSTR($P(IBREC,U,10),11," "),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1) I IBRL=0 D SET(IBSRC,IB,CNT,IBCNT) S IB=""
 I $S(IBFULL:1,1:$P(IBREC,U,11)) S IB=$$SETSTR^VALM1("DRG Weight Used   :"_$$RJ^XLFSTR($P(IBREC,U,11),11," "),IB,$S('IBRL:2,1:41),$S('IBRL:39,1:38)),IBRL=$S(IBRL:0,1:1)
 D:IBRL'="" SET(IBSRC,IB,CNT,IBCNT)
 D:IBSRC SET(IBSRC,"",CNT,IBCNT)
 Q
 ;
MOUT ;
 N IBREC1,IBRL
 S IBREC1=$G(^IBM(361.1,IBCNT,3)),IBSRC=$G(IBSRC)
 I 'IBSRC,$$INPAT^IBCEF(+IBREC),$TR(IBREC1,"0^")="" Q
 I IBREC1="" D:'$D(^IBM(361.1,IBCNT,4)) SET(IBSRC,"  NONE",CNT,IBCNT) D:'IBSRC SET(IBSRC,"",CNT,IBCNT),REMARK^IBCECSA5 Q
 D SET(IBSRC," OUTPATIENT:",CNT,IBCNT)
 S IBRL=""
 I $S(IBFULL:1,1:$P(IBREC1,U)) S IB=$$SETSTR^VALM1("Reimburse Rate    : "_$$P10($P(IBREC1,U)),"",$S('IBRL:4,1:40),$S('IBRL:41,1:38)),IBRL=$S(IBRL:0,1:1)
 I $S(IBFULL:1,1:$P(IBREC1,U,2)) S IB=$$SETSTR^VALM1("HCPCS Pay Amt     : "_$$A10($P(IBREC1,U,2)),IB,$S('IBRL:4,1:40),$S('IBRL:41,1:38)),IBRL=$S(IBRL:0,1:1)
 D:IBRL=0 SET(IBSRC,IB,CNT,IBCNT)
 I $S(IBFULL:1,1:$P(IBREC1,U,8)) S IB=$$SETSTR^VALM1("Esrd Paid Amt     : "_$$A10($P(IBREC1,U,8)),"",$S('IBRL:4,1:40),$S('IBRL:41,1:38)),IBRL=$S(IBRL:0,1:1)
 D:IBRL=0 SET(IBSRC,IB,CNT,IBCNT)
 I $S(IBFULL:1,1:$P(IBREC1,U,9)) S IB=$$SETSTR^VALM1("Non-Pay Prof Comp : "_$$A10($P(IBREC1,U,9)),IB,$S('IBRL:4,1:40),$S('IBRL:41,1:38)),IBRL=$S(IBRL:0,1:1)
 D:IBRL'="" SET(IBSRC,IB,CNT,IBCNT)
 D REMARK^IBCECSA5
 D SET(IBSRC,"",CNT,IBCNT)
 Q
 ;
CLVLA ;
 N IBREC,IBFLG,GR,RSN,Z
 S IB=$$SETSTR^VALM1("CLAIM LEVEL ADJUSTMENTS:","",1,50),IBSRC=$G(IBSRC)
 D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBSRC D
 . D CNTRL^VALM10(VALMCNT,1,24,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",4)=VALMCNT
 S (Y,IBFLG)=0 F  S Y=$O(^IBM(361.1,IBCNT,10,Y)) Q:'Y  D
 . S IBREC=$G(^IBM(361.1,IBCNT,10,Y,0)),GR=$P(IBREC,U,1)
 . I GR="OA",$P($G(^IBM(361.1,IBCNT,10,Y,1,0)),U,4)=1,$D(^IBM(361.1,IBCNT,10,Y,1,"B","AB3")) Q   ; kludge
 . S IBREC=$$EXTERNAL^DILFD(361.11,.01,"",GR),IBFLG=1
 . D SET(IBSRC," GROUP CODE: "_IBREC,CNT,IBCNT)
 . S Z=0 F  S Z=$O(^IBM(361.1,IBCNT,10,Y,1,Z)) Q:'Z  D
 .. S IBREC=$G(^IBM(361.1,IBCNT,10,Y,1,Z,0)),RSN=$P(IBREC,U,1)
 .. I GR="OA",RSN="AB3" Q   ; kludge
 .. S IB=$$SETSTR^VALM1("REASON CODE: "_RSN_"  "_$P(IBREC,U,4),"",3,77)
 .. D SET(IBSRC,IB,CNT,IBCNT)
 .. S IB=$$SETSTR^VALM1("Amount: "_$$A10($P(IBREC,U,2)),"",3,40)
 .. S IB=$$SETSTR^VALM1("Quantity: "_$P(IBREC,U,3),IB,41,38)
 .. D SET(IBSRC,IB,CNT,IBCNT)
 I 'IBFLG D SET(IBSRC," NONE",CNT,IBCNT)
 D:IBSRC SET(IBSRC,"",CNT,IBCNT)
 Q
 ;
A10(X) ; returns a dollar amount right justified to 10 characters
 Q $$RJ^XLFSTR($FN(X,"",2),10," ")
 ;
P10(X) ; returns a % right just 10
 ; X is a decimal between 0-1
 Q $$RJ^XLFSTR((X*100)_"%",10," ")
 ;
