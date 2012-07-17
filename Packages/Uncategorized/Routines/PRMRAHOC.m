PRMRAHOC ;GLRISC/JES-AD HOC INCIDENT REPORTS ; 2/9/89  11:10 ;
 ;VERSION 1.01
 D ^PRMRDATE I $D(PRMRSTOP)#2,PRMRSTOP G QUIT
 S SEL="SELECT ",CATA=" CATEGORY TO SORT BY: ",DATA=" DATA TO PRINT: ",BLURB="ENTER NUMERIC 1 TO 14 (or press RETURN to END)",(S,P,DATE,TYPE,O2)=0,KEEP="@,",C=",",(BY,FR,TO,FLDS)=""
 F SEQ=1:1 D ASKSORT Q:O1
 G:O2 QUIT
 F SS=1:1:S S GOT="",GOT=$O(SORT(SS,GOT)),BY=BY_SORT(SS,GOT)_"," S:GOT=15 TYPE=1 S:GOT=".01" DATE=1
 S:'TYPE BY=BY_"INCIDENT TYPE,",FR=FR_C,TO=TO_C
 S:'DATE BY=BY_"DATE AND TIME,",FR=FR_PRMRNBEG_C,TO=TO_PRMRNEND_C
 S FR=$E(FR,1,$L(FR)-1),TO=$E(TO,1,$L(TO)-1)
 F ASK=0:0 D ASKPRNT Q:O1
 G:O2 QUIT
 S GOT="" F PP=1:1:P S GOT=$O(PRNT(GOT)),FLDS=FLDS_PRNT(GOT)_","
 S BY=$E(BY,1,$L(BY)-1),FLDS=$E(FLDS,1,$L(FLDS)-1),L=0,DIC="^PRMQ(513.72," D EN1^DIP
QUIT ;
 K PRMRSPOT,PRMRSTOP,PRMRENGD,PRMRNBEG,PRMRNEND,PRMR1HED,PRMR2HED,ASK,DIC,POP,L,SEQ,G,I,S,P,SOR,PRN,SOPR,SNPN,O1,O2,DUPE,TYPE,DATE,CK,SS,PP,GOT,SORT,PRNT,FLDS,BY,FR,TO,SEL,BLURB,CATA,DATA,KEEP,C,DTOUT,FIELD,%,%DT,%Y,%ZIS
 Q
