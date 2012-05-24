PXRMGECN        ;SLC/JVS GEC-Score Reports-cont'd ;06/01/2007
        ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
        Q
SUM     ;By Summary by Patient
        N CAT,HF,DATE,DFN,Y,HFN,CNTREF,X,REFNUM,SUM,GSUM,CATDANA
        N DATER,SDATE,SCNT
        D E^PXRMGECV("HS1",1,BDT,EDT,"F",DFNONLY)
        I FORMAT="D" S FOR=0
        I FORMAT="F" S FOR=1
        W @IOF
        S CATDANA("GEC REFERRAL BASIC ADL")=""
        S CATDANA("GEC REFERRAL IADL")=""
        S CATDANA("GEC REFERRAL SKILLED CARE")=""
        S CATDANA("GEC REFERRAL PATIENT BEHAVIORS/SYMPTOM")=""
        ;
        S Y=1,SUM=0,DATER=0,GSUM=0
        S DFN="" F  S DFN=$O(^TMP("PXRMGEC",$J,"HS1",DFN)) Q:DFN=""!(Y=0)  D
        .S CNTREF="",REFNUM=0 F  S CNTREF=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF)) Q:CNTREF=""!(Y=0)  D
        ..S REFNUM=REFNUM+1
        ..S SDATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,0)) D
        ...S DATER=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,SDATE,0))
        ..S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE)) Q:DATE=""!(Y=0)  D
        ...S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT)) Q:VDT=""!(Y=0)  D
        ....S CAT=0 F  S CAT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT)) Q:CAT=""!(Y=0)  D
        .....Q:'$D(CATDANA(CAT))
        .....S SUM=0
        .....S DATEV=0 F  S DATEV=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV)) Q:DATEV=""!(Y=0)  D
        ......S DA=0 F  S DA=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV,DA)) Q:DA=""!(Y=0)  D
        .......S HFN=$$HFNAME^PXRMGECR(DA)
        .......S SUM=SUM+$$VALUE($P($G(^AUPNVHF(DA,0)),"^",1))
        .......S CATSUM(CAT)=SUM
        ..S GSUM=+$G(CATSUM("GEC REFERRAL IADL"))+(+$G(CATSUM("GEC REFERRAL BASIC ADL")))+(+$G(CATSUM("GEC REFERRAL SKILLED CARE")))+(+$G(CATSUM("GEC REFERRAL PATIENT BEHAVIORS/SYMPTOM")))
        ..S ^TMP("PXRMGEC",$J,"S",DFN,SDATE,DATER,+$G(CATSUM("GEC REFERRAL IADL")),+$G(CATSUM("GEC REFERRAL BASIC ADL")),+$G(CATSUM("GEC REFERRAL SKILLED CARE")),+$G(CATSUM("GEC REFERRAL PATIENT BEHAVIORS/SYMPTOM")),GSUM)=""
        ..K CATSUM
        ;
