RJTLAB ; ;[ 06/21/95  2:40 PM ]
 S DD="" F I=0:0 S DD=$O(^LRO(68,18,1,2950000,1,DD)) Q:DD="AC"  W !,DD D SWT
 Q
SWT ;
 I $D(^LRO(68,18,1,2950000,1,DD,3)),$P(^(3),"^",5) S $P(^LRO(68,18,1,2950000,1,DD,3),"^",6)=$P(^LRO(68,18,1,2950000,1,DD,3),"^",5) S $P(^(3),"^",5)="" W !,"switched entry "_$ZR
 Q
