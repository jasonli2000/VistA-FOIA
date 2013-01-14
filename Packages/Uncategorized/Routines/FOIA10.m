FOIA10 ;SLC-ISC/RJS - SCRUB MDWS JAVA SOURCE FILES ; 09/09/2011
 ;
 K ^TMP($J)
 ;
 S HOME=$I
 ;
 ;
 ;Get Directory
 ;
 D GETDIR("C:\pch\FOIA\scrub\","DIRTEXT")
 ;
 ;
 K ^TMP($J,"FILELIST")
 ;
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
 .U HOME W !!,"Scanning ",FILE
 .;
 .;Q
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
 ..D REPL(.TEXT,"//10.162.2.255/","//127.0.0.1/")
 ..D REPL(.TEXT,"//10.2.28.196:443/","//127.0.0.1:21/")
 ..D REPL(.TEXT,"//10.2.28.197:7010/","//127.0.0.1:21/")
 ..D REPL(.TEXT,"port=""15500""","port=""21""")
 ..D REPL(.TEXT,"port=""19014""","port=""21""")
 ..D REPL(.TEXT,"port=""9010""","port=""21""")
 ..D REPL(.TEXT,"port=""9011""","port=""21""")
 ..D REPL(.TEXT,"port=""9012""","port=""21""")
 ..D REPL(.TEXT,"port=""9200""","port=""21""")
 ..D REPL(.TEXT,"port=""9205""","port=""21""")
 ..D REPL(.TEXT,"port=""9207""","port=""21""")
 ..D REPL(.TEXT,"port=""9215""","port=""21""")
 ..D REPL(.TEXT,"port=""9220""","port=""21""")
 ..D REPL(.TEXT,"port=""9300""","port=""21""")
 ..D REPL(.TEXT,"port=""9441""","port=""21""")
 ..D REPL(.TEXT,"port=""9474""","port=""21""")
 ..D REPL(.TEXT,"port=""9476""","port=""21""")
 ..D REPL(.TEXT,"port=""9503""","port=""21""")
 ..D REPL(.TEXT,"port=""9565""","port=""21""")
 ..D REPL(.TEXT,"port=""9586""","port=""21""")
 ..D REPL(.TEXT,"port=""9593""","port=""21""")
 ..D REPL(.TEXT,"port=""9604""","port=""21""")
 ..D REPL(.TEXT,"port=""9611""","port=""21""")
 ..D REPL(.TEXT,"port=""9620""","port=""21""")
 ..D REPL(.TEXT,"port=""9621""","port=""21""")
 ..D REPL(.TEXT,"port=""9693""","port=""21""")
 ..D REPL(.TEXT,"port=""9694""","port=""21""")
 ..D REPL(.TEXT,"port=""9700""","port=""21""")
 ..D REPL(.TEXT,"port=""9705""","port=""21""")
 ..D REPL(.TEXT,"port=""9900""","port=""21""")
 ..D REPL(.TEXT,"port=""19201""","port=""21""")
 ..D REPL(.TEXT,"port=""19202""","port=""21""")
 ..D REPL(.TEXT,"port=""19203""","port=""21""")
 ..D REPL(.TEXT,"port=""19204""","port=""21""")
 ..D REPL(.TEXT,"port=""19205""","port=""21""")
 ..D REPL(.TEXT,"port=""19206""","port=""21""")
 ..D REPL(.TEXT,"port=""19207""","port=""21""")
 ..D REPL(.TEXT,"port=""19208""","port=""21""")
 ..D REPL(.TEXT,"port=""19209""","port=""21""")
 ..D REPL(.TEXT,"port=""19210""","port=""21""")
 ..D REPL(.TEXT,"port=""19211""","port=""21""")
 ..D REPL(.TEXT,"port=""19212""","port=""21""")
 ..D REPL(.TEXT,"port=""19213""","port=""21""")
 ..D REPL(.TEXT,"port=""19214""","port=""21""")
 ..D REPL(.TEXT,"port=""19215""","port=""21""")
 ..D REPL(.TEXT,"port=""19216""","port=""21""")
 ..D REPL(.TEXT,"port=""19217""","port=""21""")
 ..D REPL(.TEXT,"port=""19218""","port=""21""")
 ..D REPL(.TEXT,"port=""19219""","port=""21""")
 ..D REPL(.TEXT,"port=""19220""","port=""21""")
 ..D REPL(.TEXT,"port=""19221""","port=""21""")
 ..D REPL(.TEXT,"port=""19222""","port=""21""")
 ..D REPL(.TEXT,"port=""19223""","port=""21""")
 ..D REPL(.TEXT,"port=""19224""","port=""21""")
 ..D REPL(.TEXT,"port=""19225""","port=""21""")
 ..D REPL(.TEXT,"port=""19226""","port=""21""")
 ..D REPL(.TEXT,"port=""19227""","port=""21""")
 ..D REPL(.TEXT,"port=""19228""","port=""21""")
 ..D REPL(.TEXT,"port=""19229""","port=""21""")
 ..D REPL(.TEXT,"port=""19230""","port=""21""")
 ..D REPL(.TEXT,"port=""19231""","port=""21""")
 ..D REPL(.TEXT,"port=""19232""","port=""21""")
 ..D REPL(.TEXT,"port=""5500""","port=""21""")
 ..D REPL(.TEXT,"port=""8080""","port=""21""")
 ..D REPL(.TEXT,"port=""9600""","port=""21""")
 ..D REPL(.TEXT,"source=""10.1.19.122""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.174.3.107""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.186.128.214""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.189.110.69""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.2.29.142""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.238.38.68""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.30.23.20""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.37.92.52""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.229.201""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.229.203""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.229.30""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.229.36""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.229.50""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.230.151""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.4.230.251""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.5.20.132""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.69.61.101""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.89.23.40""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.93.80.143""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.93.81.20""","source=""127.0.0.1""")
 ..D REPL(.TEXT,"source=""10.98.4.72""","source=""127.0.0.1""")
 ..;
 ..I (TEXT?.E1"10."1.3N1"."1.3N1"."1.3N.E),'(TEXT["10.0.0.0"),'(TEXT["127.0.0.1") S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ..I (TEXT["port="""),'(TEXT["port=""21"""),$P(TEXT,"port=""",2) S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ..;
 ..I MODIFIED D
 ...S ^TMP($J,"MODIFIED",FILE,LINE)=$G(^TMP($J,"FDATA",LINE))
 ...S FILESAVE=1
 ...S ^TMP($J,"FDATA",LINE)=TEXT
 .;
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
 W !,"               Directories: ",DIRCNT
 W !,"                     Files: ",FILECNT
 W !,"             Lines of Text: ",LINECNT
 W !,"Lines Needing Modification: ",MODCNT
 ;
 ;
 Q
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
 ;U HOME W !!,"GETDATA ",FILE,"  ",SUB
 ;
 N EOF,INDEX,MODE,TEXT
 ;
 K ^TMP($J,SUB)
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' not found." Q
 S (INDEX,EOF)=0,TEXT="",INDEX=1,PINDEX=0 F  D GETCHAR  Q:EOF  D
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
 S $ZT="ERROR^FOIA10"
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
 
