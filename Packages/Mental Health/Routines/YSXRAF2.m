YSXRAF2 ; COMPILED XREF FOR FILE #602.01 ; 09/19/10
 ;
 S DA(1)=DA S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^YSA(602,DA(1),"T",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^YSA(602,DA(1),"T",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^YSA(602,DA(1),"T","B",$E(X,1,30),DA)
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^YSXRAF3
