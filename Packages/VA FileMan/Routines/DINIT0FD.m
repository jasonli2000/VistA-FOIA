DINIT0FD	;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0FE S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
	Q
ENTRY	;
	;;^DIST(.404,.310106,40,1,13)
	;;=D:X=""!(DDSOLD="") UNED^DDSUTL("DETAILS","","",$S(X="":1,1:0))
	;;^DIST(.404,.310106,40,1,14)
	;;=D UIVAL^DIKKFORM
	;;^DIST(.404,.310106,40,2,0)
	;;=2^Index Details...^2^^DETAILS
	;;^DIST(.404,.310106,40,2,2)
	;;=3,19^1^3,2^1
	;;^DIST(.404,.310106,40,2,20)
	;;=F^^0:0
	;;^DIST(.404,.310106,40,2,21,0)
	;;=^^1^1^2970722
	;;^DIST(.404,.310106,40,2,21,1,0)
	;;=Press <Return> to view the properties of the Uniqueness Index.
	;;^DIST(.404,.310107,0)
	;;=DIKK EDIT UI HDR^.11
	;;^DIST(.404,.310107,40,0)
	;;=^.4044I^1^1
	;;^DIST(.404,.310107,40,1,0)
	;;=1^ Uniqueness Index ^1
	;;^DIST(.404,.310107,40,1,2)
	;;=^^1,31
	;;^DIST(.404,.310108,0)
	;;=DIKK EDIT UI^.11
	;;^DIST(.404,.310108,40,0)
	;;=^.4044I^9^9
	;;^DIST(.404,.310108,40,1,0)
	;;=1^File^3
	;;^DIST(.404,.310108,40,1,1)
	;;=.01
	;;^DIST(.404,.310108,40,1,2)
	;;=1,13^20^1,7
	;;^DIST(.404,.310108,40,1,4)
	;;=^^^1
	;;^DIST(.404,.310108,40,1,13)
	;;=D BLDLOG^DIKCFORM(DA)
	;;^DIST(.404,.310108,40,1,14)
	;;=D VALFILE^DIKCFORM
	;;^DIST(.404,.310108,40,2,0)
	;;=2^Root File^3
	;;^DIST(.404,.310108,40,2,1)
	;;=.51
	;;^DIST(.404,.310108,40,2,2)
	;;=1,56^20^1,45
	;;^DIST(.404,.310108,40,2,4)
	;;=^^^1
	;;^DIST(.404,.310108,40,3,0)
	;;=3^Index Name^3^^NAME
	;;^DIST(.404,.310108,40,3,1)
	;;=.02
	;;^DIST(.404,.310108,40,3,2)
	;;=2,13^30^2,1
	;;^DIST(.404,.310108,40,3,13)
	;;=D BLDLOG^DIKCFORM(DA)
	;;^DIST(.404,.310108,40,3,14)
	;;=D NAMEVAL^DIKCFORM
	;;^DIST(.404,.310108,40,4,0)
	;;=4^Root Type^3
	;;^DIST(.404,.310108,40,4,1)
	;;=.5
	;;^DIST(.404,.310108,40,4,2)
	;;=2,56^16^2,45
	;;^DIST(.404,.310108,40,4,4)
	;;=^^^1
	;;^DIST(.404,.310108,40,5,0)
	;;=5^Short Description^3
	;;^DIST(.404,.310108,40,5,1)
	;;=.11
	;;^DIST(.404,.310108,40,5,2)
	;;=4,20^56^4,1
	;;^DIST(.404,.310108,40,5,11)
	;;=D HLP^DDSUTL(X)
	;;^DIST(.404,.310108,40,6,0)
	;;=6^Description (wp)^3
	;;^DIST(.404,.310108,40,6,1)
	;;=.1
	;;^DIST(.404,.310108,40,6,2)
	;;=5,20^1^5,2
	;;^DIST(.404,.310108,40,7,0)
	;;=7^!M^1
	;;^DIST(.404,.310108,40,7,.1)
	;;=N WPROOT S WPROOT=$$GET^DDSVAL(.11,DA,.1),Y=$S(WPROOT]"":$G(@WPROOT@(1,0)),1:""),Y=$S(Y]"":"["_$E(Y,1,51)_"]",1:"(empty)")
	;;^DIST(.404,.310108,40,7,2)
	;;=^^5,23
	;;^DIST(.404,.310108,40,8,0)
	;;=8^Set Logic^3
	;;^DIST(.404,.310108,40,8,1)
	;;=1.1
	;;^DIST(.404,.310108,40,8,2)
	;;=14,13^63^14,2
	;;^DIST(.404,.310108,40,8,4)
	;;=^^^2
	;;^DIST(.404,.310108,40,8,11)
	;;=D HLP^DDSUTL(X)
	;;^DIST(.404,.310108,40,9,0)
	;;=9^Kill Logic^3
	;;^DIST(.404,.310108,40,9,1)
	;;=2.1
	;;^DIST(.404,.310108,40,9,2)
	;;=15,13^63^15,1
	;;^DIST(.404,.310108,40,9,4)
	;;=^^^2
	;;^DIST(.404,.310108,40,9,11)
	;;=D HLP^DDSUTL(X)
	;;^DIST(.404,.310109,0)
	;;=DIKK EDIT UI FIELD COLUMN HDR^.31
	;;^DIST(.404,.310109,40,0)
	;;=^.4044I^8^8
	;;^DIST(.404,.310109,40,1,0)
	;;=1^Order...^1
	;;^DIST(.404,.310109,40,1,2)
	;;=^^1,1
	;;^DIST(.404,.310109,40,2,0)
	;;=2^Subscr^1
	;;^DIST(.404,.310109,40,2,2)
	;;=^^1,11
	;;^DIST(.404,.310109,40,3,0)
	;;=3^Length^1
	;;^DIST(.404,.310109,40,3,2)
	;;=^^1,19
	;;^DIST(.404,.310109,40,4,0)
	;;=4^[File,Field] Field Name^1
	;;^DIST(.404,.310109,40,4,2)
	;;=^^1,27
	;;^DIST(.404,.310109,40,5,0)
	;;=5^--------^1
	;;^DIST(.404,.310109,40,5,2)
	;;=^^2,1
	;;^DIST(.404,.310109,40,6,0)
	;;=6^------^1
	;;^DIST(.404,.310109,40,6,2)
	;;=^^2,11
	;;^DIST(.404,.310109,40,7,0)
	;;=7^------^1
	;;^DIST(.404,.310109,40,7,2)
	;;=^^2,19
	;;^DIST(.404,.310109,40,8,0)
	;;=8^-----------------------^1
	;;^DIST(.404,.310109,40,8,2)
	;;=^^2,27
	;;^DIST(.404,.31011,0)
	;;=DIKK EDIT UI FIELD REP^.114
	;;^DIST(.404,.31011,40,0)
	;;=^.4044I^4^4
	;;^DIST(.404,.31011,40,1,0)
	;;=1^^3^^ORDER
	;;^DIST(.404,.31011,40,1,1)
	;;=.01
	;;^DIST(.404,.31011,40,1,2)
	;;=1,3^3
	;;^DIST(.404,.31011,40,1,4)
	;;=^^^2
	;;^DIST(.404,.31011,40,1,14)
	;;=I X="" D HLP^DDSUTL($C(7)_"Deletions not allowed.") S DDSERROR=1
	;;^DIST(.404,.31011,40,2,0)
	;;=2^^3^^SUBSCRIPT
	;;^DIST(.404,.31011,40,2,1)
	;;=.5
	;;^DIST(.404,.31011,40,2,2)
	;;=1,12^3
	;;^DIST(.404,.31011,40,2,4)
	;;=^^^1
	;;^DIST(.404,.31011,40,3,0)
	;;=3^^3
	;;^DIST(.404,.31011,40,3,1)
	;;=6
	;;^DIST(.404,.31011,40,3,2)
	;;=1,20^3
	;;^DIST(.404,.31011,40,3,13)
	;;=D BLDLOG^DIKCFORM(DA(1))
	;;^DIST(.404,.31011,40,4,0)
	;;=4^^4
	;;^DIST(.404,.31011,40,4,2)
	;;=1,27^49
	;;^DIST(.404,.31011,40,4,30)
	;;=N DIKKFIL,DIKKFLD S DIKKFIL={FILE},DIKKFLD={FIELD} S Y="["_DIKKFIL_","_DIKKFLD_"] "_$P($G(^DD(DIKKFIL,DIKKFLD,0)),U)
	;;^DIST(.404,.310111,0)
	;;=DIKK EDIT UI FIELD CRV^.114
	;;^DIST(.404,.310111,40,0)
	;;=^.4044I^9^9
	;;^DIST(.404,.310111,40,1,0)
	;;=1^ Field-Type Cross Reference Value ^1
	;;^DIST(.404,.310111,40,1,2)
	;;=^^1,23
	;;^DIST(.404,.310111,40,2,0)
	;;=2^Order Number^3
	;;^DIST(.404,.310111,40,2,1)
	;;=.01
	;;^DIST(.404,.310111,40,2,2)
	;;=3,18^3^3,4
	;;^DIST(.404,.310111,40,2,4)
	;;=^^^1
	;;^DIST(.404,.310111,40,3,0)
	;;=3^Subscript Number^3
	;;^DIST(.404,.310111,40,3,1)
	;;=.5
	;;^DIST(.404,.310111,40,3,2)
	;;=3,56^3^3,38
	;;^DIST(.404,.310111,40,3,4)
	;;=^^^1
	;;^DIST(.404,.310111,40,4,0)
	;;=4^Field^3^^FIELD
	;;^DIST(.404,.310111,40,4,1)
	;;=3
	;;^DIST(.404,.310111,40,4,2)
	;;=4,18^20^4,11
	;;^DIST(.404,.310111,40,4,4)
	;;=^^^1
	;;^DIST(.404,.310111,40,5,0)
	;;=5^File^3
	;;^DIST(.404,.310111,40,5,1)
	;;=2
	;;^DIST(.404,.310111,40,5,2)
	;;=4,56^20^4,50
	;;^DIST(.404,.310111,40,5,4)
	;;=^^^1
	;;^DIST(.404,.310111,40,6,0)
	;;=6^Field Name^4
	;;^DIST(.404,.310111,40,6,2)
	;;=5,18^58^5,6
	;;^DIST(.404,.310111,40,6,30)
	;;=N DIKCFIL,DIKCFLD S Y="",DIKCFIL=+{FILE},DIKCFLD=+{FIELD} I DIKCFIL,DIKCFLD S Y=$P($G(^DD(DIKCFIL,DIKCFLD,0)),U) S:$L(Y)>60 Y=$E(Y,1,57)_"..."
	;;^DIST(.404,.310111,40,7,0)
	;;=7^Maximum Length^3
	;;^DIST(.404,.310111,40,7,1)
	;;=6
	;;^DIST(.404,.310111,40,7,2)
	;;=7,18^3^7,2
	;;^DIST(.404,.310111,40,7,13)
	;;=S DIKCCRV=1
	;;^DIST(.404,.310111,40,8,0)
	;;=8^Collation^3
	;;^DIST(.404,.310111,40,8,1)
	;;=7
	;;^DIST(.404,.310111,40,8,2)
	;;=7,58^9^7,47
	;;^DIST(.404,.310111,40,9,0)
	;;=9^Lookup Prompt^3
	;;^DIST(.404,.310111,40,9,1)
	;;=8
	;;^DIST(.404,.310111,40,9,2)
	;;=8,18^30^8,3
	;;^DIST(.404,.400011,0)
	;;=DIBTED^.401
	;;^DIST(.404,.400011,40,0)
	;;=^.4044I^9^9
	;;^DIST(.404,.400011,40,1,0)
	;;=1^TEMPLATE NAME^3
	;;^DIST(.404,.400011,40,1,1)
	;;=.01
	;;^DIST(.404,.400011,40,1,2)
	;;=1,16^30^1,1
	;;^DIST(.404,.400011,40,2,0)
	;;=3^DATE LAST MODIFIED^3
	;;^DIST(.404,.400011,40,2,1)
	;;=2
	;;^DIST(.404,.400011,40,2,2)
	;;=4,28^17^4,8
	;;^DIST(.404,.400011,40,2,4)
	;;=^^^1
	;;^DIST(.404,.400011,40,3,0)
	;;=4^DATE LAST USED^3
	;;^DIST(.404,.400011,40,3,1)
	;;=7
