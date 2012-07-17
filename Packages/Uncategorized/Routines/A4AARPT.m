A4AARPT ;HINES-CIOFO/JJM - PROGRAM TO AUDIT PATIENT ACCOUNT  6/23/99 12:15
 ;;1.0;**** CLASS III ****;;JUN 30, 1998
START K TEMP,^TEMP($J)
 D DEBTOR I Y=-1 D EXIT Q
 D KA4AV^A4AARPT8
 ; N A4ADEB,A4APAT,A4ASSN,A4AU1N4,A4ASDAY,A4ANAME
 ; N A4ATOA1,A4APSB2,A4ATNA3,A4ATOA,A4APSB,A4ATNA,A4AFRB
OPENDEV ;check for regular run or TaskMan
 N A4ADEV,POP,%ZIS,ZTRTN,ZTSAVE,A4AIOSV K IOP
 I $D(ZTSK) S A4ADEV=ION_";"_IOST_";"_IOM_";"_IOSL D AUDIT G START
 ;
OPENQ ;check device for queueing or local
 S ZTRTN="AUDIT^A4AARPT",%ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP CLOSEDV S (IOP,A4ADEV)=ION_";"_IOST_";"_IOM_";"_IOSL,A4AIOSV=IO(0)
 I IO=IO(0) D @ZTRTN G CLOSEDV
 I $D(IO("Q")) D
   . S (ZTSAVE("DEBTOR"),ZTSAVE("NAME"),ZTSAVE("FLAG1"))="" S:$D(A4ARDT) ZTSAVE("A4ARDT")="" S ZTDESC="AUDIT REPORT",ZTSAVE("A4ADEV")=""
  . S ZTSAVE("SSN")="",ZTSAVE("U1N4")="",ZTSAVE("PFLAG")="",ZTSAVE("DEBTOR")=""
  . S ZTSAVE("NAME")="",ZTSAVE("PAT")="",ZTSAVE("SDAY")=""
  . D ^%ZTLOAD
 E  U IO D @ZTRTN
 ;
CLOSEDV ;close device and exit routine
 W:IO'=IO(0) @IOF D ^%ZISC Q:$D(ZTSK)  S:$D(A4AIOSV) IO(0)=A4AIOSV U IO(0)
