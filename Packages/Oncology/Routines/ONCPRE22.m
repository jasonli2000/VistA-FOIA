ONCPRE22 ;HIRMFO/GWB,RTK-PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*22
 ;;2.11;ONCOLOGY;**22**;Mar 07, 1995
 ;Delete files #166.1 and #166.12
 S DIU="^ONCO(166.1,",DIU(0)="D" D EN^DIU2  ;ONCOLOGY BLADDER CANCER
 K ^DD(164,0,"ID","W")
 I $G(^ONCO(164.5,248,1,100,0))'="" S ^ONCO(164.5,248,1,91,0)=^ONCO(164.5,248,1,100,0) K ^ONCO(164.5,248,1,100,0) S ^ONCO(164.5,248,1,0)="^164.54A^91^20"
 K ^ONCO(160.16) ; PURGE Extract File
 K ^ONCO(160.17) ; PURGE PCE Extract File
EDIT ;Edit the NAME (#.01) value of entries #151 and #152 in the SEER CODE
 ;SET (#164.5) file: From: SG52  MALE GENITAL, OTHER/PENIS  To: PENIS
 S DIE="^ONCO(164.5,",DA=151,DR=".01///PENIS" D ^DIE
 S DIE="^ONCO(164.5,",DA=152,DR=".01///PENIS" D ^DIE
 K DIU,DIE,DA,DR
ATX ;Delete "AT THIS FACILITY" entries from the "ATX" cross-reference,
 ;they are in the form ^ONCO(165.5,D0,"2980426RF").
 F PR=0:0 S PR=$O(^ONCO(165.5,"ATX",PR)) Q:PR'>0  D
 .S TDT="" F  S TDT=$O(^ONCO(165.5,"ATX",PR,TDT)) Q:TDT=""  I $L(TDT)>8 K ^ONCO(165.5,"ATX",PR,TDT)
 .Q
 K PR,TDT
 ;Then delete the X-REF off of the TX @FAC DATE fields. To do this,
 ;delete the entire field and it will be brought back without the X-REF.
 S DIK="^DD(165.5,",DA(1)=165.5 F DA=1.2,2.1,50.3,138.3,139.3,51.5,53.4,54.4,55.4,57.4 D ^DIK
 ;
PKGFILE ;Rename PREFIX of ONCOLOGY package file entry to "ONC", move patches
 ;from bogus package file entry to correct one, delete patches from
 ;bogus entry and rename PREFIX of bogus entry to "ONCZ"
 ;
 S ONCOPF="",FND=0
 S NM=""
 F  S NM=$O(^DIC(9.4,"B",NM)) Q:NM=""!(FND=1)  I NM="ONCOLOGY" D
 .S BXF=$O(^DIC(9.4,"B",NM,""))
 .I $P($G(^DIC(9.4,BXF,0)),"^",3)'["Oncology treatment tracking & tumor registry package" Q
 .S ONCOPF=BXF,FND=1 Q
 I ONCOPF="" Q
 ;
 S ONC211="",FND=0
 S NM=""
 F  S NM=$O(^DIC(9.4,"B",NM)) Q:NM=""!(FND=1)  I NM["ONC*2.11*1" D
 .S BXF=$O(^DIC(9.4,"B",NM,""))
 .I $P($G(^DIC(9.4,BXF,0)),"^",3)'["This patch will make Oncology compliant with ROADS 96" Q
 .S ONC211=BXF,FND=1 Q
 I ONC211="" Q
 ;
 I $O(^DIC(9.4,"C","ONCZ",""))'="" Q
 N DIE,DA,X
 I ONC211'="" S DIE="^DIC(9.4,",DA=ONC211,DR="1///ONCZ" D ^DIE
 I ONCOPF'="" S DIE="^DIC(9.4,",DA=ONCOPF,DR="1///ONC" D ^DIE
 S VNUMPF="",VNUMPF=$O(^DIC(9.4,ONCOPF,22,"B",2.11,VNUMPF))
 S VNUM21="",VNUM21=$O(^DIC(9.4,ONC211,22,"B",2.11,VNUM21))
 F PNUM=0:0 S PNUM=$O(^DIC(9.4,ONC211,22,VNUM21,"PAH",PNUM)) Q:PNUM'>0  D
 .S PATCH=$P($G(^DIC(9.4,ONC211,22,VNUM21,"PAH",PNUM,0)),"^",1,3)
 .I $P(PATCH,"^",1)'=1,$P(PATCH,"^",1)'=14,$P(PATCH,"^",1)'=15 Q
 .S PAH=$P(PATCH,"^",1),DATEAP=$P(PATCH,"^",2),APPBY=$P(PATCH,"^",3)
 .K DD,DO S DIC="^DIC(9.4,"_ONCOPF_",22,"_VNUMPF_",""PAH"","
 .S DIC(0)="",DIC("DR")=".02///^S X=DATEAP;.03///^S X=APPBY"
 .S DA(2)=ONCOPF,DA(1)=VNUMPF,X=PAH
 .D FILE^DICN
 .S DIK="^DIC(9.4,"_ONC211_",22,"_VNUM21_",""PAH"","
 .S DA(2)=ONC211,DA(1)=VNUM21,DA=PNUM
 .D ^DIK
 .Q
 K APPBY,BXF,DATEAP,NM,ONCOPF,ONC211,PAH,PATCH,VNUMPF,VNUM21 Q
