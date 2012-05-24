PSORENW1        ;BIR/DSD - Renew Main Driver Continuation ;03/29/93
        ;;7.0;OUTPATIENT PHARMACY;**20,37,51,46,71,117,157,143,219,239,225**;DEC 1997;Build 29
        ;External reference ^VA(200 supported by DBIA 10060
        ;
START   ;
        S PSORENW("RX0")=^PSRX(PSORENW("OIRXN"),0),PSORENW("RX2")=^(2),PSORENW("RX3")=^(3),PSORENW("STA")=^("STA"),PSORENW("TN")=$G(^("TN")),SIGOK=+$P($G(^("SIG")),"^",2)
        S PSOIBOLD=$G(PSORENW("OIRXN"))
        D SETIB
        S PSORENW("PROVIDER")=$P(PSORENW("RX0"),"^",4)
        S PSORX("PROVIDER NAME")=$P($G(^VA(200,PSORENW("PROVIDER"),0)),"^")
        S PSORENW("CLINIC")=$P(PSORENW("RX0"),"^",5),PSORENW("COPIES")=$P(PSORENW("RX0"),"^",18)
        I $G(PSOFDR),$P($G(OR0),"^",13) S PSORENW("CLINIC")=$P($G(OR0),"^",13)
        S PSORENW("REMARKS")="RENEWED FROM RX # "_$P(PSORENW("RX0"),"^")
        S PSORENW("SIG")=$P($G(^PSRX(PSORENW("OIRXN"),"SIG")),"^")
        S:$P(PSORENW("RX3"),"^",3) PSORENW("COSIGNING PROVIDER")=$P(PSORENW("RX3"),"^",3)
        S (PSODFN,PSORENW("PSODFN"))=$P(PSORENW("RX0"),"^",2)
        S PSORENW("ORX #")=$P(PSORENW("RX0"),"^")
        S PSORENW("DRUG IEN")=$P(PSORENW("RX0"),"^",6)
        S PSORENW("INS")=$S($G(PSORENW("INS"))]"":PSORENW("INS"),1:$G(^PSRX(PSORENW("OIRXN"),"INS")))
        S D=0 F  S D=$O(^PSRX(PSORENW("OIRXN"),"INS1",D)) Q:'D  S PSORENW("SIG",D)=^PSRX(PSORENW("OIRXN"),"INS1",D,0)
        I '$O(PSORENW("SIG",0)),$G(PSORENW("INS"))]"" S PSORENW("SIG",1)=PSORENW("INS")
        G:$G(PSORENW("ENT")) FDR
        I $G(PSORENW("ENT"))'>0,'$O(^PSRX(PSORENW("OIRXN"),6,0)) S PSORENW("ENT")=0 G FDR
        F I=0:0 S I=$O(^PSRX(PSORENW("OIRXN"),6,I)) Q:'I  S DOSE=^PSRX(PSORENW("OIRXN"),6,I,0) D
        .S PSORENW("ENT")=$G(PSORENW("ENT"))+1,PSORENW("DOSE",PSORENW("ENT"))=$P(DOSE,"^")
        .S PSORENW("UNITS",PSORENW("ENT"))=$P(DOSE,"^",3),PSORENW("DOSE ORDERED",PSORENW("ENT"))=$P(DOSE,"^",2),PSORENW("ROUTE",PSORENW("ENT"))=$P(DOSE,"^",7)
        .S PSORENW("SCHEDULE",PSORENW("ENT"))=$P(DOSE,"^",8),PSORENW("DURATION",PSORENW("ENT"))=$P(DOSE,"^",5),PSORENW("CONJUNCTION",PSORENW("ENT"))=$P(DOSE,"^",6)
        .S PSORENW("NOUN",PSORENW("ENT"))=$P(DOSE,"^",4),PSORENW("VERB",PSORENW("ENT"))=$P(DOSE,"^",9)
        .I $G(^PSRX(PSORENW("OIRXN"),6,I,1))]"" S PSORENW("ODOSE",PSORENW("ENT"))=^PSRX(PSORENW("OIRXN"),6,I,1)
        .K DOSE
