DDSR	;SFISC/MKO-PAINT ;22DEC2011
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
R	;All pages
	;Called after wp, mults, & deletions
	F DDSSC=1:1:DDSSC D RP(DDSSC(DDSSC),DDSSC=1)
	Q
	;
RP(X,DDS3LIN)	;Paint page
	; X       = DDSSC(DDSSC) node
	; DDS3LIN = paint bottom line
	;
	S DDS3P=$P(X,U),DDS3UL=$P(X,U,2),DDS3LR=$P(X,U,3)
	I DDS3UL="" W $P(DDGLCLR,DDGLDEL,2)
	E  D ^DDSBOX(DDS3UL,DDS3LR)
	;
	;Write caps in "X" nodes
	D CAP^DDSR1
	;
	;Paint data & exec caps
	;Hdr blk
	S DDS3B=$P($G(^DIST(.403,+DDS,40,DDS3P,0)),U,2)
	D:DDS3B]"" DB(DDS3P,DDS3B)
	;
	;Other blks
	S DDS3BO="" F  S DDS3BO=$O(^DIST(.403,+DDS,40,DDS3P,40,"AC",DDS3BO)) Q:'DDS3BO  S DDS3B=$O(^(DDS3BO,"")) Q:'DDS3B  D DB(DDS3P,DDS3B)
	K DDS3B,DDS3BO
	;
	I DDS3LIN D
	. S DDSH=1,DX=0,DY=DDSHBX X IOXY W $TR($J("",IOM-1)," ","_") ;WRITE ____ LINE SO WE ARE AT LAST (80TH) COLUMN POSITION
	.I DDS3UL]"" S DY=DY+1 X IOXY W $P(DDGLCLR,DDGLDEL,3) N Y F Y=DY:1:IOSL K DDSMOUSE(Y)
	K DDS3P,DDS3UL,DDS3LR
	Q
	;
DB(DDS3P,DDS3B)	;Paint data
	K @DDSREFT@("XCAP",DDS3P,DDS3B)
	S DDS3=@DDSREFS@(DDS3P,DDS3B)
	S DDS3FN="F"_$P(DDS3,U,3),DDS3REP=$P(DDS3,U,7),DDS3PTB=$P(DDS3,U,8)
	K DDS3
	;
	I $G(DDS3REP)'>1 D
	. N DIE
	. S DDS3DA=$G(@DDSREFT@(DDS3P,DDS3B))
	. S:DDS3DA]"" DIE=$G(@DDSREFT@(DDS3P,DDS3B,DDS3DA,"GL"))
	. S DDS3DDO=0
	. F  S DDS3DDO=$O(@DDSREFS@(DDS3P,DDS3B,DDS3DDO)) Q:DDS3DDO'=+DDS3DDO  S DDS3C=$G(^(DDS3DDO,"D")) D:DDS3C]"" DF(DDS3P,DDS3B,DDS3DDO,DDS3DA,DDS3C,DDS3FN,DDS3PTB)
	. K DDS3C,DDS3DA,DDS3DDO
	E  D DMULT(DDS3P,DDS3B,DDS3FN)
	;
	K DDS3FN,DDS3PTB,DDS3REP
	Q
	;
DMULT(DDS3P,DDS3B,DDS3FN)	;Paint data, all lines
	N X,DIE
	S DDS3PDA=$P($G(@DDSREFT@(DDS3P,DDS3B)),U)
GFT	I '$D(^(DDS3B,"COMP MUL")),'DDS3PDA  D
	. S X="",DDS3STL=1
	. S DDS3NREP=$P(@DDSREFS@(DDS3P,DDS3B),U,7),DDS3SEL=$P(^(DDS3B),U,10)
	E  D
	. S X=@DDSREFT@(DDS3P,DDS3B,DDS3PDA)
	. S DDS3STL=$P(X,U,3),DDS3NREP=$P(X,U,6),DDS3SEL=$P(X,U,9) ;3RD PIECE SAYS WHICH LINE IS NOW TOP LINE
	S DIE=$G(@DDSREFT@(DDS3P,DDS3B,DDS3PDA,"GL"))
	;
	F DDS3LN=1:1:DDS3NREP D  ;PAINT LINES ONE BY ONE
	. S DDS3SN=DDS3LN+DDS3STL-1
	. S DDS3DA=$G(@DDSREFT@(DDS3P,DDS3B,DDS3PDA,DDS3SN))
	. S:DDS3LN=1 DDS3MORE=$S(DDS3STL>1:"+",1:" ") ;IF 1ST LINE ISN'T REALLY FIRST
