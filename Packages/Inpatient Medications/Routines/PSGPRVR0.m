PSGPRVR0 ;BIR/CML3-PRINT COST PER PROVIDER REPORT ;31 OCT 95 / 2:04 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
START ;
 D NOW^%DTC S PSGDT=%,PSGPDT=$$ENDTC^PSGMI(PSGDT),CML=IO'=IO(0)!(IOST'["C-"),(DRG,NP,LN1,LN2,PR)="",$P(LN1,"-",81)="",$P(LN2,"=",81)="",(PG,TCNT,TCST)=0
 U IO I '$D(^TMP("PSG",$J)) D HDR W !!?22,"*** NO PROVIDER COST DATA FOUND ***" G DONE
 ;
RUN ;
 I 'PSGPRVRP D HDR
 F  D:PR]"" PTOT G:NP["^" DONE S PR=$O(^TMP("PSG",$J,PR)) Q:PR=""  D:PSGPRVRP NP W !?1,PR S (PCNT,PCST)=0 F Q=0:0 S DRG=$O(^TMP("PSG",$J,PR,DRG)) Q:DRG=""  S CST=^(DRG),NF=$P(CST,U,3) D DRGP I NP["^" G DONE
 ;
TOTLS ;
 S PR=$S(PSGPRVRP:1,1:$Y+8>IOSL) D:PR NP I NP'["^" S TCPU=$S(TCNT:TCST/TCNT,1:0) S:TCST<0&(TCPU>0) TCPU=-TCPU W !!,LN2,!!?5,"TOTALS =>",?17,"AVG. COST/UNIT: ",$J(TCPU,0,2),?52,$J(TCNT,9,0),?67,$J(TCST,12,2)
 W !!!?34,"*** DONE ***" I 'PR,NP'["^",CML F X=$Y:1:IOSL-4 W !
 I  W !?54,"(** = NON-FORMULARY ITEM)"
 ;
DONE ;
 W:CML&($Y) @IOF,@IOF K %,CML,CNT,CPU,CST,LN1,LN2,NP,PCNT,PCPU,PCST,PSGID,PSGOD,PSGPDT,SN,TCNT,TCPU,TCST Q
 ;
PTOT ;
 I $Y+5>IOSL D NP Q:NP["^"  W !?1,PR,"  (cont.)"
 S TCNT=TCNT+PCNT,TCST=TCST+PCST,PCPU=$S(PCNT:PCST/PCNT,1:0) S:PCST<0&(PCPU>0) PCPU=-PCPU W ?52,"---------",?67,"------------",!?1,"-----  AVG. COST/UNIT: ",$J(PCPU,0,2),?52,$J(PCNT,9,0),?67,$J(PCST,12,2) W:'PSGPRVRP !! Q
 ;
DRGP ;
 I $Y+4>IOSL D NP Q:NP["^"  W !?1,PR,"  (cont.)"
 S CNT=+CST,CST=$P(CST,"^",2),PCNT=PCNT+CNT,PCST=PCST+CST
 W !?4,$S('NF:"  ",1:"**")," ",$S(DRG'="zz":$P(DRG,"^"),1:"*** DRUG NOT FOUND ***"),?52,$J(CNT,9,0),?67,$J(CST,12,2),!
 Q
 ;
NP ;
 I PG,PR]"",'CML W $C(7) R !,"'^' TO STOP ",NP:DTIME W:'$T $C(7) S:'$T NP="^" Q:NP["^"
 I PG,PR]"",CML F X=$Y:1:IOSL-4 W !
 I  W !?54,"(** = NON-FORMULARY ITEM)"
 ;
HDR ;
 S PG=PG+1 W:$Y @IOF W !!?1,PSGPDT,?24,"UNIT DOSE COST PER PROVIDER REPORT",?73-$L(PG),"Page: ",PG,!?28,"FROM ",STRT," TO ",STOP,!!?1,"PROVIDER",?52,"TOTAL UNITS",?72,"TOTAL",!?10,"DRUG",?53,"DISPENSED",?72,"COST",!,LN1,! Q