PRCHCS9 ;WISC/RWS,RHD-BUILD ISMS CODE SHEET DATA ;12/1/93  09:53
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ADDRS ;GET BILL TO & SHIP TO ADDRESS
 S PRCH("ST")=$P(^PRC(442,PRCHPO,1),U,3),PRCH("BI")=$P(^(12),U,6)
 S PRCH("CU")=$G(^PRC(411,PRC("SITE"),3))
 I PRCH("ST") S PRCH("ST")=$G(^PRC(411,PRC("SITE"),1,PRCH("ST"),0))
 I PRCH("BI") S PRCH("BI")=$G(^PRC(411,PRC("SITE"),4,PRCH("ST"),0))
 Q
PRIORITY S X=$S($P($G(^PRC(442,PRCHPO,1)),U,19)=1:3,$P($G(^(17)),U,9)=8:2,1:1),X=$S(PRCHN("SFC")=1:"TO",1:"SO")_X Q
SETUP ;SETUP VARIABLES - CALLED FROM INPUT TEMPLATE
 Q:'$D(PRCHPO)&0  D ADDRS S PRCHI="",PRCHI("PODATE")=$P(^PRC(442,PRCHPO,1),U,15),PRCH0=^(0) Q
ITEM ;SET UP LINE ITEM VARIABLES
 Q:PRCFASYS'="ISM"&0  S PRCHI=$O(^PRC(442,PRCHPO,2,PRCHI)),X=$S(PRCHI:PRCHI,1:"") Q:'PRCHI  S PRCHI0=^(PRCHI,0) W "." Q
 Q
BLDAR ; BUILD THE PRCHTP ARRAY
 K PRCHTP D ADDRS S PRCHTP(1)="442,"_PRCHPO_",^PRC(442,",PRCHTP(2)="442.01,PRCHLI,^PRC(442,"_PRCHPO_",2,"
 S PRCHTP(1,1)="S X=""ISM"";500"
 S PRCHTP(1,2)="S X=PRC(""SITE"");1"
 S PRCHTP(1,3)="107;63"
 S PRCHTP(1,4)="D PRIORITY^PRCHCS9;3"
 S PRCHTP(1,5)="S X=""T"";501"
 S PRCHTP(1,6)="S X=""N"";502"
 S PRCHTP(1,6)="S X=PRCHPONO;503"
 S PRCHTP(1,8)="S X=1;504"
 S PRCHTP(1,9)="S X=""|HE"";540"
 S PRCHTP(1,10)=".1;541"
 S PRCHTP(1,11)="S X=""01"";542"
 S PRCHTP(1,12)="7;543"
 S PRCHTP(1,13)="S X=PRCHLCNT;520"
 S PRCHTP(1,14)="S X=""|AC"";570"
 S PRCHTP(1,15)="1.4;78"
 S PRCHTP(1,16)="S X=PRC(""FY"");80"
 S PRCHTP(1,17)="2;81"
 S PRCHTP(1,18)="1;82"
 S PRCHTP(1,19)="S X=""|CU"";512"
 S PRCHTP(1,20)="S X=$P(^PRC(411,PRC(""SITE""),0),U,10);512.2"
 S PRCHTP(1,21)="S X=0;512.1"
 S PRCHTP(1,22)="S X=$P(PRCH(""CU""),U,1);512.3"
 S PRCHTP(1,23)="S X=$P(PRCH(""CU""),U,2);512.4"
 S PRCHTP(1,24)="S X=$P(PRCH(""CU""),U,3);512.7"
 S PRCHTP(1,25)="S X=$P(PRCH(""CU""),U,4) S:X]"""" X=$P($G(^DIC(5,X,0)),U,2);512.8"
 S PRCHTP(1,26)="S X=$P(PRCH(""CU""),U,5);512.9"
 S PRCHTP(1,27)="S X=""|BI"";513"
 S PRCHTP(1,28)="S X=$P(PRCH(""BI""),U,1);513.1"
 S PRCHTP(1,29)="S X=0;513.2"
 S PRCHTP(1,30)="S X=$P(PRCH(""BI""),U,2);513.3"
 S PRCHTP(1,32)="S X=$P(PRCH(""BI""),U,3);513.4"
 S PRCHTP(1,32)="S X=$P(PRCH(""BI""),U,4);513.5"
 S PRCHTP(1,33)="S X=$P(PRCH(""BI""),U,5);513.7"
 S PRCHTP(1,34)="S X=$P(PRCH(""BI""),U,6) S:X]"""" X=$P($G(^DIC(5,X,0)),U,2);513.8"
 S PRCHTP(1,35)="S X=$P(PRCH(""BI""),U,7);513.9"
 S PRCHTP(1,36)="S X=""|ST"";514"
 S PRCHTP(1,37)="S X=$P(PRCH(""ST""),U,1);514.2"
 S PRCHTP(1,38)="S X=0;514.1"
 S PRCHTP(1,39)="S X=$P(PRCH(""ST""),U,2);514.3"
 S PRCHTP(1,40)="S X=$P(PRCH(""ST""),U,3);514.4"
 S PRCHTP(1,41)="S X=$P(PRCH(""ST""),U,4);514.5"
 S PRCHTP(1,42)="S X=$P(PRCH(""ST""),U,5);514.7"
 S PRCHTP(1,43)="S X=$P(PRCH(""ST""),U,6) S:X]"""" X=$P($G(^DIC(5,X,0)),U,2);514.8"
 S PRCHTP(1,44)="S X=$P(PRCH(""ST""),U,7);514.9"
 S PRCHTP(1,45)="D LINE^PRCHCS9 S X=""|$"";507"
 QUIT
LINE ; TRANSFER LINE ITEM DATA OVER
 N I,J S PRCHI=0 F  S PRCHI=$O(^PRC(442,PRCHPO,2,PRCHI)) Q:'PRCHI  S X=^(PRCHI,0) W "."_PRCHI D
 .S PRCHI(0,20)="|IT"
 .S PRCHI(0,1)=$P(X,U,1)
 .S PRCHI(0,2)=$P(X,U,13)
 .S PRCHI(0,4)=$P(X,U,4)
 .S PRCHI(1,2)=$P(X,U,3)
 .S PRCHI(0,3)=$P(X,U,16)
 .S PRCHI(1,5)=$P(X,U,4)
 .S PRCHI(1,10)="0"
 .I $D(^PRC(442,PRCHPO,2,PRCHI,4)) N X4 S X4=^(4) D
 ..S PRCHI(1,6)=$P(X4,U,15)
 ..S PRCHI(1,7)=$P(X4,U,16)
 .S $P(^PRCF(423,PRCFA("CSDA"),52,0),U,3,4)=$P(^PRC(442,PRCHPO,2,0),U,3,4)
 .S I="" F  S I=$O(PRCHI(I)) Q:I=""  S J="" F  S J=$O(PRCHI(I,J)) Q:J=""  D
 ..S $P(^PRCF(423,PRCFA("CSDA"),52,PRCHI,I),U,J)=PRCHI(I,J)
 S PRCHLI="QUIT" QUIT