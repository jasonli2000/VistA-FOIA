LBRYX61 ; COMPILED XREF FOR FILE #689.2 ; 03/12/96
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^LBRY(689.2,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^LBRY(689.2,"B",$E(X,1,30),DA)
END G ^LBRYX62
