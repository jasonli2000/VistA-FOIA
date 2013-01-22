DIFROMS2	;SFISC/DCL/TKW-INSTALL DD FROM SOURCE ARRAY ;12MAR2010
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	;
	;
	Q
EN	;
	I '$D(@DIFRSA) D ERR(5) Q
	I '$D(@DIFRFIA) D ERR(4) Q
	G:$G(DIFRFILE) FCHK
	S DIFRFILE=0 F  S DIFRFILE=$O(@DIFRFIA@(DIFRFILE)) Q:DIFRFILE'>0  D FILE ;LOOP THRU ALL INCOMING TOP-LEVEL FILES
	Q
FCHK	I '$D(@DIFRFIA@(DIFRFILE)) D ERR(6) Q
FILE	;
	N DIFR01,DIFR02,DIFRVR,DIFRFDD
	S DIFR01=$G(@DIFRFIA@(DIFRFILE,0,1)),DIFR02=$G(^(2))
	I $TR($E(DIFR01),"NY","ny")="n" D ERR(1) Q
	S DIFRFDD=$TR($P(DIFR01,"^",3),"FP","fp")'="p" ;DIFRFDD=0 means PARTIAL DEFINITION
	I 'DIFRFDD,'$D(^DIC(DIFRFILE)) D ERR(7) Q
	I $D(^DIC(DIFRFILE,0)),$G(@DIFRFIA@(DIFRFILE,0,10))]"" X ^(10) I '$T D ERR(3) Q
	;I $TR($E(@DIFRFIA@(DIFRFILE,0,5)),"NY","ny")="y",$D(^DIC(DIFRFILE)) D ERR(2) Q  ;INSTALL ONLY IF NEW * * PHASING OUT * *
	N %1,DSEC,D,DA,DIC,DIK,DIFRD,DIFRDATA,DIFRFLD,DIFRDIC,DIFRGL,DIFRX,I,X,Y,Z
	S DSEC=$P(DIFR02,"^") ; **>> add file security if new file only <<**
	I 'DSEC,'$D(^DIC(DIFRFILE,0))#2 S DSEC=1 ; Check to see if the file was Deleted during Pre-Install
	;delete DD wp text for file, field and x-ref description and field tech description
	;also delete "NM" nodes when installing full DD at specified level
	I 'DIFRFDD D
	.K @DIFRSA@("DIFRNI",DIFRFILE)
	.N DIFRD
	.S DIFRD=DIFRFILE
	.F  S DIFRD=$O(@DIFRFIA@(DIFRFILE,DIFRD)) Q:DIFRD'>0  D
	..Q:$$UP(DIFRSA,DIFRFILE,DIFRD)  ;abort DIFRD subfile if we can't see its parent
	..S @DIFRSA@("DIFRNI",DIFRFILE,DIFRD)=""
	..N DIFRNGF,DIFRNGFD
	..S DIFRNGF=+$G(@DIFRSA@("UP",DIFRFILE,DIFRD,-1))
	..S DIFRNGFD=.01 F  S DIFRNGFD=$O(@DIFRSA@("^DD",DIFRFILE,DIFRNGF,DIFRNGFD)) Q:DIFRNGFD=""  Q:+$P($G(^(DIFRNGFD,0)),U,2)=DIFRD
	..I DIFRNGFD'="" K @DIFRSA@("^DD",DIFRFILE,DIFRNGF,DIFRNGFD)
	..Q
	.Q
	K:DIFRFDD ^DIC(DIFRFILE,"%D")
	S DIFRD=0
	F  S DIFRD=$O(@DIFRSA@("^DD",DIFRFILE,DIFRD)) Q:DIFRD'>0  D
	.I 'DIFRFDD,$D(@DIFRSA@("DIFRNI",DIFRFILE,DIFRD)) Q
	.K:$D(@DIFRSA@("^DD",DIFRFILE,DIFRD,0,"NM"))\10 ^DD(DIFRD,0,"NM")
	.S DIFRFLD=0
	.F  S DIFRFLD=$O(@DIFRSA@("^DD",DIFRFILE,DIFRD,DIFRFLD)) Q:DIFRFLD'>0  D
	..K ^DD(DIFRD,DIFRFLD,21),^(23)
	..S DIFRX=0
	..F  S DIFRX=$O(@DIFRSA@("^DD",DIFRFILE,DIFRD,DIFRFLD,1,DIFRX)) Q:DIFRX'>0  D
	...K ^DD(DIFRD,DIFRFLD,1,DIFRX,"%D")
	...Q
	..Q
	.Q
	I DIFRFDD F DIFRX="^DIC","^DD" D
	.;I DIFRX="^DIC",'DIFRFDD Q
	.N X
	.I DIFRX="^DIC",$G(^DIC(DIFRFILE,0))]"" S X=$P(^(0),"^",3,9)
	.M @DIFRX=@DIFRSA@(DIFRX,DIFRFILE)
	.I DIFRX="^DIC",$G(X)]"" S $P(^DIC(DIFRFILE,0),"^",3,9)=X
	.I DSEC,$D(@DIFRSA@("SEC",DIFRX,DIFRFILE)) M @DIFRX=@DIFRSA@("SEC",DIFRX,DIFRFILE)
	.Q
	I 'DIFRFDD D
	.N DIFRD
	.S DIFRD=0
	.F  S DIFRD=$O(@DIFRSA@("^DD",DIFRFILE,DIFRD)) Q:DIFRD'>0  D
	..I $D(@DIFRSA@("DIFRNI",DIFRFILE,DIFRD)) Q  ;ABORT
	..M ^DD(DIFRD)=@DIFRSA@("^DD",DIFRFILE,DIFRD) ;HERE IS WHERE A WHOLE DD COMES OVER!
