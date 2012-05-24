PSABRKU6        ;BIR/DB-Upload and Process Prime Vendor Invoice Data - CONT'D ;10/9/97
        ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**26,48,68**; 10/24/97;Build 7
        ;This routine looks in the DRUG file for each line item on the order.
        ;It looks for the NDC then VSN. If it is not found, no data is stored.
        ;
        ;References to ^DIC(51.5 are covered by IA #1931
        ;References to ^PSDRUG( are covered by IA #2095
        S PSAGUI1=0 ;Counter for Order Unit conversions
        S PSAGUI5=0 ;matched NDC counter
        S PSAGUI6=0 ;matched VSN counter
        S PSAGUI7=0 ;matched Supply Item counter
        S PSACTRL=0 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  D
        .I '$D(^XTMP("PSAPV",PSACTRL,"IN"))!($P($G(^XTMP("PSAPV",PSACTRL,"IN")),"^",8)="P") Q
        .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSAORD=$P(PSAIN,"^",4),PSAINV=$P(PSAIN,"^",2),PSACS=0
        .S PSALINE=0 F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  D
        ..Q:'$D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE))  Q:$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P"
        ..S PSAOK=1,PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE),PSANDC=$P(PSADATA,"^",4),PSAVSN=$P(PSADATA,"^",5)
        ..DO GETDRUG ;W "."
        ..S:PSAOK $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="OK"
        ..D:PSAOK OUAUTO^PSAUP8 ;*48 ORDER UNIT AUTO ADJUST
        .S (PSACNT,PSALLCS,PSALLOK,PSASUP)=0
        .S:PSACS $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="CS"
        .S PSALINE=0 F  S PSALINE=+$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:'PSALINE  D
        ..S PSACNT=PSACNT+1
        ..S:$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="CS" PSALLCS=PSALLCS+1
        ..S:$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="OK" PSALLOK=PSALLOK+1
        ..S:'+$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6) PSASUP=PSASUP+1
        .I PSACNT=PSASUP S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",13)="SUP"
        .I PSACNT=PSALLCS S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)="ALL CS"
        .I PSACNT=PSALLOK S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)="OK"
        Q
        ;
GETDRUG ;Looks for NDC then VSNs in DRUG file.
        I $D(PSANDC) S PSANDC=$P(PSANDC,"~")
        I $D(PSAVSN) S PSAVSN=$P(PSAVSN,"~")
        G:PSANDC=0 GETVSN
        I PSANDC'="" S PSAIEN=+$O(^PSDRUG("C",PSANDC,0)) I PSAIEN S PSASUB=+$O(^PSDRUG("C",PSANDC,PSAIEN,0)) G FOUND
        ;
GETVSN  ;Looks for Vendor Stock Number then NDC.
        I PSAVSN'="" S PSAIEN=+$O(^PSDRUG("AVSN",PSAVSN,0)) I PSAIEN S PSASUB=+$O(^PSDRUG("AVSN",PSAVSN,PSAIEN,0)) G FOUND
        I $G(PSAVSN)'="" S PSAMTCH=0,PSASUPPL=0 D
        .F  S PSAMTCH=$O(^XTMP("PSA SUPPLY",PSAMTCH)) Q:PSAMTCH'>0  S DATA=^XTMP("PSA SUPPLY",PSAMTCH,0) I $P(DATA,"^",2)=PSAVSN D
        ..;Found match on supply item
        ..S ^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")="UPLOAD GUI"_"^"_DT_"^"_$P(DATA,"^",1)
        ..S PSAGUI7=$G(PSAGUI7)+1,PSASUPPL=1
        I $G(PSASUPPL)>0 G VSN
        ;
        I (PSANDC=""&PSAVSN=""),$P(PSADATA,"^",26)'="" D ^PSAUP6
        ;
        S:'+$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6) PSAOK=0
        G UOM
        ;
