 ; VHAINO.IMPEXPHANDPRINTFIELD.T1
 ; Filing Methods for table: VHAINO.IMPEXP_HAND_PRINT_FIELD (extent = VHAINO.IMPEXPHANDPRINTFIELD) - Do Not Edit.  Compiled November 18, 2010 10:41:01
 ; Filing Methods for table: VHAINO.IMPEXP_HAND_PRINT_FIELD (extent = VHAINO.IMPEXPHANDPRINTFIELD)
#classmethod VHAINO.IMPEXPHANDPRINTFIELDTableCode
#classcontext VHAINO.IMPEXPHANDPRINTFIELD
#include %occExtent
#include %occInclude
#include %systemInclude
#import VHAINO
%delete(%rowid,%check,%tstart=1,%mv=0) n bva,%d,%e,%ele,%itm,%key,%l,%oper,%pos,%s,sn,sqlcode,subs,%SkipFiling s %oper="DELETE",sqlcode=0,%ROWID=%rowid,%d(1)=%rowid,%e(1)=%rowid,%d(2)=$p(%d(1),"||",1),%l=$c(0)
 ;;LinK  k:'$TLEVEL %0CacheLock i '$a(%check,2) { n %ls i $i(%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD"))>$zu(115,6) { l +^IBE(358.94):$zu(115,4) l:$t -^IBE(358.94) s %ls=$s($t:2,1:0) } else { l +^IBE(358.94,%d(1)):$zu(115,4) s %ls=$t } s:%ls=2 $e(%check,2)=$c(1) s:%ls=1 $e(%l)=$c(1) i '%ls s SQLCODE=-110,%msg="Unable to acquire lock for "_%oper_" of table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' on row with RowID = '"_$g(%d(1))_"'" q  } If %tstart { TSTART:($zu(115,1)=1)||('$TLEVEL&&($zu(115,1)=2))  } s $zt="<|'%ETrap'|>"
 ;;LinK  d <|'getold'|> i sqlcode s SQLCODE=-106 g <|'%EExit'|>
 ;;LinK  i '$a(%check),'$zu(115,7) d  i sqlcode s SQLCODE=sqlcode g <|'%EExit'|>
 . n %fk,%k,%p,%st,%t,%z s %k="",%p("%1")="%d(1),",%p("IDKeyIndex")="%d(2),"
 . f  q:sqlcode<0  s %k=$o(^oddEXTR("VHAINO.IMPEXPHANDPRINTFIELD","n",%k)) q:%k=""  s %t="" f  s %t=$o(^oddEXTR("VHAINO.IMPEXPHANDPRINTFIELD","n",%k,"f",%t)) q:%t=""  s %st=(%t="VHAINO.IMPEXPHANDPRINTFIELD") s %fk="" f  s %fk=$o(^oddEXTR("VHAINO.IMPEXPHANDPRINTFIELD","n",%k,"f",%t,%fk)) q:%fk=""  s %z=$g(^oddEXTR("VHAINO.IMPEXPHANDPRINTFIELD","n",%k,"f",%t,%fk,61)) i %z'="",@("$$"_%z_"("_%p(%k)_",%k,%st)") s sqlcode=-124 q
 . q:sqlcode  q:$a(%check,2)=1
 . i '$$IDKeyIndex^VHAINO.ENCOUNTERFORMBLOCK.T1(%e(9),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_BLOCK (Field BLOCK) failed to acquire long-term shared lock on referenced row - required when deleting in case of ROLLBACK" q
 . i '$$IDKeyIndex^VHAINO.AICSDATAELEMENTS.T1(%e(10),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_DHCP_DATA_ELEMENT (Field DHCP_DATA_ELEMENT) failed to acquire long-term shared lock on referenced row - required when deleting in case of ROLLBACK" q
 . i '$$IDKeyIndex^VHAINO.PACKAGEINTERFACE.T1(%e(8),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_TYPE_OF_DATA (Field TYPE_OF_DATA) failed to acquire long-term shared lock on referenced row - required when deleting in case of ROLLBACK" q
 ;;LinK  i '$a(%check,4) { d <|'%bdtrig'|> i sqlcode { s SQLCODE=sqlcode g <|'%EExit'|> }}
 i '$g(%SkipFiling) { i %e(9)'="" s sn(1)=$E(%e(9),1,30) i sn(1)'="" s sn(2)=%d(1) i sn(2)'="" k ^IBE(358.94,"C",sn(1),sn(2))
 	s sn(1)=%e(3) s sn(2)=%d(1) k ^IBE(358.94,"B",sn(1),sn(2)) }
 g:$g(%SkipFiling) %deleteskip
 k ^IBE(358.94,%d(1))
