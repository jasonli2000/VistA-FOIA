A4ARIGQ ;HINES-CIOFO/JJM - CLASS III AR REPORTS 10/27/98 15:30
 ;;1.0;CLASS III REPORTS OCTOBER 15,1998
OPENDEV ;check for regular run or TaskMan
 N A4ADEV,POP,%ZIS,ZTRTN,ZTSAVE,A4AIOSV K IOP
 I $D(ZTSK) S A4ADEV=ION_";"_IOST_";"_IOM_";"_IOSL D ^A4ARIG0 K ZTSK Q
 ;
OPENQ ;check device for queueing or local
 S ZTRTN="^A4ARIG0",%ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP CLOSEDV S (IOP,A4ADEV)=ION_";"_IOST_";"_IOM_";"_IOSL,A4AIOSV=IO(0)
 I IO=IO(0) D @ZTRTN G CLOSEDV
 I $D(IO("Q")) D
   . S ZTDESC="CLASS III AR REPORTS"
  . D ^%ZTLOAD
 E  U IO D @ZTRTN
 W:$D(ZTSK) !,"TASK NUMBER ",ZTSK
 ;
CLOSEDV ;close device and exit routine
 W:IO'=IO(0) @IOF D ^%ZISC I '$D(ZTSK) S:$D(A4AIOSV) IO(0)=A4AIOSV U IO(0)
 K X,Y,ZTSK
