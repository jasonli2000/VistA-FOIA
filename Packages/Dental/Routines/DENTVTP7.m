DENTVTP7 ;DSS/KC - RPCS FOR RESERVED TXNS ;05/11/2004 13:35
 ;;1.2;DENTAL;**39,47,50,57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains all the RPCs needed for reserved txns
 ;  DBIA#  Supported  Description
 ;  -----  ---------  ----------------
 ;   2053      x      ^DIE: UPDATE, WP
 ;  10103      x      $$NOW^XLFDT
 ;  10104      x      $$UP^XLFSTR
 ;  10013      x      ^DIK
 ;
SAVE(DENT,DATA) ;  RPC: DENTV TP FILE RESERVED TXNS
 ;this rpc will allow the addition, update, or deletion of reserved txns
 ;  DATA - required
 ;  DATA(1) = FLG ^ PROV ^ DFN
 ;            if $G(FLG)="",$G(IEN)<1 then default to ADD
 ;            FLG - optional - A add/update new record (DEFAULT)
 ;                             D delete reserved txns
 ;           PROV - required - pointer to the New Person file (#200)
 ;            DFN - required - pointer to the patient file (#2)
 ;            
 ;  DATA(n) = reserved txn data   where n =2,3,4,5,6,...
 ;  Return(n) = 1^message if action successful, else return -1^message
 N X,Y,Z,DEN,DENER,DENIEN,DENX,DFN,DI,FLG,DENTI,PROV,DIERR
 S DENTI=$O(DATA("")) I 'DENTI D MSG(1) Q
 S Z="FLG^PROV^DFN"
 F Y=1:1:3 S @$P(Z,U,Y)=$P(DATA(DENTI),U,Y)
 S FLG=$E(FLG) S:FLG?1L FLG=$$UP^XLFSTR(X) I FLG="" S FLG="A"
 I "AD"'[FLG D MSG(2) Q
 S X=$$DPRV^DENTVUTL(PROV) I 'X D MSG(3) Q
 S X=$$DFN^DENTVRF0(DFN,1) I +X=-1 S DENT=X Q
 S DENIEN=$O(^DENT(228.7,"AC",PROV,DFN,0))
 I DENIEN,FLG="A" S FLG="U"
 I FLG="D",'DENIEN D MSG(8) Q
 I FLG="D" D  Q  ;delete record
 .N DA,DD,DO,DIK S DA=DENIEN,DIK="^DENT(228.7," D ^DIK
 .S DENT="1^Reserved transactions deleted"
 .Q
 I $O(DATA(DENTI))="" D MSG(4) Q
 ; set the WP nodes for filing
 N PERIO ; only save 1 perio set of data! P50 (bug in Discus component)
 K DEN S Y=0,PERIO=0 F  S DENTI=$O(DATA(DENTI)) Q:'DENTI  D
 .I PERIO,$E(DATA(DENTI),1,6)="$$PE$$" S PERIO=2 ;another set
 .I PERIO=2,$E(DATA(DENTI),1,4)="$$PE" Q  ;don't save
 .I $E(DATA(DENTI),1,6)="$$PE$$" S PERIO=1 ;first pass, keep these
 .S Y=Y+1,DEN(Y)=DATA(DENTI)
 .Q
 I FLG="A" D  Q  ;add record
 .K DENIEN,DENX S DENX(228.7,"+1,",.01)=DFN
 .S DENX(228.7,"+1,",.02)=PROV
 .S DENX(228.7,"+1,",.03)=DFN
 .S DENX(228.7,"+1,",.04)=$$NOW^XLFDT
 .S DENX(228.7,"+1,",1)="DEN"
 .S DENIEN(1)=""
 .D UPDATE^DIE(,"DENX","DENIEN","DENER")
 .I '$D(DIERR) S DENT="1^Reserved transactions saved"
 .E  D  Q
 ..S X=$$MSG^DSICFM01("VE",,,,"DENER")
 ..I $G(DENIEN(1))<1 S DENT="-1^"_X
 ..E  S DENT="1^"_X
 ..Q
 .Q
 ;update (wp info only)
 L +^DENT(228.7,DENIEN):2 E  D MSG(9) Q
 D WP^DIE(228.7,DENIEN_",",1,,"DEN","DENER")
 I '$D(DIERR) S DENT="1^Reserved transactions updated"
 E  S DENT="-1^"_$$MSG^DSICFM01("VE","","","","DENER")
 Q
 ;
GET(DENT,PROV,DFN) ;  RPC: DENTV TP GET RESERVED TXNS
 ;  this will retreive all reserved txns for a provider/patient
 ;  PROV - required - pointer to the New Person file
 ;  DFN - required - pointer to the patient file
 ;  Return: global array ^TMP("DENT",$J,n)=value
 ;    if problems, ^TMP("DENT",$J,1) = -1^message
 ;    format of return of individual records:
 ;    ^TMP("DENT",$J,n) = 1st txn line
 ;                 n+m) = last txn line
 N DENIEN,CNT,DENTAR,I,DENER,ZNODE,ZN
 S DENT=$NA(^TMP("DENT",$J)) K @DENT
 I '$G(PROV) S @DENT@(1)="-1^No provider received" Q
 I '$G(DFN) S @DENT@(1)="-1^No patient received" Q
 S DENIEN=$O(^DENT(228.7,"AC",PROV,DFN,0))
 I 'DENIEN S @DENT@(1)="-1^No transactions found" Q
 K ^TMP("DENTV",$J,"TC") ;P57 for timecounter
 S DENIEN=DENIEN_"," D GETS^DIQ(228.7,DENIEN,1,"E","DENTAR","DENER")
 I '$D(DENTAR) S @DENT@(1)="-1^No transactions found" Q
 S I=0,CNT=0 F  S I=$O(DENTAR(228.7,DENIEN,1,I)) Q:'I  D
 .S ZNODE=DENTAR(228.7,DENIEN,1,I)
 .I $E(ZNODE,1,6)="$$PE$$" S ZN=$G(DENTAR(228.7,DENIEN,1,I+1)) I $E(ZN,1,7)="$$PED$$" D  Q
 ..S CNT=CNT+1,@DENT@(CNT)=ZNODE ;get the first perio node
 ..S CNT=CNT+1,@DENT@(CNT)="$$PEN$$^" ;P47 fix old perio null issue
 ..S ZN="0",ZN=$TR($J(ZN,200)," ","0") ;force 200 char perionullhex value
 ..S CNT=CNT+1,@DENT@(CNT)="$$PEN$$^"_ZN
 ..Q
 .I $E(ZNODE,1,6)="$$TX$$" D VALTC ;P57
 .S CNT=CNT+1,@DENT@(CNT)=ZNODE
 .Q
 I '$D(@DENT) S @DENT@(1)="-1^No records found"
 K ^TMP("DENTV",$J,"TC")
 Q
VALTC ;validate the timecounter going back to the GUI P57
 ;This value must be unique for a txn or ranged txn 'set' for the day
 ;another user may have filed data to the patient, so the TC must be reset
 N X,Y S Y=$P(ZNODE,U,22),X=$$CNVT^DSICDT(,$P(ZNODE,U,21),"E","F",,,1) Q:'X  ;not valid dt?
 I $O(^DENT(228.2,"AE",DFN,+X,+Y,0)) D RESET(X) ;P57
 Q
RESET(CDAT) ;reset the timecounter/slightly different than code in DENTVTPC P57
 ;txns may file in any order - grouped txns need the same timecounter, even if reset
 ;because we don't file here and update the "AE" x-ref for each xref,
 ; we update "LAST" node each time we use a new number
 N LAST
 S LAST=$G(^TMP("DENTV",$J,"TC",+$P(ZNODE,U,22))) I LAST S $P(ZNODE,U,22)=LAST Q
 S LAST=$G(^TMP("DENTV",$J,"TC","LAST")) ;we don't "file", need to update something temporarily
 S:'LAST LAST=$O(^DENT(228.2,"AE",DFN,CDAT,9999),-1) ;get last tc from txn file
 S LAST=LAST+10,^TMP("DENTV",$J,"TC","LAST")=LAST ;add 10 to become "new" last
 ;save in case of grouped txns and update the timecounter field with new tc
 S ^TMP("DENTV",$J,"TC",+$P(ZNODE,U,22))=LAST,$P(ZNODE,U,22)=LAST
 Q
 ;-------------------------  subroutines  -------------------------
MSG(X) ;
 I X=1 S X="No input array received"
 I X=2 S X="Invalid filing flag received: "_FLG
 I X=3 S X="Not a Dental Provider"
 I X=4 S X="No transaction data received"
 I X=8 S X="No record exists to delete"
 I X=9 S X="Unable to lock record #:"_DENIEN_", try again"
 S DENT="-1^"_X
 Q
