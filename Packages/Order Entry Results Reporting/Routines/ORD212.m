ORD212 ; COMPILED XREF FOR FILE #100.008 ; 09/17/08
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^OR(100,DA(1),8,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^OR(100,DA(1),8,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" N ORDA S ORDA=DA(1) D ACT1^ORDD100A(ORDA,DA)
 S X=$P(DIKZ(0),U,1)
 I X'="" N X1,X2 S X1=DA(1),X2=DA D SET^ORDD100(X1,X2)
 S X=$P(DIKZ(0),U,1)
 I X'="" N ORDA S ORDA=DA(1) D S1^ORDD100(ORDA,DA,"",X)
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^OR(100,"AF",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^OR(100,DA(1),8,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,4)
 I X'="" N ORDA S ORDA=DA(1) D S1^ORDD100(ORDA,DA)
 S X=$P(DIKZ(0),U,16)
 I X'="" N ORDER S ORDER=DA(1) D RS^ORDD100(ORDER,DA,,X)
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^ORD213
