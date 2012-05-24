ICD1837C ;;ALB/EG/MJB - FY 2009 UPDATE; 6/19/05 4:08pm ; 11/14/07 5:25pm
 ;;18.0;DRG Grouper;**37**;Oct 13,2000;Build 20
 ;
 Q
 ;
PRO ;-update operation/procedure codes
 ; from Table 6B in Fed Reg - assumes new codes already added by Lexicon
 D BMES^XPDUTL(">>>Modifying new op/pro codes - file 80.1")
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,MDC24,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REV+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .; check if already created in case patch being re-installed
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I $D(^ICD0(ENTRY,2,"B",3081001)) D
 ..;kill existing entry for FY
 .. S DA(1)=ENTRY,DA=$O(^ICD0(ENTRY,2,"B",3081001,0))
 .. S DIK="^ICD0("_DA(1)_",2," D ^DIK K DIK,DA
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S MDC24=$P(ICDPROC,U,3)
 ..S DR="2///^S X=IDENT;5///^S X=MDC24"
 ..;I IDENT=""&(MDC24="") Q
 ..D ^DIE
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REV+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ....S FDA(1820,80.171,"+2,?1,",.01)=3081001
 ....D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S DATA=$E(DATA,2,99)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3081001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3081001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...I $P(DATA,U,6) S FDA(1820,80.17111,"+8,?3,?2,?1,",.01)=$P(DATA,U,6)
 ...I $P(DATA,U,7) S FDA(1820,80.17111,"+9,?3,?2,?1,",.01)=$P(DATA,U,7)
 ...I $P(DATA,U,8) S FDA(1820,80.17111,"+10,?3,?2,?1,",.01)=$P(DATA,U,8)
 ...I $P(DATA,U,9) S FDA(1820,80.17111,"+11,?3,?2,?1,",.01)=$P(DATA,U,9)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
 ;
REV ; PROC/OP^IDENTIFIER^MDC^DRG
 ;;00.49^N^
 ;;00.58^N^
 ;;00.59^N^
 ;;00.67^N^
 ;;00.68^N^
 ;;00.69^N^
 ;;17.11^J^
 ;;+6^350^351^352
 ;;17.12^J^
 ;;+6^350^351^352
 ;;17.13^J^
 ;;+6^350^351^352
 ;;17.21^J^
 ;;+6^350^351^352
 ;;17.22^J^
 ;;+6^350^351^352
 ;;17.23^J^
 ;;+6^350^351^352
 ;;17.24^J^
 ;;+6^350^351^352
 ;;17.31^^
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.32^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.33^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.34^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.35^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+10^628^629^630
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.36^^
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.39^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;17.41^N^
 ;;17.42^N^
 ;;17.43^N^
 ;;17.44^N^
 ;;17.45^N^
 ;;17.49^N^
 ;;33.72^N^
 ;;37.36^N^
 ;;37.55^O^
 ;;+5^237^238
 ;;37.60^O^
 ;;+5^215
 ;;38.23^N^
 ;;45.81^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;45.82^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;45.83^^
 ;;+5^264
 ;;+6^329^330^331
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.40^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.42^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.43^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.50^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.51^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.52^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;48.59^^
 ;;+6^332^333^334
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.42^O^
 ;;+6^353^354^355
 ;;53.43^^
 ;;+6^353^354^355
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.62^^
 ;;+6^353^354^355
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.63^^
 ;;+6^353^354^355
 ;;53.71^^
 ;;+4^163^164^165
 ;;+6^326^327^328
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.72^^
 ;;+4^163^164^165
 ;;+6^326^327^328
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.75^^
 ;;+4^163^164^165
 ;;+6^326^327^328
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.83^^
 ;;+4^163^164^165
 ;;+6^326^327^328
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;53.84^^
 ;;+4^163^164^165
 ;;+6^326^327^328
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;80.53^^
 ;;+1^28^29^30
 ;;+8^490^491^
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;80.54^^
 ;;+1^28^29^30
 ;;+8^490^491^
 ;;+17^820^821^822^826^827^828
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.70^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.71^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.72^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.73^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.74^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.75^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.76^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;85.79^O^
 ;;+9^582^583^584^585
 ;;+21^907^908^909
 ;;+24^957^958^959
 ;;EXIT