SETUP	..I $G(@DIFRSA@("UP",DIFRFILE,DIFRD,-1)) S ^DD(DIFRD,0,"UP")=+^(-1) ;SET THE "UP" NODE, SINCE IT SEEMS NOT TO BE SENT WITH THE REST OF THE ^DD
	..I DSEC,$D(@DIFRSA@("SEC","^DD",DIFRFILE,DIFRD)) M ^DD(DIFRD)=@DIFRSA@("SEC","^DD",DIFRFILE,DIFRD)
	..Q
	.Q
	S DIFRD=0 F  S DIFRD=$O(@DIFRFIA@(DIFRFILE,DIFRD)) Q:DIFRD'>0  D
	.I 'DIFRFDD,$D(@DIFRSA@("DIFRNI",DIFRFILE,DIFRD)) Q
	.S D=DIFRD,DIK="A" F  S DIK=$O(^DD(D,DIK)) Q:DIK=""  K ^(DIK)
	.S DA(1)=D,DIK="^DD("_D_"," D IXALL^DIK
	.I $D(^DIC(D,"%",0)) S DIK="^DIC(D,""%""," D IXALL^DIK
	.Q
	I 'DIFRFDD D  G IXKEY
	.Q:'$D(@DIFRSA@("^DD",DIFRFILE,DIFRFILE,.01))
	.S $P(@(^DIC(DIFRFILE,0,"GL")_"0)"),"^",2)=$$HDR2P^DIFROMSS(DIFRFILE)
	.Q
	S DIFRGL=^DIC(DIFRFILE,0,"GL"),DIFRDIC=$P(^DIC(DIFRFILE,0),U,1,2)
	S $P(DIFRDIC,"^",2)=@DIFRFIA@(DIFRFILE,0,0)
	I DIFRFDD,+$G(@DIFRFIA@(DIFRFILE,0,"VR")) S DIFRVR=^("VR") D
	.S ^DD(DIFRFILE,0,"VR")=$P(DIFRVR,"^")
	.S ^DD(DIFRFILE,0,"VRPK")=$P(DIFRVR,"^",2)
	.Q
	S DIFRDATA=$D(@(DIFRGL_"0)")),^(0)=DIFRDIC_"^"_$S(DIFRDATA#2:$P(^(0),"^",3,9),1:"^")
	;
IXKEY	; Bring INDEX and KEY entries
	K ^TMP("DIFROMS2",$J,"TRIG")
	S DIFRD=0
	F  S DIFRD=$O(@DIFRSA@("IX",DIFRFILE,DIFRD)) Q:'DIFRD  D DDIXIN^DIFROMSX(DIFRFILE,DIFRD,DIFRSA)
	K ^TMP("DIFROMS2",$J,"TRIG")
	S DIFRD=0
	F  S DIFRD=$O(@DIFRSA@("KEY",DIFRFILE,DIFRD)) Q:'DIFRD  D DDKEYIN^DIFROMSY(DIFRFILE,DIFRD,DIFRSA)
	;
DIKZ	I $D(^DD(DIFRFILE,0,"DIK")) D
	.N %X,DIKJ,DIR,DMAX,X,Y,DIFRDIKA
	.D EN2^DIKZ(DIFRFILE,"",^DD(DIFRFILE,0,"DIK"),^DD("ROU"),"DIFRDIKA")
	.I $D(DIFRDIKA) M @DIFRSA@("DIKZ",DIFRFILE)=DIFRDIKA
	.S @DIFRSA@("DIKZ",DIFRFILE)=^DD(DIFRFILE,0,"DIK")
	.Q
	I 'DIFRFDD,$D(@DIFRSA@("DIFRNI",DIFRFILE)) D
	.N DIFRD
	.S DIFRD=0
	.F  S DIFRD=$O(@DIFRSA@("DIFRNI",DIFRFILE,DIFRD)) Q:DIFRD'>0  D
	..N DIFRERR S DIFRERR(1)=DIFRD
	..D BLD^DIALOG(9512,.DIFRERR) ;"parent DD(s) missing"
	..Q
	.Q
	Q
	;
UP(ROOT,FILE,DDN)	;Return 1 or 0 to install
	Q:FILE=DDN 1
	Q:$D(^DD(DDN)) 1
	Q:'$D(@ROOT@("UP",FILE,DDN)) 1
	N MP,PARENT,T,X
	S MP=0,X="",T=0
	F  S X=$O(@ROOT@("UP",FILE,DDN,X)) Q:X=""  S PARENT=+^(X) D  Q:T!(MP)
	.I $D(^DD(PARENT))!$D(@ROOT@("FIA",FILE,PARENT)) S:X>-2 T=1 Q  ;***GFT
	.S MP=1
	.Q
	Q T
	;
ERR(X)	D BLD^DIALOG($P($T(ERR+X),";",5)) Q
	;;FIA Node Is Set To "No DD Update";1;9503
	;;Already Exist On Target System (INSTALL ONLY IF NEW);2;9504
	;;Did Not Pass DD Screen;3;9505
	;;FIA Array Does Not Exist;4;9511
	;;Distribution Array Does Not Exist;5;9506
	;;FIA File Number Invalid;6;9507
	;;Partial DD/File Does Not Already Exist On Target System;7;9508
