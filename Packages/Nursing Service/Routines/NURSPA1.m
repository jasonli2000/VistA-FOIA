NURSPA1 ; GENERATED FROM 'NURS-P-STF' PRINT TEMPLATE (#574) ; 09/19/10 ; (continued)
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
 D T Q:'DN  D N D N:$X>17 Q:'DN  W ?17 W "DEGREE: "
 S X=$G(^NURSF(210,D0,6,D1,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^NURSF(212.1,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>18 Q:'DN  W ?18 W "MAJOR: "
 D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^NURSF(212.3,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,50)
 D N:$X>5 Q:'DN  W ?5 W "COLLEGE/UNIVERSITY: "
 D N:$X>25 Q:'DN  W ?25,$E($P(X,U,3),1,50)
 D N:$X>9 Q:'DN  W ?9 W "YEAR COMPLETED: "
 D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,4) D DT
 Q
F1R ;
 D N:$X>16 Q:'DN  W ?16 W "FACULTY: "
 S X=$G(^NURSF(210,D0,15)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 S I(1)=1,J(1)=210.08 F D1=0:0 Q:$O(^NURSF(210,D0,1,D1))'>0  X:$D(DSC(210.08)) DSC(210.08) S D1=$O(^(D1)) Q:D1'>0  D:$X>30 T Q:'DN  D G1
 G G1R
G1 ;
 D N:$X>4 Q:'DN  W ?4 W "TYPE OF APPOINTMENT: "
 S X=$G(^NURSF(210,D0,1,D1,0)) D N:$X>25 Q:'DN  W ?25,$E($P(X,U,1),1,45)
 D N:$X>12 Q:'DN  W ?12 W "INSTITUTION: "
 D N:$X>25 Q:'DN  W ?25,$E($P(X,U,2),1,45)
 Q
G1R ;
 D T Q:'DN  W ?2 W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "NATIONAL CERTIFICATION"
 D N:$X>27 Q:'DN  W ?27 W "----------------------"
 S I(1)=12,J(1)=210.024 F D1=0:0 Q:$O(^NURSF(210,D0,12,D1))'>0  X:$D(DSC(210.024)) DSC(210.024) S D1=$O(^(D1)) Q:D1'>0  D:$X>51 T Q:'DN  D H1
 G H1R
H1 ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "NAME OF CERTIFICATION: "
 D N:$X>23 Q:'DN  W ?23 X ^DD(210.024,.05,9.3) S X=$P(Y(210.024,.05,101),U,2) S D0=Y(210.024,.05,80) S D1=Y(210.024,.05,81) W $E(X,1,50) K Y(210.024,.05)
 D N:$X>4 Q:'DN  W ?4 W "CERTIFYING AGENCY: "
 D N:$X>23 Q:'DN  W ?23
 X ^DD(210.024,1,9.2) S D0=$P(Y(210.024,1,1),U,1) S:'$D(^NURSF(212.2,+D0,0)) D0=-1 S Y(210.024,1,101)=$S($D(^NURSF(212.2,D0,0)):^(0),1:"") S X=$P(Y(210.024,1,101),U,3) S D0=Y(210.024,1,80) S D1=Y(210.024,1,81) W $E(X,1,50) K Y(210.024,1)
 D N:$X>0 Q:'DN  W ?0 W "DATE OF CERTIFICATION: "
 S X=$G(^NURSF(210,D0,12,D1,0)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,3) D DT
 D N:$X>3 Q:'DN  W ?3 W "DATE OF EXPIRATION: "
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,4) D DT
 Q
H1R ;
 W ?36 W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "PROFESSIONAL EXPERIENCE"
 D N:$X>27 Q:'DN  W ?27 W "-----------------------"
 S I(1)=20,J(1)=210.13 F D1=0:0 Q:$O(^NURSF(210,D0,20,D1))'>0  X:$D(DSC(210.13)) DSC(210.13) S D1=$O(^(D1)) Q:D1'>0  D:$X>52 T Q:'DN  D I1
 G I1R
I1 ;
 D T Q:'DN  D N D N:$X>24 Q:'DN  W ?24 W "LOCATION: "
 S X=$G(^NURSF(210,D0,20,D1,0)) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,4),1,30)
 D N:$X>14 Q:'DN  W ?14 W "TYPE OF EXPERIENCE: "
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,1),1,30)
 D N:$X>18 Q:'DN  W ?18 W "TITLE/POSITION: "
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^NURSF(211.3,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,10)
 D N:$X>0 Q:'DN  W ?0 W "DATE PREVIOUS ASSIGNMENT STARTED: "
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) D DT
 D N:$X>2 Q:'DN  W ?2 W "DATE PREVIOUS ASSIGNMENT ENDED: "
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,6) D DT
 Q
I1R ;
 W ?47 W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "MILITARY EXPERIENCE"
 D N:$X>27 Q:'DN  W ?27 W "-------------------"
 W ?48 D EN5^NURSAUTL K DIP K:DN Y
 W ?59 W !,NURSX K DIP K:DN Y
 D N:$X>27 Q:'DN  W ?27 W "PRIVILEGES"
 D N:$X>27 Q:'DN  W ?27 W "----------"
 S I(1)=16,J(1)=210.19 F D1=0:0 Q:$O(^NURSF(210,D0,16,D1))'>0  X:$D(DSC(210.19)) DSC(210.19) S D1=$O(^(D1)) Q:D1'>0  D:$X>39 T Q:'DN  D J1
 G J1R
J1 ;
 D T Q:'DN  D N D N:$X>3 Q:'DN  W ?3 W "PRIVILEGE: "
 S X=$G(^NURSF(210,D0,16,D1,0)) D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^NURSF(212.6,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,50)
 D N:$X>0 Q:'DN  W ?0 W "DATE GRANTED: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,2) D DT
 D N:$X>4 Q:'DN  W ?4 W "COMMENTS: "
 S I(2)=1,J(2)=210.192 F D2=0:0 Q:$O(^NURSF(210,D0,16,D1,1,D2))'>0  S D2=$O(^(D2)) D:$X>16 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^NURSF(210,D0,16,D1,1,D2,0)) S DIWL=15,DIWR=78 D ^DIWP
 Q
A2R ;
 D 0^DIWW
 D ^DIWW
 Q
J1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
