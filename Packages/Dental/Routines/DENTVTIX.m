DENTVTIX ;DSS/SGM - TEMORARY DENTAL RPC TO TIU ;01/03/2005 15:00
 ;;1.2;DENTAL;**42**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  Supported Description
 ; -----  ---------------------------------------
 ;        ADDNOTE^TIUSRVT
 ;
 ;Need to ask for an IA to call this line tag or replace
 ;it in the DRM Plus GUI with the call to the TIU RPC
 ;once it is available.  We will need an IA to call the
 ;TIU RPC in that case.
 ;
GETTMPLT(TIUY,TIUDA) ; rpc: DENTV TIU GET TEMPL DATA
 ; TIUDA - req - IFN to file 8927
 N IDX S IDX=0
 I $G(TIUDA)<1 S TIUY(1)="-1^No TIU TEMPLATE file IFN received" Q
 D ADDNODE^TIUSRVT(.IDX,TIUDA,1)
 I 'IDX S TIUY(1)="-1^No TIU TEMPLATE data found"
 Q
