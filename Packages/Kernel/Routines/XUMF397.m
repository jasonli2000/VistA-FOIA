XUMF397 ;aaa - CAPRI INSTITUTION STUFF 397; 02/08/02
 ;;2.7;AMIE;**41**;APRIL 10, 1995
 ;
 ; This routine stuffs the BOARD OF VETERANS APPEALS/VBA SUPPORT OFFICE
 ; entry into the INSTITUTTION and FACILITY TYPE files.
 ;
MAIN ; -- entry point
 ;
 N XUMF,IENS,IEN,FDA
 ;
 S XUMF=1
 ;
 S IEN=$O(^DIC(4.1,"B","BVA/VBA-SO",0))
 S IENS=$S(IEN:IEN_",",1:"+1,")
 ;
 K FDA
 S FDA(4.1,IENS,.01)="BVA/VBA-SO"
 S FDA(4.1,IENS,1)="BOARD OF VETERANS APPEALS/VBA SUPPORT OFFICE"
 S FDA(4.1,IENS,3)="NATIONAL"
 D UPDATE^DIE("E","FDA")
 ;
 S IEN=$O(^DIC(4,"D","397",0))
 S IENS=$S(IEN:IEN_",",1:"+1,")
 ;
 K FDA
 S FDA(4,IENS,.01)="BVA/VBA SUPPORT OFFICE"
 S FDA(4,IENS,.02)="DISTRICT OF COLUMBIA"
 S FDA(4,IENS,11)="NATIONAL"
 S FDA(4,IENS,13)="BVA/VBA-SO"
 S FDA(4,IENS,99)=397
 S FDA(4,IENS,100)="BOARD OF VETERANS APPEALS/VBA SUPPORT OFFICE"
 D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
