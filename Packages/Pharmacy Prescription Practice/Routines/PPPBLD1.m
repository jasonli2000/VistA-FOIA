PPPBLD1 ;ALB/DMB - BUILD FFX FROM CDROM : 3/4/92
 ;;1.0;PHARMACY PRESCRIPTION PRACTICE;**38,39**;APR 7,1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Reference to ^DIC(4) are covered by IA# 10090
 ;
BFFX(INARRY,OUTARRY,EXCARRY,LSTPROC) ; Build the Foreign Facility Xref
 ;
 N PPPTMP,BFFSEND,BFFSTRT,DA,DIC,DIE,DR,ERR,ERRARY1,ERRARY2,ERRORS
 N ERRTXT,FFXIFN,FFXLDOV,I,LOCKERR,MAXTM,MPDERR,MPDLDOV,PATDFN
 N RTRNSITE,SNIFN,SSN,STANO,STARTTM,STATUS,TEDTENT
 N TMP,TNEWENT,X,Y,MPDSTERR
 N BUFFER,GROUND
 ;
 S LOCKERR=-9004
 S MPDERR=-9014
 S MPDERR2=-9015
 S MPDSTERR=-9018
 S BFFSTRT=1012
 S BFFSEND=1013
 S RTRNSITE=1
 S BUFFER=5
 S GROUND=0
 S ERRARY1="^"_"TMP(""PPP"",$J,""ERR"","
 S ERRARY2="^"_"TMP(""PPP"",$J,""ERR"")"
 S @ERRARY2@(1)="The following errors occurred while running BFFX^PPPBLD1."
 S @ERRARY2@(2)=" "
 S MAXTM=7200
 I '$D(PPPMRT) S PPPMRT="BFFX_PPPBLD1"
 S (ERR,ERRORS,STATUS,TNEWENT,TEDTENT,TSSN)=0
 ;
LOCKFFX ; Attempt to lock the FFX file.  Exit if you can't
 ;
 L +(^PPP(1020.2)):60
 I '$T D  Q LOCKERR
 .S TMP=$$LOGEVNT^PPPMSC1(LOCKERR,PPPMRT)
 .S PPPTMP(1)="BFFX^PPPBLD1 -> FFX locked by another user."
 .S TMP=$$SNDBLTN^PPPMSC1("PPP NOTIFICATION","PRESCRIPTION PRACTICES","PPPTMP(")
 .K PPPTMP
 ;
 D FIND
STRTMPD ;VMP OIFO BAY PINES;ELR;PPP*1*38
 ;REMOVED START MPD PROCESS
 ;
 ;
 D GETDATA^PPPBLD1A
 ;
 K @OUTARRY,@ERRARY2,@EXCARRY
 Q ERR_"^"_TNEWENT_"^"_TEDTENT
 ;
FIND ;VMP OIFO BAY PINES;ELR;PPP*1*38
 ; GET PATIENT/VISIT DATA
 NEW DATA,PPPDA,PPPDATA,PPPDFN,PPPSITE,PPPSSN,PPPVST,PPPX1
 S PPPSSN=0
 F  S PPPSSN=$O(@INARRY@(PPPSSN)) Q:PPPSSN=""  D
 .S PPPDFN=+$$GETDFN^PPPGET1(PPPSSN)
 .I $G(PPPDFN)'>0 S @OUTARRY@("DONE",PPPSSN)="",@OUTARRY@(PPPSSN,"FOUND")="-1^Could not find SSN "_PPPSSN_" in Patient File." Q
 .K PPPDATA D TFL^VAFCTFU1(.PPPDATA,PPPDFN) ;Supported IA #2990
 .S PPPX1=0
 .F  S PPPX1=$O(PPPDATA(PPPX1)) Q:PPPX1'>0  S DATA=PPPDATA(PPPX1) D
 ..Q:$P(DATA,"^",5)'="VAMC"
 ..S PPPSITE=$P(DATA,"^",1)
 ..Q:PPPSITE=$P($G(^PPP(1020.1,1,0)),"^",9)
 ..S PPPVST=$P($P(DATA,"^",3),".")
 ..;VMP OIFO BAY PINES;VGF;PPP*1.0*39
 ..N PPPIIEN
 ..S PPPIIEN=$O(^DIC(4,"D",PPPSITE,0))
 ..S @OUTARRY@(PPPSSN,"SITES",PPPIIEN)=PPPVST
 .S @OUTARRY@("DONE",PPPSSN)=""
 .S @OUTARRY@(PPPSSN,"FOUND")="1"
 S @OUTARRY@("STATUS")="1^"          ;1 MEANS NO ERRORS (AS THERE IS NO LONGER A CD ROM SERVER) SO NO MSG SENT IN PIECE 2
 Q