%deleteskip ;
 ;;LinK  d <|'gunlock'|> TCOMMIT:%tstart&&($zu(115,1)=1)
 s SQLCODE=0 q
 ;;LinK %insert(%d,%check,%inssel,%vco,%tstart=1,%mv=0) n bva,%ele,%itm,%key,%l,%n,%oper,%pos,%s,sqlcode,sn,subs,unlockref,%SkipFiling,icol s %oper="INSERT",sqlcode=0,%l=$c(0,0,0),unlockref=1 i '$a(%check),'$$<|'FieldValidate'|>() { s SQLCODE=sqlcode q "" } d <|'Normalize'|>
 ;;LinK  k:'$TLEVEL %0CacheLock If %tstart { TSTART:($zu(115,1)=1)||('$TLEVEL&&($zu(115,1)=2))  } s $zt="<|'%ETrap'|>"
 s:'$d(%d(2)) %d(2)=$$next^%apiSQL("$p(^IBE(358.94,0),""^"",3)") s %d(1)=%d(2)
 ;;LinK  i '$a(%check) d  i sqlcode<0 s SQLCODE=sqlcode g <|'%EExit'|>
 . i $g(%vco)'="" d @%vco q:sqlcode<0
 ;;LinK  . d:$g(%d(3))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,4)) d:$g(%d(4))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,5)) d:$g(%d(5))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,6)) d:$g(%d(6))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,7)) d:$g(%d(8))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,9)) d:$g(%d(9))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,10)) d:$g(%d(10))="" <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,11))
 . q:sqlcode<0
 ;;LinK  . If '$a(%check,2) { l +^IBE("IDKeyIndex",%d(2)):$zu(115,4) If $t { s $e(%l,2)=$c(1) } Else { d <|'ulerror'|>("IDKeyIndex") q  } } If '$$<|'fdU23'|>(%d(2)) s sqlcode=-119,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Constraint 'IDKeyIndex' (Field 'IEN') failed unique check" q
 . q:$zu(115,7)  s %msg=""
 . i '$$IDKeyIndex^VHAINO.ENCOUNTERFORMBLOCK.T1(%d(9),,.unlockref) s sqlcode=-121,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_BLOCK' (Field 'BLOCK') failed referential integrity check"_"  "_$g(%msg) q
 . i '$$IDKeyIndex^VHAINO.AICSDATAELEMENTS.T1(%d(10),,.unlockref) s sqlcode=-121,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_DHCP_DATA_ELEMENT' (Field 'DHCP_DATA_ELEMENT') failed referential integrity check"_"  "_$g(%msg) q
 . i '$$IDKeyIndex^VHAINO.PACKAGEINTERFACE.T1(%d(8),,.unlockref) s sqlcode=-121,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_TYPE_OF_DATA' (Field 'TYPE_OF_DATA') failed referential integrity check"_"  "_$g(%msg) q
 f icol=9,3,10,8,4,5,6,7 s:'$d(%d(icol)) %d(icol)=""
 ;;LinK  i '$a(%check,2) { n %ls i $i(%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD"))>$zu(115,6) { l +^IBE(358.94):$zu(115,4) l:$t -^IBE(358.94) s %ls=$s($t:2,1:0) } else { l +^IBE(358.94,%d(1)):$zu(115,4) s %ls=$t } s:%ls=2 $e(%check,2)=$c(1) s:%ls=1 $e(%l)=$c(1) i '%ls s SQLCODE=-110,%msg="Unable to acquire lock for "_%oper_" of table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' on row with RowID = '"_$g(%d(1))_"'" g <|'%EExit'|> }
 ;;LinK  i '$a(%check,4) { d <|'%bitrig'|> i sqlcode { s SQLCODE=sqlcode g <|'%EExit'|> }}
 g:$g(%SkipFiling) %insertskip
 s ^IBE(358.94,%d(1),0)=%d(3)_"^"_%d(4)_"^"_%d(5)_"^"_%d(6)_"^"_%d(7)_"^"_%d(8)_"^^"_%d(9)_"^^"_%d(10)
 i '$a(%check,3) { i %d(9)'="" s sn(1)=$E(%d(9),1,30) i sn(1)'="" s sn(2)=%d(1) i sn(2)'="" s ^IBE(358.94,"C",sn(1),sn(2))=""
 	s sn(1)=%d(3) s sn(2)=%d(1) s ^IBE(358.94,"B",sn(1),sn(2))="" }
