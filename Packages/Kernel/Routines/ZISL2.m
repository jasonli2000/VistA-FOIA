ZISL2 ;WILM/RJ - MAIN DRIVER Statistics; 9-22-87
 ;;7.1;KERNEL;;May 11, 1993
V ;;Version 4.51
SE S U="^",S=";",O=$T(OPT) I $D(^DOPT($P(O,S,5),"VERSION")),($P($T(V),S,3)=^DOPT($P(O,S,5),"VERSION")) G IN
 K ^DOPT($P(O,S,5))
 F I=1:1 Q:$T(OPT+I)=""  S ^DOPT($P(O,S,5),I,0)=$P($T(OPT+I),S,3),^DOPT($P(O,S,5),"B",$P($P($T(OPT+I),S,3),"^",1),I)=""
 S K=I-1,^DOPT($P(O,S,5),0)=$P(O,S,4)_U_1_U_K_U_K K I,K,X S ^DOPT($P(O,S,5),"VERSION")=$P($T(V),S,3)
IN I $P(O,S,6)'="" D @($P(O,S,6))
PR S O=$T(OPT),S=";" S IOP="HOME" D ^%ZIS W:IOST'["PK-" @IOF K IOP
 I $P(O,S,7)'="" D @($P(O,S,7))
 E  W !!,$P(O,S,3),":",!,$P($T(V),S,3),!!,$P(O,S,4),"s:",!
 F J=1:1 Q:'$D(^DOPT($P(O,S,5),J,0))  S K=$S(J<10:15,1:14) W !,?K,J,". ",$P(^DOPT($P(O,S,5),J,0),U,1)
RE W ! S DIC("A")="Select "_$P($T(OPT),S,4)_": EXIT// ",DIC="^DOPT("_""""_$P($T(OPT),S,5)_""""_",",DIC(0)="AEQMN" D ^DIC G:X=""!(X=U) EXIT G:Y<0 RE K DIC,J,O D @($P($T(OPT+Y),S,4)) G PR
EXIT K DIC,S,J,O,K Q
OPT ;;Micom Package;Micom Statistics Option;ZISL2;
 ;;Capture Statistics Job Start;^ZISLSTAS
 ;;Print Cumulative Statistics;^ZISLSO
 ;;Print Daily Statistics;^ZISLPDS
 ;;Print Statistics;^ZISLSO1
 ;;Print Statistics for Selected Lines;^ZISLSO1S
 ;;Purge Statistics;^ZISLSP
