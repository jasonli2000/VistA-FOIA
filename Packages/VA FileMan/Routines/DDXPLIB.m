DDXPLIB ;SFISC/DPC-EXPORT LIBRARY ;1/25/93  13:05
 ;;22.0;VA FileMan;;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
FLDNM(DDXPXTNO) ;
 N %D,%I,FLD,NAMELST,NAME
 S NAMELST=""
 S %D=$P($G(^DIST(.44,+$G(^DIPT(DDXPXTNO,105)),0)),U,2)
 S %D=$$BLDELIM^DDXP3(%D)
 S %D=$C(%D),FLD=0
 F %I=0:1 S FLD=$O(^DIPT(DDXPXTNO,100,FLD)) Q:FLD<1  D
 . S NAME=$P(^DIPT(DDXPXTNO,100,FLD,0),U,4)
 . S NAMELST=NAMELST_NAME_%D
 . Q
 S NAMELST=$P(NAMELST,%D,1,%I)
 Q NAMELST
 ;
DP123(DDXPXTNO) ;
 N FLD,FLDZO,DPLN,I,DT,LEN,DTCHAR
 S DPLN=""
 F FLD=0:0 S FLD=$O(^DIPT(DDXPXTNO,100,FLD)) Q:FLD<1  S FLDZO=^(FLD,0) D
 . S DT=$P(FLDZO,U,2)
 . S LEN=$P(FLDZO,U,3)
 . S DTCHAR=$S(DT=4:"L",DT=2:"V",DT=1:"D",1:"L")
 . S DPLN=DPLN_DTCHAR
 . F I=1:1:LEN-1 S DPLN=DPLN_">"
 . Q
 Q DPLN
 ;
DPXCEL(DDXPXTNO) ;
 N DPLN,FLD,FLDZO,LEN,I
 S DPLN=""
 F FLD=0:0 S FLD=$O(^DIPT(DDXPXTNO,100,FLD)) Q:FLD<1  S FLDZO=^(FLD,0) D
 . S LEN=$P(FLDZO,U,3)
 . S DPLN=DPLN_"|"
 . F I=1:1:LEN-1 S DPLN=DPLN_" "
 . Q
 Q DPLN
 ;
SASCOL ;
 N INPUTLN,FLD,NAME,DTYPE,DTYPEFOR,START,END,LENGTH,FLD0
 S INPUTLN="INPUT ",START=1,FLD=0
 F  S FLD=$O(^DIPT(DDXPXTNO,100,FLD)) Q:FLD<1  S FLD0=^(FLD,0) D
 . S NAME=$P(FLD0,U,4)_" ",LENGTH=$P(FLD0,U,3),DTYPE=$P(FLD0,U,2)
 . S DTYPEFOR=$S(DTYPE=4:"$ ",DTYPE=1:"YYMMDD"_LENGTH_". ",1:"")
 . S END=START+LENGTH-1
 . S INPUTLN=INPUTLN_NAME_DTYPEFOR_$S(DTYPE=1:"",1:START_"-"_END_" ")
 . S START=END+1
 . Q
 S INPUTLN=$E(INPUTLN,1,$L(INPUTLN)-1)_";"
 W INPUTLN,!,"CARDS;"
 Q
 ;
ORACTL ;
 N FLD,FLD0,DELIM,NAME,LENGTH,DTYPEFRM,END,START,POS
 S FLD=0,DELIM=$P(^DIST(.44,DDXPFFNO,0),U,2),START=1,POS=""
 W "LOAD DATA",!
 W "INFILE *",!
 W "APPEND",!
 W "INTO TABLE "_$TR($P(^DIPT(DDXPXTNO,0),U,1)," ","_"),!
 W:DELIM]"" "FIELDS TERMINATED BY '"_DELIM_"' OPTIONALLY ENCLOSED BY '""'",!
 W "("
 F  S FLD=$O(^DIPT(DDXPXTNO,100,FLD)) Q:FLD<1  W:FLD>1 ",",! S FLD0=^(FLD,0) D
 . S NAME=$P(FLD0,U,4)_" ",LENGTH=$P(FLD0,U,3)
 . S DTYPEFRM=$S($P(FLD0,U,2)=1:" DATE 'MON DD,YYYY'",1:"")
 . I LENGTH>0 D
 . . S END=START+LENGTH-1
 . . S POS="POSITION ("_START_":"_END_")"
 . . S START=END+1
 . . Q
 . W NAME_POS_DTYPEFRM
 W " )",!
 W "BEGINDATA",!
 Q
