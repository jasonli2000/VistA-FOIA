PXRMCF  ; SLC/PKR - Handle computed findings. ;09/05/2008
        ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
        ;
        ;=======================================================
EVALFI(DFN,DEFARR,ENODE,FIEVAL) ;Evaluate computed findings.
        N FIEVT,FILENUM,FINDING,FINDPA,ITEM
        S FILENUM=$$GETFNUM^PXRMDATA(ENODE)
        S ITEM=""
        F  S ITEM=$O(DEFARR("E",ENODE,ITEM)) Q:+ITEM=0  D
        . S FINDING=""
        . F  S FINDING=$O(DEFARR("E",ENODE,ITEM,FINDING)) Q:+FINDING=0  D
        .. K FINDPA
        .. M FINDPA=DEFARR(20,FINDING)
        .. K FIEVT
        .. D FIEVAL(FILENUM,DFN,ITEM,.FINDPA,.FIEVT)
        .. M FIEVAL(FINDING)=FIEVT
        .. S FIEVAL(FINDING,"FINDING")=$P(FINDPA(0),U,1)
        Q
        ;
        ;=======================================================
EVALPL(FINDPA,ENODE,TERMARR,PLIST)      ;Patient list evaluator.
        ;Return the list in ^TMP($J,PLIST)
        N ITEM,FILENUM,PFINDPA
        N TEMP,TFINDING,TFINDPA
        S FILENUM=$$GETFNUM^PXRMDATA(ENODE)
        S ITEM=""
        F  S ITEM=$O(TERMARR("E",ENODE,ITEM)) Q:+ITEM=0  D
        . S TFINDING=""
        . F  S TFINDING=$O(TERMARR("E",ENODE,ITEM,TFINDING)) Q:+TFINDING=0  D
        .. K PFINDPA,TFINDPA
        .. M TFINDPA=TERMARR(20,TFINDING)
        ..;Set the finding parameters.
        .. D SPFINDPA^PXRMTERM(.FINDPA,.TFINDPA,.PFINDPA)
        .. D GPLIST(FILENUM,ITEM,.PFINDPA,PLIST)
        Q
        ;
        ;=======================================================
EVALTERM(DFN,FINDPA,ENODE,TERMARR,TFIEVAL)      ;General term
        ;evaluator.
        N FIEVT,FILENUM,ITEM,PFINDPA
        N TEMP,TFINDING,TFINDPA
        S FILENUM=$$GETFNUM^PXRMDATA(ENODE)
        S ITEM=""
        F  S ITEM=$O(TERMARR("E",ENODE,ITEM)) Q:+ITEM=0  D
        . S TFINDING=""
        . F  S TFINDING=$O(TERMARR("E",ENODE,ITEM,TFINDING)) Q:+TFINDING=0  D
        .. K FIEVT,PFINDPA,TFINDPA
        .. M TFINDPA=TERMARR(20,TFINDING)
        ..;Set the finding parameters.
        .. D SPFINDPA^PXRMTERM(.FINDPA,.TFINDPA,.PFINDPA)
        .. D FIEVAL(FILENUM,DFN,ITEM,.PFINDPA,.FIEVT)
        .. M TFIEVAL(TFINDING)=FIEVT
        .. S TFIEVAL(TFINDING,"FINDING")=$P(TFINDPA(0),U,1)
        Q
        ;
        ;=======================================================
