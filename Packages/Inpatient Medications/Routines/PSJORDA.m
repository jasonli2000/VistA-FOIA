PSJORDA ;BIR/LC BUILD DETAILED ALLERGY LIST- ;16 DEC 97 / 1:42 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
BEG ;
 NEW PSJINPT S PSJINPT=1 D BEG^PSOORDA(DFN)
 Q
SEL ;select allergy for detail display
 N ORD,ORN,IEN,VALMCNT I '$G(PSJALL) S VALMSG="This patient has no Allergies!" S VALMBCK="" Q
 K DIR,DUOUT,DIRUT S DIR("A")="Select Allergies by number",DIR(0)="LO^1:"_PSJALL D ^DIR I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
 K DIR,DIRUT,DTOUT,DTOUT I +Y D FULL^VALM1 S ALST=Y D
 .F ORD=1:1:$L(ALST,",") Q:$P(ALST,",",ORD)']""  S ORN=$P(ALST,",",ORD) D DSPLY
 E  S VALMBCK=""
 K ALST
 Q
DSPLY ;build detailed allergy display
 NEW PSJINPT S PSJINPT=1 D DSPLY^PSOORDA(DFN),EN^PSJLMAL
 Q
EXT K AGNL,CG,CLS,CPT,IG,ING,IPT,NB,OD,ODT,OG,ORC,ORT,SG,SNM,SYM,Y
 Q
NEWSEL ;
 N ORD,ORN,IEN,VALMCNT I '$G(PSJALL) S VALMSG="This patient has no Allergies!" S VALMBCK="" Q
 S ALST=$P(XQORNOD(0),"=",2)
 I '$O(AGN(0)) S VALMQUIT=1 Q
 I $D(ALST) D FULL^VALM1 D
 .F ORD=1:1:$L(ALST,",") Q:$P(ALST,",",ORD)']""  S ORN=$P(ALST,",",ORD) D DSPLY
 E  S VALMBCK=""
 K ALST
 G EXT
 Q
