XQAL285P ;OAKLAND-OIFO.SEA/JLI - POST-INIT FOR PATCH XU*8*285 ;7/28/03  15:37
 ;;8.0;KERNEL;**285**;Jul 10, 1995
ENTRY ;
 ; Check and remove any TEAM or TEAM (OERR) entities added for the XQAL BACKUP REVIEWER parameter
 N XQAPARAM,XQAENT,XQAINST,XQALIST,XQAIEN,XQAFILE,XQAFNUM,XQALFDA,XQAX
 S XQAPARAM=$$FIND1^DIC(8989.51,"","","XQAL BACKUP REVIEWER")
 S XQAENT="" F  S XQAENT=$O(^XTV(8989.5,"AC",XQAPARAM,XQAENT)) Q:XQAENT=""  F XQAINST=0:0 S XQAINST=$O(^XTV(8989.5,"AC",XQAPARAM,XQAENT,XQAINST)) Q:XQAINST'>0  S XQALIST($O(^(XQAINST,"")))=""
 F XQAIEN=0:0 S XQAIEN=$O(XQALIST(XQAIEN)) Q:XQAIEN'>0  S XQAX=$P($G(^XTV(8989.5,XQAIEN,0)),U),XQAFILE=$P(XQAX,";",2),XQAFNUM=+$P(@(U_XQAFILE_"0)"),U,2) I XQAFNUM>0 D
 . I $S(XQAFNUM=4:1,XQAFNUM=4.2:1,XQAFNUM=49:1,XQAFNUM=200:1,1:0) Q
 . S XQALFDA=$NA(^TMP($J,"XQALDEL")) K @XQALFDA
 . S @XQALFDA@(8989.5,XQAIEN_",",.01)="@"
 . D UPDATE^DIE("",XQALFDA)
 . K @XQALFDA
 . Q
 ;
 ; Setup and start population of the XQAL UNPROCESSED ALERTS mail group
 I DUZ<1 W !,"INVALID DUZ, COULD NOT ADD TO 'XQAL UNPROCESSED ALERTS' MAIL GROUP" Q
 N XQALIEN,XQALFDA
 S XQALIEN=$$FIND1^DIC(3.8,"","","XQAL UNPROCESSED ALERTS")
 I XQALIEN'>0 W !,"COULD NOT FIND 'XQAL UNPROCESSED ALERTS' MAIL GROUP" Q
 I $$FIND1^DIC(3.81,","_XQALIEN_",","",DUZ)'>0 D  ; Need to enter
 . S XQALFDA=$NA(^TMP($J,"XQALP285")) K @XQALFDA
 . S @XQALFDA@(3.81,"+1,"_XQALIEN_",",.01)=DUZ
 . D UPDATE^DIE("",XQALFDA)
 . K @XQALFDA
 . Q
 Q
