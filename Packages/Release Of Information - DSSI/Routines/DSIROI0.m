DSIROI0 ;DSS/BLJ/EWL - Release Of Information ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2050  MSG^DIALOG
 ;2053  UPDATE^DIE
 ;2053  FILE^DIE
 ;
 Q  ; only call via line tags.
 ;
ERR(WIDTH,LEFT) ;  process error message expected in ERR, return -1^error msg
 N X,Z,TMP S WIDTH=$G(WIDTH,72),LEFT=$G(LEFT,0)
 D MSG^DIALOG("AE",.TMP,WIDTH,LEFT,"ERR") S Z="-1^"
 F X=0:0 S X=$O(TMP(X)) Q:'X  S Z=Z_TMP(X)_" "
 Q Z
 ;
NEWITEM(RETN,VEJDDATA) ; Create a new released document RPC - DSIR ADD DOCUMENT
 ; Input: Array of
 ;        (1): Pointer to VEJD ROI INSTANCE (19620) file
 ;        (2): Internal Set of Codes value for document type
 ;        (3): Document IEN (If applicable)
 ;        (4): Internal Set of Codes value for document media
 ;        (5): Caption
 ;        (6): Document length
 ;        (7): Date/time of document
 ;        (8): Creator of Document: Needs to be a pointer to the NEW PERSON file
 ;        (9): Include in Billing (0 - No, 1 - Yes)
 ;
 N DIERR,ERR,ROOT,VEJD
 S ROOT(19620.1,"+1,",.01)=$G(VEJDDATA(1))
 S ROOT(19620.1,"+1,",.02)=$G(VEJDDATA(2))
 S ROOT(19620.1,"+1,",.03)=$G(VEJDDATA(3))
 S ROOT(19620.1,"+1,",.04)=$G(VEJDDATA(4))
 S ROOT(19620.1,"+1,",.05)=$G(VEJDDATA(5))
 S ROOT(19620.1,"+1,",.06)=$G(VEJDDATA(6))
 S ROOT(19620.1,"+1,",.07)=$G(VEJDDATA(7))
 S ROOT(19620.1,"+1,",.08)=$G(VEJDDATA(8))
 S ROOT(19620.1,"+1,",.09)=$G(DUZ)
 S ROOT(19620.1,"+1,",2.01)=$G(VEJDDATA(9))
 D UPDATE^DIE("","ROOT","VEJD","ERR")
 I '$D(DIERR) S RETN(1)="1^"_VEJD(1)
 E  S RETN(1)=$$ERR
 Q
