YSXRAA1 ; COMPILED XREF FOR FILE #600.7 ; 11/30/04
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^YSG("CNT",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YSG("CNT","B",$E(X,1,30),DA)
END G ^YSXRAA2
