IBXSC6 ; GENERATED FROM 'IB SCREEN6' INPUT TEMPLATE(#512), FILE 399;09/19/10
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,19) S:%]"" DE(25)=% S %=$P(%Z,U,22) S:%]"" DE(17)=% S %=$P(%Z,U,24) S:%]"" DE(5)=% S %=$P(%Z,U,25) S:%]"" DE(7)=% S %=$P(%Z,U,26) S:%]"" DE(11)=% S %=$P(%Z,U,27) S:%]"" DE(20)=%
 I $D(^("U2")) S %Z=^("U2") S %=$P(%Z,U,2) S:%]"" DE(12)=% S %=$P(%Z,U,3) S:%]"" DE(13)=% S %=$P(%Z,U,7) S:%]"" DE(15)=%
 I $D(^("U3")) S %Z=^("U3") S %=$P(%Z,U,2) S:%]"" DE(18)=%
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
BEGIN S DNM="IBXSC6",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(512,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=512,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S:IBDR20'["61" Y="@62"
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:$P($G(^DGCR(399,DA,0)),U,19)'=3 Y="@612"
 Q
3 S DQ=4 ;@611
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S DIE("NO^")=""
 Q
5 S DW="0;24",DV="RS",DU="",DLB="LOCATION OF CARE",DIFLD=.24
 S DU="1:HOSPITAL - INPT OR OPT (INCLUDES CLINICS);2:SKILLED NURSING (NHCU);3:HOME HEALTH AGENCY;7:CLINIC (ONLY INDEPENDENT/SATELITE);8:SPEC. FACILITY HOSP/AMB SURG CTR;"
 G RE
X5 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:'$D(DIE("NO^")) DIE("NO^")=""
 Q
7 S DW="0;25",DV="R*P399.1'",DU="",DLB="BILL CLASSIFICATION",DIFLD=.25
 S DE(DW)="C7^IBXSC6"
 S DU="DGCR(399.1,"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 D ALLID^IBCEP3(DA,.25,2)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 D ALLID^IBCEP3(DA,.25,1)
C7F1 Q
X7 S DIC("S")="I $P(^(0),U,23),$$TOBIN^IBCU4(Y,D0)" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 I '$$TOBIN^IBCU4($P(^DGCR(399,DA,0),U,25),DA) W !!,*7,"  **  The 'BILL CLASSIFICATION' must be consistent with the 'LOCATION OF CARE.'",! S Y="@611"
 Q
9 S DQ=10 ;@612
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 K DIE("NO^")
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;26",DV="RS",DU="",DLB="TIMEFRAME OF BILL",DIFLD=.26
 S DE(DW)="C11^IBXSC6"
 S DU="1:ADMIT THRU DISCHARGE;2:INTERIM - 1ST CLAIM;3:INTERIM - CONTINUING CLAIM;4:INTERIM - LAST CLAIM;5:LATE CHARGES ONLY;6:ADJUSTMENT CLAIM;7:REPLACEMENT CLAIM;8:VOID/CANCEL PRIOR CLAIM;O:NON-PAY/ZERO CLAIM;"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 ;
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,0)):^(0),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=DIV,X=X S DIH=$G(^DGCR(399,DIV(0),0)),DIV=X S $P(^(0),U,6)=DIV,DIH=399,DIG=.06 D ^DICR
C11F1 Q
X11 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW="U2;2",DV="NJ3,0",DU="",DLB="COVERED DAYS",DIFLD=216
 G RE
X12 K:+X'=X!(X>999)!(X<0)!(X?.E1"."1.N) X
 Q
 ;
13 S DW="U2;3",DV="NJ4,0",DU="",DLB="NON-COVERED DAYS",DIFLD=217
 G RE
X13 K:+X'=X!(X>9999)!(X<0)!(X?.E1"."1N.N) X
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 I '$$INPAT^IBCEF(DA)!($$FT^IBCEF(DA)'=3) S Y="@6121"
 Q
15 S DW="U2;7",DV="NJ3,0",DU="",DLB="CO-INSURANCE DAYS",DIFLD=221
 G RE
