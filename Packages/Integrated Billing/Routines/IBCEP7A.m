IBCEP7A ;ALB/TMP - Functions for fac level PROVIDER ID MAINT ;11-07-00
 ;;2.0;INTEGRATED BILLING;**232,320**;21-MAR-94
 ;
IDNUM(IBIEN) ; Find site-default id # for id type
 ; IBIEN = ien of prov ID type (file 355.97)
 N IBID,Z0,Z1
 S IBID=""
 S Z0=$G(^IBE(355.97,IBIEN,0)),Z1=$G(^(1))
 I $P(Z1,U,9) G IDNUMQ
 I $P(Z0,U,4)'="" S IBID=$P(Z0,U,4) G IDNUMQ
 I $P(Z1,U,4) S IBID=$P($G(^IBE(350.9,1,1)),U,5)
 ;
IDNUMQ Q IBID
 ;
ADDFAC(IBINS,IBEFTFL) ; Add a new fac id for an ins co
 N IB,IBDIV,IBY,IBOK,IBRBLD,IBITYP,IBFORM,DIC,DIR,X,Y,DTOUT,DUOUT,DLAYGO,DO,DD,Z,Z0,DIE,DIK,DA,IBCAREUN,DR,I
 S IBRBLD=0,IBY=-1
 S IBOK=$$FACFLDS^IBCEP7C("",IBINS,.IBITYP,.IBFORM,.IBDIV,"A",.IBCAREUN,IBEFTFL)
 I 'IBOK G ADDFQ
 ;
 S X=IBINS,DIC(0)="L",DIC="^IBA(355.92,"
 S DIC("DR")=".04////"_IBFORM_$S($G(IBDIV):";.05////"_IBDIV,1:"")_";.06////"_IBITYP_$S($G(IBCAREUN)]""&($G(IBCAREUN)'="*N/A*"):";.03////"_IBCAREUN,1:"")_";.08////"_$G(IBEFTFL)
 S DLAYGO=355.92
 D FILE^DICN
 K DIC,DLAYGO,DO,DD
 S IBY=+Y
 ;
 ; Below is a very convoluted way to get the proper prompt on the screen.  Tried using DIC("DR") above but
 ; the file name was being added to the prompt.
 S DIE=355.92
 S DA=IBY
 F I=1:1:3 L +^IBA(355.92,DA):5 Q:$T
 E  G ADDFQ
 S DR=".07"_$S(IBEFTFL="E"!(IBEFTFL="A"):"Billing Provider Secondary ID",1:"VA Lab or Facility Secondary ID")
 D ^DIE
 I $G(DTOUT)!$G(DUOUT) D
 . S DIK=355.92
 . S DA=+IBY
 . S IBY=0
 . D ^DIK
 L -^IBA(355.92,DA)
 ;
ADDFQ I IBY>0,$P($G(^IBA(355.92,IBY,0)),U,7)="" S DIK="^IBA(355.92,",DA=IBY D ^DIK S IBY=-1
 I IBY'>0 S DIR("A",+$O(DIR("A"," "),-1)+1)="A NEW ID WAS NOT ADDED",IBRBLD=0
 I IBY>0 S DIR("A",1)="A NEW ID WAS ADDED SUCCESSFULLY",IBRBLD=1 D
 . Q:IBEFTFL'="A"
 . N NEXTONE
 . S NEXTONE=$$NEXTONE^IBCEP7()
 . S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBY_U_"ADD"_U_355.92
 . S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=^IBA(355.92,IBY,0)
 S DIR(0)="EA",DIR("A")="PRESS RETURN TO CONTINUE: " W ! D ^DIR K DIR
 Q IBRBLD
 ;
ADDID ;
 N IBSAVTMP
 S IBSAVTMP=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 D FACID^IBCEP2B(+IBCNS,"A")
 S ^TMP("IBCE_PRVFAC_MAINT_INS",$J)=$G(IBSAVTMP)
 S VALMBCK="R"
 Q
 ;
IDPARAM ;
 D FULL^VALM1
 D EN^IBCEPB
 S VALMBCK="R"
 Q
 ;
VALFIDS ;
 N IBSAVTMP
 S IBSAVTMP=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 D FACID^IBCEP2B(+IBCNS,"LF")
 S ^TMP("IBCE_PRVFAC_MAINT_INS",$J)=$G(IBSAVTMP)
 S VALMBCK="R"
 Q