ADDNCPR(AXY,NAME,SSN,DOB,OVRD,NCPIEN) ;RPC - DSIR ADD NONCOMP PAT
 ; Modified to allow updates January 2007 EWL
 ;
 ;Input Parameters:
 ;       NAME   - Patient Name (Required)
 ;       SSN    - Patient Social Security Number or Identifier (last 4 _ FM Birth Date) (Optional)
 ;       DOB        - Date of Birth (Optional)
 ;       OVRD   - Override Lookup (Optional) If 1 the RPC will laygo new entry into 19620.96 without checking xrefs
 ;       NCPIEN - If this exists then it is an update not an add.  ADDED 11/30/2006 EWL
 ;
 ;Return values may be one of the following:
 ;
 ;       -1^Unable to add patient record. Missing data.
 ;       Either name or ssn is missing.
 ;       
 ;       -2^Social Security Number 123456789 on file for NAME,PATIENT!
 ;       SSN exists in patient file #2.
 ;
 ;       0^NNNN;DSIR(19620.96,^NAME,PATIENT^FileMan Birth Date
 ;       This is returned if the SSN exists in file 19620.96, the calling 
 ;       program must determine if this is the same name entered.
 ;
 ;       1^NNNN;DSIR(19620.96,^NAME,PATIENT
 ;       This is returned upon completion of a new entry being created or updated.
 ;
 ;       -3^Unable to create record! or -3^Unable to update record! 
 ;       Unknown reason why entry in file 19620.96 was unsuccessful.
 ;
 ;       -4^Unable to update, record not on file!
 ;       This is returned if an IEN is passed that does not exist.
 ;
 ;       -5^Unable to update, SSN 123456789 already on non-registered file!
 ;       This is returned if a SSN is passed that already exists on 19620.96.
 ;  
 S AXY="" I $G(NAME)="" S AXY(0)="-1^Unable to add/update patient record. Missing data." Q
 N X,Y,FIL,DSIRA,DSIR,ERR,IEN,NEW,YY
 S OVRD=+$G(OVRD),FIL=19620.96,NEW="+1,"
 S DOB=$G(DOB),YY=0
 S SSN=$G(SSN) S:SSN="" SSN=0 ; IF NO SSN SET IT TO 0 (ZERO)
 I 'OVRD,$D(^DPT("SSN",SSN)) N DFN D
 .S DFN=+$O(^DPT("SSN",SSN,0)),AXY(0)="-2^Social Security Number "_SSN_" on file for "_$P($G(^DPT(DFN,0)),U)_"!" Q
 S IEN=$G(NCPIEN)
 K ^TMP("DSIROI0",$J)
 I IEN'="" D
 .S DSIR(1)=IEN
 .I '$D(^DSIR(FIL,IEN,0)) S AXY="-4^Unable to update, record not on file!" Q
 .N TDATA,UPDTFLAG S TDATA=$G(^DSIR(FIL,IEN,0)),UPDTFLAG=0
 .I $P(TDATA,U,1)'=NAME S FDA(FIL,IEN_",",.01)=NAME,UPDTFLAG=1
 .I $P(TDATA,U,2)'=DOB S FDA(FIL,IEN_",",.02)=DOB,UPDTFLAG=1
 .I $P(TDATA,U,9)'=SSN D
 ..I $D(^DSIR(19620.96,"SSN",SSN)) S AXY="-5^Unable to update, SSN "_SSN_" already on non-registered file!",UPDTFLAG=0 Q
 ..S FDA(FIL,IEN_",",.09)=SSN,UPDTFLAG=1
 .I UPDTFLAG D FILE^DIE("","FDA","ERR")
 .I $D(DIERR) S AXY="-3^Unable to update record!"
 D:IEN=""
 .I 'OVRD,$D(^DSIR(19620.96,"SSN",SSN)) N IEN S IEN=0 D
 ..F  S IEN=+$O(^DSIR(19620.96,"SSN",SSN,IEN)) Q:'IEN  S YY=YY+1 D
 ...S AXY(YY)=0_U_IEN_";DSIR(19620.96,"_U_$P($G(^DSIR(19620.96,IEN,0)),U)_U
 ...S AXY(YY)=AXY(YY)_$P($G(^DSIR(19620.96,IEN,0)),U,2),^TMP("DSIROI0",$J,IEN)=""
 .I 'OVRD D:$O(^DSIR(19620.96,"B",NAME))[NAME!$D(^DSIR(19620.96,"B",NAME))
 ..N IEN,AA,BB S (AA,BB)=$NA(^DSIR(19620.96,"B",NAME)),BB=$P(BB,""")") F YY=0:1 S AA=$Q(@AA) Q:AA=""!(AA'[BB)  D
 ...S IEN=+$QS(AA,4) Q:'IEN  I '$D(^TMP("DSIROI0",$J,IEN)) D
 ....S AXY(YY)=0_U_IEN_";DSIR(19620.96,"_U_$P($G(^DSIR(19620.96,IEN,0)),U)_U_$P($G(^DSIR(19620.96,IEN,0)),U,2)
 .I $O(AXY(""))]"" K ^TMP("DSIROI0",$J) Q
 .S DSIRA(FIL,NEW,.01)=NAME,DSIRA(FIL,NEW,.09)=SSN,DSIRA(FIL,NEW,.02)=DOB
 .D UPDATE^DIE("","DSIRA","DSIR","ERR")
 .I $D(DIERR) S AXY="-3^Unable to create record!" Q
 I AXY="" S AXY(0)=1_U_DSIR(1)_";DSIR(19620.96,"_U_NAME
 I AXY]"" S AXY(0)=AXY
 Q
