NURCVPR0 ;HIRMFO/YH,FT-VITALS/MEASUREMENTS RESULTS REPORTING  ;5/4/99  14:43
 ;;4.0;NURSING SERVICE;**5,21,23,24**;Apr 25, 1997;
EN1 ;ENTER FROM NURCPP-VIT-SF511 OPTION TO PRINT SF 511, B/P OR WEIGHT CHART
 ;CALL ^NURCVUT0 TO SELECT PATIENT BY WARD, ROOM OR SINGLE PATIENT, THEN CALL
 ;   ^NURCAS2 TO STORE PATIENT INFORMATION IN ^TMP($J,"NURCEN")
 ;CALL EN5^GMRVSR0 WITH FOLLOWING VALUES:
 ;     DFN = PATIENT NUMBER
 ;     GMRDATE = START DATE^FINISH DATE OF REPORT^TYPE OF GRAPH
 ;     GMRVWLO = NURSING LOCATION
 S (NGRAPH,NURQUIT)=0 D SELECT^NURCVPR1(.NGRAPH) G:NGRAPH'>0 Q2 D ^NURCVUT0 I NURQUIT!(NUREDB["S"&'$D(NRMBD)) G Q2
 D DATE I NURQUIT G Q2
 I NGRAPH=5 S X="GMRVKPN0" X ^%ZOSF("TEST") I $T S NUR5FLG=1
 I NGRAPH=5,'$D(NUR5FLG) W !!,"PAIN CHART must be queued to a HP Laser printer",! G DEV
 W !!,"This report must be queued to a line printer",!,"or a slave printer with 132 columns",!,"or a Kyocera/HP Laser printer",!