X15 K:+X'=X!(X>999)!(X<0)!(X?.E1"."1.N) X
 Q
 ;
16 S DQ=17 ;@6121
17 S DW="0;22",DV="P40.8'",DU="",DLB="DEFAULT DIVISION",DIFLD=.22
 S DE(DW)="C17^IBXSC6"
 S DU="DG(40.8,"
 G RE
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 ;
 S X=DE(17),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U3")):^("U3"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"U3")),DIV=X S $P(^("U3"),U,2)=DIV,DIH=399,DIG=243 D ^DICR
C17S S X="" G:DG(DQ)=X C17F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$PRVNUM^IBCU(DA,"",1) X ^DD(399,.22,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=$$PRVNUM^IBCU(DA,"",2) X ^DD(399,.22,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=$$PRVNUM^IBCU(DA,"",3) X ^DD(399,.22,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y S X=DIV S X=$$PRVQUAL^IBCU(DA,"",1) X ^DD(399,.22,1,4,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X=DIV S X=$$PRVQUAL^IBCU(DA,"",2) X ^DD(399,.22,1,5,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M1")):^("M1"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X=DIV S X=$$PRVQUAL^IBCU(DA,"",3) X ^DD(399,.22,1,6,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$CLIAREQ^IBCEP8A(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X=DIV S X=$$CLIA^IBCEP8A(DA) X ^DD(399,.22,1,7,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U3")):^("U3"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$P($$TAXDEF^IBCEP81(DIV(0)),U,2) X ^DD(399,.22,1,8,1.4)
C17F1 Q
X17 Q
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="U3;2",DV="*P8932.1'",DU="",DLB="DEFAULT DIVISION TAXONOMY",DIFLD=243
 S DU="USC(8932.1,"
 G RE
X18 S DIC("S")="I $P($G(^(90002)),U,2)=""N""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 D DISPTAX^IBCEP81($P($G(^DGCR(399,DA,"U3")),U,2),"Default Division")
 Q
20 S DW="0;27",DV="S",DU="",DLB="BILL CHARGE TYPE",DIFLD=.27
 S DE(DW)="C20^IBXSC6"
 S DU="1:INSTITUTIONAL;2:PROFESSIONAL;"
 G RE
C20 G C20S:$D(DE(20))[0 K DB
 S X=DE(20),DIC=DIE
 ;
C20S S X="" G:DG(DQ)=X C20F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,0)):^(0),1:"") S X=$P(Y(1),U,19),X=X S DIU=X K Y S X=DIV S X=$$FT^IBCU3(DA,1) X ^DD(399,.27,1,1,1.4)
C20F1 Q
X20 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 S DGRVRCAL=1
 Q
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S DIPA("FT1")=$P($G(^DGCR(399,DA,0)),U,19)
 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 D CKFT^IBCIUT1(IBIFN)
 Q
24 S DQ=25 ;@614
25 D:$D(DG)>9 F^DIE17,DE S DQ=25,DW="0;19",DV="R*P353'",DU="",DLB="FORM TYPE",DIFLD=.19
 S DE(DW)="C25^IBXSC6"
 S DU="IBE(353,"
 G RE
C25 G C25S:$D(DE(25))[0 K DB
 D ^IBXSC61
C25S S X="" G:DG(DQ)=X C25F1 K DB
 D ^IBXSC62
C25F1 Q
X25 S DIC("S")="N Z S Z=$G(^IBE(353,Y,2)) I $P(Z,U,2)=""P"",$P(Z,U,4)" D ^DIC K DIC S DIC=$G(DIE),X=+Y K:Y<0 X
 Q
 ;
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S DIPA("FT")=$P($G(^DGCR(399,DA,0)),U,19)
 Q
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 I $P($G(^IBE(353,+DIPA("FT"),2)),U,2)="P",$P($G(^(2)),U,4) S DIPA("FT1")=DIPA("FT") D CKFT^IBCIUT1(IBIFN) S Y="@615"
 Q
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 W !,*7,"Must be a printable national form type"
 Q
29 D:$D(DG)>9 F^DIE17 G ^IBXSC63
