ZRGET ; GATHER FOR KNOWLEDGE BASE
 ;COPYRIGHT ASPIRE TECHNOLOGY 1997
 ;COPYRIGHT 1997 Pittsburgh Veterans Research Corp
 W !,"Build The Knowledge Base"
 ;
 S U="^",EXECPROG="" ; K ^ZRKB
 D CALLS ;Recreates 'program call' nodes of knowledge base
GETFN R !,"Enter File number to examine:",FILENUM:120
 I '$T W !,"Time out.." Q
ADD I FILENUM=""!(FILENUM["^") G EXIT
 S USERFN=$G(^DIC(FILENUM,0)),USERFN=$P(USERFN,"^",1) W "  "_USERFN_" choosen."
 R !,"Are you sure?? Y//",ANS:30
 I "yY"'[$E(ANS,1,1) G GETFN
 S MFILENUM=FILENUM
GLOB ;GET GLOBAL NAME
 S GLOBNAM=$G(^DIC(FILENUM,0,"GL")),GLOBNAM=$E(GLOBNAM,2,999)
 W:'$D(ZFLG) !,"GLOBAL NAME=",GLOBNAM
FILENAME ;GET FILENAME
 S FILENAME=$P($G(^DIC(FILENUM,0)),"^",1)
 W:'$D(ZFLG) !,"FILENAME=",FILENAME
 S SUB(1)="DA" I FILENUM=63 S SUB(1)="LRDFN"
 S FIELDNAM=""
LOOP F  S SUBLEV=1 S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM=""  D PROCESS
 ;
EXIT ;THIS IS THE EXIT POINT...
 W:'$D(ZFLG) !,"Finished..."
 Q
 ;
PROCESS ;
 I $E(FIELDNAM,1,1)="*" Q  ;FIELD OBSOLETE THROW AWAY
 W:'$D(ZFLG) !," field=",FIELDNAM
 S FIELDNUM=$O(^DD(FILENUM,"B",FIELDNAM,""))
MULT ;HERE YOU MIGHT HAVE A MULTIPLE FIELD
 S FIELDREF=$P(^DD(FILENUM,FIELDNUM,0),"^",1)
 I +$P(^(0),"^",2) S SUBLEV=SUBLEV+1 D 
 .S SUB(SUBLEV)=$P($P(^DD(FILENUM,FIELDNUM,0),"^",4),";",1),SUBLEV=SUBLEV+1
 .S NFILENUM=FILENUM,NFIELDNUM=FIELDNUM,NFIELDNAME=FIELDNAM 
 .N FILENUM,FIELDNAM,FIELDNUM 
 .S FILENUM=+$P(^DD(NFILENUM,NFIELDNUM,0),"^",2),FIELDNAM="",N1=FILENUM 
 .S PIECE5=$P(^DD(FILENUM,.01,0),"^",5,999)
 .S SUBVAL="DA" I PIECE5["DINUM" S XPOS=$F(PIECE5,"DINUM")-5,XSTR=$E(PIECE5,XPOS,999),SUBVAL=$P(XSTR," ",1),SUBVAL=$P(SUBVAL,",",1)
 .S SUB(SUBLEV)=SUBVAL
 .D MORMULT S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM="" 
 I +$P(^DD(FILENUM,FIELDNUM,0),"^",2) Q
 W:'$D(ZFLG) " [",FIELDNUM,"]"
 S NODPIECE=$P($G(^DD(FILENUM,FIELDNUM,0)),"^",4)
 S NODE=$P(NODPIECE,";",1),PIECE=$P(NODPIECE,";",2)
 W:'$D(ZFLG) " Global loc: node=",NODE," piece=",PIECE
SET ;CREATE THE KNOWLEDGE BASE FILE
 S D=0,X=MFILENUM_"^"_FILENUM_"^"_FIELDNUM_"^"_FIELDREF_"^"_GLOBNAM
 F  S D=$O(SUB(D)) Q:D'>0  S X=X_"^"_SUB(D)
 S $P(X,"^",15)=NODE,$P(X,"^",16)=PIECE,$P(X,"^",17)="~~"_EXECPROG
 F I=1:1:10 I $D(^ZRKB(FIELDNAM,I))=0 D XPROC S ^ZRKB(FIELDNAM,I)=X Q
 Q
MORMULT ;
 W:'$D(ZFLG) !,"******* MULTIPLE FILE****>",FILENUM
 F  S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM=""  D PROCESS
 K SUB(SUBLEV),SUB(SUBLEV-1) S SUBLEV=SUBLEV-2
 Q
FIXUP ;FIX UP THE DATABASE WITH NAMES AND FOR LAB STUFF ADD HIGH/LOW
 S NAME="" F  S NAME=$O(^ZRKB(NAME)) Q:NAME=""  S NUM=0 F  S NUM=$O(^ZRKB(NAME,NUM)) Q:NUM'>0  D XPROC 
 W:'$D(ZFLG) !,"DONE.."
 Q
XPROC ;PROCESS THE FILE
 ;S X=$G(^ZRKB(NAME,1))
 S XFILENUM=$P(X,"^",1),XFRAMENUM=$P(X,"^",2)
 I +XFILENUM=63 S $P(X,"~~",2)="LABTST^ZRESUTIL"
 S XFILENAME=$O(^DD(XFILENUM,0,"NM",""))
 S XFRAMENAME=$O(^DD(XFRAMENUM,0,"NM",""))
 W:'$D(ZFLG) !,"Frame of reference=",XFRAMENAME," file=",XFILENAME
 ;S ^ZRKB(NAME,NUM)=X
 S ^ZRKB(FIELDNAM,I,"FRAME")=XFILENAME_"^"_XFRAMENAME
 ;W:'$D(ZFLG) !," Field :",NAME
 Q
 ;
 Q
LOOK S D="" F  S D=$O(^ZRKB(D)) Q:D=""  S M=0 F  S M=$O(^ZRKB(D,M)) Q:M'>0  I ^ZRKB(D,M)["CALC;" W !,D,"   ",M S ^MIKE(D,M)=^ZRKB(D,M)
 Q
CALLS ;Sets up ZRKB nodes for specific calls
 I $D(^ZRKB("AGE",1))>0 Q
 S ^ZRKB("ADDRESS",1)="CALC;ADDR^ZRESUTIL"
 S ^ZRKB("AGE",1)="CALC;AGE^ZRESUTIL"
 S ^ZRKB("APPOINTMENT LIST",1)="CALC;APP^ZRESUTL1"
 S ^ZRKB("CATH RESULTS",1)="CALC;CATH^ZRESUTL1"
 S ^ZRKB("HEALTH SUMMARY",1)="CALC;MAIN^MUSGMTS"
 S ^ZRKB("LAB CY",1)="CALC;CY^ZRESUTL1"
 S ^ZRKB("LAB EM",1)="CALC;EM^ZRESUTL1"
 S ^ZRKB("LAB SP",1)="CALC;SP^ZRESUTL1"
 S ^ZRKB("LAB TEST REQUIREMENTS",1)="CALC;^ZLRUTW"
 S ^ZRKB("MEDICATIONS",1)="CALC;MED^ZRESUTIL"
 S ^ZRKB("OPERATIONS",1)="CALC;OPER^ZRESUTL1"
 S ^ZRKB("RADIOLOGY REPORT",1)="CALC;RAD^ZRESUTIL"
 S ^ZRKB("TIME",1)="CALC;^%T"
 S ^ZRKB("TODAY",1)="CALC;DATE^ZRESUTIL"
 Q
DEL ;GET RID OF A FILES ENTRIES INTO THE KNOWLEDGE BASE
 ;THIS IS USED FOR RERUNNING AFTER ENTRIES HAVE BEEN MADE...
 R !,"Delete what file:",FILENUM:30
 I FILENUM=""!(FILENUM["^") G EXIT
 I FILENUM["?" W !,"Choose a file by number..." G DEL
 S FILNAME=$G(^DIC(FILENUM,0)),FILNAME=$P(FILNAME,"^",1)
 W " working..."
 I FILENUM=""!(FILENUM["^") W " No file chosen.. Exiting..." Q
BODY ;
 S INDN="" F  S INDN=$O(^ZRKB(INDN)) Q:INDN=""  D  ;
 .;W !,"IND=",INDN
 .S NODE=$G(^ZRKB(INDN,1)) S FILE=$P(NODE,"^",1)
 .I FILE=FILENUM W !,"Removing: "_INDN K ^ZRKB(INDN,1)
 .Q
 Q
LIST ;SHOW ALL DATA items in the knowledge base
 W !!,"Knowledge Base Data Item List",!!
 W "Object  ",?35,"File",?45,"Sub File",?54,"Field Number",!!
 S IND=""
 F  S IND=$O(^ZRKB(IND)) Q:IND=""  D  ;
 .S X=$G(^ZRKB(IND,1)) S FILE=$P(X,"^",1),SUBFIELD=$P(X,"^",2),FIELDNUM=$P(X,"^",3)
 .W IND,?35,FILE,?45," ",SUBFIELD,?53," ",FIELDNUM,!
 Q
SYN ;BUILD a synonym for an existing entry
 ;same definitions as first object
 W !,"Synonynm Builder",!
 S FLAGSYN=0
 R !,"Enter existing object:",X:300 I '$T W " Exiting.." Q
 I X=""!(X["^") K FLAGSYN,X,XX,NODE,INC W "Exiting..." Q
 I X="?" W !,*7,"You must enter an existing object, ?? for a list." G SYN
 I X="??" D LIST^ZRGET G SYN
 I $D(^ZRKB(X,1))=0 W "  not found..." g SYN
 K XX
SYN1 R !,"Enter the synonym: ",SYN
 I SYN=""!(SYN="^") G SYN
 I $D(^ZRKB(X,2))=0 D  G SYN
 .S ^ZRKB(SYN,1)=$G(^ZRKB(X,1)),^ZRKB(SYN,1,"FRAME")=$G(^ZRKB(X,1,"FRAME"))
 .W " done..."
 ;ARE THERE MORE THAN ONE OF THESE?
SYN2 I $D(^ZRKB(X,2))>0 D  G:FLAGSYN=1 SYN1 G SYN
 .S INC=-1 F  S INC=$O(^ZRKB(X,INC)) Q:INC=""  D  ;
 ..S NODE=$G(^ZRKB(X,INC))
 ..W !,INC,?4,X,"  from file:",$P(NODE,"^",1),", subfile:",$P(NODE,"^",2),", field:",$P(NODE,"^",3)
 ..S XX(INC)=X
 .R !!,"Create a synomn for which field? ",ANS:300 I '$T W !,"Exit" Q
 .I ANS=""!ANS="^" Q
 .I '$D(XX(ANS)) W "  ???",*7 Q
 .I $D(^ZRKB(SYN,1))>0 W !,"Already exists",*7 H 1 S FLAGSYN=1 Q
 .S ^ZRKB(SYN,1)=^ZRKB(XX(ANS),ANS)
 .S ^ZRKB(SYN,1,"FRAME")=^ZRKB(XX(ANS),ANS,"FRAME")
 .W " Done..."
 Q
