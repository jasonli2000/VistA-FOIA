DICA	;SEA/TOAD-VA FileMan, Updater, Engine ;18APR2009
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	;
ADD(DIFLAGS,DIFDA,DIEN,DIMSGA)	;
	;
ADDX	; Branch in from UPDATE^DIE
	; ENTRY POINT--add a new entry to a file
	; subroutine, DIEN passed by reference
	I '$D(DIQUIET) N DIQUIET S DIQUIET=1
	I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
	N DICLERR S DICLERR=$G(DIERR) K DIERR
INPUT	;
	; initialize input parameters & check
	N DIRULE S DIRULE=$$GETTMP^DIKC1("DICA")
	N DIFDAO
	S DIFLAGS=$G(DIFLAGS)
	I $TR(DIFLAGS,"EKSUY")'="" D  Q
	. D ERR^DICA3(301,"","","",DIFLAGS),CLOSE
	S DIFDA=$G(DIFDA) I $D(@DIFDA)<10 D  Q
	. D ERR^DICA3(202,"","","","FDA"),CLOSE
	S DIFDAO=DIFDA
	S DIEN=$G(DIEN) I DIEN="" S DIEN="DIDUMMY" N DIDUMMY
PRE	;
	N DIOK S DIOK=1 D CHECK^DICA1(DIFLAGS,.DIFDA,DIEN,DIRULE,.DIOK)
	I $G(DIERR) D CLOSE Q
	I 'DIOK D ERR^DICA3(202,"","","","FDA"),CLOSE Q
SEQ	;
	N DICHECK,DIENTRY,DIFILE,DIOUT1,DINEXT
	S (DIOUT1,DINEXT)="" F  D  Q:DIOUT1
	. S DINEXT=$O(@DIRULE@("NEXT",DINEXT)) I DINEXT="" S DIOUT1=1 Q
	. X @DIRULE@("NEXT",DINEXT)
