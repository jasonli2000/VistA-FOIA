GMTSDGCH ; SLC/KER/NDBI - Extended ADT Hist ; 09/21/2001
 ;;2.7;Health Summary;**28,35,47**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA    17  ^DGPM("APCA"
 ;    DBIA    17  ^DGPM("ATID1"
 ;    DBIA    17  ^DGPM("ATS"
 ;    DBIA 10035  ^DPT( fields .01,2,3 Read w/Fileman
 ;    DBIA  2929  DSP^A7RHSM (NDBI)
 ;    DBIA  2929  LST^A7RHSM (NDBI)
 ;    DBIA 10015  EN^DIQ1 (file #2)
 ;    DBIA 10061  ELIG^VADPT
 ;    DBIA 10061  IN5^VADPT
 ;    DBIA 10061  KVAR^VADPT
 ;
MAIN ; Loop through admissions starting from most recent
 N FLAG,IN,IM,ADA,ADM,MDA,MDM,X,DOC,CNTR,CODE,TYPE,TT,SPEC,ITS,TS,TSDM,TSDA,VAHOW,VA200,GMC,GMMDA,PTF K VAIP
 S CNTR=$S(+($G(GMTSNDM))>0:GMTSNDM,1:100),VA200=1,VAHOW=1,FLAG=-1,ADM=GMTS1,GMC=0
 D DISAB,FADM
 D:$$ROK^GMTSU("A7RHSM")&($$NDBI^GMTSU) LST^A7RHSM(DFN,.A7RHS)
 F  S ADM=$O(^DGPM("ATID1",DFN,ADM)) D:$$ROK^GMTSU("A7RHSM")&($$NDBI^GMTSU) DSP^A7RHSM(ADM) Q:('ADM)!(ADM>GMTS2)!(CNTR=0)!('DFN)  D
 . S GMC=0 D MVTS I GMC>0 D
 . . D ICDP^GMTSDGC2(DFN,+($G(PTF))),ICDS^GMTSDGC2(DFN,+($G(PTF)))
 D KVAR^VADPT K ^UTILITY($J)
 K A7RHS
 Q
MVTS ; Loop through mvts chronologically, per admission
 S ADA=0,ADA=$O(^DGPM("ATID1",DFN,ADM,ADA)) Q:'ADA
 N VAIP,PREVDR,PREVSP,PREVAP,PREVWD
 K ^UTILITY($J)
 S (VAIP("E"),GMMDA)=ADA D IN5^VADPT
 I $D(VAIP) D CKP^GMTSUP Q:$D(GMTSQIT)  W:FLAG>0 ! D PRNT
 D SETUTL
 S MDM=""
 F  S MDM=$O(^UTILITY($J,"GMTSMVTS",MDM)) Q:'MDM  D GET
 S CNTR=CNTR-1
 K ^UTILITY($J)
 Q
GET ; D IN5^VADPT for each mvt, print info
 I ^UTILITY($J,"GMTSMVTS",MDM)=ADA Q
 K VAIP
 S (VAIP("E"),GMMDA)=^UTILITY($J,"GMTSMVTS",MDM) D IN5^VADPT
 I $D(VAIP) D PRNT
 Q
PRNT ; output line of data
 S X=+$P(VAIP("MD"),U) D REGDTM4^GMTSU
 D CKP^GMTSUP Q:$D(GMTSQIT)
 N DOC,TYPE,CODE,SPEC,ATTN,WARD
 S DOC=$E($P($G(VAIP("DR")),U,2),1,30),TYPE=$P($G(VAIP("MT")),U,2)
 S CODE=+$P($G(VAIP("TT")),U),SPEC=$P(VAIP(("TS")),U,2)
 S PTF=+$G(VAIP("PT"))
 S TT=$S(CODE=0:"NON",CODE=1:"ADM",CODE=2:"TR ",CODE=3:"DC ",CODE=4:"CIL",CODE=5:"COL",CODE=6:"TS ",1:"   ")
 S GMC=1
 W X,?18,TT,?23,$E(TYPE,1,56),!
 I $G(DOC)'=$G(PREVDR)!($G(SPEC)'=$G(PREVSP)) D
 . N AWS S AWS="Provider/Specialty: "_DOC
 . W ?3,AWS,?56,SPEC,!
 . S PREVDR=$G(DOC),PREVSP=$G(SPEC)
 S ATTN=$P($G(VAIP("AP")),"^",2)
 S WARD=$P($G(VAIP("WL")),"^",2)
 I $L(ATTN),($G(ATTN)'=$G(PREVAP)!($G(WARD)'=$G(PREVWD))) D
 . S AWS="Attending/Ward: "_ATTN
 . W ?7,AWS,?56,WARD,!
 . S PREVAP=$G(ATTN),PREVWD=$G(WARD)
 D OTHER^GMTSDGC1(DFN,PTF,CODE,.VAIP,$G(GMMDA))
 S FLAG=2
 Q
SETUTL ; Set ^UTILITY array
 S (TSDM,MDM)=0
 F  S TSDM=$O(^DGPM("ATS",DFN,ADA,TSDM)) Q:'TSDM  D NEXT1
 F  S MDM=$O(^DGPM("APCA",DFN,ADA,MDM)) Q:'MDM  D NEXT2
 Q
NEXT1 ; Next ^UTILITY($J,"GMTSMVTS",<inverse date>) - "ATS"
 S TS="",TS=$O(^DGPM("ATS",DFN,ADA,TSDM,TS)) Q:'TS
 S TSDA=0,TSDA=$O(^DGPM("ATS",DFN,ADA,TSDM,TS,TSDA)) Q:'TSDA
 S ^UTILITY($J,"GMTSMVTS",9999999-TSDM)=TSDA
 Q
NEXT2 ; Next ^UTILITY($J,"GMTSMVTS",<date>)  - "APCA"
 S MDA=0,MDA=$O(^DGPM("APCA",DFN,ADA,MDM,MDA)) Q:'MDA
 I MDA'=ADA S ^UTILITY($J,"GMTSMVTS",MDM)=MDA
 Q
DISAB ; Disability Display
 N GMW,GMTSI,VA,VADM,VAEL,VAERR,VAPA
 D ELIG^VADPT I +$G(VAEL("EL")) D
 . S FLAG=2
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W "Eligibility: ",$E($P(VAEL("EL"),U,2),1,40)
 . W:VAEL("ES")]"" ?56,$P(VAEL("ES"),U,2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W:+VAEL("SC") !,"Total S/C %: ",$P(VAEL("SC"),U,2)
 . I '$D(^DPT(DFN,.372)) D  Q
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"   No rated disabilities"
 . S GMTSI=0
 . F  S GMTSI=$O(^DPT(DFN,.372,GMTSI)) Q:GMTSI'>0  D
 . . N DA,DIQ,DR,DIC,GMTSDIS
 . . S DIC="^DPT("_DFN_",.372,",DA=GMTSI,DR=".01;2;3",DIQ="GMTSDIS",DIQ(0)="E"
 . . D EN^DIQ1
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W !?3,GMTSDIS(2.04,DA,.01,"E"),?51,$J(GMTSDIS(2.04,DA,2,"E"),3),"%",?60,$S(GMTSDIS(2.04,DA,3,"E")="YES":"S/C",1:"NSC")
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
FADM ; Future Admissions
 N GMDT,NODE,X
 K ^TMP("GMFADM",$J)
 D GETFADM^GMTSDGA2
 Q:'$D(^TMP("GMFADM",$J))
 S GMDT=0
 F  S GMDT=$O(^TMP("GMFADM",$J,GMDT)) Q:GMDT'>0  D
 . S NODE=$G(^TMP("GMFADM",$J,GMDT))
 . S X=$P(NODE,U) D REGDT4^GMTSU
 . I FLAG>0 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . E  S FLAG=2
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W X,?16,"Scheduled Admission",?56,$E($P(NODE,U,5),1,12),?69,$E($P(NODE,U,3),1,10),!
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I $P(NODE,U,2)]"" W ?11,"Adm. Diag.: ",$P(NODE,U,2)
 . I $P(NODE,U,6)>0 W ?56,"Expected LOS: ",$P(NODE,U,6),!
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I $P(NODE,U,4)]"" W ?14,"Surgery: ",$P(NODE,U,4),!
 K ^TMP("GMFADM",$J)
 Q
