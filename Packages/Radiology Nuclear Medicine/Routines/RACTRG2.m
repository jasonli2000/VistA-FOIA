RACTRG2 ; ;03/13/10
 D DE G BEGIN
DE S DIE="^RADPT(D0,""DT"",D1,""P"",",DIC=DIE,DP=70.03,DL=3,DIEL=2,DU="" K DG,DE,DB Q:$O(^RADPT(D0,"DT",D1,"P",DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(8)=%,DE(15)=% S %=$P(%Z,U,3) S:%]"" DE(5)=% S %=$P(%Z,U,26) S:%]"" DE(4)=%
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
BEGIN S DNM="RACTRG2",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S RACN=X,RACNI=DA
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S RACMTHOD=$P(^RA(79.1,+$P(RAMLC,"^"),0),"^",21)
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S RACMTHOD=$S(RACMTHOD]"":RACMTHOD,1:0)
 Q
4 S DW="0;26",DV="S",DU="",DLB="CREDIT METHOD",DIFLD=26
 S DU="0:Regular Credit;1:Interpretation Only;2:No Credit;3:Technical Component Only;"
 S X=RACMTHOD
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X4 Q
5 S DW="0;3",DV="R*P72'X",DU="",DLB="EXAM STATUS",DIFLD=3
 S DE(DW)="C5^RACTRG2"
 S DU="RA(72,"
 S X=$O(^RA(72,"AA",RAIMGTY,1,0))
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 K ^RADPT("AE",+$P($G(^RADPT(DA(2),"DT",DA(1),"P",DA,0)),U),DA(2),DA(1),DA)
 S X=DE(5),DIC=DIE
 K ^RADPT("AS",$E(X,1,30),DA(2),DA(1),DA)
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 N RA,RAIMGTY S RA(0)=$G(^RADPT(DA(2),"DT",DA(1),0)),RAIMGTY=$P($G(^RA(79.2,+$P(RA(0),U,2),0)),U) I RAIMGTY]"" X:('$D(^RA(72,"AA",RAIMGTY,9,X)))&('$D(^RA(72,"AA",RAIMGTY,0,X))) ^DD(70.03,3,9.2)
 S X=DG(DQ),DIC=DIE
 N RA,RAIMGTY S RA(0)=$G(^RADPT(DA(2),"DT",DA(1),0)),RAIMGTY=+$P(RA(0),U,2),RAIMGTY=$P($G(^RA(79.2,RAIMGTY,0)),U) I RAIMGTY]"" S:('$D(^RA(72,"AA",RAIMGTY,9,X)))&('$D(^RA(72,"AA",RAIMGTY,0,X))) ^RADPT("AS",$E(X,1,30),DA(2),DA(1),DA)=""
C5F1 Q
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S RASTI=X
 Q
7 S DQ=8 ;@3
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;2",DV="*P71'XR",DU="",DLB="PROCEDURE",DIFLD=2
 S DE(DW)="C8^RACTRG2",DE(DW,"INDEX")=1
 S DU="RAMIS(71,"
 S X=$S($D(RAPRC):RAPRC,1:"")
 S Y=X
 G Y
C8 G C8S:$D(DE(8))[0 K DB
 S X=DE(8),DIC=DIE
 K ^RADPT(DA(2),"DT","AP",$E(X,1,30),DA(1),DA)
 S X=DE(8),DIC=DIE
 D DW^RACPTMSC
C8S S X="" G:DG(DQ)=X C8F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RADPT(DA(2),"DT","AP",$E(X,1,30),DA(1),DA)=""
 S X=DG(DQ),DIC=DIE
 ;
C8F1 S DIEZRXR(70.03,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=463 S DIEZRXR(70.03,DIXR)=""
 Q
X8 S DIC("S")="I $$ACTC^RACPTCSV" X ^DD(70.03,2,9.2)
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S RAPRI=X
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S RAPRI(0)=$G(^RAMIS(71,+RAPRI,0))
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 I $P(RAMDV,U,7),($P(RAPRI(0),U,6)="B") S Y="@3000"
 Q
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S:$P($G(^RA(79,+$$DIVSION^RAUTL6(DT,+$P($G(^RAO(75.1,+RAOIFN,0)),"^",22)),.1)),"^",7)="N"!($P(RAPRI(0),"^",6)'="B") Y="@4"
 Q
13 S DQ=14 ;@3000
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 W !?3,$C(7),"A 'detailed' procedure or a 'series' of procedures is required!"
 Q
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW="0;2",DV="*P71'X",DU="",DLB="PROCEDURE",DIFLD=2
 S DE(DW)="C15^RACTRG2",DE(DW,"INDEX")=1
 S DU="RAMIS(71,"
 S Y="@"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C15 G C15S:$D(DE(15))[0 K DB
 S X=DE(15),DIC=DIE
 K ^RADPT(DA(2),"DT","AP",$E(X,1,30),DA(1),DA)
 S X=DE(15),DIC=DIE
 D DW^RACPTMSC
C15S S X="" G:DG(DQ)=X C15F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RADPT(DA(2),"DT","AP",$E(X,1,30),DA(1),DA)=""
 S X=DG(DQ),DIC=DIE
 ;
C15F1 S DIEZRXR(70.03,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=463 S DIEZRXR(70.03,DIXR)=""
 Q
X15 S DIC("S")="I $$ACTC^RACPTCSV" X ^DD(70.03,2,9.2)
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S Y="@3"
 Q
17 S DQ=18 ;@4
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S RAPX(RACNI)=RACN_"^"_^RAMIS(71,RAPRI,0)
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S REM="don't copy proc mods for Series and Broad, 9/24/1999"
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S:$P(RAPX(RACNI),U,7)="S" Y="@7"
 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 S:$P(RAPX(RACNI),U,7)="B" Y="@8"
 Q
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S RAI=0,Y=$S('$D(RAPRC):"@6",RAPRC'=$P(RAPX(RACNI),U,2):"@6",1:"@5")
 Q
23 S DQ=24 ;@5
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 S RAI=$O(^RAO(75.1,+RAOIFN,"M","B",RAI)) S:'RAI Y="@6"
 Q
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 S RAMOD=$S($D(^RAMIS(71.2,RAI,0)):$P(^(0),U),1:-1) S:RAMOD<0 Y="@6"
 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S:'$D(^RAMIS(71.2,"AB",+$$ITYPE^RASITE(+$G(RAPRI)),RAI)) Y="@5"
 Q
27 D:$D(DG)>9 F^DIE17 G ^RACTRG3
