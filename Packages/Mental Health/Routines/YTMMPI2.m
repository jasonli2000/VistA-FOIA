YTMMPI2 ;ALB/ASF-MMPI2 REPORT; ;4/21/92  08:53
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S J=1,(YSTR,YSFR,YSQR)=0 F I=1:1:3 I $D(^YTD(601.2,YSDFN,1,YSET,1,YSED,I)) S X=^(I),L=$L(X) F K=1:1:L S:$E(X,K)="X" YSQR=YSQR+1 S:$E(X,K)="T" YSTR=YSTR+1 S:$E(X,K)="F" YSFR=YSFR+1
T0 ;
 S L=200,M=0,YSKK=1,YSTL=0 D RD
T01X ;
 I '$D(^YTT(601,YSTEST,"S",J,"K",YSKK,0)) S A(J)=YSTL,J=J+1 G T0:J<14,RD1
 S Y=^YTT(601,YSTEST,"S",J,"K",YSKK,0),P=1
T03X ;
 S YSIT=$P(Y,U,P) I YSIT="" S YSKK=YSKK+1 G T01X
 S B=$P(Y,U,P+1),P=P+2
T3 ;
 I YSIT>L S L=L+200,M=M+200 D RD G T3
 S:$E(X,YSIT-M)=B YSTL=YSTL+1 G T03X
RD ;
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,L\200) Q
RD1 ;
MF ;SCALE 5 FIX
 S YSND=$S(YSSX="F":"FK",1:"MK"),Y=^YTT(601,YSTEST,"S",8,YSND)
 F P=1,3,5,7 S YSIT=$P(Y,U,P),B=$P(Y,U,P+1) S X=$S(YSIT>200:$E(^YTD(601.2,YSDFN,1,YSET,1,YSED,2),YSIT-200),1:$E(^YTD(601.2,YSDFN,1,YSET,1,YSED,1),YSIT)) S:X=B A(8)=A(8)+1
 S R="" F I=1:1:13 S R=R_A(I)_U
 K A S YSRNK=R
K ;CORRECTION SCALE MODIFIER
 S X=$P(R,U,3) S $P(R,U,4)=$P(R,U,4)+$J(X*.5,0,0) S $P(R,U,7)=$P(R,U,7)+$J(X*.4,0,0) S $P(R,U,10)=$P(R,U,10)+X S $P(R,U,11)=$P(R,U,11)+X S $P(R,U,12)=$P(R,U,12)+$J(X*.2,0,0)
ST ;
 S S="",J=1,P=YSSX
LK ;
 S A=$P(R,U,J) G:A="" K0 S L1=$P(^YTT(601,YSTEST,"S",J,P),U) I A<L1 S YSTVL=$P(^(P),U,2) G LK1
 S YSTVL=$P(^(P),U,A+2-L1) I YSTVL="" S YSTVL=$P(^(P),U,$L(^(P),"^"))
LK1 ;
 S S=S_YSTVL_"^",J=J+1 G LK
K0 ;
 K YSTVL S (YSSCALEB,YSSCALE)=S,YSRAW=R
HD ;
 S DOT=YSHD,YSNS=13,V(3)="",YSSK="B",YSSNM="L ,F ,K ,HS,D ,HY,PD,MF,PA,PT,SC,MA,SI"
 S X="   M M P I 2   P R O F I L E      ",Y=70-$L(X)\2 W @IOF,!!?Y,X,$P(^YTT(601,YSTEST,0),U) D ^YTMMPI2P G:YSLFT END
