RTP3 ;MJK/TROY ISC,JLU/TROY ISC;Clinic Pull List; ; 5/15/87  3:21 PM ;
 ;;2.0;Record Tracking;**7,37,43**;10/22/91
 K RTDV,RTTDFL,RTPULL,RTDT,RTSORT,RTLIST D DIV^RTP4 G Q:'$D(RTDV) S X=$P(^DIC(195.1,+RTAPL,"INST",RTDV,0),"^",3),RTDVS=$S(X="c":2,X="a":3,X="h":4,X="d":5,1:1),RTX=X
 S RTMES="PRINTED" D PULL^RTP6 K RTMES G Q:'$D(RTPULL) S:RTPULL RTSORT=$S(RTX="c":"C",RTX="a":"A",RTX="h":"H",RTX="d":"D",RTX="t":"T",1:"T") K:$E(RTPULL,1,3)="ALL" RTPULL
 S RTRD(1)="Terminal Digits^sort by terminal digits",RTRD(2)="Clinic Name^sort by clinic name; then by terminal digits",RTRD(3)="Appointment Time^sort by clinic name; then by appointment time"
 S RTRD(4)="Home Location^sort by home location; then terminal digits",RTRD(5)="Detailed Home Location^sort by home location, clinic, terminal digits"
 S RTRD("B")=RTDVS,RTRD(0)="S",RTRD("A")="How do you want list sorted? " D SET^RTRD K RTRD G Q:$E(X)="^" S RTSORT=$E(X)
 S RTRD(1)="All^include all appointments",RTRD(2)="Not Fillable^print a short non-fillable list" S:"HDCT"[RTSORT RTRD(3)="Detail-Not Fillable^print a detailed non-fillable list",RTRD(4)="Update^only include updates to list"
 S RTRD(0)="S",RTRD("B")=1,RTRD("A")="Select type of list? " D SET^RTRD K RTRD G Q:$E(X)="^" S RTLIST=$E(X)
 W ! S RTDESC="Clinic Pull List ["_$P($P(RTAPL,"^"),";",2)_"]",RTVAR="RTDV^RTSORT^RTAPL^RTDT^RTLIST"_$S($D(RTPULL):"^RTPULL^RTPULL0",1:""),RTPGM="START^RTP3" S IOP="HOME" D ^%ZIS K IOP D ZIS^RTUTL
 I POP X "N POP D ^%ZISC D DEV^RTP32" G Q:POP
START U IO K ^TMP($J) D NOW^%DTC S RTRDT=%,RTBEG=RTDT-.0001 I RTLIST="D" D ^RTP32 W:'$D(RTNONE) !!?3,"No lists needed to be produced." G Q
 I '$D(RTPULL) F RTDTE=RTBEG:0 S RTDTE=$O(^RTV(194.2,"C",RTDTE)) Q:RTDT<$P(RTDTE,".")!('RTDTE)  F RTP=0:0 S RTP=$O(^RTV(194.2,"C",RTDTE,RTP)) Q:'RTP  I $D(^RTV(194.2,RTP,0)) S X=^(0) I $P(X,"^",10)=1,$S(RTLIST="N":1,1:$P(X,"^",6)'="x") D PULL
 I $D(RTPULL) S RTP=RTPULL D PULL
 G ^RTP31
Q K RTC,RTDVS,RT,RT0,RTB,RTC,RTCLOC,RTCNME,RTDEV,RTDESC,RTDIGIT,RTDT,RTDTE,RTDV,RTESC,RTINST,RTL,RTLIST,RTLNME,RTP,RTP0,RTPAGE,RTPDT,RTPDV,RTPGM,RTVAR,RTPNME,RTPX,RTQ,RTQ0,Q,Q0,RTQDT,RTQNME,RTQST,RTQTIME,RTRDT,RTSORT,RTHLP,RTHL,RTHL1
 K RTWND,RTTASK,RTNONE,RTHD,RTQST,RTBEG,RTPGFL,RTPULL0,RTTDFL,RTPULL,RTTD,RTTDX,RTVAR,RTWARD,RTYPE,RTHL,RTDIG,RTHLN,RTX,^TMP($J),RTDED,RTCM,RTJCOM,RTTRG,Y,RTHLOC,RTTDC,T,RTCUR1,RTCUR,P,C,DUOUT,X,RTBCNT,RTBREC,RTBREC1,RTBST D CLOSE^RTUTL Q
 ;
