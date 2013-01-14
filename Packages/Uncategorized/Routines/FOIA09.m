FOIA09 ;SLC-ISC/RJS - SCRUB DI KIDS FILES ; 09/09/2011
 ;
 K ^TMP($J)
 ;
 S HOME=$I
 ;
 ;
 ;Get Directory
 ;
 D GETDIR("C:\pch\FOIA\scrub\",".KID","KID")
 ;
 S FILE="" F C=1:1 S FILE=$O(^TMP($J,"KID",FILE)) Q:'$L(FILE)  D
 .;
 .;load orig file
 .;
 .S MODIFIED=0
 .;
 .Q:($E(FILE,$L(FILE))="s")
 .D GETDATA(FILE,"FDATA")
 .U HOME W !!,"Scanning ",FILE
 .;
 .;scrub file
 .;
 .S LINE=0 F  S LINE=$O(^TMP($J,"FDATA",LINE)) Q:'LINE  D
 ..S TEXT=$G(^TMP($J,"FDATA",LINE))
 ..;
 ..D REPL(.TEXT,"LAV.ISC-WASH","SRV.EXAMPLE")
 ..D REPL(.TEXT,".FORUM.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,"FORUM.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,"LAVC-WASH.MED.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,"WASH.MED.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,".MED.VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,"VA.GOV","DOMAIN.EXT")
 ..D REPL(.TEXT,"^XUSRB1","^ROUTINE")
 ..D REPL(.TEXT,"^XUSHSHP","^ROUTINE")
 ..D REPL(.TEXT,"^XUSHSH","^ROUTINE")
 ..D REPL(.TEXT,"ISWIMG","SERVER")
 ..D REPL(.TEXT,"wasimgjb1\image1","server\netshare")
 ..;
 .;
 .Q:'MODIFIED
 .;
 ..S ^TMP($J,"FDATA",LINE)=TEXT
 .;
 .;recalculate RTN checksums
 .;
 .K CKSOLD,XREF,^TMP($J,"RTN")
 .S LINE=0 F  S LINE=$O(^TMP($J,"FDATA",LINE)) Q:'LINE  D
 ..S RTEXT=$G(^TMP($J,"FDATA",LINE))
 ..Q:'$L(RTEXT)
 ..Q:'($E(RTEXT,1,7)="""RTN"",""")
 ..S VTEXT=$G(^TMP($J,"FDATA",LINE+1))
 ..;
 .;
 .S RTN="" F  S RTN=$O(^TMP($J,"RTN",RTN)) Q:'$L(RTN)  D
 ..S OLDCSUM=$P($G(^TMP($J,"FDATA",+$G(XREF(RTN)))),"^",3)
 ..S NEWCSUM=$$RSUM(RTN)
 ..Q:(OLDCSUM=NEWCSUM)
 ..U HOME W !!,RTN
 ..U HOME W !,"Old Checksum: ",OLDCSUM
 ..U HOME W !,"New Checksum: ",NEWCSUM
 ..S $P(^TMP($J,"FDATA",+$G(XREF(RTN))),"^",3)=NEWCSUM
 .;
 .;delete old scrub file if exists
 .;
 .S SFILE=FILE_"s"
 .I $G(^TMP($J,"KID",SFILE)) S X=$ZF(-1,"DEL """_SFILE_"""") U HOME W !!!,SFILE," deleted"
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
 U HOME W !!,+$G(LINE),"  Before: ",STR
 ;
 F  Q:'(STR[OLD)  S STR=$P(STR,OLD,1)_NEW_$P(STR,OLD,2,$L(STR,OLD))
 ;
 U HOME W !,+$G(LINE),"   After: ",STR
 ;
 ;
 ;
GETDATA(FILE,SUB) ;
 ;
 N EOF,INDEX,MODE,TEXT
 ;
 K ^TMP($J,SUB)
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' not found." Q
 S (INDEX,EOF)=0,TEXT="" F  D GETLINE  Q:EOF  D
 .;
 .S ^TMP($J,SUB)=$G(^TMP($J,SUB))+1
 .S ^TMP($J,SUB,^TMP($J,SUB))=TEXT
 ;
 C FILE
 ;
 Q
 ;
 ;
GETLINE ;
 ;
 S $ZT="ERROR^FOIA04"
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
GETDIR(DIR,FILTER,SUB) ;
 ;
 N CNT,EOF,ERROR,FILE,MODE,TEXT,X,DIROUT,FILENM
 ;
 S FILE=DIR_"DIRLIST.TXT"
 S X=$ZF(-1,"DEL """_FILE_"""")
 S X=$ZF(-1,"DIR /OD """_DIR_""" >> """_FILE_"""")
 ;
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  Q
 S EOF=0,TEXT="" F INDEX=1:1 D GETLINE  Q:EOF  D
 .N GTEXT,FTEXT
 .Q:'TEXT
 .F  Q:'$L(TEXT)  Q:'(TEXT["  ")  S TEXT=$P(TEXT,"  ",1)_" "_$P(TEXT,"  ",2,$L(TEXT,"  "))
 .S PFILE=$P(TEXT," ",5,$L(TEXT," "))
 .Q:(PFILE=".")
 .Q:(PFILE="..")
 .Q:'($$UPCASE(TEXT)[FILTER)
 .I (SUB="KID") S ^TMP($J,SUB,DIR_PFILE)=1 U HOME W !,DIR_PFILE_" added to list"
 ;
 ;C FILE
 ;
 S X=$ZF(-1,"DEL """_FILE_"""")
 ;
 Q INDEX
 ;
 ;
UPCASE(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 ;
 
