ECX8252 ; COMPILED XREF FOR FILE #727.825 ; 11/23/09
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^ECX(727.825,DA,0))
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^ECX(727.825,"AC",$E(X,1,30),DA)=""
END Q
