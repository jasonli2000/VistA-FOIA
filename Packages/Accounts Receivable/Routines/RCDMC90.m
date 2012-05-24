RCDMC90 ;WASH IRMFO@ALTOONA,PA/TJK-DMC 90 DAY ;7/17/97 8:13 AM
V       ;;4.5;Accounts Receivable;**45,108,133,121,163,190,192,236,237,229,253**;Mar 20, 1995;Build 9
        ;;Per VHA Directive 2004-038, this routine should not be modified.
ENTER   ;Entry point from nightly process
        Q:'$D(RCDOC)
        ;run the interest and admin for newly flagged Katrina Patients.
        I DT'<$P($G(^RC(342,1,30)),"^",1)&(DT'>$P($G(^RC(342,1,30)),"^",2)) D ^RCEXINAD
        N DEBTOR,BILL,DEBTOR0,B0,B6,B7,LTRDT3,P30DT,PRIN,INT,ADMIN,B4,B12
        N TPRIN,TINT,TADMIN,ESTDT,CATYP,DFN,CNTR,SITE,LN,FN,MN,STNM,DOB,SITE
        N PHONE,QUIT,TOTAL,ZIPCODE,FULLNM,XN,P91DT,OFFAMT,RCNT,TLINE,REPAY,X1,X2
        N LKUP,ADDR,ADDRPHO,CHKPHONE,PSSN
        K ^XTMP("RCDMC90",$J),^TMP($J,"RCDMC90") S ^XTMP("RCDMC90",0)=DT
        S SITE=$$SITE^RCMSITE(),TLINE="0^0^0"
        S X1=DT,X2=-91 D C^%DTC S P91DT=X
        S X1=DT,X2=-30 D C^%DTC S P30DT=X
        S (CNTR,DEBTOR)=0,RCNT=2 G UPDATE:$G(RCDOC)="W"
        ;MASTER SHEET COMPILATION
        F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:DEBTOR'?1N.N  D
        .N X,RCDFN
        .S RCDFN=$P($G(^RCD(340,DEBTOR,0)),"^",1) I $P(RCDFN,";",2)'["DPT" Q
        .S X=$$EMERES^PRCAUTL(+RCDFN) I X]""&('$D(^RCD(340,"DMC",1,DEBTOR))) Q  ;stop the master sheet compilation for hurricane Katrina sites
        .K ^TMP($J,"RCDMC90","BILL")
        .S QUIT=1,OFFAMT=+$P($G(^RCD(340,DEBTOR,3)),U,9)
        .D PROC(DEBTOR,.QUIT) Q:QUIT
        .;COMPILES FIELDS UNIQUE TO MASTER CODE SHEETS
        .S FULLNM=$$NM(DFN),FN=$P(FULLNM,U,3),MN=$P(FULLNM,U,4)
        .S LN=$P(FULLNM,U,1),XN=$P(FULLNM,U,2)
        .S FULLNM=FN_" "_$S(MN'="":$P(MN,".")_" ",1:"")_LN_$S(XN'="":" "_$P(XN,"."),1:"")
        .S STNM=$$LJ^XLFSTR($E(FN)_$S(MN'="":$E(MN),1:" ")_$E(LN,1,5),7," ")
        .S DOB=$$DATE8(+VADM(3))
        .;SET HOLDING GLOBAL FOR MASTER SHEETS
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$E($$LJ^XLFSTR($P(VADM(2),U),9),1,9)_STNM_SITE_DOB_PHONE_$$LJ^XLFSTR(FULLNM,40)_$$LJ^XLFSTR($E($P(ADDR,U,1),1,2),2)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$$LJ^XLFSTR($E($P(ADDR,U,1),3,40),38)_$$LJ^XLFSTR($E($P(ADDR,U,2),1,40),40)_$$LJ^XLFSTR($E($P(ADDR,U,3)),1)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$$LJ^XLFSTR($E($P(ADDR,U,3),2,40),39)_$$LJ^XLFSTR($E($P(ADDR,U,4),1,40),40)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$$LJ^XLFSTR($E($P(ADDR,U,5),1,40),40)_$$LJ^XLFSTR(ZIPCODE,9)_$$DATE8(ESTDT)_$$AMT(TPRIN)_$$AMT(TINT)_$E($$AMT(TADMIN),1,4)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$E($$AMT(TADMIN),5,9)_$$DATE8(DT)_CATYP_$$AMT(OFFAMT)_$$AMT($$BAL(DEBTOR))_$E("0000000000",1,10-$L(DEBTOR))_DEBTOR_"$"
        .S $P(^RCD(340,DEBTOR,3),U)=1,$P(^(3),U,2)=DT,$P(^(3),U,3)=ESTDT,$P(^(3),U,5)=TOTAL,$P(^(3),U,6)=TPRIN,$P(^(3),U,7)=TINT,$P(^(3),U,8)=TADMIN,^RCD(340,"DMC",1,DEBTOR)=""
        .S X=0 F  S X=$O(^TMP($J,"RCDMC90","BILL",X)) Q:'X  S ^PRCA(430,X,12)=^(X)
        .D SETREC
        .Q
        D COMPILE^RCDMC90U(375,CNTR,5,TLINE),KVAR
        Q
UPDATE  ;WEEKLY UPDATE COMPILATION
        F  S DEBTOR=$O(^RCD(340,"DMC",1,DEBTOR)) Q:DEBTOR'?1N.N  D
        .I '$G(^RCD(340,DEBTOR,3)) K ^RCD(340,"DMC",1,DEBTOR) Q
        .S QUIT=1,OFFAMT=+$P(^RCD(340,DEBTOR,3),U,9)
        .D PROC(DEBTOR,.QUIT) Q:QUIT
        .;SET HOLDING GLOBAL FOR WEEKLY UPDATES
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$E($$LJ^XLFSTR($P(VADM(2),U),9),1,9)_$$LJ^XLFSTR($E($P(ADDR,U,1),1,40),40)_$$LJ^XLFSTR($E($P(ADDR,U,2),1,30),30)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$$LJ^XLFSTR($E($P(ADDR,U,2),31,40),10)_$$LJ^XLFSTR($E($P(ADDR,U,3),1,40),40)_$$LJ^XLFSTR($E($P(ADDR,U,4),1,29),29)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$$LJ^XLFSTR($E($P(ADDR,U,4),30,40),11)_$$LJ^XLFSTR($E($P(ADDR,U,5),1,40),40)_$$LJ^XLFSTR(ZIPCODE,9)_SITE_PHONE_$E($$AMT(TPRIN),1,6)
        .S CNTR=CNTR+1
        .S ^XTMP("RCDMC90",$J,CNTR)=$E($$AMT(TPRIN),7,9)_$$AMT(TINT)_$$AMT(TADMIN)_$$DATE8(DT)_CATYP_$$AMT(OFFAMT)_$$AMT($$BAL(DEBTOR))_"$"
        .S:TOTAL $P(^RCD(340,DEBTOR,3),U,5)=TOTAL,$P(^(3),U,6)=TPRIN,$P(^(3),U,7)=TINT,$P(^(3),U,8)=TADMIN
        .D SETREC
        .Q
        D COMPILE^RCDMC90U(300,CNTR,4,TLINE),KVAR
        Q
KVAR    D KVAR^VADPT
        K RCDOC,^XTMP("RCDMC90",$J),VA("BID"),XMDUZ
        Q
PROC(DEBTOR,QUIT)       ;PROCESS BILLS FOR A SPECIFIC DEBTOR
        ;SETS DATA COMMON TO BOTH WEEKLY & MASTER CODESHEETS
        S DEBTOR0=$G(^RCD(340,DEBTOR,0))
        Q:$P(DEBTOR0,U)'["DPT"
        S DFN=+DEBTOR0 D DEM^VADPT Q:$E(VADM(2),1,5)="00000"
        F X=1:1:6 S CATYP(X)=""
        S (BILL,TOTAL,TPRIN,TINT,TADMIN,REPAY)=0,ESTDT=P91DT
        I RCDOC="W",$P(^RCD(340,DEBTOR,3),U,10) G TOTAL
        F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D  K:PRIN=0 ^PRCA(430,BILL,12) Q:REPAY
        .S (PRIN,INT,ADMIN)=0
        .I +VADM(6) Q
        .S B0=$G(^PRCA(430,BILL,0)),B4=$G(^(4)),B6=$G(^(6)),B7=$G(^(7)),B12=$G(^(12))
        .Q:$P(B0,U,8)'=16
        .I B4 D  Q
        ..S (TOTAL,TPRIN,TINT,TADMIN)=0
        ..S X=0 F  S X=$O(^PRCA(430,"C",DEBTOR,X)) Q:X'?1N.N  K ^PRCA(430,X,12)
        ..S REPAY=1
        ..Q
        .I RCDOC="W",'$P(B12,U) Q
        .S PRIN=$P(B7,U),INT=$P(B7,U,2),ADMIN=$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
        .I PRIN'>0,INT+ADMIN>0 D  Q
        ..N XMSUB,XMY,XMTEXT,MSG
        ..S XMSUB="Notice Of Active Bill Without Principal Balance"
        ..S XMY("G.DMR")=""
        ..S XMDUZ="AR PACKAGE"
        ..S XMTEXT="MSG("
        ..S MSG(1)="The following bill has a 0 principal balance,"
        ..S MSG(2)="but has interest/admin charges remaining."
        ..S MSG(3)="These charges should be exempted"
        ..S MSG(4)=" "
        ..S MSG(5)="BILL #:  "_$P(B0,U)
        ..D ^XMD
        ..Q
        .Q:$P(B4,U)
        .S LTRDT3=$P(B6,U,3) Q:'LTRDT3  Q:LTRDT3>P30DT
        .;CHECK FOR DC REFERRAL HERE
        .I $P(B6,U,4),($P(B6,U,5)="DC")!($P(B6,U,5)="RC") Q
        .;Q:$$INSURED^IBCNS1(DFN,$P(B0,U,10))  ;Commented out w/patch *121
        .S X=$P(B0,U,2),X=$S(X=22:1,X=23:1,(X>2)&(X<6):2,X=18:2,X=24:2,X=25:2,X=1:3,X=2:4,(X>26)&(X<30):5,X>29:6,1:"")
        .Q:X=""  K CATYP(X)
        .;Check if bill should be deferred from being sent to DMC if Veteran is
        .;SC 50% to 100% or Receiving VA Pension (Hold Debt to DMC project, sbw)
        .Q:+$$HOLDCHK^RCDMCUT1(BILL,DFN)>0
        .I $P(B6,U,21),$P(B6,U,21)<ESTDT S ESTDT=$P($P(B6,U,21),".")
        .I $P(B12,U,2),PRIN>$P(B12,U,2) S PRIN=$P(B12,U,2)
        .S ^TMP($J,"RCDMC90","BILL",BILL)=$S($P(B12,U):$P(B12,U),1:DT)_U_PRIN_U_INT_U_ADMIN
        .S TPRIN=TPRIN+PRIN,TINT=TINT+INT,TADMIN=TADMIN+ADMIN
        .Q
TOTAL   S TOTAL=TPRIN+TINT+TADMIN
        I RCDOC="M" Q:TPRIN'>0                                  ;PRCA*4.5*229
        I RCDOC="M",'+$$SWSTAT^IBBAPI() Q:TOTAL<25              ;PRCA*4.5*229
        ;
        I RCDOC="M",$P(VADM(2),U)["P" S PSSN=$P(VADM(2),U) D PSEUDO^RCDMC90U(DFN,PSSN) Q
        I RCDOC="W" Q:(TOTAL_U_TPRIN_U_TINT_U_TADMIN)=$P(^RCD(340,DEBTOR,3),U,5,8)
        S DFN=+DEBTOR0
        ;SETS CATEGORY CODE 1=MEANS TEST,2=PHARMACY,3=INEL.,4=EMER./HUM.
        ;5=CHAMPVA,6=TRICARE OR ANY COMBINATION THEREOF
        S CATYP="" F X=1:1:6 S:'$D(CATYP(X)) CATYP=CATYP_X
        S CATYP=$$LJ^XLFSTR(CATYP,6)
        ;
        ;Send Master/Weekly error msg if Unknown or Invalid address
        ;If Master update, quit and don't refer to DMC
        ;If Weekly update, send a zero balance
        S LKUP=$$CHKADD(DEBTOR)
        I LKUP D ERROR^RCDMC90U(RCDOC,LKUP,DFN)  Q:RCDOC="M"  S (TOTAL,TPRIN,TINT,TADMIN)=0
        ;
        S ZIPCODE=$TR($P(ADDR,U,6),"-")
        ;
        ;Retrieve and format patient phone number
        S ADDRPHO=$P(ADDR,U,7),PHONE=""
        F I=1:1:$L(ADDRPHO) S CHKPHONE=$E(ADDRPHO,I) I CHKPHONE?1N S PHONE=PHONE_CHKPHONE
        S PHONE=$S(PHONE?10N:PHONE,PHONE?7N:"   "_PHONE,1:"          ")
        ;
        I RCDOC="W",TOTAL=0 D
        .K ^RCD(340,"DMC",1,DEBTOR),^RCD(340,DEBTOR,3)
        .N NM,XMSUB,XMY,XMTEXT,MSG
        .S XMSUB="Deletion of Debtor from DMC"
        .S XMY("G.DMX")=""
        .S XMDUZ="AR PACKAGE"
        .S XMTEXT="MSG("
        .S MSG(1)="The following patient has a DMC balance of '0'"
        .S MSG(2)="and will be deleted from the DMC system:"
        .S MSG(3)=" "
        .S MSG(4)=$P(^DPT(DFN,0),U)_"   SSN:  "_$P(^(0),U,9)
        .D ^XMD
        .Q
        S QUIT=0
PROCQ   Q
DATE8(X)        ;CHANGES FILEMAN DATE INTO 8 DIGIT DATE IN FORMAT MMDDYYYY
        S X=$E(X,4,7)_($E(X,1,3)+1700)
        Q X
AMT(X)  ;CHANGES AMOUNT TO ZERO FILLED, RIGHT JUSTIFIED
        S X=$TR($J(X,0,2),".")
        S X=$E("000000000",1,9-$L(X))_X
        Q X
NM(DFN) ;Returns first, middle, and last name in 3 different variables
        N FN,LN,MN,NM,XN
        S NM=$P($G(^DPT(DFN,0)),"^")
        S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
        I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S XN=MN,MN=""
        I $G(XN)="" S XN=$P($P($G(NM),",",2)," ",3)
        S FN=$P($P(NM,",",2)," ")
QNM     Q LN_"^"_XN_"^"_FN_"^"_MN
BAL(DEBTOR)     ;COMPUTES TOTAL OF ACTIVE BILLS THAT COULD BE SENT TO DMC
        N BILL,BAL
        S (BILL,BAL)=0
        F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
        .S B0=$G(^PRCA(430,BILL,0)),B7=$G(^(7))
        .Q:$P(B0,U,8)'=16
        .S X=$P(B0,U,2),X=$S((X>0)&(X<6):1,X=18:1,(X>21)&(X<26):1,(X>26)&(X<33):1,1:"")
        .Q:X=""
        .S BAL=BAL+$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
        .Q
BALQ    Q BAL
SETREC  ;SETS TEMPORARY GLOBAL FOR MAIL MESSAGE TO USERS
        S RCNT=RCNT+1 D PID^VADPT S:$L(VA("BID"))=4 VA("BID")=" "_VA("BID")
        S TLINE=($P(TLINE,U)+TPRIN)_U_($P(TLINE,U,2)+TINT)_U_($P(TLINE,U,3)+TADMIN)
        S ^XTMP("RCDMC90",$J,"REC",$P(^DPT(DFN,0),U)_";"_DFN)=$$LJ^XLFSTR($E($P(^DPT(DFN,0),U),1,28),29)_" "_VA("BID")_" "_$J(TPRIN,10,2)_$J(TINT,10,2)_$J(TADMIN,10,2)_$J(TOTAL,10,2)
        Q
        ;
CHKADD(DEBTOR)  ; Checks for invalid and unknown addresses
        N CHK S CHK=0,ADDR=""
        I $P($G(^RCD(340,+DEBTOR,1)),"^",9)=1 S CHK=1 G CHKADDQ
        S ADDR=$$DADD^RCAMADD(+DEBTOR,1) ;get address (confidential if possible)
        I ADDR'?.ANP!(ADDR["$")!(ADDR["**")!(ADDR["///")!(ADDR["ZZZ") S CHK=2
CHKADDQ Q CHK
        ;
