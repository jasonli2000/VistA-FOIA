RACTVR4 ; ;03/19/10
 D DE G BEGIN
DE S DIE="^RARPT(",DIC=DIE,DP=74,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RARPT(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(7)=% S %=$P(%Z,U,7) S:%]"" DE(16)=% S %=$P(%Z,U,9) S:%]"" DE(1)=%,DE(10)=% S %=$P(%Z,U,10) S:%]"" DE(12)=% S %=$P(%Z,U,17) S:%]"" DE(4)=%,DE(13)=%
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
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
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
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="RACTVR4",DQ=1
1 S DW="0;9",DV="*P200'X",DU="",DLB="VERIFYING PHYSICIAN",DIFLD=9
 S DU="VA(200,"
 S X=$S($D(RAVER):RAVER,1:"")
 S Y=X
 G Y
X1 S DIC("S")="N RAINADT X ^DD(74,9,9.2) I $S('RAINADT:1,DT'>RAINADT:1,1:0),$D(^XUSEC(""RA VERIFY"",+Y)),($D(^VA(200,""ARC"",""R"",+Y))!($D(^VA(200,""ARC"",""S"",+Y))))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I X=""!('X) W !!,$C(7),"You must enter the 'VERIFYING PHYSICIAN'." S Y="@15"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 K RAVER S:$D(^VA(200,X,0)) RAVER=$P(^(0),U)
 Q
4 S DW="0;17",DV="P200'",DU="",DLB="STATUS CHANGED TO VERIFIED BY",DIFLD=17
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y="@30"
 Q
6 S DQ=7 ;@15
7 S DW="0;5",DV="RSX",DU="",DLB="REPORT STATUS",DIFLD=5
 S DE(DW)="C7^RACTVR4"
 S DU="V:VERIFIED;R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT;EF:ELECTRONICALLY FILED;X:DELETED;"
 S Y="DRAFT"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 X "D ^RABUL2 Q"
 S X=DE(7),DIC=DIE
 N RAXREF K RASET S RAXREF="ARES",RARAD=12,RAKILL="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(7),DIC=DIE
 N RAXREF K RASET S RAXREF="ASTF",RARAD=15,RAKILL="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(7),DIC=DIE
 K ^RARPT("ASTAT",$E(X,1,30),DA)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ARES",RARAD=12,RASET="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RARAD,RASET
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ASTF",RARAD=15,RASET="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RARAD,RASEC
 S X=DG(DQ),DIC=DIE
 S:"Vv"'[$E(X) ^RARPT("ASTAT",$E(X,1,30),DA)=""
C7F1 Q
X7 D EN1^RAUTL4
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S Y="@5"
 Q
9 S DQ=10 ;@20
10 D:$D(DG)>9 F^DIE17,DE S DQ=10,DW="0;9",DV="*P200'X",DU="",DLB="VERIFYING PHYSICIAN",DIFLD=9
 S DU="VA(200,"
 S X="`"_RAVER
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X10 S DIC("S")="N RAINADT X ^DD(74,9,9.2) I $S('RAINADT:1,DT'>RAINADT:1,1:0),$D(^XUSEC(""RA VERIFY"",+Y)),($D(^VA(200,""ARC"",""R"",+Y))!($D(^VA(200,""ARC"",""S"",+Y))))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S X1=RASIG("PER"),X=RASIG("NAME"),X2=DA D EN^XUSHSHP S RASIGCDE=X
 Q
12 S DW="0;10",DV="FIO",DU="",DLB="ELECTRONIC SIGNATURE CODE",DIFLD=10
 S DQ(12,2)="S Y(0)=Y S Y=""  <Hidden>"""
 S X=RASIGCDE
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X12 K:$L(X)>50!($L(X)<1) X
 I $D(X),X'?.ANP K X
 Q
 ;
13 S DW="0;17",DV="P200'",DU="",DLB="STATUS CHANGED TO VERIFIED BY",DIFLD=17
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X13 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 K RASIGCDE,X2,X1
 Q
15 S DQ=16 ;@30
16 S DW="0;7",DV="DI",DU="",DLB="VERIFIED DATE",DIFLD=7
 S DE(DW)="C16^RACTVR4"
 S X="NOW"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C16 G C16S:$D(DE(16))[0 K DB
 S X=DE(16),DIC=DIE
 K ^RARPT("AA",9999999.9999-$E(X,1,30),DA)
C16S S X="" G:DG(DQ)=X C16F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RARPT("AA",9999999.9999-$E(X,1,30),DA)=""
C16F1 Q
X16 S %DT="TX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
17 S DQ=18 ;@99
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I $E(RAOLDST)=$E(RACT) S Y="@999"
 Q
19 D:$D(DG)>9 F^DIE17,DE S DQ=19,D=0 K DE(1) ;100
 S DIFLD=100,DGO="^RACTVR5",DC="10^74.01DA^L^",DV="74.01RD",DW="0;1",DOW="LOG DATE",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 I $D(DSC(74.01))#2,$P(DSC(74.01),"I $D(^UTILITY(",1)="" X DSC(74.01) S D=$O(^(0)) S:D="" D=-1 G M19
 S D=$S($D(^RARPT(DA,"L",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M19 I D>0 S DC=DC_D I $D(^RARPT(DA,"L",+D,0)) S DE(19)=$P(^(0),U,1)
 S X=$$MIDNGHT^RAUTL5($$NOW^XLFDT())
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R19 D DE
 G A
 ;
20 S DQ=21 ;@999
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 K RASTATX,RAOLDST
 Q
22 G 0^DIE17
