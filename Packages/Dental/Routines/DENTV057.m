DENTV057  ;DSS/KC - Post init DENTAL Patch 57 ;2/3/2009 10:51
 ;;1.2;DENTAL;**57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ; 10005      x      DT^DICRW
 ; 10070      x       ^XMD
 ; 10063      x      ^%ZTLOAD
 ; 10086      x      HOME^%ZIS
 ; 10013      x      ^DIK
 ; 2053       x      FILE^DIE
 Q
PRE ;  pre-install
 D SAVE^DENTVIP1 ;save off 228 data so that we can restore their $Values and admin notes
 ;
 I $$VFIELD^DSICFM06(,228,1.02,1)<0 Q  ;has been run (installed) before
 ;
 ;delete field 3 in file 220 (DOM/NHCU changed to FLUORIDE CODE 1)
 I $$VFILE^DSICFM06(,220,1)>0,$$VFIELD^DSICFM06(,220,3,1)>0 D
 .D MSG("Deleting FIELD 3 from FILE 220")
 .N DA,DD,DO,DIK S DA(1)=220,DA=3,DIK="^DD(220," D ^DIK
 .Q
 ;
 ;delete field 4 in file 220 (DENTISTRY ADJUNCT changed to FLUORIDE CODE 2)
 I $$VFILE^DSICFM06(,220,1)>0,$$VFIELD^DSICFM06(,220,4,1)>0 D
 .D MSG("Deleting FIELD 4 from FILE 220")
 .N DA,DD,DO,DIK S DA(1)=220,DA=4,DIK="^DD(220," D ^DIK
 .Q
 ;
 ;delete field 5 in file 220 
 ;(COMPLETE EXAM AFTER SCREENING changed to FLUORIDE MONITOR RUN DATE)
 I $$VFILE^DSICFM06(,220,1)>0,$$VFIELD^DSICFM06(,220,5,1)>0 D
 .D MSG("Deleting FIELD 5 from FILE 220")
 .N DA,DD,DO,DIK S DA(1)=220,DA=5,DIK="^DD(220," D ^DIK
 .Q
 ;
 ;delete field 6 in file 220 
 ;(DENTAL CARE NEEDED changed to FLUORIDE RX DATE)
 I $$VFILE^DSICFM06(,220,1)>0,$$VFIELD^DSICFM06(,220,6,1)>0 D
 .D MSG("Deleting FIELD 6 from FILE 220")
 .N DA,DD,DO,DIK S DA(1)=220,DA=6,DIK="^DD(220," D ^DIK
 .Q
 ;
 ;delete field 7 in file 220
 ;(PREVENTIVE DENTISTRY changed to FLUORIDE MONITOR FLAG)
 I $$VFILE^DSICFM06(,220,1)>0,$$VFIELD^DSICFM06(,220,7,1)>0 D
 .D MSG("Deleting FIELD 7 from FILE 220")
 .N DA,DD,DO,DIK S DA(1)=220,DA=7,DIK="^DD(220," D ^DIK
 .Q
 ;
 D DEL ;now delete the old data in those fields
 ;
 ;delete 228 DD
 I $$VFILE^DSICFM06(,228,1)>0 D MSG("Deleting DD for file 228") D
 .N DIU S DIU=228,DIU(0)="" D EN^DIU2
 .Q
 Q
POST ;queue off the restore of file 228 data
 N M S M(1)=" The post-install will be queued, but may take some time to run."
 S M(2)=" It loops through file 228.2 multiple times for two conversions,"
 S M(3)=" and must verify the consistency of the Time Counter field for"
 S M(4)=" grouped (bridge, partials, etc) transactions."
 D MES^DSICXPDU(.M,1)
 D TASK
 Q
MSG(X) ;
 S X=" >> "_X_" <<"
 D MES^DSICXPDU(X,1)
 Q
 ;
TASK ;task off the code to restore 228 site values
 N X,Y,Z,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 I '$D(XPDNM) D  Q:'X
 .I $G(DUZ)<.5 W !!,"Please sign on properly through the Kernel" S X=0
 .E  D HOME^%ZIS,DT^DICRW S X=1
 .Q
 S ZTIO="",ZTDTH=$H,ZTRTN="PS^DENTV057",ZTDESC="DENTV PATCH 57 POST-INSTALL"
 D ^%ZTLOAD S X="Patch 57 post-install successfully queued, task# "_$G(ZTSK)
 I $G(ZTSK) D MSG(X)
 I '$G(ZTSK) D MSG("Could not queue the Post-Install!"),MSG("Enter a Dental Remedy ticket.")
 Q
 ;
PS ;post-install
 D RESTORE^DENTVIP1 ;restore $Values and admin guidelines saved in the pre-install
 D MM ;send MM about file 228
 D UDEL ;undelete deleted
 D TC ;fix time counter
 D RPT ;fix grps specifically for time counter
 Q
