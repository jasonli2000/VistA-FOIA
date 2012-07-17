DENTV058  ;DSS/KC - Post init DENTAL Patch 58 ;09/17/2009 11:33
 ;;1.2;DENTAL;**58**;Aug 10, 2001;Build 3
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  -----------
 ; 10086      x       HOME^%ZIS
 ; 10063      x       ^%ZTLOAD 
 ; 10005      x       DT^DICRW 
 ; 10013      x       IX1^DIK
 ; 10070      x       ^XMD
 ;
 Q
POST ;queue off the restore of file 228 data
 D TASK
 Q
MSG(X) ;
 S X="   >>>>> "_X_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
TASK ;task off the code to replace inactive ICD-9s
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV058",ZTDESC="DENTV PATCH 58 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 58 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X) Q
 D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
PS ;post-install, replace 239.8 with 239.89 and 799.2 with 799.21
 N OICD2,NICD2,OICD7,NICD7,DENTV
 S OICD2=$$ICD9^DSICDRG(,239.8,,3090930,,1)
 S NICD2=$$ICD9^DSICDRG(,239.89,,3091001,,1)
 S OICD7=$$ICD9^DSICDRG(,799.2,,3090930,,1)
 S NICD7=$$ICD9^DSICDRG(,799.21,,3091001,,1)
 I $$VFIELD^DSICFM06(,228,1.02,1)<0 D NEW ;new 228 file format
 E  D OLD ;old 228 file format
 I $D(DENTV)>9 D MM ;send mailman mess
 D UNF ;fix unfiled data
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM,CNT
 S XMDUZ=DUZ,XMSUB="New ICD-9 Codes for Dental procedures"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The following ADA/CPT Codes were modified:"
 S %=%+1,@R@(%,0)="CODE    Old ICD-9     New ICD-9"
 S %=%+1,@R@(%,0)="==============================="
 S CNT="" F  S CNT=$O(DENTV(CNT)) Q:CNT=""  S %=%+1,@R@(%,0)=DENTV(CNT)
 S %=%+1,@R@(%,0)=""
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
NEW ;Post-P57 environment
 N CPT,ICD,X,DA,DIK,CHG,CPTN S CPT=0
 F  S CPT=$O(^DENT(228,CPT)) Q:'CPT  S ICD=0 F  S ICD=$O(^DENT(228,CPT,5,ICD)) Q:'ICD  D
 .S X=$G(^DENT(228,CPT,5,ICD,0)),CHG=0
 .I +X=+OICD2 S ^DENT(228,CPT,5,ICD,0)=+NICD2,CHG=1
 .I +X=+OICD7 S ^DENT(228,CPT,5,ICD,0)=+NICD7,CHG=2
 .Q:'CHG  S DIK="^DENT(228,",DA=CPT D IX1^DIK
 .S CPTN=$P($$CPT^DSICCPT(,CPT,,,,1),U,2)
 .S DENTV(CPTN)=CPTN_"     "_$S(CHG=1:"239.8",1:"799.2")_"         "_$S(CHG=1:"239.89",1:"799.21")
 Q
OLD ;P56 environment
 N CPT,CPTN,X,Y,Z,CHG,DA,DIK
 S CPT=0 F  S CPT=$O(^DENT(228,CPT)) Q:'CPT  D
 .S X=$G(^DENT(228,CPT,1)),CHG=0
 .F Y=1:1:5 S Z=$P(X,U,Y) D
 ..I Z=+OICD2 S $P(X,U,Y)=+NICD2,CHG=1
 ..I Z=+OICD7 S $P(X,U,Y)=+NICD7,CHG=2
 .Q:'CHG
 .S CPTN=$P($$CPT^DSICCPT(,CPT,,,,1),U,2)
 .S DENTV(CPTN)=CPTN_"     "_$S(CHG=1:"239.8",1:"799.2")_"         "_$S(CHG=1:"239.89",1:"799.21")
 .S ^DENT(228,CPT,1)=X
 .S DIK="^DENT(228,",DA=CPT D IX1^DIK
 Q
UNF ;fix unfiled data - replace the ICD-9s
 N IEN,IENSUB,DATA,X,TYP
 S IEN=0 F  S IEN=$O(^DENT(228.7,IEN)) Q:'IEN  D
 .S IENSUB=0 F  S IENSUB=$O(^DENT(228.7,IEN,1,IENSUB)) Q:'IENSUB  D
 ..S DATA=$G(^DENT(228.7,IEN,1,IENSUB,0)),TYP=$E(DATA,1,6)
 ..I "$$TX$$RI$$LB$$"'[TYP Q
 ..I TYP="$$TX$$",$P(DATA,U,2)]"",$D(DENTV($P(DATA,U,2))) D
 ...I $P(DATA,U,10)=$P(OICD2,U,2) S $P(DATA,U,10)=$P(NICD2,U,2)
 ...I $P(DATA,U,10)=$P(OICD7,U,2) S $P(DATA,U,10)=$P(NICD7,U,2)
 ...S ^DENT(228.7,IEN,1,IENSUB,0)=DATA
 ..I TYP="$$RI$$",$P(DATA,U,3)]"",$D(DENTV($P(DATA,U,3))) D
 ...I +$P(DATA,U,10)=+OICD2 S $P(DATA,U,10)=(+NICD2_"~"_$P(NICD2,U,2)_"~"_$P(NICD2,U,4))
 ...I +$P(DATA,U,10)=+OICD7 S $P(DATA,U,10)=(+NICD7_"~"_$P(NICD7,U,2)_"~"_$P(NICD7,U,4))
 ...S ^DENT(228.7,IEN,1,IENSUB,0)=DATA
 ..I TYP="$$LB$$",($P(DATA,U,4)=+OICD2!($P(DATA,U,4)=+OICD7)) D
 ...I $P(DATA,U,4)=+OICD2 S $P(DATA,U,4,6)=(+NICD2_U_$P(NICD2,U,4)_U_$P(NICD2,U,2))
 ...I $P(DATA,U,4)=+OICD7 S $P(DATA,U,4,6)=(+NICD7_U_$P(NICD7,U,4)_U_$P(NICD7,U,2))
 ...S ^DENT(228.7,IEN,1,IENSUB,0)=DATA
 ..Q
 .Q
 Q
