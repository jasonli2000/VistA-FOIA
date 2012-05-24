PSOORED1        ;ISC-BHAM/SAB - edit orders from backdoor ;5/10/07 8:25am
        ;;7.0;OUTPATIENT PHARMACY;**5,23,46,78,114,117,131,146,223,148,244,249,268,206**;DEC 1997;Build 39
        ;External reference ^PS(55 supported by DBIA 2228
        ;External reference ^PS(50.7 supported by DBIA 2223
        ;
        ;*244 call to remove DC'd Rx's from Rx ien strings
        ;
EN(PSORENW)     ;
        N LST,ORD,ORN K VALMBCK,PSORX("FN") S PSOAC=1,(PSORX("QFLG"),PSORX("DFLG"))=0 ;D DREN^PSOORNW2,INIT
        D INIT
        D @$S($P(PSOPAR,"^",7):"AUTO^PSONRXN",1:"MANUAL^PSONRXN")
        I '$D(PSONEW("RX #")),'$P(PSOPAR,"^",7) D PAUSE^VALM1 K VALMSG,PSONEW("QFLG") S VALMBCK="Q" Q
        I '$D(PSONEW("RX #")) K VALMSG D DEL^PSONEW,PAUSE^VALM1 S VALMBCK="Q" Q
        S PSORENW("RX #")=PSONEW("RX #") I '$P(PSOPAR,"^",7) D  Q:$G(PSONEW("DFLG"))!($G(PSONEW("QFLG")))
        .S PSOX=PSORENW("RX #") D CHECK^PSONRXN
        I $G(PSONEW("DFLG"))!$G(PSONEW("QFLG")) D DEL^PSONEW,PAUSE^VALM1 S VALMBCK="Q" K PSORENW Q
        D EN^PSOORNE1(.PSORENW) I '$G(PSORX("FN")) D:$P($G(PSOPAR),"^",7)=1  S VALMBCK="Q" Q
        .S DIE="^PS(59,",DA=PSOSITE,PSOY=$O(PSONEW("OLD LAST RX#","")),PSOX=PSONEW("OLD LAST RX#",PSOY)
        .L +^PS(59,+PSOSITE,PSOY):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
        .S DR=$S(PSOY=8:"2003////"_PSOX,PSOY=3:"1002.1////"_PSOX,1:"2003////"_PSOX)
        .D:PSOX<$P(^PS(59,+PSOSITE,PSOY),"^",3) ^DIE K DIE,X,Y L -^PS(59,+PSOSITE,PSOY)
        .I $D(PSONEW("RX #")) L -^PSRX("B",PSONEW("RX #"))
        .K PSOX,PSOY Q
        Q:$G(COPY)
TRY     S $P(^PSRX(PSORENW("OIRXN"),"STA"),"^")=15,DA=PSORENW("OIRXN")
        S $P(^PSRX(DA,3),"^",5)=DT,$P(^PSRX(DA,3),"^",10)=$P(^PSRX(DA,3),"^")
        D REVERSE^PSOBPSU1(DA,,"DC",7),CAN^PSOTPCAN(DA)
        D RMP^PSOCAN3                ;*244
        ;cancel/discontinue action
        S PHARM="",STAT="RP",COMM="Prescription discontinued due to editing." D EN^PSOHLSN1(DA,STAT,PHARM,COMM,PSONOOR) K STAT,PHARM,COMM
        S ACOM="Discontinued due to editing. New Rx created "_$P(^PSRX(PSORENW("IRXN"),0),"^")_"."
        I $G(^PSRX(DA,"H"))]"" D
        .I $P(^PSRX(DA,"STA"),"^")=3!($P(^("STA"),"^")=16) D
        ..S DIE=52,DR="22///"_$P(^PSRX(DA,3),"^") D ^DIE S ACOM="Discontinued due to editing while on hold. " K:$P(^PSRX(DA,"H"),"^") ^PSRX("AH",$P(^PSRX(DA,"H"),"^"),DA)
        ..S ^PSRX(DA,"H")=""
        S RXDA=DA,(DA,SUSDA)=$O(^PS(52.5,"B",RXDA,0)) D:DA
        .S SUSD=$P($G(^PS(52.5,DA,0)),"^",2)
        .S:+$G(^PS(52.5,DA,"P"))'=1 ACOM="Discontinued due to editing while suspended."
        .I $O(^PSRX(RXDA,1,0)) S DA=RXDA D:'$G(^PS(52.5,+SUSDA,"P")) REF^PSOCAN2
        .S DA=SUSDA,DIK="^PS(52.5," D ^DIK K DIK
        K SUSD,SUSDA S DA=RXDA,RXREF=0,PSODFN=+$P(^PSRX(DA,0),"^",2) D
        .S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(DA,"A",SUB)) Q:'SUB  S ACNT=SUB
        .S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
        .D NOW^%DTC S ^PSRX(DA,"A",0)="^52.3DA^"_(ACNT+1)_"^"_(ACNT+1),^PSRX(DA,"A",ACNT+1,0)=%_"^C^"_DUZ_"^"_RFCNT_"^"_$G(ACOM)
        .I $G(PSOOIFLG),'$G(PSOMRFLG) S $P(^PSRX(DA,"A",ACNT+1,1),"^")="Pharmacy Orderable Item Edited."
        .I '$G(PSOOIFLG),$G(PSOMRFLG) S $P(^PSRX(DA,"A",ACNT+1,1),"^")="Medication Route/Schedule Edited."
        .I $G(PSOOIFLG),$G(PSOMRFLG) S $P(^PSRX(DA,"A",ACNT+1,1),"^")="Pharmacy Orderable Item and Medication Route/Schedule Edited."
        .S REA="C" D EXP^PSOHELP1
        I $G(^PS(52.4,DA,0))]"" S PSCDA=DA,DIK="^PS(52.4," D ^DIK S DA=PSCDA K DIK,PSCDA
        Q
