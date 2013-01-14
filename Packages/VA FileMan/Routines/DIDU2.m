DIDU2 ;SEA/TOAD-VA FileMan: DD Tools, Header Nodes ;1:17 PM  12 Jan 2001
 ;;22.0;VA FileMan;**72**;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
HEADER(DIFILE,DIENS,DIMSGA) ;
 ;ENTRY POINT--return the value a file's Header Node should have
 ;extrinsic function, DIENS passed by reference
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 N DIROOT D HINPUT(.DIFILE,.DIENS,.DIMSGA,.DIROOT) I $G(DIERR) D  Q ""
 . D CLOSE
 N DIHEADER S DIHEADER=$$PIECES12(DIFILE,DIROOT) I $G(DIERR) D  Q ""
 . D CLOSE
 N DIRECENT S DIRECENT=$O(@DIROOT@(" "),-1) I DIRECENT="" S DIRECENT=0
 N DICOUNT,DIRECORD S DIRECORD=0
 F DICOUNT=0:1 S DIRECORD=$O(@DIROOT@(DIRECORD)) Q:'DIRECORD  I DICOUNT>10000 S DICOUNT=$P($G(@DIROOT@(0)),U,4) Q
 Q DIHEADER_U_DIRECENT_U_DICOUNT
 ;
HINPUT(DIFILE,DIENS,DIMSGA,DIROOT) ;
 ;evaluate input variables for HEADER call
 I $G(DIMSGA)'="" D
 . K @DIMSGA@("DIERR"),@DIMSGA@("DIHELP"),@DIMSGA@("DIMSG")
 S DIFILE=$G(DIFILE) I DIFILE="" D ERR(202,"","","","FILE") Q
 I $G(^DD(DIFILE,.01,0))="" D  Q
 . I '$D(^DD(DIFILE)) D ERR(401,DIFILE) Q
 . I '$D(^DD(DIFILE,.01)) D ERR(406,DIFILE) Q
 . E  D ERR(502,DIFILE,"",.01)
 S DIENS=$G(DIENS) I DIENS="" S DIENS=","
 I '$$IEN^DIDU1(DIENS) D  Q
 . I '$$IEN^DIDU1(DIENS_",") D ERR(202,"","","","IENS") Q
 . E  D ERR(304,"",DIENS)
 S DIROOT=$G(DIFILE("ROOT")) I DIROOT="" D
 . S DIROOT=$$ROOT^DILFD(DIFILE,DIENS,1,1) Q:DIROOT'=""!$G(DIERR)
 . I '$D(^DD(DIFILE)) D ERR(401,DIFILE) Q
 . E  D ERR(402,DIFILE,DIENS)
 Q
 ;
PIECES12(DIFILE,DIROOT) ;
 ;return pieces 1 & 2 of the Header node
 N DIPIECE1,DIPIECE2
 N DINAME S DINAME=$O(^DD(DIFILE,0,"NM","")) I DINAME="" D  Q ""
 . D ERR(408,DIFILE)
 N DIPARENT S DIPARENT=$G(^DD(DIFILE,0,"UP"))
 ;
P1 I DIPARENT'="" D  ;subfile
 . S DIPIECE1=""
 . I $P(^DD(DIFILE,.01,0),U,2)["W" D  Q
 . . D ERR(407,DIFILE)
 . N DIFIELD S DIFIELD=$O(^DD(DIPARENT,"B",DINAME,""))
 . I DIFIELD="" D  Q
 . . D ERR(501,DIFILE,"","",DINAME)
 . N DINODE S DINODE=$G(^DD(DIPARENT,DIFIELD,0)) I DINODE="" D  Q
 . . D ERR(502,DIFILE,"",DIFIELD)
 . S DIPIECE2=$P(DINODE,U,2) I DIPIECE2="" D  Q
 . . D ERR(502,DIFILE,"",DIFIELD)
 ;
P2 E  D  ;root file
 . S DIPIECE1=DINAME
 . S DIPIECE2=DIFILE_$$CODES(DIFILE,DIROOT) I $G(DIERR) Q
 I $G(DIERR) Q ""
 Q DIPIECE1_U_DIPIECE2
 ;
CODES(DIFILE,DIROOT) ;
 ;collect the file characteristics codes
 N DIFIELD S DIFIELD=$P($G(^DD(DIFILE,.01,0)),U,2) I DIFIELD="" D  Q ""
 . I '$D(^DD(DIFILE,.01)) D ERR(501,DIFILE,"","",.01) Q
 . E  D ERR(510,DIFILE,"",DIFIELD)
 N DICODES S DICODES=""
 N DITYPE F DITYPE="D","S","P","V" I DIFIELD[DITYPE S DICODES=DITYPE Q
 I $D(^DD(DIFILE,0,"ID")) S DICODES=DICODES_"I"
 I $D(^DD(DIFILE,0,"SCR"))#2 S DICODES=DICODES_"s"
 N DINODE S DINODE=$G(@DIROOT@(0))
 I $P(DINODE,U,2)["A" S DICODES=DICODES_"A"
 I $P(DINODE,U,2)["O" S DICODES=DICODES_"O"
 Q DICODES
 ;
CLOSE D CALLOUT^DIEFU($G(DIMSGA)):$G(DIMSGA)'="" Q
 ;
ERR(DIERN,DIFILE,DIIENS,DIFIELD,DI1,DI2,DI3) ;
 ;log an error
 N DIPE
 N DI F DI="FILE","IENS","FIELD",1:1:3 S DIPE(DI)=$G(@("DI"_DI))
 D BLD^DIALOG(DIERN,.DIPE,.DIPE)
 Q
