SDAMEP2 ;ALB/CAW - Extended Display (Patient Data) ; 11/13/02
        ;;5.3;Scheduling;**258,325,441**;Aug 13, 1993;Build 14
        ;
PDATA   ; Patient Data
        F SD=0,.11,.13,.32,.322,.321,.36,.52 S SD(SD)=$G(^DPT(DFN,SD))
        S SD("CV")=$$CVEDT^DGCV(DFN,SDT)
        S VAIP("D")="L",VAIP("L")="" D INP^DGPMV10
        S SDFSTCOL=16,SDSECCOL=60
        S X="" D SET^SDAMEP1($$SETSTR^VALM1("*** Patient Information ***",X,25,30))
        D CNTRL^VALM10(SDLN,25,30,IOINHI,IOINORM)
PTDOB   ; Date of Birth and SSN Info
        ;
        S X="",X=$$SETSTR^VALM1("Date of Birth:",X,1,14)
        S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SD(0),U,3)),X,SDFSTCOL,18)
        S X=$$SETSTR^VALM1(" ID:",X,55,4)
        S X=$$SETSTR^VALM1(VA("PID"),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
PTSEX   ; Sex and Marital Status Info
        ;
        S X="",X=$$SETSTR^VALM1("Sex:",X,11,4)
        S X=$$SETSTR^VALM1($S($P(SD(0),U,2)="F":"FEMALE",$P(SD(0),U,2)="M":"MALE",1:"UNKNOWN"),X,SDFSTCOL,18)
        S X=$$SETSTR^VALM1("Marital Status:",X,44,15)
        S X=$$SETSTR^VALM1($P($G(^DIC(11,+$P(SD(0),U,5),0)),U),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
PTREL   ; Religious Pref. Info
        ;
        S X="",X=$$SETSTR^VALM1("Religious Pref.:",X,43,16)
        S X=$$SETSTR^VALM1($P($G(^DIC(13,+$P(SD(0),U,8),0)),U),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
PTMT    ; Means Test Info
        ;
        S SDMT=$$LST^DGMTU(DFN),X="" G:$P(SDMT,U,4)="N" PTCO I +SDMT D  G PTMTQ
        .S X=$$SETSTR^VALM1("Means Test:",X,4,11)
        .S X=$$SETSTR^VALM1($P($$FMT^SDUTL2(DFN),U),X,SDFSTCOL,20)
        .S X=$$SETSTR^VALM1("Last Means Test:",X,43,16)
        .S X=$$SETSTR^VALM1($$FDATE^VALM1($P(SDMT,U,2)),X,SDSECCOL,20)
PTCO    S SDMT=$$LST^DGMTU(DFN,"",2),X="" I +SDMT D
        .S X=$$SETSTR^VALM1("Co-Pay Test:",X,3,12)
        .S X=$$SETSTR^VALM1($P($$FCO^SDUTL2(DFN),U,2),X,SDFSTCOL,10)
        .S X=$$SETSTR^VALM1("Last Co-Pay Test:",X,42,17)
        .S X=$$SETSTR^VALM1($$FDATE^VALM1($P(SDMT,U,2)),X,SDSECCOL,20)
PTMTQ   D SET^SDAMEP1(X)
PTELG   ; Primary Eligibility and Period of Service Info
        ;
        S X="",X=$$SETSTR^VALM1("Primary Elig.:",X,1,14)
        S X=$$SETSTR^VALM1($P($G(^DIC(8,+$P(SD(.36),U),0)),U,6),X,SDFSTCOL,21)
        S X=$$SETSTR^VALM1("POS:",X,55,4)
        S X=$$SETSTR^VALM1($P($G(^DIC(21,+$P(SD(.32),U,3),0)),U),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
PTADD   ; Patient Address
        ;
        S X="",X=($$SETSTR^VALM1("Address:",X,7,8))
        S X=$$SETSTR^VALM1("Phone:",X,53,6)
        S X=$$SETSTR^VALM1($P(SD(.13),U),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
        S X="",X=($$SETSTR^VALM1($P(SD(.11),U),X,10,30))
        S X=$$SETSTR^VALM1("Cell Phone:",X,48,11)
        S X=$$SETSTR^VALM1($S(($P(SD(.13),U,4)'=""):$P(SD(.13),U,4),1:"UNANSWERED"),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
        S X="",SDPAGFLG=0
        I $P(SD(.11),U,2)'="" D
        .S X="",X=($$SETSTR^VALM1($P(SD(.11),U,2),X,10,30))
        .S X=$$SETSTR^VALM1("Pager #:",X,51,8)
        .S X=$$SETSTR^VALM1($S(($P(SD(.13),U,5)'=""):$P(SD(.13),U,5),1:"UNANSWERED"),X,SDSECCOL,20),SDPAGFLG=1
        D:X'="" SET^SDAMEP1(X)
        ; retrieve country info -- PERM country is piece 10 of .11
        N FILE,CNTRY,FORIEN,FOREIGN
        S FILE=779.004,FORIEN=$P(SD(.11),U,10),CNTRY=$$GET1^DIQ(FILE,FORIEN_",",2),CNTRY=$$UPPER^VALM1(CNTRY),FOREIGN=$$FORIEN^DGADDUTL(FORIEN)
        I 'FOREIGN D
        . N SDZIP S SDZIP=$P(SD(.11),U,12) S:$E(SDZIP,6,10)'="" SDZIP=$E(SDZIP,1,5)_"-"_$E(SDZIP,6,10)
        . S X="",X=($$SETSTR^VALM1($P(SD(.11),U,4)_", "_$P($G(^DIC(5,+$P(SD(.11),U,5),0)),U)_"  "_SDZIP,X,10,45))
        E  D
        . S X="",X=($$SETSTR^VALM1($P(SD(.11),U,9)_" "_$P(SD(.11),U,4)_" "_$P(SD(.11),U,8),X,10,45))
        I 'SDPAGFLG D
        .S X=$$SETSTR^VALM1("Pager #:",X,51,8)
        .S X=$$SETSTR^VALM1($S(($P(SD(.13),U,5)'=""):$P(SD(.13),U,5),1:"UNANSWERED"),X,SDSECCOL,20)
        D SET^SDAMEP1(X) K SDPAGFLG
        S X="",X=$$SETSTR^VALM1(CNTRY,X,10,45)
        D SET^SDAMEP1(X)
        S X="",X=$$SETSTR^VALM1("EMAIL ADDRESS:",X,1,14)
        S X=$$SETSTR^VALM1($S(($P(SD(.13),U,3)'=""):$P(SD(.13),U,3),1:"UNANSWERED"),X,SDFSTCOL,45)
        D SET^SDAMEP1(X)
PTEXP   ; Radiation and Status
        ;
        S X="",X=$$SETSTR^VALM1("Radiation Exposure:",X,1,19)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($P(SD(.321),U,3)),X,21,7)
        S X=$$SETSTR^VALM1("Status:",X,52,7)
        S A=$S("^3^5^"[("^"_+DGPMVI(2)_"^"):0,1:+DGPMVI(2)),SDST=$S('A:"IN",1:"")_"ACTIVE ",SDSTA=$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"LODGER",1:"INPATIENT")
        I '$D(^DGPM("C",DFN)) S SDST="NO INPT./LOD. ACT.",SDSTA=""
        S X=$$SETSTR^VALM1(SDST_SDSTA,X,SDSECCOL,20)
        D SET^SDAMEP1(X)
PTPOW   ; Prisoner of War Info and Last Admission Date
        ;
        S X="",X=$$SETSTR^VALM1("Prisoner of War:",X,4,16)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($P(SD(.52),U,5)),X,21,7)
        S X=$$SETSTR^VALM1("Last Admit/Lodger Date:",X,36,23)
        I +DGPMVI(13,1) S X=$$SETSTR^VALM1($$FTIME^VALM1(+DGPMVI(13,1)),X,SDSECCOL,18)
        D SET^SDAMEP1(X)
PTAO    ; Agent Orange Exposure and Last Discharge Date
        S X="",X=$$SETSTR^VALM1("AO Exp/Loc:",X,9,11)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($P(SD(.321),U,2))_$S($P(SD(.321),U,13)="V":"/VIET",$P(SD(.321),U,13)="K":"/DMZ",$P(SD(.321),U,13)="O":"/OTH",1:""),X,21,14)
        S X=$$SETSTR^VALM1("Last Disch./Lodger Date:",X,35,24)
        S SDDISCH=+$G(^DGPM(+DGPMVI(17),0))
        I +SDDISCH S X=$$SETSTR^VALM1($$FTIME^VALM1(SDDISCH),X,SDSECCOL,18)
        D SET^SDAMEP1(X)
CV      ;Combat vet
        S X="",X=$$SETSTR^VALM1("Combat Veteran:",X,5,15)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($S($P(SD("CV"),U,1)>0:"Y",1:"N")),X,21,7)
        S X=$$SETSTR^VALM1("Combat Veteran End Date:",X,35,24)
        I $P(SD("CV"),U,1)>0 D
        .S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SD("CV"),U,2)),X,SDSECCOL,18)
        E  S X=$$SETSTR^VALM1("N/A",X,SDSECCOL,3)
        D SET^SDAMEP1(X)
SHAD    ;PROJ 112/SHAD
        S X="",X=$$SETSTR^VALM1("PROJ 112/SHAD:",X,6,14)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($S($P(SD(.321),U,15)>0:"Y",1:"N")),X,21,7)
SWASIA  ;SW Asia
        S X=$$SETSTR^VALM1("SW Asia Conditions:",X,40,19)
        S X=$$SETSTR^VALM1($$FYNUNK^SDUTL2($P(SD(.322),U,13)),X,SDSECCOL,20)
        D SET^SDAMEP1(X)
        D SET^SDAMEP1("")
        Q
