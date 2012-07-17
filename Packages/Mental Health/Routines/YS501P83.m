YS501P83 ;BP/TMD,Pre-init Routine for YS*5.01*83 ; 2/5/04 9:06am
 ;;5.01;MENTAL HEALTH;**83**;Dec 30, 1994
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
POST ;Main entry point for Post-init items.
 ;
 N YTTNAME,YTTIEN
 D 20,21
 Q
 ;
20 S YTTNAME="4 Sociable",YTTIEN=""
 S YTTIEN=$O(^YTT(601,244,"S","C",YTTNAME,YTTIEN))
 I +$G(YTTIEN) I $D(^YTT(601,244,"S",YTTIEN,"K",1,0)) D  Q
 .S ^YTT(601,244,"S",YTTIEN,"K",1,0)="4^T;3^17^T;3^87^T;3^100^T;3^163^T;3^52^T;2^114^T;2^73^T;1^162^T;1"
 .D BMES^XPDUTL("**The key for Test Scale '"_YTTNAME_"' was successfully updated.")
 D BMES^XPDUTL("**The key for Test Scale '"_YTTNAME_"' could not be updated.")
 D BMES^XPDUTL("Please contact IRM staff.")
 Q
 ;
21 S YTTNAME="5 Confident",YTTIEN=""
 S YTTIEN=$O(^YTT(601,244,"S","C",YTTNAME,YTTIEN))
 I +$G(YTTIEN) I $D(^YTT(601,244,"S",YTTIEN,"K",1,0)) D  Q
 .S ^YTT(601,244,"S",YTTIEN,"K",1,0)="34^T;3^52^T;3^73^T;3^90^T;3^114^T;3^87^T;2^17^T;1^79^T;1^121^T;1^129^T;1^138^T;1^163^T;1"
 .D BMES^XPDUTL("**The key for Test Scale '"_YTTNAME_"' was successfully updated.")
 D BMES^XPDUTL("**The key for Test Scale '"_YTTNAME_"' could not be updated.")
 D BMES^XPDUTL("Please contact IRM staff.")
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
