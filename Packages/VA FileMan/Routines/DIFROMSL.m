DIFROMSL(DIFRDD) ;SFISC/DCL-DIFROM SELECT FIELD FROM DD ;08:37 AM  6 Sep 1994
 ;;22.0;VA FileMan;;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Select field from DD
 N D0,D1,D2,D3,DA,DIC,DO,DIE,%,C,DC,DH,DI,DIA,DR,DIEL,DILK,DIOV,DIP,DK,DL,DM,DP,DQ,DSC,DV,DW,DXS,Y
 S DIC="^DD("_DIFRDD_",",DIC(0)="AEMQ"
 D ^DIC
 S X=+Y
