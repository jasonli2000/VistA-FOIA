DGMTXI ; GENERATED FROM 'DGMT ENTER/EDIT ANNUAL INCOME' INPUT TEMPLATE(#469), FILE 408.21;09/19/10
 D DE G BEGIN
DE S DIE="^DGMT(408.21,",DIC=DIE,DP=408.21,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGMT(408.21,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,8) S:%]"" DE(5)=% S %=$P(%Z,U,9) S:%]"" DE(8)=% S %=$P(%Z,U,10) S:%]"" DE(11)=% S %=$P(%Z,U,11) S:%]"" DE(14)=% S %=$P(%Z,U,12) S:%]"" DE(17)=% S %=$P(%Z,U,13) S:%]"" DE(20)=% S %=$P(%Z,U,14) S:%]"" DE(23)=%
 I  S %=$P(%Z,U,15) S:%]"" DE(26)=% S %=$P(%Z,U,16) S:%]"" DE(29)=% S %=$P(%Z,U,17) S:%]"" DE(32)=%
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
BEGIN S DNM="DGMTXI",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(469,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=469,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 K DGFIN
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I '$D(DGDR)!('$D(DGPRTY)) W !,*7,"Variable DGDR and DGPRTY must be defined!" S Y="@999"
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:DGDR'["101" Y="@102"
 Q
4 S DQ=5 ;@101
5 S DW="0;8",DV="NJ10,2X",DU="",DLB="SOCIAL SECURITY (NOT SSI)",DIFLD=.08
 S DE(DW)="C5^DGMTXI"
 G RE
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 D E40821^DGRTRIG(DA)
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C5F1 Q
X5 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
6 S DQ=7 ;@102
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:DGDR'["102" Y="@103"
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;9",DV="NJ8,2X",DU="",DLB="U.S. CIVIL SERVICE",DIFLD=.09
 S DE(DW)="C8^DGMTXI"
 G RE
C8 G C8S:$D(DE(8))[0 K DB
 S X=DE(8),DIC=DIE
 D E40821^DGRTRIG(DA)
C8S S X="" G:DG(DQ)=X C8F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C8F1 Q
X8 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
9 S DQ=10 ;@103
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:DGDR'["103" Y="@104"
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;10",DV="NJ8,2X",DU="",DLB="U.S. RAILROAD RETIREMENT",DIFLD=.1
 S DE(DW)="C11^DGMTXI"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 D E40821^DGRTRIG(DA)
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C11F1 Q
X11 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
12 S DQ=13 ;@104
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S:DGDR'["104" Y="@105"
 Q
14 D:$D(DG)>9 F^DIE17,DE S DQ=14,DW="0;11",DV="NJ8,2X",DU="",DLB="MILITARY RETIREMENT",DIFLD=.11
 S DE(DW)="C14^DGMTXI"
 G RE
C14 G C14S:$D(DE(14))[0 K DB
 S X=DE(14),DIC=DIE
 D E40821^DGRTRIG(DA)
C14S S X="" G:DG(DQ)=X C14F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C14F1 Q
X14 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
15 S DQ=16 ;@105
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S:DGDR'["105" Y="@106"
 Q
17 D:$D(DG)>9 F^DIE17,DE S DQ=17,DW="0;12",DV="NJ8,2X",DU="",DLB="UNEMPLOYMENT COMPENSATION",DIFLD=.12
 S DE(DW)="C17^DGMTXI"
 G RE
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 D E40821^DGRTRIG(DA)
C17S S X="" G:DG(DQ)=X C17F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C17F1 Q
X17 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
18 S DQ=19 ;@106
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S:DGDR'["106" Y="@107"
 Q
20 D:$D(DG)>9 F^DIE17,DE S DQ=20,DW="0;13",DV="NJ8,2X",DU="",DLB="OTHER RETIREMENT",DIFLD=.13
 S DE(DW)="C20^DGMTXI"
 G RE
C20 G C20S:$D(DE(20))[0 K DB
 S X=DE(20),DIC=DIE
 D E40821^DGRTRIG(DA)
C20S S X="" G:DG(DQ)=X C20F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C20F1 Q
X20 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
21 S DQ=22 ;@107
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S:DGDR'["107" Y="@108"
 Q
23 D:$D(DG)>9 F^DIE17,DE S DQ=23,DW="0;14",DV="NJ9,2X",DU="",DLB="TOTAL INCOME FROM EMPLOYMENT",DIFLD=.14
 S DE(DW)="C23^DGMTXI"
 G RE
C23 G C23S:$D(DE(23))[0 K DB
 S X=DE(23),DIC=DIE
 I $D(^DGMT(408.21,DA,0)),$P(^(0),U,14)="" D EMP^DGMTDD3
 S X=DE(23),DIC=DIE
 D E40821^DGRTRIG(DA)
C23S S X="" G:DG(DQ)=X C23F1 K DB
 S X=DG(DQ),DIC=DIE
 D EMP^DGMTDD3
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C23F1 Q
X23 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
24 S DQ=25 ;@108
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 D X25 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X25 S:DGDR'["108" Y="@109"
 Q
26 D:$D(DG)>9 F^DIE17,DE S DQ=26,DW="0;15",DV="NJ8,2X",DU="",DLB="INTEREST, DIVIDEND, OR ANNUITY",DIFLD=.15
 S DE(DW)="C26^DGMTXI"
 G RE
C26 G C26S:$D(DE(26))[0 K DB
 S X=DE(26),DIC=DIE
 D E40821^DGRTRIG(DA)
C26S S X="" G:DG(DQ)=X C26F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C26F1 Q
X26 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
27 S DQ=28 ;@109
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S:DGDR'["109" Y="@110"
 Q
29 D:$D(DG)>9 F^DIE17,DE S DQ=29,DW="0;16",DV="NJ8,2X",DU="",DLB="WORKERS COMP. OR BLACK LUNG",DIFLD=.16
 S DE(DW)="C29^DGMTXI"
 G RE
C29 G C29S:$D(DE(29))[0 K DB
 S X=DE(29),DIC=DIE
 D E40821^DGRTRIG(DA)
C29S S X="" G:DG(DQ)=X C29F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C29F1 Q
X29 S:X["$" X=$P(X,"$",2) X:X["*" "S X=X*12 W ""  "",X" K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
30 S DQ=31 ;@110
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 S:DGDR'["110" Y="@998"
 Q
32 D:$D(DG)>9 F^DIE17,DE S DQ=32,DW="0;17",DV="NJ9,2X",DU="",DLB="ALL OTHER INCOME",DIFLD=.17
 S DE(DW)="C32^DGMTXI"
 G RE
C32 G C32S:$D(DE(32))[0 K DB
 S X=DE(32),DIC=DIE
 D E40821^DGRTRIG(DA)
C32S S X="" G:DG(DQ)=X C32F1 K DB
 S X=DG(DQ),DIC=DIE
 D E40821^DGRTRIG(DA)
C32F1 Q
X32 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>9999999)!(X<0)!(X?.E1"."3.N) X
 Q
 ;
33 S DQ=34 ;@998
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 S DGFIN=""
 Q
35 S DQ=36 ;@999
36 G 0^DIE17
