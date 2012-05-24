C0CFM2   ; CCDCCR/GPL - CCR FILEMAN utilities; 12/6/08
 ;;1.0;C0C;;May 19, 2009;Build 2
 ;Copyright 2009 George Lilly.  Licensed under the terms of the GNU
 ;General Public License See attached copy of the License.
 ;
 ;This program is free software; you can redistribute it and/or modify
 ;it under the terms of the GNU General Public License as published by
 ;the Free Software Foundation; either version 2 of the License, or
 ;(at your option) any later version.
 ;
 ;This program is distributed in the hope that it will be useful,
 ;but WITHOUT ANY WARRANTY; without even the implied warranty of
 ;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ;GNU General Public License for more details.
 ;
 ;You should have received a copy of the GNU General Public License along
 ;with this program; if not, write to the Free Software Foundation, Inc.,
 ;51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ;
 W "This is the CCR FILEMAN Utility Library ",!
 ; THIS SET OF ROUTINES USE CCR E2 (^C0CE(, FILE 171.101) INSTEAD OF
 ; CCR ELEMENTS (^C0C(179.201,
 ; E2 IS A SIMPLIFICATION OF CCR ELEMENTS WHERE SUB-ELEMENTS ARE
 ; AT THE TOP LEVEL. OCCURANCE, THE 4TH PART OF THE KEY IS NOW FREE TEXT
 ; AND HAS THE FORM X;Y FOR SUB-ELEMENTS
 ; ALL SUB-VARIABLES HAVE BEEN REMOVED
 W !
 Q
 ;
RIMTBL(ZWHICH) ; PUT ALL PATIENT IN RIMTBL ZWHICH INTO THE CCR ELEMENTS FILE
 ;
 I '$D(RIMBASE) D ASETUP^C0CRIMA ; FOR COMMAND LINE CALLS
 N ZI,ZJ,ZC,ZPATBASE
 S ZPATBASE=$NA(@RIMBASE@("RIMTBL","PATS",ZWHICH))
 S ZI=""
 F ZJ=0:0 D  Q:$O(@ZPATBASE@(ZI))=""  ; TIL END
 . S ZI=$O(@ZPATBASE@(ZI))
 . D PUTRIM(ZI) ; EXPORT THE PATIENT TO A FILE
 Q
 ;
PUTRIM(DFN,ZWHICH) ;DFN IS PATIENT , WHICH IS ELEMENT TYPE
 ;
 S C0CGLB=$NA(^TMP("C0CRIM","VARS",DFN))
 I '$D(ZWHICH) S ZWHICH="ALL"
 I ZWHICH'="ALL" D  ; SINGLE SECTION REQUESTED
 . S C0CVARS=$NA(@C0CGLB@(ZWHICH))
 . D PUTRIM1(DFN,ZWHICH,C0CVARS) ; IF ONE SECTION
 E  D  ; MULTIPLE SECTIONS
 . S C0CVARS=$NA(@C0CGLB)
 . S C0CI=""
 . F  S C0CI=$O(@C0CVARS@(C0CI)) Q:C0CI=""  D  ;FOR EACH SECTION
 . . S C0CVARSN=$NA(@C0CVARS@(C0CI)) ; GRAB ONE SECTION
 . . D PUTRIM1(DFN,C0CI,C0CVARSN)
 Q
 ;
PUTRIM1(DFN,ZZTYP,ZVARS) ; PUT ONE SECTION OF VARIABLES INTO CCR ELEMENTS
 ; ZVARS IS PASSED BY NAME AN HAS THE FORM @ZVARS@(1,"VAR1")="VAL1"
 S C0CX=0
 F  S C0CX=$O(@ZVARS@(C0CX)) Q:C0CX=""  D  ; FOR EACH OCCURANCE
 . W "ZOCC=",C0CX,!
 . K C0CMDO ; MULTIPLE SUBELEMENTS FOR THIS OCCURANCE PASSED BY NAME
 . S C0CV=$NA(@ZVARS@(C0CX)) ; VARIABLES FOR THIS OCCURANCE
 . D PUTELS(DFN,ZZTYP,C0CX,C0CV) ; PUT THEM TO THE CCR ELEMENTS FILE
 . I $D(C0CMDO) D  ; MULTIPLES TO HANDLE (THIS IS INSTEAD OF RECURSION :()
 . . N ZZCNT,ZZC0CI,ZZVALS,ZT,ZZCNT,ZV
 . . S ZZCNT=0
 . . S ZZC0CI=0
 . . S ZZVALS=$NA(@C0CMDO@("M")) ; LOCATION OF THIS MULTILPE
 . . S ZT=$O(@ZZVALS@("")) ; ELEMENT TYPE OF MULTIPLE
 . . S ZZVALS=$NA(@ZZVALS@(ZT)) ; PAST MULTIPLE TYPE INDICATOR
 . . W "MULTIPLE:",ZZVALS,!
 . . ;B
 . . F  S ZZC0CI=$O(@ZZVALS@(ZZC0CI)) Q:ZZC0CI=""  D  ; EACH MULTIPLE
 . . . S ZZCNT=ZZCNT+1 ;INCREMENT COUNT
 . . . W "COUNT:",ZZCNT,!
 . . . S ZV=$NA(@ZZVALS@(ZZC0CI))
 . . . D PUTELS(DFN,ZT,C0CX_";"_ZZCNT,ZV)
 Q
 ;
PUTELS(DFN,ZTYPE,ZOCC,ZVALS) ; PUT CCR VALUES INTO THE CCR ELEMENTS FILE
 ; 171.101, ^C0CE  DFN IS THE PATIENT IEN PASSED BY VALUE
 ; ZTYPE IS THE NODE TYPE IE RESULTS,PROBLEMS PASSED BY VALUE
 ; ZOCC IS THE OCCURANCE NUMBER IE PROBLEM NUMBER 1,2,3 ETC
 ; ZVALS ARE THE VARIABLES AND VALUES PASSED BY NAME AND IN THE FORM
 ; @ZVALS@("VAR1")="VALUE1" FOR ALL VARIABLES IN THIS ELEMENT
 ; AND @ZVALS@("M",SUBOCCUR,"VAR2")="VALUE2" FOR SUB VARIABLES
 ;
 N PATN,ZTYPN,XD0,ZTYP
 I '$D(ZSRC) S ZSRC=1 ; CCR SOURCE IS ASSUMED, 1 IF NOT SET
 ; PUT THIS IN PARAMETERS - SO SOURCE NUMBER FOR PROCESSING IN CONFIGURABLE
 N C0CFPAT S C0CFPAT=171.101 ; FILE AT PATIENT LEVEL
 N C0CFSRC S C0CFSRC=171.111 ; FILE AT CCR SOURCE LVL
 N C0CFTYP S C0CFTYP=171.121 ; FILE AT ELEMENT TYPE LVL
 N C0CFOCC S C0CFOCC=171.131 ; FILE AT OCCURANCE LVL
 N C0CFVAR S C0CFVAR=171.1311 ; FILE AT VARIABLE LVL
 ;FILE IS ^C0CE(PAT,1,SCR,1,TYP,1,OCC,1,VAR,1, ...
 ; AND WE HAVE TO ADD THEM LEVEL AT A TIME I THINK
 N C0CFDA
 S C0CFDA(C0CFPAT,"?+1,",.01)=DFN
 D UPDIE ; ADD THE PATIENT
 S PATN=$O(^C0CE("B",DFN,"")) ; IEN FOR THE PATIENT
 S C0CFDA(C0CFSRC,"?+1,"_PATN_",",.01)=ZSRC
 D UPDIE ; ADD THE CCR SOURCE
 N ZTYPN S ZTYPN=$O(^C0CDIC(170.101,"B",ZTYPE,"")) ; FIND THE ELE TYPE
 S C0CFDA(C0CFTYP,"?+1,"_ZSRC_","_PATN_",",.01)=ZTYPN
 D UPDIE ; ADD THE ELEMENT TYPE
 S ZTYP=$O(^C0CE(PATN,1,ZSRC,1,"B",ZTYPN,"")) ; IEN OF ELEMENT TYPE
 S C0CFDA(C0CFOCC,"?+1,"_ZTYP_","_ZSRC_","_PATN_",",.01)=ZOCC ; STRING OCC
 ; OCC IS PRECEDED BY " " TO FORCE STRING STORAGE AND PRESERVE
 ; STRING COLLATION ON THE INDEX
 D UPDIE ; ADD THE OCCURANCE
 S ZD0=$O(^C0CE(PATN,1,ZSRC,1,ZTYP,1,"B",ZOCC,""))
 W "RECORD NUMBER: ",ZD0,!
 ;I ZD0=32 B
 ;I ZD0=31 B
 N ZCNT,ZC0CI,ZVARN,C0CZ1
 S ZCNT=0
 S ZC0CI="" ;
 F  S ZC0CI=$O(@ZVALS@(ZC0CI)) Q:ZC0CI=""  D  ;
 . I ZC0CI'="M" D  ; NOT A SUBVARIABLE
 . . S ZCNT=ZCNT+1 ;INCREMENT COUNT
 . . S ZVARN=$$VARPTR(ZC0CI,ZTYPE) ;GET THE POINTER TO THE VAR IN THE CCR DICT
 . . ; WILL ALLOW FOR LAYGO IF THE VARIABLE IS NOT FOUND
 . . S C0CZ1=ZTYP_","_ZSRC_","_PATN_","
 . . S C0CFDA(C0CFVAR,"?+"_ZCNT_","_ZD0_","_C0CZ1,.01)=ZVARN
 . . S ZZVAL=$TR(@ZVALS@(ZC0CI),"^","|")
 . . S C0CFDA(C0CFVAR,"?+"_ZCNT_","_ZD0_","_C0CZ1,1)=ZZVAL
 . E  D  ; THIS IS A SUBELEMENT
 . . ;PUT THE FOLLOWING BACK TO USE RECURSION
 . . ;N ZZCNT,ZZC0CI,ZZVALS,ZT,ZZCNT,ZV
 . . ;S ZZCNT=0
 . . ;S ZZC0CI=0
 . . ;S ZZVALS=$NA(@ZVALS@("M")) ; LOCATION OF THIS MULTILPE
 . . ;S ZT=$O(@ZZVALS@("")) ; ELEMENT TYPE OF MULTIPLE
 . . ;S ZZVALS=$NA(@ZZVALS@(ZT)) ; PAST MULTIPLE TYPE INDICATOR
 . . ;W "MULTIPLE:",ZZVALS,!
 . . ;B
 . . ;F  S ZZC0CI=$O(@ZZVALS@(ZZC0CI)) Q:ZZC0CI=""  D  ; EACH MULTIPLE
 . . ;. S ZZCNT=ZZCNT+1 ;INCREMENT COUNT
 . . ;. W "COUNT:",ZZCNT,!
 . . ;. S ZV=$NA(@ZZVALS@(ZZC0CI))
 . . ;. D PUTELS(DFN,ZT,ZOCC_";"_ZZCNT,ZV) ; PUT THIS BACK TO DEBUG RECURSION
 . . S C0CMDO=ZVALS ; FLAG TO HANDLE MULTIPLES (INSTEAD OF RECURSION)
 D UPDIE ; UPDATE
 Q
 ;
UPDIE ; INTERNAL ROUTINE TO CALL UPDATE^DIE AND CHECK FOR ERRORS
 K ZERR
 D CLEAN^DILF
 D UPDATE^DIE("","C0CFDA","","ZERR")
 I $D(ZERR) D  ;
 . W "ERROR",!
 . ZWR ZERR
 . B
 K C0CFDA
 Q
 ;
CHECK ; CHECKSUM EXPERIMENTS
 ;
 ;B
 S ZG=$NA(^C0CE(DA(2),1,DA(1),1,DA))
 ;S G2=$NA(^C0CE(8,1,1,1,2,1,6))
 S X=$$CHKSUM^XUSESIG1(ZG)
 W G1,!
 Q
 ;
CHKELS(DFN) ; CHECKSUM ALL ELEMENTS FOR  A PATIENT
 ;
 S ZGLB=$NA(^TMP("C0CCHK"))
 S ZPAT=$O(^C0CE("B",DFN,""))
 K @ZGLB@(ZPAT) ; CLEAR PREVIOUS CHECKSUMS
 S ZSRC=""
 F  S ZSRC=$O(^C0CE(ZPAT,1,"B",ZSRC)) Q:ZSRC=""  D  ;
 . W "PAT:",ZPAT," SRC:",ZSRC,!
 . S ZEL=""
 . F  S ZEL=$O(^C0CE(ZPAT,1,ZSRC,1,"B",ZEL)) Q:ZEL=""  D  ;ELEMENTS
 . . W "ELEMENT:",ZEL," "
 . . S ZELE=$$GET1^DIQ(170.101,ZEL,.01,"E") ;ELEMENT NAME
 . . W ZELE," "
 . . S ZELI=$O(^C0CE(ZPAT,1,ZSRC,1,"B",ZEL,""))
 . . S ZG=$NA(^C0CE(ZPAT,1,ZSRC,1,ZELI))
 . . S ZCHK=$$CHKSUM^XUSESIG1(ZG) ; CHECKSUM FOR THE ELEMENT
 . . W ZCHK,!
 . . S @ZGLB@(ZPAT,ZELE,ZSRC)=ZCHK
 ZWR ^TMP("C0CCHK",ZPAT,*)
 Q
 ;
DOIT(DFN) ; EXPERIMENT FOR TIMING CALLS USING mumps -dir DOIT^C0CFM2(DFN)
 D SETXUP
 D CHKELS(DFN)
 Q
 ;
SETXUP ; SET UP ENVIRONMENT
 S DISYS=19
 S DT=3090325
 S DTIME=300
 S DUZ=1
 S DUZ(0)="@"
 S DUZ(1)=""
 S DUZ(2)=7247
 S DUZ("AG")="I"
 S DUZ("BUF")=1
 S DUZ("LANG")=""
 S IO="/dev/pts/20"
 S IO(0)="/dev/pts/20"
 S IO(1,"/dev/pts/20")=""
 S IO("ERROR")=""
 S IO("HOME")="344^/dev/pts/20"
 S IO("ZIO")="/dev/pts/20"
 S IOBS="$C(8)"
 S IOF="#,$C(27,91,50,74,27,91,72)"
 S IOM=80
 S ION="TELNET"
 S IOS=344
 S IOSL=24
 S IOST="C-VT100"
 S IOST(0)=9
 S IOT="VTRM"
 S IOXY="W $C(27,91)_((DY+1))_$C(59)_((DX+1))_$C(72)"
 S U="^"
 S X="216;DIC(4.2,"
 S XPARSYS="216;DIC(4.2,"
 S XQXFLG="^^XUP"
 Q
 ;
PUTELSOLD(DFN,ZTYPE,ZOCC,ZVALS) ; PUT CCR VALUES INTO THE CCR ELEMENTS FILE
 ; 171.101, ^C0CE  DFN IS THE PATIENT IEN PASSED BY VALUE
 ; ZTYPE IS THE NODE TYPE IE RESULTS,PROBLEMS PASSED BY VALUE
 ; ZOCC IS THE OCCURANCE NUMBER IE PROBLEM NUMBER 1,2,3 ETC
 ; ZVALS ARE THE VARIABLES AND VALUES PASSED BY NAME AND IN THE FORM
 ; @ZVALS@("VAR1")="VALUE1" FOR ALL VARIABLES IN THIS ELEMENT
 ; AND @ZVALS@("M",SUBOCCUR,"VAR2")="VALUE2" FOR SUB VARIABLES
 ;
 S ZSRC=1 ; CCR SOURCE IS ASSUMED TO BE THIS EHR, WHICH IS ALWAYS SOURCE 1
 ; PUT THIS IN PARAMETERS - SO SOURCE NUMBER FOR PROCESSING IN CONFIGURABLE
 N ZF,ZFV S ZF=171.101 S ZFV=171.1011
 ;S ZSUBF=171.20122 ;FILE AND SUBFILE NUMBERS
 ;N ZSFV S ZSFV=171.201221 ; SUBFILE VARIABLE FILE NUMBER
 N ZTYPN S ZTYPN=$O(^C0CDIC(170.101,"B",ZTYPE,""))
 W "ZTYPE: ",ZTYPE," ",ZTYPN,!
 N ZVARN ; IEN OF VARIABLE BEING PROCESSED
 ;N C0CFDA ; FDA FOR CCR ELEMENT UPDATE
 K C0CFDA
 S C0CFDA(ZF,"?+1,",.01)=DFN
 S C0CFDA(ZF,"?+1,",.02)=ZSRC
 S C0CFDA(ZF,"?+1,",.03)=ZTYPN
 S C0CFDA(ZF,"?+1,",.04)=" "_ZOCC ;CREATE OCCURANCE
 K ZERR
 ;B
 D UPDATE^DIE("","C0CFDA","","ZERR") ;ASSIGN RECORD NUMBER
 I $D(ZERR) B  ;OOPS
 K C0CFDA
 S ZD0=$O(^C0CE("C",DFN,ZSRC,ZTYPN,ZOCC,""))
 W "RECORD NUMBER: ",ZD0,!
 ;B
 S ZCNT=0
 S ZC0CI="" ;
 F  S ZC0CI=$O(@ZVALS@(ZC0CI)) Q:ZC0CI=""  D  ;
 . I ZC0CI'="M" D  ; NOT A SUBVARIABLE
 . . S ZCNT=ZCNT+1 ;INCREMENT COUNT
 . . S ZVARN=$$VARPTR(ZC0CI,ZTYPE) ;GET THE POINTER TO THE VAR IN THE CCR DICT
 . . ; WILL ALLOW FOR LAYGO IF THE VARIABLE IS NOT FOUND
 . . S C0CFDA(ZFV,"?+"_ZCNT_","_ZD0_",",.01)=ZVARN
 . . S C0CFDA(ZFV,"?+"_ZCNT_","_ZD0_",",1)=@ZVALS@(ZC0CI)
 . . ;S C0CFDA(ZSFV,"+1,"_DFN_","_ZSRC_","_ZTYPN_","_ZOCC_",",.01)=ZVARN
 . . ;S C0CFDA(ZSFV,"+1,"_DFN_","_ZSRC_","_ZTYPN_","_ZOCC_",",1)=@ZVALS@(ZC0CI)
 ;S GT1(170,"?+1,",.01)="ZZZ NEW MEDVEHICLETEXT"
 ;S GT1(170,"?+1,",12)="DIR"
 ;S GT1(171.201221,"?+1,1,5,1,",.01)="ZZZ NEW MEDVEHICLETEXT"
 ;S GT1(171.201221,"+1,1,5,1,",1)="THIRD NEW MED DIRECTION TEXT"
 D CLEAN^DILF
 D UPDATE^DIE("","C0CFDA","","ZERR")
 I $D(ZERR) D  ;
 . W "ERROR",!
 . ZWR ZERR
 . B
 K C0CFDA
 Q
 ;
VARPTR(ZVAR,ZTYP) ;EXTRINSIC WHICH RETURNS THE POINTER TO ZVAR IN THE
 ; CCR DICTIONARY. IT IS LAYGO, AS IT WILL ADD THE VARIABLE TO
 ; THE CCR DICTIONARY IF IT IS NOT THERE. ZTYP IS REQUIRED FOR LAYGO
 ;
 N ZCCRD,ZVARN,C0CFDA2
 S ZCCRD=170 ; FILE NUMBER FOR CCR DICTIONARY
 S ZVARN=$O(^C0CDIC(170,"B",ZVAR,"")) ;FIND IEN OF VARIABLE
 I ZVARN="" D  ; VARIABLE NOT IN CCR DICTIONARY - ADD IT
 . I '$D(ZTYP) D  Q  ; WON'T ADD A VARIABLE WITHOUT A TYPE
 . . W "CANNOT ADD VARIABLE WITHOUT A TYPE: ",ZVAR,!
 . S C0CFDA2(ZCCRD,"?+1,",.01)=ZVAR ; NAME OF NEW VARIABLE
 . S C0CFDA2(ZCCRD,"?+1,",12)=ZTYP ; TYPE EXTERNAL OF NEW VARIABLE
 . D CLEAN^DILF ;MAKE SURE ERRORS ARE CLEAN
 . D UPDATE^DIE("E","C0CFDA2","","ZERR") ;ADD VAR TO CCR DICTIONARY
 . I $D(ZERR) D  ; LAYGO ERROR
 . . W "ERROR ADDING "_ZC0CI_" TO CCR DICTIONARY",!
 . E  D  ;
 . . D CLEAN^DILF ; CLEAN UP
 . . S ZVARN=$O(^C0CDIC(170,"B",ZVAR,"")) ;FIND IEN OF VARIABLE
 . . W "ADDED ",ZVAR," TO CCR DICTIONARY, IEN:",ZVARN,!
 Q ZVARN
 ;
BLDTYPS ; ROUTINE TO POPULATE THE CCR NODE TYPES FILE (^C0CDIC(170.101,)
 ; THE CCR DICTIONARY (^C0CDIC(170, ) HAS MOST OF WHAT'S NEEDED
 ;
 N C0CDIC,C0CNODE ;
 S C0CDIC=$$FILEREF^C0CRNF(170) ; CLOSED FILE REFERENCE TO THE CCR DICTIONARY
 S C0CNODE=$$FILEREF^C0CRNF(170.101) ; CLOSED REF TO CCR NODE TYPE FILE
 Q
 ;
FIXSEC ;FIX THE SECTION FIELD OF THE CCR DICTIONARY.. IT HAS BEEN REDEFINED
 ; AS A POINTER TO CCR NODE TYPE INSTEAD OF BEING A SET
 ; THE SET VALUES ARE PRESERVED IN ^KBAI("SECTION") TO FACILITATE THIS
 ; CONVERSION
 ;N C0CC,C0CI,C0CJ,C0CN,C0CZX
 D FIELDS^C0CRNF("C0CC",170)
 S C0CI=""
 F  S C0CI=$O(^KBAI("SECTION",C0CI)) Q:C0CI=""  D  ; EACH SECTION
 . S C0CZX=""
 . F  S C0CZX=$O(^KBAI("SECTION",C0CI,C0CZX)) Q:C0CZX=""  D  ; EACH VARIABLE
 . . W "SECTION ",C0CI," VAR ",C0CZX
 . . S C0CV=$O(^C0CDIC(170.101,"B",C0CI,""))
 . . W " TYPE: ",C0CV,!
 . . D SETFDA("SECTION",C0CV)
 . . ;ZWR C0CFDA
 Q
 ;
SETFDA(C0CSN,C0CSV) ; INTERNAL ROUTINE TO MAKE AN FDA ENTRY FOR FIELD C0CSN
 ; TO SET TO VALUE C0CSV.
 ; C0CFDA,C0CC,C0CZX ARE ASSUMED FROM THE CALLING ROUTINE
 ; C0CSN,C0CSV ARE PASSED BY VALUE
 ;
 N C0CSI,C0CSJ
 S C0CSI=$$ZFILE(C0CSN,"C0CC") ; FILE NUMBER
 S C0CSJ=$$ZFIELD(C0CSN,"C0CC") ; FIELD NUMBER
 S C0CFDA(C0CSI,C0CZX_",",C0CSJ)=C0CSV
 Q
ZFILE(ZFN,ZTAB) ; EXTRINSIC TO RETURN FILE NUMBER FOR FIELD NAME PASSED
 ; BY VALUE IN ZFN. FILE NUMBER IS PIECE 1 OF C0CA(ZFN)
 ; IF ZTAB IS NULL, IT DEFAULTS TO C0CA
 I '$D(ZTAB) S ZTAB="C0CA"
 N ZR
 I $D(@ZTAB@(ZFN)) S ZR=$P(@ZTAB@(ZFN),"^",1)
 E  S ZR=""
 Q ZR
ZFIELD(ZFN,ZTAB) ;EXTRINSIC TO RETURN FIELD NUMBER FOR FIELD NAME PASSED
 ; BY VALUE IN ZFN. FILE NUMBER IS PIECE 2 OF C0CA(ZFN)
 ; IF ZTAB IS NULL, IT DEFAULTS TO C0CA
 I '$D(ZTAB) S ZTAB="C0CA"
 N ZR
 I $D(@ZTAB@(ZFN)) S ZR=$P(@ZTAB@(ZFN),"^",2)
 E  S ZR=""
 Q ZR
 ;
ZVALUE(ZFN,ZTAB) ;EXTRINSIC TO RETURN VALUE FOR FIELD NAME PASSED
 ; BY VALUE IN ZFN. FILE NUMBER IS PIECE 3 OF C0CA(ZFN)
 ; IF ZTAB IS NULL, IT DEFAULTS TO C0CA
 I '$D(ZTAB) S ZTAB="C0CA"
 N ZR
 I $D(@ZTAB@(ZFN)) S ZR=$P(@ZTAB@(ZFN),"^",3)
 E  S ZR=""
 Q ZR
 ;