%insertskip ;
 ;;LinK  d <|'gunlock2'|>
 ;;LinK  d <|'gunlock'|> TCOMMIT:%tstart&&($zu(115,1)=1)
 for %itm=2:1:$g(unlockref) l -@$lg(unlockref(%itm))#"SI" s %0CacheLock($lg(unlockref(%itm),2))=%0CacheLock($lg(unlockref(%itm),2))-1
 s SQLCODE=0 q %d(1) 			// %insert-end
 ;;LinK %update(%rowid,%check,%d,%vco,%tstart=1,%mv=0) n %e,bva,%ele,%itm,%key,%l,%n,%oper,%pos,%s,icol,s,sn,sqlcode,subs,t,unlockref,%SkipFiling s %oper="UPDATE",sqlcode=0,%ROWID=%rowid,$e(%e,1)=$c(0),%l=$c(0,0,0),unlockref=1 i '$a(%check),'$$<|'FieldValidate'|>() s SQLCODE=sqlcode q
 ;;LinK  d <|'Normalize'|> i ($d(%d(1))&&($g(%d(1))'=%rowid))||($d(%d(2))&&($g(%d(2))'=$p(%rowid,"||",1))) s SQLCODE=-107,%msg="Updating any of the RowID Fields ('RowId', or 'IEN') not allowed" q
 f icol=2:1:10 s $e(%e,icol)=$c($d(%d(icol)))
 s %d(1)=%rowid,%e(1)=%rowid,%d(2)=$p(%d(1),"||",1)
 ;;LinK  k:'$TLEVEL %0CacheLock i '$a(%check,2) { n %ls i $i(%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD"))>$zu(115,6) { l +^IBE(358.94):$zu(115,4) l:$t -^IBE(358.94) s %ls=$s($t:2,1:0) } else { l +^IBE(358.94,%d(1)):$zu(115,4) s %ls=$t } s:%ls=2 $e(%check,2)=$c(1) s:%ls=1 $e(%l)=$c(1) i '%ls s SQLCODE=-110,%msg="Unable to acquire lock for "_%oper_" of table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' on row with RowID = '"_$g(%d(1))_"'" q  } If %tstart { TSTART:($zu(115,1)=1)||('$TLEVEL&&($zu(115,1)=2))  } s $zt="<|'%ETrap'|>"
 ;;LinK  if $g(%vco)="" { d <|'getold'|> i sqlcode { s SQLCODE=-109 g <|'%EExit'|> } f icol=9,3,10,8,4,5,6,7 { s:'$d(%d(icol)) %d(icol)=%e(icol) s:%d(icol)=%e(icol) $e(%e,icol)=$c(0) }} else { d <|'getoldall'|> i sqlcode { s SQLCODE=-109 g <|'%EExit'|> } f icol=3,4,5,6,7,8,9,10 { s:'$d(%d(icol)) %d(icol)=%e(icol) s:%d(icol)=%e(icol) $e(%e,icol)=$c(0) }}
 ;;LinK  d:'$a(%check)  i sqlcode s SQLCODE=sqlcode g <|'%EExit'|>
 . i $g(%vco)'="" d @%vco q:sqlcode<0
 ;;LinK  . i $a(%e,3),$g(%d(3))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,4))
 ;;LinK  . i $a(%e,4),$g(%d(4))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,5))
 ;;LinK  . i $a(%e,5),$g(%d(5))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,6))
 ;;LinK  . i $a(%e,6),$g(%d(6))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,7))
 ;;LinK  . i $a(%e,8),$g(%d(8))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,9))
 ;;LinK  . i $a(%e,9),$g(%d(9))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,10))
 ;;LinK  . i $a(%e,10),$g(%d(10))="" d <|'%nBuild'|>:'$d(%n),<|'missing'|>($lg(%n,11))
 . q:sqlcode
 . q:$zu(115,7)  s %msg=""
 . i $a(%e,9),$g(%updcas)'="IDKeyIndex",'$$IDKeyIndex^VHAINO.ENCOUNTERFORMBLOCK.T1(%d(9),,.unlockref) s sqlcode=-122,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_BLOCK' (Field 'BLOCK') failed referential integrity check"_"  "_$g(%msg) q
 . i $a(%e,10),$g(%updcas)'="IDKeyIndex",'$$IDKeyIndex^VHAINO.AICSDATAELEMENTS.T1(%d(10),,.unlockref) s sqlcode=-122,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_DHCP_DATA_ELEMENT' (Field 'DHCP_DATA_ELEMENT') failed referential integrity check"_"  "_$g(%msg) q
 . i $a(%e,8),$g(%updcas)'="IDKeyIndex",'$$IDKeyIndex^VHAINO.PACKAGEINTERFACE.T1(%d(8),,.unlockref) s sqlcode=-122,%msg="Table 'VHAINO.IMPEXP_HAND_PRINT_FIELD', Foreign Key Constraint 'FKey_TYPE_OF_DATA' (Field 'TYPE_OF_DATA') failed referential integrity check"_"  "_$g(%msg) q
 . q:$a(%check,2)=1  q:$g(%updcas)'=""
 . i ($a(%e,9)),$g(%e(9))'="",'$$IDKeyIndex^VHAINO.ENCOUNTERFORMBLOCK.T1(%e(9),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_BLOCK (Field BLOCK) failed to acquire long-term shared lock on [old] referenced row - required when updated in case of ROLLBACK" q
 . i ($a(%e,10)),$g(%e(10))'="",'$$IDKeyIndex^VHAINO.AICSDATAELEMENTS.T1(%e(10),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_DHCP_DATA_ELEMENT (Field DHCP_DATA_ELEMENT) failed to acquire long-term shared lock on [old] referenced row - required when updated in case of ROLLBACK" q
 . i ($a(%e,8)),$g(%e(8))'="",'$$IDKeyIndex^VHAINO.PACKAGEINTERFACE.T1(%e(8),1) s %msg="Table VHAINO.IMPEXP_HAND_PRINT_FIELD, Foreign Key Constraint FKEY_TYPE_OF_DATA (Field TYPE_OF_DATA) failed to acquire long-term shared lock on [old] referenced row - required when updated in case of ROLLBACK" q
 ;;LinK  i '$a(%check,4) { d <|'%butrig'|> i sqlcode { s SQLCODE=sqlcode g <|'%EExit'|> }}
 i '$a(%check,3),'$g(%SkipFiling) { i $a(%e,9) { i %e(9)'="" s sn(1)=$E(%e(9),1,30) i sn(1)'="" s sn(2)=%d(1) i sn(2)'="" k ^IBE(358.94,"C",sn(1),sn(2)) }
 	i $a(%e,3) { s sn(1)=%e(3) s sn(2)=%d(1) k ^IBE(358.94,"B",sn(1),sn(2)) } }
 g:$g(%SkipFiling) %updateskip
 s:$s($a(%e,3):1,$a(%e,4):1,$a(%e,5):1,$a(%e,6):1,$a(%e,7):1,$a(%e,8):1,$a(%e,9):1,1:$a(%e,10)) s=$g(^IBE(358.94,%d(1),0)),^IBE(358.94,%d(1),0)=$s($a(%e,3):%d(3),1:$p(s,"^"))_"^"_$s($a(%e,4):%d(4),1:$p(s,"^",2))_"^"_$s($a(%e,5):%d(5),1:$p(s,"^",3))_"^"_$s($a(%e,6):%d(6),1:$p(s,"^",4))_"^"_$s($a(%e,7):%d(7),1:$p(s,"^",5))_"^"_$s($a(%e,8):%d(8),1:$p(s,"^",6))_"^"_$p(s,"^",7)_"^"_$s($a(%e,9):%d(9),1:$p(s,"^",8))_"^"_$p(s,"^",9)_"^"_$s($a(%e,10):%d(10),1:$p(s,"^",10))_"^"_$p(s,"^",11,3641144)
 i '$a(%check,3) { i $a(%e,9) { i %d(9)'="" s sn(1)=$E(%d(9),1,30) i sn(1)'="" s sn(2)=%d(1) i sn(2)'="" s ^IBE(358.94,"C",sn(1),sn(2))="" }
 	i $a(%e,3) { s sn(1)=%d(3) s sn(2)=%d(1) s ^IBE(358.94,"B",sn(1),sn(2))="" } }
%updateskip ;
 ;;LinK  d <|'gunlock2'|>
 ;;LinK  d <|'gunlock'|> TCOMMIT:%tstart&&($zu(115,1)=1)
 for %itm=2:1:$g(unlockref) l -@$lg(unlockref(%itm))#"SI" s %0CacheLock($lg(unlockref(%itm),2))=%0CacheLock($lg(unlockref(%itm),2))-1
 s SQLCODE=0 q
%1(%p1,lockonly=0,unlockref) // FKey validation entry point
 n id s id=%p1
 if '$$%getlock(id,1,.unlockref) { s sqlcode=-114,%msg="SQLCODE=-114:  Cannot acquire lock on referenced row for referenced key VHAINO.IMPEXP_HAND_PRINT_FIELD:%1" q 0 }
 ;;LinK  if 'lockonly { n qv s qv='$$<|'fdU19'|>(%p1) d:'$g(unlockref) %ReleaseLock(id,1) q qv } Else { d:'$g(unlockref) %ReleaseLock(id,1) q 1 }