INS     K X,QUIT,Y,DIR,DIRUT,DUOUT,DTOUT,DIC,INSDEL,UPMI,^TMP($J,"INS1")
        I '$O(^PSRX(PSORXED("IRXN"),6,0)),'$O(PSORXED("DOSE",0)) D UPMI Q:$G(QUIT)  ;G INS1
        I $G(^PSRX(PSORXED("IRXN"),"INS"))]"" S PSORXED("FLD",114)=^PSRX(PSORXED("IRXN"),"INS") K UPMI G INS1
        K DD,GG F I=0:0 S I=$O(^PSRX(PSORXED("IRXN"),"INS1",I)) Q:'I  S DD=$G(DD)+1
        I $G(DD)=1 S PSORXED("FLD",114)=^PSRX(PSORXED("IRXN"),"INS1",$O(^PSRX(PSORXED("IRXN"),"INS1",0)),0) K UPMI,DD G INS1
        I $O(^PSRX(PSORXED("IRXN"),"INS1",0)) D  G INSX
        .F I=0:0 S I=$O(^PSRX(PSORXED("IRXN"),"INS1",I)) Q:'I  S ^TMP($J,"INS1",I,0)=^PSRX(PSORXED("IRXN"),"INS1",I,0)
        .S ^TMP($J,"INS1",0)=^PSRX(PSORXED("IRXN"),"INS1",0)
        .S DIC="^TMP($J,""INS1"",",DWPK=2,DWLW=80 D EN^DIWE I $G(X)="^" K ^TMP($J,"INS1") Q
        .I '$O(^TMP($J,"INS1",0)) S INSDEL=1
        .S D=0 F  S D=$O(^PSRX(PSORXED("IRXN"),"INS1",D)) Q:'D  S PSORXED("SIG",D)=^PSRX(PSORXED("IRXN"),"INS1",D,0)
INS1    K Y,DIR,DIRUT,DUOUT,DTOUT,DIC,X
        I $G(UPMI) K UPMI I $G(^PS(50.7,PSODRUG("OI"),"INS"))]"" S PSORXED("FLD",114)=^PS(50.7,PSODRUG("OI"),"INS")
        S:$G(PSORXED("FLD",114))]"" DIR("B")=PSORXED("FLD",114)
        S DIR("?")="Enter Quick codes or Free Text",DIR(0)="52,114" D ^DIR
        I $D(DTOUT)!($D(DUOUT))!($G(PSORXED("FLD",114))=X) K PSORXED("FLD",114) G INSX
        I X'="",X'="@" D SIG^PSOHELP G INS1:'$D(X)
        S PSORXED("FLD",114)=X
        I $G(INS1)]"" W " ("_$E(INS1,2,9999999)_")"
        G:(X']""!(X="@")) INSX
        S (PSORXED("INS"),PSORXED("SIG",1))=$E(INS1,2,9999999) D EN^PSOFSIG(.PSORXED)
INSX    I $P($G(^PS(55,PSODFN,"LAN")),"^") K DIR D
        .I $G(^PSRX(PSORXED("IRXN"),"INSS"))]"" S PSORXED("SINS")=^PSRX(PSORXED("IRXN"),"INSS")
        .D SINS^PSODIR(.PSORXED) I $G(PSORXED("SINS"))']"" K ^PSRX(PSORXED("IRXN"),"INSS") Q
        .S PSORXED("FLD",114.1)=PSORXED("SINS")
        K DIRUT,DUOUT,DTOUT,DIR,X,Y,DIC,DWPK
        Q
