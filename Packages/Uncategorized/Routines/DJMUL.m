DJMUL ;JA/WASH;MULTIPLE STACK DRIVER ; 04 Sep 86  11:14 AM
 ;VERSION 1.36
 K DJW2 G:X=""!($E(X,1)="^") EN3^DJINJ S:X=" " X=V(V)
 S DJST=DJST+1,^UTILITY($J,"DJST",DJST,"DA")=V(V,"DA"),^UTILITY($J,"DJST",DJST,"SC")=$N(^DJR("B",$P(DJJ(V),U,6),0)),^UTILITY($J,"DJST",DJST-1,"LOC")=V,^UTILITY($J,"DJST",DJST,"DD")=V(V,"DD"),^UTILITY($J,"DJST",DJST,"GN")=V(V,"GN")
 S ^UTILITY($J,"DJST",DJST,"FRSC")=DJN,^UTILITY($J,"DJST",DJST,"DIC")=^UTILITY($J,"DJST",DJST-1,"DIC")_^UTILITY($J,"DJST",DJST-1,"DA")_","_V(V,"GN")_","
 S DJZ=DJST F DJK=1:1:DJST-1 S DJZ=DJZ-1,DA(DJZ)=^UTILITY($J,"DJST",DJK,"DA")
 S DJNM=$P(^DJR(^UTILITY($J,"DJST",DJST,"SC"),0),U,1),DIC=^UTILITY($J,"DJST",DJST,"DIC") S:$D(@(DIC_0_")"))=0 @(DIC_0_")")="^"_^UTILITY($J,"DJST",DJST,"DD")_"^^" K DJDN
 S DIC(0)="EQZM" S:'$D(DJDIS) DIC(0)=DIC(0)_"L" X DJCP W ! W X D ^DIC I X["?" X DJCL W "Type <CR> to continue:" R DJX:DTIME S:DJ4["S" DJT=DJDD,DJDD=+DJ4,DJY=DJAT,DJAT=.01 D ^DJINQ:DJ4["S"!(DJ4["D") S:DJ4["S" DJDD=DJT,DJAT=DJY
 I $Y>23 R !,"Type <CR> to continue",DJZ1:DTIME K DJZ1
 I Y>0 D SAVE K V,DJMUL S DA=+Y,DJDN=+Y,^UTILITY($J,"DJST",DJST,"DA")=DA,@("D"_(DJST-1)_"="_DA) D ^DJDPL S (W(V),V(V))=DJDN D ^DJC2 S ^UTILITY($J,"DJST",DJST-1,"KEY")=V(DJKEY) D EN^DJINJ S DJW2=1
 S DJN=^UTILITY($J,"DJST",DJST,"FRSC") S DJST=DJST-1 S DJNM=$P(^DJR(DJN,0),"^",1),DIC=^UTILITY($J,"DJST",DJST,"DIC") S DJDN=^UTILITY($J,"DJST",DJST,"DA")
 K DA S DJZ=DJST I $D(DJW2),DJST>1 F DJK=1:1:DJST-1 S DJZ=DJZ-1,DA(DJZ)=^UTILITY($J,"DJST",DJK,"DA")
 I $D(DJW2),DJST>1 F DJK=0:1:DJST-2 S @("D"_DJK)=^UTILITY($J,"DJST",DJK+1,"DA")
 I $D(DJW2) D REST S V=^UTILITY($J,"DJST",DJST,"LOC"),V(V)=^UTILITY($J,"DJST",DJST,"KEY") D ^DJDPL K DJZ,DJW2 G N
 D N^DJDPL
N S DJFF=0,V=^UTILITY($J,"DJST",DJST,"LOC") G TK^DJINJ
SAVE S %X="V(",%Y="^UTILITY($J,""DJ"",DJN," D %XY^%RCR K V Q
REST K V S %X="^UTILITY($J,""DJ"",DJN,",%Y="V(" D %XY^%RCR Q
