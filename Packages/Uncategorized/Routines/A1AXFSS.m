A1AXFSS ;SLL/ALB ISC; FACILITY STATISTICS (LAST REVIEW DATE); 1/20/88
 ;;VERSION 1.0
 ;
 I DUZ(2)>999 D ^A1AXFS Q
 S A1AXOPT="F"
DEVICE ;
 S %IS("B")="HOME",%IS="MQF" D ^%ZIS G:POP EXIT1 I '$D(IO("Q")) U IO G DQ
 S ZTRTN="DQ^A1AXFSS",ZTIO=ION S ZTSAVE("A1AX*")="" S ZTDESC="EXT REV FAC STAT REPORT" D ^%ZTLOAD W !,"PRINT QUEUED!" X ^%ZIS("C")
 K IO("Q"),ZTRTN,ZTIO,ZTDESC,ZTSAVE,%DT("A"),%DT("B"),A1AXL,AU,AA,AP,AS,AR,I,J,A1AXOPT,A1AXO,A1AXF,A1AXCT,A1AXDT,A1AX1,A1AX2,A1AXST,A1AXSTOP,A1AXEND,A1AXM,^UTILITY($J,"ST"),^UTILITY($J,"CCT")
 K ^UTILITY($J,"LAST"),POP,ZTSK
 K A1AXD
 Q
DQ ;
 D CLOSE^A1AXUTL
 G:A1AXOPT="O" INITO S A1AX1=""
 S A1AX1=$P(^DIZ(11837,DUZ(2),0),"^",1) S A1AXD=$P(^DIZ(11837,DUZ(2),0),"^",2),A1AX2="" F J=0:0 S A1AX2=$O(^DIZ(11831,"B",A1AX2)) Q:A1AX2=""  D SETF
 D LASTF
 D ^A1AXFSS1
 Q
SETF ;
 S ^UTILITY($J,"ST",A1AXD,A1AX1,A1AX2)="",^UTILITY($J,"CCT",A1AXD,A1AX1,A1AX2)=""
 S ^UTILITY($J,"LAST",A1AX1,A1AX2)=0
 Q
LASTF ;
 F AN=0:0 S AN=$N(^DIZ(11830,"F",AN)) Q:AN<0  F AA=0:0 S AA=$N(^DIZ(11830,"F",AN,AA)) Q:AA<0  D LASTL
 Q
LASTL ;
 Q:'$D(^DIZ(11830,AA,"D"))  Q:$P(^("D"),"^",1)=""
 S A1AXDT=^DIZ(11830,AA,0) Q:^("F")'=DUZ(2)  S A1AX1=$P(^DIZ(11837,^("F"),0),"^",1),A1AX2=$P(^DIZ(11831,^DIZ(11830,AA,"O"),0),"^",1) I A1AXDT>^UTILITY($J,"LAST",A1AX1,A1AX2) S ^UTILITY($J,"LAST",A1AX1,A1AX2)=A1AXDT
 Q
INITO S A1AX2="" F J=0:0 S A1AX2=$O(^DIZ(11831,"B",A1AX2)) Q:A1AX2=""  S A1AX1=$P(^DIZ(11837,DUZ(2),0),"^",1),A1AXD=$P(^DIZ(11837,$N(^DIZ(11837,"B",A1AX1,0)),0),"^",2) D SETO
 D LASTF
 D ^A1AXFSS1
 Q
SETO ;
 S ^UTILITY($J,"ST",A1AXD,A1AX2,A1AX1)="",^UTILITY($J,"CCT",A1AXD,A1AX2,A1AX1)=""
 S ^UTILITY($J,"LAST",A1AX1,A1AX2)=0
 Q
EXIT1 ;
 K %DT("A"),%DT,%DT("B"),IO("Q"),A1AXOPT
 Q
