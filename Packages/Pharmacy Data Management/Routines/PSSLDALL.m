PSSLDALL        ;BIR/RTR-Find all Local Possible Dosage to edit ;05/04/08
        ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
        ;
        ;Reference to 50.607 supported by DBIA 2221
EN      ;
        W !!,"This option will find all Local Possible Dosages that are eligible for Dosage"
        W !,"Checks that do not have either the Numeric Dosage or Dose Unit entered for the"
        W !,"Local Possible Dosage. This mapping is necessary to perform Dosage checks."
        W !!,"Searching for local Possible Dosages..."
        N DIRUT,DIROUT,DIC,DTOUT,DUOUT,X,Y,DIE,DA,DR,PSSGVNMX,PSSGVIEN,PSSGVTOT,PSSGVLPX,PSSGVLC1,PSSGVLC2,PSSGVOUT,PSSGVZR,PSSGVND1,PSSGVND3
        N PSSGVOK,PSSGVNDF,PSSGVDF,PSSGVSTN,PSSGVUNT,PSSGVUNX,PSSGVSXX,PSSGVSZZ,PSSGVFLG,PSSGVGG1,PSSGVGG2,PSSGVGG3,PSSGVGG4,PSSGVCNT,PSSGVLP
        N PSSGVLOC,PSSGVGG5,PSSGVGG6,PSSGVLCX,PSSGVBF6,PSSGVAF6,DIR,DIDEL
        K PSSGVNMX,PSSGVIEN,PSSGVTOT,PSSGVOUT
        S (PSSGVOUT,PSSGVTOT)=0
        S PSSGVNMX="" F  S PSSGVNMX=$O(^PSDRUG("B",PSSGVNMX)) Q:PSSGVNMX=""!(PSSGVOUT)  F PSSGVIEN=0:0 S PSSGVIEN=$O(^PSDRUG("B",PSSGVNMX,PSSGVIEN)) Q:'PSSGVIEN!(PSSGVOUT)  D
        .K PSSGVZR,PSSGVND1,PSSGVND3,PSSGVOK,PSSGVNDF,PSSGVDF,PSSGVLC2,PSSGVLPX,PSSGVLC1,PSSGVSTN,PSSGVUNT,PSSGVUNX,PSSGVSXX,PSSGVSZZ,PSSGVFLG
        .K PSSGVGG1,PSSGVGG2,PSSGVGG3,PSSGVGG4,PSSGVCNT,PSSGVLP,PSSGVLOC,PSSGVGG5,PSSGVGG6,PSSGVLCX,PSSGVBF6,PSSGVAF6
        .S PSSGVZR=$G(^PSDRUG(PSSGVIEN,0)),PSSGVND1=$P($G(^PSDRUG(PSSGVIEN,"ND")),"^"),PSSGVND3=$P($G(^PSDRUG(PSSGVIEN,"ND")),"^",3)
        .S PSSGVTOT=PSSGVTOT+1 I '(PSSGVTOT#20) W "."
        .S PSSGVOK=$$TEST
        .Q:'PSSGVOK
        .S PSSGVLC2=0 F PSSGVLPX=0:0 S PSSGVLPX=$O(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLPX)) Q:'PSSGVLPX!(PSSGVLC2)  S PSSGVLC1=$G(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLPX,0)) I $P(PSSGVLC1,"^")'="" I '$P(PSSGVLC1,"^",5)!($P(PSSGVLC1,"^",6)="") S PSSGVLC2=1
        .Q:'PSSGVLC2
        .W !!!?5,"Drug: "_$P(PSSGVZR,"^")
        .S PSSGVSTN=$P($G(^PSDRUG(PSSGVIEN,"DOS")),"^"),PSSGVUNT=$P($G(^PSDRUG(PSSGVIEN,"DOS")),"^",2)
        .S PSSGVUNX=$S($G(PSSGVUNT):$P($G(^PS(50.607,+$G(PSSGVUNT),0)),"^"),$P($G(PSSGVNDF),"^",6)'="":$P($G(PSSGVNDF),"^",6),1:"")
        .L +^PSDRUG(PSSGVIEN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !!,"Another person is editing "_$P(PSSGVZR,"^"),! D  Q
        ..K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSGVOUT=1
        .I PSSGVND1,PSSGVND3 S PSSGVSXX=$P(PSSGVNDF,"^",4),PSSGVSZZ=$P(PSSGVNDF,"^",6)
        .I PSSGVSTN'="",$E($G(PSSGVSTN),1)="." S PSSGVSTN="0"_PSSGVSTN
        .I $G(PSSGVSXX)'="",$E($G(PSSGVSXX),1)="." S PSSGVSXX="0"_PSSGVSXX
        .S PSSGVFLG=0
        .I $G(PSSGVSXX)'="",($G(PSSGVSTN)'="") I $G(PSSGVSXX)'=$G(PSSGVSTN) D
        ..S PSSGVFLG=1
        ..S PSSGVGG1=$L($G(PSSGVSXX)),PSSGVGG2=$L($G(PSSGVUNX)),PSSGVGG3=$L($G(PSSGVSTN)),PSSGVGG4=$L($S($G(PSSGVUNX)'["/":$G(PSSGVUNX),1:""))
        ..W !!,"Strength from National Drug File match => " D
        ...I PSSGVGG1+PSSGVGG2<34 W $G(PSSGVSXX)_"   "_$G(PSSGVUNX) Q
        ...W !?3,$G(PSSGVSXX) D
        ....I PSSGVGG1+PSSGVGG2<73 W "   "_$G(PSSGVUNX) Q
        ....W !?3,$G(PSSGVUNX)
        ..W !,"Strength currently in the Drug File    => " D
        ...I PSSGVGG3+PSSGVGG4<34 W $G(PSSGVSTN)_"   "_$S($G(PSSGVUNX)'["/":$G(PSSGVUNX),1:"") Q
        ...W !?3,$G(PSSGVSTN) D
        ....I PSSGVGG3+PSSGVGG4<73 W "   "_$S($G(PSSGVUNX)'["/":$G(PSSGVUNX),1:"") Q
        ....W !?3,$S($G(PSSGVUNX)'["/":$G(PSSGVUNX),1:"")
        ..W !!,"Please Note: Strength of drug does not match strength of VA Product it is",!,"matched to."
        .S PSSGVCNT=0
        .F PSSGVLP=0:0 S PSSGVLP=$O(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLP)) Q:'PSSGVLP!(PSSGVOUT)  S PSSGVLOC=$G(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLP,0)) D:$P(PSSGVLOC,"^")'=""
        ..I $P(PSSGVLOC,"^",5),($P(PSSGVLOC,"^",6)'="") Q
        ..I 'PSSGVCNT,'PSSGVFLG I $G(PSSGVSXX)'=""!($G(PSSGVSTN)'="")!($G(PSSGVUNX)'="") D
        ...S PSSGVGG5=$L($S($G(PSSGVSTN)'="":$G(PSSGVSTN),$G(PSSGVSXX)'="":$G(PSSGVSXX),1:"")),PSSGVGG6=$L($G(PSSGVUNX))
        ...W !!,"Strength: "_$S($G(PSSGVSTN)'="":$G(PSSGVSTN),$G(PSSGVSXX)'="":$G(PSSGVSXX),1:"")
        ...I PSSGVGG5+PSSGVGG6<60 W "   Unit: "_$G(PSSGVUNX) Q
        ...W !,"Unit: "_$G(PSSGVUNX)
        ..S PSSGVCNT=1
        ..W !!!,$P(PSSGVLOC,"^") I $P(PSSGVLOC,"^",5)!($P(PSSGVLOC,"^",6)'="") D
        ...W !,"Numeric Dose: "_$S($E($P(PSSGVLOC,"^",6),1)=".":"0"_$P(PSSGVLOC,"^",6),1:$P(PSSGVLOC,"^",6))
        ...W ?37,"Dose Unit: "_$S('$P(PSSGVLOC,"^",5):"",1:$P($G(^PS(51.24,+$P(PSSGVLOC,"^",5),0)),"^"))
        ..W ! K DIE,Y,DTOUT,DR,DA,DIDEL S DA(1)=PSSGVIEN,DIE="^PSDRUG("_PSSGVIEN_",""DOS2"",",DR="4;5",DA=PSSGVLP
        ..D ^DIE K DIE,DR,DA I $D(DTOUT)!($D(Y)) D  Q:PSSGVOUT
        ...W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to continue mapping Local Possible Dosages",DIR("B")="Y",DIR("?")="Enter 'Y' to continue mapping Local Possible Dosages, enter 'N' to exit."
        ...D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($G(Y)<1) S PSSGVOUT=1
        ..S PSSGVLCX=$G(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLP,0))
        ..S PSSGVBF6=$S($E($P(PSSGVLOC,"^",6),1)=".":"0"_$P(PSSGVLOC,"^",6),1:$P(PSSGVLOC,"^",6)) S PSSGVAF6=$S($E($P(PSSGVLCX,"^",6),1)=".":"0"_$P(PSSGVLCX,"^",6),1:$P(PSSGVLCX,"^",6))
        ..I $P(PSSGVLCX,"^",5)'=$P(PSSGVLOC,"^",5)!(PSSGVBF6'=PSSGVAF6) D
        ...W !!,$P(PSSGVLCX,"^")
        ...W !,"Numeric Dose: "_$S($E($P(PSSGVLCX,"^",6),1)=".":"0"_$P(PSSGVLCX,"^",6),1:$P(PSSGVLCX,"^",6))
        ...W ?40,"Dose Unit: "_$S('$P(PSSGVLCX,"^",5):"",1:$P($G(^PS(51.24,+$P(PSSGVLCX,"^",5),0)),"^"))
        .W ! D UL
        K PSSGVOUT,PSSGVTOT,PSSGVNMX,PSSGVIEN,PSSGVZR,PSSGVND1,PSSGVND3,PSSGVOK,PSSGVLC2,PSSGVLPX,PSSGVLC1
        S (PSSGVOUT,PSSGVTOT)=0 W !!,"Checking for any remaining unmapped Local Possible Dosages..."
        S PSSGVNMX="" F  S PSSGVNMX=$O(^PSDRUG("B",PSSGVNMX)) Q:PSSGVNMX=""!(PSSGVOUT)  F PSSGVIEN=0:0 S PSSGVIEN=$O(^PSDRUG("B",PSSGVNMX,PSSGVIEN)) Q:'PSSGVIEN!(PSSGVOUT)  D
        .S PSSGVZR=$G(^PSDRUG(PSSGVIEN,0)),PSSGVND1=$P($G(^PSDRUG(PSSGVIEN,"ND")),"^"),PSSGVND3=$P($G(^PSDRUG(PSSGVIEN,"ND")),"^",3)
        .S PSSGVTOT=PSSGVTOT+1 I '(PSSGVTOT#100) W "."
        .K PSSGVDF,PSSGVNDF S PSSGVOK=$$TEST
        .Q:'PSSGVOK
        .S PSSGVLC2=0 F PSSGVLPX=0:0 S PSSGVLPX=$O(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLPX)) Q:'PSSGVLPX!(PSSGVLC2)  S PSSGVLC1=$G(^PSDRUG(PSSGVIEN,"DOS2",PSSGVLPX,0)) I $P(PSSGVLC1,"^")'="" I '$P(PSSGVLC1,"^",5)!($P(PSSGVLC1,"^",6)="") S PSSGVLC2=1
        .Q:'PSSGVLC2
        .S PSSGVOUT=1
        I 'PSSGVOUT W !!,"All Local Possible Dosages are mapped!",! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR Q
        W !!,"There are still Local Possible Dosages not yet mapped,",!,"see the 'Local Possible Dosages Report' option for more details.",!
        K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
        Q
        ;
UL      ;unlock drug
        L -^PSDRUG(PSSGVIEN)
        Q
        ;
TEST()  ;See if drug need Dose Unit and Numeric Dose defined
        I 'PSSGVND3!('PSSGVND1) Q 0
        I $P($G(^PSDRUG(PSSGVIEN,"I")),"^"),$P($G(^PSDRUG(PSSGVIEN,"I")),"^")<DT Q 0
        N PSSGVDOV
        S PSSGVDOV=""
        I PSSGVND1,PSSGVND3,$T(OVRIDE^PSNAPIS)]"" S PSSGVDOV=$$OVRIDE^PSNAPIS(PSSGVND1,PSSGVND3)
        I '$O(^PSDRUG(PSSGVIEN,"DOS2",0)) Q 0
        I $P(PSSGVZR,"^",3)["S"!($E($P(PSSGVZR,"^",2),1,2)="XA") Q 0
        I PSSGVND1,PSSGVND3 S PSSGVNDF=$$DFSU^PSNAPIS(PSSGVND1,PSSGVND3) S PSSGVDF=$P(PSSGVNDF,"^")
        I $G(PSSGVDF)'>0,$P($G(^PSDRUG(PSSGVIEN,2)),"^") S PSSGVDF=$P($G(^PS(50.7,+$P($G(^PSDRUG(PSSGVIEN,2)),"^"),0)),"^",2)
        I PSSGVDOV=""!('$G(PSSGVDF))!($P($G(^PS(50.606,+$G(PSSGVDF),1)),"^")="") Q 1
        I $P($G(^PS(50.606,+$G(PSSGVDF),1)),"^"),'PSSGVDOV Q 0
        I '$P($G(^PS(50.606,+$G(PSSGVDF),1)),"^"),PSSGVDOV Q 0
        Q 1
