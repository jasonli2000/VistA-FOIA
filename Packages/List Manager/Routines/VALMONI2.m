VALMONI2 ; ; 13-AUG-1993
 ;;1;List Manager;;Aug 13, 1993
 ;
 ;
 K ^UTILITY("ORVROM",$J),DIC
 Q
DT W !
 I '$D(DTIME) S DTIME=999
 K %DT D NOW^%DTC S DT=X
 K DIK,DIC,%I,DICS Q
 ;