LAST	. I DDS3LN=DDS3REP S DDS3MORE=" " I $D(@DDSREFT@(DDS3P,DDS3B,DDS3PDA,DDS3SN+1))#2 S DDS3MORE="+",DDS3MORE("LAST")=1 ;IF LAST LINE ISN'T REALLY LAST
	. D DMULT1(DDS3P,DDS3B,DDS3FN,DDS3DA,DDS3LN,DDS3SN,.DDS3MORE,DDS3SEL)
	. K DDS3MORE
	;
	K DDS3DA,DDS3LN,DDS3NREP,DDS3PDA,DDS3SEL,DDS3SN,DDS3STL
	Q
	;
DMULTN(DDS3P,DDS3B,DDS3PDA,DDS3REP,DDS3LN)	;Paint lines from DDS3LN
	S DDS3FN="F"_$P(@DDSREFS@(DDS3P,DDS3B),U,3)
	S DDS3STL=$P(@DDSREFT@(DDS3P,DDS3B,DDS3PDA),U,3),DDS3SEL=$P(^(DDS3PDA),U,9)
	F DDS3LN=DDS3LN:1:DDS3REP D
	. S DDS3SN=DDS3LN+DDS3STL-1
	. S DDS3DA=$G(@DDSREFT@(DDS3P,DDS3B,DDS3PDA,DDS3SN))
	. S:DDS3LN=1 DDS3MORE=$S(DDS3STL>1:"+",1:" ")
	. S:DDS3LN=DDS3REP DDS3MORE=$S($D(@DDSREFT@(DDS3P,DDS3B,DDS3PDA,DDS3SN+1))#2:"+",1:" ")
	. D DMULT1(DDS3P,DDS3B,DDS3FN,DDS3DA,DDS3LN,DDS3SN,.DDS3MORE,DDS3SEL)
	. K DDS3MORE
	K DDS3DA,DDS3FN,DDS3LN,DDS3SEL,DDS3SN,DDS3STL
	Q
	;
DMULT1(DDS3P,DDS3B,DDS3FN,DDS3DA,DDS3LN,DDS3SN,DDS3MORE,DDS3SEL)	;Paint 1 line, LINE DDS3LN
	N DDSHITE S DDSHITE=$$HITE(DDS3B),DDS3DDO=0
	F  S DDS3DDO=$O(@DDSREFS@(DDS3P,DDS3B,DDS3DDO)) Q:DDS3DDO'=+DDS3DDO  S DDS3C=$G(^(DDS3DDO,"D")) I DDS3C]"" D  ;go thru fields in the multiple
	. S $P(DDS3C,U)=$P(DDS3C,U)+(DDS3LN-1*DDSHITE) ;DJW/GFT
	. S:$P(DDS3C,U,5)]"" $P(DDS3C,U,5)=$P(DDS3C,U,5)+(DDS3LN-1*DDSHITE) ;DJW/GFT
	. I $D(DDS3MORE),DDS3SEL=DDS3DDO,$P(DDS3C,U)?1.N D
	.. S DY=+DDS3C,DX=$P(DDS3C,U,2)-1 Q:DX<0
PLUSSIGN	.. X IOXY D
	...I DDS3MORE="+" S DDSMOUSE(DY,DX,DX)=$S($D(DDS3MORE("LAST")):"NP",1:"PP") I $G(DDSMOUSY) S DDS3MORE=$$HIGH^DDSU(DDS3MORE)
	...W DDS3MORE
	. D DF(DDS3P,DDS3B,DDS3DDO,DDS3DA,DDS3C,DDS3FN,1,DDS3LN,DDS3SN) ;7TH parameter says ALWAYS PAINT AREA even if value is null
	K DDS3C,DDS3DDO
	Q
	;
