APSPT04 ; GENERATED FROM 'PSO INTERVENTION EDIT' INPUT TEMPLATE(#1381), FILE 9009032.4;09/17/98
 D DE G BEGIN
DE S DIE="^APSPQA(32.4,",DIC=DIE,DP=9009032.4,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^APSPQA(32.4,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(3)=% S %=$P(%Z,U,4) S:%]"" DE(4)=% S %=$P(%Z,U,5) S:%]"" DE(5)=% S %=$P(%Z,U,6) S:%]"" DE(6)=% S %=$P(%Z,U,7) S:%]"" DE(7)=%
 I  S %=$P(%Z,U,8) S:%]"" DE(9)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) I DV'["*" D ^DIC S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
BEGIN S DNM="APSPT04",DQ=1
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIEZ=1381,U="^"
1 S DW="0;1",DV="RDX",DU="",DLB="INTERVENTION DATE",DIFLD=.01
 S DE(DW)="C1^APSPT04"
 G RE
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 K ^APSPQA(32.4,"B",$E(X,1,30),DA)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"B",$E(X,1,30),DA)=""
 Q
X1 S %DT="EX",%DT(0)=-DT D ^%DT K %DT(0) S X=Y K:Y<1 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;2",DV="RP2'",DU="",DLB="PATIENT",DIFLD=.02
 S DE(DW)="C2^APSPT04"
 S DU="DPT("
 G RE
C2 G C2S:$D(DE(2))[0 K DB S X=DE(2),DIC=DIE
 K ^APSPQA(32.4,"C",$E(X,1,30),DA)
C2S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"C",$E(X,1,30),DA)=""
 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW="0;3",DV="*P200'",DU="",DLB="PROVIDER",DIFLD=.03
 S DE(DW)="C3^APSPT04"
 S DU="VA(200,"
 G RE
C3 G C3S:$D(DE(3))[0 K DB S X=DE(3),DIC=DIE
 K ^APSPQA(32.4,"AC",$E(X,1,30),DA)
C3S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"AC",$E(X,1,30),DA)=""
 Q
X3 S DIC("S")="S X(1)=$G(^(""PS"")) I +X(1),$S('$P(X(1),""^"",4):1,1:$P(X(1),""^"",4)'<DT)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="0;4",DV="*P200'",DU="",DLB="PHARMACIST",DIFLD=.04
 S DE(DW)="C4^APSPT04"
 S DU="VA(200,"
 G RE
C4 G C4S:$D(DE(4))[0 K DB S X=DE(4),DIC=DIE
 K ^APSPQA(32.4,"AE",$E(X,1,30),DA)
 S X=DE(4),DIC=DIE
 K ^APSPQA(32.4,"D",$E(X,1,30),DA)
C4S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"AE",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"D",$E(X,1,30),DA)=""
 Q
X4 S DIC("S")="I $D(^XUSEC(""PSORPH"",Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;5",DV="P50'",DU="",DLB="DRUG",DIFLD=.05
 S DU="PSDRUG("
 G RE
X5 Q
6 S DW="0;6",DV="RS",DU="",DLB="INSTITUTED BY",DIFLD=.06
 S DU="1:PHARMACY;2:PROVIDER;3:NURSING;4:PATIENT OR FAMILY;5:OTHER;"
 G RE
X6 Q
7 S DW="0;7",DV="RP9009032.3'",DU="",DLB="INTERVENTION",DIFLD=.07
 S DE(DW)="C7^APSPT04"
 S DU="APSPQA(32.3,"
 G RE
C7 G C7S:$D(DE(7))[0 K DB S X=DE(7),DIC=DIE
 K ^APSPQA(32.4,"AD",$E(X,1,30),DA)
C7S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 S ^APSPQA(32.4,"AD",$E(X,1,30),DA)=""
 Q
X7 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,D=0 K DE(1) ;1100
 S Y="OTHER FOR INTERVENTION^WL^^0;1^Q",DG="11",DC="^9009032.411" D DIEN^DIWE K DE(1) G A
 ;
9 S DW="0;8",DV="RP9009032.5'",DU="",DLB="RECOMMENDATION",DIFLD=.08
 S DU="APSPQA(32.5,"
 G RE
X9 Q
10 D:$D(DG)>9 F^DIE17 G ^APSPT041