ASKSORT ;
 S O1=0 W:S=0 !!?17,SEL_"MAJOR"_CATA W:S>0 !!?17,SEL_"NEXT"_CATA,!?17,"(IE., WITHIN LAST CHOSEN SORT CATEGORY)"
 W !?17,BLURB,!?17,"(MAXIMUM OF 4 SORT FIELDS ALLOWED)" D LIST R !!?18,"SELECTION: ",SOR:DTIME I (S=0)&(SOR="") D NOTHING G:%=2 ASKSORT Q:O1
 S:SOR="" O1=1 S:SOR["^" (O1,O2)=1 Q:O1!O2
 I (SOR<1)!(SOR>14)!(SOR'?1.N) W *7,!!?17,BLURB G ASKSORT
 S S=S+1 I S>4 W !!?17,"MAXIMUM OF 4 SORT FIELDS ALLOWED",*7 S O1=1,S=S-1 Q
 S FIELD=$P($T(TEXT+SOR),";;",3) D CHKDUPES G:DUPE ASKSORT D CHKELIM
 S SORT(SEQ,FIELD)=$P($T(TEXT+SOR),";;",3) Q
CHKDUPES ;
 S DUPE=0 F CK=1:1:S I $D(SORT(CK,FIELD)) S DUPE=1,S=S-1,SOPR="SORT",SNPN=SOR D DUPEMESS Q
 Q
CHKELIM ;
 I SOR=3 S FR=FR_PRMRNBEG_",",TO=TO_PRMRNEND_"," Q
 I (SOR=1)!(SOR=2) S FR=FR_C,TO=TO_C Q
 W !!?2,"DO YOU WISH TO ELIMINATE A CASE FROM THE PRINTOUT",!?2,"IF THIS PARTICULAR FIELD CONTAINS NO DATA?" S %=2,DTOUT=0 D YN^DICN I (DTOUT=1)&(%Y="^") W *7 K DTOUT G CHKELIM
 K DTOUT I %Y="^" W *7,!!?4,"""^"" NOT ALLOWED" G CHKELIM
 I %Y["?" W !!,"Enter ""N"" if you wish to print a case if this field contains no data,",!,"or enter ""Y"" if you wish eliminate cases with data in this field",!! G CHKELIM
 S %=% I (%'=1)&(%'=2) W *7 G CHKELIM
 S TO=TO_C S:%=2 FR=FR_KEEP S:%=1 FR=FR_C
 Q
ASKPRNT ;
 S O1=0 W:P=0 !!?17,SEL_"FIRST"_DATA W:P>0 !!?17,SEL_"NEXT"_DATA W !?17,BLURB D LIST R !!?18,"SELECTION: ",PRN:DTIME I (P=0)&(PRN="") D NOTHING G:%=2 ASKPRNT Q:O1
 S:PRN="" O1=1 S:PRN["^" (O1,O2)=1 Q:O1!O2
 I (PRN<1)!(PRN>14)!(PRN'?1.N) W *7,!!?17,BLURB G ASKPRNT
 S P=P+1,FIELD=$P($T(TEXT+PRN),";;",3),SOPR="PRINT",SNPN=PRN D CHKDUPEP G:DUPE ASKPRNT
 S PRNT(PRN)=$P($T(TEXT+PRN),";;",3) Q
CHKDUPEP ;
 S DUPE=0 F CK=0:0 S CK=$O(PRNT(CK)) Q:CK=""  I PRNT(CK)=FIELD S DUPE=1,P=P-1,SOPR="PRINT",SNPN=PRN D DUPEMESS Q
 Q
DUPEMESS ;
 W *7,!!?17,"YOU HAVE ALREADY CHOSEN ITEM "_SNPN_" AS A "_SOPR_" FIELD",!?17,"PLEASE RE-ENTER YOUR SELECTION" Q
NOTHING ;
 W *7,!!?2,"YOU HAVE NOT SELECTED EITHER SORT OR PRINT CATEGORY !!",!?2,"DO YOU WISH TO STOP PROCESSING AND EXIT PROGRAM? (Y/N): " S %=1,DTOUT=0 D YN^DICN I %Y="^" W *7 K DTOUT G NOREP
 I %=0 W !!,"You must answer YES or NO" G NOTHING
 G:%=-1 NOREP
 I (%'=1)&(%'=2) W *7 G NOTHING
NOREP ;
 W ! I (%=1)!(%=-1) S (O1,O2)=1 W !?2,"NO REPORT WILL BE PRODUCED",!!
 Q
LIST ;
 W ! F L=1:1:14 W !?15,$P($T(TEXT+L),";;",2)
 Q
TEXT ;;
 ;; 1 INCIDENT TYPE;;15;;INCIDENT TYPE
 ;; 2 PATIENT NAME;;1;;PATIENT NAME
 ;; 3 DATE (AND TIME) OF INCIDENT;;.01;;DATE AND TIME
 ;; 4 WARD;;8;;WARD
 ;; 5 LOCATION OF INCIDENT;;17;;LOCATION
 ;; 6 SEVERITY;;18;;SEVERITY OF INJURY
 ;; 7 FALL FACTOR;;20;;FALL FACTOR
 ;; 8 MEDICATION ERROR FACTOR;;21;;MEDICATION ERROR FACTOR
 ;; 9 RESPONSIBLE PARTY FOR MEDICATION ERROR;;21.7;;RESPONSIBLE PARTY - MED ERROR
 ;;10 PROCEDURE;;25;;PROCEDURE
 ;;11 SUSPENSE DATE;;80;;SUSPENSE DATE
 ;;12 DISPOSITION OF CASE;;79;;DISPOSITION
 ;;13 FINAL DISPOSITION DATE;;50;;FINAL DISPOSITION DATE
 ;;14 FINAL DISPOSITION AUTHORITY;;51;;FINAL DISPOSITION REACHED BY
