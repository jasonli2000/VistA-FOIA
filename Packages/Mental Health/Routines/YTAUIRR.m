YTAUIRR ;ALB/ASF-   AUI-R REPORT ;11/15/90  16:58 ; 4/6/07 4:12pm
        ;;5.01;MENTAL HEALTH;**37,85**;Dec 30, 1994;Build 49
F0      ;
        S R="",J=1
T0      ;
        S L=200,M=0,YSKK=1,YSTL=0 G:'$D(^YTT(601,YSTEST,"S",J,"K",YSKK,0)) STND D RD
T1      ;
        I '$D(^YTT(601,YSTEST,"S",J,"K",YSKK,0)) S R=R_YSTL_"^",J=J+1 G T0
        S Y=^YTT(601,YSTEST,"S",J,"K",YSKK,0),P=1
T2      ;
        S YSIT=$P(Y,U,P) I YSIT="" S YSKK=YSKK+1 G T1
        S A=$P(Y,U,P+1),A=$A(A)-64,P=P+2
T3      ;
        I +YSIT>L S L=L+200,M=M+200 D RD G T3
        S:$E(X,+YSIT-M)=A YSTL=YSTL+$P(YSIT,"(",2) G T2
RD      ;
        S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,L\200) Q
STND    ;
        S J=1,S=""
LK      ;
        S A=$P(R,U,J) G:A="" REPT S L1=$P(^YTT(601,YSTEST,"S",J,"M"),U) I A<L1 S S=S_"0^",J=J+1 G LK
        I $D(^YTT(601,YSTEST,"S",J,"MS")) S L2=+^YTT(601,YSTEST,"S",J,"MS") I A'<L2 S S=S_$P(^YTT(601,YSTEST,"S",J,"MS"),U,A+2-L2),J=J+1 G LK
        S S=S_$P(^YTT(601,7,"S",J,"M"),U,A+2-L1)_"^",J=J+1 G LK
REPT    ;
        Q:YSTY["X"  ;--> out ASF 09/15/04
        S X1="",$P(X1,"# ",60)=""
        S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
        D DTA W !!?(72-$L(X)\2),X,!!!?4,"S C A L E",?22,"RAW   DECILE RANK"
        F J=1:1 S YSRS=$P(R,U,J) Q:YSRS=""  D:IOST?1"C-".E&($Y>21) SCR D H1:J=1,H5:J=5,H8:J=8,H13:J=13,H18:J=18,H24:J=24 W !?4,$P(^YTT(601,YSTEST,"S",J,0),U,2),?20,$J(YSRS,4,0),$J($P(S,U,J),5)," |",$E(X1,1,2*$P(S,U,J))
        Q
IR      ;
        S P0=$S(IOST?1"P".E:1,1:0),K=0,YSLFT=0 F I=1:1 Q:'$D(^YTD(601.2,YSDFN,1,YSET,1,YSED,I))  S K=K+$L(^(I))
        S K=K\10+$Y D DTA S X=$P(^YTT(601,YSTEST,"P"),U) W !!?(72-$L(X)/2),X
        W !!!?25,"--- ITEM RESPONSES ---",!! S L=200,M=0,YSIT=1 I $D(^YTD(601.2,YSDFN,1,YSTEST,1,YSHD,99)),^(99)="MMPIR" S L=800
R2      ;
        D RD S A=$L(X),B=A\10 I B S K=10 F I=1:1:B D RLN Q:YSLFT
        G:YSLFT DONE
        S K=-10*B+A I K D RLN G DONE
        G:A<200 DONE S L=L+200,M=M+200 I $D(^YTD(601.2,YSDFN,1,YSET,1,YSED,L\200)) G R2
DONE    ;
        K YSTY,X,Y,A,B,K,YSKK,L,L1,L2,M,J,YSIT,YSRS,I,P,YSMX,YSTL,YSTTL Q
RLN     ;
        W ?1 F YSKK=1:1:K W $J(YSIT,3,0)," ",$E(X,YSIT-M),"  " S YSIT=YSIT+1
        D:'P0&($Y>21) SCR:I<B W ! Q
SCR     ;
        ;  Added 5/6/94 LJA
        N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
        N N1,N2,N3,N4,P,P0,P1,P3,R,R1,S,S1,T,T1,T2,TT,V,V1,V2,V3
        N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
        ;
        F I0=1:1:(IOSL-$Y-2) W !
        N DTOUT,DUOUT,DIRUT
        S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
        W @IOF Q
DTA     ;
        D KVAR^VADPT S DFN=YSDFN
        D DEM^VADPT,PID^VADPT
        S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID"),YSBID=VA("BID")
        D KVAR^VADPT
        S X0=^YTD(601.2,YSDFN,1,YSET,1,YSED,0),YSDTA=$P(X0,U,5) S:YSDTA'="" YSDTA=$$FMTE^XLFDT(YSDTA,"5ZD")
        S YSSX=YSSEX,YSBL="           ",YSHDR=YSSSN_"  "_YSNM_YSBL_YSBL_YSBL,YSHD=DT
        S YSHDR=$E(YSHDR,1,43)_" "_YSSEX_" AGE "_$J(YSAGE,2,0)_" "_YSDT(0)_" "_$$FMTE^XLFDT(YSHD,"5ZD") W @IOF,YSHDR," ",YSDTA
        S X=$P(^YTT(601,YSTEST,"P"),U)
        W ! S X7=$P(X0,U),X8=$P(X0,U,8) I X8,X8<X7 W "Begun: ",$$FMTE^XLFDT(X8,"5ZD"),"  Finished ",$$FMTE^XLFDT(X7,"5ZD")
        W ?53,"PRINTED  ENTERED  " W:YSDTA'="" "ADMIN" Q
H1      ;
        W !,"PRIMARY SCALES",!?2,"Benefits" Q
H5      ;
        W !!?2,"Styles" Q
H8      ;
        W !!?2,"Consequences" Q
H13     ;
        W !!?2,"Concerns and Acknowledgements" Q
H18     ;
        W !!,"SECOND ORDER FACTOR SCALES" Q
H24     ;
        W !!,"GENERAL ALCOHOL INVOLVEMENT SCALE" Q
