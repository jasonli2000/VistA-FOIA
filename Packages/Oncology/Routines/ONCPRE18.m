ONCPRE18 ;HINES CIOFO/GWB-PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*18
 ;;2.11;ONCOLOGY;**18**;Mar 07, 1995
 ;
 ;Create new entry 000000 in the FACILITY (#160.19) file
 ;See INSTITUTION REFERRED FROM and INSTITUTION REFERRED TO
 ;(ROADS pages 94 and 95) for details.
 I '$D(^ONCO(160.19,"B","000000")) K DD,DO S DIC="^ONCO(160.19,",DIC(0)="L",DIC("DR")=".02////NONE",X="000000" D FILE^DICN
 K DIC,X
 ;
 ;Convert TYPE OF STAGING SYSTEM (PED) (#165.5,849) values of 88 to 17
 ;Field is pointer and data value of 88 was being stuffed instead of
 ;pointer value of 17.
 W !!," Fixing bad TYPE OF STAGING SYSTEM (PED) pointers..."
 S CT=0 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I $P($G(^ONCO(165.5,IEN,"NHL2")),U,4)=88 S $P(^ONCO(165.5,IEN,"NHL2"),U,4)=17
POD ;Convert PLACE OF DEATH (#165.5,21) pointers from pointers to ZIP CODE
 ;(#5.11) file to pointers to GEOCODES (#165.2) file
 I $P(^DD(160,21,0),U,2)["P165.2" G DDD
 W !!," Converting PLACE OF DEATH pointers..."
 S CT=0 F PTIEN=0:0 S PTIEN=$O(^ONCO(160,PTIEN)) Q:PTIEN'>0  D  S $P(^ONCO(160,PTIEN,1),U,5)=PODPNT
 .S PODPNT="",CT=CT+1 I CT#100=0 W "."
 .I '$D(^ONCO(160,PTIEN,1)) Q
 .S ZIPPNT=$P($G(^ONCO(160,PTIEN,1)),U,5) I ZIPPNT="" Q
 .I '$D(^VIC(5.11,ZIPPNT,0)) S PODPNT=999 Q  ;PLACE OF DEATH=999 Unknown
 .S CTYPNT=$P(^VIC(5.11,ZIPPNT,0),U,3)
 .I '$D(^VIC(5.1,CTYPNT,0)) S PODPNT=999 Q   ;PLACE OF DEATH=999 Unknown
 .S STAPNT=$P(^VIC(5.1,CTYPNT,0),U,2)
 .I '$D(^DIC(5,STAPNT,0)) S PODPNT=999 Q     ;PLACE OF DEATH=999 Unknown
 .S POD=$P(^DIC(5,STAPNT,0),U,1),PODPNT=$O(^ONCO(165.2,"B",POD,0))
 ;
DDD ;Delete PLACE OF DEATH (#160,21) to remove output transform.
 S DIK="^DD(160,",DA=21,DA(1)=160 D ^DIK
 ;Delete AGENT ORANGE EXPOSURE       (#160,48)
 ;       IONIZING RADIATION EXPOSURE (#160,50)
 ;       PERSIAN GULF SERVICE        (#160,51)
 ;to remove 9 and 9.01 nodes from DDs.  These fields were originally
 ;defined as COMPUTED and these nodes were left over after field 
 ;definitions were changed to SETs OF CODES.
 ;These fields will be recreated by the install.
 S DIK="^DD(160,",DA=48,DA(1)=160 D ^DIK
 S DIK="^DD(160,",DA=50,DA(1)=160 D ^DIK
 S DIK="^DD(160,",DA=51,DA(1)=160 D ^DIK
 K DIK,DA
 ;
 ;Kill GEOCODES data ^ONCO(165.2).
 ;New data will be recreated by the install.
 K ^ONCO(165.2)
 Q
