DSIROI2 ;DSS/BLJ/EWL - Release Of Information ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10103 $$NOW^XLFDT
 ;10103 $$FMADD^XLFDT
 ;2053  FILE^DIE
 ;10046 $$EN^XUWORKDY
 Q
GETITEMS(RETN,IFN) ; Get a list of all documents for a request RPC - DSIR GET DOCUMENTS
 ; Input: IFN of request
 ;
 ; Return: Array of
 ;     IFN^
 ;
 S RETN=$NA(^TMP("DSIROI",$J))
 K @RETN
 N I M ^TMP("DSIROI",$J)=^DSIR(19620.1,"B",IFN)
 F I=0:0 S I=$O(^TMP("DSIROI",$J,I)) Q:'I  S ^TMP("DSIROI",$J,I)=I_U
 Q
 ;
CLEANUP(VEJDRETN) ; Does cleanup of all TMP globals used. RPC - DSIR CLEANUP
 K ^TMP("DSIROI",$J)
 K ^TMP("DSIRVAL",$J)
 S VEJDRETN=""
 Q
 ;       
FOLLOWUP(RETN,IEN) ; Set date of followup letter to today.  RPC - DSIR SET FOLLOWUP DATE
 ; input: IEN of entry to set date on
 ;
 ; Return: "1^" if successful
 ;         "-1^Error Message" if unsuccessful
 ;
 N X,DIERR,ERR,DSIR
 S DSIR(19620,IEN,.26)=$$NOW^XLFDT\1
 D FILE^DIE("K","DSIR","ERR")
 I '$D(DIERR) S RETN(1)="1^"
 E  S RETN(1)=$$ERR^DSIROI0
 Q
 ;
GETFOLLW(RETN) ; Get list of requests that require a followup  RPC - DSIR FOLLOWUP REQUIRED LIST
 ; letter
 ;
 ; No Input
 ; 
 ; Output: Array of
 ;    IEN^
 ;
 N X,DATE,ST,WRKD S X=0
 F ST="O","P" F  S X=$O(^DSIR(19620,"ACST",ST,X)) Q:'X  D
 .Q:$P($G(^DSIR(19620,X,2)),U,6)'=""
 .S DATE=$P($G(^DSIR(19620,X,10)),U,6)
 .S WRKD=$$EN^XUWORKDY(DATE,$$NOW^XLFDT)
 .Q:WRKD<10
 .; Filter out FOIA from Privacy Act
 .Q:$P($G(^DSIR(19620,X,0)),U)[19620.95
 .; 6 Feb 2001: Below added to filter out all requests from different divisions. 
 .Q:$P($G(^DSIR(19620,X,6)),U,3)'=$G(DUZ(2))
 .S RETN(X)=X
 .Q
 Q
 ;
GETPREVY(RETN,DFN,REQ,DATE) ; Get #requests for a given patient since a given date.  RPC - DSIR REQUESTS SINCE DATE
 ;
 ; Input: DFN: Patient IFN
 ;        REQ: Requestor IFN
 ;       DATE: Earliest date to look from
 ;
 ; Return: Number of requests
 ;
 N X,RQDT S (X,RETN)=0
 I '$G(DFN) S RETN="-1^Must specify patient!" Q
 I '$G(DATE) S RETN="-1^Must specify date!" Q
 F  S X=$O(^DSIR(19620,"B",DFN,X)) Q:'X  D
 .S RQDT=$P($G(^DSIR(19620,X,10)),U,6) Q:RQDT<DATE
 .I REQ,REQ'=+$G(^DSIR(19620,X,1)) Q
 .S RETN=RETN+1
 Q
 ;
GETVER(RETN,RTN) ; Returns the current version of the ROI KIDS file  RPC - DSIR GET ROUTINE VERSION
 ;
 ;  INPUT : RTN: Routine to test.
 ; RETURN : VERSION^PATCH
 ;
 N PATCH,VERSION
 S VERSION=$T(+2^@RTN)
 S PATCH=$P($P(VERSION,";",5),"**",2)
 S VERSION=$P(VERSION,";",3)
 S RETN=VERSION_"^"_PATCH
 Q
