LRZTST ;LAB ACC/RESULT LIST BY SPECIFIC TEST;CGF/ALB;4/25/86 [ 05/31/95  8:45 AM ]
 S U="^",X="T",%DT="" D ^%DT S DT=+Y K X,Y,%DT
AREA S DIC="^LRO(68,",DIC(0)="AEQMZ" D ^DIC K DIC I Y<1 W *7,!!,X," NOT IN ACCESSION FILE" G QUIT
 S LRAA=+Y
TST S DIC="^LAB(60,",DIC(0)="AEQMZ" D ^DIC K DIC G:X="^"!(X="") QUIT I Y<1 W *7,!!,"NOT AN ACCEPTABLE TEST" G TST
 S LRTST=+Y
 S ZTRTN="DQ^LRZTST" D B^LRU Q:Y<0  D BEG^LRUTL Q:POP!($D(ZTSK))
DQ S PG=0,IOF="#" D DT^LRU,BEG
 W @IOF C:IO'=IO(0) IO I $D(IO("C")) G H^XUS
 Q
BEG D ^LRPARAM S LRINF=^LRO(68,LRAA,0),LRAA(1)=$P(LRINF,"^",1),LRE=$P(LRINF,"^",2) G QUIT:'$L(LRE)
 S V(1)=$S($P(LRINF,"^",3)="Y":$E(LRSDT,1,3)_"0000",1:LRSDT),V=$S($P(LRINF,"^",3)="Y":$E(LRLDT,1,3)_"0000",1:LRLDT)
 D HD
 S V(1)=V(1)-1 F I=V(1):0 S I=$N(^LRO(68,LRAA,1,I)) Q:I<1!(I>V)  F N=0:0 S N=$N(^LRO(68,LRAA,1,I,1,N)) Q:N'>0  D SUB
QUIT K LRAA,LRAA(1),LRE,LRLDT,LRSDT,ENDDATE,BEGDATE,LRINF,V,V(1),I,N,PG,LRTST,ZZ,J,LRNUM,TP,X,C(3),P(5),A(3),LRIFN,TNAM,LOC,TLOC,UT,ANS,X1 Q
HD S PG=PG+1 W @IOF,!!,LRAA(1)," ACCESSION / RESULT LIST",?46,"DATE: ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),?71,"PAGE: ",PG
 W !,?21,"DATE RANGE: ",$E(LRSDT,4,5),"/",$E(LRSDT,6,7),"/",$E(LRSDT,2,3)," to ",$E(LRLDT,4,5),"/",$E(LRLDT,6,7),"/",$E(LRLDT,2,3)
 W !,?26,"Test requested: ",$P(^LAB(60,LRTST,0),"^",1)
 W !!,"ACC#",?6,"ARRIVAL",?18,"PATIENT",?38,"ID",?44,"LOC",?52,"SPEC",?59,"TEST",?68,"RESULTS",! F II=1:1:80 W "-"
 W !! Q
SUB Q:'$D(^LRO(68,LRAA,1,I,1,N,3))  F ZZ=0:0 S ZZ=$N(^LRO(68,LRAA,1,I,1,N,4,ZZ)) Q:ZZ'>0  G:ZZ=LRTST!($D(TP(ZZ))) SET I $P(^LAB(60,ZZ,0),"^",5)="" F J=0:0 S J=$N(^LAB(60,ZZ,2,J)) Q:J'>0  S LRNUM=^(J,0) I LRNUM=LRTST S TP(ZZ)=ZZ G SET
 Q
SUB1 ;F J=0:0 S J=$N(^LAB(60,ZZ,2,J)) Q:J'>0  S LRNUM=^(J,0) I LRNUM=LRTST S TP(ZZ)=ZZ G SET
 Q
SET S X=$S($D(^LRO(68,LRAA,1,I,1,N,5,1,0)):^(0),1:""),C(3)=+X S:'C(3) C(3)=LRUNKNOW Q:'$D(^LRO(68,LRAA,1,I,1,N,3))  S X=^(3),P(5)=$P(X,"^",5),A(3)=$P(X,"^",3),X=^(0),LRIFN=+X,A(7)=$P(X,"^",7) S:'A(3) A(3)=$P(X,"^",3)
 Q:'$D(^LR(LRIFN,0))  S X=^(0),Y=$P(X,"^",3),X=$P(X,"^",2),P(0)=$P(^DIC(X,0),"^",1),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),P(9)=$P(X,"^",9),P(1)=$P(X,"^",1)
 D:$Y>52 HD D WRTN
WRT2 I $P(^LAB(60,ZZ,0),"^",5)'="" S INF=^LAB(60,ZZ,0),TNAM=$E($P(^LAB(60,ZZ,.1),"^",1),1,7),LOC=$P(INF,"^",5),TLOC=$P(LOC,";",2),UT=$S($D(^LAB(60,ZZ,1,C(3),0)):$P(^(0),"^",7),1:"") G WRT1
 F J=0:0 S J=$N(^LAB(60,ZZ,2,J)) Q:J'>0  S TNUM=^(J,0),INF=^LAB(60,TNUM,0),TNAM=$E($P(^LAB(60,TNUM,.1),"^",1),1,8),LOC=$P(INF,"^",5),TLOC=$P(LOC,";",2),UT=$S($D(^LAB(60,TNUM,1,C(3),0)):$P(^(0),"^",7),1:"") D WRT1
 Q
WRT1 I '$D(^LR(LRIFN,LRE,P(5),TLOC)) S X="",X1="" G WRT3
 S ANS=$P(^LR(LRIFN,LRE,P(5),TLOC),"^",1),X1="" S:$E(ANS,1)=">"!($E(ANS,1)="<") X1=$E(ANS,1),ANS=$E(ANS,2,10) S X=$S(+ANS=ANS:$J(ANS,6,1)_$P(^(TLOC),"^",2),ANS["%":+ANS,1:ANS_$P(^(TLOC),"^",2))
WRT3 W ?59,TNAM,?67 W:X1'="" X1 W X,?75,$E(UT,1,5),!
 I $D(^LR(LRIFN,LRE,P(5),1,2,0)) W ?22,^(0),!
 Q
WRTN W !,N,?6,$E(A(3),4,5),"/",$E(A(3),6,7),"@",$E(A(3),9,12),?18,$E(P(1),1,17),?38,$E(P(9),6,9),?44,$E(A(7),1,6),?52,$S($D(^LAB(61,C(3),0)):$E($P(^LAB(61,C(3),0),"^",1),1,5),1:"")
 Q
VAR S VAR="BEGDATE^ENDDATE^ASPGM^LRAA^LRTST",VAL=BEGDATE_"^"_ENDDATE_"^"_ASPGM_"^"_LRAA_"^"_LRTST
 Q
