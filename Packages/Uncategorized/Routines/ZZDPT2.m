ZZDPT2 ;CHECKS FOR MISSING "SSN" XREF
 ;
EN ;
 S N=0
 F I=0:0 S N=$O(^DPT(N)) Q:N=""!('$D(^DPT(N,0)))  D CHECKS  
 Q
CHECKS ; 
 S X=$P(^DPT(N,0),"^",9)
 I X="" S ^UTILITY($J,"BLANKSSN",N)="" Q
 S:'$D(^DPT("SSN",X)) ^UTILITY($J,"NOXREF",N)=X
 Q