FIEVAL(FILENUM,DFN,ITEM,PFINDPA,FIEVAL) ;
        ;Evaluate regular patient findings.
        N BDT,CASESEN,COND,CONVAL,DAS,DATA,DATE,EDT,FLIST,ICOND,IND
        N NFOUND,NGET,NOCC,NP,PDATA,ROUTINE
        N SAVE,SDIR,STATUSA,TEMP,TEST,TEXT,TYPE,UCIFS,VALUE,VSLIST
        ;Set the finding search parameters.
        D SSPAR^PXRMUTIL(PFINDPA(0),.NOCC,.BDT,.EDT)
        S SDIR=$S(NOCC<0:+1,1:-1)
        S TEST=PFINDPA(15)
        D SCPAR^PXRMCOND(.PFINDPA,.CASESEN,.COND,.UCIFS,.ICOND,.VSLIST)
        S NGET=$S(UCIFS:50,$D(STATUSA):50,1:NOCC)
        ;Make sure NGET has the same sign as NOCC.
        I NGET'=NOCC S NGET=NGET*($$ABS^XLFMTH(NOCC)/NOCC)
        S TEMP=^PXRMD(811.4,ITEM,0)
        S TYPE=$P(TEMP,U,5)
        I TYPE="" S TYPE="S"
        I TYPE="S" D
        . S ROUTINE=$P(TEMP,U,3)_"^"_$P(TEMP,U,2)_"(DFN,.TEST,.DATE,.VALUE,.TEXT)"
        . D @ROUTINE
        .;Make sure that the date is in range.
        . I TEST,DATE'<BDT,DATE'>EDT S NFOUND=1
        . E  S NFOUND=0
        . I NFOUND D
        .. S TEST(1)=TEST,DATE(1)=DATE,TEXT(1)=$G(TEXT)
        .. S DATA(1,"VALUE")=$G(VALUE)
        .. I $D(VALUE)=11 S IND="" F  S IND=$O(VALUE(IND)) Q:IND=""  S DATA(1,IND)=VALUE(IND)
        I TYPE="M" D
        . S ROUTINE=$P(TEMP,U,3)_"^"_$P(TEMP,U,2)_"(DFN,NGET,BDT,EDT,.NFOUND,.TEST,.DATE,.DATA,.TEXT)"
        . D @ROUTINE
        I TYPE'="S",TYPE'="M" D
        . S NFOUND=0
        . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","COMPUTED FINDING","WRONG TYPE")=TYPE_" IS NOT SUITABLE FOR REMINDER EVALUATION"
        I NFOUND=0 S FIEVAL=0 Q
        S NP=0
        F IND=1:1:NFOUND Q:NP=NOCC  D
        . S DATA(IND,"DATE")=DATE(IND)
        . I TEST(IND),COND'="" D
        .. K PDATA M PDATA=DATA(IND)
        .. S CONVAL=$$COND^PXRMCOND(CASESEN,ICOND,VSLIST,.PDATA)
        . E  S CONVAL=TEST(IND)
        . S SAVE=$S('UCIFS:1,(UCIFS&CONVAL):1,1:0)
        . I SAVE D
        .. S NP=NP+1
        .. S FIEVAL(NP)=CONVAL
        .. I COND'="" S FIEVAL(NP,"CONDITION")=CONVAL
        .. S FIEVAL(NP,"DATE")=DATE(IND)
        .. S FIEVAL(NP,"TEXT")=$G(TEXT(IND))
        .. M FIEVAL(NP)=DATA(IND)
        .. I $G(PXRMDEBG) M FIEVAL(NP,"CSUB")=DATA(IND)
        ;
        ;Save the finding result.
        D SFRES^PXRMUTIL(SDIR,NP,.FIEVAL)
        S FIEVAL("FILE NUMBER")=FILENUM
        Q
        ;
        ;=======================================================
GPLIST(FILENUM,CFIEN,PFINDPA,PLIST)     ;Add to the patient list
        ;for a regular file.
        N BDT,CASESEN,COND,CONVAL,DAS,DATE,EDT,DATA,DFN,FLIST
        N ICOND,IND,IPLIST
        N NOCC,NOCCABS,NFOUND,NGET,NP,PARAM,ROUTINE
        N SAVE,STATUSA,TEMP,TEXT,TGLIST,TPLIST,TYPE
        N UCIFS,VALUE,VSLIST
        S TEMP=^PXRMD(811.4,CFIEN,0)
        S TYPE=$P(TEMP,U,5)
        I TYPE'="L" Q
        S TGLIST="GPLIST_PXRMCF"
        S PARAM=PFINDPA(15)
        ;Set the finding search parameters.
        D SSPAR^PXRMUTIL(PFINDPA(0),.NOCC,.BDT,.EDT)
        S NOCCABS=$$ABS^XLFMTH(NOCC)
        D SCPAR^PXRMCOND(.PFINDPA,.CASESEN,.COND,.UCIFS,.ICOND,.VSLIST)
        S NGET=$S(UCIFS:50,$D(STATUSA):50,1:NOCCABS)
        K ^TMP($J,TGLIST)
        S ROUTINE=$P(TEMP,U,3)_"^"_$P(TEMP,U,2)_"(NGET,BDT,EDT,TGLIST,PARAM)"
        D @ROUTINE
        ;Routine should return:
        ;^TMP($J,TGLIST,DFN,N)=DAS_U_DATE_U_FILENUM_U_ITEM_U_VALUE
        ;Data values for condition are returned in
        ;^TMP($J,TGLIST,DFN,N,SUB)=DATA(SUB)
        S DFN=""
        F  S DFN=$O(^TMP($J,TGLIST,DFN)) Q:DFN=""  D
        . K TPLIST
        . M TPLIST=^TMP($J,TGLIST,DFN)
        . S (IND,NFOUND)=0
        . K IPLIST
        . F  S IND=$O(TPLIST(IND)) Q:(IND="")!(NFOUND=NOCCABS)  D
        .. S TEMP=TPLIST(IND)
        .. K DATA M DATA=TPLIST(IND)
        .. S CONVAL=$S(COND'="":$$COND^PXRMCOND(CASESEN,ICOND,VSLIST,.DATA),1:1)
        .. S SAVE=$S('UCIFS:1,(UCIFS&CONVAL):1,1:0)
        .. I SAVE D
        ... S NFOUND=NFOUND+1
        ... S IPLIST(CONVAL,DFN,CFIEN,NFOUND,FILENUM)=TEMP
        . M ^TMP($J,PLIST)=IPLIST
        K ^TMP($J,TGLIST)
        Q
        ;
        ;=======================================================
MHVOUT(INDENT,IFIEVAL,NLINES,TEXT)      ;Produce the MHV output.
        N DATA,DATE,FIEN,IND,JND,NAME,NOUT,PNAME,TEMP,TEXTOUT,VALUE
        S FIEN=$P(IFIEVAL("FINDING"),";",1)
        S TEMP=^PXRMD(811.4,FIEN,0)
        S PNAME=$P(TEMP,U,4)
        I PNAME="" S PNAME=$P(TEMP,U,1)
        S NAME="Computed Finding: "_PNAME_" = "
        S IND=0
        F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
        . S VALUE=$G(IFIEVAL(IND,"VALUE"))
        . S DATE=IFIEVAL(IND,"DATE")
        . S TEMP=NAME_VALUE_" ("_$$EDATE^PXRMDATE(DATE)_")"
        . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
        . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
        S NLINES=NLINES+1,TEXT(NLINES)=""
        Q
        ;
        ;=======================================================
OUTPUT(INDENT,IFIEVAL,NLINES,TEXT)      ;Produce the clinical
        ;maintenance output.
        N DATA,DATE,FIEN,IND,JND,NOUT,PNAME,TEMP,TEXTOUT,VALUE
        S FIEN=$P(IFIEVAL("FINDING"),";",1)
        S TEMP=^PXRMD(811.4,FIEN,0)
        S PNAME=$P(TEMP,U,4)
        I PNAME="" S PNAME=$P(TEMP,U,1)
        S NLINES=NLINES+1
        S TEXT(NLINES)=$$INSCHR^PXRMEXLC(INDENT," ")_"Computed Finding: "_PNAME
        S IND=0
        F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
        . S DATE=IFIEVAL(IND,"DATE")
        . S TEMP=$$EDATE^PXRMDATE(DATE)
        . S VALUE=$G(IFIEVAL(IND,"VALUE"))
        . I VALUE'="" S TEMP=TEMP_" value - "_VALUE
        .;If there is text append it.
        . I $G(IFIEVAL(IND,"TEXT"))'="" S TEMP=TEMP_"; "_IFIEVAL(IND,"TEXT")
        . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
        . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
        S NLINES=NLINES+1,TEXT(NLINES)=""
        Q
        ;
