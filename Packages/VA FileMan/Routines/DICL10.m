DICL10 ;SEA/TOAD,SF/TKW-VA FileMan: Lookup: Lister, Part 2 ;5/21/98  15:27
 ;;22.0;VA FileMan;;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POINT(DIFILE,DIFLAGS,DINDEX,DIDENT,DIEN,DIFIEN,DISCREEN,DILIST) ;
 ; save off the primary file info, follow the ptr chain to the end
 S DIFLAGS=DIFLAGS_"p"
 N DIVPTR,DIF S DIVPTR=$S(DINDEX(1,"TYPE")="V":1,1:0)
 M DIF=DIFILE N DIFILE M DIFILE=DIF K DIF
 D FOLLOW^DICL3(.DIFILE,"",DINDEX(1,"NODE"),1,0,"",DINDEX(1,"FIELD"),DINDEX(1,"FILE"),DIVPTR,1,.DISCREEN)
 D SETB^DICL3
 N DIX1 S DIX1="B"
 S DIX1("WAY")=DINDEX("WAY")
 N DIFROM S DIFROM(1)=$G(DINDEX(1,"FROM")),DIFROM("IEN")=""
 N DIPART S DIPART(1)=$G(DINDEX(1,"PART"))
 S DIFILE("STACK")=1_U_DIFILE("STACKEND",1)
 S DIFILE=$P(DIFILE("STACK"),U,3)
 D INDEX^DICUIX(.DIFILE,.DIFLAGS,.DIX1,.DIFROM,.DIPART)
 I $G(DINDEX(1,"USE")) S DIX1(1,"USE")=1
 N I F I="FIELD","FILE","FROM","GET","TYPE" K DIX1(1,I)
 K DIX1("FLIST")
P1 ; no variable pointers in pointer chain
 I '$O(DIFILE("STACKEND",1)) D  Q
 . D WALK^DICLIX(DIFLAGS,.DIX1,.DIDENT,.DIFILE,.DIEN,.DIFIEN,.DISCREEN,.DILIST,.DINDEX,"",.DIC)
 . Q
P2 ; variable pointer(s) in pointer chain
 N DIXV
 S DIFLAGS=DIFLAGS_"v",DIFILE("STACK")=""
 S I=0 F  S I=$O(DIFILE("STACKEND",I)) Q:'I  D
 . N DIXNAME,DISUB,R S DIXNAME="DIXV("_I_")",DISUB=DIX1(1)
 . N DIFL,DIGL S DIFL=+$P(DIFILE("STACKEND",I),U,2),DIGL=DIFILE(DIFL,"O")
 . S @DIXNAME@(1)=DISUB,@DIXNAME@(1,"MORE?")=DIX1(1,"MORE?"),@DIXNAME@(2)=""
 . S R=DIGL_"DINDEX"
 . S @DIXNAME@(1,"ROOT")=R_")",@DIXNAME@(2,"ROOT")=R_",DINDEX(1))"
 . I $G(DINDEX(1,"USE")),DISUB'="" D
 . . S R=DIGL_"""B"")",DISUB=$O(@R@(DISUB),-DIX1(1,"WAY"))
 . . S @DIXNAME@(1)=DISUB
 . . Q
 . S R=DIGL_"""B"")",DISUB=$O(@R@(DISUB)),@DIXNAME@(1,"NXTVAL")=DISUB
 . I DISUB="" K @DIXNAME,DIFILE("STACKEND",I) Q
 . Q:DIFILE("STACK")
 . S DIFILE("STACK")=I_U_DIFILE("STACKEND",I)
 . Q
 K DIX1(1,"USE")
 I +DIFILE("STACK")=1 S DIX1(1)=DIXV(1,1)
 E  S I="DIXV("_+DIFILE("STACK")_")" M DIX1=@I
 D WALK^DICLIX(DIFLAGS,.DIX1,.DIDENT,.DIFILE,.DIEN,.DIFIEN,.DISCREEN,.DILIST,.DINDEX,.DIXV,.DIC)
 Q
 ;