MM ;send message
 Q:'DUZ  N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 S XMDUZ=DUZ,XMSUB="New Default Diagnosis for Dental"
 S (%,IEN)=0,R="DENTVTXT",XMY(XMDUZ)="",XMY("G.DENTV ADA CODE MAPPING")=""
 S %=%+1,@R@(%,0)="The Dental Coding Committee has added additional default"
 S %=%+1,@R@(%,0)="Diagnosis (ICD-9) codes to procedures.  This field is now"
 S %=%+1,@R@(%,0)="a multiple, rather than five distinct fields and some procedures"
 S %=%+1,@R@(%,0)="(e.g. D0120) have twelve default diagnosis codes."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="Sites may add to the list of default diagnoses, but may"
 S %=%+1,@R@(%,0)="NO LONGER edit or replace or rearrange the defaults from the"
 S %=%+1,@R@(%,0)="Dental Coding Committee to be saved in file 228."
 S %=%+1,@R@(%,0)=""
 S %=%+1,@R@(%,0)="Sites are still allowed to add diagnosis codes ""on the fly"""
 S %=%+1,@R@(%,0)="while selecting procedures for an encounter."
 S %=%+1,@R@(%,0)=""
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
 ;
DEL ;delete any residual data in file 220 fields 3,4,5,6,7
 N I,X,CNT S I=0,CNT=0
 D MSG("Ensuring data fields 3-7 are clean in file 220") W !
 F  S I=$O(^DENT(220,I)) Q:'I  S CNT=CNT+1,X=$G(^(I,0)),$P(X,U,4,8)="^^^^" W:CNT#500=0 "." S ^DENT(220,I,0)=X
 Q
 ;
 ;
UDEL ;undelete deleted txns from NON-ADMIN users
 N IDT,EDT,IEN,TXN,X0,X1,DENTV
 ;STARTING POINT: "AF" XREF IS CREATE DATE
 S IDT=3050101,EDT=DT+.24
 F  S IDT=$O(^DENT(228.1,"AF",IDT)) Q:'IDT!(IDT>EDT)  D
 .S IEN=0 F  S IEN=$O(^DENT(228.1,"AF",IDT,IEN)) Q:'IEN  D TXNS
 .Q
 Q
TXNS S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",IEN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1))
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)  ;bad data, no ada code, not a txn
 .I $P(X0,U,12)'=104 Q  ;only COMPLETE
 .I '$P(X1,U,3) Q  ;not DELETED (we're un-deleting remember)
 .I $$GET1^DSICXPR(,"USR.`"_$P(X1,U,4)_"~DENTV DRM ADMINISTRATOR",1)=1 Q  ;delete person is admin, don't include
 .K DENTV S DENTV(228.2,TXN_",",1.03)="@" ;undelete the transaction
 .I $$GET1^DIQ(228.2,TXN,1.18,"I")'="" S DENTV(228.2,TXN_",",1.18)="P" ;resend to Austin
 .D FILE^DIE(,"DENTV")
 .Q
 Q
 ;