HITE(BLK)	N D,Z,H,L,F S D=1,H=1,L=999 F F=0:0 S F=$O(^DIST(.404,BLK,40,F)) Q:'F  S Z=$G(^(F,2)) D
	.I 'Z S Z=$P(Z,U,3) ;MIGHT BE JUST A CAPTION
	.I Z S:Z<L L=Z S:Z>H H=Z S D=H-L+1 ;GFT
	Q D
	;
	;
DF(DDS3P,DDS3B,DDS3DDO,DDS3DA,DDS3C,DDS3FN,DDS3FLG,DDS3LN,DDS3SN)	;
	;Paint field
	N DDS3FLD,DDS3LEN,DDSX
	D:$P(DDS3C,U,5)]"" XCAP
	;
	S DY=+DDS3C,DX=$P(DDS3C,U,2)
	S DDS3LEN=$P(DDS3C,U,3),DDS3FLD=$P(DDS3C,U,4)
	;
	;Computed flds
	I DDS3DA]"",$P(DDS3C,U,9) S DDSX=$$VAL^DDSCOMP(DDS3DDO,DDS3B,DDS3DA)
	;
	;Form only flds
	Q:DDS3FLD=""
	I DDS3FLD'=+DDS3FLD N DDS3FN S DDS3FN="F0"
	;
	;External form
	S:DDS3FLD DDSX=$S(DDS3DA="":"",$D(@DDSREFT@(DDS3FN,DDS3DA,DDS3FLD,"X"))#2:^("X"),1:$G(^("D")))
PAINT	D  ;I $G(DDSX)]""!$G(DDS3FLG) D   PAINT NULL FIELD TO SHOW COLOR
	.I DDS3LEN=1,DDS3DA]"",DDS3FLD,$G(@DDSREFT@(DDS3FN,DDS3DA,DDS3FLD,"M"))?1"0^".E D
	..N WP S WP=$P(^("M"),U,2) I WP["(" S WP=U_$$CREF^DILF(WP_0),WP=$P($G(@WP),U,3) I WP S DDSX="+" ;SHOW THAT WP FIELD HAS SOME DATA
	. S:$D(DDSX)[0 DDSX=""
	. X IOXY
	. I '$P(DDS3C,U,10) S DDSX=$E(DDSX,1,DDS3LEN)_$J("",DDS3LEN-$L(DDSX))
	. E  S DDSX=$J("",DDS3LEN-$L(DDSX))_$E(DDSX,1,DDS3LEN)
	. W $P(DDGLVID,DDGLDEL)_DDSX_$P(DDGLVID,DDGLDEL,10)
	Q
	;
XCAP	;Paint exec caps
	N Y,DDSLN,DDSSN
	I 'DDS3DA N DA,D0 S (DA,D0)=""
	;
	I DDS3DA N DDSDL S DDSDL=$L(DDS3DA,",")-2
	I  N DA,@$$D0^DDS(DDSDL)
	I  D BLDDA^DDS(DDS3DA)
	;
	S DDS3TP=$P($G(@DDSREFS@(DDS3P,DDS3B)),U,5)
	S DDS3L0=$G(^DIST(.404,DDS3B,40,DDS3DDO,0)) G:DDS3L0?."^" XCAPQ
	S DDS3L01=$G(^DIST(.404,DDS3B,40,DDS3DDO,.1)) G:DDS3L01?."^" XCAPQ
	;
	S:$D(DDS3LN) DDSLN=DDS3LN
	S:$D(DDS3SN) DDSSN=DDS3SN
	;
	X DDS3L01 G:$G(Y)="" XCAPQ
	S DDS3CAP=Y
	;
	I DDS3TP="e","^2^3^"[(U_$P(DDS3L0,U,3)_U)!'$P(DDS3L0,U,3) D
	. S Y=$$UP^DILIBF(Y) ;**
	. S @DDSREFT@("XCAP",DDS3P,Y,DDS3B,DDS3DDO)=""
	;
	S DY=$P(DDS3C,U,5),DX=$P(DDS3C,U,6)
	S DDS3CAP=DDS3CAP_$P(DDS3C,U,7)
	S:$P(DDS3C,U,8) DDS3CAP=$P(DDGLVID,DDGLDEL,4)_DDS3CAP_$P(DDGLVID,DDGLDEL,10)
	X IOXY W DDS3CAP
XCAPQ	K DDS3CAP,DDS3L0,DDS3L01,DDS3TP
	Q
