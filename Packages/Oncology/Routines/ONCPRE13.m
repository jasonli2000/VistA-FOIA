ONCPRE13 ;HIRMFO/RTK-PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*13  07/31/97
 ;;2.11;ONCOLOGY;**13**;Mar 07, 1995
 ;
 ;Kill ONCOLOGY DATA EXTRACT FORMAT (160.16) data.
 ;Kill REGIONAL TREATMENT MODALITY (160.13) data.
 ;New data will be recreated by the build.
 K ^ONCO(166.13)
 K ^ONCO(160.16)
 ; Loop thru Primary (#165.5) file, check CLINICAL (#38) and PATHOLOGIC
 ; (#88) STAGE GROUP fields, and convert if necessary (I to 1, II to 2
 ; III to 3, IV to 4, NA to 88, Unknown to 99 etc...)
 ; Null out data for deleted fields HYPERTHERMIA THERAPY DATE (#56),
 ; HYPERTHERMIA THERAPY HOSPITAL (#56.1) and HYPERTHERMIA THERAPY (#56.2)
 ;
 ; Call ONCPREMR to check for duplicates in file #164.1
 D ^ONCPREMR
 ;
 S CTR=0
 W !!,"Converting CLINICAL STAGE GROUP (#38) and PATHOLOGIC STAGE GROUP (#88) fields"
 F PRMIEN=0:0 S PRMIEN=$O(^ONCO(165.5,PRMIEN)) Q:PRMIEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .I $D(^ONCO(165.5,PRMIEN,3)) S $P(^ONCO(165.5,PRMIEN,3),"^",20)="",$P(^ONCO(165.5,PRMIEN,3),"^",21)="",$P(^ONCO(165.5,PRMIEN,3),"^",22)=""
 .I $D(^ONCO(165.5,PRMIEN,2)) S CSG=$P(^ONCO(165.5,PRMIEN,2),"^",20) D
 ..I CSG="" Q
 ..S Z=CSG D CHECK I CSG'=Z S $P(^ONCO(165.5,PRMIEN,2),"^",20)=Z Q
 .I $D(^ONCO(165.5,PRMIEN,2.1)) S PSG=$P(^ONCO(165.5,PRMIEN,2.1),"^",4) D
 ..I PSG="" Q
 ..S Z=PSG D CHECK I PSG'=Z S $P(^ONCO(165.5,PRMIEN,2.1),"^",4)=Z Q
 .Q
 ;
 ; Convert Primary (#165.5) file fields REASON FOR NO RADIATION (#75),
 ; REASON FOR NO CHEMOTHERAPY (#76) and REASON FOR NO HORMONE THERAPY
 ; (#77), from Pointers to files (#160.7, #160.8, #160.9, respectively)
 ; to sets of codes.
 ;
 I '$D(^ONCO(160.7)) K CSG,CTR,PRMIEN,PSG,Z Q
 S CTR=0
 W !!,"Converting REASON FOR NO RADIATION (#75), REASON FOR NO CHEMOTHERAPY (#76) and REASON FOR NO HORMONE THERAPY (#77) fields"
 F PRMIEN=0:0 S PRMIEN=$O(^ONCO(165.5,PRMIEN)) Q:PRMIEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .I '$D(^ONCO(165.5,PRMIEN,3)) Q
 .S RPT=$P(^ONCO(165.5,PRMIEN,3),"^",35) I RPT'="" D
 ..S RCD=$P($G(^ONCO(160.7,RPT,0)),"^",1)
 ..S $P(^ONCO(165.5,PRMIEN,3),"^",35)=RCD Q
 .S CPT=$P(^ONCO(165.5,PRMIEN,3),"^",36) I CPT'="" D
 ..S CCD=$P($G(^ONCO(160.8,CPT,0)),"^",1)
 ..S $P(^ONCO(165.5,PRMIEN,3),"^",36)=CCD Q
 .S HPT=$P(^ONCO(165.5,PRMIEN,3),"^",37) I HPT'="" D
 ..S HCD=$P($G(^ONCO(160.9,HPT,0)),"^",1)
 ..S $P(^ONCO(165.5,PRMIEN,3),"^",37)=HCD Q
 .Q
 ;
 ; Convert IMMUNOTHERAPY (BRM) (#55.2) field of Primary file (#165.5)
 ; from pointer to (#160.5) file to set of codes.
 ;
 S CTR=0
 W !!,"Converting IMMUNOTHERAPY (BRM) field"
 F PRMIEN=0:0 S PRMIEN=$O(^ONCO(165.5,PRMIEN)) Q:PRMIEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .I '$D(^ONCO(165.5,PRMIEN,3)) Q
 .S IMM=$P(^ONCO(165.5,PRMIEN,3),"^",19) Q:IMM=""
 .I IMM<1!(IMM>10) S $P(^ONCO(165.5,PRMIEN,3),"^",19)="" Q
 .I IMM=6!(IMM=10) S IMM=$S(IMM=6:0,IMM=10:6,1:IMM),$P(^ONCO(165.5,PRMIEN,3),"^",19)=IMM
 .Q
 ;
 ; Also need to convert IMMUNOTHERAPY (BRM) (#.08) **sub-field** of
 ; SUBSEQUENT COURSE OF TREATMENT (#60) field of Primary file (#165.5)
 ; from pointer to (#160.5) file to set of codes.
 ;
 S CTR=0 K IMM
 W !!,"Converting IMMUNOTHERAPY (BRM) sub-field of SUBSEQUENT COURSE"
 W !,"OF TREATMENT multiple"
 F PRMIEN=0:0 S PRMIEN=$O(^ONCO(165.5,PRMIEN)) Q:PRMIEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .I '$D(^ONCO(165.5,PRMIEN,4)) Q
 .F SBSQ=0:0 S SBSQ=$O(^ONCO(165.5,PRMIEN,4,SBSQ)) Q:SBSQ'>0  D
 ..I '$D(^ONCO(165.5,PRMIEN,4,SBSQ,3)) Q
 ..S IMM=$P(^ONCO(165.5,PRMIEN,4,SBSQ,3),"^",19) I IMM="" K ^ONCO(165.5,PRMIEN,4,SBSQ,3) Q
 ..I IMM<1!(IMM>10) S $P(^ONCO(165.5,PRMIEN,4,SBSQ,0),"^",8)="" K ^ONCO(165.5,PRMIEN,4,SBSQ,3) Q
 ..S IMM=$S(IMM=6:0,IMM=10:6,1:IMM),$P(^ONCO(165.5,PRMIEN,4,SBSQ,0),"^",8)=IMM K ^ONCO(165.5,PRMIEN,4,SBSQ,3) Q
 .Q
 ;
DELETE ; DELETE FILES #160.5,#160.7,#160.8 AND #160.9
 S DIU="^ONCO(160.5,",DIU(0)="D" D EN^DIU2
 S DIU="^ONCO(160.7,",DIU(0)="D" D EN^DIU2
 S DIU="^ONCO(160.8,",DIU(0)="D" D EN^DIU2
 S DIU="^ONCO(160.9,",DIU(0)="D" D EN^DIU2
 K CCD,CPT,CSG,CTR,DIU,HCD,HPT,IMM,PRMIEN,PSG,RCD,RPT,SBSQ,Z
 ;Delete the following fields:
 ;   *TYPE SURGERY                 (165.5,50.2)
 ;   HYPERTHERMIA THERAPY DATE     (165.5,56)
 ;   HYPERTHERMIA THERAPY HOSPITAL (165.5,56.1)
 ;   HYPERTHERMIA THERAPY          (165.5,56.2)
 S DIK="^DD(165.5,",DA=50.2,DA(1)=165.5 D ^DIK
 I $P(^DD(165.5,56,0),"^",1)="HYPERTHERMIA THERAPY DATE" S DIK="^DD(165.5,",DA=56,DA(1)=165.5 D ^DIK
 S DIK="^DD(165.5,",DA=56.1,DA(1)=165.5 D ^DIK
 S DIK="^DD(165.5,",DA=56.2,DA(1)=165.5 D ^DIK
 K DIK,DA Q
 ;
CHECK S Z=$S(Z["NA":88,Z["Unk":99,Z["Occ":"0C",Z="0a":"0A",Z="0is":"0S",1:Z)
 I Z="IIIE+S" S Z="3ES" Q
 I Z="V" S Z=5 Q
 I $E(Z,1,2)="IV" S Z=4_$E(Z,3) Q
 I $E(Z,1,3)="III" S Z=3_$E(Z,4) Q
 I $E(Z,1,2)="II" S Z=2_$E(Z,3) Q
 I $E(Z,1)="I" S Z=1_$E(Z,2) Q
 Q