TC ;fix the Time Counter field (#.14) in file 228.2
 ;this field must be unique for a txn or ranged 'set' (like bridges) of txns
 ;it was not unique if one user filed unfiled data to a patient
 ;and another filed txn data on the same day for the same patient
 ;when the first user filed the unfiled data the time counter did not increment
 ;but used the same numbers as currently existed in the file.
 ;this caused the app to delete txns incorrectly (hence the undelete above)
 N PAT,CDT
 S PAT=0 F  S PAT=$O(^DENT(228.2,"AE",PAT)) Q:'PAT  D
 .S CDT=0 F  S CDT=$O(^DENT(228.2,"AE",PAT,CDT)) Q:'CDT  D EACHD
 Q
EACHD ;each day is evaluated
 N TC,IEN,GRP,EACHD,FLAG,NEWTC,DENTV,LASTC,REDO,QUIT,FIRST,CNT,GRPD
 S TC=0,FLAG=0 F  S TC=$O(^DENT(228.2,"AE",PAT,CDT,TC)) Q:'TC  D
 .S IEN=0 F  S IEN=$O(^DENT(228.2,"AE",PAT,CDT,TC,IEN)) Q:'IEN  D
 ..S GRP=$$GET1^DIQ(228.2,IEN,.22)>0
 ..I $D(EACHD(TC,0)) S FLAG=1 ;We have dup tc single or grouped txns
 ..I $D(EACHD(TC)),$O(EACHD(TC,0))'=GRP S FLAG=1 ;We have dup tc grouped txns
 ..S EACHD(TC,GRP,IEN)=$$GET1^DIQ(228.2,IEN,.22)
 ..I EACHD(TC,GRP,IEN)>0 S GRPD(IEN)=EACHD(TC,GRP,IEN)_U_TC
 ..Q
 .Q
 ;quit if we're not working with dupes
 Q:'FLAG
 ;get rid of the singles and one of each duplicate tc
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP="",QUIT=0 F  S GRP=$O(EACHD(TC,GRP)) Q:GRP=""!QUIT  D
 ..I GRP=0 S IEN=0,IEN=$O(EACHD(TC,GRP,IEN)) K EACHD(TC,GRP,IEN) S QUIT=1 Q
 ..S IEN=0 F  S IEN=$O(EACHD(TC,GRP,IEN)) Q:'IEN  K EACHD(TC,GRP,IEN)
 ..S QUIT=1
 ..Q
 .Q
 ;now reset the tc for what's left
 K LASTC
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP="" F  S GRP=$O(EACHD(TC,GRP)) Q:GRP=""  D
 ..S IEN=0 F  S IEN=$O(EACHD(TC,GRP,IEN)) Q:'IEN  D
 ...S NEWTC=0
 ...I EACHD(TC,GRP,IEN)>1 S NEWTC=$$LOOK(IEN)
 ...I 'NEWTC S NEWTC=$$NEWTC(PAT,CDT,TC,IEN)
 ...I GRP S GRPD(IEN)=+$G(GRPD(IEN))_U_NEWTC
 ...K DENTV S DENTV(228.2,IEN_",",.14)=NEWTC D FILE^DIE(,"DENTV")
 ...Q
 ..Q
 .Q
 Q
LOOK(IEN) ;lookup previous group txn using IEN
 N X,Y,I S I=EACHD(TC,GRP,IEN)
 S X=$O(GRPD(IEN),-1) I X S Y=GRPD(X) I +Y=(I-1) Q $P(Y,U,2)
 S X=$O(GRPD(99999999),-1) I X S Y=GRPD(X) I +Y=(I-1) Q $P(Y,U,2)
 Q 0
NEWTC(PAT,CDT,TC,IEN) ;get the new timecounter value
 N LAST
 S LAST=$G(LASTC("TC",TC)) I LAST Q LAST
 S LAST=$O(^DENT(228.2,"AE",PAT,CDT,9999),-1),LAST=LAST+10 ;get last tc and add 10
 ;save in case of grouped txns and update the timecounter field with new tc
 S LASTC("TC",TC)=LAST
 Q LAST
 ;
RPT ;check AGAIN for grp txns that did not convert correctly the first time
 ;grps must all have the same TC so they may not have 'hit' on the above check
 ;they could have been screened out since if the placeholder txn has a diff TC for example
 N PAT,CDT
 S PAT=0 F  S PAT=$O(^DENT(228.2,"AE",PAT)) Q:'PAT  D
 .S CDT=0 F  S CDT=$O(^DENT(228.2,"AE",PAT,CDT)) Q:'CDT  D DAYS
 Q
DAYS ;each day is evaluated
 N TC,IEN,GRP,EACHD,FLAG,NEWTC,DENTV,LASTC,REDO,QUIT,FIRST,CNT,GRPD,ERR
 S TC=0,FLAG=0 F  S TC=$O(^DENT(228.2,"AE",PAT,CDT,TC)) Q:'TC  D
 .S IEN=0 F  S IEN=$O(^DENT(228.2,"AE",PAT,CDT,TC,IEN)) Q:'IEN  D
 ..S GRP=$$GET1^DIQ(228.2,IEN,.22) Q:'GRP!(GRP<0)
 ..S EACHD(TC,GRP,IEN)=GRP
 ..S GRPD(IEN)=GRP_U_TC
 ..Q
 .Q
 Q:'$D(EACHD)
 ;check that grps have the same TC
 S TC=0 F  S TC=$O(EACHD(TC)) Q:'TC  D
 .S GRP=0,CNT=0,ERR=0,QUIT=0 F  S GRP=$O(EACHD(TC,GRP)),CNT=CNT+1 Q:'GRP!QUIT  D
 ..I GRP'=CNT S ERR=1
 ..Q:'ERR
 ..S IEN=$O(EACHD(TC,GRP,0)) Q:'IEN
 ..S NEWTC=$$LOOK(IEN) I 'NEWTC S ^XTMP("DENT57",IEN)=PAT_U_CDT_U_TC_U_GRP,QUIT=1 Q
 ..S GRPD(IEN)=+$G(GRPD(IEN))_U_NEWTC
 ..K DENTV S DENTV(228.2,IEN_",",.14)=NEWTC D FILE^DIE(,"DENTV")
 ..Q
 .Q
 I $D(^XTMP("DENT57")) S ^XTMP("DENT57",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"DENT P57 CONV ISSUES"
 Q 