FOUND   ;Store line item data if ordered item was found in DRUG file.
        I $P($G(^PSDRUG(PSAIEN,2)),"^",3)["N" S PSACS=1,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="CS"
        S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,$P(^(PSALINE),"^",7)=PSASUB
        ;
NDC     ;If >1 NDC in DRUG file, store how many.
        ;^XTMP $P4=NDC ~ # of nodes with same VSN (if >1 NDC) ~ VSN if different
        ;          than one on SYNONYM multiple (if 1 NDC)
        I PSANDC'="",$O(^PSDRUG("C",PSANDC,0)) D
        .S (PSACNT,PSACNT1,PSAFND,PSAFND1,PSAIEN50)=0
        .;
        .F  S PSAIEN50=+$O(^PSDRUG("C",PSANDC,PSAIEN50)) Q:'PSAIEN50  I '$D(^PSDRUG(PSAIEN50,"I")) S PSASYN=0 F  S PSASYN=+$O(^PSDRUG("C",PSANDC,PSAIEN50,PSASYN)) Q:'PSASYN  D
        ..Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
        ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)=PSAVSN S PSAFND=PSAFND+1,PSAFND1=PSAIEN50_"^"_PSASYN Q
        ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)'=PSAVSN S PSACNT=PSACNT+1,PSACNT1=PSAIEN50_"^"_PSASYN
        .;
        .;If NDC & VSN match, set ^XTMP
        .I PSAFND=1 S PSAIEN=$P(PSAFND1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSAFND1,"^",2),$P(^(PSALINE),"^",7)=PSASUB,$P(^(PSALINE),"^",4)=PSANDC Q
        .;
        .;If >1 with same NDC & VSN, set # with same NDC & VSN in ^XTMP & flag
        .I PSAFND>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)_"~"_PSAFND,PSAOK=0 Q
        .;
        .;If 1 NDC and ...
        .I PSACNT=1 S PSAIEN=$P(PSACNT1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSACNT1,"^",2),$P(^(PSALINE),"^",7)=PSASUB D  Q
        ..;VSN is null, accept as found & set ^XTMP
        ..I $P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",4)="" S PSAIEN=$P(PSACNT1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSACNT1,"^",2),$P(^(PSALINE),"^",7)=PSASUB,$P(^(PSALINE),"^",4)=PSANDC Q
        ..;Different VSN, set VSN in NDC piece in ^XTMP
        ..S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)_"~~"_$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",4),PSAOK=0
        .;
        .;If >1 NDC with different VSN, set flag in NDC piece of ^XTMP
        .I PSACNT>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)_"~"_PSACNT,PSAOK=0
        ;
VSN     ;If there >1 VSN with same VSN, store how many.
        ;^XTMP $P5=VSN ~ # of nodes with same UOM (if >1 VSN) ~ NDC if different
        ;          than one on SYNONYM multiple (if 1 VSN)
        I PSAVSN'="",$O(^PSDRUG("AVSN",PSAVSN,0))  D
        .S (PSACNT,PSACNT1,PSAFND,PSAFND1,PSAIEN50)=0
        .;
        .;DAVE B (PSA*3*2)
        .F  S PSAIEN50=+$O(^PSDRUG("AVSN",PSAVSN,PSAIEN50)) Q:'PSAIEN50  I '$D(^PSDRUG(PSAIEN50,"I")) S PSASYN=0 F  S PSASYN=+$O(^PSDRUG("AVSN",PSAVSN,PSAIEN50,PSASYN)) Q:'PSASYN  D
        ..Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
        ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^")=PSANDC S PSAFND=PSAFND+1,PSAFND1=PSAIEN50_"^"_PSASYN Q
        ..I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^")'=PSANDC S PSACNT=PSACNT+1,PSACNT1=PSAIEN50_"^"_PSASYN
        .;
        .;If VSN & NDC match, set ^XTMP
        .I PSAFND=1 D  Q
        ..I '+$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6) D
        ...S PSAIEN=$P(PSAFND1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSAFND1,"^",2),$P(^(PSALINE),"^",7)=PSASUB
        ...S:$P($G(^PSDRUG(PSAIEN,2)),"^",3)["N" $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="CS",PSACS=1
        ...S:$P($G(^PSDRUG(PSAIEN,2)),"^",3)'["N" $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="",PSACS=0
        ..S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=+$G(PSAVSN) ;*48
        .;
        .;If >1 with same VSN & NDC, set # with same NDC & VSN in ^XTMP & flag
        .I PSAFND>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)_"~"_PSAFND,PSAOK=0 Q
        .;
        .;If 1 VSN and ...
        .I PSACNT=1 D  Q
        ..I '+$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6) S PSAIEN=$P(PSACNT1,"^"),$P(^(PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSACNT1,"^",2),$P(^(PSALINE),"^",7)=PSASUB
        ..;NDC is null, accept as found & set ^XTMP
        ..;I $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)="" S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^") Q
        ..I $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)="" S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN D NDCCHK Q
        ..;Different VSN, set VSN in NDC piece in ^XTMP
        ..S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)_"~~"_$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^"),PSAOK=0
        .;
        .;If >1 VSN with different NDC, set flag in NDC piece of ^XTMP
        .I PSACNT>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)_"~"_PSACNT,PSAOK=0
        ;
