DGYRONI2 ; ; 15-MAR-1995
 ;;5.3;Registration;**45**;Aug 13, 1993
 ;
 ;
 K ^UTILITY("ORVROM",$J),DIC
 Q
DT W !
 I '$D(DTIME) S DTIME=999
 K %DT D NOW^%DTC S DT=X
 K DIK,DIC,%I,DICS Q
 ;
