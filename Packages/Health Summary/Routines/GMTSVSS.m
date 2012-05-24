GMTSVSS ; SLC/KER - Selected Vital Signs           ; 02/27/2002
 ;;2.7;Health Summary;**8,20,28,35,49,78**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  4791  EN1^GMVHS
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA 10022  %XY^%RCR
 ;
 ; Health Summary patch GMTS*2.7*35 will require
 ; Vitals version 4.0, patch GMRV*4.0*7
 ;
OUTPAT ; Outpatient Select Vitals Signs Main control
 N CNT,COL,COLL,HDR,GMTSDA,GMTSDT,GMTSF,GMTSI,GMW,GMRVSTR,LOOP,MAX,ROW,WIDTH
 K ^UTILITY($J,"GMRVD") S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:100)
 S GMTSI=0 F  S GMTSI=$O(GMTSEG(GMTSEGN,120.51,GMTSI)) Q:GMTSI'>0  S GMTSDA=GMTSEG(GMTSEGN,120.51,GMTSI) D BLDSTR
 Q:'$D(GMRVSTR)
 S GMRVSTR(0)=GMTSBEG_U_GMTSEND_U_MAX_U_1
 ;   Set to only get Vital Sign for Clinics
 S GMRVSTR("LT")="^C^"
 ;D BLDHDR,EN1^GMRVUT0
 D BLDHDR,EN1^GMVHS
 ;   If no data, display most recent inpatient measurements
 I '$D(^UTILITY($J,"GMRVD")) D  Q
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "*** No Outpatient measurements ***",!!
 . S MAX=1 D ENVS
 S ROW=1 D NXTROW
 D WRTHDR,WRTHDR1
 S GMTSDT="" F GMTSF=1:1:MAX S GMTSDT=$O(^UTILITY($J,"GMRVD",GMTSDT)) Q:GMTSDT'>0  D WRT Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 I $O(COL(ROW)) F ROW=2:1 Q:'$D(COL(ROW))!($D(GMTSQIT))  D
 . D NXTROW
 . W !! D WRTHDR,WRTHDR1
 . S GMTSDT="" F GMTSF=1:1:MAX S GMTSDT=$O(^UTILITY($J,"GMRVD",GMTSDT)) Q:GMTSDT'>0  D WRT Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 K ^UTILITY($J,"GMRVD"),GMTSVMVR
 Q
