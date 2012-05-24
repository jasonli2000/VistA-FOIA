NURCES0 ;HIRMFO/YH,RM,FT,YH-END OF SHIFT REPORT PART 1/1 ;6/25/97  14:35
 ;;4.0;NURSING SERVICE;**2**;Apr 25, 1997
EN1 ;132 COLUMN FORMAT OF REPORT
 S NOPT=1,NURS132=1
START0 G:'$D(^DIC(213.9,1,"OFF")) QUIT2 G:$P(^DIC(213.9,1,"OFF"),"^",1)=1 QUIT2
 I '$D(^GMRD(126.95,1,1)) W !,"The Nursing shift parameters in ^GMRD(126.95) must be completed.",!,"Please contact the Nursing ADP Coordinator",! G QUIT2
 S NURQUIT=0 K DIR
 S DIR("A")="Please enter the character of your choice: "
 S DIR("A",1)="Select shift for the report"
 S DIR("A",2)=" "
 S DIR("A",3)="     N - night"
 S DIR("A",4)="     D - day"
 S DIR("A",5)="     E - evening"
 S DIR("A",6)=" "
 S DIR(0)="SMA^N:night;D:day;E:evening"
 D ^DIR K DIR I $D(DIRUT) G QUIT2
 S NX=Y,GMRDAY=$P(^GMRD(126.95,1,1),"^",2),GMREVE=$P(^(1),"^",3),GMRNIT=$P(^(1),"^")
 I GMRDAY=""!(GMREVE="")!(GMRNIT="") W !,"The Nursing shift parameters in ^GMRD(126.95) must be completed.",!,"Please contact the Nursing ADP Coordinator",! G QUIT2
 S GMRSTRT=$S(NX="N":DT,NX="D":DT_"."_GMRDAY,NX="E":DT_"."_GMREVE,1:"") G:GMRSTRT="" QUIT S GMRFIN=$S(NX="N":DT_"."_GMRDAY,NX="D":DT_"."_GMREVE,NX="E":DT_".2400",1:"") G:GMRFIN="" QUIT
 S:NX'="N" GMRFIN=GMRFIN-0.0001
 I NX="N",GMRNIT>2000 S X1=DT,X2=-1 D C^%DTC K %DTC S GMRSTRT=X_"."_GMRNIT
 W ! D WARDPAT^NURCUT0 S:NUREDB="" NUROUT=1 G:NURQUIT QUIT S:"Pp"'[NUREDB NURORDR=$$SORT^NURCES5("")
 G:NURQUIT QUIT D EN6^NURSUT0 G:NURQUIT QUIT W:NOPT=1 !,"THIS REPORT REQUIRES AN 132 COLUMN DEVICE - LAND!"
 W ! S ZTRTN="START^NURCES0",ZTDESC="NURSING END-OF-SHIFT REPORT" D EN7^NURSUT0 G:POP!($D(ZTSK)) QUIT
START ;
 S GPACK=1,X="GMRYRP0" X ^%ZOSF("TEST") S:'$T GPACK=0 S GFH=1,X="FHWHEA" X ^%ZOSF("TEST") S:'$T GFH=0 S $P(NURX,"-",130)="" D NOW^%DTC S NURNOW=%,Y=$E(%,1,12) X ^DD("DD") S NURDT=Y
 S NURNOW(1)=$$FMADD^XLFDT(NURNOW,-1)
 I $E(IOST)="P",NCOPY>1 D
 .  F NURI=1:1 Q:NURI>NCOPY  D REPORT W:NURI<NCOPY @IOF
 .  Q
 E  D REPORT
QUIT ; KILL LOCAL VARIABLES
 D CLOSE^NURSUT1 K NURNOW,NURORDR
QUIT2 K ^TMP($J) D KVAR^VADPT,^NURCKILL K NURMDSW
 Q
REPORT U IO S (NURSW1,NURPAGE)=0 K ^TMP($J),^TMP("DIQ1",$J)
 D ^NURCAS2
 I '$D(^TMP($J,"NURCEN")) D HEADER^NURCES2 W $C(7),!,"NO PATIENTS IN SELECTED ROOM(S) ON "_NPWARD Q
