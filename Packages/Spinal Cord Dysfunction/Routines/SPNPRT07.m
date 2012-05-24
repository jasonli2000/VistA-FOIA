SPNPRT07 ;HIRMFO/WAA- PRINT Possible Reg. Based on D/C ;10/25/96  11:30
 ;;2.0;Spinal Cord Dysfunction;**11,13**;01/02/1997
 ;;
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE,SPNDATE,SPNEDAT S SPNPAGE=1
 S SPNLEXIT=0
 S SPNA="   Enter START Date: "
 S SPNQ=" Enter the earliest date of Discharge for the print to START with."
 D QUEST^SPNPRT04("DA^:NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNDATE=Y
 S ZTSAVE("SPN*")=""
 S SPNA="   Enter END Date: "
 S SPNQ=" Enter the latest date of Discharge for the print to END with."
 D QUEST^SPNPRT04("DA^"_SPNDATE_":NOW:EP",SPNA,SPNQ) Q:SPNLEXIT
 S SPNEDAT=Y
 D DEVICE^SPNPRTMT("PRINT^SPNPRT07","SCD/SCI Discharges Patients",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNDATE
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT,0) ; Ensure that the exit is set
 N SPNDFN,SPNX,SPNFAC
 S (SPNDFN,SPNLPRT,SPNFAC)=0
 S SPNQDAT=SPNDATE-.000001
 Q:SPNLEXIT
 F  S SPNQDAT=$O(^DGPM("AMV3",SPNQDAT)) Q:(SPNQDAT<1)  Q:(SPNQDAT>SPNEDAT)  D  Q:SPNLEXIT
 . S SPNDFN=0
 . F  S SPNDFN=$O(^DGPM("AMV3",SPNQDAT,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 .. S SPNIEN=0 F  S SPNIEN=$O(^DGPM("AMV3",SPNQDAT,SPNDFN,SPNIEN)) Q:SPNIEN<1  D  Q:SPNLEXIT
 ... N DFN,SPNLINE,SPNLOS
 ... I '$D(^SPNL(154,SPNDFN,0)),'(+$$GET1^DIQ(2,SPNDFN,57.4,"I")) Q
 ... S DFN=SPNDFN,VAIP("E")=SPNIEN D IN5^VADPT
 ... S SPNLOS=$$FMDIFF^XLFDT(SPNQDAT,$P(VAIP(15,1),U)) ; LENGTH OF STAY
 ... ; SPNLINE=Movement date(E)^pointer to PTF(I)^Length of Stay
 ... ;         ^Ward location(E)^D/C date
 ... S SPNLINE=$P(VAIP(15,1),U)_U_VAIP(12)_U_SPNLOS_U_$P(VAIP(5),U,2)_U_SPNQDAT
 ... S ^TMP($J,"SPN",$$GET1^DIQ(2,SPNDFN,.01,"E"),SPNDFN,SPNIEN)=SPNLINE
 ... D KVAR^VADPT
 ... Q
 .. Q
 . Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . N SPNSTATE,SPNDFN,SPNNAME,SPNCOU
 . S SPNCOU=0
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  D  Q:SPNLEXIT
 .. S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D NEWPAT(SPNDFN) Q:SPNLEXIT  D  Q:SPNLEXIT  W !
 ... S SPNIEN=0 F  S SPNIEN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN,SPNIEN)) Q:SPNIEN<1  D  Q:SPNLEXIT
 .... S SPNLINE=^TMP($J,"SPN",SPNNAME,SPNDFN,SPNIEN)
 ... D HEAD Q:SPNLEXIT
 ... D PATIENT(SPNDFN,SPNLINE) Q:SPNLEXIT
 ... Q
 .. Q
 .I SPNCOU D
 .. W !,?15,SPNCOU," Patients have been processed."
 .. I SPNFAC D RECFAC
 .. Q
 . Q
 E  W !,"     ******* No Data for this report. *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
RECFAC ; Print out a frequency table for receiving facilities
 S SPNPAGE=1
 N SPNFACN
 S SPNFACN=0
 F  S SPNFACN=$O(SPNFAC(SPNFACN)) Q:SPNFACN<1  D  Q:SPNLEXIT
 . N SPNIEN
 . S SPNIEN=0
 . F  S SPNIEN=$O(^DIC(4,"D",SPNFACN,SPNIEN)) Q:SPNIEN<1  D  Q:SPNLEXIT
 .. Q:$G(^DIC(4,SPNIEN,0))=""
 .. D HEAD2 Q:SPNLEXIT
 .. W !,?8,"| ",$E($$GET1^DIQ(4,SPNIEN,.01,"E"),1,40),?46,"| ",SPNFACN,?59,"| ",SPNFAC(SPNFACN),?72,"|"
 .. W !,?8,$$REPEAT^XLFSTR("-",65) ; Last Line in table
 .. Q
 . Q
 Q
NEWPAT(SPNDFN) ; New patient to print
 D HEAD Q:SPNLEXIT
 N DFN
 S DFN=SPNDFN D DEM^VADPT
 W !!,"  Patient: ",$E(VADM(1),1,25),?38,"SSN: ",$P(VADM(2),U),?56,"SCI: ",$E($$GET1^DIQ(2,SPNDFN,57.4,"E"),1,23)
 D KVAR^VADPT
 S SPNCOU=SPNCOU+1
 I '$D(^SPNL(154,SPNDFN,0)) Q
 I $O(^SPNL(154,SPNDFN,"E",0))<1 Q
 N SPNETI,SPNDFLG
 S (SPNETI,SPNDFLG)=0 W !,"  Etiology: "
 F  S SPNETI=$O(^SPNL(154,SPNDFN,"E",SPNETI)) Q:SPNETI<1  D  Q:SPNLEXIT
 .N SPNETO
 .S SPNETO=$P($G(^SPNL(154,SPNDFN,"E",SPNETI,0)),U) Q:SPNETO=""
 .I $X>13 D HEAD Q:SPNLEXIT  W !
 .W ?12,$E($$GET^DDSVAL(154.03,SPNETO,.01,"","E"),1,30)
 .I 'SPNDFLG W ?45,"Registration Date: ",$$FMTE^XLFDT($P($G(^SPNL(154,SPNDFN,0)),U,2),"2D") S SPNDFLG=1
 .Q
 Q
PATIENT(SPNDFN,SPNLINE) ; Print Patient data
 ; SPNLINE=Movement date(I)^pointer to PTF(I)^Length of Stay
 ;         ^Ward location(E)^D/C Date
 ; SPNLINE=$P(VAIP(15,1),U,2)_U_VAIP(12)_U_SPNLOS_U_$P(VAIP(5),U,2)_U_SPNQDAT
 Q:SPNLEXIT
 W !,$$FMTE^XLFDT($P(SPNLINE,U,5),"2D"),?11,$P(SPNLINE,U,3)
 W ?16,$E($P(SPNLINE,U,4),1,28)
 Q:$P(SPNLINE,U,2)=""
 N SPNODE,SPNNODE
 S SPNNODE=$G(^DGPT($P(SPNLINE,U,2),70)) Q:SPNNODE=""
 I $P(SPNNODE,U,12)?1N.N S SPNFAC=SPNFAC+1,SPNFAC($P(SPNNODE,U,12))=$G(SPNFAC($P(SPNNODE,U,12)))+1 ; Collect Receiving Facility
 N SPNY
 F SPNODE=10,16:1:24 D  Q:SPNLEXIT
 .S SPNY=$P(SPNNODE,U,SPNODE)
 .I SPNY'>0 Q
 .I $G(^ICD9(SPNY,0))="" Q
 .I $X>50 D HEAD Q:SPNLEXIT  W !
 .W ?50,$E($$GET1^DIQ(80,SPNY,3,"E"),1,29)
 .Q
 I '$D(^SPNL(154,SPNDFN,0)) W !?2,"*** NOT IN THE REGISTRY ! ***"
 Q
HEAD ; Header Print
 I SPNPAGE'=1 Q:$Y<(IOSL-4)
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE=1 W @IOF Q
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..K Y
 ..Q
 .Q
 Q:SPNLEXIT
 I SPNPAGE'=1 W @IOF
 W !,$$FMTE^XLFDT($$NOW^XLFDT,1),?70,"Page: ",SPNPAGE
 W !!,?27,"SCD/SCI Discharge Patients"
 W !,?27,"From: ",$$FMTE^XLFDT(SPNDATE,"2D")," to: ",$$FMTE^XLFDT(SPNEDAT,"2D")
 W !!,"Date D/C",?11,"LOS",?16,"D/C Location",?50,"Diagnosis Codes"
 W !,$$REPEAT^XLFSTR("-",79)
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q
HEAD2 ; Header Print
 I SPNPAGE'=1 Q:$Y<(IOSL-4)
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE=1 W @IOF Q
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..K Y
 ..Q
 .Q
 Q:SPNLEXIT
 W @IOF
 W !,$$FMTE^XLFDT($$NOW^XLFDT,1),?70,"Page: ",SPNPAGE
 W !!,?27,"SCD/SCI Discharges Patients"
 W !,?20,"Frequency Table of Discharge Destination"
 W !!,?9,"Facility",?47,"Station #",?60,"Total"
 W !,?8,$$REPEAT^XLFSTR("-",65) ; first Line in table
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q
