ECXAPRO1 ;ALB/GTS -  PRO Extract Audit Report (Cont) ; July 20, 1998
 ;;3.0;DSS EXTRACTS;**9**;Dec 22, 1997
 ;
DTRGHD ;* Output the date range report heading
 ; Input
 ;  ECXRPHD1
 ;  ECXRPHD2
 ;  ECXRPHD3
 ;  ECXRPHD4  - Intro heading lines for Date Range Report (not bulletin)
 ;
 ; Output
 ;  ECXPGCT - Page counter value
 ;
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I ECXPGCT>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 I QFLG=0 DO
 .W:$Y!($E(IOST)="C") @IOF
 .S ECXPGCT=ECXPGCT+1
 .W !,?68,"Page: ",ECXPGCT,!
 .W !,ECXRPHD1
 .W !,ECXRPHD2
 .W !,ECXRPHD3
 .W !,ECXRPHD4,!!
 .W !,ECXHD1A,!
 .W !,ECXHD1B
 .W !,ECXHD1C
 .W !,ECXHD1D
 .W !,ECXHD1E,!
 Q
 ;
DTRGRPT(ECXLINE) ;* Report a line of Date Range text
 ;
 ; Input
 ;  ECXLINE - A line of text to report
 ;
 D:($Y+2)>IOSL DTRGHD
 W !,ECXLINE
 Q
 ;
YTDLINE(ECXLINE) ;* Report a line of YTD text
 ;
 ; Input
 ;  ECXLINE - A line of text to report
 ;
 D:($Y+2)>IOSL YTDHD
 W !,ECXLINE
 Q
 ;
