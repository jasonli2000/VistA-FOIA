MCARLV ;WISC/RMP-MEDICINE PACKAGE ECHO LVINDEX ;7/12/96  14:20
 ;;2.3;Medicine;;09/13/1996
 S MCDX=+$G(DA)
 S:'MCDX MCDX=D0
 S MCX=$S($D(^MCAR(691,MCDX,4)):^(4),1:"")
 S MCSEP=$P(MCX,U),MCPWALL=$P(MCX,U,2),MCLVD=$P(MCX,U,7)
 S MCBSA=$P($G(^MCAR(691,MCDX,13)),U,3)
 S DFN=$P(^MCAR(691,MCDX,0),U,2) D DEM^VADPT S MCSEX=$S($D(VADM(5)):$P(VADM(5),U,2),1:""),X=""
 I MCBSA>0,MCSEP>0,MCPWALL>0,MCLVD>0,MCSEX'="" G CALC
 I MCSEP>0,MCPWALL>0,MCLVD>0 G CALC2
EXIT ;
 K MCBSA,MCSEP,MCPWALL,MCLVD,MCX,MCINDEX,MCSEX
 Q
CALC ;
 S X=MCSEP+MCPWALL+MCLVD/10 D CUBE S MCINDEX=X
 S X=MCLVD/10 D CUBE S MCINDEX=MCINDEX-X*1.05
 S MCINDEX=$S(MCSEX="MALE":.93*MCINDEX-17.92,MCSEX="FEMALE":.88*MCINDEX-9,1:"")
 ; DAD 7-12-96 I MCINDEX'="" S MCINDEX=MCINDEX/MCBSA,MCINDEX=$J(MCINDEX,3,2),$P(^MCAR(691,MCDX,13),U,6)=MCINDEX
 S X="" I MCINDEX'="" S MCINDEX=MCINDEX/MCBSA,(X,MCINDEX)=$J(MCINDEX,3,2)
 G EXIT
CUBE ;
 S X=X*X*X Q
CALC2 ;
 S X=MCSEP+MCPWALL+MCLVD/10 D CUBE
 G EXIT
