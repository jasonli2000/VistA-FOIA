SRTPTM2 ;BIR/SJA - TRANSPLANT TRANSMISSION ;05/07/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K SRA,VALM S SRA(0)=^SRT(SRTPP,0),DFN=$P(SRA(0),"^"),SRA(.11)=$G(^SRT(SRTPP,.11)) D ADD^VADPT
LN14 ;Other Cardiomyopathy
 S SRSHEMP=$E(SRSHEMP,1,11)_" 14",SRACNT=SRACNT+1
 S TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRSHEMP_$E($P(SRA(.11),"^",15),1,60)
LN15 S SRSHEMP=$E(SRSHEMP,1,11)_" 15",SRACNT=SRACNT+1
 S TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRSHEMP_$J($E(SRANAME,1,40),40)_$J(VAPA(8),20)
LN16 S SRSHEMP=$E(SRSHEMP,1,11)_" 16",SRACNT=SRACNT+1
 S SRSHEMP=SRSHEMP_$J(VAPA(1),35)_$J(VAPA(2),30),TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRSHEMP
LN17 S SRSHEMP=$E(SRSHEMP,1,11)_" 17",SRACNT=SRACNT+1
 S SRSHEMP=SRSHEMP_$J(VAPA(3),30)_$J(VAPA(4),15)
 K DA,DIC,DIQ,DR,SRY S X=$P(VAPA(5),"^") I X S DIC=5,DA=X,DR=1,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 S X=SRY(5,$P(VAPA(5),"^"),1,"E")
 S SRSHEMP=SRSHEMP_$J(X,5)
 S X=$S($P(VAPA(11),"^",2)'="":$P(VAPA(11),"^",2),1:VAPA(6)),TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRSHEMP_$J(X,10)
 Q
