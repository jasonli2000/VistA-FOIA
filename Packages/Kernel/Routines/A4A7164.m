A4A7164 ; GLRISC/REL - Move Data fields into 200 ;5/31/89  11:35
 ;;1.01
 W !!,"Moving data which has not already been moved"
 W !,"from Files 3,6 & 16 into File 200 ..."
 F K=0:0 S K=$N(^DIC(3,K)) Q:K'>0  D MOV
 Q
MOV K X S P3=K,Y=$S($D(^DIC(3,P3,0))#2:^(0),1:"") Q:Y=""  S P16=$P(Y,"^",16)
 S NAM=$P(Y,"^",1)
 S X(0)=$S($D(^VA(200,P3,0))#2:^(0),1:"") Q:X(0)=""
 S X(1)=$S($D(^VA(200,P3,1))#2:^(1),1:"") K:X(1)="" X(1)
 F L=2,4,9,11 S Z=$P(Y,"^",L) S:Z'="" $P(X(0),"^",L)=Z
 S Y=$S($D(^DIC(3,P3,5))#2:$P(^(5),"^",1,2),1:"") I "^"'[Y S X(5)=Y
 S Y=$S($D(^DIC(3,P3,.1))#2:$P(^(.1),"^",4),1:"") S:Y'="" $P(X(.1),"^",4)=Y
 G:'P16 M1
 S Y=$S($D(^DIC(16,P16,0))#2:$P(^(0),"^",1),1:"") I Y'=NAM D NAM
 S Y=$S($D(^DIC(16,P16,.11))#2:$P(^(.11),"^",1,6),1:"") I "^^^^^"'[Y S X(.11)=Y
 S Y=$S($D(^DIC(16,P16,.121))#2:$P(^(.121),"^",1,8),1:"") I "^^^^^^^"'[Y S X(.121)=Y
 S Y=$S($D(^DIC(16,P16,.13))#2:$P(^(.13),"^",1,4),1:"") I "^^^"'[Y S X(.13)=Y
 S Y=$S($D(^DIC(16,P16,20))#2:$P(^(20),"^",1,4),1:"") I "^^"'[$P(Y,"^",2,4) S X(20)="^"_$P(Y,"^",2,4)
 S Y=$P(Y,"^",1) S:Y'="" $P(X(0),"^",2)=Y
 S Y=$S($D(^DIC(16,P16,0))#2:$P(^(0),"^",2,3),1:"")
 I "^"'[Y S:Y'["^" Y=Y_"^" S $P(X(1),"^",2,3)=Y
 S P6=$S($D(^DIC(16,P16,"A6"))#2:^("A6"),1:"") G:P6<1 M1
 S Y=$S($D(^DIC(6,P6,.11))#2:$P(^(.11),"^",1,6),1:"") I "^^^^^"'[Y S:$D(X(.11)) $P(^DIC(16,P16,.11),"^",1,6)=$P(Y_"^^^^^","^",1,6) S X(.11)=Y
 S Y=$S($D(^DIC(6,P6,0))#2:$P(^(0),"^",2),1:"") S:Y'="" $P(X(0),"^",2)=Y
 S Y=$S($D(^DIC(6,P6,"I"))#2:$P(^("I"),"^",1),1:"") S:Y'="" X("I")=Y
M1 S Z="" F L=0:0 S Z=$O(X(Z)) Q:Z=""  S ^VA(200,P3,Z)=X(Z)
 Q
NAM S $P(^DIC(16,P16,0),"^",1)=NAM K ^DIC(16,"B",$E(Y,1,30),P16)
 S ^DIC(16,"B",$E(NAM,1,30),P16)="" I $E(NAM,1)=$E(Y,1) G N1
 S SSN=$S($D(^DIC(16,P16,0))#2:$P(^(0),"^",9),1:"") G:SSN="" N1
 K ^DIC(16,"BS5",$E(Y,1)_$E(SSN,6,9),P16) S ^DIC(16,"BS5",$E(NAM,1)_$E(SSN,6,9),P16)=""
N1 S $P(^DIC(16,P16,20),"^",2)=$E(NAM,",",2)_" "_$P(NAM,",",1) Q
