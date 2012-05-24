ORWDXR  ; SLC/KCM/JDL - Utilites for Order Actions ;5/30/06  14:50
        ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,125,131,134,141,149,187,190,213,243**;Dec 17, 1997;Build 242
        ;
ACTDCREA(DCIEN) ; Valid DC Reason
        N X
        S X=$G(^ORD(100.03,DCIEN,0))
        I $P(X,U,4) Q 0
        I $P(X,U,5)'=+$O(^DIC(9.4,"C","OR",0)) Q 0
        I $P(X,U,7)=+$O(^ORD(100.02,"C","A",0)) Q 0
        Q 1
        ;
ISREL(VAL,ORIFN)        ; Return true if an order has been released
        N STS S STS=$P(^OR(100,+ORIFN,3),U,3)
        S VAL=$S(STS=10:0,STS=11:0,1:1)  ; false if delayed or unreleased order
        Q
RENEW(REC,ORIFN,ORVP,ORNP,ORL,FLDS,CPLX,ORAPPT) ; Renew an order
        N ORDG
        N ORDUZ,ORSTS,OREVENT,ORCAT,ORDA,ORTS,ORNEW,ORCHECK,ORLOG,ORPKG
        N ORDIALOG,PRMT,X0
        N FSTDOSE,FST
        S (FSTDOSE,FST)=0
        I '$D(CPLX) S CPLX=0
        I '$G(ORAPPT) S ORAPPT=""
        S ORVP=ORVP_";DPT(",ORL(2)=ORL_";SC(",ORL=ORL(2)
        S X0=^OR(100,+ORIFN,0)
        S ORDG=$P(X0,U,11)
        S ORPKG=$P(X0,U,14)
        I $D(FLDS("ORCHECK")) M ORCHECK=FLDS("ORCHECK")
        I $P(X0,U,5)["101.41," D                        ; version 3
        . S ORDIALOG=+$P(X0,U,5),ORCAT=$P(^OR(100,+ORIFN,0),U,12)
        . D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD(+ORIFN)
        . I CPLX S FSTDOSE=$P($G(ORDIALOG("B","FIRST DOSE")),U,2) S:'FSTDOSE FSTDOSE=$$PTR^ORCD("OR GTX NOW")
        . I FSTDOSE,$G(ORDIALOG(FSTDOSE,1)) K ORDIALOG(FSTDOSE,1)
        E  D                                            ; version 2.5 generic
        . S ORDIALOG=$O(^ORD(101.41,"B","OR GXTEXT WORD PROCESSING ORDE",0))
        . D GETDLG^ORCD(ORDIALOG)
        . S PRMT=$O(^ORD(101.41,"B","OR GTX WORD PROCESSING 1",0))
        . S ORDIALOG(PRMT,1)=$NA(^TMP("ORWORD",$J,PRMT,1))
        . M ^TMP("ORWORD",$J,PRMT,1)=^OR(100,+ORIFN,1)
        . S PRMT=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",0))
        . I $P(X0,U,9) S ORDIALOG(PRMT,1)=$P(X0,U,9)
        I +FLDS(1)=999 D  ; generic order
        . S ORDIALOG($$PTR^ORCD("OR GTX START DATE/TIME"),1)=$P(FLDS(1),U,2)
        . S ORDIALOG($$PTR^ORCD("OR GTX STOP DATE/TIME"),1)=$P(FLDS(1),U,3)
        I ($O(^ORD(101.41,"AB","PS MEDS",0))>0),(+FLDS(1)=130)!(+FLDS(1)=135)!(+FLDS(1)=140),'$L($G(ORDIALOG($$PTR^ORCD("OR GTX SIG"),1))) D
        . N ORDOSE,ORDRUG,ORCAT,ORWPSOI,PROMPT,DRUG
        . S ORCAT=$P($G(^OR(100,+ORIFN,0)),U,12)
        . S PROMPT=$$PTR^ORCD("OR GTX INSTRUCTIONS")
        . S ORDRUG=$G(ORDIALOG($$PTR^ORCD("OR GTX DISPENSE DRUG"),1))
        . S ORWPSOI=+$G(ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1))
        . I ORWPSOI S ORWPSOI=+$P($G(^ORD(101.43,+ORWPSOI,0)),U,2)
        . D DOSE^PSSORUTL(.ORDOSE,ORWPSOI,$S(ORCAT="I":"U",1:"O"),ORVP)       ; dflt doses
        . D D1^ORCDPS2  ; set up ORDOSE
        . S DRUG=$G(ORDOSE("DD",+ORDRUG))
        . I DRUG,ORCAT="O" D RESETID^ORCDPS
        . D SIG^ORCDPS2
        I +FLDS(1)=140 D  ; outpatient meds
        . K ORDIALOG($$PTR^ORCD("OR GTX START DATE"),1) ; remove effective dt
        . S ORDIALOG($$PTR^ORCD("OR GTX REFILLS"),1)=$P(FLDS(1),U,4)
        . S ORDIALOG($$PTR^ORCD("OR GTX ROUTING"),1)=$P(FLDS(1),U,5)
        . S PRMT=$$PTR^ORCD("OR GTX WORD PROCESSING 1")
        . K ^TMP("ORWORD",$J,PRMT,1)
        . S I=1 F  S I=$O(FLDS(I)) Q:'I  S ^TMP("ORWORD",$J,PRMT,1,I-1,0)=FLDS(I)
        . S ^TMP("ORWORD",$J,PRMT,1,0)=U_U_(I-1)_U_(I-1)_U_DT_U
        . S ORDIALOG(PRMT,1)=$NA(^TMP("ORWORD",$J,PRMT,1))
        . N SIG,PI,X S SIG=$$PTR^ORCD("OR GTX SIG")
        . S PI=$$PTR^ORCD("OR GTX PATIENT INSTRUCTIONS"),X=$$STR(PI)
        . I $L(X),$$STR(SIG)[X S ORDIALOG(PI,"FORMAT")="@" ;PI in Sig
        D RN^ORCSAVE
        S REC="" S ORIFN=+ORIFN_";"_ORDA D GETBYIFN^ORWORR(.REC,ORIFN)
        Q
RNWFLDS(LST,ORIFN)      ; Return fields for renew action
        ; LST(0)=RenewType^Start^Stop^Refills^Pickup  LST(n)=Comments
        N X0,DG,PKG,RNWTYPE,START,STOP,REFILLS,OROI
        S ORIFN=+ORIFN,X0=^OR(100,ORIFN,0),DG=$P(X0,U,11),PKG=$P(X0,U,14)
        S PKG=$E($P(^DIC(9.4,PKG,0),U,2),1,2),DG=$P(^ORD(100.98,DG,0),U,3)
        S LST(0)=$S(PKG="OR":999,PKG="PS"&(DG="O RX"):140,PKG="PS"&(DG="UD RX"):130,PKG="PS"&(DG="NV RX"):145,1:0)
        I +LST(0)=140 D
        . S LST(0)=LST(0)_U_U_U_+$$VAL(ORIFN,"REFILLS")_U_$$VAL(ORIFN,"PICKUP")
        . ;D WPVAL(.LST,ORIFN,"COMMENT")
        I +LST(0)=999 S LST(0)=LST(0)_U_$$VAL(ORIFN,"START")_U_$$VAL(ORIFN,"STOP")
        ; make sure start/stop times are relative times, otherwise use NOW, no Stop
        I +$P(LST(0),U,2) S $P(LST(0),U,2)="NOW"
        I +$P(LST(0),U,3)!($P(LST(0),U,3)="0") S $P(LST(0),U,3)=""
        ;NEW STUFF AFTER THIS LINE OR*3*243
        S $P(LST(0),U,9)=0
        S OROI=$O(^OR(100,+ORIFN,4.5,"ID","ORDERABLE",0))
        Q:'OROI
        S OROI=$G(^OR(100,+ORIFN,4.5,OROI,1))
        Q:'OROI
        S $P(LST(0),U,9)=$$ISCLOZ^ORALWORD(OROI)
        ; add to LST node specifying if patient of ORIFN passes clozapine lab tests
        I $P(LST(0),U,9) D
        .N ORY,ORDFN,ORTMP
        .S ORTMP=LST(0)
        .K LST
        .S LST(0)=ORTMP
        .S ORDFN=$P(^OR(100,ORIFN,0),U,2)
        .I $P(ORDFN,";",2)'="DPT(" Q
        .S ORDFN=+ORDFN
        .D ALLWORD^ORALWORD(.ORY,ORDFN,ORIFN,"E")
        .M LST(1)=ORY
        Q
VAL(ORIFN,ID)   ; Return value for order response
        N DA S DA=+$O(^OR(100,ORIFN,4.5,"ID",ID,0))
        Q $G(^OR(100,ORIFN,4.5,DA,1))
WPVAL(TXT,ORIFN,ID)     ; Return word processing value
        N DA S DA=+$O(^OR(100,ORIFN,4.5,"ID",ID,0))
        S I=0 F  S I=$O(^OR(100,ORIFN,4.5,DA,2,I)) Q:'I  S TXT(I)=^(I,0)
        Q
STR(PTR)        ; -- Return word processing text as long string for comparison
        N X,Y,I,ARRY
        S ARRY=$G(ORDIALOG(+$G(PTR),1)) Q:'$L(ARRY) ""
        S I=+$O(@ARRY@(0)),Y=$$UP^XLFSTR($G(@ARRY@(I,0)))
        F  S I=+$O(@ARRY@(I)) Q:'I  S X=$G(@ARRY@(I,0)),Y=Y_$$UP^XLFSTR(X)
        S Y=$TR(Y," ") ;remove all spaces, compare only text
        Q Y
CHKACT(ORDERID,ORWSIG,ORWREL,ORWNATR)   ; Return error if can't sign/release order
        N ORACT,ORWERR
        ; begin case
        S ORACT=""
        I (ORWSIG=1),$D(^XUSEC("ORES",DUZ)) S ORACT="ES" G XC1
        I (ORWSIG=7),$D(^XUSEC("ORES",DUZ)) S ORACT="DS" G XC1
        I ORWREL,(ORWNATR="W") S ORACT="OC" G XC1
        I ORWREL S ORACT="RS" S:$P($G(^OR(100,+ORDERID,0)),U,16)<2 ORACT="ES"
XC1     ; end case
        S ORWERR=""
        I $L(ORACT),$$VALID^ORCACT0(ORDERID,ORACT,.ORWERR,ORWNATR) S ORWERR=""
        Q ORWERR
GTORITM(Y,ORIFN)        ;-- Get back the orderable item IEN
        S ORIFN=+ORIFN
        S Y=$$VALUE^ORCSAVE2(ORIFN,"ORDERABLE")
        Q
GETPKG(Y,IFN)   ;Get package for an order
        N ORDERID,PKGID
        Q:+IFN<1
        S ORDERID=+IFN,Y=""
        S PKGID=$P(^OR(100,ORDERID,0),U,14)
        S:PKGID>0 Y=$P(^DIC(9.4,PKGID,0),U,2)
        Q
ISCPLX(ORY,ORID)        ; 1: is complex order 0: is not
        Q:'$D(^OR(100,+ORID,0))
        N PKG
        S PKG=$P($G(^OR(100,+ORID,0)),U,14)
        S PKG=$$NMSP^ORCD(PKG)
        I PKG'="PS" Q
        N NUMCHDS,NOWID,NOWVAL
        S (NOWVAL,NOWID)=0
        S NUMCHDS=$P($G(^OR(100,+ORID,2,0)),U,4)
        I NUMCHDS>2 S ORY=1 Q
        I NUMCHDS=2 D
        . S ORY=1
        . S:$D(^OR(100,+ORID,4.5,"ID","NOW")) NOWID=$O(^("NOW",0))
        . S:NOWID NOWVAL=$G(^OR(100,+ORID,4.5,NOWID,1))
        I NOWVAL=1 S ORY=0 Q
        Q
ORCPLX(ORY,ORID,ORACT)  ;Return children orders of the complex order
        Q:'$D(^OR(100,+ORID,0))
        N PKG,LACT,OELACT,ISNOW
        S PKG=$P($G(^OR(100,+ORID,0)),U,14)
        S PKG=$$NMSP^ORCD(PKG)
        I PKG'="PS" Q
        N CHLDCNT,IDX,X3
        S (CHLDCNT,IDX)=0
        S:$L($G(^OR(100,+ORID,2,0))) CHLDCNT=$P(^(0),U,4)
        I 'CHLDCNT Q
        F  S IDX=$O(^OR(100,+ORID,2,IDX)) Q:'IDX  D
        . S (LACT,OELACT,ISNOW)=0
        . D ISNOW(.ISNOW,IDX)
        . Q:ISNOW
        . S X3=$G(^OR(100,IDX,3))
        . S LACT=$P(X3,U,7)
        . F  S OELACT=$O(^OR(100,IDX,8,OELACT),-1) Q:OELACT
        . S:OELACT>LACT LACT=OELACT
        . S ORY(IDX)=IDX_";"_LACT
        Q
CANRN(ORY,ORID) ; Check conjunction for renew.
        ; All conjunctioni = "And" return 1
        ; Has a "Then" return 0
        Q:'$G(^OR(100,+ORID,0))
        N PKG
        S PKG=$P($G(^OR(100,+ORID,0)),U,14)
        S PKG=$$NMSP^ORCD(PKG)
        I PKG'="PS" Q
        N INDX,INDY,CANRENEW
        S INDX=0
        S CANRENEW=1
        N CHID
        S CHID=0 F  S CHID=$O(^OR(100,+ORID,2,CHID)) Q:'CHID  D
        . N ORSTS,ACTIVE S ORSTS=0
        . S ORSTS=$P($G(^OR(100,CHID,3)),U,3)
        . S ACTIVE=$O(^ORD(100.01,"B","ACTIVE",0))
        . I ACTIVE'=ORSTS S CANRENEW=0
        I 'CANRENEW S ORY=CANRENEW Q
        F  S INDX=$O(^OR(100,+ORID,4.5,"ID","CONJ",INDX)) Q:'INDX  D
        . S INDY=0 F  S INDY=$O(^OR(100,+ORID,4.5,INDX,INDY)) Q:'INDY  D
        . . I $G(^(INDY))="T" S CANRENEW=0 Q
        . I CANRENEW=0 Q
        S ORY=CANRENEW
        Q
ISNOW(ORY,ORID) ; Is first time now order?
        N SCH
        Q:'$D(^OR(100,+ORID,0))
        S SCH=""
        S SCH=$O(^OR(100,+ORID,4.5,"ID","SCHEDULE",0))
        S:SCH SCH=$G(^OR(100,+ORID,4.5,SCH,1))
        S:SCH="NOW" ORY=1
        Q