IDKeyIndex(%p1,lockonly=0,unlockref) // FKey validation entry point
 n id s id=%p1
 if '$$%getlock(id,1,.unlockref) { s sqlcode=-114,%msg="SQLCODE=-114:  Cannot acquire lock on referenced row for referenced key VHAINO.IMPEXP_HAND_PRINT_FIELD:IDKEYINDEX" q 0 }
 ;;LinK  if 'lockonly { n qv s qv='$$<|'fdU23'|>(%p1) d:'$g(unlockref) %ReleaseLock(id,1) q qv } else { d:'$g(unlockref) %ReleaseLock(id,1) q 1 }
 ;;LinK %PurgeIndices(indices="") q $$<|'BuildPurgeIndices'|>(indices,0)
 ;;LinK %BuildIndices(indices="") q $$<|'BuildPurgeIndices'|>(indices,1)
%CheckUniqueIndices(indices,ok) n d,g,n,o s d=0
 s ok=1 q
 ;;LinK %ForeignKey1(%d9,%n9,k,sametab=0) q:%d9="" 0 n rx s rx=$$<|'%fkE20'|>(%d9) s:rx %msg="At least 1 Row exists in table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' which references key "_k_" - failed on referential action of NO ACTION" QUIT rx
 ;;LinK %ForeignKey2(%d10,%n10,k,sametab=0) q:%d10="" 0 n rx s rx=$$<|'%fkE21'|>(%d10) s:rx %msg="At least 1 Row exists in table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' which references key "_k_" - failed on referential action of NO ACTION" QUIT rx
 ;;LinK %ForeignKey3(%d8,%n8,k,sametab=0) q:%d8="" 0 n rx s rx=$$<|'%fkE22'|>(%d8) s:rx %msg="At least 1 Row exists in table 'VHAINO.IMPEXP_HAND_PRINT_FIELD' which references key "_k_" - failed on referential action of NO ACTION" QUIT rx