PULL ;Entry point for list with RTP
 Q:'$D(^RTV(194.2,RTP,0))  S RTP0=^(0) I $P(RTP0,"^",15)=+RTAPL S RTPDV=+$P(RTP0,"^",12),RTPDT=+$P(RTP0,"^",2),RTB=+$P(RTP0,"^",5),Y=RTB D BOR^RTB S RTPNME=Y D RTQ
 I "HDCT"[RTSORT,"AU"[RTLIST D NOW^%DTC S $P(^RTV(194.2,RTP,0),"^",$S(RTLIST="A":13,1:14))=%
 Q
RTQ F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTP,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) S RTQ0=^(0) I $P(RTQ0,"^",5)=RTB S RTQST=$P(RTQ0,"^",6),RTQDT=+$P(RTQ0,"^",4) I $D(^RT(+RTQ0,0)) S RT=+RTQ0,RT0=^(0) D RT
 Q
 ;
RT S RTBST=1  ;; CHANGE FOR RT*2.0*37
 I $O(^RTV(195.9,RTB,"RECS",0)) D
 .S (RTBST,RTBREC1,RTADMIN)="",RTBCNT=0,RTADMIN=$O(^DIC(195.2,"B","ADMINISTRATIVE FOLDER",RTADMIN))
 .F RTBREC=0:0 S RTBREC=$O(^RTV(195.9,RTB,"RECS",RTBREC)) Q:'RTBREC  S RTBCNT=RTBCNT+1,RTBREC1=$P(^RTV(195.9,RTB,"RECS",RTBREC,0),"^",1) S:$P(RT0,"^",3)=RTBREC1 RTBST=1
 .S:RTBCNT=0 RTBST=0
 .S:$P(RT0,"^",3)=RTADMIN RTBST=1
 .S:$D(^DIC(195.1,"B","RADIOLOGY",+RTAPL)) RTBST=1
 .K RTADMIN
 Q:RTBST'=1  ;; END OF RT*2.0*37 CHANGE
 S Y=0 I RTQST'="x",RTLIST="A" S Y=1
 I RTQST'="x",RTLIST="U",'$P(RTQ0,"^",13) S Y=1
 I RTQST="x",RTLIST="U",$P(RTQ0,"^",13) S Y=1
 I RTQST="n",RTLIST="N" S Y=1
 Q:'Y  K RTINST S RTCLOC="",Y=$S($D(^RT(RT,"CL")):+$P(^("CL"),"^",5),1:0) D BOR^RTB S Y=RTCLOC
 S RTHL=$S("HD"[RTSORT:$P(RT0,"^",6),1:"RTHL")
 I RTHL="" S RTHL="AAA"
 I (RTHL'="RTHL")&(RTHL'="AAA") S RTHLP=$P(^RTV(195.9,RTHL,0),"^",2),RTHL=$P(^SC(RTHLP,0),"^",1)
 S P=$S(RTSORT="C"!(RTSORT="A")!(RTSORT="D"):$P(RTP0,"^"),1:"TDIGITS"),T=$S(RTSORT="A":$P(RTQ0,"^",4),1:"A"_RTCLOC)
 I RTSORT'="A",$P(RT0,"^")[";DPT(",$D(^DPT(+RT0,0)) S T=$P(^(0),"^",9),T="A"_$E(T,8,9)_$E(T,6,7),RTTDFL=""
 I RTDV=RTPDV S:$D(^TMP($J,"RTNEED",RTHL,P))["0" ^(P)=$S(P="TDIGITS":"",1:RTP0) S ^(P,T,RTQ)=RTQ0
BLD ;
 K C I $D(^TMP($J,"RT",RT))=0 S C=0 F Q=0:0 S Q=$O(^RTV(190.1,"AC",RT,RTDT,Q)) Q:'Q  I $D(^RTV(190.1,Q,0)) S Q0=^(0) I $P(Q0,"^",6)="r"!($P(Q0,"^",6)="n") S ^TMP($J,"RT",RT,$P(Q0,"^",4),Q)=Q0,C=C+1
 S:$D(C) ^TMP($J,"RT",RT)=C Q
 ;
