PSGWDUP1 ;BHAM ISC/KKA-Report for Duplicate Entries in ITEM subfile-CONTINUED ; 17 Aug 93 / 10:58 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
ENTRY ;** entry point when queued **
 S (PAGE,OUT)=0
 S CONT="********** CONTINUED **********",CONTLTH=(132-$L(CONT))/2
 S CNT=1 F  Q:'$P(PSGWDRP,",",CNT)!(OUT)  S PSGWDRCT=$P(PSGWDRP,",",CNT),CNT=CNT+1 D ONE
 I $E(IOST)'="P",'OUT W !!,"Press RETURN to continue: " R CONT:DTIME
END W !,@IOF
 K CNT,CNT3,CONT,CONTLTH,I,OUT,PAGE,PSGWAOU,PSGWDRCT,PSGWDRG,PSGWDRP,PSGWINND,PSGWINV,PSGWITM,PSGWND,PSGWNOD,PSGWNXT,PSGWOD,PSGWODND,PSGWRET,PSGWRR,PSGWRTND,PSGWVAL,PSGWY,X,Y
 Q
ONE ;** display information for one drug **
 F PSGWNXT=0:0 S PSGWNXT=$O(^TMP("PSGW",$J,PSGWDRCT,PSGWNXT)) Q:'PSGWNXT!(OUT)  S PSGWND=^(PSGWNXT) D
 .S PSGWAOU=$P(PSGWND,"^"),PSGWITM=$P(PSGWND,"^",2),PSGWDRG=$P(PSGWND,"^",3)
 .D PAGE
 .D INV,RET:'OUT,OD:'OUT
 Q
INV ;** display inventory data **
 I '$O(^PSI(58.1,PSGWAOU,1,PSGWITM,1,0)) W !,"INVENTORIES:",!,?10,"No inventories shown" Q
 D INVHEAD
 F PSGWINV=0:0 S PSGWINV=$O(^PSI(58.1,PSGWAOU,1,PSGWITM,1,PSGWINV)) Q:'PSGWINV!(OUT)  D
 .I $Y+6>IOSL D PAGE Q:OUT  W !,?CONTLTH,CONT D INVHEAD
 .S PSGWINND=$G(^PSI(58.1,PSGWAOU,1,PSGWITM,1,PSGWINV,0))
 .I PSGWINND]"" S Y=$P($G(^PSI(58.19,+$P(PSGWINND,"^"),0)),"^") X ^DD("DD") W !,?10,Y,?35,$S($P(PSGWINND,"^",4)=1:"YES",1:"NO"),?47,$P(PSGWINND,"^",5),?62,$P(PSGWINND,"^",6)
 Q
INVHEAD ;** header for inventory data **
 W !,"INVENTORIES: "
 W !!,?10,"DATE/TIME",?33,"COMPILED",?60,!,?13,"FOR",?35,"INTO",?45,"DISPENSE",!,?10,"INVENTORY",?35,"AMIS",?45,"QUANTITY",?60,"ON HAND",!
 W ?10 F I=1:1:122 W "-"
 Q
RET ;** display return data **
 I $Y+6>IOSL D PAGE Q:OUT  W !,?CONTLTH,CONT
 I '$O(^PSI(58.1,PSGWAOU,1,PSGWITM,3,0)) W !!,"RETURNS:",!,?10,"No returns shown" Q
 D RETHEAD
 F PSGWRET=0:0 S PSGWRET=$O(^PSI(58.1,PSGWAOU,1,PSGWITM,3,PSGWRET)) Q:'PSGWRET!(OUT)  D
 .I $Y+6>IOSL D PAGE Q:OUT  W !,?CONTLTH,CONT D RETHEAD
 .S PSGWRTND=$G(^PSI(58.1,PSGWAOU,1,PSGWITM,3,PSGWRET,0))
 .I PSGWRTND]"" S Y=$P(PSGWRTND,"^") X ^DD("DD") W !,?10,Y,?27,$P(PSGWRTND,"^",2),?37,$S($P(PSGWRTND,"^",4)=1:"YES",1:"NO")
 .F PSGWRR=0:0 S PSGWRR=$O(^PSI(58.1,PSGWAOU,1,PSGWITM,3,PSGWRET,1,PSGWRR)) Q:'PSGWRR  S Y=$P(^(PSGWRR,0),"^"),C=$P(^DD(58.152,.01,0),"^",2) D Y^DIQ W ?50,Y,!
 Q
RETHEAD ;** header for return data **
 W !!,"RETURNS: "
 W !!,?35,"COMPILED",!,?10,"DATE OF",?25,"RETURN",?37,"INTO",?50,"RETURN",!,?10,"RETURN",?25,"QUANTITY",?37,"AMIS",?50,"REASON(S)",!
 W ?10 F I=1:1:122 W "-"
 Q
OD ;** display on-demand data **
 I $Y+6>IOSL D PAGE Q:OUT  W !,?CONTLTH,CONT
 I '$O(^PSI(58.1,PSGWAOU,1,PSGWITM,5,0)) W !!,"ON-DEMANDS: ",!,?10,"No on-demands shown" Q
 D ODHEAD
 F PSGWOD=0:0 S PSGWOD=$O(^PSI(58.1,PSGWAOU,1,PSGWITM,5,PSGWOD)) Q:'PSGWOD!(OUT)  D
 .I $Y+6>IOSL D PAGE Q:OUT  W !,?CONTLTH,CONT D ODHEAD
 .S PSGWODND=$G(^PSI(58.1,PSGWAOU,1,PSGWITM,5,PSGWOD,0)) I PSGWODND S Y=$P(PSGWODND,"^") X ^DD("DD") W !,?10,Y,?30,$P(PSGWODND,"^",2),?50,$S($P(PSGWODND,"^",3):$P($G(^VA(200,$P(PSGWODND,"^",3),0)),"^"),1:"")
 .I PSGWODND]"" W ?72,$S($P(PSGWODND,"^",4)=1:"YES",1:"NO"),?85,$S($P(PSGWODND,"^",5):$P($G(^VA(200,+$P(PSGWODND,"^",5),0)),"^"),1:"") S Y=$P(PSGWODND,"^",6) X ^DD("DD") W ?105,Y
 Q
ODHEAD ;** header for on-demand data **
 W !!,"ON-DEMANDS:"
 W !!,?70,"COMPILED",!,?10,"DATE/TIME",?30,"QUANTITY",?72,"INTO",?105,"DATE/TIME",!,?10,"FOR ON-DEMAND",?30,"DISPENSED",?50,"ENTERED BY",?72,"AMIS",?85,"EDITED BY",?105,"LAST EDITED"
 W !,?10 F I=1:1:122 W "-"
 Q
PAGE ;** header for page **
 I PAGE>0,($E(IOST)'="P") W !!,"Press RETURN to continue or ""^"" to quit: " R CONT:DTIME S:CONT["^" OUT=1 Q:'$T!(OUT)
 S PAGE=PAGE+1
 W:$Y @IOF S X="*** DUPLICATE ENTRY REPORT ***" W !!,?(132-$L(X))/2,X,!!,"DRUG: ",$P($G(^PSDRUG(PSGWDRG,0)),"^"),?115,"PAGE ",PAGE
 W !!!,"AOU:  ",$P($G(^PSI(58.1,PSGWAOU,0)),"^"),!,"Internal Entry #: ",PSGWITM,!,"Pointer in file 50: ",PSGWDRG,!
 F I=1:1:132 W "-"
