RTSM5 ;RPW/BUF,PKE/TROY-Init RT pull list 1 clinic; 7-27-87 ; 10/6/87  16:16 ;
 ;;v 2.0;Record Tracking;**13**;10/22/91
 ;
18 W !,"Clinic Record Request Initialization",!
AGN S DIC=44,DIC(0)="AEQM" D ^DIC G Q16:Y<0 S RTSC=+Y
 I $P(^SC(RTSC,0),"^",3)'="C" W !,*7,"This location is NOT a CLINIC",*7,! G AGN
 ;
 S X="T",%DT="" D ^%DT K %DT S DT=Y,%DT(0)=Y D DATE^RTUTL G Q16:'$D(RTEND) S:RTEND'["." RTEND=RTEND_".9999"
 S RTDESC="Clinic Record Request Initialization Routine",RTVAR="RTBEG^RTEND^RTSC",RTPGM="START^RTSM5" D ZIS^RTUTL G Q16:POP S RTAPLX=RTAPL,RTDIVX=RTDIV D START S RTAPL=RTAPLX,RTDIV=RTDIVX K RTAPLX,RTDIVX G Q16
 ;
START U IO D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W @IOF,!,"Clinic Record Requests Initialization Program",!!,"Start    Time: ",Y S RTBKGRD="",RTMASS=+^DIC(195.4,1,"MAS"),RTRAD=+^("RAD") D GET^RTSM6
 S RTMAS=RTMASS
 I $D(^SC(RTSC,0)),$P(^(0),"^",3)="C" D APP
 W !!,"Number of requests made or reaffirmed:"
 F Z=0:0 S Z=$O(RTSCOUNT(RTMASS,Z)) Q:'Z  S Y=Z D D^DIQ W !?3,Y," = ",$E(RTSCOUNT(RTMASS,Z)_"     ",1,6)_$S($D(RTSCOUNT(RTRAD,Z)):" X-ray Requests = "_RTSCOUNT(RTRAD,Z),1:"")
 I '$D(RTSCOUNT(RTMASS)),'$D(RTSCOUNT(RTRAD)) W " 0"
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W !!,"Finished Time: ",Y
 ;
Q16 K RTINP,RTEXCLUD,Z,RTMASS,RTRAD,RTMAS,RTDESC,RTVAR,RTPGM,DFN,RTSC,RTTM,RTPL,SDSC,SDTTM,SDPL,RTSCOUNT,RTBEG,RTEND D CLOSE^RTUTL
 K RTBKGRD,Y,DIC,X,%I Q
APP I $D(^RTV(195.9,"ABOR",(RTSC_";SC("),RTMAS)) S X=+$O(^(RTMAS,0)) I '$O(^(X)),$D(^RTV(195.9,X,0)),$P(^(0),"^",14)'="y" Q
 F RTTM=(RTBEG-.0001):0 S RTTM=$O(^SC(RTSC,"S",RTTM)) Q:'RTTM!(RTEND<RTTM)  F RTPL=0:0 S RTPL=$O(^SC(RTSC,"S",RTTM,1,RTPL)) Q:'RTPL  I $D(^(RTPL,0)),$P(^(0),"^",9)'="C" S DFN=+^(0) D RTQ
 Q
RTQ S SDSC=RTSC,SDTTM=RTTM,SDPL=RTPL,RTBKGRD="" D CREATE^RTQ2 I $D(^SC(RTSC,"S",RTTM,1,RTPL,"RTR")) F RTMAS=RTMASS,RTRAD D CNT^RTSM6 I '$D(ZTQUEUED) W "."
 S RTMAS=RTMASS
 Q
