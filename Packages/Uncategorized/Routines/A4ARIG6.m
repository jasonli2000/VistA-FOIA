A4ARIG6 ;HINES CIOFO/JJM-IG REPORTS ; 11/10/98 18:10
V ;;4.5;Accounts Receivable;**41,77,117**;Mar. 20, 1995
PRPTS ; PRINT ALL REPORTS
 D:'$G(^XTMP("A4ARIG",$J,"BILL",0)) EN1^A4ARIG
 D NOW^%DTC
 D OPEN
 W @IOF
 D BSRPTS
 D CLOSE
 D EOR
 QUIT
BSRPTS ; PRINT BILL RSC REPORTS
 F ACCRUED=0:1:1 W @IOF D BSRPT2
 QUIT
BSRPT1 ;
BSRPT2 ;
 D BSRPT3
 QUIT
BSRPT3 ;
 W !!,?55,"BILL DATA RSC REPORT BY FUND"
 W !,?55,%,!,?55,"JOB NUMBER: ",$J
 W !,?55,$S(ACCRUED=0:"NON-ACCRUED ",1:"ACCRUED")," RSC REPORT - 1",!
 S (RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5)=0 S RSC=""
 F  S RSC=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC)) Q:RSC=""  D
    . S FUND=""
    . F  S FUND=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND)) Q:FUND=""  D
      .. S STAT=""
      .. F  S STAT=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,"STATUS",STAT)) Q:STAT=""  D
       ... S CATEGORY="" F  S CATEGORY=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,"STATUS",STAT,"CATEGORY",CATEGORY)) Q:CATEGORY=""  D
           .... W !,RSC," FUND: ",FUND," STATUS: ",STAT,"  "," CATEGORY: ",CATEGORY
           .... W ?45,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,"STATUS",STAT,"CATEGORY",CATEGORY,0),12,2),$J(^(1),12,2),$J(^(2),12,2),$J(^(3),12,2),$J(^(4),12,2),$J(^(5),12,2)
    ... W !,?45,"  ----------","  ----------","  ----------","  ----------","  ----------","  ----------"
      ... W !,RSC," FUND: ",FUND," STATUS: ",STAT," TOTALS",":",?45,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,"STATUS",STAT,0),12,2),$J(^(1),12,2),$J(^(2),12,2),$J(^(3),12,2),$J(^(4),12,2),$J(^(5),12,2),!
    .. W !,?45,"  ==========","  ==========","  ==========","  ==========","  ==========","  =========="
      .. W !,RSC," FUND: ",FUND," TOTALS",":",?45,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,0),12,2),$J(^(1),12,2),$J(^(2),12,2),$J(^(3),12,2),$J(^(4),12,2),$J(^(5),12,2),!
      .. S RTOTAL=RTOTAL+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,0)
      .. S RTOTAL1=RTOTAL1+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,1)
      .. S RTOTAL2=RTOTAL2+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,2)
      .. S RTOTAL3=RTOTAL3+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,3)
      .. S RTOTAL4=RTOTAL4+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,4)
      .. S RTOTAL5=RTOTAL5+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,"FUND",FUND,5)
    . W !,?45,"  __________","  __________","  __________","  __________","  __________","  __________"
    . W !,?45,"  ==========","  ==========","  ==========","  ==========","  ==========","  =========="
      .  W !,RSC," TOTALS:",?45,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,0),12,2),$J(^(1),12,2),$J(^(2),12,2),$J(^(3),12,2),$J(^(4),12,2),$J(^(5),12,2),!
    . ; W !,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"RSC",RSC,0),12,2),$J(^(1),12,2),$J(^(2),12,2),$J(^(3),12,2),$J(^(4),12,2),$J(^(5),12,2)
 ; W !,"GRAND TOTALS :",!,?45,$J(RTOTAL,12,2),$J(RTOTAL1,12,2),$J(RTOTAL2,12,2),$J(RTOTAL3,12,2),$J(RTOTAL4,12,2),$J(RTOTAL5,12,2)
 QUIT
BSRPT4 ;
BSRPT5 ;
BSRPT6 ;
OPEN ; SELECT OUTPUT DEVICE
 S %ZIS="M" D ^%ZIS U IO
 QUIT
CLOSE ; CLOSE OUTPUT DEVICE
 D ^%ZISC
 QUIT
EOR ; END OF ROUTINE
 K FUND,STAT,CATEGORY,RTOTAL,RSC,TT,SITE
 K ACCRUED,AMT,AMT1,AMT2,AMT3,AMT4,AMT5,FUND,STAT,CATEGORY,RSC
 K RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5
 K TAMT,TAMT1,TAMT2,TAMT3,TAMT4,TAMT5
