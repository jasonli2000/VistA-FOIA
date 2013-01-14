FOIA08 ;SLC-ISC/RJS - SCRUB LEX GBL FILES ; 09/09/2011
 ;
 K ^TMP($J)
 ;
 S HOME=$I
 ;
 ;
 ;Get Directory
 ;
 D GETDIR("C:\pch\FOIA\scrub\",".GBL","GBL") U HOME W !!
 ;
 ;
 S FILE="",MODIF=0,DELTEXT=0 F C=1:1 S FILE=$O(^TMP($J,"GBL",FILE)) Q:'$L(FILE)  D
 .;
 .;load orig global
 .;
 .U HOME W !!,"Scanning ",FILE
 .;
 .I $G(^TMP($J,"GBL",FILE_"s")) U HOME W !!,FILE,"  Already Scrubbed..."  H 1 Q
 .Q:($E(FILE,$L(FILE))="s")
 .;
 .;
 .S MODIF=0 K HEADER K ^LEXM
 .D GETDATA(FILE)
 .;
 .Q:'$$VC(0)
 .;Q
 .;
 .F FMFILE=81,81.1,81.3 I $O(^LEXM(FMFILE,0)) K ^LEXM(FMFILE) U HOME W !,"Killing ",FMFILE S MODIF=1
 .;
 .;  FILE ENTRIES
 .;
 .K ^TMP($J,"XRNDX")
 .S LINE=0 F  S LINE=$O(^LEXM(757.02,LINE)) Q:'LINE  D
 ..S TEXT=^LEXM(757.02,LINE)
 ..Q:'($E(TEXT,1,14)="S ^LEX(757.02,")
 ..;
 ..S INDEX=$P(TEXT,",",2) Q:'INDEX
 ..S SUB=$P(TEXT,",",3) Q:SUB
 ..;
 ..S REF=$P(TEXT,"=",1),VAL=$P(TEXT,"=",2,$L(TEXT,"="))
 ..S D3VAL=$P(VAL,"^",3)
 ..I (D3VAL=3)!(D3VAL=4) D
 ...;
 ...U HOME:132 W !!,"BEFORE ",^LEXM(757.02,LINE)
 ...S $P(VAL,"^",2)=""
 ...S $P(VAL,"^",3)=""
 ...S ^LEXM(757.02,LINE)=REF_"="_VAL
 ...U HOME:132 W !," AFTER ",^LEXM(757.02,LINE)
 ...S ^TMP($J,"XRNDX",INDEX)=1
 ...S MODIF=1
 .;
 .;   CROSS REFERENCES
 .;
 .S LINE=0 F  S LINE=$O(^LEXM(757.02,LINE)) Q:'LINE  D
 ..S TEXT=^LEXM(757.02,LINE)
 ..Q:'($E(TEXT,1,14)="S ^LEX(757.02,")
 ..;
 ..S INDEX=$P(TEXT,",",2) Q:INDEX
 ..;
 ..S REF=$P(TEXT,"=",1),VAL=$P(TEXT,"=",2,$L(TEXT,"="))
 ..S XREF=$P(REF,",",2)
 ..S INDEX=0
 ..I (XREF="""ACT""") S INDEX=+$P(TEXT,",",6) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..I (XREF="""ACODE""") S INDEX=+$P(TEXT,",",4) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..I (XREF="""CODE""") S INDEX=+$P(TEXT,",",4) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..I (XREF="""APCODE""") S INDEX=+$P(TEXT,",",4) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..I (XREF="""ASRC""") S INDEX=+$P(TEXT,",",4) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..I (XREF="""AVA""") S INDEX=+$P(TEXT,",",6) I '$G(^TMP($J,"XRNDX",INDEX)) S INDEX=0
 ..;
 ..Q:'INDEX
 ..;
 ..U HOME W !,"KILL ^LEXM(757.02,",LINE,")=",TEXT
 ..K ^LEXM(757.02,LINE)
 ..S MODIF=1
 ..;
 ..Q
 .;
 .Q:'MODIF
 .;
 .;delete old scrub file if exists
 .;
 .S SFILE=FILE_"s"
 .I $G(^TMP($J,"GBL",SFILE)) S X=$ZF(-1,"DEL """_SFILE_"""") U HOME W !!!,SFILE," deleted"
 .;
 .Q:'$$VC(1)
 .;
 .;save scrub file
 .;
 .U HOME W !!,"Saving ",SFILE
 .S MODE="WN"
 .O SFILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' cannot be opened for writing." Q
 .F LINE=1:1:HEADER U SFILE W HEADER(LINE),!
 .S REF="^LEXM" F  S REF=$Q(@REF)  Q:'$L(REF)  D
 ..S VAL=@REF
 ..U SFILE W REF,!
 ..U SFILE W VAL,!
 .;
 .U SFILE W !!
 .;
 .C SFILE
 .;
 ;
 ;
 Q
 ;
VC(MODIFY) ;   GET Checksum for import global
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR Q:'$D(^LEXM) 0
 N LEXCK,LEXND,LEXCNT,LEXLC,LEXL,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXL=64,(LEXCNT,LEXLC)=0
 S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"
 . Q:LEXN="^LEXM(0,""NODES"")"
 . S LEXCNT=LEXCNT+1
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD
 . F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 ;
 S LEXCK=+$G(^LEXM(0,"CHECKSUM"))
 S LEXND=+$G(^LEXM(0,"NODES"))
 ;
 I '(LEXNC=LEXND) D  Q:'MODIFY 0
 .W !!!,"Node Count does not match "," Calculated: ",LEXNC,"  Stored: ",LEXND
 .I MODIFY S ^LEXM(0,"NODES")=LEXNC W "  fixed..."
 ;
 I '(LEXGCS=LEXCK) D  Q:'MODIFY 0
 .W !!!,"Checksum does not match "," Calculated: ",LEXGCS,"  Stored: ",LEXCK
 .I MODIFY S ^LEXM(0,"CHECKSUM")=LEXGCS W "  fixed..."
 ;
 S LEXCK=+$G(^LEXM(0,"CHECKSUM"))
 S LEXND=+$G(^LEXM(0,"NODES"))
 ;
 W !!
 W !,"Node Count   Calculated: ",LEXNC
 W !,"                 Stored: ",LEXND
 W !
 W !,"  Checksum   Calculated: ",LEXGCS
 W !,"                 Stored: ",LEXCK
 ;
 Q 1
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
 ;
 U HOME W !!,+$G(LINE),"  Before: ",STR
 ;
 F  Q:'(STR[OLD)  S STR=$P(STR,OLD,1)_NEW_$P(STR,OLD,2,$L(STR,OLD))
 ;
 U HOME W !,+$G(LINE),"   After: ",STR
 ;
 ;
 ;
GETDATA(FILE) ;
 ;
 N SOF,EOF,INDEX,MODE,TEXT
 ;
 K ^LEXM
 S MODE="RS"
 C FILE
 O FILE:(MODE):1 E  U HOME W !,"File: '",FILE,"' not found." Q
 S (INDEX,EOF,SOF)=0,TEXT="" F  D  Q:EOF  
 .;
 .S REF=""
 .D GETLINE
 .S GLREF=$P(TEXT,"(",1)?1"^".8UN
 .I GLREF S REF=TEXT,SOF=1
 .I 'SOF S HEADER=$G(HEADER)+1,HEADER(HEADER)=TEXT Q
 .I 'GLREF U HOME W !,TEXT Q
 .D GETLINE
 .S @REF=TEXT
 .Q
 .;
 .;S ^TMP($J,SUB,^TMP($J,SUB))=TEXT
 ;
 C FILE
 ;
 Q
 ;
 ;
GETLINE ;
 ;
 S $ZT="ERROR^FOIA08"
 ;
 U FILE R TEXT
 ;
 Q
ERROR ;
 ;
 C FILE ; U HOME W !!,FILE," Closed"
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
 .S ^TMP($J,SUB,DIR_PFILE)=1 U HOME W !,DIR_PFILE_" added to list"
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
 
