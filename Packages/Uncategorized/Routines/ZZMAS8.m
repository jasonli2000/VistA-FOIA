ZZMAS8 ; ;04/12/09
 S X=DG(DQ),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
 S X=DG(DQ),DIC=DIE
 D SET^DGREGDD1(DA,.1112,.11,12,X)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.11)):^(.11),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X=DIV S X=$$NOW^XLFDT() S DIH=$G(^DPT(DIV(0),.11)),DIV=X S $P(^(.11),U,13)=DIV,DIH=2,DIG=.118 D ^DICR
