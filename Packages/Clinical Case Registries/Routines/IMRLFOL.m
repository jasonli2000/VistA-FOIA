IMRLFOL ;ISC-SF.SEA/JLI,HCIOFO/FT-LIST OF PATIENTS POTENTIALLY LOST TO FOLLOW-UP ;10/16/97  9:39
 ;;2.1;IMMUNOLOGY CASE REGISTRY;;Feb 09, 1998
 ;[IMR FOLLOWUP LIST] - Follow Up Report
 I '$D(^XUSEC("IMRMGR",DUZ)) S IMRLOC="IMRLFOL" D ACESSERR^IMRERR,H^XUS K IMRLOC
 K DIR S DIR(0)="N^1:365",DIR("A")="Number of Days Patients Not Seen"
 S DIR("?")="Enter the number of days you want to check if any patient has not been seen"
 D ^DIR K DIR
 I $D(DIRUT) D KILL Q
 S IMRDAY=Y
 S IMRSD=$$FMADD^XLFDT(DT,-IMRDAY) ;calculate date for DT-IMRDAY
 S X=$$RX1589^IMRUTL() ;get pharmacy archive date from File 158.9
 I X,X'<IMRSD D ASKN G:$D(DIRUT) KILL G DEV
 D LRARC^IMRUTL ;check Lab archive date
 I IMRLRC,IMRLRC'<IMRSD D ASKN I $D(DIRUT) KILL Q
DEV D IMRDEV^IMREDIT I POP D KILL Q
 I $D(IO("Q")) D  G KILL
 .S ZTRTN="DQ^IMRLFOL",ZTDESC="Immunology Followup List",ZTIO=ION_";"_IOM_";"_IOSL
 .S ZTSAVE("IMRDAY")="",ZTSAVE("IMRSD")=""
 .D ^%ZTLOAD
 .K ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE
 .Q
DQ ;
 K ^TMP($J) S (IMRPG,IMRSEEN,IMRUT)=0
 D GETNOW^IMRACESS ;get the current date/time
 F IMRI=0:0 S IMRI=$O(^IMR(158,IMRI)) Q:IMRI'>0  D P1 I IMRDFN>0,IMRSEEN S IMRC=$P(^IMR(158,IMRI,0),U,42) S ^TMP($J,(9999999-IMRD),IMRI)=IMRD_U_IMRC_U_IMRNAM_U_IMRSSN
 S:$D(ZTQUEUED) ZTREQ="@"
 I $D(^TMP($J)) U IO D LIST
 I '$D(^TMP($J)) U IO D HEDR W !!,"NO DATA FOR THIS REPORT"
HOLD D:'IMRUT PRTC
CLOSE D ^%ZISC
KILL K ^TMP($J),DFN,D,K,IMRSTN,IMRFLG,IMRC,IMRD,IMRNAM,IMRSSN,IMRUT,I,J,POP,X,Y,IMRDFN,IMRDOD,X0,X1,X2,IMRI,IMRJ,VAERR,%T,DISYS,IMRDTE,IMRPG,IMRDAY,IMRSD,IMRSEEN,%I,%Y,IMRDL,IMRYES
 K IMRAD,IMRDD,IMRDISP,IMRDSP,IMREC,IMRFB,IMRLRC,IMROUT,IMRPTF,IMRST,IMRSUF
 Q
 ;
