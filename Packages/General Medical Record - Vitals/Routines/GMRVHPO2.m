GMRVHPO2 ;HIRMFO/YH-HP LASER PULSE OXIMETRY/RESP. GRAPH - BOX DATA ;2/5/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN1 ;PRINT DATE
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;"
 S J=19.5,J(1)=1 D WRTLN^GMRVHG3
 ;PRINT TIME
 S J=19.1,J(1)=17 D WRTLN^GMRVHG3
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS"
RESP ;PRINT RESPIRATION
 S J=-0.3,J(1)=332 D WRTLN^GMRVHG3
POX ;PRINT PULSE OXIMETRY
 S J=-0.7,J(1)=382 D WRTLN^GMRVHG3
LMIN ;PRINT L/MIN
 S J=-1.1,J(1)=1431 D WRTLN^GMRVHG3
PCNT ;PRINT % DATA
 S J=-1.5,J(1)=1451 D WRTLN^GMRVHG3
METHOD ;PRINT METHOD
 S J=-1.9,J(1)=1471 D WRTLN^GMRVHG3
 ;PRINT PULSE
 S J=-2.3,J(1)=511 D WRTLN^GMRVHG3
 ;PRINT QUALIFIER
 S J=-2.7,J(1)=531 D WRTLN^GMRVHG3
 Q