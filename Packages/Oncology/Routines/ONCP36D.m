ONCP36D ;HINES OIFO/GWB-POST-INSTALL ROUTINE FOR PATCH ONC*2.11*36
 ;;2.11;ONCOLOGY;**36**;Mar 07, 1995
 ;
 D  S:FORDS'="" $P(^ONCO(165.5,IEN,3),U,26)=FORDS
 .S FORDS=""
 .I +SPP<10,RFNS=0 S FORDS=1 Q
 .I +SPP>9,+SPP<91 S FORDS=0 Q
 .I +SPP=99,RFNS="" S FORDS=9 Q
 ;
 D  D RTM S $P(^ONCO(165.5,IEN,27),U,7)="Y"
 .S FORDS=""
 .I $P($G(^ONCO(165.5,IEN,27)),U,7)="Y" Q
 .S RAD=$$GET1^DIQ(165.5,IEN,51.2,"I")
 .S RADAF=$$GET1^DIQ(165.5,IEN,51.4,"I")
 .S RTM=$$GET1^DIQ(165.5,IEN,363,"I")
 .S:RTM'="" RTM=$$GET1^DIQ(166.13,RTM,.01,"I")
 .I (RAD=0)!(RAD=7),(RADAF<1)!(RADAF>5) S FORDS=1 Q
 .I (RAD<1)!(RAD>5),(RADAF=0)!(RADAF=7) S FORDS=1 Q
 .I RAD>0,RAD<6,RTM="01" S FORDS=21 Q
 .I RAD>0,RAD<6,RTM="02" S FORDS=22 Q
 .I RAD>0,RAD<6,RTM="03" S FORDS=23 Q
 .I RAD>0,RAD<6,RTM="04" S FORDS=24 Q
 .I RAD>0,RAD<6,RTM="05" S FORDS=25 Q
 .I RAD>0,RAD<6,RTM="06" S FORDS=26 Q
 .I RAD>0,RAD<6,RTM="07" S FORDS=27 Q
 .I RAD>0,RAD<6,RTM="08" S FORDS=28 Q
 .I RAD>0,RAD<6,RTM="09" S FORDS=29 Q
 .I RAD>0,RAD<6,RTM=10 S FORDS=30 Q
 .I RAD>0,RAD<6,RTM=11 S FORDS=20 Q
 .I RAD>0,RAD<6,RTM=12 S FORDS=33 Q
 .I RAD>0,RAD<6,RTM=13 S FORDS=34 Q
 .I RAD>0,RAD<6,RTM=14 S FORDS=40 Q
 .I RAD>0,RAD<6,RTM=15 S FORDS=41 Q
 .I RAD>0,RAD<6,RTM=16 S FORDS=20 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="01" S FORDS=21 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="02" S FORDS=22 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="03" S FORDS=23 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="04" S FORDS=24 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="05" S FORDS=25 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="06" S FORDS=26 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="07" S FORDS=27 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="08" S FORDS=28 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM="09" S FORDS=29 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=10 S FORDS=30 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=11 S FORDS=20 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=12 S FORDS=33 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=13 S FORDS=34 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=14 S FORDS=40 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=15 S FORDS=41 Q
 .I (RAD=8)!(RAD=9),RADAF>0,RADAF<6,RTM=16 S FORDS=20 Q
 .I RAD=1,(RADAF=2)!(RADAF=3)!(RADAF=4),(+RTM<1)!(+RTM>16) S FORDS=46 Q
 .I RAD=1,RADAF=5,(+RTM<1)!(+RTM>16) S FORDS=47 Q
 .I RAD=1,(+RTM<1)!(+RTM>16) S FORDS=20 Q
 .I RAD=2,(RADAF=1)!(RADAF=4),(+RTM<1)!(+RTM>16) S FORDS=46 Q
 .I RAD=2,(RADAF=3)!(RADAF=5),(+RTM<1)!(+RTM>16) S FORDS=47 Q
 .I RAD=2,(+RTM<1)!(+RTM>16) S FORDS=37 Q
 .I RAD=3,(RADAF=1)!(RADAF=4),(+RTM<1)!(+RTM>16) S FORDS=46 Q
 .I RAD=3,(RADAF=2)!(RADAF=5),(+RTM<1)!(+RTM>16) S FORDS=47 Q
 .I RAD=3,(+RTM<1)!(+RTM>16) S FORDS=43 Q
 .I RAD=4,(+RTM<1)!(+RTM>16) S FORDS=46 Q
 .I RAD=5,(+RTM<1)!(+RTM>16) S FORDS=47 Q
 .I RADAF=1,(+RTM<1)!(+RTM>16) S FORDS=20 Q
 .I RADAF=2,(+RTM<1)!(+RTM>16) S FORDS=37 Q
 .I RADAF=3,(+RTM<1)!(+RTM>16) S FORDS=43 Q
 .I (RADAF=4)!(RADAF=5),(+RTM<1)!(+RTM>16) S FORDS=18 Q
 .I (RAD'="")!(RADAF'="") S FORDS=19 Q
 .
 D  D CMX
 .S (FORDS,FORDSAF)=""
 .S CMX=$$GET1^DIQ(165.5,IEN,53.2,"I")
 .S CMXAF=$$GET1^DIQ(165.5,IEN,53.3,"I")
 .S RFNC=$$GET1^DIQ(165.5,IEN,76,"I")
 .I CMX=0,(RFNC=0)!(RFNC="")!(RFNC=9) S FORDS="00"
 .I CMXAF=0,(RFNC=0)!(RFNC="")!(RFNC=9) S FORDSAF="00"
 .I CMX=1 S FORDS="01"
 .I CMXAF=1 S FORDSAF="01"
 .I CMX=2 S FORDS="02"
 .I CMXAF=2 S FORDSAF="02"
 .I CMX=3 S FORDS="03"
 .I CMXAF=3 S FORDSAF="03"
 .I CMX=7 S FORDS=87
 .I CMXAF=7 S FORDSAF=87
 .I CMX=8 S FORDS=88
 .I CMXAF=8 S FORDSAF=88
 .I (CMX=0)!(CMX=9),RFNC=1 S FORDS="00"
 .I (CMXAF=0)!(CMXAF=9),RFNC=1 S FORDSAF="00"
 .I (CMX=0)!(CMX=9),RFNC=2 S FORDS=82
 .I (CMXAF=0)!(CMXAF=9),RFNC=2 S FORDSAF=82
 .I (CMX=0)!(CMX=9),RFNC=6 S FORDS=86
 .I (CMXAF=0)!(CMXAF=9),RFNC=6 S FORDSAF=86
 .I (CMX=0)!(CMX=9),RFNC=7 S FORDS=87
 .I (CMXAF=0)!(CMXAF=9),RFNC=7 S FORDSAF=87
 .I (CMX=0)!(CMX=9),RFNC=8 S FORDS=88
 .I (CMXAF=0)!(CMXAF=9),RFNC=8 S FORDSAF=88
 .I CMX=9,RFNC=9 S FORDS=99
 .I CMXAF=9,RFNC=9 S FORDSAF=99
 .I CMX=9,RFNC="" S FORDS=99
 .I CMXAF=9,RFNC="" S FORDSAF=99
 .S SUB=0 F  S SUB=$O(SUBTX(SUB)) Q:SUB'>0  D  D SUBCMX
 ..S FORDSUB=""
 ..I $P(SUBTX(SUB),U,6)=0 S FORDSUB="00" Q
 ..I $P(SUBTX(SUB),U,6)=1 S FORDSUB="01" Q
 ..I $P(SUBTX(SUB),U,6)=2 S FORDSUB="02" Q
 ..I $P(SUBTX(SUB),U,6)=3 S FORDSUB="03" Q
 ..I $P(SUBTX(SUB),U,6)=7 S FORDSUB=87 Q
 ..I $P(SUBTX(SUB),U,6)=8 S FORDSUB=88 Q
 ..I $P(SUBTX(SUB),U,6)=9 S FORDSUB=99 Q
 Q
 ;
RTM S:FORDS'="" $P(^ONCO(165.5,IEN,"BLA2"),U,18)=FORDS
 Q
 ;
CMX S:FORDS'="" $P(^ONCO(165.5,IEN,3),U,13)=FORDS
 S:FORDSAF'="" $P(^ONCO(165.5,IEN,3.1),U,14)=FORDSAF
 Q
 ;
SUBCMX S:FORDSUB'="" $P(^ONCO(165.5,IEN,4,SUB,0),U,6)=FORDSUB
 Q
