ESPQNC  ;Albany/VAD - QUICK NAME CHECK ; 11/27/07 2:15pm
        ;;1.0;POLICE & SECURITY;**2,18,21,29,45**;Mar 31, 1994;Build 1
START   W !! S DIC("A")="Select Name: ",DIC="^ESP(910,",DIC(0)="AEMQZ" D ^DIC I Y<0 G EXIT
        S ESPNAM=+Y W !?5,"SEX: ",$P(^ESP(910,ESPNAM,0),"^",8),?20,"RACE: ",$S($D(^DIC(10,+$P(^(0),"^",9),0)):$P(^DIC(10,+$P(^ESP(910,ESPNAM,0),"^",9),0),"^",1),1:""),!!
        S ESPN=0,ESPCNT=0,ESPSTP=0,ESPLAST=0
        S ESPL=9
REG     ;
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(910.2,"D",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". " S REG0=^ESP(910.2,ESPI,0),ESPREG(ESPN)=ESPI W $P("VEHICLE^BICYCLE^WEAPON^PET^GOLF","^",$P(REG0,"^",4))," REGISTRATION ",$P(REG0,"^",1)," ",$P($G(^ESP(910.7,+$P(REG0,"^",2),0)),U)
        .  I ESPCNT>ESPL S ESPR=ESPN D SELX
        S ESPR=$G(ESPN)
        G:ESPSTP START
VIO     ;
        S ESPJ=0 F ESPJ1=1:1 S ESPJ=$O(^ESP(914,"E",ESPNAM,ESPJ)) Q:ESPJ=""!ESPSTP  D
        .  S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". VIOLATION-" S VIO0=^ESP(914,ESPJ,0),ESPVIO(ESPN)=ESPJ S Y=$P(^(0),U,2) X ^DD("DD") W "  ",Y W " ",$P($G(^ESP(915,$P(^ESP(914,ESPJ,0),U,4),0)),U)
        .  I ESPCNT>ESPL S ESPV=ESPN D SELX
        S ESPV=$G(ESPN)
        G:ESPSTP START
OFF     ;
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(912,"D",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  S OFF0=^ESP(912,ESPI,0) I $P(^(5),U,2),$P(^(5),U,5),'$P(^(5),U,4) S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". OFFENSE COMPLAINANT- " S (ESPDTR,X)=$P(^ESP(912,ESPI,0),U,2) W $$CONV^ESPUOR(X) D CL S ESPOFF(ESPN)=ESPI
        .  I ESPCNT>ESPL S ESPO=ESPN D SELX
        G:ESPSTP START
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(912,"E",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  I $P(^ESP(912,ESPI,5),U,2),$P(^(5),U,5),'$P(^(5),U,4) S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". OFFENSE VICTIM- " S (ESPDTR,X)=$P(^ESP(912,ESPI,0),U,2) W $$CONV^ESPUOR(X) D CL S ESPOFF(ESPN)=ESPI
        .  I ESPCNT>ESPL S ESPO=ESPN D SELX
        G:ESPSTP START
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(912,"G",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  I $P(^ESP(912,ESPI,5),U,2),$P(^(5),U,5),'$P(^(5),U,4) S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". OFFENSE OFFENDER- " S (ESPDTR,X)=$P(^ESP(912,ESPI,0),U,2) W $$CONV^ESPUOR(X) D CL S ESPOFF(ESPN)=ESPI
        .  I ESPCNT>ESPL S ESPO=ESPN D SELX
        G:ESPSTP START
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(912,"I",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  I $P(^ESP(912,ESPI,5),U,2),$P(^(5),U,5),'$P(^(5),U,4) S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". OFFENSE WITNESS- " S (ESPDTR,X)=$P(^ESP(912,ESPI,0),U,2) W $$CONV^ESPUOR(X) D CL S ESPOFF(ESPN)=ESPI
        .  I ESPCNT>ESPL S ESPO=ESPN D SELX
        S ESPO=$G(ESPN)
        G:ESPSTP START
WAR     ;
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(913,"B",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        .  S ESPN=ESPN+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". " S WAR0=^ESP(913,ESPI,0),ESPWAR(ESPN)=ESPI W "WANT OR WARRANT " S Y=$P(WAR0,U) X ^DD("DD") W Y," ",$P(WAR0,U,6)
        .  I ESPCNT>ESPL S ESPW=ESPN D SELX
        S ESPW=$G(ESPN)
        G:ESPSTP START
EVID    ;
        S ESPI=0 F ESPI1=1:1 S ESPI=$O(^ESP(910.8,"C",ESPNAM,ESPI)) Q:ESPI=""!ESPSTP  D
        . S EVI0=^ESP(910.8,ESPI,0) I '$P(^(0),U,4) S ESPN=ESPN+1,ESPEVI(ESPN)=ESPI,ESPCNT=ESPCNT+1 W !?5,ESPN,". EVIDENCE RECORD NUMBER ",$P(^(0),U)," ",$P($G(^ESP(910.8,ESPI,10)),U)
        . I ESPCNT>ESPL S ESPE=ESPN D SELX
        S ESPE=$G(ESPN)
        G:ESPSTP START
        S ESPN=$G(ESPN)+1,ESPCNT=ESPCNT+1 W !?5,ESPN,". " W "MASTER NAME INDEX RECORD" S ESPLAST=1
        D SELX
        G START
        ;
SELX    ;
        Q:ESPSTP  W ! S DIR(0)="NO^1:"_ESPN,DIR("A")="Select a number for viewing, ^ to exit"
        I 'ESPLAST S DIR("A")=DIR("A")_", <RETURN> for more"
        D ^DIR S ESPX=X W !
        I $D(DTOUT) S ESPSTP=1 Q
        I X["^" S ESPSTP=1 Q
        I X=""&'ESPLAST S ESPSTP=0,ESPCNT=0 Q
        I X=""&ESPLAST S ESPSTP=1 Q
        S ESPSTP=1
        ; ===================================================================
        ;S %ZIS="Q" D ^%ZIS I POP S ESPSTP=1 Q
        ;I '$D(IO("Q")) U IO D DISP D:IO'=IO(0) ^%ZISC Q
        ;S ZTRTN="DISP^ESPQNC",ZTSAVE("ESP*")="",ZTDESC="QUICK NAME CHECK" D ^%ZTLOAD,HOME^%ZIS
        ; -------------------------------------------------------------------
        ; The following lines replace the lines above.
        ; -------------------------------------------------------------------
        N ZTRTN,ZTSAVE,ZTDESC
        S ZTRTN="DISP^ESPQNC",ZTSAVE("ESP*")="",ZTDESC="QUICK NAME CHECK"
        W ! D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
        ; ===================================================================
        Q
        ;
DISP    ;
        I ESPX<ESPR!(ESPX=ESPR) S DA=ESPREG(ESPX),DIC="^ESP(910.2," D EN^DIQ Q
        I ESPX>ESPR,ESPX<ESPV!(ESPX=ESPV) S ESPID=ESPVIO(ESPX) D START^ESPVNP Q
        I ESPX>ESPV,ESPX<ESPO!(ESPX=ESPO) S ESPID=ESPOFF(ESPX),ESPDTR=$P(^ESP(912,ESPID,0),U,2) D START^ESPORP Q
        I ESPX>ESPO,ESPX<ESPW!(ESPX=ESPW) S DA=ESPWAR(ESPX),DIC="^ESP(913," D EN^DIQ Q
        I ESPX>ESPW,ESPX<ESPE!(ESPX=ESPE) S DA=ESPEVI(ESPX),DIC="^ESP(910.8," D EN^DIQ Q
        I ESPX=ESPN S DA=ESPNAM,DIC="^ESP(910," D EN^DIQ Q
        ;
EXIT    ;
        K %ZIS,DA,DIC,DIQ,DIR,DR,DTOUT,ESPDTR,ESPE,ESPEVI,ESPFN,ESPI,ESPI1,ESPID,ESPJ,ESPJ1,ESPN,ESPNAM,ESPO,ESPOFF,ESPR,ESPREG,ESPV,ESPVIO,ESPW,ESPWAR,ESPX,ESPZ,EVI0,OFF0,REG0,VIO0,WAR0,X,Y,ESPCNT,ESPSTP,ESPL,ESPLAST
        Q
        ;
CL      ;PRINT CLASSIFICATION CODES, TYPES, AND SUBTYPES
        F ESPZ=0:0 S ESPZ=$O(^ESP(912,ESPI,10,ESPZ)) Q:ESPZ'>0  D
        .  S DIC="^ESP(912,"_ESPI_",10,",DA=ESPZ,DR=".01;.02;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
        .  W "  ",$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
        .  I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
        .  I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
        .  K DIC,DR
        QUIT
