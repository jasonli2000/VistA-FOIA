RMPC6J ;DDC/KAW-RMPF*1.1*6 - TELEX [ 06/24/93  1:44 PM ]
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"TELEX"
 F IX=1:1:8 S MD=$P($T(MODEL+IX),";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0))
 .I 'MP W !!,MD," does not exist in file 791811.  Components not added." Q
 .F IY=1:1 S ST=$T(COMP+IY) Q:ST=""  D
 ..S CS=$P(ST,";",IX+4) Q:CS=""
 ..S CP=$E($P(ST,";",3),1,30),CD=$P(ST,";",4),(CA,CX)=""
 ..F  S CA=$O(^RMPF(791811.2,"B",CP,CA)) Q:'CA  I $P(^RMPF(791811.2,CA,0),"^",3)=CD S CX=CA Q
 ..I 'CX W !!,CP," component not added." Q
 ..D SET1^RMPC6 W "."
 .F IZ=1:1:4 S ST=$T(BAT+IZ) D
 ..S BT=$P(ST,";",3),BX=$P(ST,";",IX+3) Q:'BX
 ..S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 ..D SET2^RMPC6 W "."
 G ^RMPC6K
MODEL ;;Telex Models
 ;;28A
 ;;TLP
 ;;M29
 ;;TCA
 ;;TCA-M
 ;;WIRELESS CROS
 ;;WIRELESS BICROS
 ;;WIRELESS MULTICROS
BAT ;;Batteries
 ;;ZA10;1;1;1;1;1;1;1;1
 ;;ZA13;1;1;1;1;1;1;1;1
 ;;ZA312;1;1;1;1;1;1;1;1
 ;;ZA675;;;;;;1;1;1
COMP ;;Components
 ;;ADAPTIVE COMPRESSION;AC;64.5;64.5;64.5;64.5;64.5;64.5;64.5;64.5
 ;;CANAL RESONANCE ENHANCEMENT;CRE;21.12;21.12;21.12;21.12;21.12;21.12;21.12;21.12
 ;;FEEDBACK LIMITING TRIMMER;FEED;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;FLEX CANAL;FLEX;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;HELIX AID OPTION;HELIX;44
 ;;K-AMP;KAMP;88;88
 ;;NOISE SWITCH;NS;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;NON-ALLERGENIC CLEAR SHELL;CLEAR;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;OUTPUT CONTROL;LP;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;POWER AID OPTION - DUAL RECEIVER;POWER;44
 ;;RETENTION WING;RW;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
 ;;TELEPHONE COIL W/SWITCH;TC/S;21.12;21.12;21.12;21.12;21.12;21.12;21.12;21.12
 ;;TONE CONTROL;TONE;14.08;14.08;14.08;14.08;14.08;14.08;14.08;14.08