ENVS ; Set up for extraction routine
 N CNT,COL,COLL,HDR,HDR1,GMTSDA,GMTSDT,GMTSF,GMTSI,GMW,LOOP,ROW,WIDTH
 K ^UTILITY($J,"GMRVD"),GMRVSTR("LT")
 S MAX=$S(+($G(MAX))>0:MAX,+($G(MAX))'>0&(+($G(GMTSNDM))>0):+($G(GMTSNDM)),1:100)
 S GMTSI=0 F  S GMTSI=$O(GMTSEG(GMTSEGN,120.51,GMTSI)) Q:GMTSI'>0  S GMTSDA=GMTSEG(GMTSEGN,120.51,GMTSI) D BLDSTR
 Q:'$D(GMRVSTR)
 S GMRVSTR(0)=GMTSBEG_U_GMTSEND_U_MAX_U_1
 ;D BLDHDR,EN1^GMRVUT0
 D BLDHDR,EN1^GMVHS
 I '$D(^UTILITY($J,"GMRVD")) Q
 S ROW=1 D NXTROW
 D WRTHDR,WRTHDR1
 S GMTSDT="" F GMTSF=1:1:MAX S GMTSDT=$O(^UTILITY($J,"GMRVD",GMTSDT)) Q:GMTSDT'>0  D WRT Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 I $O(COL(ROW)) F ROW=2:1 Q:'$D(COL(ROW))!($D(GMTSQIT))  D
 . D NXTROW
 . W !! D WRTHDR,WRTHDR1
 . S GMTSDT="" F GMTSF=1:1:MAX S GMTSDT=$O(^UTILITY($J,"GMRVD",GMTSDT)) Q:GMTSDT'>0  D WRT Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 K ^UTILITY($J,"GMRVD"),GMTSVMVR
 Q
BLDSTR ; Builds GMRVSTR string for extract call
 N DA,DIC,DIQ,DR,VIT
 S GMTSVMVR=+$$VERSION^XPDUTL("GMRV")
 S DIQ="VIT(",DIQ(0)="E",DIC=120.51,DR="1",DA=GMTSDA
 D EN^DIQ1 S VIT=VIT(120.51,DA,1,"E")
 S GMRVSTR=$S($D(GMRVSTR):GMRVSTR_";"_VIT,1:VIT)
 Q
BLDHDR ; Builds the HDR array
 N ABB,GMTSI S COL=18
 F GMTSI=1:1:$L(GMRVSTR,";") D
 . S (HDR(GMTSI-1),ABB)=$P(GMRVSTR,";",GMTSI)
 . S HDR(GMTSI-1)=HDR(GMTSI-1)_U
 . S HDR(GMTSI-1)=HDR(GMTSI-1)_$S(ABB="BP":"BP",ABB="PN":"PAIN",ABB="HT":"HEIGHT",ABB="WT":"WEIGHT",ABB="P":"PULSE",ABB="R":"RESP",ABB="T":"TEMP",ABB="PO2":"POx",1:ABB)
 . S WIDTH=$S($P(HDR(GMTSI-1),U)="T":13,$P(HDR(GMTSI-1),U)="P":8,$P(HDR(GMTSI-1),U)="R":12,$P(HDR(GMTSI-1),U)="WT":20,$P(HDR(GMTSI-1),U)="CG":34,$P(HDR(GMTSI-1),U)="CVP":16,$P(HDR(GMTSI-1),U)="HT":13,$P(HDR(GMTSI-1),U)="PO2":13,1:12)
 . S COLL=$P(COL,U,GMTSI)+WIDTH
 . S COL=COL_U
 . S COL=COL_COLL
 . S HDR(GMTSI-1)=HDR(GMTSI-1)_U_COLL_U_WIDTH
 S ROW=1,COL(ROW)=18,COLL=18,CNT=0
 F LOOP=0:1 Q:'$D(HDR(LOOP))  D
 . I $P(HDR(LOOP),U,4)+COLL'>80 D  Q
 . . S COLL=$P(HDR(LOOP),U,4)+COLL
 . . S COL(ROW)=COL(ROW)_U_COLL
 . . S HDR1(ROW,CNT)=HDR(LOOP)
 . . S CNT=CNT+1
 . . K HDR(LOOP)
 . S ROW=ROW+1,COL(ROW)=18,COLL=18,CNT=0
 . S COLL=$P(HDR(LOOP),U,4)+COLL
 . S COL(ROW)=COL(ROW)_U_COLL
 . S HDR1(ROW,CNT)=HDR(LOOP)
 . S CNT=CNT+1
 . K HDR(LOOP)
 Q
WRTHDR ; Writes Header
 N GMI
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Measurement DT"
 I GMTSVMVR'>3 F GMI=0:1:5 D CKP^GMTSUP Q:'$D(HDR(GMI))!($D(GMTSQIT))  D
 . W ?$P(COL,U,GMI+1),$P(HDR(GMI),U,2)
 I GMTSVMVR>3 S GMI="" F  S GMI=$O(HDR(GMI)) Q:(GMI="")  Q:('$D(HDR(GMI)))!($D(GMTSQIT))  D CKP^GMTSUP D
 . W ?$P(COL,U,GMI+1),$P(HDR(GMI),U,2)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WRTHDR1 ; Writes 2nd line of header
 N GMI
 I GMTSVMVR'>3 F GMI=0:1:5 D CKP^GMTSUP Q:'$D(HDR(GMI))!($D(GMTSQIT))  D
 . I $P(HDR(GMI),U)="HT" W ?$P(COL,U,GMI+1),"IN(CM)"
 . I $P(HDR(GMI),U)="WT" W ?$P(COL,U,GMI+1),"LB(KG)"
 . I $P(HDR(GMI),U)="T" W ?$P(COL,U,GMI+1),"F(C)"
 I GMTSVMVR>3 S GMI="" F  S GMI=$O(HDR(GMI)) Q:(GMI="")  Q:('$D(HDR(GMI)))!($D(GMTSQIT))  D CKP^GMTSUP D
 . I $P(HDR(GMI),U)="HT" W ?$P(COL,U,GMI+1),"IN(CM)"
 . I $P(HDR(GMI),U)="WT" W ?$P(COL,U,GMI+1),"LB(KG)[BMI]"
 . I $P(HDR(GMI),U)="T" W ?$P(COL,U,GMI+1),"F(C)"
 . I $P(HDR(GMI),U)="CVP" W ?$P(COL,U,GMI+1),"CMH20(MMHG)"
 . I $P(HDR(GMI),U)="PO2" W ?$P(COL,U,GMI+1),"(L/MIN)(%)"
 . I $P(HDR(GMI),U)="CG" W ?$P(COL,U,GMI+1),"IN(CM)"
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !!
 Q
WRT ; Writes vitals record for one observation time
 N GMLEN,GMTSBMI,GMTSI,GMTSVAL,GMTDT,GMTSVI,GMTSVT,GMTSMET,GMTSPERC,GMTSLMIN,GMTSQUAL,IEN,X
 S GMTSVI="",X=9999999-GMTSDT D REGDTM4^GMTSU S GMTDT=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG WRTHDR,WRTHDR1 W GMTDT
 I GMTSVMVR'>3 F GMTSI=0:1:5 S GMTSVI=$O(HDR(GMTSVI)) Q:GMTSVI=""!($D(GMTSQIT))  D
 . S GMTSVT=$P(HDR(GMTSVI),U),IEN=$O(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,0))
 . I +IEN D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . . S GMTSVAL=$P(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,+IEN),U,8)
 . . W ?$P(COL,U,GMTSI+1),GMTSVAL
 . . S GMTSMET=$P(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,+IEN),U,13) I GMTSMET'="" W "("_$P(^(+IEN),U,13)_")"
 . . Q
 . Q
 I GMTSVMVR>3 F GMTSI=0:1 S GMTSVI=$O(HDR(GMTSVI)) Q:GMTSVI=""!($D(GMTSQIT))  D
 . S GMTSVT=$P(HDR(GMTSVI),U),IEN=$O(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,0))
 . I +IEN D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . . S GMTSVAL=$P(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,+IEN),U,8)
 . . S:GMTSVT="PN"&(GMTSVAL=99) GMTSVAL="No Response"
 . . S:GMTSVT="P"&(GMTSVAL?1A.E) GMTSVAL=$E(GMTSVAL,1,7)
 . . W ?$P(COL,U,GMTSI+1),GMTSVAL
 . . S GMTSMET=$P(^UTILITY($J,"GMRVD",GMTSDT,GMTSVT,+IEN),U,13,17)
 . . S GMTSLMIN=$P(GMTSMET,U,3),GMTSPERC=$P(GMTSMET,U,4)
 . . S GMTSQUAL=$P(GMTSMET,U,5) S:GMTSQUAL]"" GMTSQUAL=$E(GMTSQUAL,1,15)
 . . S GMTSBMI=$P(GMTSMET,U,2),GMTSMET=$P(GMTSMET,U,1)
 . . I GMTSMET'="" W "("_GMTSMET_")" ;   centigrade/kilos/centimeters
 . . I GMTSBMI'="" W "["_GMTSBMI_"]" ;   body mass index
 . . I GMTSLMIN'=""!(GMTSPERC'="") W "["_GMTSLMIN_"]["_GMTSPERC_"]" ; [liters/min supplemental O2][% supplemental O2]
 . . I GMTSVT="CG",GMTSQUAL]"" W "["_GMTSQUAL_"]" ;   qualifiers
 . . Q
 . Q
 Q
NXTROW ; Get the Next Row of Vital Signs
 Q:$G(ROW)'>0  K HDR S %X="HDR1(ROW,",%Y="HDR(" D %XY^%RCR
 S COL=COL(ROW) K %X,%Y
 Q