PRINT ;PRINT ROUTINE
 I "Pp"[NUREDB S (NURWARD,NPWARD)=+$P(^NURSF(214,+DFN,0),"^",3) D:NPWARD>0 EN6^NURSAUTL S NURORDR="SORT1"
 D @NURORDR
 Q
SORT1 ;
 S NBED="" F  S NBED=$O(^TMP($J,"NURCEN",NBED)) Q:NBED=""!(NURQUIT)  I NBED'="GMRY" S NBED(0)="" F  S NBED(0)=$O(^TMP($J,"NURCEN",NBED,NBED(0))) Q:NBED(0)=""!(NURQUIT)  D
 . D:'NURSW1 HEADER^NURCES2 S N1="" F  S N1=$O(^TMP($J,"NURCEN",NBED,NBED(0),N1)) Q:N1=""!(NURQUIT)  K NPT,NSS,NADM,NCL,NPR S NDATA=^(N1),DFN=$P(NDATA,"^"),NSSN=$P(NDATA,"^",2) D PRINT1^NURCES01 K ^TMP($J,"GMRY")
 Q
EN2 ;80 COLUMN FORMAT REPORT
 S NOPT=2 K NURS132 G START0
 ;
SORT2 ;RESORT BY PATIENT NAME
 S NBED="" F  S NBED=$O(^TMP($J,"NURCEN",NBED)) Q:NBED=""  D
 . S NBED(0)="" F  S NBED(0)=$O(^TMP($J,"NURCEN",NBED,NBED(0))) Q:NBED(0)=""  D
 . . S N1="" F  S N1=$O(^TMP($J,"NURCEN",NBED,NBED(0),N1)) Q:N1=""  S ^TMP($J,"NSORT",N1,$P(NBED,"-"),NBED(0))=^TMP($J,"NURCEN",NBED,NBED(0),N1)
 S N1="" F  S N1=$O(^TMP($J,"NSORT",N1)) Q:N1=""!(NURQUIT)  I N1'="GMRY" S NBED="" F  S NBED=$O(^TMP($J,"NSORT",N1,NBED)) Q:NBED=""!(NURQUIT)  D
 . D:'NURSW1 HEADER^NURCES2 Q:NURQUIT  S NBED(0)="" F  S NBED(0)=$O(^TMP($J,"NSORT",N1,NBED,NBED(0))) Q:NBED(0)=""!(NURQUIT)  K NPT,NSS,NADM,NCL,NPR S NDATA=^(NBED(0)),DFN=$P(NDATA,"^"),NSSN=$P(NDATA,"^",2) D PRINT1^NURCES01 K ^TMP($J,"GMRY")
 Q
SORT3 ;RESORT BY BED ORDER
 S NBED="" F  S NBED=$O(^TMP($J,"NURCEN",NBED)) Q:NBED=""  D
 . S NBED(0)="" F  S NBED(0)=$O(^TMP($J,"NURCEN",NBED,NBED(0))) Q:NBED(0)=""  D
 . . S N1="" F  S N1=$O(^TMP($J,"NURCEN",NBED,NBED(0),N1)) Q:N1=""  S ^TMP($J,"NSORT",NBED(0),$P(NBED,"-"),N1)=^TMP($J,"NURCEN",NBED,NBED(0),N1)
 S NBED(0)="" F  S NBED(0)=$O(^TMP($J,"NSORT",NBED(0))) Q:NBED(0)=""!(NURQUIT)  I NBED(0)'="GMRY" S NBED="" F  S NBED=$O(^TMP($J,"NSORT",NBED(0),NBED)) Q:NBED=""!(NURQUIT)  D
 . D:'NURSW1 HEADER^NURCES2 Q:NURQUIT  S N1="" F  S N1=$O(^TMP($J,"NSORT",NBED(0),NBED,N1)) Q:N1=""!(NURQUIT)  K NPT,NSS,NADM,NCL,NPR S NDATA=^(N1),DFN=$P(NDATA,"^"),NSSN=$P(NDATA,"^",2) D PRINT1^NURCES01 K ^TMP($J,"GMRY")
 Q
