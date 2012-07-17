DG284PT2 ;ALB/SEK DG*5.3*284 POST-INSTALL TO MAILMAN MSG ; 04/20/00
 ;;5.3;Registration;**284**;Aug 13, 1993
 ;
 ;This routine will be run as part of the post-install for patch
 ;DG*5.3*284
 ;
 ;A mail message will be sent to the HEC and the user
 ;when the post-install is complete.
 ;
 ;
MAIL ; Send a mailman msg to user/HEC with results
 N DIFROM,%
 N IVMCX,IVMDATA,IVMDATA1,IVMFILE,IVMFLD,IVMIENX,IVMIY,IVMNODE,IVMTEXT,IVMX,I
 N X,XMDUZ,XMSUB,XMTEXT,XMY,Y,IVMSTA
 K ^TMP("DG284PT",$J)
 S IVMCX=$$SITE^VASITE,IVMSTA=$P(IVMCX,"^",3)
 S XMSUB=IVMSTA_" - Purge of non CAT C IVM verified Means Tests"
 S XMDUZ="IVM/HEC PACKAGE",XMY("HARBIN,LYNNE@IVM.VA.GOV")="",XMY(DUZ)="",XMY(.5)="",XMY("PERREAULT,JEAN@IVM.VA.GOV")=""
 S XMY("PICKELSIMER,HENRY@IVM.VA.GOV")="",XMY("STEFFEY,KIM@IVM.VA.GOV")=""
 S XMY("ARMOUR,EDDIE@IVM.VA.GOV")="",XMY("WHITFIELD,VENIS@IVM.VA.GOV")=""
 S XMTEXT="^TMP(""DG284PT"",$J,"
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP("DG284PT",$J,1)="Purge of non CAT C IVM verified Means Tests"
 S ^TMP("DG284PT",$J,2)="  "
 S ^TMP("DG284PT",$J,3)="Facility Name:         "_$P(IVMCX,"^",2)_"         "_Y
 S ^TMP("DG284PT",$J,4)="Station Number:        "_IVMSTA
 S ^TMP("DG284PT",$J,5)="  "
 S IVMTEXT="Income year"
 S IVMTEXT=$$BLDSTR^DG284PT1("# of IVM MT purged",IVMTEXT,20,18)
 S ^TMP("DG284PT",$J,6)=IVMTEXT
 S IVMTEXT=$$REPEAT^XLFSTR("=",$L(IVMTEXT))
 S ^TMP("DG284PT",$J,7)=IVMTEXT
 S IVMIY=0,IVMNODE=7
 F  S IVMIY=$O(^XTMP("DGMTPAT",IVMIY)) Q:'IVMIY  D
 .S IVMDATA=^XTMP("DGMTPAT",IVMIY)
 .S IVMTEXT=IVMIY+1700
 .S IVMDATA1=$J(+$P(IVMDATA,U),6)
 .S IVMTEXT=$$BLDSTR^DG284PT1(IVMDATA1,IVMTEXT,20,$L(IVMDATA1))
 .S IVMNODE=IVMNODE+1
 .S ^TMP("DG284PT",$J,IVMNODE)=IVMTEXT
 F I=1:1:2 S IVMNODE=IVMNODE+1,^TMP("DG284PT",$J,IVMNODE)=" "
 ;
 ; add error reports to the mail message...
 I $O(^XTMP("DGMTPERR",0))'="" D
 .S IVMNODE=IVMNODE+1
 .S ^TMP("DG284PT",$J,IVMNODE)="Some records were not edited due to filing errors:"
 .S IVMNODE=IVMNODE+1
 .S ^TMP("DG284PT",$J,IVMNODE)=" "
 .S IVMTEXT="File #"
 .S IVMTEXT=$$BLDSTR^DG284PT1("Record #",IVMTEXT,12,8)
 .S IVMTEXT=$$BLDSTR^DG284PT1("Field #",IVMTEXT,22,7)
 .S IVMTEXT=$$BLDSTR^DG284PT1("Error Message",IVMTEXT,30,13)
 .S IVMNODE=IVMNODE+1
 .S ^TMP("DG284PT",$J,IVMNODE)=IVMTEXT
 .K IVMTEXT
 .S IVMFILE=0
 .F  S IVMFILE=$O(^XTMP("DGMTPERR",IVMFILE)) Q:'IVMFILE  D
 ..S IVMTEXT=IVMFILE
 ..S IVMIENX=0
 ..F  S IVMIENX=$O(^XTMP("DGMTPERR",IVMFILE,IVMIENX)) Q:'IVMIENX  D
 ...S IVMFLD=0
 ...F  S IVMFLD=$O(^XTMP("DGMTPERR",IVMFILE,IVMIENX,IVMFLD)) Q:'IVMFLD  D
 ....S IVMX=0
 ....F  S IVMX=$O(^XTMP("DGMTPERR",IVMFILE,IVMIENX,IVMFLD,IVMX)) Q:'IVMX  D
 .....S IVMDATA=^XTMP("DGMTPERR",IVMFILE,IVMIENX,IVMFLD,IVMX)
 .....S IVMTEXT=$$BLDSTR^DG284PT1(IVMIENX,IVMTEXT,12,$L(IVMIENX))
 .....S IVMTEXT=$$BLDSTR^DG284PT1(IVMFLD,IVMTEXT,22,$L(IVMFLD))
 .....S IVMTEXT=$$BLDSTR^DG284PT1(IVMDATA,IVMTEXT,30,$L(IVMDATA))
 .....S IVMNODE=IVMNODE+1
 .....S ^TMP("DG284PT",$J,IVMNODE)=IVMTEXT
 .....K IVMDATA
 ....K IVMX
 ...K IVMFLD
 ..K IVMIENX
 .K IVMFILE,IVMTEXT
 ;
MAIL1 D ^XMD
 K ^TMP("DG284PT",$J)
 Q