FDR     I $G(PSOFDR) D
        .F I=0:0 S I=$O(^PSRX(PSORENW("OIRXN"),6,I)) Q:'I  I $G(^PSRX(PSORENW("OIRXN"),6,I,1))]"" S PSORENW("ODOSE",I)=^PSRX(PSORENW("OIRXN"),6,I,1)
        .S $P(PSORENW("RX0"),"^",7)=$P(OR0,"^",10),$P(PSORENW("RX0"),"^",11)=$P(OR0,"^",17)
        .S (PSORX("PROVIDER NAME"),PSORENW("PROVIDER NAME"))=$P(^VA(200,$P(OR0,"^",5),0),"^"),PSORENW("PROVIDER")=$P(OR0,"^",5)
        .K PSORENW("COSIGNING PROVIDER")
        .I $G(PSORENW("PROVIDER")),$P($G(^VA(200,PSORENW("PROVIDER"),"PS")),"^",7),$P($G(^("PS")),"^",8) S PSORENW("COSIGNING PROVIDER")=$P($G(^("PS")),"^",8)
        .S (PSDY,PSORENW("DAYS SUPPLY"))=$P(PSORENW("RX0"),"^",8)
        .S POERR=1,DREN=$P(PSORENW("RX0"),"^",6) D DRG^PSOORDRG K POERR S PSODIR("CS")=0
        .F DEA=1:1 Q:$E(PSODRUG("DEA"),DEA)=""  I $E(+PSODRUG("DEA"),DEA)>1,$E(+PSODRUG("DEA"),DEA)<6 S PSODIR("CS")=1
        .I PSODIR("CS") S RFMX=$S(PSDY<60:5,PSDY'<60&(PSDY'>89):2,PSDY=90:1,1:0)
        .E  S RFMX=$S(PSDY<60:11,PSDY'<60&(PSDY'>89):5,PSDY=90:3,1:0)
        .S $P(PSORENW("RX0"),"^",9)=$S($P(OR0,"^",11)'>RFMX:$P(OR0,"^",11),1:RFMX),$P(OR0,"^",11)=$P(PSORENW("RX0"),"^",9)
        .K RFMX,PSODIR("CS"),PSDY
END     Q
STOP    K PSEXDT,X,%DT S PSON52("QFLG")=0,DAYS=$S($G(PSORENW("DAYS SUPPLY")):PSORENW("DAYS SUPPLY"),1:$P(PSORENW("RX0"),"^",8))
        S DEA("CS")=0 K DIR,DIC
        F DEA=1:1 Q:$E(PSODRUG("DEA"),DEA)=""  I $E(+PSODRUG("DEA"),DEA)>1,$E(+PSODRUG("DEA"),DEA)<6 S DEA("CS")=1
        S X1=$S($G(PSORENW("ISSUE DATE")):$G(PSORENW("ISSUE DATE")),1:DT),X2=DAYS*($P(PSORENW("RX0"),"^",9)+1)\1
        S X2=$S(DAYS=X2&('DEA("CS")):X2,DEA("CS"):184,1:366) D C^%DTC
        I PSORENW("FILL DATE")>$P(X,".") S PSEXDT=1_"^"_$P(X,".")
        K X1,X2,X,%DT
        Q
OERR    ;renewal finish from oe/rr
        S PSORENW("RX0")=^PSRX(PSORENW("OIRXN"),0),PSORENW("RX2")=^(2),PSORENW("RX3")=^(3),PSORENW("STA")=^("STA"),PSORENW("TN")=$G(^("TN"))
        S $P(PSORENW("RX0"),"^",4)=$P(OR0,"^",5)
        S PSORENW("PROVIDER")=$P(OR0,"^",5)
        S PSORX("PROVIDER NAME")=$P($G(^VA(200,PSORENW("PROVIDER"),0)),"^")
        S $P(PSORENW("RX0"),"^",5)=$P(OR0,"^",13)
        S PSORENW("CLINIC")=$P(OR0,"^",13)
        S PSORENW("REMARKS")="RENEWED FROM RX # "_$P(PSORENW("RX0"),"^")_"."_$S($P(OR0,"^",17)="C":" Administered in Clinic.",1:"")
        S PSORENW("SIG")=$P($G(^PSRX(PSORENW("OIRXN"),"SIG")),"^"),SIGOK=$P(^("SIG"),"^",2) I SIGOK D
        .F I=0:0 S I=$O(^PSRX(PSORENW("OIRXN"),"SIG1",I)) Q:'I  S SIG(I)=^PSRX(PSORENW("OIRXN"),"SIG1",I,0)
        S:$P(PSORENW("RX3"),"^",3) PSORENW("COSIGNING PROVIDER")=$P(PSORENW("RX3"),"^",3)
        S PSORENW("PSODFN")=$P(PSORENW("RX0"),"^",2)
        S PSORENW("ORX #")=$P(PSORENW("RX0"),"^")
        S PSORENW("DRUG IEN")=$P(PSORENW("RX0"),"^",6),$P(PSORENW("RX0"),"^",11)=$P(OR0,"^",17)
        S PSORENW("INS")=$S($G(PSORENW("INS"))]"":PSORENW("INS"),1:$G(^PSRX(PSORENW("OIRXN"),"INS")))
        Q:$G(PSORENW("ENT"))>0
        F I=0:0 S I=$O(^PSRX(PSORENW("OIRXN"),6,I)) Q:'I  S DOSE=^PSRX(PSORENW("OIRXN"),6,I,0) D
        .S PSORENW("ENT")=PSORENW("ENT")+1,PSORENW("DOSE",PSORENW("ENT"))=$P(DOSE,"^")
        .S PSORENW("UNITS",PSORENW("ENT"))=$P(DOSE,"^",3),PSORENW("DOSE ORDERED",PSORENW("ENT"))=$P(DOSE,"^",2),PSORENW("ROUTE",PSORENW("ENT"))=$P(DOSE,"^",7)
        .S PSORENW("SCHEDULE",PSORENW("ENT"))=$P(DOSE,"^",8),PSORENW("DURATION",PSORENW("ENT"))=$P(DOSE,"^",5),PSORENW("CONJUNCTION",PSORENW("ENT"))=$P(DOSE,"^",6)
        .S PSORENW("NOUN",PSORENW("ENT"))=$P(DOSE,"^",4),PSORENW("VERB",PSORENW("ENT"))=$P(DOSE,"^",9)
        .I $G(^PSRX(PSORENW("OIRXN"),6,I,1))]"" S PSORENW("ODOSE",PSORENW("ENT"))=^PSRX(PSORENW("OIRXN"),6,I,1)
        .K DOSE
        Q
        ;
SETIB   ;Set defaults on Renewals with Copay information
        ;If answer is in Pending File, use that, else look in Prescription file
        N PSOOICD,JJJ
        K PSOSCP,PSOANSQ("SC>50") D SCP^PSORN52D S PSOANSQ("SC>50")="" K PSOSCA
        I '$G(PSOIBOLD) Q
        I $G(PSOFDR),$G(ORD) D SETIBP Q
        ;I '$$DT^PSOMLLDT Q
        I $G(PSORX(PSOIBOLD,"SC"))'=0,$G(PSORX(PSOIBOLD,"SC"))'=1 S PSORX(PSOIBOLD,"SC")=$S($P($G(^PSRX(PSOIBOLD,"IBQ")),"^")'="":$P($G(^("IBQ")),"^"),$P($G(^PSRX(PSOIBOLD,"IB")),"^"):0,1:"")
        I $G(PSORX(PSOIBOLD,"SC"))="" K PSORX(PSOIBOLD,"SC")
        I '$$DT^PSOMLLDT Q
        I $G(PSORX(PSOIBOLD,"MST"))'=0,$G(PSORX(PSOIBOLD,"MST"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",2)'="" S PSORX(PSOIBOLD,"MST")=$P($G(^("IBQ")),"^",2)
        I $G(PSORX(PSOIBOLD,"VEH"))'=0,$G(PSORX(PSOIBOLD,"VEH"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",3)'="" S PSORX(PSOIBOLD,"VEH")=$P($G(^("IBQ")),"^",3)
        I $G(PSORX(PSOIBOLD,"RAD"))'=0,$G(PSORX(PSOIBOLD,"RAD"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",4)'="" S PSORX(PSOIBOLD,"RAD")=$P($G(^("IBQ")),"^",4)
        I $G(PSORX(PSOIBOLD,"PGW"))'=0,$G(PSORX(PSOIBOLD,"PGW"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",5)'="" S PSORX(PSOIBOLD,"PGW")=$P($G(^("IBQ")),"^",5)
        I $G(PSORX(PSOIBOLD,"HNC"))'=0,$G(PSORX(PSOIBOLD,"HNC"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",6)'="" S PSORX(PSOIBOLD,"HNC")=$P($G(^("IBQ")),"^",6)
        I $G(PSORX(PSOIBOLD,"CV"))'=0,$G(PSORX(PSOIBOLD,"CV"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",7)'="" S PSORX(PSOIBOLD,"CV")=$P($G(^("IBQ")),"^",7)
        I $G(PSORX(PSOIBOLD,"SHAD"))'=0,$G(PSORX(PSOIBOLD,"SHAD"))'=1,$P($G(^PSRX(PSOIBOLD,"IBQ")),"^",8)'="" S PSORX(PSOIBOLD,"SHAD")=$P($G(^("IBQ")),"^",8)
        ;
SET2    ;for when patient status is exempt or SC>50
        I $TR($G(^PSRX(PSOIBOLD,"IBQ")),"^")="" S PSOOICD=$G(^PSRX(PSOIBOLD,"ICD",1,0)) D SET3:PSOOICD'=""
        ;
ICD     I $D(^PSRX(PSORENW("OIRXN"),"ICD",0)) D
        . N JJ,ICD,II,FLD,RXN S RXN=PSOIBOLD
        . S II=0 F  S II=$O(^PSRX(PSORENW("OIRXN"),"ICD",II)) Q:II=""!(II'?1N.N)  D
        .. S ICD=^PSRX(PSORENW("OIRXN"),"ICD",II,0),FLD=$P(ICD,U) D ICD^PSONEWF
        Q
SET3    ;for when patient status is exempt or SC>50
        D SET3^PSORN52D
        Q
        ;
SETIBP  ;
        I $P($G(^PS(52.41,ORD,0)),"^",16)="SC"!($P($G(^(0)),"^",16)="NSC") S PSORX(PSOIBOLD,"SC")=$S($P($G(^(0)),"^",16)="SC":1,1:0)
        I $G(PSORX(PSOIBOLD,"SC"))="" K PSORX(PSOIBOLD,"SC")
        I '$$DT^PSOMLLDT Q
        N PSOIBQFN S PSOIBQFN=$G(^PS(52.41,ORD,"IBQ"))
        I $P(PSOIBQFN,"^",1)=0!($P(PSOIBQFN,"^",1)=1) S PSORX(PSOIBOLD,"MST")=$P(PSOIBQFN,"^")
        I $P(PSOIBQFN,"^",2)=0!($P(PSOIBQFN,"^",2)=1) S PSORX(PSOIBOLD,"VEH")=$P(PSOIBQFN,"^",2)
        I $P(PSOIBQFN,"^",3)=0!($P(PSOIBQFN,"^",3)=1) S PSORX(PSOIBOLD,"RAD")=$P(PSOIBQFN,"^",3)
        I $P(PSOIBQFN,"^",4)=0!($P(PSOIBQFN,"^",4)=1) S PSORX(PSOIBOLD,"PGW")=$P(PSOIBQFN,"^",4)
        I $P(PSOIBQFN,"^",5)=0!($P(PSOIBQFN,"^",5)=1) S PSORX(PSOIBOLD,"HNC")=$P(PSOIBQFN,"^",5)
        I $P(PSOIBQFN,"^",6)=0!($P(PSOIBQFN,"^",6)=1) S PSORX(PSOIBOLD,"CV")=$P(PSOIBQFN,"^",6)
        I $P(PSOIBQFN,"^",7)=0!($P(PSOIBQFN,"^",7)=1) S PSORX(PSOIBOLD,"SHAD")=$P(PSOIBQFN,"^",7)
        ;for when patient status is exempt, null IBQ node was set for exempts or SC>50 - data is in ICD node
        I $TR($G(^PS(52.41,ORD,"IBQ")),"^")="" S PSOOICD=$G(^PS(52.41,ORD,"ICD",1,0)) D SET3:PSOOICD'=""
        ;
ICD2    ;
        I $D(^PS(52.41,ORD,"ICD",0)) D
        . N JJ,ICD,II,FLD,RXN S RXN=ORD
        . S II=0 F  S II=$O(^PS(52.41,ORD,"ICD",II)) Q:II=""!(II'?1N.N)  D
        .. S ICD="",ICD=^PS(52.41,ORD,"ICD",II,0)
        .. I $G(PSOSCP)>49&(II=1) S PSORX(PSOIBOLD,"SC>50")=$P(ICD,"^",4)
        .. S JJ="" F JJ=1:1:9 S FLD=$P(ICD,U,JJ) D ICD^PSONEWF
        K PSOIBQFN
        Q
KLIB    ;Kill renewal IB array
        I '$G(PSOIBOLD) Q
        K PSORX(PSOIBOLD,"SC"),PSORX(PSOIBOLD,"MST"),PSORX(PSOIBOLD,"VEH"),PSORX(PSOIBOLD,"RAD"),PSORX(PSOIBOLD,"PGW"),PSORX(PSOIBOLD,"HNC"),PSORX(PSOIBOLD,"CV"),PSORX(PSOIBOLD,"SHAD")
        K PSOIBOLD
        Q
