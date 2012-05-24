LAMIVTLX ;SLC/DLG/DALISC/PAC - VITEK LITERAL PROTOCOL CONTROLLER ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12**;Sep 27, 1994
 ;;
 ;Call with T set to Instrument data is to/from
 ; P1= RESET POINT FOR INCOMING RECORDS,
 ; P3=Reset point FOR RECORDS SENT
 S OSTX=$C(2),OETX=$C(3),OEDT=$C(4),OENQ=$C(5),OACK=$C(6),ONAK=$C(21)
RCHK K LATYPE S:IN'["~" LATYPE="X" S:'$D(LATYPE) LATYPE=$E(IN,$F(IN,"~"))
 Q:"BCDEFUX^]"'[LATYPE
 S LATYPE=$S(LATYPE="]":"GS",LATYPE="^":"RS",LATYPE="B":"RS",1:LATYPE)
 S OLDTYPE=LATYPE D @LATYPE
 ;,^LA(T,"I")=^LA(T,"I")+1 D @LATYPE
 ;I LATYPE="B" G RCHK
 Q
B ; ~B RECEIVED STX 2
 D RS Q  ; S OUT="",%=OUT Q
C ; ~C RECEIVED ETX 3
 Q
D ; ~D RECEIVED EOT 4
 I OLDTYPE="X" D CKSUM  S OUT=$S(LASUM=LASUM1:$C(6),1:$C(21)) Q
 I $D(^LA(T,"O",0)),^LA(T,"O")'=^LA(T,"O",0) S K=1 D OUT Q
 Q
E ; ~E RECEIVED ENQ 5
 ;S OUT=$C(6),%=OUT
 S ^LA(T,"P1")=CNT+2,OUT=$C(6),%=OUT
 ;I ^LA(T,"O",^LA(T,"P3"))[$C(29) S ^LA(T,"O",0)=^LA(T,"P2") L ^LA(T) S Q=^LA("Q")+1,^("Q")=Q,^LA("Q",Q)=T L  ;OUTPUT WAS HUNG RESET FOR RETRANSMISSION
 S T=T-BASE Q
 ;
F ;~F RECEIVED ACK 6
 S O=^LA(T,"O",0),^LA(T,"P3")=$S(^LA(T,"O",O)[$C(2):O+1,1:O) S K=1 D OUT
 Q
GS ; ~] GS RECORD NEXT RECORD SHOULD BE X TYPE LENGTH 2 ? 35
 D CKSUM Q  ;S OUT=OACK,%=OACK Q
RS ; ~^ RECEIVED RS DATA PACKET 30
 D CKSUM Q
U ; ~U RECEIVED NAK 21
 S ^LA(T,"O",0)=^LA(T,"P3"),K=1 D OUT Q  ;RECEIVED NAK
X ;RECEIVED GS CKSUM PACKET/?
 ;D CKSUM I $L(IN)=2,$E(IN,2)="D" S OUT=$C(6),%=OUT,^LA(T,"P1")=CNT+1 S T=T-BASE K LASUM,LASUM1 Q
 D CKSUM I $L(IN)=2 S OUT=$S(LASUM=LASUM1:$C(6),1:$C(6)),%=OUT S:LASUM=LASUM1 ^LA(T,"P1")=CNT+1 S T=T-BASE K LASUM,LASUM1 Q  ;RECEIVED GS CKSUM PACKET
 S ^LA(T,"P1")=CNT+1
 Q
CKSUM S:'$D(LASUM) LASUM=0
 S LASUM=$S(LATYPE="RS":30,LATYPE="GS":29,LATYPE="X":23,1:0)+LASUM
 ;I LATYPE="X",($L(IN)>2) F I=1:1:$L(IN) S LASUM=LASUM+$A(IN,I)
 ;I LATYPE="X",($L(IN)=2)
 I LATYPE="X" S LASUM=LASUM-23,LASUM=LASUM#256,LASUM1=$F("0123456789abcdef",$E(IN,1))-2*16+($F("0123456789abcdef",$E(IN,2))-2)
 Q
OUT D NEXT Q:'$D(^LA(T,"O",O))  Q:%[$C(29)  ;Q:%[$C(4)  Q:%[$C(5)
 S K=K+1 G OUT Q
NEXT S O=^LA(T,"O",0)+K Q:'$D(^(O))  S %=^(O)
 L ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T L  Q
ACK S LASUM1=$F("0123456789abcdef",$E(IN,121))-2*16+($F("0123456789abcdef",$E(IN,122))-2)
 S LASUM=0 F I=1:1:120 S LASUM=LASUM+(255-$A(IN,I)+1)
 S LASUM=LASUM#256,OUT=$S(LASUM=LASUM1:$C(6),1:$C(21)),%=OUT S T=T-BASE Q
 ;S LASUM=LASUM#256,OUT=$C(6),%=OUT S T=T-BASE
 Q
