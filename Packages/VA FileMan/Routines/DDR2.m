DDR2 ;ALB/MJK-FileMan Delphi Components' RPCs ;4/20/98  11:38
 ;;22.0;VA FileMan;;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
FIND1C(DDRDATA,DDR) ; DDR FIND1 rpc callback
 N DDRFILE,DDRIENS,DDRFLAGS,DDRVAL,DDRXREF,DDRSCRN,DDRERR,A,IEN,N
 D PARSE(.DDR) S DDRVAL=$G(DDR("VALUE"))
 S A=$$FIND1^DIC(DDRFILE,DDRIENS,DDRFLAGS,DDRVAL,DDRXREF,DDRSCRN,"DDRERR")
 S A=$S($G(DIERR):"",1:A)
 S N=0 D SET(A)
 I $G(DIERR) D ERROR Q
 I $G(DDROPT)["R" S IEN=$S($G(DDRIENS)]"":A_DDRIENS,1:A_",") D RECALL^DILFD(DDRFILE,IEN,DUZ)
 Q
 ;
GETSC(DDRDATA,DDR) ; DDR GETS ENTRY DATA rpc callback
 N DDRFILE,DDRIENS,DDRFLDS,DDRFLAGS,DDROPT,DDRRSLT,DDRERR
 N DDRXREF,DDRSCRN,N
 D PARSE(.DDR)
 D GETS^DIQ(DDRFILE,DDRIENS,DDRFLDS,DDRFLAGS,"DDRRSLT","DDRERR")
 S N=0
 I '$D(DDROPT) D 1,2 Q
 I $G(DDROPT)["U" D 11,21
 I $G(DDROPT)["?" D HLP
 Q
1 I $D(DDRRSLT) D
 . N DDRFIELD,X,J
 . D SET("[Data]")
 . S DDRFIELD=0 F  S DDRFIELD=$O(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD)) Q:'DDRFIELD  D
 . . ;Do not remove stripping of ',' from IENS in line below if this code should work with T11 (21.1T1) of FM components.
 . . S X=DDRFILE_"^"_$E(DDRIENS,1,$L(DDRIENS)-1)_"^"_DDRFIELD_"^"
 . . ; -- below call to $$GET1 is too slow...working w/FM team for speed
 . . ;IF $$GET1^DID(DDRFILE,DDRFIELD,"","TYPE")="WORD-PROCESSING" D
 . . ;IF $P($G(^DD(DDRFILE,DDRFIELD,0)),U,4)[";0" D <<Replaced by more generic check below.
 . . I $P($G(^DD(+$P($G(^DD(DDRFILE,DDRFIELD,0)),U,2),.01,0)),U,2)["W" D
 . . . D SET(X_"[WORD PROCESSING]")
 . . . S J=0 F  S J=$O(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,J)) Q:'J  D
 . . . . D SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,J))
 . . . D SET("$$END$$")
 . . E  D
 . . . D SET(X_$G(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"I"))_"^"_$G(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"E")))
 Q
11 N HD,I,E,B,J,K
 D SET("[BEGIN_diDATA]")
 S HD=DDRFILE_U_$E(DDRIENS,1,$L(DDRIENS)-1)
 S I=DDRFLAGS["I",E=DDRFLAGS["E",B=(I&E)
 S DDRFIELD=0 F  S DDRFIELD=$O(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD)) Q:'DDRFIELD  D
 . I $P($G(^DD(+$P($G(^DD(DDRFILE,DDRFIELD,0)),U,2),.01,0)),U,2)["W" D  Q
 . . S (K,J)=0 F  S K=$O(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,K)) Q:'K  S J=J+1
 . . D SET(HD_U_DDRFIELD_U_"W"_U_J)
 . . S J=0  F  S J=$O(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,J)) Q:'J  D SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,J))
 . . Q
 . S FLG=$S(B:"B",I:"I",1:"E")
 . D SET(HD_U_DDRFIELD_U_FLG)
 . I B D SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"E")),SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"I")) Q
 . I E D SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"E")) Q
 . I I D SET(DDRRSLT(DDRFILE,DDRIENS,DDRFIELD,"I")) Q
 D SET("[END_diDATA]")
 Q