DEV S %ZIS="NQ",%ZIS("B")="" W ! D ^%ZIS G:POP Q2
 N NURDEV S NURDEV=ION_";"_IOST_";"_IOM_";"_IOSL
 I IOM'>131 W !!,"Sorry, you must select a DEVICE that can print 132 columns. Try again." G DEV ;device must be 132 columns
 ;I '(IOST?1"P".E&$D(IO("Q"))),'$D(IO("S")) D WRT1^NURCVPR1 G DEV
 I NGRAPH=5,'$D(NUR5FLG),$$UP^XLFSTR(IOST)'["HPLASER" W !,"PAIN CHART uses HP Laser printer only." G DEV
 I '$D(IO("Q")) S IOP=NURDEV K %ZIS D ^%ZIS G Q2:POP,START
 I $D(IO("Q")) W ! S ZTDESC="V/M GRAPHIC REPORTS",ZTIO=ION,ZTRTN="START^NURCVPR0" F G="NUREDB","NURSTRT","NURFIN","NPWARD","NURWARD","NURQUIT","NRMBD(","DFN","NGRAPH","GSTRFIN" S ZTSAVE(G)=""
 I $D(IO("Q")) D ^%ZTLOAD,HOME^%ZIS D Q2 Q
START ; ENTRY TO PRINT THIS REPORT AFTER IT HAS BEEN QUEUED
 ;  NOTE:  THIS REPORT MUST BE QUEUED TO A PRINTER.
 I NGRAPH=5,'$D(IO("Q")),$$UP^XLFSTR(IOST)'["HPLASER" S NURPERR=0 D  Q:NURPERR
 .S X="GMRVKPN0" X ^%ZOSF("TEST")
 .I $T,$$UP^XLFSTR(IOST)'["KYOCERA" W !,"Sorry, you must select a Kyocera or HP Laser printer for the Pain Chart." S NURPERR=1 Q
 .I '$T,$$UP^XLFSTR(IOST)'["KYOCERA" W !,"Sorry, you must select a HP Laser printer." S NURPERR=1 Q
 .Q
 K ^TMP($J,"NURCEN") S GFLAG=0 D ^NURCAS2 I '$D(^TMP($J,"NURCEN")) W !,"NO DATA FOR THIS REPORT" G Q1
 I NUREDB="P" S NPWARD=$S($D(^NURSF(214,DFN,0)):$P(^(0),"^",3),1:"") I NPWARD'="" D EN6^NURSAUTL
 S:NPWARD'="" GMRVWLO=NPWARD
 S GMRDATE=NURSTRT_"^"_NURFIN_"^"_NGRAPH,NURRM=""
 F  S NURRM=$O(^TMP($J,"NURCEN",NURRM)) Q:NURRM=""!NURQUIT  S NBED="" F  S NBED=$O(^TMP($J,"NURCEN",NURRM,NBED)) Q:NBED=""!NURQUIT  S NURNAM="" F  S NURNAM=$O(^TMP($J,"NURCEN",NURRM,NBED,NURNAM)) Q:NURNAM=""!NURQUIT  D REPT
 G Q1
REPT ;
 Q:'$D(^TMP($J,"NURCEN",NURRM,NBED,NURNAM))  S DFN=+$P(^(NURNAM),"^") D:DFN>0 EN5^GMRVSR0
 Q
DATE S %DT("A")="Start DATE (TIME optional): ",%DT("B")="T-7",%DT="AETX" D ^%DT K %DT I +Y'>0 S NURQUIT=1 Q
 S NURSTRT=+Y
 S %DT("A")="Go to DATE (TIME optional): ",%DT="AETX",%DT("B")="NOW" D ^%DT K %DT I +Y'>0 S NURQUIT=1 Q
 I $P(Y,".",2)'>0,Y=DT D NOW^%DTC S Y=%
 I $P(Y,".",2)'>0 S Y=Y_$S(Y[".":"2400",1:".2400")
 S (X1,NURFIN)=+Y,X2=NURSTRT D ^%DTC
 I X<0!(X=0&(((+("."_$P(NURFIN,".",2))*10000)-((+("."_$P(NURSTRT,".",2))*10000)))'>0)) W !?5,"Ending date of range needs to be greater that starting date.",!?5,$C(7),"PLEASE REENTER!!" G DATE
 S Y=NURSTRT X ^DD("DD") S GSTRFIN=Y S Y=NURFIN X ^DD("DD") S GSTRFIN=GSTRFIN_" - "_Y
 Q
Q1 D Q2^GMRVSR0
Q2 K NURLOCSW,NGRAPH,NURP,ZTSK,ZTDESC,X1,X2 D ^%ZISC
 K ^TMP($J),DFN,GMRDATE,NAME,NBED,NI,NN,NROOM,NURRM,NRMBD,NURNAM,GMRDT,NIEF,NWRD,NURFIN,NURSTRT,NUR5FLG,NUREDB,NPWARD,NURWARD,X,Y,GMROUT,NURQUIT,NORM,NUREDB,GMRVWLO,G,ND1,NDA,NURQUEUE,NURI,NURLEN,NURRMST,NURPERR
 K NURSX,NURSY,NURX,NWLOC,%W,%T,%Y1,VAROOT
 K NURMDSW,GSTRFIN Q
EN2 ;VITAL SIGNS DISPLAY BY INDIVIDUAL PATIENT
 ;ENTRY POINT FOR OPTION NURCPP-VIT-DISP
 D EN2^GMRVDS0
 Q
EN3 ;REPORT OF VITALS ENTERED IN ERROR FOR A PATIENT
 ;ENTRY POINT FOR OPTION NURCPP-VIT-ERROR
 D EN1^GMRVER0
 Q
EN4 ;CUMULATIVE VITALS REPORT BY WARD/ROOM/PATIENT
 ;ENTRY POINT FOR OPTION NURCPP-VIT-CUM
 S NURQUIT=0 D ^NURCVUT0 G:NURQUIT!(NUREDB["S"&'$D(NRMBD)) Q4
 K ^TMP($J,"NURCEN") D ^NURCAS2 I '$D(^TMP($J,"NURCEN")) W !,"NO PATIENT FOR THIS REPORT" G Q4
 S GMRX="",GMROUT=0 I "Pp"[NUREDB D INP^VADPT S:VAIN(7)'="" GMRX=$P($P(VAIN(7),"^",2),"@")
 D DATE^GMRVSC0 G:GMROUT Q4 S ZTRTN="START4^NURCVPR0" F G="GMRVSDT","GMRVFDT","DFN","^TMP($J,","NUREDB","GMROUT" S ZTSAVE(G)=""
 D EN7^NURSUT0 I POP!($D(ZTSK)) G Q4
START4 S GMRPG=0 U IO
 S NURRM=""
 F  S NURRM=$O(^TMP($J,"NURCEN",NURRM)) Q:NURRM=""!($G(GMROUT))  S NBED="" F  S NBED=$O(^TMP($J,"NURCEN",NURRM,NBED)) Q:NBED=""!($G(GMROUT))  S NURNAM="" F  S NURNAM=$O(^TMP($J,"NURCEN",NURRM,NBED,NURNAM)) Q:NURNAM=""!($G(GMROUT))  D REPORT
Q4 D Q2,KVAR^VADPT K GFLAG,GMROUT,GMRPG,GMRVSDT,GMRVFDT,GMRX,VA Q
REPORT S DFN=+$P(^TMP($J,"NURCEN",NURRM,NBED,NURNAM),"^") D:DFN>0 EN5^GMRVSC0
 Q
EN5 ;DISPLAY VITAL SIGNS BY LOCATION
 ;ENTRY POINT FOR NURCPP-VIT-WARD
 ; LOOKUP FILE 211.4 TO GET NURSING LOCATION
 ;OUTPUT VARIABLES: ^TMP($J,ROOM-BED,PATIENT NAME,DFN)=""
 ;                  DFN = POINTER TO FILE 2
 ;                  GMRVWLO = NURSING LOCATION
 ;EN3^GMRVSL0 IS CALLED TO PRINT VITALS FOR THE PATIENTS IN ^TMP($J)
 S (NURLOCSW,NURQUIT)=0,NUREDB="U" D WARDSEL^NURCUT0 I NURQUIT G Q2
 I '$D(^NURSF(211.4,+$G(NURWARD),3,0))!($O(^(0))'>0) W !,"****  NO DATA FOR UNIT : ",NPWARD G Q2
 S ZTRTN="START2^NURCVPR0",ZTDESC="Unit Vital/Measurements Report" F G="NURQUIT","NURWARD","NPWARD" S ZTSAVE(G)=""
 D EN7^NURSUT0 G:POP!($D(ZTSK)) Q2
START2 ;
 F DFN=0:0 S DFN=$O(^NURSF(214,"AF","A",NURWARD,DFN)) Q:DFN'>0  D 1^VADPT S ^TMP($J,$S(VAIN(5)'="":VAIN(5),1:"  BLANK"),$S(VADM(1)'="":VADM(1),1:"  BLANK"),DFN)=""
 S GMRVWLO=NPWARD,GMRVHLOC=$P($G(^DIC(42,+$G(VAIN(4)),44)),"^") D EN3^GMRVDS1
 G Q2
