PXRMP21I ; SLC/JVS - Patch 21 inits. ;11/20/03  21:06
 ;;1.5;CLINICAL REMINDERS;**21**;Jun 19, 2000
 ;
 Q
 ;
 ;===============================================================
DELEI ;If the Exchange File entry already exists delete it.
 ;
 N IND,LIST,PXRMVAL,NUM
 ;
 S PXRMVAL(1)="VA-IRAQ &AFGHAN POST-DEPLOY SCREEN"
 D FIND^DIC(811.8,"","","U",.PXRMVAL,"","","","","LIST")
 S NUM=$P(LIST("DILIST",0),U,1)
 I NUM'=0 D
 .F IND=1:1:NUM D
 .. N DA,DIK
 .. S DIK="^PXD(811.8,"
 .. S DA=LIST("DILIST",2,IND)
 .. D ^DIK
 ;
 Q
 ;
 ;===============================================================
PRE ;Pre-inits
 D DELEI
 Q
 ;
 ;===============================================================
POST ;Post-inits
 D SMEXINS
 Q
 ;
 ;===============================================================
SMEXINS ;Silent mode install.
 N IEN,PXRMVAL
 ;
 S PXRMVAL(1)="VA-IRAQ &AFGHAN POST-DEPLOY SCREEN"
 S PXRMVAL(2)="12/23/2003@22:52:03"
 S IEN=+$$FIND1^DIC(811.8,"","KU",.PXRMVAL)
 I IEN'=0 D
 . N TEXT
 . S TEXT="Installing reminder "_PXRMVAL(1)
 . D BMES^XPDUTL(TEXT)
 . D POSTKIDS^PXRMEXU5(IEN)
 . D INSTALL^PXRMEXSI(IEN)
 ;
 Q
