DIX	;SFISC/GFT,NHRC/DRH-STATISTICS ;05:46 PM  16 Dec 1999
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	S DIK="^DOPT(""DIX"","
	G F:$D(^DOPT("DIX",3)) S ^(0)="STATISTICAL ROUTINE^1.01^" F I=1:1:3 S ^DOPT("DIX",I,0)=$E($T(F+I),4,99)
	D IXALL^DIK
F	S DIC=DIK,DIC(0)="AEQZ" D ^DIC Q:Y<0  D @($P(Y(0),U,2,3)) W !! G DIX
	;;DESCRIPTIVE STATISTICS^D^DIXC
	;;SCATTERGRAM^^DIG
	;;HISTOGRAM^^DIH
	;;ESTIMATED LINEAR CORRELATION COEFFICIENTS^C^DIX2
	;;COEFFICIENTS OF DETERMINATION^D^DIX2
	;;RANDOM SAMPLE - DESCRIPTIVE STATISTICS^RS^DIX3
	;;GENERATE RANDOM NUMBERS (WITH REPLACEMENT)^R^DIX3
DHDR	;
	S:$D(^%ZTSK) %ZIS="Q" D ^%ZIS Q:POP!$D(IO("Q"))
DQ	U IO S:+DHDR'=0 DIXMM=+DHDR S:'$D(DHDR) DHDR="" I DHDR="" G HDR
	I $E(IOST)="C" S DIFF=1
SITE	W:$D(DIFF)&($Y) @IOF S DIFF=1 W:$D(^DD("SITE"))&(DHDR["S") !,"(",^("SITE"),")"
	I $D(DIC) I DHDR["F",@("$D("_DIC_"0))") W "  ",$P(^(0),U,1)," FILE"
	I $D(DUZ)#2,DHDR["U",$S($D(^VA(200,+DUZ,0)):1,1:$D(^DIC(3,+DUZ,0))) W "  USER: ",$P(^(0),U,1)," "
	W ?(DIXMM-(DHDR["T"*10)-($D(PG)*10)-18) ;**CCO/NI ALLOW SPACE AT RIGHT
DT	W $$DATE^DIUTL(DT) I $D(PG) W "  ",$$EZBLD^DIALOG(7095,PG) S PG=PG+1 ;**CCO/NI  DATE FORMAT AND PAGE
HDR	F J=1:1 Q:'$D(DHDR(J))  W !?(DHDR["C"*(DIXMM-$L(DHDR(J))\2)),$E(DHDR(J),1,DIXMM)
	W ! Q:DHDR'["L"
LINE	F %=1:1:DIXMM W "-"
	W ! Q