INIT    ;setup psorenw array
        S PSORENW("RX0")=^PSRX(PSORENW("IRXN"),0),PSORENW("RX2")=^(2),PSORENW("RX3")=^(3),PSORENW("STA")=^("STA"),PSORENW("TN")=$G(^("TN"))
        I $G(PSOSIGFL),$G(PSORX("SIG"))]"" S PSORENW("SIG")=PSORX("SIG"),SIGOK=0
        E  D
        .I '$P($G(^PSRX(PSORENW("IRXN"),"SIG")),"^",2) S PSORENW("SIG")=$P($G(^("SIG")),"^")
        .E  D
        ..S SIGOK=1 Q:$O(SIG(0))
        ..S D=0 F I=0:0 S D=D+1,I=$O(^PSRX(PSORENW("IRXN"),"SIG1",I)) Q:'I  S SIG(D)=^PSRX(PSORENW("IRXN"),"SIG1",I,0)
        ..K PSOX1,D
        S PSORENW("OIRXN")=PSORENW("IRXN")
        S PSORENW("PROVIDER")=$S($G(PSORENW("PROVIDER")):PSORENW("PROVIDER"),1:$P(PSORENW("RX0"),"^",4))
        S (PSORENW("PROVIDER NAME"),PSORX("PROVIDER NAME"))=$P($G(^VA(200,PSORENW("PROVIDER"),0)),"^")
        I $P($G(^VA(200,PSORENW("PROVIDER"),"PS")),"^",7),$P($G(^("PS")),"^",8) S PSORENW("COSIGNING PROVIDER")=$P($G(^("PS")),"^",8)
        S PSORENW("CLINIC")=$S($G(PSORENW("CLINIC")):PSORENW("CLINIC"),1:$P(PSORENW("RX0"),"^",5))
        S PSORENW("REMARKS")="New Order Created by "_$S($G(COPY)&('$G(PSOEDIT)):"copying",1:"editing")_" Rx # "_$P(PSORENW("RX0"),"^")_"."
        S PSORENW("COSIGNER")=$S($G(PSORENW("COSIGNER")):PSORENW("COSIGNER"),$P(PSORENW("RX3"),"^",3):$P(PSORENW("RX3"),"^",3),1:"")
        K:PSORENW("COSIGNER")="" PSORENW("COSIGNER")
        S PSORENW("PSODFN")=$P(PSORENW("RX0"),"^",2)
        S PSORENW("ORX #")=$P(PSORENW("RX0"),"^")
        S:$G(PSODRUG("IEN")) PSORENW("DRUG IEN")=PSODRUG("IEN")
        I $G(PSORENW("DAYS SUPPLY")) G QTY
        S PSORENW("DAYS SUPPLY")=$S($D(CLOZPAT):7,1:$P(PSORENW("RX0"),"^",8))
QTY     S PSORENW("QTY")=$S($G(PSORENW("QTY")):PSORENW("QTY"),1:$P(PSORENW("RX0"),"^",7))
RFN     S PSORENW("# OF REFILLS")=$S($D(CLOZPAT):0,$G(PSORENW("# OF REFILLS")):PSORENW("# OF REFILLS"),1:$P(PSORENW("RX0"),"^",9))
        S (PSOID,Y,PSORENW("FILL DATE"),PSORENW("ISSUE DATE"))=DT
        S:PSORENW("CLINIC") PSORX("CLINIC")=$P(^SC(+PSORENW("CLINIC"),0),"^")
        S PSORENW("PATIENT STATUS")=$S($G(PSORENW("PATIENT STATUS")):PSORENW("PATIENT STATUS"),'$P(PSORENW("RX0"),"^",3):$G(^PS(55,PSORENW("PSODFN"),"PS")),1:$P(PSORENW("RX0"),"^",3))
        S PSORENW("PTST NODE")=$G(^PS(53,PSORENW("PATIENT STATUS"),0))
        S PSDAYS=$S($G(PSORENW("DAYS SUPPLY")):PSORENW("DAYS SUPPLY"),'$P(PSORENW("RX0"),"^",8):$P(PSORENW("PTST NODE"),"^",3),1:$P(PSORENW("RX0"),"^",8))
        I $G(PSODRUG("IEN")) S DREN=PSODRUG("IEN"),POERR=1 D DRG^PSOORDRG K POERR
        D:$G(PSORENW("# OF REFILLS"))']"" RF
        S PSORENW("MAIL/WINDOW")=$S($G(PSORENW("MAIL/WINDOW"))]"":PSORENW("MAIL/WINDOW"),1:$P(PSORENW("RX0"),"^",11))
        S PSORX("MAIL/WINDOW")=$S(PSORENW("MAIL/WINDOW")="W":"WINDOW",1:"MAIL")
        S PSORENW("COPIES")=$S($G(PSORENW("COPIES")):PSORENW("COPIES"),$P(PSORENW("RX0"),"^",18):$P(PSORENW("RX0"),"^",18),1:1)
        S PSORENW("CLERK CODE")=DUZ
        S:$G(PSORX("CLERK CODE"))']"" PSORX("CLERK CODE")=$P($G(^VA(200,DUZ,0)),"^")
        Q:$D(COPY)  S PSORENW("ENT")=0 ;Q:$G(PSOSIGFL)!($D(COPY))
        K PSORENW("ENT") F I=0:0 S I=$O(PSORENW("DOSE",I)) Q:'I  S PSORENW("ENT")=$G(PSORENW("ENT"))+1
        I $O(^TMP($J,"INS1",0)) D
        .K PSORXED("SIG"),DD
        .F I=0:0 S I=$O(^TMP($J,"INS1",I)) Q:'I  S PSORENW("SIG",I)=^TMP($J,"INS1",I,0)
        .K ^TMP($J,"INS1")
        I $G(^PSRX(PSORENW("IRXN"),"INS"))]"" S PSORENW("INS")=^PSRX(PSORENW("IRXN"),"INS")
        I $G(^PSRX(PSORENW("IRXN"),"INSS"))]"" S PSORENW("SINS")=^PSRX(PSORENW("IRXN"),"INSS")
        I '$G(PSORENW("ENT")),'$G(PSOSIGFL) D DOLST1^PSOORED3(.PSORENW) S PSORENW("ENT")=+$G(OLENT)
        Q
RF      ;# of refills
        S PTRF=$S($P(PSORENW("PTST NODE"),"^",4)]"":$P(PSORENW("PTST NODE"),"^",4),1:11)
        S CS=0 F DEA=1:1 Q:$E(PSODRUG("DEA"),DEA)=""  I $E(+PSODRUG("DEA"),DEA)>1,$E(+PSODRUG("DEA"),DEA)<6 S CS=1
        I CS D
        .S PSOX1=$S(PTRF>5:5,1:PTRF),PSOX=$S(PSOX1=5:5,1:PSOX1)
        .S PSOX=$S('PSOX:0,PSDAYS=90:1,1:PSOX),PSDY1=$S(PSDAYS<60:5,PSDAYS'<60&(PSDAYS'>89):2,PSDAYS=90:1,1:0) S PSORENW("# OF REFILLS")=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
        E  D
        .S PSOX1=PTRF,PSOX=$S(PSOX1=11:11,1:PSOX1),PSOX=$S('PSOX:0,PSDAYS=90:3,1:PSOX)
        .S PSDY1=$S(PSDAYS<60:11,PSDAYS'<60&(PSDAYS'>89):5,PSDAYS=90:3,1:0) S PSORENW("# OF REFILLS")=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
        I PSODRUG("DEA")["A"&(PSODRUG("DEA")'["B")!(PSODRUG("DEA")["F")!(PSODRUG("DEA")[1)!(PSODRUG("DEA")[2) S PSORENW("# OF REFILLS")=0
        K PSDY,PSDY1,PTRF,PSOX,PSOX1,PSDAYS,CS
        Q
UPMI    ;add dosing data for pre-poe rxs
        W !! K PSONEW("DFLG"),DIR,DIRUT,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="No",DIR("A")="Dosing Instructions Are Missing!! Do You Want to Add Them"
        D ^DIR I 'Y!($D(DIRUT)) S QUIT=1 K DIR,DIRUT,DUOT,DUOUT Q
        S UPMI=1,EDTHLD=$G(PSORX("EDIT")) K PSORX("EDIT")
        D DOSE1^PSOORED5(.PSORXED) S (PSORXED,PSORX("EDIT"))=EDTHLD K EDTHLD I $G(PSONEW("DFLG")) S QUIT=1
        Q