EXIT ;;
 K ^TEMP($J)
 K BS,DATE
 K %DT,AB,BAL,BILL,BTYPE,CA,CB,CC,CI,CS,DATE1,DATE2,DATE3,DEBTOR,DIC,DIYS,EP,FLAG1,IB,IO("CLOSE"),IOHG,IOP,IOPAR,IOUPAR,ITF,LINE,MF,NAF,NAME,NATOTAL,PA,PAT,PB,PC,PG,PI,PSB,RBAL,SBAL,SC,START,TAMT,TAO,TDATE,TEMP,TIME1,TIME2,TRANS,TYPE,X,Y
 K DIR,C,PRCA4307,RBILL,RFLAG,SDAY,SSN,STATUS,U1N4,XBILL,XDATE,ZTDESC,ZTSK,T1,T2,T3,T4,T5,T6,T7,T8,DIC,PFLAG,LST1,LST2,LST3,LST4,LST5
 K PRCA433X,LST6,SRBAL,SDT,SFLAG
 K CAT,ERRCNT,F430N0,F433N0,F433N1,F433N8,RCNT
 S DIR("A")="DO YOU WISH TO EXIT" S DIR(0)="Y",DIR("B")="NO" D ^DIR
 G:(X'["Y")&(X'["y") START
 K X,Y,DIR
 QUIT
 ;
EOR ; END OF REPORT
 K ^TEMP($J),^XTMP("A4AARPT",$J)
 K BS,DATE,END,BN,DMC,DMCAMT,DMCBD
 K %DT,AB,BAL,BILL,BTYPE,CA,CB,CC,CI,CS,DATE1,DATE2,DATE3,DEBTOR,DIC,DIYS,EP,FLAG1,IB,IO("CLOSE"),IOHG,IOP,IOPAR,IOUPAR,ITF,LINE,MF,NAF,NAME,NATOTAL,PA,PAT,PB,PC,PG,PI,PSB,RBAL,SBAL,SC,START,TAMT,TAO,TDATE,TEMP,TIME1,TIME2,TRANS,TYPE,X,Y
 K DIR,C,PRCA4307,RBILL,RFLAG,SDAY,SSN,STATUS,U1N4,XBILL,XDATE,ZTDESC,ZTSK,T1,T2,T3,T4,T5,T6,T7,T8,DIC,PFLAG,LST1,LST2,LST3,LST4,LST5
 K PRCA433X,LST6,SRBAL,SDT,SFLAG
 K CAT,ERRCNT,F430N0,F430N6,F433N0,F433N1,F433N8,RCNT
 K DEBTOR
 K BN,DAT,DD,DEBTOR,DIC,J
 K NAME,PAT,PFLAG,SDAY,SSN,X,Y
 K A4ADEB,A4AFRB,A4ANAME,A4ANAT,A4APAT,A4APSB,A4ASDAY,A4ASSN,A4ATL1,A4ATL10
 K A4ATL2,A4ATL3,A4ATL4,A4ATL5,A4ATL6,A4ATL7,A4ATL8,A4ATL9,A4ATNA,A4ATNA3
 K A4ATOA,A4ATOA1,A4AU1N4,A4APSB2,A4ABN
 K BFLAG,DAT,DFLAG
 K LSTB1,LSTB2,LSTB3,LSTB4,LSTB5,LSTB6,LSTBT,OV1,OV2,XDATE,XDATE1,XTRANS1
 QUIT
A4AARPT5 ; CHECK PATIENT FOR DISCREPANCY
 S A4ADEB="",A4APAT=""
 F  D DEBTOR Q:A4ADEB=-1  D
    . D:A4ADEB[";DPT"
    . S Y=$$EN^A4AARPT5(DEBTOR)
    . W !!,"ACCOUNT IS ",$S(Y=1:"OUT OF BALANCE",1:"IN BALANCE"),!!
ENDRPT5 ;
 K DEBTOR,A4APAT
 K BN,DAT,DD,DEBTOR,DIC,J,A4ADEB,A4AFRB,A4ANAME,A4ANAT,A4APAT,A4APSB2,A4APSB
 K A4ASDAY,A4ASSN,A4ATNA,A4ATNA3,A4ATNA,A4ATOA1,A4ATOA,A4AU1N4
 K A4AYOA5,NAME,PAT,PFLAG,SDAY,SSN,X,Y
 QUIT
 ;
 ;
DEBTOR ;
 S PFLAG=0,SSN="",U1N4=""
 S DIC="^RCD(340,",DIC(0)="AEMNQZ" D ^DIC
 S A4ADEB=Y
 Q:Y=-1
 S DEBTOR=+Y,NAME=Y(0,0)
 S U="^"
 S PAT=+$P(Y,U,2)
 S A4APAT=PAT
 S:$P(Y(0),";",2)["DPT" PFLAG=1
 S:PFLAG=1 SSN=$P($G(^DPT(PAT,0)),U,9)
 S:PFLAG=1 U1N4=$E(NAME,1,1)_$E(SSN,6,9)
 S SDAY=$P(^RCD(340,DEBTOR,0),U,3)
 K C,DIC,DIYS,PFLAG,X
 QUIT
BILL ;
 S BS=" "
 S DIC="^PRCA(430,",DIC(0)="AEMNQZ" D ^DIC
 S A4ABN=Y
 Q:Y=-1
 S BILL=+Y
 N A4ADEV,POP,%ZIS,ZTRTN,ZTSAVE,A4AIOSV K IOP
 I $D(ZTSK) S A4ADEV=ION_";"_IOST_";"_IOM_";"_IOSL D PBILL1^A4AARPT1 G BILL
 ;
OPENB ;check device for queueing or local
 S ZTRTN="PBILL1^A4AARPT1",%ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP CLOSEDV S (IOP,A4ADEV)=ION_";"_IOST_";"_IOM_";"_IOSL,A4AIOSV=IO(0)
 I IO=IO(0) D @ZTRTN G CLOSEDV
 I $D(IO("Q")) D
   . S (ZTSAVE("BILL"),ZTSAVE("BS"))="" S ZTDESC="AUDIT BILL REPORT",ZTSAVE("A4ADEV")=""
  . D ^%ZTLOAD
 E  U IO D @ZTRTN
 S DIR("A")="DO YOU WISH TO EXIT" S DIR(0)="Y",DIR("B")="NO" D ^DIR
 G:(X'["Y")&(X'["y") BILL
 D EXIT
 QUIT
 ;
AUDIT ;;
 D PARTA
 D PARTB
 D PARTC
 D PARTD
 D:'END 
 . D ^A4AARPT3
 . Q:END
 . D PRTRPT3
 . Q:END
 . W !!,"TOTAL OF ACTIVE & OPEN BILLS: ",$J(TAO,10,2)
 . S A4ATOA=TAO
 W #
 D PCLDFCS^A4AARPT5
 D PCLDFAR^A4AARPT5
ENDRPT W #
 K %DT,AB,BAL,BILL,BTYPE,CA,CB,CC,CI,CS,DATE1,DATE2,DATE3,DEBTOR,DIC,DIYS,EP,FLAG1,IB,IO("CLOSE"),IOHG,IOP,IOPAR,IOUPAR,ITF,LINE,MF,NAF,NAME,NATOTAL,PA,PAT,PB,PC,PG,PI,PSB,RBAL,SBAL,SC,START,TAMT,TAO,TDATE,TEMP,TIME1,TIME2,TRANS,TYPE,X,Y
 K DIR,C,PRCA4307,RBILL,RFLAG,SDAY,SSN,STATUS,U1N4,XBILL,XDATE,PFLAG,PRCA4338
 K END,BN
 QUIT
START1 ;
 D DEBTOR I Y=-1 D EXIT Q
 W !
PARTA ; 1ST REPORT LISTING
 D INITA4A
 S END=0
 W "CHECKING THE C CROSS-REFERENCES FOR DEBTOR: ",DEBTOR
 D INIT^A4AADP1
 D LOOPBN^A4AADP1
 ; D LOOPDAT^A4AADP1
 D:ERRCNT>0 ERRLIST^A4AADP2
 W !,$J(RCNT,10)," RECORDS CHECKED"
 D CLEANUP^A4AADP1
 QUIT
PARTB ;
 D ^A4AARPT8
 QUIT
START2 ;
 D:'$G(DEBTOR) DEBTOR I Y=-1 D EXIT Q
 S BFLAG=1
 S FLAG1=0
 D PARTC
 D CLEANUP^A4AADP1
 QUIT
PARTC ;
 D PRTRPT1^A4AARPT1
 QUIT
PARTD ;
 D PRTRPT9^A4AARPT9
 QUIT
INITA4A ; INITIALIZE THE VARIABLES USED BETWEEN ROUTINES
 S A4ADEB=$G(DEBTOR),A4APAT=$G(PAT),A4ASSN=$G(SSN),A4AU1N4=$G(U1N4),A4ASDAY=$G(SDAY),A4ANAME=$G(NAME)
 S (A4ATOA1,A4APSB2,A4ATNA3,A4ATL4,A4ATOA,A4APSB,A4ATNA,A4ATL8,A4AFRB)=0
 S SDT=""
 QUIT
SETUP ;
 Q:'DEBTOR
 S END=0
 S PG=0,(DATE1,DATE2,DATE3,TIME1,TIME2)=""
 S NAME=$G(NAME)
 S LINE="",$P(LINE,"=",IOM)="",PAT=$P($P($P($G(^RCD(340,DEBTOR,0)),"^"),";"),")")
 S:$D(FLAG1)=0 FLAG1=0
 S SSN="",U1N4="",PFLAG=""
 S:PAT>0 PFLAG=1
 S:PFLAG=1 SSN=$P($G(^DPT(PAT,0)),U,9)
 S:PFLAG=1 U1N4=$E(NAME,1,1)_$E(SSN,6,9)
 S SDAY=$P($G(^RCD(340,DEBTOR,0)),U,3)
 QUIT
PRTRPT1 ;
 S FLAG1=1
 D PRTRPT1^A4AARPT1
 S FLAG1=0
 QUIT
PRTRPT3 ;
 S FLAG1=1
 D PRTRPT3^A4AARPT2
 S FLAG1=0
 QUIT
CALC4332 ;
 S (BAL,T1,T2,T3,T4,T5,T6,T7,T8)=0
 Q:$D(^PRCA(433,TRANS,2))=0
 S PRCA433X=^PRCA(433,TRANS,2)
 S T1=+$P(PRCA433X,U,1)
 S T2=+$P(PRCA433X,U,2)
 S T3=+$P(PRCA433X,U,3)
 S T4=+$P(PRCA433X,U,4)
 S T5=+$P(PRCA433X,U,5)
 S T6=+$P(PRCA433X,U,6)
 S T7=+$P(PRCA433X,U,7)
 S T8=+$P(PRCA433X,U,8)
 S BAL=T1+T2+T3+T4+T5+T6+T7+T8
 QUIT
CALC4333 ;
 S (BAL,T1,T2,T3,T4,T5)=0
 Q:$D(^PRCA(433,TRANS,3))=0
 S PRCA433X=^PRCA(433,TRANS,3)
 S T1=+$P(PRCA433X,U,1)
 S T2=+$P(PRCA433X,U,2)
 S T3=+$P(PRCA433X,U,3)
 S T4=+$P(PRCA433X,U,4)
 S T5=+$P(PRCA433X,U,5)
 S BAL=T1+T2+T3+T4+T5
 QUIT
CALC4338 ;
 S (BAL,T1,T2,T3,T4,T5)=0
 Q:$D(^PRCA(433,TRANS,8))=0
 S PRCA433X=^PRCA(433,TRANS,8)
 S T1=+$P(PRCA433X,U,1)
 S T2=+$P(PRCA433X,U,2)
 S T3=+$P(PRCA433X,U,3)
 S T4=+$P(PRCA433X,U,4)
 S T5=+$P(PRCA433X,U,5)
 S BAL=T1+T2+T3+T4+T5
 QUIT
CALCCBAL ;
 S BAL=0
 Q:$D(^PRCA(430,BILL,7))=0
 S PRCA4307=^PRCA(430,BILL,7)
 S PB=$P(PRCA4307,U,1)
 S:$P(^(0),U,2)=26 PB=-PB
 S IB=$P(PRCA4307,U,2)
 S AB=$P(PRCA4307,U,3)
 S MF=$P(PRCA4307,U,4)
 S CC=$P(PRCA4307,U,5)
 S BAL=PB+IB+AB+MF+CC
 QUIT
CALCPAY ;
 S BAL=0
 Q:$D(^PRCA(430,BILL,7))=0
 S PRCA4307=^PRCA(430,BILL,7)
 S PB=$P(PRCA4307,U,7)
 S IB=$P(PRCA4307,U,8)
 S AB=$P(PRCA4307,U,9)
 S MF=$P(PRCA4307,U,10)
 S CC=$P(PRCA4307,U,11)
 S BAL=PB+IB+AB+MF+CC
 QUIT
CALCOUT ;
 S BAL=0
 Q:$D(^PRCA(430,BILL,7))=0
 S PRCA4307=^PRCA(430,BILL,7)
 S PB=$P(PRCA4307,U,12)
 S IB=$P(PRCA4307,U,13)
 S AB=$P(PRCA4307,U,14)
 S MF=$P(PRCA4307,U,15)
 S CC=$P(PRCA4307,U,16)
 S BAL=PB+IB+AB+MF+CC
 QUIT
