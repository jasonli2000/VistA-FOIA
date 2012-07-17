DSIRENV ;AMC/EWL - Document Storage Systems Inc - ROI Environment Check Routine ;05/21/2010 15:14
 ;;7.2;RELEASE OF INFORMATION - DSSI;**1**;May 21, 2010;Build 8
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;10141 $$VERSION^XPDUTL
 ;10141 MES^XPDUTL
 ;
 ;Version checks
 N VER S VER=+$$VERSION^XPDUTL("DSIR")
 I (VER<7.2)&(VER'=0) S XPDQUIT=1 D MES^XPDUTL("You must have installed ROI version 7.2 first!!!")
 Q
