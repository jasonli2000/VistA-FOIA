PPPPRT4 ;ALB/DMB - FFX PRINT ROUTINES ; 3/13/92
 ;;V1.0;PHARMACY PRESCRIPTION PRACTICE;;APR 7,1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SRTBYNM(OUTARRY) ; Sort the FFX file by name
 ;
 ; This function will order through the APOV xref of the FFX file
 ; and return an array containing the patient info and place of visit
 ; info.
 ;
 ; The output array is in the form:
 ;
 ;   @OUTARRY@(PATIENT_NAME)=DOB^SSN
 ;   @OUTARRY@(PATIENT_NAME,STATION_NAME)=NUMBER^DOMAIN^LDOV
 ;
 N DIC,DA,PATDFN,DR,DIQ,PATNAME,PATDOB,PATSSN,PPPTMP,STANAME,STANUM
 N STADOM,LDOV,TPATS,TSTATION,SNIFN,FFXIFN
 ;
 K @OUTARRY
 ;
 S TPATS=0
 S TSTATION=0
 ;
 ; Order through the APOV xref and get the data for each dfn
 ;
 F PATDFN=0:0 D  Q:PATDFN=""
 .S PATDFN=$O(^PPP(1020.2,"APOV",PATDFN)) Q:PATDFN=""
 .S DIC=2,DA=PATDFN,DR=".01;.03;.09",DIQ="PPPTMP"
 .D EN^DIQ1 Q:'$D(PPPTMP)
 .S PATNAME=PPPTMP(2,PATDFN,.01)
 .S PATDOB=PPPTMP(2,PATDFN,.03)
 .S PATSSN=PPPTMP(2,PATDFN,.09)
 .S @OUTARRY@(PATNAME)=PATDOB_"^"_PATSSN
 .S TPATS=TPATS+1
 .K PPPTMP
 .F SNIFN=0:0 D  Q:SNIFN=""
 ..S SNIFN=$O(^PPP(1020.2,"APOV",PATDFN,SNIFN)) Q:SNIFN=""
 ..S FFXIFN=$O(^PPP(1020.2,"APOV",PATDFN,SNIFN,"")) Q:FFXIFN=""
 ..S DIC=4,DA=SNIFN,DR=".01;99",DIQ="PPPTMP"
 ..D EN^DIQ1 Q:'$D(PPPTMP)
 ..S STANAME=PPPTMP(4,SNIFN,.01)
 ..S STANUM=PPPTMP(4,SNIFN,99)
 ..K PPPTMP
 ..S LDOV=$$I2EDT^PPPCNV1($P($G(^PPP(1020.2,FFXIFN,0)),"^",3))
 ..S STADOM=$P($G(^PPP(1020.2,FFXIFN,1)),"^",5)
 ..S @OUTARRY@(PATNAME,STANAME)=STANUM_"^"_STADOM_"^"_LDOV
 ..S TSTATION=TSTATION+1
 Q TPATS_"^"_TSTATION
 ;
SRTBYSTA(OUTARRY) ; Sort the FFX file by STATION
 ;
 ; This function will order through the ARPOV xref of the FFX file
 ; and return an array containing the patient info and place of visit
 ; info.
 ;
 ; The output array is in the form:
 ;
 ;   @OUTARRY@(STATION_NAME)=NUMBER^DOMAIN
 ;   @OUTARRY@(STATION_NAME_PATIENT_NAME)=DOB^SSN^LDOV
 ;
 N DIC,DA,PATDFN,DR,DIQ,PATNAME,PATDOB,PATSSN,PPPTMP,STANAME,STANUM
 N STADOM,LDOV,TPATS,TSTATION,SNIFN,FFXIFN
 ;
 K @OUTARRY
 ;
 S TPATS=0
 S TSTATION=0
 ;
 ; Order through the ARPOV xref and get the data for each dfn
 ;
 F SNIFN=0:0 D  Q:SNIFN=""
 .S SNIFN=$O(^PPP(1020.2,"ARPOV",SNIFN)) Q:SNIFN=""
 .S DIC=4,DA=SNIFN,DR=".01;99",DIQ="PPPTMP"
 .D EN^DIQ1 Q:'$D(PPPTMP)
 .S STANAME=PPPTMP(4,SNIFN,.01)
 .S STANUM=PPPTMP(4,SNIFN,99)
 .K PPPTMP
 .S TSTATION=TSTATION+1
 .F PATDFN=0:0 D  Q:PATDFN=""
 ..S PATDFN=$O(^PPP(1020.2,"ARPOV",SNIFN,PATDFN)) Q:PATDFN=""
 ..S DIC=2,DA=PATDFN,DR=".01;.03;.09",DIQ="PPPTMP"
 ..D EN^DIQ1 Q:'$D(PPPTMP)
 ..S PATNAME=PPPTMP(2,PATDFN,.01)
 ..S PATDOB=PPPTMP(2,PATDFN,.03)
 ..S PATSSN=PPPTMP(2,PATDFN,.09)
 ..S FFXIFN=$O(^PPP(1020.2,"ARPOV",SNIFN,PATDFN,"")) Q:FFXIFN=""
 ..S LDOV=$$I2EDT^PPPCNV1($P($G(^PPP(1020.2,FFXIFN,0)),"^",3))
 ..S STADOM=$P($G(^PPP(1020.2,FFXIFN,1)),"^",5)
 ..S @OUTARRY@(STANAME)=STANUM_"^"_STADOM
 ..S @OUTARRY@(STANAME,PATNAME)=PATDOB_"^"_PATSSN_"^"_LDOV
 ..S TPATS=TPATS+1
 ..K PPPTMP
 Q TSTATION_"^"_TPATS
 ;
NAMESRT(INARRY,OUTARRY) ; Sort the clinic list by name and get SSN & DOB.
 ;
 N DIC,DA,PATDFN,DR,DIQ,NAME,DOB,SSN,PPPTMP
 ;
 ; Make sure the output array is empty
 ;
 K @OUTARRY,PPPTMP
 ;
 S TENTRY=0
 ;
 ; Order through the in array and get the data for each DFN.
 ;
 F PATDFN=0:0 D  Q:PATDFN=""
 .S PATDFN=$O(@INARRY@(PATDFN)) Q:PATDFN=""
 .S DIC=2,DA=PATDFN,DR=".01;.03;.09",DIQ="PPPTMP"
 .D EN^DIQ1 Q:'$D(PPPTMP)
 .S NAME=PPPTMP(2,PATDFN,.01)
 .S DOB=PPPTMP(2,PATDFN,.03)
 .S SSN=PPPTMP(2,PATDFN,.09)
 .S @OUTARRY@(NAME,PATDFN)=DOB_"^"_SSN
 .S TENTRY=TENTRY+1
 .K PPPTMP
 Q TENTRY
