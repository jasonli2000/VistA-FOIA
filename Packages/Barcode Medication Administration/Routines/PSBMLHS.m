PSBMLHS ;BIRMINGHAM/EFC-BCMA OIT HISTORY ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**3**;Mar 2004
 ;
 ;
 ;
HISTORY(RESULTS,DFN,PSBOI) ; Returns Orderable Item History
 ;
 ; RPC: PSB MEDICATION HISTORY
 ;
 ; PSBOPM IS NOW THE STANDARD FOR MEDICATION HISTORY.
 ; THIS RPC IS ACTING AS A WRAPPER FOR THE NEW REPORT
 ; TO MAINTIAN BACKWARDS COMPATABILITY
 ;
 D RPC^PSBO(.RESULTS,"PM",DFN,"","","","","","","","","",PSBOI)
 Q
 ;
