MCAROAT1 ; GENERATED FROM 'MCAREP2' PRINT TEMPLATE (#2109) ; 07/22/97 ; (continued)
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
 D N:$X>19 Q:'DN  W ?19 S DIP(1)=$S($D(^MCAR(691.9,D0,2)):^(2),1:"") S X="RATE: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>19 Q:'DN  W ?19 W "MORPHOLOGY: "
 S X=$G(^MCAR(691.9,D0,2)) S Y=$P(X,U,6) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 S I(1)=3,J(1)=691.921 F D1=0:0 Q:$O(^MCAR(691.9,D0,3,D1))'>0  X:$D(DSC(691.921)) DSC(691.921) S D1=$O(^(D1)) Q:D1'>0  D:$X>33 T Q:'DN  D B1
 G B1R
B1 ;
 D T Q:'DN  D N D N:$X>7 Q:'DN  W ?7 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 W "CONDUCTION: "
 S X=$G(^MCAR(691.9,D0,3,D1,0)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>44 Q:'DN  W ?44 W "ARRHYTHMIA: "
 S I(2)=1,J(2)=691.9212 F D2=0:0 Q:$O(^MCAR(691.9,D0,3,D1,1,D2))'>0  X:$D(DSC(691.9212)) DSC(691.9212) S D2=$O(^(D2)) Q:D2'>0  D:$X>58 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^MCAR(691.9,D0,3,D1,1,D2,0)) D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 Q
A2R ;
 D N:$X>9 Q:'DN  W ?9 W "SHORTEST R-R A FIB:"
 S X=$G(^MCAR(691.9,D0,3,D1,2)) S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>44 Q:'DN  W ?44 W "SHORTEST R-R POST ISPUREL:"
 S Y=$P(X,U,2) W:Y]"" $J(Y,4,0)
 D N:$X>9 Q:'DN  W ?9 W "LOCATION OF TRACT: "
 W ?30 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.9,D0,3,D1,2)):^(2),1:"") S X="V-A TIME: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 W "ANTEGRADE ERP"
 D N:$X>44 Q:'DN  W ?44 W "RETROGRADE ERP"
 D N:$X>11 Q:'DN  W ?11 S DIP(1)=$S($D(^MCAR(691.9,D0,3,D1,2)):^(2),1:"") S X="BYPASS TRACT: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>46 Q:'DN  W ?46 S DIP(1)=$S($D(^MCAR(691.9,D0,3,D1,2)):^(2),1:"") S X="BYPASS TRACT: "_$P(DIP(1),U,7) K DIP K:DN Y W X
 D N:$X>11 Q:'DN  W ?11 S DIP(1)=$S($D(^MCAR(691.9,D0,3,D1,2)):^(2),1:"") S X="BYPASS ISUPREL: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>46 Q:'DN  W ?46 S DIP(1)=$S($D(^MCAR(691.9,D0,3,D1,2)):^(2),1:"") S X="BYPASS ISUPREL: "_$P(DIP(1),U,8) K DIP K:DN Y W X
 Q
B1R ;
 S I(1)=7,J(1)=691.93 F D1=0:0 Q:$O(^MCAR(691.9,D0,7,D1))'>0  X:$D(DSC(691.93)) DSC(691.93) S D1=$O(^(D1)) Q:D1'>0  D:$X>57 T Q:'DN  D C1
 G C1R
C1 ;
 D T Q:'DN  D N D N:$X>27 Q:'DN  W ?27 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 X DXS(6,9.2) S X=X_Y K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.9,D0,7,D1,0)):^(0),1:"") S X="ATRIAL CYCLE LENGTH (MSEC): "_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.9,D0,7,D1,0)):^(0),1:"") S X="VENT CYCLE LENGTH (MSEC): "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.9,D0,7,D1,0)):^(0),1:"") S X="QRS DURATION: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.9,D0,7,D1,0)):^(0),1:"") S X="QRS AXIS: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.9,D0,7,D1,0)):^(0),1:"") S X="QT: "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X $P(^DD(691.93,8,0),U,5,99) S DIP(2)=X S X="QTC: ",DIP(1)=X S X=DIP(2),DIP(3)=X S X=3,DIP(4)=X S X=0,X=$J(DIP(3),DIP(4),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 W "RYHTHM: "
 S DICMX="D L^DIWP" S DIWL=20,DIWR=78 X DXS(7,9.4) S X=$S('$D(^MCAR(693.3,+$P(DIP(103),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D1=I(1,0) S D2=I(2,0) K DIP K:DN Y
 D A^DIWW
 D N:$X>9 Q:'DN  W ?9 W "INTERPRETATION: "
 S X=$G(^MCAR(691.9,D0,7,D1,0)) D N:$X>27 Q:'DN  S DIWL=28,DIWR=77 S Y=$P(X,U,10) S X=Y D ^DIWP
 D A^DIWW
 Q
C1R ;
 D T Q:'DN  D N D N:$X>7 Q:'DN  W ?7 W "COMMENTS: "
 S I(1)=5,J(1)=691.923 F D1=0:0 Q:$O(^MCAR(691.9,D0,5,D1))'>0  S D1=$O(^(D1)) D:$X>19 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.9,D0,5,D1,0)) S DIWL=20,DIWR=79 D ^DIWP
 Q
D1R ;
 D 0^DIWW K DIP K:DN Y
 G ^MCAROAT2