TMP(ECXLINE) ;* Add a line to the TMP global for the HCPCS cost report bulletin
 ;
 ; Input
 ;  ECXLINE  - A line of output for the HCPCS Cost report bulletin
 ;  ECXTMPCT - The value of the current line for the TMP global
 ;
 ; Output
 ;  ^TMP("ECX-PRO",$J - Global for HCPCS report bulletin
 ;  ECXTMPCT - The value of the next line in the TMP global
 ;
 S ^TMP("ECX-PRO",$J,ECXTMPCT)=ECXLINE
 S ECXTMPCT=ECXTMPCT+1
 Q
 ;
YTDRPT ;* Create a report/bulletin of fiscal year to date prosthetics work
 ;
 ; Input
 ;  ECXBUL    - If defined, date range is not prompted
 ;               (Optional - Set by MSG^ECXAPRO)
 ;  ECXFYDTS  - FM formated Calendar & Fiscal year beginning & end dates
 ;  ECXEBFY   - Externally formated Begin Date (KILLed by calling rtn)
 ;  ECXEDT    - FM formated End Date (KILLed by calling rtn)
 ;  ECXEBDT   - Externally formated Start Date
 ;  ECXEEDT   - Externally formated End Date (KILLed by calling rtn)
 ;  ECXTMPCT  - Set if a bulletin is to be sent (KILLed by calling rtn)
 ;  ECSTAT    - Station number of selected division to report
 ;  QFLG      - TaskMan stop flag
 ;  ^TMP("ECX-PRO",$J - Global if report is sent in a message (Optional)
 ;
 ; Output
 ;  ^TMP("ECX-PRO",$J - Global if report is sent in a message (Optional)
 ;
 N ECXINFO
 I QFLG=0 DO
 .I '$D(ECXBUL) S ECX1ST="" D YTDHD K ECX1ST
 .N ECXLPGRP,ECXLPPCE,ECXPRDA,ECXCPTDA,ECXCPT,ECXN0
 .N ECXQTY,ECXCTRA,ECXLLC,ECXLMC,ECXPRDA,ECXLINE,ECXSPC1,ECXSPC2,ECXSPC3
 .N ECXSPC4,ECXSPC5,ECXSPC6,ECXLAMC,ECXLALC,ECXLPEND,ECXCGRPR
 .;
 .;*Total the HCPCS costs for reporting
 .S ECXLPDT=$$ECXYM^ECXUTL($P(ECXFYDTS,"^",3))
 .S ECXLPDT=$$ECXDATE^ECXUTL($P(ECXFYDTS,"^",3),ECXLPDT)-1
 .S ECXLPEND=$$ECXYM^ECXUTL(ECXEDT)
 .S ECXLPEND=$$ECXDATE^ECXUTL(ECXEDT,ECXLPEND)
 .F  S ECXLPDT=$O(^ECX(727.826,"AG",ECXLPDT)) Q:(ECXLPDT>ECXLPEND)  Q:(+ECXLPDT=0)  Q:(QFLG=1)  DO
 ..S ECXLPGRP=""
 ..F  S ECXLPGRP=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP)) Q:(ECXLPGRP="")  Q:(QFLG=1)  DO
 ...S ECXLPPCE=""
 ...F  S ECXLPPCE=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP,ECXLPPCE)) Q:(ECXLPPCE="")  Q:(QFLG=1)  DO
 ....S ECXPRDA=""
 ....F  S ECXPRDA=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP,ECXLPPCE,ECXPRDA)) Q:(+ECXPRDA=0)  Q:(QFLG=1)  DO
 .....S ECXN0=$G(^ECX(727.826,ECXPRDA,0))
 .....I ECSTAT=$E($$STRIP^ECXUTL1($P(ECXN0,"^",4),5,"B"),1,3) DO
 ......S ECXINFO=1
 ......S ECXCPT=$$STRIP^ECXUTL1(ECXLPPCE,8,"B") ;* Remove blanks
 ......S ECXCPTDA=$O(^ICPT("B",ECXCPT,""))
 ......;
 ......;*Set up variables of data to report
 ......S ECXCDNME=$P(^ICPT(ECXCPTDA,0),"^",1)_" "_$P(^ICPT(ECXCPTDA,0),"^",2)
 ......S ECXQTY=$$STRIP^ECXUTL1($P(ECXN0,"^",12),4,"F")
 ......S ECXCTRA=$$STRIP^ECXUTL1($P(ECXN0,"^",21),9,"F")
 ......S ECXLLC=$$STRIP^ECXUTL1($P(ECXN0,"^",22),7,"F")
 ......S ECXLMC=$$STRIP^ECXUTL1($P(ECXN0,"^",23),7,"F")
 ......;
 ......;*Total Quantity, Pros. cost, Lab Labor cost and Lab Mat. cost
 ......I $D(^TMP("ECX-HCPCS",$J,ECXCDNME,"QTY")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"QTY")=^TMP("ECX-HCPCS",$J,ECXCDNME,"QTY")+ECXQTY
 ......I '$D(^TMP("ECX-HCPCS",$J,ECXCDNME,"QTY")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"QTY")=ECXQTY
 ......I $D(^TMP("ECX-HCPCS",$J,ECXCDNME,"TRAN COST")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"TRAN COST")=^TMP("ECX-HCPCS",$J,ECXCDNME,"TRAN COST")+ECXCTRA
 ......I '$D(^TMP("ECX-HCPCS",$J,ECXCDNME,"TRAN COST")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"TRAN COST")=ECXCTRA
 ......I $D(^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB LABOR")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB LABOR")=^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB LABOR")+ECXLLC
 ......I '$D(^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB LABOR")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB LABOR")=ECXLLC
 ......I $D(^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB MAT")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB MAT")=^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB MAT")+ECXLMC
 ......I '$D(^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB MAT")) DO
 .......S ^TMP("ECX-HCPCS",$J,ECXCDNME,"LAB MAT")=ECXLMC
 ......I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ S QFLG=1
 ;
 ;*Report YTD totals
 I QFLG=0 DO
 .N ECXAVCT,ECXLALC,ECXLAMC,ECXLACCT,ECXCDNLP
 .S ECXCDNLP=""
 .F  S ECXCDNLP=$O(^TMP("ECX-HCPCS",$J,ECXCDNLP)) Q:(ECXCDNLP="")  Q:(QFLG=1)  DO
 ..S ECXQTY=^TMP("ECX-HCPCS",$J,ECXCDNLP,"QTY")
 ..S ECXCTRA=^TMP("ECX-HCPCS",$J,ECXCDNLP,"TRAN COST")
 ..S ECXLLC=^TMP("ECX-HCPCS",$J,ECXCDNLP,"LAB LABOR")
 ..S ECXLMC=^TMP("ECX-HCPCS",$J,ECXCDNLP,"LAB MAT")
 ..;
 ..;Get Average Total Cost
 ..S:(ECXQTY>0) ECXAVCT=$S(+$P((ECXCTRA/ECXQTY),".",1)>0:$P((ECXCTRA/ECXQTY),".",1),1:"0")_"."_$E($P((ECXCTRA/ECXQTY),".",2),1,2)
 ..S:(ECXQTY=0) ECXAVCT="0.00"
 ..S:($L($P(ECXAVCT,".",2))<2) $P(ECXAVCT,".",2)=$$PAD^ECXUTL1($P(ECXAVCT,".",2),2,"B","0")
 ..;
 ..;*Get Lab Average Labor Cost
 ..S:(ECXQTY>0) ECXLALC=$S(+$P((ECXLLC/ECXQTY),".",1)>0:$P((ECXLLC/ECXQTY),".",1),1:"0")_"."_$E($P((ECXLLC/ECXQTY),".",2),1,2)
 ..S:(ECXQTY=0) ECXLALC="0.00"
 ..S:($L($P(ECXLALC,".",2))<2) $P(ECXLALC,".",2)=$$PAD^ECXUTL1($P(ECXLALC,".",2),2,"B","0")
 ..;
 ..;*Get Lab Average Material Cost
 ..S:(ECXQTY>0) ECXLAMC=$S(+$P((ECXLMC/ECXQTY),".",1)>0:$P((ECXLMC/ECXQTY),".",1),1:"0")_"."_$E($P((ECXLMC/ECXQTY),".",2),1,2)
 ..S:(ECXQTY=0) ECXLAMC="0.00"
 ..S:($L($P(ECXLAMC,".",2))<2) $P(ECXLAMC,".",2)=$$PAD^ECXUTL1($P(ECXLAMC,".",2),2,"B","0")
 ..;
 ..;*Get Lab Average Combined Cost
 ..S:(ECXQTY>0) ECXLACCT=$S(+$P(((ECXLLC+ECXLMC)/ECXQTY),".",1)>0:$P(((ECXLLC+ECXLMC)/ECXQTY),".",1),1:"0")_"."_$E($P(((ECXLLC+ECXLMC)/ECXQTY),".",2),1,2)
 ..S:(ECXQTY=0) ECXLACCT="0.00"
 ..S:($L($P(ECXLACCT,".",2))<2) $P(ECXLACCT,".",2)=$$PAD^ECXUTL1($P(ECXLACCT,".",2),2,"B","0")
 ..;
 ..;*Format Total Cost
 ..S:(ECXCTRA=0) ECXCTRA="0.00"
 ..S:(+ECXCTRA>0) ECXCTRA=$S(+$P(ECXCTRA,".",1)>0:$P(ECXCTRA,".",1),1:"0")_"."_$E($P(ECXCTRA,".",2),1,2)
 ..S:($L($P(ECXCTRA,".",2))<2) $P(ECXCTRA,".",2)=$$PAD^ECXUTL1($P(ECXCTRA,".",2),2,"B","0")
 ..;
 ..;*Set up a Line of text to report
 ..S ECXCDNME=$E(ECXCDNLP,1,25)
 ..S (ECXSPC1,ECXSPC2,ECXSPC3,ECXSPC4,ECXSPC5,ECXSPC6)=""
 ..S $P(ECXSPC1," ",((28-$L(ECXCDNME))+(4-$L(ECXQTY))))=""
 ..S $P(ECXSPC2," ",(13-$L(ECXCTRA)))=""
 ..S $P(ECXSPC3," ",(10-$L(ECXAVCT)))=""
 ..S $P(ECXSPC4," ",(9-$L(ECXLALC)))=""
 ..S $P(ECXSPC5," ",(10-$L(ECXLAMC)))=""
 ..S $P(ECXSPC6," ",(10-$L(ECXLACCT)))=""
 ..S ECXLINE=ECXCDNME_ECXSPC1_ECXQTY_ECXSPC2_ECXCTRA_ECXSPC3_ECXAVCT_ECXSPC4_ECXLALC_ECXSPC5_ECXLAMC_ECXSPC6_ECXLACCT
 ..;
 ..;*Output the line
 ..D:($D(ECXBUL)) TMP(ECXLINE)
 ..D:('$D(ECXBUL)) YTDLINE(ECXLINE)
 ..I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ S QFLG=1
 ;
 ;* Output message when Queued report is aborted
 I QFLG=1 DO
 .I $D(ECXBUL) DO
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 ..S ECXTMPCT=ECXTMPCT+1
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" Year to Date Report was aborted"
 ..S ECXTMPCT=ECXTMPCT+1
 .I '$D(ECXBUL) DO
 ..W !!," Year to Date Report was aborted",!
 ;
 ;*Output Nothing to Report message when appropriate
 I '$D(ECXINFO),(QFLG=0) DO
 .I $D(ECXBUL) DO
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 ..S ECXTMPCT=ECXTMPCT+1
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" Nothing to Report"
 ..S ECXTMPCT=ECXTMPCT+1
 .I '$D(ECXBUL) W !!," Nothing to Report"
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I ECXPGCT>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 W:'$D(ECXBUL) @IOF
 K ^TMP("ECX-HCPCS",$J)
 Q
 ;
YTDHD ;* Output the report header for the Year to Date report
 ;
 ; Input
 ;  ECXHD2A
 ;  ECXHD2B
 ;  ECXHD2C
 ;  ECXHD2D
 ;  ECXHD2E
 ;  ECXHD2F  - Intro heading lines for Date Range Report (not bulletin)
 ;  ECXPGCT  - Page counter value
 ;
 ; Output
 ;  ECXPGCT  - Page counter value
 ;
 I $E(IOST)="C",'$D(ECX1ST) D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I ECXPGCT>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 I QFLG=0 DO
 .W:$Y!($E(IOST)="C") @IOF
 .S ECXPGCT=ECXPGCT+1
 .W !,?68,"Page: ",ECXPGCT,!
 .W !,ECXHD2A,!!
 .W !,ECXHD2B
 .W !,ECXHD2C
 .W !,ECXHD2D
 .W !,ECXHD2E
 .W !,ECXHD2F,!
 Q
 ;
ECXARPT ;* HCPCS Cost Report control tag
 D DTRNGRPT^ECXAPRO2
 I $E(IOST)="C",('QFLG) D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I ECXPGCT>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 D YTDRPT
 D VARKIL
 Q
 ;
VARKIL ;* Cleanup the variables from the report
 K ECXFYDTS,ECXEBFY,ECXRPHD1,ECXRPHD2,ECXRPHD3,ECXPGCT
 K ECXETDDT,ECXRPHD4,ECXHD1A,ECXHD1B,ECXHD1C,ECXHD2A,ECXHD2B,ECXHD2C
 K ECXDIV,ECXHD,ECXHD1D,ECXHD1E,ECXHD2D,ECXHD2E,ECXHD2F
 I '$D(ECXBUL) K ECINST,ECXBDT,ECXEDT,ECXEBDT,ECXEEDT,QFLG,ECSTAT
 Q