2 IF $D(DDRERR) D SET("[ERROR]")
 Q
21 I $D(DIERR) D ERROR
 Q
SET(X) ;
 S N=N+1
 S DDRDATA(N)=X
 Q
HLP ;
 N FLD,FLG,Z,%
 S FLD=0,FLG="?"
 D SET("[BEGIN_diHELP]")
 F Z=1:1 S FLD=+$P(DDRFLDS,";",Z) Q:'FLD  D HELP(DDRFILE,DDRIENS,FLD,FLG)
 D SET("[END_diHELP]")
 Q
 ;
GETHLPC(DDRDATA,DDR) ; DDR GET DD HELP rpc callback
 N DDRFILE,DDRFIELD,DDRFLGS,N
 S DDRFILE=$G(DDR("FILE"))
 S DDRFIELD=$G(DDR("FIELD"))
 S DDRFLGS=$G(DDR("FLAGS"))
 S N=0
 D SET("[BEGIN_diHELP]")
 D HELP(DDRFILE,"",DDRFIELD,DDRFLGS)
 D SET("[END_diHELP]")
 Q
 ;
HELP(FILE,IENS,FIELD,FLGS) ;
 N DDRHLP,HD,A
 D HELP^DIE(FILE,IENS,FIELD,FLGS,"DDRHLP")
 Q:'$D(DDRHLP("DIHELP"))
 S HD=FILE_U_FIELD_U_"?"_U_DDRHLP("DIHELP") D SET(HD)
 S A=0 F  S A=$O(DDRHLP("DIHELP",A)) Q:'A   D SET(DDRHLP("DIHELP",A))
 Q
ERROR ;
 D SET("[BEGIN_diERRORS]")
 N A S A=0 F  S A=$O(DDRERR("DIERR",A)) Q:'A  D
 . N HD,PARAM,B,C,TEXT,TXTCNT,D,FILE,FIELD,IENS
 . S HD=DDRERR("DIERR",A)
 . I $D(DDRERR("DIERR",A,"PARAM",0)) D
 . . S (B,D)=0 F C=1:1 S B=$O(DDRERR("DIERR",A,"PARAM",B)) Q:B=""  D
 . . . I B="FILE" S FILE=DDRERR("DIERR",A,"PARAM","FILE")
 . . . I B="FIELD" S FIELD=DDRERR("DIERR",A,"PARAM","FIELD")
 . . . I B="IENS" S IENS=DDRERR("DIERR",A,"PARAM","IENS")
 . . . S D=D+1,PARAM(D)=B_U_DDRERR("DIERR",A,"PARAM",B)
 . S C=0 F  S C=$O(DDRERR("DIERR",A,"TEXT",C)) Q:'C  S TEXT(C)=DDRERR("DIERR",A,"TEXT",C),TXTCNT=C
 . S HD=HD_U_TXTCNT_U_$G(FILE)_U_$G(IENS)_U_$G(FIELD)_U_$G(D) D SET(HD)
 . S B=0 F  S B=$O(PARAM(B)) Q:'B  S %=PARAM(B) D SET(%)
 . S B=0 F  S B=$O(TEXT(B)) Q:'B  S %=TEXT(B) D SET(%)
 . Q
 D SET("[END_diERRORS]")
 Q
PARSE(DDR) ;
 S DDRFILE=$G(DDR("FILE"))
 S DDRIENS=$G(DDR("IENS"))
 S DDRFLDS=$G(DDR("FIELDS"))
 S DDRFLAGS=$G(DDR("FLAGS"))
 S DDRXREF=$G(DDR("XREF"))
 S DDRSCRN=$G(DDR("SCREEN"))
 S:$D(DDR("OPTIONS")) DDROPT=DDR("OPTIONS")
 Q
