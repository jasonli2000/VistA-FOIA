DVBHCE23 ; ;09/19/10
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,10),X=X S DIU=X K Y X ^DD(2,.351,1,1,1.1) X ^DD(2,.351,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.35)):^(.35),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(2,.351,1,2,1.1) X ^DD(2,.351,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D DSBULL^DGDEATH
 S X=DG(DQ),DIC=DIE
 S ^DPT("AEXP1",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 D DEATH^DGOERNOT
 S X=DG(DQ),DIC=DIE
 S XX=X,X="PSJADT" X ^%ZOSF("TEST") S X=XX K XX I  D END^PSJADT
 S X=DG(DQ),DIC=DIE
 S RCX=X,X="RCAMDTH" X ^%ZOSF("TEST") S X=RCX K RCX I  D SET^RCAMDTH
 S X=DG(DQ),DIC=DIE
 D SET^DGDEPINA
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 D START^DGMTDELS(DA)
 S X=DG(DQ),DIC=DIE
 I $$VERSION^XPDUTL("PSO")>6 D APSOD^PSOCAN3(DA)
 S X=DG(DQ),DIC=DIE
 S IVMX=X,X="IVMPXFR" X ^%ZOSF("TEST") D:$T DPT^IVMPXFR S X=IVMX K IVMX
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".351;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
 I $D(DE(20))'[0!(^DD(DP,DIFLD,"AUDIT")'="e") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
