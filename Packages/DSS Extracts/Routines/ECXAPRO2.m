ECXAPRO2 ;ALB/GTS - PRO Extract Audit Report ; July 20, 1998
 ;;3.0;DSS EXTRACTS;**9**;Dec 22, 1997
 ;
DTRNGRPT ;* Report Date range information
 ;
 ; Input
 ;  ECXBUL    - Indicates a bulletin to be sent (KILLed by calling rtn)
 ;  ECXBDT    - FM formated Beginning Date (KILLed by calling rtn)
 ;  ECXEDT    - FM formated End Date (KILLed by calling rtn)
 ;  ECXTMPCT  - Set if a bulletin is to be sent (KILLed by calling rtn)
 ;  ECSTAT    - Station number of extract records to report
 ;  ^TMP("ECX-PRO",$J - Global if report is sent in a message (Optional)
 ;
 ; Output
 ;  ^TMP("ECX-PRO",$J - Global if report is sent in a message (Optional)
 ;
 N ECXINFO,ECXLPDT,ECXLPGRP,ECXLPPCE,ECXCDNME,ECXCPTDA,ECXCPT,ECXN0
 N ECXQTY,ECXCTRA,ECXLLC,ECXLMC,ECXPRDA,ECXLINE,ECXSPC1,ECXSPC2,ECXSPC3
 N ECXSPC4,ECXSPC5,ECXSPC6,ECXLAMC,ECXLALC,ECXLPEND,ECXCGRPR
 I '$D(ECXBUL) DO
 .U IO
 .D DTRGHD^ECXAPRO1
 S ECXCGRPR=""
 S ECXLPDT=$$ECXYM^ECXUTL(ECXBDT)
 S ECXLPDT=$$ECXDATE^ECXUTL(ECXBDT,ECXLPDT)-1
 S ECXLPEND=$$ECXYM^ECXUTL(ECXEDT)
 S ECXLPEND=$$ECXDATE^ECXUTL(ECXEDT,ECXLPEND)
 F  S ECXLPDT=$O(^ECX(727.826,"AG",ECXLPDT)) Q:(ECXLPDT>ECXLPEND)  Q:(+ECXLPDT=0)  Q:(QFLG=1)  DO
 .S ECXLPGRP=""
 .F  S ECXLPGRP=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP)) Q:(ECXLPGRP="")  Q:(QFLG=1)  DO
 ..S ECXLPPCE=""
 ..F  S ECXLPPCE=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP,ECXLPPCE)) Q:(ECXLPPCE="")  Q:(QFLG=1)  DO
 ...S ECXPRDA=""
 ...F  S ECXPRDA=$O(^ECX(727.826,"AG",ECXLPDT,ECXLPGRP,ECXLPPCE,ECXPRDA)) Q:(+ECXPRDA=0)  Q:(QFLG=1)  DO
 ....S ECXN0=$G(^ECX(727.826,ECXPRDA,0))
 ....I ECSTAT=$E($$STRIP^ECXUTL1($P(ECXN0,"^",4),5,"B"),1,3) DO
 .....S ECXINFO=1
 .....S ECXCPT=$$STRIP^ECXUTL1(ECXLPPCE,8,"B") ;* Remove blanks
 .....S ECXCPTDA=$O(^ICPT("B",ECXCPT,""))
 .....I ECXLPGRP'=ECXCGRPR DO
 ......S ECXCGRPR=ECXLPGRP
 ......D:($D(ECXBUL)) TMP^ECXAPRO1(" ")
 ......D:('$D(ECXBUL)) DTRGRPT^ECXAPRO1(" ")
 .....I QFLG=0 DO
 ......;
 ......;*Set up variables of data to report
 ......S ECXCDNME=$P(^ICPT(ECXCPTDA,0),"^",1)_" "_$P(^ICPT(ECXCPTDA,0),"^",2)
 ......S ECXQTY=$$STRIP^ECXUTL1($P(ECXN0,"^",12),4,"F")
 ......S ECXCTRA=$$STRIP^ECXUTL1($P(ECXN0,"^",21),9,"F")
 ......S ECXLLC=$$STRIP^ECXUTL1($P(ECXN0,"^",22),7,"F")
 ......S ECXLMC=$$STRIP^ECXUTL1($P(ECXN0,"^",23),7,"F")
 ......;
 ......;Get Average Total Cost
 ......S:(ECXQTY>0) ECXAVCT=$S(+$P((ECXCTRA/ECXQTY),".",1)>0:$P((ECXCTRA/ECXQTY),".",1),1:"0")_"."_$E($P((ECXCTRA/ECXQTY),".",2),1,2)
 ......S:(ECXQTY=0) ECXAVCT="0.00"
 ......S:($L($P(ECXAVCT,".",2))<2) $P(ECXAVCT,".",2)=$$PAD^ECXUTL1($P(ECXAVCT,".",2),2,"B","0")
 ......;
 ......;*Get Lab Average Labor Cost
 ......S:(ECXQTY>0) ECXLALC=$S(+$P((ECXLLC/ECXQTY),".",1)>0:$P((ECXLLC/ECXQTY),".",1),1:"0")_"."_$E($P((ECXLLC/ECXQTY),".",2),1,2)
 ......S:(ECXQTY=0) ECXLALC="0.00"
 ......S:($L($P(ECXLALC,".",2))<2) $P(ECXLALC,".",2)=$$PAD^ECXUTL1($P(ECXLALC,".",2),2,"B","0")
 ......;
 ......;*Get Lab Average Material Cost
 ......S:(ECXQTY>0) ECXLAMC=$S(+$P((ECXLMC/ECXQTY),".",1)>0:$P((ECXLMC/ECXQTY),".",1),1:"0")_"."_$E($P((ECXLMC/ECXQTY),".",2),1,2)
 ......S:(ECXQTY=0) ECXLAMC="0.00"
 ......S:($L($P(ECXLAMC,".",2))<2) $P(ECXLAMC,".",2)=$$PAD^ECXUTL1($P(ECXLAMC,".",2),2,"B","0")
 ......;
 ......;*Get Lab Average Combined Cost
 ......S:(ECXQTY>0) ECXLACCT=$S(+$P(((ECXLLC+ECXLMC)/ECXQTY),".",1)>0:$P(((ECXLLC+ECXLMC)/ECXQTY),".",1),1:"0")_"."_$E($P(((ECXLLC+ECXLMC)/ECXQTY),".",2),1,2)
 ......S:(ECXQTY=0) ECXLACCT="0.00"
 ......S:($L($P(ECXLACCT,".",2))<2) $P(ECXLACCT,".",2)=$$PAD^ECXUTL1($P(ECXLACCT,".",2),2,"B","0")
 ......;
 ......;*Format Total Cost
 ......S:(ECXCTRA=0) ECXCTRA="0.00"
 ......S:(+ECXCTRA>0) ECXCTRA=$S(+$P(ECXCTRA,".",1)>0:$P(ECXCTRA,".",1),1:"0")_"."_$E($P(ECXCTRA,".",2),1,2)
 ......S:($L($P(ECXCTRA,".",2))<2) $P(ECXCTRA,".",2)=$$PAD^ECXUTL1($P(ECXCTRA,".",2),2,"B","0")
 ......;
 ......;*Set up a Line of text to report
 ......S ECXCDNME=$E(ECXCDNME,1,25)
 ......S (ECXSPC1,ECXSPC2,ECXSPC3,ECXSPC4,ECXSPC5,ECXSPC6)=""
 ......S $P(ECXSPC1," ",((28-$L(ECXCDNME))+(4-$L(ECXQTY))))=""
 ......S $P(ECXSPC2," ",(13-$L(ECXCTRA)))=""
 ......S $P(ECXSPC3," ",(10-$L(ECXAVCT)))=""
 ......S $P(ECXSPC4," ",(9-$L(ECXLALC)))=""
 ......S $P(ECXSPC5," ",(10-$L(ECXLAMC)))=""
 ......S $P(ECXSPC6," ",(10-$L(ECXLACCT)))=""
 ......S ECXLINE=ECXCDNME_ECXSPC1_ECXQTY_ECXSPC2_ECXCTRA_ECXSPC3_ECXAVCT_ECXSPC4_ECXLALC_ECXSPC5_ECXLAMC_ECXSPC6_ECXLACCT
 ......;
 ......;*Output the line
 ......D:($D(ECXBUL)) TMP^ECXAPRO1(ECXLINE)
 ......D:('$D(ECXBUL)) DTRGRPT^ECXAPRO1(ECXLINE)
 ......I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ S QFLG=1
 ;
 ;*Output message when queued report is aborted
 I QFLG=1 DO
 .I $D(ECXBUL) DO
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 ..S ECXTMPCT=ECXTMPCT+1
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" Period Report was aborted"
 ..S ECXTMPCT=ECXTMPCT+1
 .I '$D(ECXBUL) DO
 ..W !!," Period Report was aborted",!
 ;
 ;*Output Nothing to Report message when appropriate
 I '$D(ECXINFO) DO
 .I $D(ECXBUL) DO
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" "
 ..S ECXTMPCT=ECXTMPCT+1
 ..S ^TMP("ECX-PRO",$J,ECXTMPCT)=" Nothing to Report"
 ..S ECXTMPCT=ECXTMPCT+1
 .I '$D(ECXBUL) DO
 ..W !!," Nothing to Report"
 ..I $E(IOST)="C" D
 ...S SS=22-$Y F JJ=1:1:SS W !
 ...S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q
