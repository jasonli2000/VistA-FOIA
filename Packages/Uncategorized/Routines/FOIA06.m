FOIA06 ;SLC-ISC/RJS - SCRUB PSN KIDS FILES ; 09/09/2011
 ;
 K ^TMP($J)
 ;
 S HOME=$I
 ;
 ;
 ;Get Directory
 ;
 D GETDIR("C:\pch\FOIA\scrub\",".KID","KID") U HOME W !!
 ;
 S FILE="",MODIF=0,DELTEXT=0 F C=1:1 S FILE=$O(^TMP($J,"KID",FILE)) Q:'$L(FILE)  D
 .;
 .;load orig file
 .;
 .U HOME W !!,"Scanning ",FILE
 .I $G(^TMP($J,"KID",FILE_"s")) U HOME W !!,FILE,"  Already Scrubbed..."  H 1 Q
 .Q:($E(FILE,$L(FILE))="s")
 .;
 .;
 .S MODIF=0
 .D GETDATA(FILE,"FDATA")
 .;
 .;scrub file
 .;
 .S LINE=0 F  S LINE=$O(^TMP($J,"FDATA",LINE)) Q:'LINE  D
 ..S TEXTR=$G(^TMP($J,"FDATA",LINE))
 ..S TEXTV=$G(^TMP($J,"FDATA",LINE+1))
 ..S DELTEXT=0
 ..;
 ..F TARGET=50.621,50.622,50.623,50.624,50.625,50.626,50.627,"""DATA""" D  Q:DELTEXT
 ...;
 ...I (TEXTR=("""TEMP"","_TARGET_",0)")) D  Q
 ....U HOME W !!,TEXTR," = ",TEXTV
 ....S $P(TEXTV,"^",3)="",$P(TEXTV,"^",4)=""
 ....U HOME W !,TEXTR," = ",TEXTV
 ....S ^TMP($J,"FDATA",LINE)=TEXTR
 ....S ^TMP($J,"FDATA",LINE+1)=TEXTV
 ....S MODIF=1
 ...;
 ...S TTEXT="""TEMP"","_TARGET_","
 ...I ($E(TEXTR,1,$L(TTEXT))=TTEXT) D
 ....U HOME W !!,TEXTR," = ",TEXTV,"   <deleted>"
 ....K ^TMP($J,"FDATA",LINE)
 ....K ^TMP($J,"FDATA",LINE+1)
 ....S DELTEXT=1,MODIF=1
 ..;
 ..;
 ..;
 ..;
 ..;D REPL(.TEXT,"LAV.ISC-WASH","SRV.EXAMPLE")
 ..;D REPL(.TEXT,".FORUM.VA.GOV","DOMAIN.EXT")
 ..;D REPL(.TEXT,"FORUM.VA.GOV","DOMAIN.EXT")
 ..;
 ..;S ^TMP($J,"FDATA",LINE)=TEXT
 .;
 .Q:'MODIF
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
 S $ZT="ERROR^FOIA06"
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
 
