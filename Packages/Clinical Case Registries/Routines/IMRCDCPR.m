IMRCDCPR ;ISC-SF/JLI-PRINT CDC FORMS ;7/16/97  08:48
 ;;2.1;IMMUNOLOGY CASE REGISTRY;;Feb 09, 1998
BLNKCDC ; [IMR BLANK CDC FORM] - Generate a Blank copy of CDC Form
 W !,"Need 132 character wide printer."
 D IMRDEV^IMREDIT G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQBLNK^IMRCDCPR",ZTDESC="Print Blank CDC Form" D ^%ZTLOAD D ^%ZISC K ZTDESC,ZTRTN,ZTSK G EXIT
 U IO D DQBLNK D ^%ZISC K %ZIS,IOP G EXIT
DQBLNK S (IMRADDR,IMRNAM,IMRPTEL,IMRADDR2,IMRCNTY,IMRSTATE,IMRZIP,IMRPHYS,IMRPHYST,IMRUSR,IMRUSRT,IMRSSN,IMRPT,IMRPN,IMRCDC)=""
 S (IMRDOB,IMRDOD)="__  __   __"
 S (IMRLT,IMRFT)="__    __"
 S IMRFDM="_____",(IMRCOPI,IMRCOPY)=1
 D ^IMRCDP1,^IMRCDP2,^IMRCDP3,^IMRCDP4,^IMRCDP5,^IMRCDP6,^IMRCDP7,^IMRCDP8,KILL
 Q
CDCPRT ; [IMR PRINT CDC FORM] - Print CDC Form with Data
 S IMRNEW=0 D CHK^IMREDIT K IMRNEW G:DA'>0 EXIT S IMRDA=+DA
