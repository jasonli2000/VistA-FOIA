PRSTUTL ; HISC/REL/FPT - Utilities ;1/16/92  14:30
 ;;3.5;PAID;;Jan 26, 1995
PICK ; Select T&L from among those allowed
 K DIC S OTL=0 I PRSTLV>3 G P1
 S TLIEN=$O(^PRST(455.5,"AT",DUZ,0)) Q:TLIEN<1
 I $O(^PRST(455.5,"AT",DUZ,TLIEN))<1 S OTL=1 G P2
 S DIC("S")="I $D(^PRST(455.5,+Y,""T"",DUZ))"
P1 S DIC="^PRST(455.5,",DIC(0)="AEQM" W ! D ^DIC I "^"[X S TLIEN=0 K DIC Q
 G:Y<1 P1 S TLIEN=+Y K DIC
P2 S TLMETH=$S(PRSTLV>3:0,1:$P(^PRST(455.5,TLIEN,"T",DUZ,0),"^",2)) Q
CODES ; Set variables T0 and T1 with 8B code list
 S T0="AN SK WD NO AU RT CE CU UN NA NB SP DA SA SB SC OA OB OC OK DB OM RA RB RC HA HB HC HD PT PA ON VC EA EB AL SL WP NP AB RL",N1=53
 S T1="CT CO US NR NS DC TF SE SF SG OE OF OG OS TA OU RE RF RG HL HM HN HO PH PB CL VS EC ED NL DW IN TL LU LN LD TO LA ML CA PC TC CY RR SQ FF DE DF YA DG TG YD YE TB DT YH TD",N2=57 Q
DECHG ; Change method of Timekeeper data entry
 D PICK G:TLIEN<1 EX G:'$D(^PRST(455.5,TLIEN,"T",0)) EX K DIE,DIC
 S DIC="^PRST(455.5,TLIEN,""T"",",Y=DUZ
 I PRSTLV>3 S DIC(0)="AEQM" W ! D ^DIC G:Y<1 EX
 S DIE=DIC,DA=+Y,DA(1)=TLIEN,DR=1 W ! D ^DIE
EX K DIC,DIE,DZ,Y,DR,DA,OTL,TLIEN,TLMETH,X,Y,%,%H,D,D0,DI,DISYS,DQ,I,Y,Z Q
