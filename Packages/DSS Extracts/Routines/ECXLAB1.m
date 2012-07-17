ECXLAB1 ;ALB/JAP,BIR/CML-Driver Routine for DSS Lab Extract; [ 03/20/97  11:54 AM ]
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
EN ;entry point from option
 N JJ,SS,LN,X,Y,DIRUT,DTOUT,DUOUT,DIR
 I '$O(^ECX(728,0)) D  Q
 .W $C(7),!!,"You have not yet defined your facility in the DSS EXTRACTS file (#728)!"
 .I ($E(IOST)="C") D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..K X,Y
 ..S DIR(0)="E" W ! D ^DIR K DIR
 ;Check for lmip flag (field .5) in file (#728), if "1" then skip this question
 I $G(^ECX(728,1,"LMIP")) D  Q
 .D BEG^ECXLABN
 S $P(LN,"-",80)=""
 W $C(7),@IOF,!,LN,!,"     ARE YOU COMPLETELY READY TO SEND LMIP CODES FOR DSS LAB FEEDER KEYS?      ",!,LN
 W !!,"To answer ""YES"" to this question, Lab CO directives for LMIP MUST have"
 W !,"been completed at your facility. This means that your Lab Service must"
 W !,"have matched all entries in the LABORATORY TEST file (#60) to an LMIP"
 W !,"code.  After this is accomplished, you are ready to send LMIP codes to"
 W !,"DSS for your initial LAB Feeder Key Values."
 W !!?30,"**IMPORTANT NOTES**",!,"- Once you answer ""YES"" to send LMIP Codes, you will not be asked this"
 W !,"  question again.  All LAB extracts will send LMIP Codes."
 W !,"- Answering ""NO"" will prevent generation of DSS LAB extracts"
 W !,"- If you are not sure, enter an ""^"" at the next prompt and check with"
 W !,"  your LAB ADPAC or LAB Service before continuing."
 W ! K DIR D HELP S DIR(0)="Y",DIR("A")="Are you ready to send LMIP codes",DIR("B")="NO"
 D ^DIR K DIR
 I 'Y D
 .W !!,"LAB Extracts cannot be generated without LMIP Codes.",!,"...exiting."
 I Y D
 .W !!,"Proceeding with LAB extract...",!
 .S ^ECX(728,1,"LMIP")=1
 I '$D(DIRUT),($E(IOST)="C") D
 .S SS=22-$Y F JJ=1:1:SS W !
 .K X,Y
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
HELP ;
 S DIR("?",1)="   Enter:"
 S DIR("?",2)="     ""YES"" if your site is ready to send LMIP codes,"
 S DIR("?",3)="      ""NO"" if your site cannot send LMIP Codes,"
 S DIR("?")="       ""^"" to exit option."
 Q