CDCPRT1 S IMRP103=+Y
 S IMRPHYS="",DIC=200,DIC("A")="Select PHYSICIAN NAME for form: ",DIC(0)="AEQM" D ^DIC K DIC G EXIT:U[X!$D(DTOUT),CDCPRT:Y<1
 I Y>0 S IMRPHYS=$P(^VA(200,+Y,0),U),IMRPHYS=$P(IMRPHYS,",",2,9)_" "_$P(IMRPHYS,",")
 K DIR S IMRPHYST=$S($D(^IMR(158.9,1,4)):$P(^(4),U,8),1:"") S DIR(0)="FO^13:13^K:X'?1""(""3N1"")""3N1""-""4N X",DIR("A")="PHYSICIAN Phone Number",DIR("A",1)="Enter the following phone number in the format (NNN)NNN-NNNN"
 S:IMRPHYST'="" DIR("B")=IMRPHYST
 D ^DIR K DIR G:$D(DIRUT)!($D(DIROUT)) EXIT S IMRPHYST=X I X'="" S $P(^IMR(158.9,1,4),U,8)=X
 W !! S IMRUSR=$P(^VA(200,DUZ,0),U),IMRUSR=$P(IMRUSR,",",2,9)_" "_$P(IMRUSR,",")
 S IMRUSRT=$S($D(^IMR(158.9,1,4)):$P(^(4),U,7),1:""),DIR(0)="FO^13:13^K:X'?1""(""3N1"")""3N1""-""4N X",DIR("A")="YOUR OFFICE Phone Number",DIR("A",1)="Enter your Phone Number in the format (NNN)NNN-NNNN"
 S:IMRUSRT'="" DIR("B")=IMRUSRT D ^DIR K DIR G:$D(DIRUT)!($D(DIROUT)) EXIT
 S:(IMRUSRT=""&(X'="")) $P(^IMR(158.9,1,4),U,7)=X S IMRUSRT=X,DIR(0)="N^1:10",DIR("B")=1,DIR("A")="Number of Copies" D ^DIR K DIR G:$D(DIRUT)!($D(DIROUT)) EXIT
 S IMRCOPY=$S(+Y>0:+Y,1:1)
 W !!,"Need 132 character wide printer." D IMRDEV^IMREDIT G:POP EXIT
 I $D(IO("Q")) D SAVE G EXIT
 U IO D DQ D ^%ZISC K %ZIS,IOP G EXIT
SAVE ; ZTSAVE all the Variables
 K IO("Q"),ZTSAVE,ZTIO,ZTDTH S ZTDESC="PRINT CDC FORM",ZTSAVE("IMRDA")="",ZTSAVE("IMRP103")="",ZTSAVE("IMRPHYS")="",ZTSAVE("IMRNAM")=""
 S ZTSAVE("IMRPTEL")="",ZTSAVE("IMRADDR")="",ZTSAVE("IMRADDR2")="",ZTSAVE("IMRPHYST")="",ZTSAVE("IMRSSN")="",ZTSAVE("IMRUSR")=""
 S ZTSAVE("IMRCOPY")="",ZTSAVE("IMRUSRT")="",ZTSAVE("IMRDOB")="",ZTSAVE("IMRDOD")="",ZTRTN="DQ^IMRCDCPR" D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",! K ZTDESC,ZTSAVE,ZTIO,ZTRTN,ZTSK
 Q
DQ ; Process Printing CDC Form
 S (IMRPT,IMRPN)=+IMRDA S:'$D(^IMR(158,IMRDA,108)) ^(108)=""
 S DFN=IMRP103 D DEM^VADPT,ADD^VADPT S IMRDOD=+VADM(6) S:IMRDOD'>0 IMRDOD=$S('$D(^IMR(158,IMRDA,5)):0,$P(^(5),U,19)'>0:0,1:$P(^(5),U,19))
 S IMRDOD=$S(IMRDOD'>0:"__  __   __",1:$E(IMRDOD,4,5)_"  "_$E(IMRDOD,6,7)_"   "_$E(IMRDOD,2,3)),IMRDOB=+VADM(3),IMRDOB=$S(IMRDOB'>0:"__  __   __",1:$E(IMRDOB,4,5)_"  "_$E(IMRDOB,6,7)_"   "_$E(IMRDOB,2,3))
 S IMRNAM=VADM(1),IMRSSN=$P(VADM(2),U),IMRPTEL=VAPA(8),IMRADDR=VAPA(1),IMRADDR2=VAPA(4),IMRSTATE=$P(VAPA(5),U,2),IMRZIP=VAPA(6),IMRCNTY=$P(VAPA(7),U,2)
 S IMRCDC="",IMRFT="",IMRLT="" I $D(^IMR(158,IMRDA,1)) S IMRCDC=$P(^(1),U,6),IMRFT=$P(^(1),U,22),IMRLT=$P(^(1),U,23)
 S:IMRFT="" IMRFT="_____" S:IMRLT="" IMRLT="_____"
 S IMRFDM=$S('$D(^IMR(158,IMRDA,2)):"",1:$P(^(2),U,47)) I IMRFDM="" S IMRFDM="_____"
 S IMRCDC=$E(IMRCDC,4,5)_"  "_$E(IMRCDC,6,7)_"   "_$E(IMRCDC,2,3),IMRFT=$E(IMRFT,4,5)_"    "_$E(IMRFT,2,3),IMRLT=$E(IMRLT,4,5)_"    "_$E(IMRLT,2,3),IMRFDY=$E(IMRFDM,2,3),IMRFDM=$E(IMRFDM,4,5)
 I $P(^IMR(158,IMRPN,0),U,39)'="C" W:'$D(ZTQUEUED) *7,!,"Just a moment please...",! D S1^IMRCDC S:$D(^IMR(158,IMRPN,0)) $P(^(0),U,39)="C" D END^IMRCDC
 K VA,VADM,DFN
 S:+$P($G(^IMR(158.9,1,0)),U,7)>0 ^IMR(158,IMRPN,103)=IMRP103
 S IMRUT=0
 F IMRCOPI=1:1:IMRCOPY Q:IMRUT  D ^IMRCDP1,^IMRCDP2,^IMRCDP3,^IMRCDP4,^IMRCDP5,^IMRCDP6,^IMRCDP7,^IMRCDP8
 K:$P(^IMR(158.9,1,0),U,7)'>0 ^IMR(158,IMRPN,103)
KILL ; kill variables for both blank cdc form and cdc w/data
 K C,DQTIME,IMRPN,IMRP103,IMRNAM,IMRSSN,IMRPTEL,IMRADDR,IMRADDR2,IMRDOD,IMRDOB,IMRCDC,IMRFT,IMRLT,IMRFDM,IMRFDY,IMRCOPY,IMRCOPI,IMRCNTY,IMRSTATE,IMRZIP,LN,UNDR,IMRUT
 Q
HDR ; Check End Of Page
 S IMRUT=0 I $E(IOST,1,2)="C-" W ! S DIR(0)="E" D ^DIR K DIR I 'Y S IMRUT=1 Q
 Q
EXIT K %X,%Y,B,D,DHIT,DIC,DIPGM,DISYS,DIJ,DP,%ZIS,DA,IMRP103,POP,Y,IMRPT,IMRSTN,IMRFLG,IMRDA,IMRDFN,IMREDIT,IMRPHYS,IMRPHYST,IMRUSR,IMRUSRT,X,Y0,Y1,Y2,M,P,X1,%T,DIWI,DIWTC,DIWX,VAERR,VAPA,ZTSK,ZTREQ,IMRCOPY,IMRCOPI
 Q