BOTTM ;
 W !?YSLM+6 F I=1:1:YSNS W $E($P(YSSNM,",",I)_"    ",1,4)
 W !?2,"Raw Score:" F I=1:1:YSNS W $J($P(YSRNK,U,I),4) W:I=3 " "
 S X=$P(R,U,3) W !!?2,"K Corr.",?27,$J(X*.5,2,0),?$X+10,$J(X*.4,2,0),?$X+10,$J(X,2),"  ",$J(X,2),"  ",$J(X*.2,2,0)
 W !!?2,"T Score:  " F I=1:1:YSNS W $J($P(S,U,I),4) W:I=3 " "
 W !!?2,"? Cannot Say (Raw): ",YSQR,?35,"F-K (Raw): ",$P(R,U,2)-$P(R,U,3)
 W !?2,"Percent True:",$J(YSTR/$P(^YTT(601,YSTEST,0),U,11)*100,3,0),?$X+7,"Percent False:",$J(YSFR/$P(^YTT(601,YSTEST,0),U,11)*100,3,0),?$X+7,"Profile Elev.:"
 S X=0 F I=4,5,6,7,9,10,11,12 S X=X+$P(S,U,I)
 W $J(X/8,5,1)
WC ;WELSH CODE
 S YSULON="",YSULOF="",Z=2
 ;I IO=0 S YSULON="*27,*91,*52,*109",YSULOF=HL ; *** PC ***
 ;I IO>0 S YSULON="*27,*45,1",YSULOF="*27,*45,0"
 I $D(^%ZIS(2,IO,6)) S YSULON=$P(^%ZIS(2,IO,6),U,4),YSULOF=$P(^(6),U,5)
 K ^UTILITY($J,"YTMMPI2") F I=4:1:13 S X=999-$P(S,U,I),X1=$S(I=13:0,1:I-3) S:'$D(^UTILITY($J,"YTMMPI2",X)) ^(X)="" S ^(X)=^(X)_X1
 W !!?2,"Welsh Code (new): " S X=0,Z=2
 F  S X=$O(^UTILITY($J,"YTMMPI2",X)) Q:'X  S X1=^(X),X2=999-X,Y=X,Y=$O(^UTILITY($J,"YTMMPI2",Y)) S:Y Y=999-Y D UL:$L(X1)>1!(X2-Y<2) W X1 S Z1=Z D:(X2-Y>1) ULOF:Z1=1,NUL:Z1'=1 D WCM
 K ^UTILITY($J,"YTMMPI2") F I=1,2,3 S X=999-$P(S,U,I),X1=$S(I=1:"L",I=2:"F",1:"K") S:'$D(^UTILITY($J,"YTMMPI2",X)) ^(X)="" S ^(X)=^(X)_X1
 W "   " S X=0,Z=2
 F  S X=$O(^UTILITY($J,"YTMMPI2",X)) Q:'X  S X1=^(X),X2=999-X,Y=X,Y=$O(^UTILITY($J,"YTMMPI2",Y)) S:Y Y=999-Y D UL:$L(X1)>1!(X2-Y<2) W X1 S Z1=Z D:(X2-Y>1) ULOF:Z1=1,NUL:Z1'=1 D WCM
 W:YSULON="" "   unable to show ties"
 W !! D DTA^YTMMPI2P,WAIT^YTMMPI2P G:YSLFT END
OUT ;
 K X1,X2,X3,DIC D:^YTT(601,YSTEST,0)?1"MMPI2".E SUP^YTMMPI2A
END ;
 K A,B,C,G,H,I,J,K,L,L1,M,N,P,R,S,V,X,X1,X2,X3,Y,YSAST,YSB1,YSB2,YSBV,YSCNT,YSF,YSFR,YSHS,YSINC,YSIN2,YSIT,YSIT1,YSIT2,YSKK,YSKY,YSLE,YSLL,YSLM,YSLV,YSN,YSND,YSNS,YSOFF,YSQR,YSRAW,YSRNK,YSSCALE,YSSCALEB
 K YSSK,YSSNM,YSSNM1,YSTL,YSTR,YSTV,YSTVL,YSULON,YSULOF,YSVS Q
UL ;
 W:Z=0 " " W:$L(YSULON) @YSULON S Z=1 Q
ULOF ;
 W:$L(YSULOF) @YSULOF S Z=0 Q
NUL ;
 S Z=2 Q
WCM ;
 S N=0 F K=100:-10:30 S N=N+1 I (X2>(K-1))&(Y<K) W $P("**^*^""^'^-^/^:^#",U,N) S:Z=0 Z=2 Q:Y<1
