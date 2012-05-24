XUSNPIE1        ;FO-OAKLAND/JLI - NATIONAL PROVIDER IDENTIFIER DATA CAPTURE ;5/13/08  17:32
        ;;8.0;KERNEL;**420,410,435,454,462,480**; July 10, 1995;Build 38
        ;;Per VHA Directive 2004-038, this routine should not be modified
        Q
        ;
SET(XUSIEN,XUSNPI)      ;
        ; set value for NPI related fields (#41.97-41.99) in file #200
        N XUSFDA,XUSIENS,X
        S X=$G(^VA(200,XUSIEN,"NPI"))
        S XUSIENS=XUSIEN_","
        S XUSFDA(200,XUSIENS,41.99)=XUSNPI
        S XUSFDA(200,XUSIENS,41.98)="D"
        S XUSFDA(200,XUSIENS,41.97)=1
        D FILE^DIE("","XUSFDA")
        Q
        ;
SET1(XUSIEN,XUSNPI)     ;
        ; set value for NPI field (#41.99) in file #4
        N OLDNPI S OLDNPI=$P($G(^DIC(4,XUSIEN,"NPI")),"^")
        I OLDNPI K ^DIC(4,"ANPI",OLDNPI,XUSIEN)
        S ^DIC(4,XUSIEN,"NPI")=XUSNPI,^DIC(4,"ANPI",XUSNPI,XUSIEN)=""
        Q
        ;
SIGNON  ; .ACT - run at user sign-on display message if NEEDS AN NPI
        N XVAL,DATETIME,OPT,XVALTIME
        I $$CHEKNPI^XUSNPIED(DUZ) W !!,"To enter your NPI value enter  NPI  at a menu prompt to jump to the",!,"edit option.",! H 1
        ; following to insure CBO List is scheduled to run on first day of month
        S XVALTIME=$E(DT,6,7) I '((XVALTIME="01")!(XVALTIME="15")) Q
        S XVAL=+$E($$NOW^XLFDT(),6,10) I XVAL>(XVALTIME_".19"),XVAL<(XVALTIME_".1958") D  ; 7 PM TO 7:58 PM ON 1ST OF MONTH
        . S OPT=$$FIND1^DIC(19.2,"","","XUS NPI CBO LIST") I OPT'>0 L +^TMP("XUS NPI CBO LOCK"):0 Q:'$T  D CBOQUEUE L -^TMP("XUS NPI CBO LOCK") Q
        . S DATETIME=$$GET1^DIQ(19.2,OPT_",",2)
        . I DATETIME'=$$FMTE^XLFDT(DT_".2") L +^DIC(19.2,OPT):0 Q:'$T  D SETQUEUE(OPT,DT_".2") L -^DIC(19.2,OPT) Q
        . I '$$GET1^DIQ(19.2,OPT_",",99.1) L +^DIC(19.2,OPT):0 Q:'$T  D  L -^DIC(19.2,OPT)
        . . D SETQUEUE(OPT,"@")
        . . D SETQUEUE(OPT,DT_".2")
        . . Q
        . Q
        Q
        ;
SETQUEUE(OPT,VALUE)     ;
        N FDA S FDA(19.2,OPT_",",2)=VALUE D FILE^DIE("","FDA")
        Q
        ;
POSTINIT        ;
        N XUGLOB,XUUSER,XIEN,X,ZTDESC,ZTDTH,ZTIO,ZTRTN
        ;S XIEN=$$FIND1^DIC(19,"","","XUCOMMAND") I XIEN>0,$$FIND1^DIC(19.01,","_XIEN_",","","XUS NPI PROVIDER SELF ENTRY")'>0 S X=$$ADD^XPDMENU("XUCOMMAND","XUS NPI PROVIDER SELF ENTRY","NPI","")
        ;S XIEN=$$FIND1^DIC(19,"","","XU USER SIGN-ON") I XIEN>0,$$FIND1^DIC(19.01,","_XIEN_",","","XUS NPI SIGNON CHECK")'>0 S X=$$ADD^XPDMENU("XU USER SIGN-ON","XUS NPI SIGNON CHECK","","")
        ; get global containing Taxonomy values
        S XUGLOB=$$CHKGLOB^XUSNPIED()
        ; go through file 200 and ma
        S XUUSER=0 F  S XUUSER=$O(^VA(200,XUUSER)) Q:XUUSER'>0  I $$ACTIVE^XUSER(XUUSER) D DOUSER^XUSNPIED(XUUSER,XUGLOB)
        ; and send CBO a starting point list
        ;S ZTIO="",ZTDTH=$$NOW^XLFDT(),ZTRTN="CBOLIST^XUSNPIED",ZTDESC="XUS NPI CBOLIST MESSAGE GENERATION" D ^%ZTLOAD
        ; set up to generate CBO list monthly
        D CBOQUEUE
        Q
        ;
CBOQUEUE        ;
        N FDA,XUSVAL
        ; check for already queued
        S XUSVAL=$$FIND1^DIC(19.2,"","","XUS NPI CBO LIST") I XUSVAL>0 D  Q
        . S FDA(19.2,XUSVAL_",",2)=$$SETDATE()
        . S FDA(19.2,XUSVAL_",",6)="1M(1@2000,15@2000)"
        . N ZTQUEUED S ZTQUEUED=1 D FILE^DIE("","FDA") K ZTQUEUED
        . Q
        ; no set up queued job
        S XUSVAL=$$FIND1^DIC(19,"","","XUS NPI CBO LIST") Q:XUSVAL'>0  S FDA(19.2,"+1,",.01)=XUSVAL
        S FDA(19.2,"+1,",2)=$$SETDATE()
        S FDA(19.2,"+1,",6)="1M(1@2000,15@2000)"
        N ZTQUEUED S ZTQUEUED=1 D UPDATE^DIE("","FDA") K ZTQUEUED
        Q
        ;
SETDATE()       ;
        Q $S($E($$NOW^XLFDT(),6,10)<1.2:DT,$E($$NOW^XLFDT(),6,10)<15.2:$E(DT,1,5)_"15",$E(DT,4,5)>11:(($E(DT,1,3)+1)_"0101"),1:($E(DT,1,5)+1)_"01")_".2"
        ;
CHKOLD1(IEN)    ;
        D CHKOLD1^XUSNPIE2(IEN)
        Q
        ;
CLERXMPT        ;
        D CLERXMPT^XUSNPIE2
        Q
        ;
CHKDGT(XUSNPI,XUSDA,XUSQI)      ; INPUT TRANSFORM
        N XUS S XUS=$$CHKDGT^XUSNPI(XUSNPI)
        I XUS'>0 Q 0
        N XUSQIK S XUSQIK=$$QI^XUSNPI(XUSNPI) I XUSQIK=0 Q 1
        ; Check whether NPI is already being used. If so, issue error or warning.
        N NPIUSED,XUSRSLT
        S NPIUSED=$$NPIUSED^XUSNPI1(XUSNPI,XUSQI,XUSQIK,XUSDA,.XUSRSLT,1)
        ; If an error was encountered, quit 0.
        I NPIUSED=1 Q 0
        ; If a warning was encountered, quit 1 (Person on file 200 and 355.93 can share NPI)
        I NPIUSED=2 Q 1
        ; If current provider previously had this NPI, make sure the NPI being added is the most
        ; current one in the EFFECTIVE DATE/TIME multiple (history).
        N XUSROOT S XUSROOT=$$GET^XPAR("PKG.KERNEL","XUSNPI QUALIFIED IDENTIFIER",XUSQI)
        I $E(XUSROOT)'="^" S XUSROOT="^"_XUSROOT
        N XUS1 S XUS1=XUSROOT_XUSDA_","_"""NPISTATUS"""_","_"""A"""_")"
        N XUS2 S XUS2=$O(@XUS1,-1) I XUS2'>0 Q 1
        S XUS1=XUSROOT_XUSDA_","_"""NPISTATUS"""_","_XUS2_","_0_")"
        S XUS2=$G(@XUS1) I $P(XUS2,"^",3)=XUSNPI Q 1
        Q 0