FILES	. ;
	. I $P($G(^DD($$FNO^DILIBF(DIFILE),0,"DI")),U,2)["Y" D  Q:DIOUT1  ;Entries in file cannot be edited.
	. . S DIOUT1=DIFLAGS'["Y"&'$D(DIOVRD)
	. . I DIOUT1 D ERR^DICA3(405,DIFILE,"","",DIFILE)
ENTRIES	. ;
	. N DIDA,DIENP,DIOP,DIROOT,DISEQ
	. S DIDA=$P(DIENTRY,",") I +DIDA=DIDA Q
	. S DIENP=$$IEN(DIENTRY,"",DIRULE)
	. S DIOP=$E(DIDA,1,2) I DIOP'="?+" S DIOP=$E(DIOP)
	. S DISEQ=$P(DIDA,DIOP,2)
FINDING	. ;
	. ; Finding (?) or LAYGO/FInding (?+) nodes
	. I DIOP["?" D  Q
	. . I DIOP="?+",DIENP[",," S @DIRULE@("NEXTADD",DINEXT)=@DIRULE@("NEXT",DINEXT) Q
	. . N DIFIND,DIFORMAT,DIGET,DIINDEX,DIVALUE
	. . S DIFORMAT="B"_$S(DIFLAGS["E":"",1:"Q")_$S(DIOP="?+":"X",1:"")
	. . S DIGET=DIFDA
	. . I DIFLAGS["E",DIOP["?" S DIGET=DIFDAO
	. . I DIFLAGS["K",$D(^TMP("DIKK",$J,"P",DIFILE))#2 D
	. . . D GETKVALS(.DIVALUE,.DIINDEX)
	. . E  S DIVALUE=$G(@DIGET@(DIFILE,DIENTRY,.01))
	. . S DIFIND=$$FIND1^DIC(DIFILE,DIENP,DIFORMAT,.DIVALUE,$G(DIINDEX))
	. . I $G(DIERR) S DIOUT1=1 Q
	. . I DIOP="?+",'DIFIND S @DIRULE@("NEXTADD",DINEXT)=@DIRULE@("NEXT",DINEXT) Q
	. . I 'DIFIND S DIOUT1=1 D  Q
	. . . I $D(DIVALUE)=10 N I,Q S DIVALUE="",(I,Q)=0 F  S I=$O(DIVALUE(I)) Q:'I  D  Q:Q
	. . . . Q:DIVALUE(I)=""
	. . . . S:DIVALUE]"" DIVALUE=DIVALUE_";"
	. . . . I $L(DIVALUE)+$L(DIVALUE(I))>252 D
	. . . . . S DIVALUE=$E(DIVALUE,1,252)_$E(DIVALUE(I),1,252-$L(DIVALUE))_"..."
	. . . . . S Q=1
	. . . . E  S DIVALUE=$G(DIVALUE)_$E(DIVALUE(I),1,251)
	. . . D ERR^DICA3(703,DIFILE,DIENTRY,"",DIVALUE)
	. . S @DIEN@(DISEQ)=DIFIND
	. . I DIOP="?+" S @DIEN@(DISEQ,0)="?"
	. . S @DIRULE@("IEN",DISEQ)=DIFIND
	. . I DIFLAGS["K",$D(^TMP("DIKK",$J,"P",DIFILE)) D SAVEK Q
	. . D SAVE
	. ; Adding (+) nodes
	. I '$G(DICHECK) S DICHECK=1 D ADDLF S:DIENP[",," DIENP=$$IEN(DIENTRY,"",DIRULE) I $G(DIERR) S DIOUT1=1 Q
	. D ADDING
	;
FILER	; file the data for the new records
	I '$G(DIERR),$D(@DIFDA) D
	. I '$G(DICHECK) D ADDLF Q:$G(DIERR)!'$D(@DIFDA)  ;QUITS HERE WHEN KEY IS BAD!
	.K ^TMP("DIKK",$J,"L") D FILE^DIEF($E("S",DIFLAGS["S")_"U",DIFDA,"",DIEN) ;GFT  Artf8720:recursive UPDATE^DIE call would look at KEY
	I '$G(DIERR),DIFLAGS'["S" K @DIFDAO
	I $G(DIERR)!(DIFLAGS["S"),DIFLAGS'["E" D
	. M @DIFDA=@DIRULE@("SAVE")
	D CLOSE
	Q
	;
ADDING	;
	N DIENEW,DIKEY
	I $L(DIENP,",")>2 S DIOK=$$VMINUS9^DIEFU(DIFILE,DIENP) I 'DIOK D  Q
	. S DIOUT1=1
	. D ERR^DICA3(602,DIFILE,$P(DIENP,",",$L(DIENP,",")-1))
	S DIROOT=$$ROOT^DIQGU(DIFILE,DIENP)
	D DA^DILF(DIENTRY,.DIENEW)
A1	S DIENEW=$$IEN(DIENTRY,$G(@DIEN@(DISEQ)),DIRULE)
	S DIKEY=$G(@DIFDA@(DIFILE,DIENTRY,.01)) I DIKEY="" D  Q
	. S DIOUT1=1 D ERR^DICA3(202,"","","","FDA")
	S DIOK=$$LAYGO(DIFILE,.DIENEW,DIKEY)
	I 'DIOK S DIOUT1=1 D  Q
	. I '$G(DIERR) D ERR^DICA3(405,DIFILE,"","",DIFILE) Q
	. N DIENS S DIENS="New entry"
	. I $L(DIENEW,",")>2 S DIENS=DIENS_" under record: "_DIENEW
	. N DI1 S DI1="LAYGO Node on the new value '"_DIKEY_"'"
	. D ERR^DICA3(120,DIFILE,DIENS,.01,DI1)
	D CREATE^DICA3(DIFILE,.DIENEW,DIROOT,DIKEY) ;THIS SHOULD SET DIERR
	S DIENEW=+DIENEW
	I 'DIENEW S DIOUT1=1 Q
	L -@(DIROOT_"DIENEW)")
	S @DIEN@(DISEQ)=DIENEW ;SET RETURN VALUE
	I DIOP="?+" S @DIEN@(DISEQ,0)="+" ;SET ZERO NODE IN IEN ARRAY
	S @DIRULE@("IEN",DISEQ)=DIENEW
	D SAVE
	Q
	;
LAYGO(DIFILE,DIEN,DIKEY)	;
	; ADDING--return if LAYGO permitted
	; function, all by value
	N DA,DIOK,DINODE,DIOUTS,X,Y,Y1
	S DIOK=1,DINODE="",DIOUTS=0 F  D  I DIOUTS!'DIOK Q
	. S DINODE=$O(^DD(DIFILE,.01,"LAYGO",DINODE))
	. I DINODE'>0 S DIOUTS=1 Q
	. I $D(^DD(DIFILE,.01,"LAYGO",DINODE,0))[0 Q
	. S X=DIKEY M DA=DIEN S Y=$P(DA,","),Y1=DA,DA=$P(DA,",")
	. I 1 X ^DD(DIFILE,.01,"LAYGO",DINODE,0) S DIOK=$T&'$G(DIERR)
	Q DIOK
	;
SAVE	I DIFLAGS'["E" D
	. S @DIRULE@("SAVE",DIFILE,DIENTRY,.01)=@DIFDA@(DIFILE,DIENTRY,.01)
	K @DIFDA@(DIFILE,DIENTRY,.01)
	Q
	;
SAVEK	; Remove primary key field from FDA; save in ^TMP first if necessary
	N DIFLD
	S DIFLD=0
	F  S DIFLD=$O(^TMP("DIKK",$J,"P",DIFILE,DIFILE,DIFLD)) Q:'DIFLD  D
	. Q:'^TMP("DIKK",$J,"P",DIFILE,DIFILE,DIFLD)
	. Q:$D(@DIGET@(DIFILE,DIENTRY,DIFLD))[0
	. S:DIFLAGS'["E" @DIRULE@("SAVE",DIFILE,DIENTRY,DIFLD)=@DIFDA@(DIFILE,DIENTRY,DIFLD)
	. K @DIFDA@(DIFILE,DIENTRY,DIFLD)
	Q
	;
IEN(DIENTRY,DIENF,DIRULE)	;
	; ADDING/FINDING--return translated IEN String
	; function, DIENTRY passed by value
	N DIC,DIENEW,DIOP,DIP,DIPNEW,DISEQ
	S DIENEW=""
	S DIENF=$G(DIENF)
	S DIP="" F DIC=1:1 D  I DIP="" Q
	. S DIP=$P(DIENTRY,",",DIC) I DIP="" Q
	. D
	. . I +DIP=DIP S DIPNEW=DIP Q
IEN1	. . I DIC=1 S DIPNEW=DIENF Q
	. . S DIOP=$E(DIP,1,2) I DIOP'="?+" S DIOP=$E(DIOP)
	. . S DISEQ=$P(DIP,DIOP,2,9999)
	. . S DIPNEW=$G(@DIRULE@("IEN",DISEQ))
	. S $P(DIENEW,",",DIC)=DIPNEW
	I DIENEW'="" S DIENEW=DIENEW_","
	Q DIENEW
	;
CLOSE	I DICLERR'=""!$G(DIERR) D
	. S DIERR=$G(DIERR)+DICLERR_U_($P($G(DIERR),U,2)+$P(DICLERR,U,2))
	I $G(DIMSGA)'="" D CALLOUT^DIEFU(DIMSGA)
	K @DIRULE,^TMP("DIKK",$J)
	Q
	;
GETKVALS(DIVALUE,DIINDEX)	; Get primary key values and uniq index
	N DIFLD,DIKEY,DISQ
	K DIVALUE
	S DIKEY=$P(^TMP("DIKK",$J,"P",DIFILE),U),DIINDEX=$P(^(DIFILE),U,4)
	Q:DIINDEX=""!'DIKEY
	;
	S DIFLD=0
	F  S DIFLD=$O(^TMP("DIKK",$J,"P",DIFILE,DIFILE,DIFLD)) Q:'DIFLD  D
	. S DISQ=^TMP("DIKK",$J,"P",DIFILE,DIFILE,DIFLD) Q:'DISQ
	. Q:$D(@DIGET@(DIFILE,DIENTRY,DIFLD))[0
	. S DIVALUE(DISQ)=@DIGET@(DIFILE,DIENTRY,DIFLD)
	Q
	;
ADDLF	; Check key integrity
	I $D(^TMP("DIKK",$J,"L")),'$$CHECK^DIEVK(DIFDA,DIFLAGS,DIEN) Q
	;
	; Add records for LAYGO/Finding nodes which were not found
	N DINEXT
	S (DINEXT,DIOUT1)=""
	F  S DINEXT=$O(@DIRULE@("NEXTADD",DINEXT)) Q:DINEXT=""  D  Q:DIOUT1
	. N DIENP,DIFILE,DIENTRY,DIOP,DIROOT,DISEQ
	. X @DIRULE@("NEXTADD",DINEXT)
	. S DIENP=$$IEN(DIENTRY,"",DIRULE)
	. S DIOP="?+"
	. S DISEQ=$P($P(DIENTRY,","),DIOP,2)
	. D ADDING
	Q
