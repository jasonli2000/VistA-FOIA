ONCPST40 ;Hines OIFO/GWB - POST-INSTALL ROUTINE FOR PATCH ONC*2.11*40 ; 6/8/04 11:01am
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 ;Set the COLLABORATIVE STAGING URL (160.1,19) value in all ONCOLOGY
 ;SITE PARAMETERS entries with the value:
 ;"http://vaww.va.gov/cstage/cgi-bin/cstage.exe"
 S RC=$$UPDCSURL^ONCSAPIU("http://vaww.va.gov/cstage/cgi-bin/cstage.exe")
 ;
 ;Delete CODE (164.52,1) multiple and DATA from ONC CS SITE-SPECIFIC
 ;FACTORS (164.52) file
 S DIU=164.521,DIU(0)="DS" D EN^DIU2 K DIU
 ;
 ;Check the DNS functionality
 D CHECKDNS()
 ;
ITEM17 ;ROADS to FORDS Conversion Errata
 ;3. PALLIATIVE CARE (165.5,12) and PALLIATIVE CARE @FAC (165.5,13)
 S CTR=0 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .S PC=$P($G(^ONCO(165.5,IEN,3.1)),U,26)
 .S PCFAC=$P($G(^ONCO(165.5,IEN,3.1)),U,27)
 .S IR=$P($G(^ONCO(165.5,IEN,3)),U,29)
 .I (PC=0)!(PC=9),(IR=4)!(IR=5) S $P(^ONCO(165.5,IEN,3.1),U,26)=2
 .I PC=1,(IR=4)!(IR=5) S $P(^ONCO(165.5,IEN,3.1),U,26)=5
 .I (PCFAC=0)!(PCFAC=9),(IR=4)!(IR=5) S $P(^ONCO(165.5,IEN,3.1),U,27)=2
 .I PCFAC=1,(IR=4)!(IR=5) S $P(^ONCO(165.5,IEN,3.1),U,27)=5
 Q
 ;
 ;***** CHECKS THE DNS FUNCTIONALITY
CHECKDNS() ;
 N HOST,IPADDR,RC,URL
 D BMES^XPDUTL("   Checking the DNS functionality...")
 ;--- Get the CS server URL
 S URL=$$GETCSURL^ONCSAPIU()
 ;--- Parse the URL
 S RC=$$PARSE^ONCXURL(URL,.HOST)
 I RC<0  D MES($P(RC,U,2))  Q
 ;--- Try to resolve the host name into IP address(es)
 I HOST'?1.3N3(1"."1.3N)  D  Q:IPADDR=""
 . S IPADDR=$$ADDRESS^XLFNSLK(HOST)  Q:IPADDR'=""
 . D MES("Cannot resolve the Collaborative Staging server name")
 . D MES("('"_HOST_"') into an IP address.")
 . D MES("Please check if the DNS IP field of the Kernel Site")
 . D MES("Parameters contains a valid IP address of an active DNS")
 . D MES("server.")
 ;--- Success
 D MES("DNS check has been completed successfully.")
 Q
 ;
 ;***** INDENTS THE MESSAGE TEXT
 ;
 ; TEXT          Message text
 ;
MES(TEXT) ;
 D MES^XPDUTL("   "_TEXT)
 Q
