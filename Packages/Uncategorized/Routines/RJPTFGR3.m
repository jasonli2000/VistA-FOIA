RJPTFGR3 ;RJ WILM DE; GRAPH PHYSICIAN VERSUS AVG LOS; 12-10-86
 ;;4.0
 D NOW^%DTC S Y=% X ^DD("DD") S H3=H3/10+1\1*10,X=H3\10
 D H S I=0 F PTF=0:0 S I=$O(^UTILITY($J,"RJPTF",I)) Q:I=""  D W
 W !?20 F I=1:1:10 W "|" F J=1:1:9 W "-"
 W "|",! F I=0:1:9 W ?(I+2*10),I*X
 W !!?20,"% AVG LOS  =  AVG LOS BY PHYSICIAN / TOTAL AVG LOS * 100",!
 K X,Y,Z,H3,I,J,D Q
W S D=^UTILITY($J,"RJPTF",I,"TOTAL") S:I="ZZZZNOPHY" I="NO PHYSICIAN" W !,$E(I,1,15),?19,"-|" S Y=$P(D,"^",3)\X*10,Z=$P(D,"^",3)#X/X*10+Y F J=1:1:Z W "*"
 S Z=Z+21\1 F J=Z:1:111 I $E(J,$L(J))=0 W ?J,"|"
 W ?120,"|",?123,$J($P(D,"^",3),6,2) S:I="NO PHYSICIAN" I="ZZZZZ"
 Q
H U IO W @IOF,!?40,"P H Y S I C I A N   V E R S U S   A V G  L O S",!! F I=0:1:9 W ?(I+2*10),I*X
 W !?20 F I=1:1:10 W "|" F J=1:1:9 W "-"
 W "|",!,"PHYSICIAN:",?20,"|"
 Q
