ECXAPRO ;ALB/GTS - PRO Extract Audit Report ; July 20, 1998
 ;;3.0;DSS EXTRACTS;**9**;Dec 22, 1997
 ;
MSG(ECXGRP,ECXBDT,ECXEDT,ECXEBDT,ECXEEDT,ECINST,EC23,QFLG,ECSTAT) ;Send bulletin after extract completes
 ;
 ; Input
 ;  ECXGRP    - Mail Group to send bulletin to
 ;  ECXBDT    - FM formated Beginning Date (Set by ECXTRAC)
 ;  ECXEDT    - FM formated End Date (Set by ECXTRAC)
 ;  ECXEBDT   - Externally formated Start Date (Set by ECXTRAC)
 ;  ECXEEDT   - Externally formated End Date (Set by ECXTRAC)
 ;  ECXINST   - IEN of division (Set by ECXTRAC)
 ;  EC23      - 2ND & 3RD pieces of ^ECX(727.826,DA,0) (Set by ECXTRAC)
 ;  QFLG      - Flag (1 indicates TaskMan stop, 0 indicates continue)
 ;  ECSTAT    - Station number (Set by ECXTRAC)
 ;
 ; Output
 ;  ECXSXS    - 1 for a successful message; 0 for unsuccessful message
 ;
 N ECXSXS,ECXBUL
 S ECXSXS=0
 S ECXBUL=1
 D BEGIN ;* Start the HCPCS cost report bulletin generation
 K XMY S XMY(ECXGRP_"@"_^XMB("NETNAME"))=""
 S XMDUZ="DSS SYSTEM"
 S XMSUB=ECSTAT_" Prosthetics DSS Extract HCPCS Cost Report Message"
 S XMN=0
 S XMTEXT="^TMP(""ECX-PRO"",$J,"
 D ^XMD
 S:(+XMZ>0) ECXSXS=1
 K ^TMP("ECX-PRO",$J),XMDUZ,XMSUB,XMTEXT,XMY
 Q ECXSXS
 ;
