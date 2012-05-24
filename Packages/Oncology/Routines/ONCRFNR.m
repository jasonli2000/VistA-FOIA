ONCRFNR ;Hines OIFO/GWB; REASON FOR NO RADIATION; 08/02/06
 ;;2.11;ONCOLOGY;**46**;Mar 07, 1995;Build 39
 ;
 ;REASON FOR NO RADIATION (165.5,75)
 S RAD=$P($G(^ONCO(165.5,DA,3)),U,6)
 K RFNRMSG
 I RFNR=8 D
 .Q:$P(^ONCO(165.5,DA,3),U,4)=8888888
 .S TXDT=$P(^ONCO(165.5,DA,3),U,4)_"R"
 .K ^ONCO(165.5,"ATX",DA,TXDT)
 .S $P(^ONCO(165.5,DA,3),U,4)=8888888 D RADDT^ONCATF1
 .S ^ONCO(165.5,"ATX",DA,"8888888R")=""
 .S RFNRMSG="DATE RADIATION STARTED changed to 88/88/8888"
 I RFNR'=8,RAD=0 D
 .Q:$P(^ONCO(165.5,DA,3),U,4)="0000000"
 .S TXDT=$P(^ONCO(165.5,DA,3),U,4)_"R"
 .K ^ONCO(165.5,"ATX",DA,TXDT)
 .S $P(^ONCO(165.5,DA,3),U,4)="0000000" D RADDT^ONCATF1
 .S ^ONCO(165.5,"ATX",DA,"0000000R")=""
 .S RFNRMSG="DATE RADIATION STARTED changed to 00/00/0000"
 I RFNR'=8,RAD=9 D
 .Q:$P(^ONCO(165.5,DA,3),U,4)=9999999
 .S TXDT=$P(^ONCO(165.5,DA,3),U,4)_"R"
 .K ^ONCO(165.5,"ATX",DA,TXDT)
 .S $P(^ONCO(165.5,DA,3),U,4)=9999999 D RADDT^ONCATF1
 .S ^ONCO(165.5,"ATX",DA,"9999999R")=""
 .S RFNRMSG="DATE RADIATION STARTED changed to 99/99/9999"
 S COC=$P($G(^ONCO(165.5,DA,0)),U,4)
 I (COC=0)!(COC=3)!(COC=6) D
 .I RFNR=8 S $P(^ONCO(165.5,DA,3.1),U,13)=8888888
 .I RFNR'=8 S $P(^ONCO(165.5,DA,3.1),U,13)="0000000"
 D RADDT^ONCATF1
 Q
