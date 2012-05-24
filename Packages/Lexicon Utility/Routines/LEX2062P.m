LEX2062P ;ISL/KER - LEX*2.0*62 Pre/Post Install ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;
 ; Global Variables
 ;    ^%ZOSF("TEST")      ICR  10096
 ;    ^TMP("LEXKID")      SACC 2.3.2.5.1
 ;
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZISC              ICR  10089
 ;    ^%ZTLOAD            ICR  10063
 ;    MIX^DIC1            ICR  10007
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$DTIME^XUP         ICR   4409
 ;
 Q
POST ; LEX*2.0*62 Post-Install
 N LEX,LEXA,LEXACCT,LEXB,LEXBB,LEXBLD,LEXBUILD,LEXC,LEXCRE,LEXD,LEXDESC,LEXE,LEXEDT,LEXENV,LEXEX,LEXID,LEXIGHF,LEXL,LEXLREV,LEXM3,LEXMSG
 N LEXN,LEXNM,LEXP,LEXPOST,LEXPRO,LEXPRON,LEXPTYPE,LEXREQP,LEXRES,LEXRTN,LEXSEND,LEXSHORT,LEXSTART,LEXSTR,LEXSUB,LEXSUBJ,LEXT,LEXT1,LEXT2,LEXT3
 N LEXU,XPDA,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,X,Y S LEXBB=$$NOW^XLFDT D IMP Q:LEXBUILD=""  S (LEXB,LEXBLD,LEXBUILD)=$G(LEXBUILD)
 S U="^",LEXEDT="",LEXSHORT="",LEXMSG="",LEXSTR=$G(LEXPTYPE) D MSG
 Q
 ;
MSG ; Install Message
 N LEXA,LEXACT,LEXB,LEXBUILD,LEXCD,LEXD,LEXDA,LEXE,LEXEDT,LEXEX,LEXFY,LEXIGHF,LEXL,LEXLAST,LEXLREV,LEXID,LEXN,LEXMSG,LEXT,LEXP,LEXPTYPE,LEXQTR
 N LEXREQP,LEXRTN,LEXSHORT,LEXSTR,LEXSUB,LEXSUBJ,LEXU,X,Y D IMP Q:LEXBUILD=""  S (LEXSUB,LEXID)="LEXKID",(LEXB,LEXBLD,LEXBUILD)=$G(LEXBUILD)
 S LEXEDT="",LEXSHORT="",LEXMSG="",LEXSTR=$G(LEXPTYPE) K ^TMP(LEXID,$J) H 2 S LEXT="" D HDR S LEXB=$$SS^LEXXII($G(LEXBUILD))
 S LEXE=$P(LEXB,"^",2),LEXL=$P(LEXB,"^",3),LEXB=$P(LEXB,"^",1) D BOD,TRL,BL^LEXXII,SND
