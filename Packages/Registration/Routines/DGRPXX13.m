DGRPXX13 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 I X'="" X ^DD(2,.3025,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,1.4)
 S X=$P(DIKZ(.3),U,10)
 I X'="" S ^DPT("ACB",$E(X,1,30),DA)=""
 S DIKZ(.311)=$S($D(^DPT(DA,.311))#2:^(.311),1:"")
 S X=$P(DIKZ(.311),U,15)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I "^3^9^"[$P(^DPT(DA,.311),U,15) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.311)):^(.311),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.31115,1,2,1.4)
 S DIKZ(.321)=$S($D(^DPT(DA,.321))#2:^(.321),1:"")
 S X=$P(DIKZ(.321),U,1)
 I X'="" X ^DD(2,.32101,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,4) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32101,1,1,1.4)
 S X=$P(DIKZ(.321),U,1)
 I X'="" X ^DD(2,.32101,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,5) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32101,1,2,1.4)
 S X=$P(DIKZ(.321),U,1)
 I X'="" X ^DD(2,.32101,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X="N" X ^DD(2,.32101,1,3,1.4)
 S X=$P(DIKZ(.321),U,2)
 I X'="" X ^DD(2,.32102,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,7) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32102,1,1,1.4)
 S X=$P(DIKZ(.321),U,2)
 I X'="" X ^DD(2,.32102,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,9) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32102,1,2,1.4)
 S X=$P(DIKZ(.321),U,2)
 I X'="" X ^DD(2,.32102,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,10) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32102,1,3,1.4)
 S X=$P(DIKZ(.321),U,2)
 I X'="" S DFN=DA D EN^DGMTR K DGREQF
 S X=$P(DIKZ(.321),U,3)
 I X'="" X ^DD(2,.32103,1,1,1.3) I X S X=DIV S Y(2)=";"_$S($D(^DD(2,.3212,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P($P(Y(2),";"_$P(Y(1),U,12)_":",2),";",1) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32103,1,1,1.4)
 S X=$P(DIKZ(.321),U,3)
 I X'="" X ^DD(2,.32103,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,11) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32103,1,2,1.4)
 S X=$P(DIKZ(.321),U,3)
 I X'="" S DFN=DA D EN^DGMTR K DGREQF
 S DIKZ(.322)=$S($D(^DPT(DA,.322))#2:^(.322),1:"")
 S X=$P(DIKZ(.322),U,10)
 I X'="" X ^DD(2,.32201,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(2,.32201,1,1,1.4)
 S X=$P(DIKZ(.322),U,10)
 I X'="" X ^DD(2,.32201,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(2,.32201,1,2,1.4)
 S X=$P(DIKZ(.322),U,1)
 I X'="" X ^DD(2,.3221,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.3221,1,1,1.4)
 S X=$P(DIKZ(.322),U,1)
 I X'="" X ^DD(2,.3221,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3221,1,2,1.4)
 S X=$P(DIKZ(.322),U,4)
 I X'="" X ^DD(2,.3224,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(2,.3224,1,1,1.4)
 S X=$P(DIKZ(.322),U,4)
 I X'="" X ^DD(2,.3224,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(2,.3224,1,2,1.4)
 S X=$P(DIKZ(.322),U,7)
 I X'="" X ^DD(2,.3227,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(2,.3227,1,1,1.4)
 S X=$P(DIKZ(.322),U,7)
 I X'="" X ^DD(2,.3227,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.322)):^(.322),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X="" X ^DD(2,.3227,1,2,1.4)
 S DIKZ(.32)=$S($D(^DPT(DA,.32))#2:^(.32),1:"")
 S X=$P(DIKZ(.32),U,3)
 I X'="" S ^DPT("APOS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(.32),U,3)
END G ^DGRPXX14
