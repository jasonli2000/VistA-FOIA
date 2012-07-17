A1AXRL2 ;SLL/ALB ISC; FACILITY RECOMMMENDATION LIST WITHIN DATE RANGE; 3/11/88
 ;;VERSION 1.0
 ;
 S $P(A1AXL,"=",IOM+1)=""
 S A1AXD="" F IJ=0:0 S A1AXD=$O(^UTILITY($J,"RL",A1AXD)) Q:A1AXD=""  D HD,PRINT G:$D(A1AXEND) EXIT
 G EXIT
HD ;
 S X="EXT REV RECOMMEND LIST " S:A1AXOPT="F" X=X_"BY FACILITY" S:A1AXOPT="O" X=X_"BY ORGANIZATION"
 W #,!!,?(IOM-$L(X)\2),X S %DT=+$H D %CDS^%H S Y=$P(%DAT1,"-",2)_" "_$P(%DAT1,"-",1)_",19"_$P(%DAT1,"-",3)
 W ?(IOM-$L(Y)),Y
 S X=$P(^DIZ(11833,1,0),"^",1)_" - DISTRICT "_A1AXD W !,?(IOM-$L(X)\2),X
 D DATES^A1AXUTL
 W:A1AXOPT="F" !,"VAMC",?27,"REVIEW" W:A1AXOPT="O" !,"REVIEW",?10,"VAMC"
 W ?37,"RECOM",?47,"REVIEW",?57,"PGM",?67,"SERVICE",?77,"PARAPHRASED"
 W:A1AXOPT="F" !,"FAC",?27,"ORG" W:A1AXOPT="O" !,"ORG",?10,"FAC"
 W ?37,"NUMBER",?47,"DATE",?57,"TYPE",?77,"RECOMMEND"
 W !,A1AXL
 Q
PRINT ;
 S A1AX1="" F I=0:0 Q:$D(A1AXEND)  S A1AX1=$O(^UTILITY($J,"RL",A1AXD,A1AX1)) W !,A1AXL Q:A1AX1=""  S A1AX2="" F J=0:0 Q:$D(A1AXEND)  S A1AX2=$O(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2)) Q:A1AX2=""  D CONT
 Q
CONT ;
 S AU=0 F K=0:0 Q:$D(A1AXEND)  S AU=$O(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2,AU)) Q:AU=""  S AC="" F IJ=0:0 S AC=$O(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2,AU,AC)) Q:AC=""  D PR Q:$D(A1AXEND)
 Q
PR ;
 D:$Y+3>IOSL WAIT Q:$D(A1AXEND)
 W !
 I A1AXOPT="O" G PRO
 I DUZ(2)>999 W A1AX1
 I DUZ(2)<1000 W:A1AX1=$P(^DIZ(11837,DUZ(2),0),"^",1) A1AX1
 W ?27,A1AX2 G WR
PRO ;
 W A1AX1
 I $D(^DIZ(11837,DUZ(2),0)) W:A1AX2=$P(^(0),"^",1) ?10,A1AX2
 I DUZ(2)>999 W ?10,A1AX2
WR ;
 S:A1AXOPT="F" A1AXO=A1AX2 S:A1AXOPT="O" A1AXO=A1AX1
 W ?37,$P(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2,AU,AC),"^",1),?47,$P(^(AC),"^",2)
 W ?57,$P(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2,AU,AC),"^",3)
 W ?67,$P(^UTILITY($J,"RL",A1AXD,A1AX1,A1AX2,AU,AC),"^",4) I $D(^(AC)) S X=$P(^(AC),"^",5) W ?77,$E(X,1,53) W:$L(X)>53 !,?77,$E(X,54,76)
 Q
WAIT ;
 I IOST["C-" R !,"PRESS '^' TO STOP ",A1AXSTOP:DTIME S:A1AXSTOP["^" A1AXEND=""
 D:'$D(A1AXEND) HD
 Q
EXIT ;
 D EXIT1,CLOSE1^A1AXUTL Q
EXIT1 K AU,AA,AP,AS,AR,II,A1AXF,A1AXO,A1AXL,A1AXUDT,A1AXLDT,%DT,%H,%Z,%Z9,%DAT,%DAT1,D,K,POP,X,Y("A"),%DT("B")
 K I,J,IJ,AC,A1AXOPT,A1AXDT,A1AXCT,A1AX1,A1AX2,A1AXST,A1AXSTOP,A1AXEND,A1AXM,A1AXD,^UTILITY($J,"RL")
 K A1AXP,A1AXPARA,A1AXS
 Q
