DVBHCG2 ; GENERATED FROM 'DVBHINQ PAT-HINQ COMP' PRINT TEMPLATE (#1018) ; 11/06/92 ; (continued)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 S X=$S($D(^DPT(D0,.362)):^(.362),1:"") D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) W:Y]"" $J(Y,9,2)
 W ?34 I $D(DVBOINC) W ?52,DVBOINC K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
