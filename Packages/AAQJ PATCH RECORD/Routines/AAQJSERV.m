AAQJSERV ;FGO/JHS; Update TST Patch UCI (#436016) ;01-28-99 [6/6/01 2:41pm]
 ;;1.4;AAQJ PATCH RECORD;; May 14, 1999
 N CNT,DOMAIN,INSTBY,INSTNAME,PACKAGE,ENV,SITE,START,STOP,VERSION,XMDUZ,XMSER,XMSUB,XMTEXT,XMY
 K ^TMP("AAQJRCV",$J),^TMP("AAQJSND",$J) S AAQBY=""
 X XMREC I XMER'=0 S ^TMP($J,"AAQJRCV",$J,1)="" D ERR("NO MESSAGE"),CLEANUP Q
 S ^TMP("AAQJRCV",$J,1)=XMRG
 I $E(XMRG,1,15)="PACKAGE INSTALL" D UNLOAD,PAC,CLEANUP Q
 D UNLOAD,ERR("BAD FORMAT"),CLEANUP
 Q
UNLOAD F CNT=2:1  X XMREC Q:XMER'=0  S ^TMP("AAQJRCV",$J,CNT)=XMRG
 Q
CLEANUP S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 K ^TMP("AAQJRCV",$J),XMER,XMREC,XMRG,XMZ,XQMSG,XQSOP
 Q
PAC ; Extract data from message
 S DOMAIN=$P($G(^TMP("AAQJRCV",$J,2)),": ",2)
 S PACKAGE=$P($G(^TMP("AAQJRCV",$J,3)),": ",2,99)
 S VERSION=$P($G(^TMP("AAQJRCV",$J,4)),": ",2)
 S START=$P($G(^TMP("AAQJRCV",$J,5)),": ",2)
 S STOP=$P($G(^TMP("AAQJRCV",$J,6)),": ",2)
 S ENV=$P($G(^TMP("AAQJRCV",$J,7)),": ",2)
 S INSTBY=$P($G(^TMP("AAQJRCV",$J,8)),": ",2)
 S INSTNAME=$P($G(^TMP("AAQJRCV",$J,9)),": ",2)
 ; Only update sites and applications being tracked
 I '$L(DOMAIN) D ERR("NO DOMAIN") Q
 I '$L(PACKAGE) D ERR("NO PACKAGE") Q
 I 'VERSION D ERR("NO VERSION") Q
 I VERSION'[".",VERSION=+VERSION S VERSION=VERSION_".0"
 S X=$P($G(^XTV(8989.3,1,0)),U,1) I X="" D ERR("NO DOMAIN NAME") Q
 D UCI^%ZOSV S AAQUCI=$P(Y,",",1),AAQDOM=$P(^DIC(4.2,X,0),U,1),AAQDOM="TEST."_AAQDOM
 I DOMAIN["MED" S DOMAIN1=$P(DOMAIN,".MED.VA.GOV")
 E  S DOMAIN1=$P(DOMAIN,".VA.GOV")
 I AAQDOM["MED" S AAQDOM1=$P(AAQDOM,".MED.VA.GOV")
 E  S AAQDOM1=$P(AAQDOM,".VA.GOV")
 I DOMAIN1'=AAQDOM1 D ERR("WRONG SITE-"_DOMAIN) Q
 D FILE
EXIT W ! K %,%DT,%Y,AAQBY,AAQCOMM,AAQDOM,AAQDOM1,AAQDT,AAQDUZ,AAQIRM,AAQLOC,AAQMETH,AAQP,AAQPM,AAQPNO,AAQPV,AAQSITN,AAQSYS,AAQT,AAQTM,AAQUCI,AAQUNO,AAQUV,AAQV,AAQVER,AAQX,AAQX1,AAQX12,AAQX2,AAQX3
 K D0,DD,DOMAIN1,DR,MSG,XMER,XMREC,XMRG
 Q
ERR(ERRMSG)  ; Returns an error message to 'Installed by' user
 S CNT=0 F  S CNT=$O(^TMP("AAQJRCV",$J,CNT)) Q:CNT<1  S ^TMP("AAQJSND",$J,CNT,0)=^(CNT)
 S ^(0)=^TMP("AAQJSND",$J,1,0)_"   ***"_ERRMSG_"***"
 S XMY(DUZ)="",XMDUZ="Patch Updating Error",XMTEXT="^TMP(""AAQJSND"",$J,",XMSUB=$E("Update Error-"_ERRMSG,1,55)
 D ^XMD
 Q
FILE ; Date is not changed if a date already exists for this Patch
 S AAQLOC=0
 N DA,DIC,DIE,DLAYGO,DR,X,Y
 S AAQP=INSTNAME,X=AAQP Q:$L(X)>50!($L(X)<3)
 Q:X'["*"  I X["*" K:$P(X,"*",2,3)'?1.2N1"."1.2N.1(1"V",1"T").2N1"*"1.6N X
 G:'$D(X) EXIT
 S AAQMETH=$P(ENV,U,5),AAQCOMM=$P(ENV,U,6)
 I INSTBY["^" S AAQBY=$P(INSTBY,U),AAQSITN=$P(INSTBY,U,2)
 S AAQUV=$P(ENV,U,1)_","_$P(ENV,U,2)
 S AAQX1=$P(AAQP,"*",1),AAQX2=$P(AAQP,"*",2) D CHKLOC S AAQX12=AAQX1_"*"_AAQX2
 S AAQX3=$P(AAQP,"*",3) I $L(AAQX3)<2 S AAQX3="0"_AAQX3 K DD,DIC,D0
 I AAQLOC=1 S AAQX3="L"_AAQX3
 I AAQCOMM["TEST v" S AAQVER=$P(AAQCOMM,"TEST v",2),AAQX3=AAQX3_"V"_AAQVER
 S X=AAQX12,DIC="^DIZ(437016,",DIC(0)="XM" D ^DIC I +Y>0 S AAQPV=+Y
 I '$D(^DIZ(437016,"B",AAQX12)) D
 .S X=AAQX12,DIC="^DIZ(437016," S DIC(0)="ML" D FILE^DICN
 .S AAQPV=+Y
 I $D(^DIZ(437016,AAQPV,1,"B",AAQX3)) S DA=0,DA=$O(^DIZ(437016,AAQPV,1,"B",AAQX3,DA)) Q:DA=""  S AAQPNO=DA,DA(1)=AAQPV,DIC="^DIZ(437016,"_DA(1)_",1," G UPDT
 I '$D(^DIZ(437016,AAQPV,1,"B",AAQX3)) D
 .S:'$D(^DIZ(437016,AAQPV,1,0)) DIC("P")=$P(^DD(437016,1,0),"^",2)
 .S DA(1)=AAQPV,DIC="^DIZ(437016,"_DA(1)_",1,",X=AAQX3,DIC(0)="XL",DLAYGO=437016
 .D ^DIC I Y=-1 Q  ;No updating if msg for PKG install or no PKG*VER
 .S AAQPNO=+Y
UPDT S %DT="FRS",X=STOP D ^%DT S AAQDT=Y
 I AAQBY'="" S INSTBY=AAQBY
 I '$D(^VA(200,"B",INSTBY)) S AAQIRM="UNK" G CHKUCI
 S AAQDUZ=0,AAQDUZ=$O(^VA(200,"B",INSTBY,AAQDUZ)),AAQIRM=$P(^VA(200,AAQDUZ,0),U,2)
CHKUCI I '$D(^DIZ(437016,AAQPV,1,AAQPNO,2,0)) S ^(0)="^437016.13S^^" S (AAQUNO,AAQT,AAQV)=0 G SETU
 S AAQX=^DIZ(437016,AAQPV,1,AAQPNO,2,0) I ($P(AAQX,U,4)=0)!($P(AAQX,U,4)="") S (AAQUNO,AAQT,AAQV)=0 G SETU
 S (AAQT,AAQV,AAQX)=0 F  S AAQX=$O(^DIZ(437016,AAQPV,1,AAQPNO,2,AAQX)) Q:AAQX=""  D
 .S AAQSYS=^DIZ(437016,AAQPV,1,AAQPNO,2,AAQX,0)
 .I $E(AAQSYS,1,1)="T" S AAQT=AAQT+1
 .I $E(AAQSYS,1,1)="V" S AAQV=AAQV+1
 I AAQT>0 D ERR("TST ALREADY ON FILE") Q
SETU K DD,D0 S AAQSYS="T",DIC="^DIZ(437016,"_AAQPV_",1,"_AAQPNO_",2,",DIC(0)="XLM",X=AAQSYS,DA(1)=AAQPNO,DA(2)=AAQPV D FILE^DICN S AAQUNO=+Y K DIC
 S DIE="^DIZ(437016,"_AAQPV_",1,"_AAQPNO_",2,",DA(2)=AAQPV,DA(1)=AAQPNO,DA=AAQUNO,DR="1///^S X=AAQDT;2///^S X=AAQIRM" D ^DIE
 G:AAQX2="DBA" LOCK
 S AAQPM="PM",DIE="^DIZ(437016,"_AAQPV_",1,",DA(1)=AAQPV,DA=AAQPNO,DR="1.5////^S X=AAQPM" D ^DIE
LOCK L -^DIZ(437016,AAQPV,1,AAQPNO,0)
 L +^DIZ(437016,1,AAQPNO,0):20 ELSE  S MSG="Unable to post data for Patch"_INSTNAME_" due to record lock." D ERR("RECORD LOCK") Q
 Q
CHKLOC Q:AAQX1'["Z"
 S AAQX1=$P(AAQX1,"Z",1),AAQLOC=1
 Q
