DVBHS1 ;ALB/JLU;Print screen for screen 1;1/24/92
 ;;V4.0;HINQ;**11**;03/25/92 
 ;
 N Y
 K DVBX(1)
 F LP2=.111,.112,.113,.114,.115,.116,.117,.1112 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".111;.112;.113;.114;.115;.116;.117;.1112"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 ;
 S DVBSCRN=1 D SCRHD^DVBHUTIL
 S DVBJS=11
 K Y
 W !,DVBON,"[1]",DVBOFF X DVBLIT1
 W ?5,"Address: ",DVBDIQ(2,DFN,.111,"E") I $D(DVBADR(1)) W ?49,DVBADR(1)
 W !,?14,DVBDIQ(2,DFN,.112,"E") I $D(DVBADR(2)) W ?49,DVBADR(2)
 W !,?14,DVBDIQ(2,DFN,.113,"E") I $D(DVBADR(3)) W ?49,DVBADR(3)
 W !,?5,"   City: ",?14,DVBDIQ(2,DFN,.114,"E") I $D(DVBADR(4)) W ?49,DVBADR(4)
 W !,?5,"  State: ",?14,DVBDIQ(2,DFN,.115,"E") I $D(DVBADR(5)) W ?49,DVBADR(5)
 I $D(DVBADR(6)) W !,?49,DVBADR(6)
 W !,?5,"  ZIP+4: ",?14,DVBDIQ(2,DFN,.1112,"E")
 W !,?5,"    Zip: ",?14,DVBDIQ(2,DFN,.116,"E") I $D(DVBZIP),DVBZIP'?9" " W ?49,DVBZIP
 W !,?5," County: ",?14,DVBDIQ(2,DFN,.117,"E")
 Q
 ;