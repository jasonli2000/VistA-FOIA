PSOORRL3 ;BHAM ISC/SJA - returns patient's outpatient meds-new sort ;02/02/07
 ;;7.0;OUTPATIENT PHARMACY;**225**;DEC 1997;Build 29
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^VA(200 supported by DBIA 10060
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to OCL^PSJORRE supported by DBIA 2383
OCL ;entry point to return condensed list
 ;BHW;PSO*7*159;New SD* Variables
 N SD,SDT,SDT1,PSG,PST,PSD,DRUG,PSOSTA
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 K ^TMP("PS",$J),^TMP("PSO",$J),^TMP("PS1",$J)
 S TFN=0,PSBDT=$G(BDT),PSEDT=$G(EDT) I +$G(PSBDT)<1 S X1=DT,X2=-120 D C^%DTC S PSBDT=X
 S EXDT=PSBDT-1,IFN=0
 F  S EXDT=$O(^PS(55,DFN,"P","A",EXDT)) Q:'EXDT  F  S IFN=$O(^PS(55,DFN,"P","A",EXDT,IFN)) Q:'IFN  D:$D(^PSRX(IFN,0))
 .S PSOSTA=$P($G(^PSRX(IFN,"STA")),"^") Q:'(PSOSTA=0!(PSOSTA=11)!(PSOSTA=5))
 .S TFN=TFN+1,RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2),LSTRD=$P(RX2,"^",13),LSTDS=$P(RX0,"^",8)
 .F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^"),LSTDS=$P(^(0),"^",10) S:$P(^(0),"^",18)]"" LSTRD=$P(^(0),"^",18)
 .S ST0=STA,ST=$P("ERROR^ACTIVE^^^^^ACTIVE/SUSP^^^^^^EXPIRED^^^^^^","^",ST0+2)
 .S DRUG=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")
 .S ^TMP("PSO",$J,DRUG,ST,TFN,0)=IFN_"R;O"_"^"_DRUG_"^^"_$P(RX2,"^",6)_"^"_($P(RX0,"^",9)-TRM)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)
 .S ^TMP("PSO",$J,DRUG,ST,TFN,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 .S ^TMP("PSO",$J,DRUG,ST,TFN,0)=^TMP("PSO",$J,DRUG,ST,TFN,0)_"^"_ST_"^"_LSTFD_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P(RX0,"^",13)_"^"_LSTRD_"^"_LSTDS
 .S ^TMP("PSO",$J,DRUG,ST,TFN,"SCH",0)=0
 .S (SCH,SC)=0 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PSO",$J,DRUG,ST,TFN,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^"),^TMP("PSO",$J,DRUG,ST,TFN,"SCH",0)=^TMP("PSO",$J,DRUG,ST,TFN,"SCH",0)+1
 .S ^TMP("PSO",$J,DRUG,ST,TFN,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 ..Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 ..I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PSO",$J,DRUG,ST,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 ..I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PSO",$J,DRUG,ST,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 ..S ^TMP("PSO",$J,DRUG,ST,TFN,"MDR",0)=^TMP("PSO",$J,DRUG,ST,TFN,"MDR",0)+1
 .S PSOELSE=0 I $D(^PSRX(IFN,"SIG")),'$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG1^PSOORRL1
 .I '$G(PSOELSE) S ITFN=1 D
 ..S ^TMP("PSO",$J,DRUG,ST,TFN,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PSO",$J,DRUG,ST,TFN,"SIG",0)=+$G(^TMP("PSO",$J,DRUG,ST,TFN,"SIG",0))+1
 ..F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PSO",$J,DRUG,ST,TFN,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PSO",$J,DRUG,ST,TFN,"SIG",0)=+$G(^TMP("PSO",$J,DRUG,ST,TFN,"SIG",0))+1
 K PSOELSE D NVA
 S PSG="",J=1 F  S PSG=$O(^TMP("PSO",$J,PSG)) Q:PSG=""  S PST="" F  S PST=$O(^TMP("PSO",$J,PSG,PST)) Q:PST=""  S I=0 F  S I=$O(^TMP("PSO",$J,PSG,PST,I)) Q:'I  D
 .M ^TMP("PS",$J,J)=^TMP("PSO",$J,PSG,PST,I) S J=J+1
 S PSG="" F  S PSG=$O(^TMP("PS1",$J,PSG)) Q:PSG=""  S PST="" F  S PST=$O(^TMP("PS1",$J,PSG,PST)) Q:PST=""  S I=0 F  S I=$O(^TMP("PS1",$J,PSG,PST,I)) Q:I=""  D
 .M ^TMP("PS",$J,J)=^TMP("PS1",$J,PSG,PST,I) S J=J+1
 K ^TMP("PSO",$J),^TMP("PS1",$J)
 D OCL^PSJORRE(DFN,BDT,EDT,.TFN,+$G(VIEW)) D END^PSOORRL1
 K SDT,SDT1,ST,DRUG,PSG,PST,PSD,EDT,EDT1,BDT,DBT1,X
 Q
NVA ; Set Non-VA Med Orders in the ^TMP Global
 ;BHW;PSO*7*159;New SDT,SDT1 Variables
 N SDT,SDT1
 F I=0:0 S I=$O(^PS(55,DFN,"NVA",I)) Q:'I  S X=$G(^PS(55,DFN,"NVA",I,0)) D
 .Q:'$P(X,"^")!($P(X,"^",7))
 .S DRG=$S($P(X,"^",2):$P($G(^PSDRUG($P(X,"^",2),0)),"^"),1:$P(^PS(50.7,$P(X,"^"),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(X,"^"),0),"^",2),0),"^"))
 .S SDT=$P(X,"^",9) I 'SDT D TMPBLD Q
 .I $E(SDT,4,5),$E(SDT,6,7) D
 ..;I $P(X,"^",9) D  Q
 ..I $G(BDT),SDT<BDT Q
 ..I $G(EDT),SDT>EDT Q
 ..I $G(BDT),$P(X,"^",7),$P(X,"^",7)<BDT Q
 ..D TMPBLD
 .I $E(SDT,4,5),'$E(SDT,6,7) D
 ..S SDT1=$E(SDT,1,5),BDT1=$E(+$G(BDT),1,5),EDT1=$E(+$G(EDT),1,5)
 ..I $G(BDT1),SDT1<BDT1 Q
 ..I $G(EDT1),SDT1>EDT1 Q
 ..I $G(BDT1),$P(X,"^",7),$E($P(X,"^",7),1,5)<BDT1 Q
 ..D TMPBLD
 .I '$E(SDT,4,5),'$E($P(X,"^",9),6,7) D
 ..;I $P(X,"^",9) D  Q
 ..S SDT1=$E(SDT,1,3),BDT1=$E(+$G(BDT),1,3),EDT1=$E(+$G(EDT),1,3)
 ..I $G(BDT1),SDT1<BDT1 Q
 ..I $G(EDT1),SDT1>EDT1 Q
 ..I $G(BDT1),$P(X,"^",7),$E($P(X,"^",7),1,3)<BDT1 Q
 ..D TMPBLD
 Q
TMPBLD S TFN=$G(TFN)+1,ST="ACTIVE"
 S ^TMP("PS1",$J,DRG,ST,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS1",$J,DRG,ST,TFN,0),"^",8)=$P(X,"^",8)_"^"_$S($P(X,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS1",$J,DRG,ST,TFN,"SCH",0)=1,^TMP("PS1",$J,DRG,ST,TFN,"SCH",1,0)=$P(X,"^",5)
 S ^TMP("PS1",$J,DRG,ST,TFN,"SIG",0)=1,^TMP("PS1",$J,DRG,ST,TFN,"SIG",1,0)=$P(X,"^",3)_" "_$P(X,"^",4)_" "_$P(X,"^",5)
 Q
