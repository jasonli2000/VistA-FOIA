YS23POST ;DALIRMFO/MJD-DELETE MEMBERS FROM YS PSYCHTEST MAIL GROUP ; 11/26/96
 ;;5.01;MENTAL HEALTH;**23**;Dec 30, 1994
 ;
 N DA,DIC,DIK,X,Y
 S DIC=3.8,DIC(0)="MZ",X="YS PSYCHTEST" D ^DIC Q:Y'>0
 I '$O(^XMB(3.8,+Y,1,0)) S X="W !!,""There are no members to delete from the YS PSYCHTEST Mail Group."",!!" X X D EXIT Q
 D ARR(+Y)
 S X=$$DM^XMBGRP(+Y,.XMY,1)
 I X=1 S X="W !!,""Deletion of YS PSCYHTEST Mail Group member(s) was successful."",!!" X X
 E  S X="W !!,""Deletion of YS PSYCHTEST Mail Group member(s) was not successful."",!!" X X
 ;
EXIT K YS,YSX,YSMGN
 QUIT
 ;
ARR(YS) ;
 S YSX=0
 F  S YSX=$O(^XMB(3.8,YS,1,YSX)) Q:YSX<1  D
 .  S YSMGN=+$G(^XMB(3.8,+Y,1,YSX,0))
 .  S XMY(YSMGN)=""
 QUIT
