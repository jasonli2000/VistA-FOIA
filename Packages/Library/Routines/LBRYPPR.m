LBRYPPR ;ISC2/DJM-PREDICTION PATTERN ROUTINE ;[ 09/03/98  3:03 PM ]
 ;;2.5;Library;**2,6**;Mar 11, 1996
 ;
START K LBRYEF1 S LBRYPP=$P(^LBRY(680.5,LBRYCLS,0),U,3) Q:LBRYPP=""  S LBNM=""
 I +LBRYPP'=LBRYPP!(LBRYPP<1) Q  ;COULD NOT RESOLVE PREDICTION PATTERN, PLEASE INSERT
 S LBA1=""
LDT S LBA1=$O(^LBRY(682,"A1",LBRYLOC,LBA1)) Q:LBA1'>0
 S LBJD=""
LBJ S LBJD=$O(^LBRY(682,"A1",LBRYLOC,LBA1,LBJD)) G LDT:LBJD=""
 S LBJD=$G(^LBRY(682,LBJD,1)) I $P(LBJD,U,8)="P" S LBJDT=$P(LBJD,U)
 I $G(LBJDT)="" G LBJ
GET S LBNM="",LBRYPP0=^LBRY(680.9,LBRYPP,0),LBRYPP3=$G(^LBRY(680.9,LBRYPP,3))
 S LBRYPP2=$G(^LBRY(680.9,LBRYPP,2))
BEGIN S X1=DT,X2=LBJDT
 S PUD=$S($P(^LBRY(680,LBRYLOC,0),U,3)'="":$P(^(0),U,3),1:5)
 D ^%DTC Q:X+PUD<0
 S LBJDY=+$E(LBJDT,1,3),LBJDM=+$E(LBJDT,4,5),LBJDD=+$E(LBJDT,6,7)
 S LBX=+LBJDM,LBY=$P(LBRYPP0,U,3) I LBX="" G ERROR1
 D FIND G:LBZ>0 TYPE
 S LBRYEF1=1
 Q
TYPE S LBMOZ=LBZ G:$P(LBRYPP0,U,5)]"" DOM
 G:$P(LBRYPP3,U)]"" DOW G:$P(LBRYPP0,U,4)]"" ADDED
 D NEXT S LBNM=1 I $P(LBN,U,2)]"" S LBJDY=LBJDY+1
 S LBN=+LBN S:$L(LBN)=1 LBN="0"_LBN S LBJDT=LBJDY_LBN_"00"
 G ^LBRYPPR0
DOM S EM=LBJDM D EOM G:LBJDD=LBEM NXT S LBX=+LBJDD,LBY=$P(LBRYPP0,U,5)
 I LBX="" G ERROR2
 D FIND G:LBZ<1 DOM1 D NEXT G:$P(LBN,U,2)]"" NXT0 S LBJDD=LBN
DOMA I LBEM<LBJDD S LBJDD=LBEM G TYPE1
 S LBJDD=LBN G TYPE1
TYPE1 S:$L(LBJDD)=1 LBJDD="0"_LBJDD S:$L(LBJDM)=1 LBJDM="0"_LBJDM
 S LBJDT=LBJDY_LBJDM_LBJDD
 G ^LBRYPPR0
NXT0 S LBY=$P(LBRYPP0,U,3),LBZ=LBMOZ
NXT D NEXT S:$P(LBN,U,2)]"" LBJDY=LBJDY+1 S (LBJDM,EM)=+LBN,LBNM=1
 S LBJDD=$P($P(LBRYPP0,U,5),",",2) D EOM G:LBJDD'>LBEM TYPE1
 S LBJDD=LBEM
 G TYPE1
DOM1 S LBDOM=$P(LBRYPP0,U,5)
 F I=2:1 S LBN=$P(LBDOM,",",I) G:LBN="" NXT0 G:LBN>LBJDD DOMA
