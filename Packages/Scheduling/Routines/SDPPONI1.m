SDPPONI1 ; ; 22-OCT-1993
 ;;5.3;Scheduling;**6**;AUG 13, 1993
 ; LOADS
 ;
 I $S('$D(DUZ)#2:1,'$D(DUZ(0))#2:1,1:0) W !,"DUZ and DUZ(0) must be defined to continue." K DIFQ Q
 K DIF,DIK,D,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,DFR,DTN,DIX,DZ D DT^SDPPONI2 S %=1,U="^",DSEC=1
 S NO=$P("I 0^I $D(@X)#2,X[U",U,%) I %<1 K DIFQ Q
 W !,"    PROTOCOL INSTALLATION"
 Q:'$D(DIFQ)  ;S %=0 W !!,"ARE YOU SURE YOU WANT TO CONTINUE" D YN^DICN I %-1 K DIFQ Q
 D DT^SDPPONI2 K ^UTILITY(U,$J),^UTILITY("DIK",$J) W !,"...OK, this may take a while, hold on please..." F R=1001:1:1003 D @("^SDPPO"_$E(R,2,4)) W "."