HDR ;   Message Header
 S (LEXMSG,LEXSHORT,LEXA)="" S LEXACT=$G(LEXACT)
 S (LEXSUBJ,LEXT)="Code Sets Query Options" D TL^LEXXII(LEXT) S LEXT="=======================" D TL^LEXXII(LEXT),BL^LEXXII
 S LEXD=$$ASOF^LEXXII,LEXA=$$UCI^LEXXII,LEXU=$$USR^LEXXII,LEXN=$P(LEXU,"^",1) S:$L($P(LEXACT,"^",1))&($L($P(LEXACT,"^",1))) LEXA=LEXACT
 S LEXP=$P(LEXU,"^",2),LEXN=$$PM^LEXXFI7(LEXN) S:$L(LEXD) LEXT="  As of:       "_LEXD D:$L(LEXD) TL^LEXXII(LEXT)
 S LEXT="" S:$L(LEXA) LEXT="  In Account:  "_$S($L($P(LEXA,"^",1)):"[",1:"")_$P(LEXA,"^",1)_$S($L($P(LEXA,"^",2)):"]",1:"")
 S:$L(LEXT)&($L($P(LEXA,"^",2))) LEXT=LEXT_"  "_$P(LEXA,"^",2) D:$L(LEXA) TL^LEXXII(LEXT) S LEXT="" S:$L(LEXU) LEXT="  Maint By:    "
 S:$L(LEXN) LEXT=LEXT_LEXN S:$L(LEXP)&($L(LEXN)) LEXT=LEXT_"   "_LEXP D:$L(LEXT)&(LEXT'["UNKNOWN") TL^LEXXII(LEXT)
 S LEXT="" S:$L($G(LEXBUILD)) LEXT="  Build:       "_$G(LEXBUILD) D:$L(LEXT) TL^LEXXII(LEXT)
 S LEXT="" S:$L($G(LEXIGHF)) LEXT="  Host File:   "_$G(LEXIGHF)
 S:$L(LEXT)&($L($G(LEXCRE)))&($P($G(LEXCRE),".",1)?7N) LEXT=LEXT_" (Created "_$$ED^LEXXII($G(LEXCRE))_")"
 S:'$L(LEXT)&($L($G(LEXCRE)))&($P($G(LEXCRE),".",1)?7N) LEXT="  Created:     "_$$ED^LEXXII($G(LEXCRE))
 D:$L(LEXT) TL^LEXXII(LEXT)
 Q
BOD ;   Message Body
 N LEXOP,LEXOK,LEXRES,LEXT
 S LEXOP="LEX CSV",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="  Code Sets Menu ..."
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV ICD QUERY",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    ICD-9 Diagnosis Query"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV ICP QUERY",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    ICD-9 Procedure Query"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV CPT QUERY",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    CPT/HCPCS Procedure Query"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV MOD QUERY",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    CPT Modifier Query"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV ICD/CPT CHANGE LIST",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    ICD/CPT Change List"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 S LEXOP="LEX CSV HISTORY",LEXOK=$$OPT(LEXOP),LEXRES=$S(+LEXOK>0:"installed",1:"not installed"),LEXC=+($G(LEXC))+1,LEXT="    Code History"
 S LEXT=LEXT_$J(" ",(31-$L(LEXT)))_"["_LEXOP_"]",LEXT=LEXT_$J(" ",(62-$L(LEXT)))_LEXRES D:LEXC=1 BL^LEXXII D TL^LEXXII(LEXT)
 Q
TRL ;   Message Trailer
 S LEXB=$G(LEXB),LEXE=$G(LEXE),LEXL=$G(LEXL) Q:'$L(LEXB)  N LEXT
 I $D(LEXTIME) I $P(LEXB,".",1)?7N!($P(LEXB,".",2)?7N)!($P(LEXB,".",3)[":") D
 . D BL^LEXXII I $P(LEXB,".",1)?7N S LEXT="" S LEXT="  Started:     "_$$ED^LEXXII($G(LEXB)) D TL^LEXXII(LEXT)
 . I $P(LEXE,".",1)?7N S LEXT="" S LEXT="  Finished:    "_$$ED^LEXXII($G(LEXE)) D TL^LEXXII(LEXT)
 . I $L(LEXL) S LEXT="" S LEXT="  Elapsed:     "_$$ED^LEXXII($G(LEXL)) D TL^LEXXII(LEXT)
 Q
SND ;   Send Message
 N LEXDESC,LEXENV,LEXID,LEXP,LEXACCT,LEXPRO,LEXPRON,LEXSEND,LEXSUB,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTQUEUED,ZTREQ
 S LEXP=0,LEXENV=$$ENV Q:+LEXENV'>0  S (LEXMSG,LEXSEND,LEXPOST)="",(LEXSUB,LEXID)="LEXKID",LEXACCT=$$U^LEXXFI7 S ZTSAVE("LEXACCT")=""
 S ZTRTN="MAIL^LEXXFI",ZTSAVE("LEXSEND")="",ZTSAVE("LEXPOST")="" S:$D(LEXLREV) ZTSAVE("LEXLREV")="" S:$D(LEXREQP) ZTSAVE("LEXREQP")=""
 S:$D(LEXBUILD) ZTSAVE("LEXBUILD")="" S:$D(LEXPOST) ZTSAVE("LEXPOST")="" S:$D(LEXSHORT) ZTSAVE("LEXSHORT")="" S:$D(LEXSTART) ZTSAVE("LEXSTART")=""
 S:$D(^TMP("LEXKID",$J)) ZTSAVE("^TMP(""LEXKID"",$J,")="" S:$D(LEXID) ZTSAVE("LEXID")="" S:$D(LEXRES) ZTSAVE("LEXRES")=""
 S:$D(XPDA) ZTSAVE("XPDA")="" S (LEXDESC,ZTDESC)="Post-Install CSV" S ZTDTH=$H S ZTIO="" S ZTREQ="@",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD W:+($G(ZTSK))>0 !!,"  ",LEXDESC,!,"  Queued Task #",+($G(ZTSK)) W ! D ^%ZISC
 Q
 ;
 ; Miscellaneous
IMP ;   Import names
 K LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXSUBJ S LEXPTYPE="Lexicon CSV Query Utilities",LEXLREV=62
 S LEXREQP="LEX*2.0*30",LEXBUILD="LEX*2.0*62",(LEXIGHF,LEXFY,LEXQTR)="",LEXSUBJ=$G(LEXPTYPE)
 Q
OPT(X) ;   Option Found
 N DIC,DTOUT,DUOUT,D,Y S DIC="^DIC(19,",DIC(0)="O",D="B",X=$G(X) Q:'$L(X) 0  D MIX^DIC1 Q:+Y'>0 0
 Q 1
ROK(X) ;   Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1
 Q 0
CLR ;   Clear
 K LEXTIME
 Q
ENV(X) ;   Environment check
 N LEXNM D HOME^%ZIS S:$G(DT)'?7N DT=$$DT^XLFDT I +($G(DUZ))'>0 W !!,"    User (DUZ) not defined",! Q 0
 S LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01) I '$L(LEXNM) W !!,"    Invalid User (DUZ) defined",! Q 0
 S DTIME=$$DTIME^XUP(+($G(DUZ)))
 Q 1
