YSXRAD1 ; COMPILED XREF FOR FILE #601.3 ; 09/19/10
 ;
 S DIKZK=2
 S DIKZ(0)=$G(^YTT(601.3,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YTT(601.3,"B",$E(X,1,30),DA)
END Q