P1 S X=+^IMR(158,IMRI,0) D ^IMRXOR S IMRDFN=X I '$D(^DPT(IMRDFN,0)) S IMRDFN=-1 Q
 S DFN=IMRDFN D DEM^VADPT S IMRNAM=VADM(1),IMRSSN=$P(VADM(2),U),IMRDOD=+VADM(6) K DFN,VA,VADM
 S X0=0 F IMRPTF=0:0 S IMRPTF=$O(^DGPT("B",IMRDFN,IMRPTF)) Q:IMRPTF'>0  I $D(^DGPT(IMRPTF,0)),+^(0)=IMRDFN D PTF^IMRUTL S X1=+IMRAD S:X1>X0 X0=X1 S X1=$S(+IMRDD'>0:1,1:0) S:X1 X0=DT Q:X1  I +IMRDD>X0 S X0=+IMRDD
 S VASD("F")=$S(X0=0:2850101,1:X0),VASD("T")=DT-1,DFN=IMRDFN D SDA^VADPT F IMRJ=0:0 S IMRJ=$O(^UTILITY("VASD",$J,IMRJ)) Q:IMRJ'>0  S X0=+^(IMRJ,"I")
 K VASD,^UTILITY("VASD",$J)
 I $D(^DPT(IMRDFN,"LR")),^("LR")>0 S X1=+^("LR"),X2=$O(^LR(X1,"CH",0)) S X=$S(X2'>0:0,'$D(^(X2,0)):0,1:1),X=$S(X:+^(0),1:-1) S:X>X0&(X'>DT) X0=X S X2=$O(^LR(X1,"MI",0)) S X=$S(X2'>0:0,'$D(^(X2,0)):0,1:1),X=$S(X:+^(0),1:-1) S:X>X0&(X'>DT) X0=X
 F IMRJ=X0:0 S IMRJ=$O(^PS(55,IMRDFN,"P","A",IMRJ)) Q:IMRJ'>0  F J=0:0 S J=$O(^PS(55,IMRDFN,"P","A",IMRJ,J)) Q:J'>0  S:$D(^PSRX(J,2)) X1=$P(^(2),U,2) S:X1>X0 X0=X1 F K=0:0 S K=$O(^PSRX(J,1,K)) Q:K'>0  S X1=+^(K,0) S:X1>X0 X0=X1
 F IMRJ=0:0 S IMRJ=$O(^RADPT(IMRDFN,"DT",IMRJ)) Q:IMRJ'>0  I $D(^(IMRJ,0)) S X=+^(0) I X'>DT Q:X<X0  I X>X0 S X0=X
 S IMRDOD=$S(IMRDOD>0:1,'$D(^IMR(158,IMRI,5)):0,1:$P(^(5),U,19)>0)
 S X1=DT,(X0,X2)=X0\1 D ^%DTC S:IMRDOD X=0 S IMRD=X0,IMRSEEN=$S(X>IMRDAY:1,1:0)
 Q
 ;
LIST D HEDR
 F I=0:0 Q:IMRUT  S I=$O(^TMP($J,I)) Q:I'>0  F J=0:0 S J=$O(^TMP($J,I,J)) Q:J'>0  D L1 Q:IMRUT
 Q
 ;
L1 ;
 I ($Y+3>IOSL) D PRTC Q:IMRUT  D HEDR
 S D=$P(^TMP($J,I,J),U,1,2) W !,$E(D,4,5),"-",$E(D,6,7),"-",$E(D,2,3),"   ",$P(^(J),U,3),?45,$E($P(^(J),U,4),6,9),?55,$P(D,U,2)
 Q
 ;
PRTC ;press return to continue prompt
 Q:$D(IO("S"))
 I IOST["C-" K DIR W ! S DIR(0)="E" D ^DIR K DIR I 'Y S IMRUT=1
 Q
HEDR ;print report header
 S IMRPG=IMRPG+1
 W:$Y>0 @IOF
 W !?33,"FOLLOW UP REPORT",!?32,IMRDTE,?70,"Page: ",IMRPG,!?25,"PATIENTS AT RISK OF LOSS TO FOLLOW UP",!?30,"NOT SEEN IN OVER "_IMRDAY_" DAYS",!!?2,"LAST",!?2,"DATE",?45,"LAST",!?2,"SEEN",?13,"NAME",?45,"FOUR",?54,"CAT",!
 Q
ASKN ; Ask User Whether they Want to Query the National Registry
 S IMRYES=0 D ASKQ1^IMRNTL Q:'IMRYES  S IMRDL="" D ASKQ2^IMRNTL Q:IMRDL=""  D MSG^IMRNTL,FOL^IMRNTL1
 Q
