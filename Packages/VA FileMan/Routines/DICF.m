DICF ;SEA/TOAD,SF/TKW-VA FileMan: Finder, Part 1 (Main) ;20APR2010
 ;;22.0;VA FileMan;**20,31,165**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
FIND(DIFILE,DIFIEN,DIFIELDS,DIFLAGS,DIVALUE,DINUMBER,DIFORCE,DISCREEN,DIWRITE,DILIST,DIMSGA,DINDEX,DIC,DIY,DIYX) ;
 ; ENTRY POINT--silent selecter
 ;
FINDX ; branch in from FIND^DIC
 I '$D(DIQUIET),$G(DIC(0))'["E" N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 N DICLERR S DICLERR=$G(DIERR) K DIERR
 N DIEN,DIFAIL
 M DIEN=DIVALUE N DIVALUE M DIVALUE=DIEN K DIEN
 N DIDENT S DIDENT(-1)=+$G(DILIST("C"))
 ;
INPUT ; Verify correctness of input parameters
 S DIFLAGS=$G(DIFLAGS)
 I DIFLAGS'["l" N DINDEX S DINDEX("WAY")=1
 S DIFAIL=0 D  I DIFAIL D CLOSE Q
I0 . ; flags
 . I DIFLAGS["p" S DIFLAGS=DIFLAGS_"f"
 . I DIFLAGS'["p" D  Q:DIFAIL
 . . I $G(DIFIELDS)["IX",DIFIELDS'["-IX" D
 . . . N D S D=";"_DIFIELDS_";" I D'[";IX;",D'[";IXE",D'[";IXIE" Q
 . . . S DIDENT(-5)=1 Q
 . . S DIFLAGS=DIFLAGS_4
 . . I DIFLAGS["O",DIFLAGS["X" S DIFLAGS=$TR(DIFLAGS,"O")
 . . S DIFLAGS=DIFLAGS_"t"
I1 . . ; value
 . . I DIFLAGS'["l" N DIERRM D  I DIFAIL D ERR^DICF4(202,"","","",DIERRM) Q
 . . . S DIERRM="Lookup values"
 . . . I $G(DIVALUE(1))="" S DIVALUE(1)=$G(DIVALUE)
 . . . N I,DIEND S DIFAIL=1,DIEND=$O(DIVALUE(999999),-1)
 . . . F I=1:1:DIEND S DIVALUE(I)=$G(DIVALUE(I)) I DIVALUE(I)]"" S DIFAIL=$$BADVAL(DIVALUE(I)) Q:DIFAIL
 . . . Q
 . . Q
I2 . ; target_root
 . S DILIST=$G(DILIST)
 . I DILIST'="",DIFLAGS'["l" D
 . . I DIFLAGS'["p" K @DILIST
 . . I DIFLAGS'["f" S DILIST=$NA(@DILIST@("DILIST"))
 . . Q
 . I DILIST="" S DILIST="^TMP(""DILIST"",$J)" K @DILIST
I3 . ; file and screens
 . D:DIFLAGS'["v"&(DIFLAGS'["l") FILE^DICUF(.DIFILE,.DIFIEN,DIFLAGS)
 . I $G(DIERR) S DIFAIL=1 Q
 . D SCREEN^DICUF(DIFLAGS,.DIFILE,.DISCREEN)
 . D DA^DILF(DIFIEN,.DIEN)
I4 . ; fields
 . S DIFIELDS=$G(DIFIELDS)
I5 . ; flags again
 . I DIFLAGS'["p",DIFLAGS'["l" D  Q:DIFAIL
 . . I $TR(DIFLAGS,"ABCKMOPQSUXfglpqtv4")'="" S DIFAIL=1 D  Q
 . . . D ERR^DICF4(301,"","","",$TR(DIFLAGS,"fglpqtv4")) Q
 . . Q
I6 . ; determine starting index.
 . I DIFLAGS'["l" D  Q:DIFAIL
 . . S DIFORCE=$G(DIFORCE),DIFORCE(1)=1
 . . I "*"[DIFORCE D
 . . . I DIFLAGS["M" S DIFORCE=0,DIFORCE(0)="*" Q
 . . . S DIFORCE(0)=$$DINDEX^DICL(DIFILE,DIFLAGS),DIFORCE=1 Q
 . . E  D  I DIFAIL D ERR^DICF4(202,"","","","Indexes") Q
 . . . I $P(DIFORCE,U)="" S DIFAIL=1 Q
 . . . S DIFORCE(0)=DIFORCE,DIFORCE=1
 . . . I $P(DIFORCE(0),U,2)]"",DIFLAGS'["M" S DIFLAGS=DIFLAGS_"M"
 . . . Q
 . . I DIFORCE S DINDEX=$P(DIFORCE(0),U) Q
 . . S DINDEX=$$DINDEX^DICL(DIFILE,DIFLAGS) Q
I7 . ; rest
 . I DIFLAGS'["p",DIFLAGS'["l" D  Q:DIFAIL
 . . S DINUMBER=$S($G(DINUMBER):DINUMBER,1:"*")
 . . I DINUMBER'="*" D  Q:DIFAIL
 . . . I DINUMBER\1=DINUMBER,DINUMBER>0 Q
 . . . S DIFAIL=1 D ERR^DICF4(202,"","","","Number")
 . . . Q
 . . Q
 . S DIWRITE=$G(DIWRITE)
 . Q
I8 I DIFLAGS["P" S DIDENT(-3)=""
 S DIDENT(-1,"JUST LOOKING")=0,DIDENT(-1,"MAX")=DINUMBER,DIDENT(-1,"MORE?")=0
 N DIOUT S DIOUT=0
 ;
HOOK75 ;
 N DIHOOK75
 S DIHOOK75=$G(^DD(DIFILE,.01,7.5))
 I DIHOOK75'="",DIVALUE(1)]"",DIVALUE(1)'?."?",'$O(DIVALUE(1)),DIFLAGS'["l" D  I DIOUT D CLOSE Q
 .N DIC D  ;I DIFLAGS["p" N DIC D
 . . S DIC=DIFILE,DIC(0)=$TR(DIFLAGS,"2^fglpqtv4") Q
 . N %,D,X,Y,Y1
 . S X=DIVALUE(1),D=DINDEX
 . M Y=DIEN S Y="",Y1=DIFIEN
 . X DIHOOK75 I '$D(X)!$G(DIERR) S DIOUT=1 D:$G(DIERR)  Q
 . . S %=$$EZBLD^DIALOG(8090) ;Pre-lookup transform (7.5 node)
 . . D ERR^DICF4(120,DIFILE,"",.01,%)
 . S DIVALUE(1)=X,DIOUT=$$BADVAL(DIVALUE(1)) Q:DIOUT
 . I $G(DIC("S"))'="" S DISCREEN("S")=DIC("S") ;DIHOOK MAY HAVE SET THIS
 . I $G(DIC("V"))'="" S (DISCREEN("V"),DISCREEN("V",1))=DIC("V") ;...OR THIS
 ;
LOOKUP ;
 I DIFLAGS'["l" D  I DIOUT!($G(DIERR)) D CLOSE Q
 . D INDEX^DICUIX(.DIFILE,DIFLAGS,.DINDEX,"",.DIVALUE,DINUMBER,.DISCREEN,DILIST,.DIOUT) Q
 I '$D(DINDEX("MAXSUB")) D
 . S DINDEX("MAXSUB")=$P($G(^DD("OS",+$G(^DD("OS")),0)),U,7)
 . I DINDEX("MAXSUB") S DINDEX("MAXSUB")=DINDEX("MAXSUB")-13 Q
 . S DINDEX("MAXSUB")=50 Q
 I $D(DISCREEN("V")) D VPDATA^DICUF(.DINDEX,.DISCREEN)
 I (DINDEX'="#")!($O(DIVALUE(1))) D CHKVAL1^DIC0(DINDEX("#"),.DIVALUE,DIFLAGS)  I $G(DIERR) D CLOSE Q
 I DIFLAGS'["f" D  I $G(DIERR) D CLOSE Q
 . D IDENTS^DICU1(DIFLAGS,.DIFILE,DIFIELDS,DIWRITE,.DIDENT,.DINDEX)
 . Q
 I DIFLAGS'["p",DIFLAGS'["l" D  I DIOUT!($G(DIERR)) D CLOSE Q
 . N I F I=2:1:DINDEX("#") Q:$G(DIVALUE(I))]""
 . Q:$G(DIVALUE(I))]""
 . D SPECIAL^DICF1(.DIFILE,.DIEN,DIFIEN,DIFLAGS,DIVALUE(1),.DINDEX,.DISCREEN,.DIDENT,.DIOUT,.DILIST)
 . Q
 I DIFLAGS["t" D XFORM^DICF1(.DIFLAGS,.DIVALUE,.DISCREEN,.DINDEX)
 I DINDEX("#")>1,DIVALUE(1)="" N S M S=DISCREEN N DISCREEN M DISCREEN=S K S D
 . I DIFIELDS["IX",DIFIELDS'["-IX" Q
 . N DISAVMAX S DISAVMAX=DINDEX("MAXSUB")
 . D ALTIDX^DICF0(.DINDEX,.DIFILE,.DIVALUE,.DISCREEN,DINUMBER)
 . S DINDEX("MAXSUB")=DISAVMAX Q
 D CHKALL^DICF2(.DIFILE,.DIEN,DIFIEN,.DIFLAGS,.DIVALUE,.DISCREEN,DINUMBER,.DIFORCE,.DINDEX,.DIDENT,.DILIST,.DIC,.DIY,.DIYX)
 D CLOSE
 Q
 ;
BADVAL(DIVALUE) ; Check for invalid characters in value
 I "^"[DIVALUE Q 1
 I DIVALUE'?.ANP D ERR^DICF4(204,"","","",DIVALUE) Q 1
 Q 0
CLOSE ;
 ; cleanup
 I $G(DIMSGA)'="" D CALLOUT^DIEFU(DIMSGA)
 I DICLERR'=""!$G(DIERR) D
 . I DIFLAGS["l",+DIERR=1 Q
 . S DIERR=$G(DIERR)+DICLERR_U_($P($G(DIERR),U,2)+$P(DICLERR,U,2))
 I $G(DIERR) D  Q
 . Q:$G(DILIST)=""  K @DILIST@("B") Q
 I DIFLAGS["p" S @DILIST=DIDENT(-1) Q
 Q:DIFLAGS["l"
 S @DILIST@(0)=DIDENT(-1)_U_DIDENT(-1,"MAX")_U_DIDENT(-1,"MORE?")_U_$S(DIFLAGS[2:"H",1:"")
 I DIFLAGS["P" S @DILIST@(0,"MAP")=$G(DIDENT(-3))
 E  D SETMAP^DICL1(.DIDENT,DILIST)
 K @DILIST@("B")
 Q
 ;
 ; Error messages:
 ; 120  The previous error occurred when performin
 ; 202  The input parameter that identifies the |1
 ; 204  The input value contains control character
 ; 301  The passed flag(s) '|1|' are unknown or in
 ; 8090 Pre-lookup transform (7.5 node)
 ; 8093 Too many lookup values for this index.
 ; 8094 Not enough lookup values provided for an e
 ; 8095 Only one compound index allowed on a looku
 ;