DIS     ;Start of Display
        S REF="^TMP(""PXRMGEC"",$J,""S"")"
        W !,"=============================================================================="
        W !,"GEC Patient-Summary (Score)"
        W !,"Data on Complete Referrals Only"
        W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
        W !
        I FOR W !,?33,"Finished",?49,"Basic",?55,"Skilled",?63,"Patient",?73,"TOTAL"
        I FOR W !,"Name",?22,"SSN",?33,"Date",?44,"IADL",?49,"ADL",?55,"Care",?63,"Behaviors",?73,"ACROSS"
        I 'FOR W !,"Name^SSN^Referral Date^IADL^Basic ADL^Skilled Care^Behaviors^Totals"
        W !,"=============================================================================="
        N S1,S2,S3,S4,S5,S1T,S2T,S3T,S4T,S5T
        S (S1T,S2T,S3T,S4T,S5T,CNT)=0
        S DFN="" F  S DFN=$O(@REF@(DFN)) Q:DFN=""  D
        .S SDATE="" F  S SDATE=$O(@REF@(DFN,SDATE)) Q:SDATE=""  D
        ..S DATER="" F  S DATER=$O(@REF@(DFN,SDATE,DATER)) Q:DATER=""  D
        ...S CNT=CNT+1
        ...S S1="" F  S S1=$O(@REF@(DFN,SDATE,DATER,S1)) Q:S1=""  D
        ....S S1T=S1T+S1
        ....S S2="" F  S S2=$O(@REF@(DFN,SDATE,DATER,S1,S2)) Q:S2=""  D
        .....S S2T=S2T+S2
        .....S S3="" F  S S3=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3)) Q:S3=""  D
        ......S S3T=S3T+S3
        ......S S4="" F  S S4=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3,S4)) Q:S4=""  D
        .......S S4T=S4T+S4
        .......S S5="" F  S S5=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3,S4,S5)) Q:S5=""  D
        ........S S5T=S5T+S5
        ........I FOR W !,$E($P(DFN," ",1,$L(DFN," ")-1),1,19),?20," ("_$P(DFN," ",$L(DFN," "))_")",?33,$P($$FMTE^XLFDT(DATER,"5ZM"),"@",1),?44,$J(S1,3),?49,$J(S2,3),?55,$J(S3,3),?63,$J(S4,3),?73,$J(S5,3)
        ........D PB Q:Y=0
        ........I 'FOR W !,$P(DFN," ",1,$L(DFN," ")-1),"^",$P(DFN," ",$L(DFN," ")),"^",$P($$FMTE^XLFDT(DATER,"5ZM"),"@",1),"^",S1,"^",S2,"^",S3,"^",S4,"^",S5
        Q:CNT=0
        I FOR W !,?44,"_________________________________" D PB Q:Y=0
        I FOR W !,?33,"Totals > >",?44,$J(S1T,3),?49,$J(S2T,3),?55,$J(S3T,3),?63,$J(S4T,3),?72,$J(S5T,4) D PB Q:Y=0
        I FOR W !,?34,"Means > >",?44,$J($FN(S1T/CNT,"",1),3),?49,$J($FN(S2T/CNT,"",1),3),?55,$J($FN(S3T/CNT,"",1),3),?63,$J($FN(S4T/CNT,"",1),3),?72,$J($FN(S5T/CNT,"",1),4)
        D PB Q:Y=0
        S (S1T,S2T,S3T,S4T,S5T,SCNT)=0
        N S1TDEV,S1TDEVT,S2TDEV,S2TDEVT,S3TDEV,S3TDEVT,S4TDEV,S4TDEVT,S5TDEV,S5TDEVT
        S (S1TDEVT,S2TDEVT,S3TDEVT,S4TDEVT,S5TDEVT)=0
        S DFN="" F  S DFN=$O(@REF@(DFN)) Q:DFN=""  D
        .S SDATE="" F  S SDATE=$O(@REF@(DFN,SDATE)) Q:SDATE=""  D
        ..S DATER="" F  S DATER=$O(@REF@(DFN,SDATE,DATER)) Q:DATER=""  D
        ...S S1="" F  S S1=$O(@REF@(DFN,SDATE,DATER,S1)) Q:S1=""  D
        ....S S1TDEV=(S1-(S1T/CNT))*(S1-(S1T/CNT)) S S1TDEVT=S1TDEVT+S1TDEV
        ....S S2="" F  S S2=$O(@REF@(DFN,SDATE,DATER,S1,S2)) Q:S2=""  D
        .....S S2TDEV=(S2-(S2T/CNT))*(S2-(S2T/CNT)) S S2TDEVT=S2TDEVT+S2TDEV
        .....S S3="" F  S S3=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3)) Q:S3=""  D
        ......S S3TDEV=(S3-(S3T/CNT))*(S3-(S3T/CNT)) S S3TDEVT=S3TDEVT+S3TDEV
        ......S S4="" F  S S4=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3,S4)) Q:S4=""  D
        .......S S4TDEV=(S4-(S4T/CNT))*(S4-(S4T/CNT)) S S4TDEVT=S4TDEVT+S4TDEV
        .......S S5="" F  S S5=$O(@REF@(DFN,SDATE,DATER,S1,S2,S3,S4,S5)) Q:S5=""  D
        ........S S5TDEV=(S5-(S5T/CNT))*(S5-(S5T/CNT)) S S5TDEVT=S5TDEVT+S5TDEV
        I FOR W !,?20,"Standard Deviations > >"
        I CNT<2 S CNT=CNT+1
        I FOR W ?44,$J($FN($$SQROOT(S1TDEVT/(CNT-1)),"",1),3),?49,$J($FN($$SQROOT(S2TDEVT/(CNT-1)),"",1),3),?55,$J($FN($$SQROOT(S3TDEVT/(CNT-1)),"",1),3),?63,$J($FN($$SQROOT(S4TDEVT/(CNT-1)),"",1),3),?72,$J($FN($$SQROOT(S5TDEVT/(CNT-1)),"",1),4)
        D PB Q:Y=0
        W ! D PB Q:Y=0
        K ^TMP("PXRMGEC",$J)
        D KILL^%ZISS
        Q
        ;
SQROOT(NUM)     ;Calculat Square Root
        N PREC,ROOT S ROOT=0 GOTO SQROOTX:NUM=0
        S:NUM<0 NUM=-NUM S ROOT=$S(NUM>1:NUM\1,1:1/NUM)
        S ROOT=$E(ROOT,1,$L(ROOT)+1\2) S:NUM'>1 ROOT=1/ROOT
        F PREC=1:1:6 S ROOT=NUM/ROOT+ROOT*.5
SQROOTX Q ROOT
        ;
VALUE(DA)       ;Return value for score
        N CAT,SYN,VALUE,PICE
        S SYN=$P($G(^AUTTHF(DA,0)),"^",9)
        Q:$E(SYN,5,5)'="F" VALUE
        Q:SYN="" VALUE
        Q:$E(SYN,5,5)="C" VALUE
        S VALUE=$P(SYN," ",$L(SYN," "))
        Q VALUE
        ;
        ;
PB      ;PAGE BREAK
        S Y=""
        I $Y=(IOSL-2) D
        .K DIR
        .S DIR(0)="E"
        .D ^DIR
        .I Y=1 W @IOF S $Y=0
        K DIR
        Q
        ;
