FOIA11 ;SLC-ISC/RJS - SCRUB SQRM JAVA SOURCE FILES ; 09/09/2011
 ;
 K ^TMP($J)
 ;
 S HOME=$I
 ;
 ;
 S DIR="C:\TEMP"
 ;
 ;S X=$ZF(-1,"CD """_DIR_""" & ""C:\Program Files\Java\jdk1.7.0_05\bin\jar.exe"" -xf """_DIR_"\ibmpkcs.jar""")
 ;
 ;
 ;Get Directory
 ;
 D GETDIR("C:\pch\FOIA\scrub\","DIRTEXT"),FLIST
 U HOME W !!
 U HOME W !,"Initial"
 U HOME W !,"               Directories: ",$FN(DIRCNT,",")
 U HOME W !,"                     Files: ",$FN(FILECNT,",")
 ;
 ; prescan to uncompress jar files
 ;
 S JARFND=0 F  D  Q:'JARFND
 .S JARFND=0
 .S FILE="" F  S FILE=$O(^TMP($J,"FILELIST",FILE)) Q:'$L(FILE)  D
 ..Q:'($$UPCASE(FILE)[".JAR")
 ..S JARFND=1
 ..S DIR=$P(FILE,"\",1,$L(FILE,"\")-1)
 ..U HOME W !,"expanding ",FILE
 ..S X=$ZF(-1,"CD """_DIR_""" & ""C:\Program Files\Java\jdk1.7.0_05\bin\jar.exe"" -xf """_FILE_"""")
 ..S X=$ZF(-1,"DEL """_FILE_"""")
 .I JARFND D
 ..U HOME W !!,"Decompression"
 ..D GETDIR("C:\pch\FOIA\scrub\","DIRTEXT"),FLIST
 ;
 D GETDIR("C:\pch\FOIA\scrub\","DIRTEXT"),FLIST
 ;Q
 ;
 ;
 S FILE="" F C=1:1 S FILE=$O(^TMP($J,"FILELIST",FILE)) Q:'$L(FILE)  D
 .;
 .;load orig file
 .;
 .S MODIFIED=0,FILESAVE=0
 .;
 .K ^TMP($J,"FDATA")
 .D GETDATA(FILE,"FDATA")
 .;
 .U HOME W !!,"Scanning ",FILE
 .;
 .;
 .;scrub file
 .;
 .S LINE=0 F  S LINE=$O(^TMP($J,"FDATA",LINE)) Q:'LINE  D
 ..S TEXT=$G(^TMP($J,"FDATA",LINE))
 ..S LINECNT=LINECNT+1
 ..;
 ..S MODIFIED=0
 ..;
 ..;I (TEXT["XUS SIGNON SETUP") W !,LINE,": ",TEXT
 ..;Q
 ..;
 ..D REPL(.TEXT,".FORUM.VA.GOV",".DOMAIN.EXT")
 ..D REPL(.TEXT,"FORUM.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,".MED.VA.GOV",".DOMAIN.EXT")
 ..D REPL(.TEXT,"VA.GOV","DOMAIN.EXT")
 ..;
 ..I ($$UPCASE(TEXT)["VA.GOV") S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ..I (TEXT?.E1"10."1.3N1"."1.3N1"."1.3N.E),'(TEXT["10.0.0.0"),'(TEXT["127.0.0.1"),'(TEXT["derby"),'(TEXT["1.2.3.4.5.6.7.8.9.10.11.12.13.14.") S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ..;
 ..I MODIFIED D
 ...S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ...;S FILESAVE=1
 ...;S ^TMP($J,"FDATA",LINE)=TEXT
 .;
 .Q
 .Q:'FILESAVE
 .;
 .S SFILE=FILE
 .S X=$ZF(-1,"DEL """_SFILE_"""") U HOME W !!!,SFILE," deleted"
 .;
 .;save scrub file
 .;
 .U HOME W !!,"Saving ",SFILE
 .S MODE="WN"
 .O SFILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' cannot be opened for writing." Q
 .S LINE=0 F  S LINE=$O(^TMP($J,"FDATA",LINE)) Q:'LINE  D
 ..S TEXT=$G(^TMP($J,"FDATA",LINE))
 ..U SFILE W TEXT,!
 .;
 .C SFILE
 .;
 ;
 S MODCNT=0
 S FILE="" F  S FILE=$O(^TMP($J,"MODIFIED",FILE)) Q:'$L(FILE)  D
 .W !!,?5,FILE,!
 .S LINE=0 F  S LINE=$O(^TMP($J,"MODIFIED",FILE,LINE)) Q:'LINE  D
 ..W !,$J(LINE,10),": ",^TMP($J,"MODIFIED",FILE,LINE)
 ..S MODCNT=MODCNT+1
 ;
 U HOME W !!
 U HOME W !,"Final"
 U HOME W !,"               Directories: ",$FN(DIRCNT,",")
 U HOME W !,"                     Files: ",$FN(FILECNT,",")
 U HOME W !,"             Lines of Text: ",$FN(LINECNT,",")
 U HOME W !,"Lines Needing Modification: ",$FN(MODCNT,",")
 ;
 ;
 Q
 ;
FLIST ;
 ;
 U HOME W !!,"Get File List"
 K ^TMP($J,"FILELIST")
 S DIRCNT=0,FILECNT=0,LINECNT=0
 S INDEX=0,DIR="" F  S INDEX=$O(^TMP($J,"DIRTEXT",INDEX)) Q:'INDEX  D
 .S TEXT=$G(^TMP($J,"DIRTEXT",INDEX))
 .I (TEXT["Directory of ") S DIR=$P(TEXT,"Directory of ",2) S DIRCNT=DIRCNT+1 Q
 .Q:'$L($G(DIR))
 .Q:'TEXT
 .S PFILE=$P(TEXT," ",5,$L(TEXT," "))
 .Q:(PFILE=".")
 .Q:(PFILE="..")
 .Q:(TEXT["<DIR>")
 .Q:(PFILE["DIRLIST.TXT")
 .;
 .S FILECNT=FILECNT+1
 .Q:$G(^TMP($J,"FILELIST",DIR_"\"_PFILE))
 .S ^TMP($J,"FILELIST",DIR_"\"_PFILE)=1
 ;
 Q
 ;
RSUM(RTN) ;
 ;
 ; OLD STYLE
 ;
 ;N RLINE,LTEXT,CLIM,Y
 ;S Y=0 F RLINE=1,3:1 S LTEXT=$T(+RLINE),CLIM=$F(LTEXT," ") Q:'CLIM  D
 ;.S CLIM=$S($E(LTEXT,CLIM)'=";":$L(LTEXT),$E(LTEXT,CLIM+1)=";":$L(LTEXT),1:CLIM-2)
 ;.F CPTR=1:1:CLIM S Y=$A(LTEXT,CPTR)*CPTR+Y
 ;
 ;Q Y
 ; NEW STYLE
 ;
 N RLINE,LTEXT,CLIM,Y
 S Y=0 F RLINE=1,3:1 S LTEXT=$G(^TMP($J,"RTN",RTN,+RLINE,0)),CLIM=$F(LTEXT," ") Q:'CLIM  D
 .S CLIM=$S($E(LTEXT,CLIM)'=";":$L(LTEXT),$E(LTEXT,CLIM+1)=";":$L(LTEXT),1:CLIM-2)
 .F CPTR=1:1:CLIM S Y=$A(LTEXT,CPTR)*(CPTR+RLINE)+Y
 ;
 Q "B"_Y
 ;
REPL(STR,OLD,NEW) ;
 ;
 Q:'(STR[OLD)
 S MODIFIED=1
 ;
 ;U HOME W !!,+$G(LINE),"  Before: ",STR
 ;
 F  Q:'(STR[OLD)  S STR=$P(STR,OLD,1)_NEW_$P(STR,OLD,2,$L(STR,OLD))
 ;
 ;U HOME W !,+$G(LINE),"   After: ",STR
 ;
 ;
 ;
GETDATA(FILE,SUB) ;
 ;
 ;
 U HOME W !!,"GETDATA ",FILE,"  ",SUB,!!
 ;
 N EOF,INDEX,MODE,TEXT,CCNT
 ;
 K ^TMP($J,SUB)
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' not found." Q
 S (INDEX,EOF)=0,TEXT="",INDEX=1,PINDEX=0 F CCNT=0:1 D GETCHAR  Q:EOF  D
 .;
 .I '(CCNT#1000) U HOME W *13,"   ",$FN(CCNT,","),"  "
 .;
 .I '(PINDEX=INDEX) S PINDEX=INDEX
 .;
 .I (CHAR<32) S:($L(TEXT)>1) ^TMP($J,SUB,INDEX)=TEXT,INDEX=INDEX+1 S TEXT="" Q
 .I (CHAR>127) S:($L(TEXT)>1) ^TMP($J,SUB,INDEX)=TEXT,INDEX=INDEX+1 S TEXT="" Q
 .I ($L(TEXT)>32000) S:($L(TEXT)>1) ^TMP($J,SUB,INDEX)=TEXT,INDEX=INDEX+1 S TEXT="" Q
 .S TEXT=TEXT_$C(CHAR)
 .;
 ;
 C FILE
 ;
 Q
 ;
GETCHAR ;
 ;
 ;U HOME W !,"GETCHAR"
 ;
 S $ZT="ERROR^FOIA11"
 ;
 U FILE R *CHAR
 ;
 Q
 ;
GETLINE ;
 ;
 S $ZT="ERROR^FOIA10"
 ;
 U FILE R TEXT
 ;
 Q
ERROR ;
 ;
 C FILE ; U HOME W "Closed"
 S $ZT="",ERROR=0
 I ($ZE["<ENDOFFILE>") S ERROR=0,EOF=1 Q
 ;
 U HOME W !!,$ZE H 3
 S ERROR=1
 ;
 I ($ZE["<MXSTR>") U HOME W !,$G(FILE) Q
 ;
 Q
 ;
GETDIR(DIR,SUB) ;
 ;
 N CNT,EOF,ERROR,FILE,MODE,TEXT,X,DIROUT,FILENM
 ;
 U HOME W !!,"Get Directories"
 ;
 K ^TMP($J,SUB)
 S FILE=DIR_"DIRLIST.TXT"
 S X=$ZF(-1,"DEL """_FILE_"""")
 S X=$ZF(-1,"DIR /S """_DIR_""" >> """_FILE_"""")
 ;
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  Q
 S EOF=0,TEXT="" F INDEX=1:1 D GETLINE  Q:EOF  D
 .N GTEXT,FTEXT
 .F  Q:'$L(TEXT)  Q:'(TEXT["  ")  S TEXT=$P(TEXT,"  ",1)_" "_$P(TEXT,"  ",2,$L(TEXT,"  "))
 .S ^TMP($J,SUB,INDEX)=TEXT
 ;
 C FILE
 ;
 S X=$ZF(-1,"DEL """_FILE_"""")
 ;
 Q INDEX
 ;
 ;
UPCASE(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 ;
