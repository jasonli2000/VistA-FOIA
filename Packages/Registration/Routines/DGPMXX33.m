DGPMXX3 ; COMPILED XREF FOR FILE #405 ; 01/17/95
 ; 
 I X'="" S ^DGPM("APHY",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,27)
 I X'="" S ^DGPM("AVISIT",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,27)
 I X'="" S:$P(^DGPM(DA,0),U,3) ^DGPM("AVST",$P(^DGPM(DA,0),U,3),X,DA)=""
 S DIKZ("ODS")=$S($D(^DGPM(DA,"ODS"))#2:^("ODS"),1:"")
 S X=$P(DIKZ("ODS"),U,2)
 I X'="" S A1B2TAG="ADM" D ^A1B2XFR
 S X=$P(DIKZ("ODS"),U,4)
 I X'="" S ^DGPM("AODSA",$E(X,1,30),DA)=""
 S X=$P(DIKZ("ODS"),U,6)
 I X'="" S A1B2TAG="ADM" D ^A1B2XFR
 S X=$P(DIKZ("ODS"),U,7)
 I X'="" S ^DGPM("AODSD",$E(X,1,30),DA)=""
END Q
