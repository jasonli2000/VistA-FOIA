KMPRPOST ;SF/RAK - RUM Post Install Routine ;1/20/00  07:36
 ;;1.0;CAPACITY MANAGEMENT - RUM;**1**;Dec 09, 1998
 ;;
 ;
 ; This post install routine is for RUM patch KMPR*1.0*1
 ;
EN ;-- entry point.
 ;
 N FDA,IEN,MESSAGE
 ; let background job know system ready to track hours.
 S ^XTMP("KMPR","HOURS","START")=1
 ; get ien for backgroung job.
 S IEN=$O(^DIC(19,"B","KMPR BACKGROUND DRIVER",0)) Q:'IEN
 ; get ien for background driver from 'option scheduling' file.
 S IEN=$O(^DIC(19.2,"B",+IEN,0)) Q:'IEN
 ; if data in 'special queueing'.
 I $P($G(^DIC(19.2,+IEN,0)),U,9)]"" D 
 .; remove special queueing.
 .S FDA($J,19.2,IEN_",",9)="@"
 .D FILE^DIE("","FDA($J)","MESSAGE")
 ;
 Q
