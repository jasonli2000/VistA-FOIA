DGMTXX33 ; COMPILED XREF FOR FILE #408.31 ; 06/24/93
 ; 
 I X'="" X ^DD(408.31,.03,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DGMT(408.31,D0,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(408.31,.03,1,3,1.4)
 S X=$P(DIKZ(0),U,16)
 I X'="" S ^DGMT(408.31,"AP",X,$P(^DGMT(408.31,DA,0),U),DA)=""
END Q
