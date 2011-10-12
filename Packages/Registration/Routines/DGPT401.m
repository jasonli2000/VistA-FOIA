DGPT401 ;ALB/MTC - 401/402/403 Edits ; 16 NOV 92
 ;;5.3;Registration;**164,729**;Aug 13, 1993;Build 59
 ;
 ;Edits for 401/402/403 transmission
EN ;
 N ERROR
 S (DGPTEDFL,DGPTERC)=0,DGPTSTR=^TMP("AEDIT",$J,NODE,SEQ),DGPTERC=0
 S:$E(DGPTSTR,37,40)="2400" DGPTSTR=$E(DGPTSTR,1,36)_"2359"_$E(DGPTSTR,41,125)
SET ;
 S DGPTSDT=$E(DGPTSTR,31,40)
 S DGPTSSC=$E(DGPTSTR,41,42),DGPTSCS=$E(DGPTSTR,43),DGPTSFA=$E(DGPTSTR,44),DGPTSAT=$E(DGPTSTR,45),DGPTSSP=$E(DGPTSTR,46),DGPTSO1=$E(DGPTSTR,47,53),DGPTSO2=$E(DGPTSTR,54,60)
 S DGPTSO3=$E(DGPTSTR,61,67),DGPTSO4=$E(DGPTSTR,68,74),DGPTSO5=$E(DGPTSTR,75,81),DGPTXX=$E(DGPTSTR,82,90)
 S DGPT40PT=$E(DGPTSTR,91)
DATE ;
 S DGPTSDT=$E(DGPTSTR,31,40),(X,DGPTSDD)=$$FMDT^DGPT101($E(DGPTSDT,1,6))_"."_$E(DGPTSDT,7,10) S %DT="XT" D ^%DT K %DT I Y<0 S DGPTERC=405 D ERR G:DGPTEDFL EXIT
 I (DGPTSDD<DGPTDTS)!(DGPTSDD>DGPTDDS) S DGPTERC=437 D ERR G:DGPTEDFL EXIT
 I (DGPTSDD>DGPTDDS) S DGPTERC=440 D ERR G:DGPTEDFL EXIT
 D DD^%DT S DGPTSDT=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)_" "_$S($P(Y,"@",2)]"":$E($P(Y,"@",2),1,5),1:"00:00")
 I DGPTSDT'?1.2N1"-"3U1"-"4N1" "2N1":"2N S DGPTERC=450 D ERR G:DGPTEDFL EXIT
 I ($P(DGPTSDD,".",2)="0000")!($P(DGPTDTS,".",2)="0000")!($P(DGPTDDS,".",2)="0000") S DGPTERC=$S(+DGPTSDD<+DGPTDTS:437,+DGPTSDD>+DGPTDDS:440,1:0)
SPEC ;
 I ((DGPTSSC>63)!(DGPTSSC<48))&((DGPTSSC'=65)&(DGPTSSC'=78)&(DGPTSSC'=97)) S DGPTERC=406 D ERR G:DGPTEDFL EXIT
CHFS ;
 S DGPTERC=0 D CHIEF^DGPTAE04 I DGPTERC D ERR G:DGPTEDFL EXIT
FAST ;
 S DGPTERC=0 D FAST^DGPTAE04 I DGPTERC D ERR G:DGPTEDFL EXIT
ANES ;
 S DGPTERC=0 D ANES^DGPTAE04 I DGPTERC D ERR G:DGPTEDFL EXIT
SRP ;
 N I,FLAG
 I "12 "'[DGPTSSP S DGPTERC=410 D ERR G:DGPTEDFL EXIT
 S FLAG=0 F I=20:1:26 I DGPTSTTY[U_I_U S FLAG=1 Q
 G:FLAG OPCD
 I "12"[DGPTSSP S DGPTERC=410 F I=10,11,30,40,42 I DGPTSTTY[U_I_U S FLAG=1,DGPTERC=0 Q
 I FLAG D ERR G:DGPTEDFL EXIT
OPCD ;
 S DGPTERC=0 D FIRST^DGPTAE04 G:DGPTEDFL EXIT
TRANS ; Transplant status
 I DGPTDDS'<2911001 G GOOD
 S DGPTERC=0 D TRAN^DGPTAE04 I DGPTERC D ERR G:DGPTEDFL EXIT
GOOD ;
 W:'$D(ERROR) "."
EXIT ;
 K DGPTSDT,DGPTSSC,DGPTSCS,DGPTSFA,DGPTSAT,DGPTSSP,DGPTSO1,DGPTSO2,DGPTSO3,DGPTSO4,DGPTSO5,DGPTXX,DGPTSTR
 K DGPTSDD,DGPT40PT
 Q
ERR ;
 D WRTERR^DGPTAE(DGPTERC,NODE,SEQ)
 S ERROR=1
 Q
 ;