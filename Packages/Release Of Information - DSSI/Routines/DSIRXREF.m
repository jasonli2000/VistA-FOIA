DSIRXREF ;AMC/EWL - Document Storage Systems Inc; ROI Mumps Xref code ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;
 ; These routines are called by FILEMAN Data Dictionary for maintaining the
 ; cross references for FOIA.
 Q
SETAFOIA(ROI) ;Set logic for AFOIA xref on file 19620 field 10.06
 Q:'$G(ROI)
 N CLDT S CLDT=+$P($G(^DSIR(19620,ROI,10)),"^",7)
 I 'CLDT S ^DSIR(19620,"AFOIA",ROI)=""
 Q
KILAFOIA(ROI) ;Kill logic for AFOIA xref on file 19620 field 10.06
 Q:'$G(ROI)
 K ^DSIR(19620,"AFOIA",ROI)
 Q
SETAFCLD(ROI,FCDT) ;Set logic for AFCLD xref on file 19620 field 10.07
 Q:'$G(ROI)
 Q:'$G(FCDT)
 S ^DSIR(19620,"AFCLD",FCDT,ROI)="" K ^DSIR(19620,"AFOIA",ROI) Q
 Q
KILAFCLD(ROI,FCDT) ;Kill logic for AFCLD xref on file 19620 field 10.07
 Q:'$G(ROI)
 Q:'$G(FCDT)
 K ^DSIR(19620,"AFCLD",FCDT,ROI) S ^DSIR(19620,"AFOIA",ROI)=""
 Q
