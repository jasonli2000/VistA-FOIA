YSXRAN1 ; COMPILED XREF FOR FILE #615.7 ; 09/19/10
 ;
 S DIKZK=2
 S DIKZ(0)=$G(^YSR(615.7,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YSR(615.7,"B",$E(X,1,30),DA)
END Q
