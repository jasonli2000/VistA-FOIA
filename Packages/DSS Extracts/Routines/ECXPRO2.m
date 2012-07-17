ECXPRO2 ;ALB/GTS - Prosthetics Extract for DSS (Continued) ; July 16, 1998
 ;;3.0;DSS EXTRACTS;**9**;Dec 22, 1997
 ;
ECXBUL(ECXLNE,ECXEBDT,ECXEEDT,ECNUM) ;* Set up the header for the exception msg
 ;
 ;   Input
 ;    ECXLNE  - The line number variable (passed by reference)
 ;    ECXEBDT - The Externally formated beginning date
 ;    ECXEEDT - The Externally formated ending date
 ;    ECNUM   - The Extract reference number
 ;
 ;   Output
 ;    ^TMP("ECX-PRO EXC",$J) - Array for the exception message
 ;    ECXLNE                 - The number of the next line in the msg
 ;
 S ^TMP("ECX-PRO EXC",$J,1)=" "
 S ^TMP("ECX-PRO EXC",$J,2)="The DSS-Prosthetic extract (#"_ECNUM_") for "_ECXEBDT_" through "_ECXEEDT
 S ^TMP("ECX-PRO EXC",$J,3)="has completed.  The following is a list of extract records that were NOT"
 S ^TMP("ECX-PRO EXC",$J,4)="created due to missing information in the Record of Pros Appliance/Repair"
 S ^TMP("ECX-PRO EXC",$J,5)="file (#660).  The Prosthetics record should be reviewed and the missing"
 S ^TMP("ECX-PRO EXC",$J,6)="information completed.  Once the missing information has been entered, it"
 S ^TMP("ECX-PRO EXC",$J,7)="will be necessary to re-generate the Prosthetics Extract for the above noted"
 S ^TMP("ECX-PRO EXC",$J,8)="time period.  To avoid duplicate records in the Prosthetics Extract, you"
 S ^TMP("ECX-PRO EXC",$J,9)="should purge the Prosthetics Extract before re-generating."
 S ^TMP("ECX-PRO EXC",$J,10)=" "
 S ^TMP("ECX-PRO EXC",$J,11)=" "
 S ^TMP("ECX-PRO EXC",$J,12)=" PROSTHETICS FILE (#660)         MISSING DATA"
 S ^TMP("ECX-PRO EXC",$J,13)="       IEN                         ELEMENTS"
 S ^TMP("ECX-PRO EXC",$J,14)=" "
 S ECXLNE=15
 Q
 ;
ECXMISLN(ECXMISS,ECXLNE,ECXPIEN) ;** Report Missing Lines
 N ECXPCE,ECXFIRST,ECXFIELD
 S ECXFIRST=1
 F ECXPCE=1:1:11 DO
 .I +$P(ECXMISS,"^",ECXPCE) DO
 ..S ECXFIELD=$P($T(ECXFLD+ECXPCE),";;",2)
 ..I 'ECXFIRST S ^TMP("ECX-PRO EXC",$J,ECXLNE)="                                   "_ECXFIELD
 ..I ECXFIRST DO
 ...S ^TMP("ECX-PRO EXC",$J,ECXLNE)="       "_ECXPIEN_"                          "_ECXFIELD
 ...S ECXFIRST=0
 ..S ECXLNE=ECXLNE+1
 S ^TMP("ECX-PRO EXC",$J,ECXLNE)=" "
 S ECXLNE=ECXLNE+1
 Q
 ;
ECXFLD ;* Missing Required fields
 ;;STATION
 ;;PATIENT NAME (In Prosthetics)
 ;;SSN
 ;;NAME (In Patient file - #2)
 ;;DELIVERY DATE
 ;;TYPE OF TRANSACTION
 ;;SOURCE
 ;;HCPCS
 ;;REQUESTING STATION
 ;;FORM REQUESTED ON
 ;;RECEIVING STATION
 Q
 ;
FEEDINFO(ECXSRCE,ECXHCPCS,ECXTYPE,ECXSTAT,ECXRQST,ECXRCST,ECXFORM) ;* FDRs
 ;Get Feeder Key and Feeder Location
 ;  
 ;   Input
 ;    ECXSTAT   - Station Number for extract
 ;    ECXTYPE   - Type of Transaction work performed
 ;    ECXSRCE   - Source of prosthesis
 ;    ECXHCPCS  - HCPCS code for prosthesis
 ;    ECXRQST   - Requesting Station
 ;    ECXRCST   - Receiving Station
 ;    ECXFORM   - Form Requested on 
 ;
 ;   Output (to be KILLed by calling routine)
 ;    ECXFELOC  - Feeder Location
 ;    ECXFEKEY  - Feeder Key
 ;
 ;* NOTE: If a Station # <> Requesting Station
 ;*         AND
 ;*       Station # <> Receiving Station
 ;*  The Feeder Location will be NULL.  This may indicate a Prosthetics
 ;*   data entry Problem per conversation with Helen Corkwell.
 ;
 S ECXFELOC=""
 S ECXFEKEY=ECXHCPCS_$S(ECXTYPE="X":"X",1:"N")_ECXSRCE
 ;
 ;* If processing a Lab Transaction
 I +ECXFORM=4 DO
 .I (ECXSTAT=ECXRCST),(ECXSTAT'=ECXRQST) DO
 ..S ECXFELOC=ECXRCST_"LAB"
 ..S ECXFEKEY=ECXFEKEY_ECXRQST_"REQ"
 .I ECXSTAT=ECXRQST DO
 ..S ECXFELOC=ECXRQST_"ORD"
 ..S ECXFEKEY=ECXFEKEY_ECXRCST_"REC"
 ;
 ;* If processing a Non-Lab Transaction
 I +ECXFORM'=4 S ECXFELOC=ECXSTAT_"NONL"
 Q
