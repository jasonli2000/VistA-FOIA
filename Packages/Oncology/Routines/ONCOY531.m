ONCOY531 ; GENERATED FROM 'ONCOY53' PRINT TEMPLATE (#1293) ; 11/03/10 ; (continued)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 M Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 Stage Group....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,19) S Y(0)=Y D SGOT^ONCCSOT W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Derived SS1977................:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived SS2000................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