DOW G:LBJDD=0 ERROR3 S X=LBJDT D DW^%DTC
 S YY=LBJDD\7,YY=$S(LBJDD#7=0:YY,1:YY+1),LBX=YY_"/"_Y
 S LBY=$P(LBRYPP3,U),EM=LBJDM D EOM,FIND S LBWKZ=LBZ G:LBZ<1 DOWA
DOW1 D NEXT D:$P(LBN,U,2)]"" NEWWK D CONV G:LBJDD'>LBEM TYPE1
 G:$P($P(LBRYPP3,U),",",3)]"" NEWM S LBJDD=LBJDD-7 G TYPE1
 Q
FIND F I=2:1 S LBY1=$P(LBY,",",I) G:LBY1="" EXIT I LBX=LBY1 S LBZ=I K I,LBY1 Q
 Q
EXIT S LBZ="-1" K I,LBY1 Q
NEXT K LBN S LBN=$P(LBY,",",LBZ+1),LBZ=LBZ+1 Q:LBN]""  S LBZ=2,LBN=$P(LBY,",",LBZ),$P(LBN,U,2)=1 Q
EOM ; sets LBEM equal to number of days in the month
 ; requires EM=month and LBJDY=FMan 3 digit year
 ;
 N LBRTEMP
 ; LBRTEMP used to store the days of the month
 S LBRTEMP="31^28^31^30^31^30^31^31^30^31^30^31"
 ; extract months' total number of days
 S LBEM=$P(LBRTEMP,U,EM)
EM2 ; if the month is February, check for leap years and centuries
 I EM=2 D
 . N YR
 . S YR=LBJDY+1700
 . I (((YR#4=0)&(YR#100'=0))!((YR#100=0)&(YR#400=0))) S LBEM=29
 K EM
 Q
NEWWK S NXTWK=LBN,LBY=$P(LBRYPP0,U,3),LBZ=LBMOZ D NEXT S:$P(LBN,U,2)]"" LBJDY=LBJDY+1 S (LBJDM,EM)=+LBN,LBNM=1,LBN=NXTWK D EOM Q
CONV S:$L(LBJDM)=1 LBJDM="0"_LBJDM
 S LBN=$P(LBN,U),X=LBJDY_LBJDM_"01" D DW^%DTC
 S FM=Y,LBRDOW=$P(LBN,"/",2)
 I FM=LBRDOW S LBJDD=1 G ADD
 I LBRDOW>FM S LBJDD=LBRDOW-FM+1 G ADD
 S LBJDD=8+LBRDOW-FM
ADD S WOM=$P(LBN,"/",1),LBJDD=LBJDD+(WOM-1*7) Q
NEWM D NEWWK S LBY=$P(LBRYPP3,U),LBZ=1 D NEXT,CONV G TYPE1
DOWA S LBXA=$P(LBX,"/",1),LBXB=$P(LBX,"/",2) K LBZ
 F I=2:1 S LBY1=$P(LBY,",",I) G:LBY1="" ERROR4
 S LBYA=$P(LBY1,"/",1),LBYB=$P(LBY1,"/",2) D DOWX G:$D(LBZ) DOW1
DOWX I LBYA=LBXA,LBYB=LBXB S LBZ=I Q
 I LBYA>LBXA S LBZ=I Q
 Q
EF1 S Y=LBJDT X ^DD("DD")
 W !!,"The last Journal Date, ",Y,", is not found in the PREDICTION PATTERN"
 W !,"for this title.  "
 W "Use (E)dit to change the JOURNAL DATE to a valid month"
 W !,"or change the ENTRY TYPE to INSERT." S XZ="CONTINUE//" D PAUSE^LBRYUTL
 Q
ADDED S X1=LBJDT,X2=$P(LBRYPP0,U,4) D C^%DTC
 S:$E(LBJDT,4,5)'=$E(X,4,5) LBNM=1 S LBJDT=X
 G ^LBRYPPR0
ERROR1 Q
ERROR2 Q
ERROR3 Q
ERROR4 Q
