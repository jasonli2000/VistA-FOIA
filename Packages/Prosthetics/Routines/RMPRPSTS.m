RMPRPSTS ;HISC/RVD/HNC - POST INIT FOR UNKNOWN HCPCS CONVERSION;6/11/98
 ;;3.0;PROSTHETICS;**32**,Jun 11,1998
 W !,$C(7),"Invalid Entry......"
 Q
START ;
 S U="^"
 W !!,"***** CONVERTING UNKNOWN HCPCS...."
 S I=0
 F  S I=$O(^RMPR(660,I)) Q:I'>0  D
 .S RMDAT1=($G(^RMPR(660,I,1)))
 .I $P(RMDAT1,U,4)=2430 S $P(^RMPR(660,I,0),U,22)=101067
 ;re-cross reference the 4.1 field
 K ^RMPR(660,"G")
 S DIK="^RMPR(660,",DIK(1)="4.1^G" D ENALL^DIK
 W !!!,$C(7),"***** UNKNOWN HCPCS CONVERSION IS DONE!!!!"
KILL K I,RMDAT0
 Q
