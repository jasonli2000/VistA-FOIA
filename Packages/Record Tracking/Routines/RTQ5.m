RTQ5 ;MJK/TROY ISC;RADIOLOGY Link; ; 5/15/87  8:57 AM ;
 ;;v 2.0;Record Tracking;;10/22/91
 I $D(RTAPL) D SAVE^RTPSET1,NEXT,RESTORE^RTPSET1 Q
NEXT Q:'$D(^DIC(195.4,1,"RAD"))  S Y=+^("RAD") D APL1^RTPSET K SDSC D NOW^%DTC S SDTTM=%,SDPL=0,DFN=RADFN,IOP="" D ^%ZIS K IOP
 I $D(RAMLC),$D(^RA(79.1,+RAMLC,0)) S Y=$P(^(0),"^"),Y=$S(Y?.N:Y,1:$O(^SC("B",Y,0))) S:$D(^SC(Y,0)) SDSC=Y
 I '$D(SDSC) D RA^RTRAD G Q:Y<0 S SDSC=+$P(^RTV(195.9,Y,0),"^",2)
 I '$D(^RT("AA",+RTAPL,DFN_";DPT(")) D NOASK^RTQ3 G Q
 S RTRD(1)="Yes^indicate it is a wet reading",RTRD(2)="No^indicate it is not a wet reading",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Is this a WET READING? " D SET^RTRD K RTRD S:$E(X)="Y" RTCOM="**** WET READING ****" D QUE^RTQ2 W !
Q K RTDIV,RTFR,RTAPL,RTSYS,SDSC,SDTTM,SDPL,RTCOM Q