UOM     ;Locates X12 Unit of Measure Code in ORDER UNIT file.
        ;^XTMP $P2=Alpha OU ~ 51.5 IEN
        K PSAUOM,PSAGUI I $P(PSADATA,"^",2)="" S PSAOK=0 G QTY
        ;
        S PSAUOM=$P($P(PSADATA,"^",2),"~") I $G(PSAUOM)'="",'$D(^DIC(51.5,"B",PSAUOM)),$D(^PSD(58.812,1,"OU","C",PSALINE)) D
        .S XIEN=$O(^PSD(58.812,1,"OU","C",PSALINE,0)) I $P($G(^PSD(58.812,1,"OU",XIEN,0)),"^",1)=PSAUOM S PSAUOMN=$P(^PSD(58.812,1,"OU",XIEN,0),"^",2),PSAUOM=$P($G(^DIC(51.5,PSAUOMN,0)),"^",1),PSAGUI1=$G(PSAGUI1)+1,PSAGUI=1
        I $G(PSAGUI)=1 D
        .;found unit of measure match in GUI file
        .S PSAUOMN=$O(^DIC(51.5,"B",PSAUOM,0)),PSAGUI=1
        .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",2)=PSAUOM_"~"_PSAUOMN
        .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",12)=PSAUOM
        .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",13)=.5 ;Assign to POSTMASTER
        .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",14)=DT
        I $G(PSAGUI)=1 K PSAGUI G QTY
        ;If order unit is standard order unit, set IEN in ^XTMP
        S PSAUOM=$O(^DIC(51.5,"B",$P($P(PSADATA,"^",2),"~"),0))
        I 'PSAUOM D  Q:'PSAOK
        .I +$P(PSADATA,"^",6),+$P(PSADATA,"^",7),+$P($G(^PSDRUG(PSAIEN,1,+$P(PSADATA,"^",7),0)),"^",5) D
        ..S PSAUOM=+$P($G(^PSDRUG(PSAIEN,1,+$P(PSADATA,"^",7),0)),"^",5),PSAUOMN=$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",2),"~")
        ..S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",2)=PSAUOMN_"~"_PSAUOM K PSAUOMN
        .S:'PSAUOM PSAOK=0
        I PSAUOM S PSAUOMN=$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",2),"~"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",2)=PSAUOMN_"~"_PSAUOM K PSAUOMN
        ;
QTY     ;If qty is 0 or blank, set flag
        I '+$P(PSADATA,"^") S PSAOK=0 Q
        ;
DUOU    ;If no dispense units per order unit, set flag.
        S PSADRG=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6),PSASYN=$P(^(PSALINE),"^",7)
        S:'PSASYN PSAOK=0
        I PSASYN,'$P($G(^PSDRUG(PSADRG,1,PSASYN,0)),"^",7) S PSAOK=0
        Q
        ;
NDCCHK  N TMPSYNDC,TMPDGNDC,TMPSYN01
        I '$G(PSANDC) D
        .S TMPSYN01=$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^")
        .S TMPSYNDC=$TR($P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",2),"-","")
        .S TMPDGNDC=$TR($P(^PSDRUG(PSAIEN,2),"^",4),"-","")
        .I TMPDGNDC=TMPSYNDC,TMPSYN01'=TMPSYNDC S PSANDC=TMPSYNDC Q
        .I $G(TMPSYNDC),'$G(TMPDGNDC) S PSANDC=TMPSYNDC Q
        .I $G(TMPDGNDC),'$G(TMPSYNDC) S PSANDC=TMPDGNDC Q
        .I '$G(TMPDGNDC),'$G(TMPSYNDC),$G(TMPSYN01) S PSANDC="",PSAOK=0 Q
        .I '$G(TMPDGNDC),'$G(TMPSYNDC),'$G(TMPSYN01) S PSANDC="",PSAOK=0
        S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC
        Q
