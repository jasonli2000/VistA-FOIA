ONCGPC7 ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;04/16/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Print
 K IOP,%ZIS S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KILL
 I $D(IO("Q")) S ONCOLST="ONCONUM^ONCOPA^PATNAM^SPACES^TOPNAM^SSN^TOPTAB^TOPCOD^DASHES^SITTAB^SITEGP^ADENOCA^HIST1234^LYMPHOMA" D TASK G KILL
 U IO D PRT D ^%ZISC K %ZIS,IOP G KILL
PRT S EX="",LIN=$S(IOST?1"C".E:IOSL-2,1:IOSL-4),IE=ONCONUM
 S HIST=$$HIST^ONCFUNC(ONCONUM)
 S HIST1234=$E(HIST,1,4),BEH=$E(HIST,5)
 S ADENOCA=0,LYMPHOMA=0
 I (HIST1234>8139)&(HIST1234<8577) S ADENOCA=1  ;Adenocarcinomas
 I HIST1234=8941 S ADENOCA=1                    ;Adenocarcinoma
 I (HIST1234>9589)&(HIST1234<9730) S LYMPHOMA=1 ;Lymphomas
 S CMC=$$GET1^DIQ(165.5,IE,1400.6) ;GAS CO-MORBID CONDITIONS Y/N
 S TC=$$GET1^DIQ(165.5,IE,1426.5)  ;LNG COMPLICATIONS Y/N
 K LINE S $P(LINE,"-",40)="-"
I S TABLE="PATIENT INFORMATION"
 D HEAD^ONCGPC0
 K LINE S $P(LINE,"-",19)="-"
 W !?4,TABLE,!?4,LINE
ITEM1 W !," 1. CO-MORBID CONDITIONS:"
 D P Q:EX=U
 I CMC="No" D  G CMC2
 .W !,"     CO-MORBID CONDITION #1.......: 000.00 No co-morbidities"
 W !,"     CO-MORBID CONDITION #1.......: ",$P($$GET1^DIQ(165.5,IE,1571)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571)," ",2,99)
CMC2 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #2.......: ",$P($$GET1^DIQ(165.5,IE,1571.1)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571.1)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #3.......: ",$P($$GET1^DIQ(165.5,IE,1571.2)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571.2)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #4.......: ",$P($$GET1^DIQ(165.5,IE,1571.3)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571.3)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #5.......: ",$P($$GET1^DIQ(165.5,IE,1571.4)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571.4)," ",2,99)
 D P Q:EX=U
 W !,"     CO-MORBID CONDITION #6.......: ",$P($$GET1^DIQ(165.5,IE,1571.5)," ",1),?43,$P($$GET1^DIQ(165.5,IE,1571.5)," ",2,99)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM2 W !," 2. PRIOR EXPOSURE TO RADIATION...: ",$$GET1^DIQ(165.5,IE,1500)
 W !
 D P Q:EX=U
ITEM3 W !," 3. ALCOHOL CONSUMPTION...........: ",$$GET1^DIQ(165.5,IE,1501)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM4 W !," 4. DURATION OF TOBACCO USE.......: ",$$GET1^DIQ(165.5,IE,1572)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM5 W !," 5. MENOPAUSAL STATUS AND HORMONE"
 D P Q:EX=U
 W !,"     REPLACEMENT THERAPY..........: ",$$GET1^DIQ(165.5,IE,1502)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM6 W !," 6. H2/BLOCKER PROTON PUMP"
 D P Q:EX=U
 W !,"     INHIBITOR....................: ",$$GET1^DIQ(165.5,IE,1503)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM7 W !," 7. FAMILY HISTORY OF GASTRIC"
 D P Q:EX=U
 W !,"     CANCER.......................: ",$$GET1^DIQ(165.5,IE,1504)
 W !
 D P Q:EX=U
ITEM8 W !," 8. PERSONAL HISTORY OF OTHER"
 D P Q:EX=U
 W !,"     INVASIVE MALIGNANCIES PRIOR"
 D P Q:EX=U
 W !,"      TO THIS CANCER DIAGNOSIS....: ",$$GET1^DIQ(165.5,IE,1573)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM9
 W !
 D P Q:EX=U
ITEM9 W !," 9. ASSOCIATED BENIGN CONDITIONS:"
 D P Q:EX=U
 W !,"     H-PYLORI INECTION............: ",$$GET1^DIQ(165.5,IE,1505)
 D P Q:EX=U
 W !,"     DUODENAL ULCER...............: ",$$GET1^DIQ(165.5,IE,1506)
 D P Q:EX=U
 W !,"     GASTRIC ULCER................: ",$$GET1^DIQ(165.5,IE,1507)
 D P Q:EX=U
 W !,"     HEARTBURN....................: ",$$GET1^DIQ(165.5,IE,1508)
 D P Q:EX=U
 W !,"     PERNICIOUS ANEMIA............: ",$$GET1^DIQ(165.5,IE,1509)
 D P Q:EX=U
 W !,"     POLYPS OF STOMACH............: ",$$GET1^DIQ(165.5,IE,1510)
 D P Q:EX=U
 W !,"     POLYPOSIS OF SMALL OR LARGE"
 D P Q:EX=U
 W !,"      BOWEL.......................: ",$$GET1^DIQ(165.5,IE,1511)
 D P Q:EX=U
 W !,"     BARRETT'S ESOPHAGUS..........: ",$$GET1^DIQ(165.5,IE,1512)
 D P Q:EX=U
 W !,"     ATROPHIC GASTRITIS...........: ",$$GET1^DIQ(165.5,IE,1513)
 D P Q:EX=U
 W !,"     GASTRIC METAPLASIA...........: ",$$GET1^DIQ(165.5,IE,1514)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCGPC0 G ITEM10
 W !
 D P Q:EX=U
ITEM10 W !,"10. H-PYLORI DRUGS GIVEN:"
 D P Q:EX=U
 W !,"     ANTIBIOTICS..................: ",$$GET1^DIQ(165.5,IE,1515)
 D P Q:EX=U
 W !,"     PROTON PUMP INHIBITORS.......: ",$$GET1^DIQ(165.5,IE,1516)
 D P Q:EX=U
 W !,"     H2 BLOCKERS..................: ",$$GET1^DIQ(165.5,IE,1517)
 D P Q:EX=U
 W !,"     BISMUTH COMPOUNDS............: ",$$GET1^DIQ(165.5,IE,1518)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM11 W !,"11. PRIOR INTRA-ABDOMINAL SURGERY.: ",$$GET1^DIQ(165.5,IE,1519)
 D P Q:EX=U
 W !
 D P Q:EX=U
ITEM12 W !,"12. YEAR OF PRIOR GASTRIC"
 D P Q:EX=U
 W !,"     RESECTION....................: ",$$GET1^DIQ(165.5,IE,1520)
 D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y
 I IOST?1"C".E D HEAD^ONCGPC0
 D ^ONCGPC7A
KILL ;
 K CS,CSDAT,CSI,CSPNT,DESC,DESC1,DESC2,DLC,DOFCT
 K EX,IE,LIN,LINE,LOS,NOP,ONCOLST,TABLE
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
P ;Print
 I ($Y'<(LIN-1)) D  Q:EX=U
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCGPC0 Q
 Q
TASK ;Queue a task
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="PRT^ONCGPC7",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print Gastric Cancers PCE"
 F V2=1:1 S V1=$P(ONCOLST,"^",V2) Q:V1=""  S ZTSAVE(V1)=""
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",!
 K V1,V2,ONCOLST,ZTSK Q
