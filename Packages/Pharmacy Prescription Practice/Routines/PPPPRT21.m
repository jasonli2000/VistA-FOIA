PPPPRT21 ;ALB/DMB - FFX PRINT ROUTINES ; 3/13/92
 ;;V1.0;PHARMACY PRESCRIPTION PRACTICE;**10**;APR 7,1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PRTBYSTA ; Print the FFX file by station
 ;
 N PPPARRY,PPPMRT,DROOT,HROOT,PRTFFXST,PRTFFXND,BLINE,X,TMP
 N PATNAME,PATINFO,PATDOB,PATSSN
 N STANAME,STAINFO,STANUM,DOMAIN,LDOV
 N HDRCNT
 ;
 S (VALMCNT,HDRCNT)=0
 ;
 S DROOT="^TMP(""PPPL6"",$J)"
 S HROOT="^TMP(""PPPL6"",$J,""HDR"")"
 S PPPARRY="^TMP(""PPP"",$J,""SRT"")"
 ;
 K @DROOT,@HROOT,@PPPARRY
 ;
 S PPPMRT="PRTBYSTA_PPPPRT21"
 S PRTFFXST=1017
 S PRTFFXND=1018
 ;
 S TMP=$$LOGEVNT^PPPMSC1(PRTFFXST,PPPMRT)
 ;
 D HDR2
 S TMP=$$SRTBYSTA^PPPPRT4(PPPARRY) ; -- Sorts data
 D ORDER1
 S TMP=$$LOGEVNT^PPPMSC1(PRTFFXND,PPPMRT)
 ; -- Clean up
 K DIR,DIE
 K @PPPARRY
 Q
 ;
HDR2 ; Write the heading
 ;
 S BLINE=$$SETSTR^VALM1(" ","",1,80)
 ;
 S X=$$CENTER^PPPUTL1(BLINE,"PPP Foreign Facility Xref File")
 D TMPHDR
 S X=$$CENTER^PPPUTL1(BLINE,"by station as of --> "_$$I2EDT^PPPCNV1(DT))
 D TMPHDR
 S X=" " D TMPHDR
 S X=$$SETSTR^VALM1("FACILITY NAME","",1,45)
 S X=$$SETSTR^VALM1("NUMBER",X,46,15)
 S X=$$SETSTR^VALM1("DOMAIN",X,61,20)
 D TMPHDR
 S X=$$SETSTR^VALM1("PATIENT NAME","",2,28)
 S X=$$SETSTR^VALM1("SSN",X,31,15)
 S X=$$SETSTR^VALM1("DOB",X,46,15)
 S X=$$SETSTR^VALM1("LAST VISIT",X,61,20)
 D TMPHDR
 Q
 ;
ORDER1 ; -- First line
 ;
 S STANAME=""
 F I1=0:0 D  Q:STANAME=""
 .S STANAME=$O(@PPPARRY@(STANAME)) Q:STANAME=""
 .S STAINFO=@PPPARRY@(STANAME) Q:STAINFO=""
 .S STANUM=$P(STAINFO,"^")
 .S DOMAIN=$E($P(STAINFO,"^",2),1,18)
 .S X=$$SETSTR^VALM1(STANAME,"",1,45)
 .S X=$$SETSTR^VALM1(STANUM,X,46,15)
 .S X=$$SETSTR^VALM1(DOMAIN,X,61,20)
 .D TMP
 .;
ORDER2 .; -- Second line
 .;
 .S PATNAME=""
 .F I2=0:0 D  Q:PATNAME=""
 ..S PATNAME=$O(@PPPARRY@(STANAME,PATNAME)) Q:PATNAME=""
 ..S PATINFO=@PPPARRY@(STANAME,PATNAME) Q:PATINFO=""
 ..S PATDOB=$P(PATINFO,"^")
 ..S PATSSN=$P(PATINFO,"^",2)
 ..S LDOV=$P(PATINFO,"^",3)
 ..S X=$$SETSTR^VALM1(PATNAME,"",2,28)
 ..S X=$$SETSTR^VALM1($E(PATSSN,1,3)_"-"_$E(PATSSN,4,5)_"-"_$E(PATSSN,6,9),X,31,15)
 ..S X=$$SETSTR^VALM1(PATDOB,X,46,15)
 ..S X=$$SETSTR^VALM1(LDOV,X,61,20)
 ..D TMP
 .S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 Q
 ;
TMP ; -- Sets up data display array
 S VALMCNT=VALMCNT+1
 S @DROOT@(VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
TMPHDR ; -- Sets up header display array
 S HDRCNT=HDRCNT+1
 S @HROOT@(HDRCNT)=$E(X,1,79)
 QUIT
 ;
ERRMSG ;Error message
 I $G(@PHRMARRY@(RVRSDT,STAPTR,"PID")) S PID=@PHRMARRY@(RVRSDT,STAPTR,"PID") D
 .S PIDNAM=$P(PID,"^",1),Y=$P(PID,"^",3) X ^DD("DD") S PIDDOB=Y,PIDSSN=$P(PID,"^",2)
 .I PIDNAM'=PPPNAME W !!," ** WARNING ** Patient's Name ",PIDNAME," does not match ",PPPNAME
 .I PIDSSN'=PPPSSN W !," ** WARNING ** Patient's SSN ",PIDSSN," does not match ",PPPSSN
 .I PIDDOB'=PPPDOB W !," ** WARNING ** Patient's DOB ",PIDDOB," does not match ",PPPDOB
 .K PIDDOB,PIDNAM,@PHRMARRY@(RVRSDT,STAPTR,"PID")
 Q