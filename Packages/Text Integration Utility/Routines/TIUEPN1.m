TIUEPN1 ; ;02/20/98
 D DE G BEGIN
DE S DIE="^TIU(8925,",DIC=DIE,DP=8925,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^TIU(8925,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,7) S:%]"" DE(1)=% S %=$P(%Z,U,8) S:%]"" DE(2)=%
 I $D(^(12)) S %Z=^(12) S %=$P(%Z,U,5) S:%]"" DE(5)=%
 I $D(^(13)) S %Z=^(13) S %=$P(%Z,U,1) S:%]"" DE(8)=%
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
BEGIN S DNM="TIUEPN1",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW="0;7",DV="D",DU="",DLB="EPISODE BEGIN DATE/TIME",DIFLD=.07
 S DE(DW)="C1^TIUEPN1"
 S X=$P($G(TIU("EDT")),U)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C1 G C1S:$D(DE(1))[0 K DB S X=DE(1),DIC=DIE
 D KAPTLD^TIUDD01(.07,X)
C1S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 D SAPTLD^TIUDD0(.07,X)
 Q
X1 Q
2 D:$D(DG)>9 F^DIE17,DE S DQ=2,DW="0;8",DV="DX",DU="",DLB="EPISODE END DATE/TIME",DIFLD=.08
 S X=$P($G(TIU("LDT")),U)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 I '+$G(TIUBY) S Y="@1"
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I +$P($G(^TIU(8925,+DA,12)),U,5) S Y="@13"
 Q
5 S DW="12;5",DV="P44'",DU="",DLB="HOSPITAL LOCATION",DIFLD=1205
 S DE(DW)="C5^TIUEPN1"
 S DU="SC("
 S X=$P($G(TIU("LOC")),U)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C5 G C5S:$D(DE(5))[0 K DB S X=DE(5),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ALOC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=DE(5),DIC=DIE
 I +$P($G(^TIU(8925,+DA,15)),U) K ^TIU(8925,"ALOCP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)
C5S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALOC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$$ALOCP^TIULX(+DA),+$P($G(^TIU(8925,+DA,15)),U) S ^TIU(8925,"ALOCP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)=""
 Q
X5 Q
6 S DQ=7 ;@13
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I +$G(^TIU(8925,+DA,13)) S Y="@14"
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="13;1",DV="D",DU="",DLB="REFERENCE DATE",DIFLD=1301
 S DE(DW)="C8^TIUEPN1"
 S X=$$NOW^TIULC
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C8 G C8S:$D(DE(8))[0 K DB S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"AAU",+$P(^TIU(8925,+DA,12),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,8),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ASUP",+$P(^TIU(8925,+DA,12),U,8),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"APT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ATS",+$P(^TIU(8925,+DA,14),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ATC",+$P(^TIU(8925,+DA,13),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ALL","ANY",+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),$L($P($G(^TIU(8925,+DA,17)),U)) D ASUBK^TIUDD($P($G(^TIU(8925,+DA,17)),U),+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ASVC",+$P(^TIU(8925,+DA,14),U,4),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$O(^TIU(8925.9,"B",+DA,0)) D APRBK^TIUDD(+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,3),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U,4),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ADCPT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U,4),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)
 S X=DE(8),DIC=DIE
 K ^TIU(8925,"D",$E(X,1,30),DA)
 S X=DE(8),DIC=DIE
 I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) K ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),+$$CLINDOC^TIULC1(+$P(^TIU(8925,+DA,0),U),+DA),(9999999-X),DA)
 S X=DE(8),DIC=DIE
 I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) K ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),38,(9999999-X),DA)
 S X=DE(8),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ALOC",+$P(^TIU(8925,+DA,12),U,5),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)
 S X=DE(8),DIC=DIE
 D KACLPT^TIUDD01(1301,X)
 S X=DE(8),DIC=DIE
 D KACLAU^TIUDD01(1301,X),KACLAU1^TIUDD01(1301,X)
 S X=DE(8),DIC=DIE
 D KACLEC^TIUDD01(1301,X)
 S X=DE(8),DIC=DIE
 D KACLSB^TIUDD01(1301,X)
C8S S X="" Q:DG(DQ)=X  K DB S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AAU",+$P(^TIU(8925,+DA,12),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,8),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASUP",+$P(^TIU(8925,+DA,12),U,8),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"APT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATS",+$P(^TIU(8925,+DA,14),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATC",+$P(^TIU(8925,+DA,13),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALL","ANY",+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),$L($P($G(^TIU(8925,+DA,17)),U)) D ASUBS^TIUDD($P($G(^TIU(8925,+DA,17)),U),+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASVC",+$P(^TIU(8925,+DA,14),U,4),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$O(^TIU(8925.9,"B",+DA,0)) D APRBS^TIUDD(+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,3),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U,4),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ADCPT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U,4),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)=""
 S X=DG(DQ),DIC=DIE
 S ^TIU(8925,"D",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),+$$CLINDOC^TIULC1(+$P(^TIU(8925,+DA,0),U),+DA),(9999999-X),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),38,(9999999-X),DA)=""
 S X=DG(DQ),DIC=DIE
 I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALOC",+$P(^TIU(8925,+DA,12),U,5),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=DG(DQ),DIC=DIE
 D SACLPT^TIUDD0(1301,X)
 S X=DG(DQ),DIC=DIE
 D SACLAU^TIUDD0(1301,X),SACLAU1^TIUDD0(1301,X)
 S X=DG(DQ),DIC=DIE
 D SACLEC^TIUDD0(1301,X)
 S X=DG(DQ),DIC=DIE
 D SACLSB^TIUDD0(1301,X)
 Q
X8 Q
9 S DQ=10 ;@14
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I +$P($G(^TIU(8925,+DA,12)),U,2) S Y="@1"
 Q
11 D:$D(DG)>9 F^DIE17 G ^TIUEPN2