%AcquireLock(%rowid,s=0,unlockref) n %d,gotlock s %d(1)=%rowid,%d(2)=$p(%d(1),"||",1) s s=$e("S",s) l +^IBE(358.94,%d(1))#s:$zu(115,4) set gotlock=$t s:gotlock&&$g(unlockref) unlockref($i(unlockref))=$lb($name(^IBE(358.94,%d(1))),"VHAINO.IMPEXPHANDPRINTFIELD") q gotlock
%AcquireTableLock(s=0,SQLCODE=0) s s=$e("S",s) l +^IBE(358.94)#s:$zu(115,4) q:$t 1 s SQLCODE=-110,%msg="Unable to acquire "_$s(s="S":"shared ",1:"")_"table lock for table 'VHAINO.IMPEXP_HAND_PRINT_FIELD'" q 0
%ReleaseLock(%rowid,s=0,i=0) n %d s %d(1)=%rowid,%d(2)=$p(%d(1),"||",1) s s=$e("S",s)_$e("I",i) l -^IBE(358.94,%d(1))#s s:i&&($g(%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD"))) %0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD")=%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD")-1 q
%ReleaseTableLock(s=0,i=0) s s=$e("S",s)_$e("I",i) l -^IBE(358.94)#s q 1
%getlock(%rowid,%s=0,unlockref) [] PUBLIC { k:'$TLEVEL %0CacheLock i $i(%0CacheLock("VHAINO.IMPEXPHANDPRINTFIELD"))>$zu(115,6) { l +^IBE(358.94):$zu(115,4) l:$t -^IBE(358.94) q $s($t:2,1:0) } q $$%AcquireLock(%rowid,%s,.unlockref) }
gunlock l:$a(%l) -^IBE(358.94,%d(1))
 q
gunlock2 l:$a(%l,2) -^IBE("IDKeyIndex",%d(2))#"I" q
%nBuild s %n=$lb(,"RowId","IEN","NAME","LABEL","STARTING_COLUMN","STARTING_ROW","LABEL_APPEARANCE","TYPE_OF_DATA","BLOCK","DHCP_DATA_ELEMENT")
 q
FieldValidate() n %f ;Validate all fields
 ;;LinK  i $g(%d(3))'="",'($select(($s(%d(3)'=$c(0):$length(%d(3)),1:0)'<3)&&($length(%d(3))'>30):1,$s(%d(3)'=$c(0):$length(%d(3)),1:0)<3:$$$ERROR($$$DTMinLen,%d(3),3),1:$$$ERROR($$$DTMaxLen,%d(3),30))) { d <|'invalid'|>(3+1,%d(3)) } i $g(%d(4))'="",'($select(($s(%d(4)'=$c(0):$length(%d(4)),1:0)'<1)&&($length(%d(4))'>150):1,$s(%d(4)'=$c(0):$length(%d(4)),1:0)<1:$$$ERROR($$$DTMinLen,%d(4),1),1:$$$ERROR($$$DTMaxLen,%d(4),150))) { d <|'invalid'|>(4+1,%d(4)) } i $g(%d(5))'="",'($select($isvalidnum(%d(5),0,0,200):1,'$isvalidnum(%d(5)):$$$ERROR($$$DTNotNum,%d(5)),%d(5)<0:$$$ERROR($$$DTMinVal,%d(5),0),1:$$$ERROR($$$DTMaxVal,%d(5),200))) { d <|'invalid'|>(5+1,%d(5)) } i $g(%d(6))'="",'($select($isvalidnum(%d(6),0,0,200):1,'$isvalidnum(%d(6)):$$$ERROR($$$DTNotNum,%d(6)),%d(6)<0:$$$ERROR($$$DTMinVal,%d(6),0),1:$$$ERROR($$$DTMaxVal,%d(6),200))) { d <|'invalid'|>(6+1,%d(6)) } i $g(%d(7))'="",'($select(($s(%d(7)'=$c(0):$length(%d(7)),1:0)'<1)&&($length(%d(7))'>3):1,$s(%d(7)'=$c(0):$length(%d(7)),1:0)<1:$$$ERROR($$$DTMinLen,%d(7),1),1:$$$ERROR($$$DTMaxLen,%d(7),3))) { d <|'invalid'|>(7+1,%d(7)) } f %f=2,8,9,10 { i $g(%d(%f))'="",'(($length(%d(%f))'>50)) d <|'invalid'|>(%f+1,$g(%d(%f))) q  }  q 'sqlcode
 ;;LinK invalid(ficol,val) [sqlcode] PUBLIC { s:$l($g(val))>40 val=$e(val,1,40)_"..." d:'$d(%n) <|'%nBuild'|> s %msg="Field 'IMPEXP_HAND_PRINT_FIELD."_$lg(%n,ficol)_"' "_$s($g(val)'="":" (value "_$s(val="":"<NULL>",val=$c(0):"<EMPTY STRING>",1:"'"_val_"'")_")",1:"")_" failed validation",sqlcode=$s(%oper="INSERT":-104,1:-105) q  }
Normalize n %f ;Normalize all fields
 f %f=5,6 { s:$g(%d(%f))'="" %d(%f)=$normalize($decimal(%d(%f)),0) }  q
%trg1 ;
#sqlcompile SELECT=Logical
#import VHAINO
	n DISYS,DT,DTIME,DUZ,FDA,FDAIEN,IO,U,wp s FDAIEN(1)=%d(1)
	s:%d(3)'="" FDA(358.94,"+1,",.01)=%d(3)
	s:%d(4)'="" FDA(358.94,"+1,",.02)=%d(4)
	s:%d(5)'="" FDA(358.94,"+1,",.03)=%d(5)
	s:%d(6)'="" FDA(358.94,"+1,",.04)=%d(6)
	s:%d(7)'="" FDA(358.94,"+1,",.05)=%d(7)
	s:%d(8)'="" FDA(358.94,"+1,",.06)=%d(8)
	s:%d(9)'="" FDA(358.94,"+1,",.08)=%d(9)
	s:%d(10)'="" FDA(358.94,"+1,",.1)=%d(10)
	d UPDATE^DIE("","FDA","FDAIEN","%FMERR(358.94)") s %SkipFiling=1
	i $d(%FMERR(358.94,"DIERR")) { s U="^" d MSG^DIALOG("AT",.err,32768,,"%FMERR(358.94)") s %ok=0 f err=1:1:err { s $p(%msg,$c(13,10),err)=$g(err(err)) } q  }
	QUIT
 q
%bitrig n %ok s %ok=1 ;  'BEFORE INSERT' trigger(s)
 ;;LinK  d <|'%trg1'|> i '%ok { s sqlcode=-130 q  } q
#sqlcompile SELECT=Logical
#import VHAINO
fdU19(%1,%id="") &sql(SELECT RowId FROM VHAINO.IMPEXP_HAND_PRINT_FIELD WHERE  RowId=:%1 AND (%ID <> :%id OR :%id IS NULL)) QUIT SQLCODE=100
#sqlcompile SELECT=Logical
#import VHAINO
fdU23(%1,%id="") &sql(SELECT IEN FROM VHAINO.IMPEXP_HAND_PRINT_FIELD WHERE  IEN=:%1 AND (%ID <> :%id OR :%id IS NULL)) QUIT SQLCODE=100
missing(fname) s sqlcode=-108,%msg="'"_fname_"' in table '"_"VHAINO"_"."_"IMPEXP_HAND_PRINT_FIELD"_"' is a required field" q
ulerror(cname) s sqlcode=-110,%msg="Unable to obtain lock to "_$s(%oper="DELETE":"maintain",1:"check")_" uniqueness of constraint '"_cname_"'" q
 ;;LinK %ETrap s $zt="",SQLCODE=-415,%msg=$s($g(%msg)'="":%msg_" -- ",1:"")_"Error occuring during "_%oper_" in '"_"VHAINO"_"."_"IMPEXP_HAND_PRINT_FIELD"_"':  $ZE="_$ze i $ze["<FRAMESTACK>" { s %msg="Error '"_$ze_"' occurred during "_%oper_" in '"_"VHAINO"_"."_"IMPEXP_HAND_PRINT_FIELD"_" - Process HALTed" d ##Class(%SYS.System).WriteToConsoleLog(%msg) i ($zu(67,10,$j)=1)||($zu(67,10,$j)=3) { w !,%msg h 3 } HALT  } g <|'%EExit'|>
 ;;LinK %EExit d:%oper'="DELETE" <|'gunlock2'|> d <|'gunlock'|> If %tstart,$zu(115,1)=1,$TLEVEL { s %tstart=0 TROLLBACK 1 }  q:%oper="INSERT" "" q
#sqlcompile SELECT=Logical
#import VHAINO
%fkE20(%val9) &sql(SELECT BLOCK
      FROM   VHAINO.IMPEXP_HAND_PRINT_FIELD
      WHERE  BLOCK=:%val9) QUIT SQLCODE=0
#sqlcompile SELECT=Logical
#import VHAINO
%fkE21(%val10) &sql(SELECT DHCP_DATA_ELEMENT
      FROM   VHAINO.IMPEXP_HAND_PRINT_FIELD
      WHERE  DHCP_DATA_ELEMENT=:%val10) QUIT SQLCODE=0
#sqlcompile SELECT=Logical
#import VHAINO
%fkE22(%val8) &sql(SELECT TYPE_OF_DATA
      FROM   VHAINO.IMPEXP_HAND_PRINT_FIELD
      WHERE  TYPE_OF_DATA=:%val8) QUIT SQLCODE=0
getold ; Get old data values
 #sqlcompile SELECT=Logical
#import VHAINO
 &sql(SELECT BLOCK,NAME,DHCP_DATA_ELEMENT,TYPE_OF_DATA,LABEL,STARTING_COLUMN,STARTING_ROW,LABEL_APPEARANCE INTO :%e() FROM VHAINO.IMPEXP_HAND_PRINT_FIELD WHERE RowId=:%rowid) s sqlcode=SQLCODE q
getoldall ; Get all old data values
 #sqlcompile SELECT=Logical
#import VHAINO
 &sql(SELECT NAME,LABEL,STARTING_COLUMN,STARTING_ROW,LABEL_APPEARANCE,TYPE_OF_DATA,BLOCK,DHCP_DATA_ELEMENT INTO :%e() FROM VHAINO.IMPEXP_HAND_PRINT_FIELD WHERE RowId=:%rowid) s sqlcode=SQLCODE q
%trg10 ;
#sqlcompile SELECT=Logical
#import VHAINO
	n DISYS,DT,DTIME,DUZ,FDA,IENS,IO,U,wp,wproot s IENS=$g(%d(1))_","
	s:($a(%e,3)) FDA(358.94,IENS,.01)=$g(%d(3))
	s:($a(%e,4)) FDA(358.94,IENS,.02)=$g(%d(4))
	s:($a(%e,5)) FDA(358.94,IENS,.03)=$g(%d(5))
	s:($a(%e,6)) FDA(358.94,IENS,.04)=$g(%d(6))
	s:($a(%e,7)) FDA(358.94,IENS,.05)=$g(%d(7))
	s:($a(%e,8)) FDA(358.94,IENS,.06)=$g(%d(8))
	s:($a(%e,9)) FDA(358.94,IENS,.08)=$g(%d(9))
	s:($a(%e,10)) FDA(358.94,IENS,.1)=$g(%d(10))
	d:$d(FDA) UPDATE^DIE("","FDA","FDAIEN","%FMERR(358.94)") s %SkipFiling=1
	i $d(%FMERR(358.94,"DIERR")) { s U="^" d MSG^DIALOG("AT",.err,32768,,"%FMERR(358.94)") s %ok=0 f err=1:1:err { s $p(%msg,$c(13,10),err)=$g(err(err)) } q  }
	QUIT
 q
%butrig n %ok s %ok=1 ;  'BEFORE UPDATE' trigger(s)
 ;;LinK  d <|'%trg10'|> i '%ok { s sqlcode=-132 q  } q
%trg2 ;
#sqlcompile SELECT=Logical
#import VHAINO
	n %,%H,DA,DIC,DIK,DISYS,DT,DTIME,DUZ,IO,U,X,Y d DTNOLF^DICRW s DIK="^IBE(358.94," s DA=%d(1) d ^DIK s %SkipFiling=1 q  
 q
%bdtrig n %ok s %ok=1 ;  'BEFORE DELETE' trigger(s)
 ;;LinK  d <|'%trg2'|> i '%ok { s sqlcode=-134 q  } q
%QuickInsert(d,%nolock=0,pkey=0,parentpkey=0) // Insert new row with values d(icol)
 s:%nolock=2 %nolock=0
 s %ROWID=$$%insert^VHAINO.IMPEXPHANDPRINTFIELD.T1(.d,$c(0,%nolock=1,0,0,0)),%ROWCOUNT='SQLCODE,%qrc=SQLCODE
 i pkey { i %qrc { s %ROWID=$lb(-1) } else { s %ROWID=$lb(d(2)) } s d=$zobjexport(%ROWID,5) } k d q
%QuickBulkInsert(%inscall,%nolock=0) // Insert multiple new rows with values %qd(icol)
 n c,call,nc,nr,%qd,r,x s:%nolock=2 %nolock=0 s nr=$zobjexport(12) f r=1:1:nr { s nc=$zobjexport(12) k %qd f c=1:1:nc { s:$zobjexport(17) %qd(c+1)=$zobjexport(12) } d @%inscall s x=$zobjexport($s(%qrc:-1,1:%ROWID),18) } q  