BEGIN ;* Start the reporting process
 ;
 ; Input
 ;  ECXBUL    - If defined, date range is not prompted
 ;               (Optional - Set by MSG^ECXAPRO)
 ;  ECXBDT    - FM formated Beginning Date (Optional)
 ;               (May be passed from ECXTRAC - Prompted if not)
 ;  ECXEDT    - FM formated End Date (Optional)
 ;               (May be passed from ECXTRAC - Prompted if not)
 ;  ECXEBDT   - Externally formated Start Date (Optional)
 ;               (May be passed from ECXTRAC - Prompted if not)
 ;  ECXEEDT   - Externally formated End Date (Optional)
 ;               (May be passed from ECXTRAC - Prompted if not)
 ;  ECINST    - Division being extracted (Optional)
 ;               (May be set by ECXTRAC - Prompted if not)
 ;  ECXINST   - Division IEN being extracted (Optional)
 ;               (May be set by ECXTRAC - Prompted if not)
 ;  EC23      - YEARMONTH (YYYYMM) ^ Extract # (Optional)
 ;               (May be set by ECXTRAC)
 ;  QFLG      - TaskMan stop flag (Optional - may be set by ECXTRAC)
 ;
 ; Output
 ;  ^TMP("ECX-PRO",$J - Global if report is sent in a message (Optional)
 ;
 N ECXRNG,ECXERR
 S ECXPGCT=0
 I '$D(ECXBUL) DO
 .S ECXRNG=$$DTRNG^ECXUTL1()
 .I +ECXRNG>0 DO
 ..S ECXBDT=+ECXRNG
 ..S ECXEDT=$P(ECXRNG,"^",2)
 ..S ECXEBDT=$$FMTE^XLFDT(ECXBDT)
 ..S ECXEEDT=$$FMTE^XLFDT(ECXEDT)
 ..S (ECXINST,ECINST)=$$PDIV^ECXPUTL()
 ..S:'ECINST ECXERR=1
 .I +ECXRNG'>0 S ECXERR=1
 ;
 Q:($D(ECXERR))  ;*QUIT out of the middle if user doesn't answer prompts
 ;
 S ECXFYDTS=$$CYFY^ECXUTL1(ECXBDT)
 S ECXEBFY=$$FMTE^XLFDT($P(ECXFYDTS,"^",3))
 K ECXDIC S DA=ECXINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01"
 D EN^DIQ1 S ECXDIV=$G(ECXDIC(4,DA,.01,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S:('$D(QFLG)) QFLG=0
 ;
 ;* Get Station Number
 I '$D(ECSTAT) DO
 .K ECXDIC S DA=ECXINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECSTAT=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ;
 I '$D(ECXBUL) DO
 .S ECXRPHD1="                      Prosthetics Extract HCPCS Cost Report"
 .S ECXRPHD2="                      Division: "_ECXDIV
 .S ECXRPHD3="                      Date Range: "_ECXEBDT_" to "_ECXEEDT
 .S ECXETDDT=$$FMTE^XLFDT(DT)
 .S ECXRPHD4="                      Date Report Run: "_ECXETDDT
 S ECXHD1A="                      PERIOD COSTS "_ECXEBDT_" to "_ECXEEDT
 S ECXHD1B="                                                       Lab      Lab       Lab"
 S ECXHD1C="                                                       Avg      Avg       Avg"
 S ECXHD1D="                            Tot        Tot     Avg     Labor    Matrl     Comb"
 S ECXHD1E="HCPCS Code                  Qty        Cost    Cost    Cost     Cost      Cost"
 ;
 S ECXHD2A="             YEAR TO DATE COSTS "_ECXEBFY_" to "_ECXEEDT
 S ECXHD2B="                                                       YTD      YTD       YTD"
 S ECXHD2C="                                                       Lab      Lab       Lab"
 S ECXHD2D="                            YTD        YTD     YTD     Avg      Avg       Avg"
 S ECXHD2E="                            Tot        Tot     Avg     Labor    Matrl     Comb"
 S ECXHD2F="HCPCS Code                  Qty        Cost    Cost    Cost     Cost      Cost"
 I $D(ECXBUL) DO
 .S ^TMP("ECX-PRO",$J,1)="The DSS Prosthetic Extract #"_$P(EC23,"^",2)_" for "_ECXEBDT_" through "_ECXEEDT
 .S ^TMP("ECX-PRO",$J,2)=" has completed.  The following is provided for the HCPCS costs."
 .S ^TMP("ECX-PRO",$J,3)=" "
 .S ^TMP("ECX-PRO",$J,4)=ECXHD1A
 .S ^TMP("ECX-PRO",$J,5)=" "
 .S ^TMP("ECX-PRO",$J,6)=ECXHD1B
 .S ^TMP("ECX-PRO",$J,7)=ECXHD1C
 .S ^TMP("ECX-PRO",$J,8)=ECXHD1D
 .S ^TMP("ECX-PRO",$J,9)=ECXHD1E
 .S ECXTMPCT=10
 .;
 .D DTRNGRPT^ECXAPRO2 ;* Report Date Range information
 .;
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2A
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2B
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2C
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2D
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2E
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXHD2F
 .S ECXTMPCT=ECXTMPCT+1
 .S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 .S ECXTMPCT=ECXTMPCT+1
 .;
 .D YTDRPT^ECXAPRO1
 .;
 .D VARKIL^ECXAPRO1
 ;
 I '$D(ECXBUL) DO
 .S %ZIS="AEQ"
 .S %ZIS("A")="Output device: "
 .D ^%ZIS
 .I POP D VARKIL^ECXAPRO1
 .I 'POP DO
 ..I $D(IO("Q")) DO
 ...S ZTRTN="ECXARPT^ECXAPRO1",ZTIO=ION
 ...S ZTDESC="DSS Prosthetics HCPCS Cost Report"
 ...N ECXI
 ...F ECXI="ECSTAT","ECXFYDTS","ECXEBFY","ECXRPHD*","ECXETDDT","ECXHD*","ECXDIV","ECINST","ECXINST","ECXBDT","ECXEDT","ECXEBDT","ECXEEDT","ECXBFY","ECXPGCT","QFLG" S ZTSAVE(ECXI)=""
 ...D ^%ZTLOAD
 ...I $D(ZTSK) W !!,"HCPCS Report Queued",!! K ZTSK
 ..I '$D(IO("Q")) DO ECXARPT^ECXAPRO1
 .D ^%ZISC
 Q
