ONCPST13 ;HIRMFO/GWB - Post-init for Patch ONC*2.11*13;7/15/97
 ;;2.11;ONCOLOGY;**13**; Mar 07, 1995
FS ;Reindex FOLLOW-UP STATUS (160,15.2) field
 W !,"Reindexing FOLLOW-UP STATUS (160,15.2) field..."
 K ^ONCO(160,"AFS")
 S DIK="^ONCO(160,",DIK(1)="15.2" D ENALL^DIK
 K DIK
OSS ;Delete ONCO SPECIFIC SURGERY Help Frame
 S DIK="^DIC(9.2,",DA=$O(^DIC(9.2,"B","ONCO SPECIFIC SURGERY",0))
 D:DA'="" ^DIK
 K DIK,DA
FID ;Replace FACILITY file ID nodes
 S ^DD(160.19,0,"ID",.02)="W $E($P(^(0),U,2),1,39)"
 S ^DD(160.19,0,"ID",.03)="W ?54,$P(^(0),U,3)"
 S ^DD(160.19,0,"ID",.04)="W ?77,$P(^(0),U,4)"
RS ;Modify RECONSTRUCTIVE SURGERY code 8
 S ^ONCO(160.4,9,0)="8^NA, no surgery"
SA ;Modify SURGICAL APPROACH codes 4 and 9
 S ^ONCO(160.6,5,0)="4^Laparoscopy, NOS"
 S ^ONCO(160.6,9,0)="9^Unknown approach, NA"
 ;Delete the following entry from the CODE/DESCRIPTION (164.5,4)
 ;multiple of the BRAIN entry of the SEER CODE SET (164.5) file:
 ;16 Confined to brain/meninges, NOS
 S IEN=$O(^ONCO(164.5,"B","BRAIN",0))
 I IEN="" K IEN Q
 S DIK="^ONCO(164.5,"_IEN_",1,",DA=16,DA(1)=IEN
 D ^DIK
 K DIK,DA Q
 Q
