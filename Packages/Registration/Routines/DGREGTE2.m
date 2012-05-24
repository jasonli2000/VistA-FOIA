DGREGTE2        ;ALB/BAJ - Temporary & Confidential Address Support Routine; 02/27/2006
        ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
        ;
        Q
        ;
GETOLD(DGCMP,DFN,TYPE)  ;populate array with existing address info
        N CCIEN,DGCURR,CFORGN,CFSTR,L,T,DGCIEN,DGST,DGCNTY,FDESC,FNODE,FPECE,CCNTRY,COUNTRY
        S CFORGN=0,FDESC=$S(TYPE="TEMP":"TEMPORARY ADDRESS COUNTRY",1:"CONFIDENTIAL ADDR COUNTRY")
        ; get current country
        S FNODE=$S(TYPE="TEMP":.122,TYPE="CONF":.141,1:.11)
        S FPECE=$S(TYPE="TEMP":3,TYPE="CONF":16,1:10)
        S CCIEN=$P($G(^DPT(DFN,FNODE)),U,FPECE)
        I CCIEN="" S CCNTRY=$O(^HL(779.004,"D","UNITED STATES",""))
        S CFORGN=$$FORIEN^DGADDUTL(CCIEN)
        ;get current address fields and xlate to ^DIQ format
        S CFSTR=$$INPT1(DFN,CFORGN),CFSTR=$TR(CFSTR,",",";")
        ; Domestic data needs some extra fields
        ; add country field before lookup
        D GETS^DIQ(2,DFN_",",CFSTR,"EI","DGCURR")
        F L=1:1:$L(CFSTR,";") S T=$P(CFSTR,";",L),DGCMP("OLD",T)=$G(DGCURR(2,DFN_",",T,"E"))
        S COUNTRY=$$CNTRYI^DGADDUTL(CCIEN) I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
        S DGCMP("OLD",FCNTRY)=COUNTRY
        I 'CFORGN D
        . S DGCIEN=$G(DGCURR(2,DFN_",",FCOUNTY,"I"))
        . S DGST=$G(DGCURR(2,DFN_",",FSTATE,"I"))
        . S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN)
        . I DGCNTY=-1 S DGCNTY=""
        . S DGCMP("OLD",FCOUNTY)="" I DGCNTY]"" S DGCMP("OLD",FCOUNTY)=$P(DGCNTY,U)_" "_$P(DGCNTY,U,3)
        Q
INPT1(DFN,FORGN,PSTR)   ; address input prompts
        N FSTR
        ; PSTR contains the full list of address fields to be modified
        ; FSTR contains the field list based on country
        S PSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FSTATE_","_FCOUNTY_","_FZIP_","_FPROV_","_FPSTAL_","_FCNTRY_$S(TYPE="TEMP":","_FPHONE,1:"")
        S FSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FSTATE_","_FCOUNTY_","_FZIP_$S(TYPE="TEMP":","_FPHONE,1:"")
        I FORGN S FSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FPROV_","_FPSTAL_$S(TYPE="TEMP":","_FPHONE,1:"")
        Q FSTR
        ;
SURE()  ; Are you sure prompt
        N DIR,X,Y,DUOUT,DTOUT,DIRUT
        S DIR(0)="Y"
        S DIR("B")="NO"
        S DIR("A")="   SURE YOU WANT TO DELETE"
        D ^DIR
        Q Y
SKIP(DGN,DGINPUT)       ; determine whether or not to skip the prompt
        N SKIP,NULL
        S SKIP=0
        S NULL=($G(DGINPUT(FSLINE1))="")!(($G(DGINPUT(FSLINE1))="@"))
        I NULL,(DGN=FSLINE2) S SKIP=1
        S NULL=($G(DGINPUT(FSLINE2))="")!(($G(DGINPUT(FSLINE2))="@"))
        I NULL,(DGN=FSLINE3) S SKIP=1
        Q SKIP
        ;
INIT    ; initialize variables
        ; This tag reads the table at FLDDAT (below) to set relationship between
        ; variables and Field numbers.
        ;
        ; Set up array of fields needed
        N I,T,FTYPE,VNAME,FNUM,RFLD
        F I=1:1 S T=$P($T(FLDDAT+I^DGREGTE2),";;",3) Q:T="QUIT"  D
        . S FTYPE=$P(T,";",1),VNAME=$P(T,";",2),FNUM=$P(T,";",3)
        . I FTYPE=TYPE S @VNAME=FNUM
        ; Set up array of field and prompting rules
        K T,I
        F I=1:1 S T=$P($T(FLDPRMPT+I^DGREGTE2),";;",2) Q:T="QUIT"  D
        . S RFLD=$P(T,";",1) I RFLD'="ALL" S RFLD=@RFLD
        . S RPROC(RFLD,$P(T,";",2),$P(T,";",3))=$P(T,";",4)
        Q
FLDDAT  ; Table of field values STRUCTURE --> Description;;Type;Variable Name;Field Number
        ;;Street Line 1;;TEMP;FSLINE1;.1211
        ;;Street Line 2;;TEMP;FSLINE2;.1212
        ;;Street Line 3;;TEMP;FSLINE3;.1213
        ;;City;;TEMP;FCITY;.1214
        ;;State;;TEMP;FSTATE;.1215
        ;;County;;TEMP;FCOUNTY;.12111
        ;;Zip;;TEMP;FZIP;.12112
        ;;Phone;;TEMP;FPHONE;.1219
        ;;Province;;TEMP;FPROV;.1221
        ;;Postal Code;;TEMP;FPSTAL;.1222
        ;;Country;;TEMP;FCNTRY;.1223
        ;;Address Node 1;;TEMP;FNODE1;.121
        ;;Address Node 2;;TEMP;FNODE2;.122
        ;;Country data piece;;TEMP;CPEICE;3
        ;;Street Line 1;;CONF;FSLINE1;.1411
        ;;Street Line 2;;CONF;FSLINE2;.1412
        ;;Street Line 3;;CONF;FSLINE3;.1413
        ;;City;;CONF;FCITY;.1414
        ;;State;;CONF;FSTATE;.1415
        ;;County;;CONF;FCOUNTY;.14111
        ;;Zip;;CONF;FZIP;.1416
        ;;Phone;;CONF;FPHONE;
        ;;Province;;CONF;FPROV;.14114
        ;;Postal Code;;CONF;FPSTAL;.14115
        ;;Country;;CONF;FCNTRY;.14116
        ;;Address Node 1;;CONF;FNODE1;.141
        ;;Address Node 2;;CONF;FNODE2;.141
        ;;Country data piece;;CONF;CPEICE;16
        ;;QUIT;;QUIT
        ;;
FLDPRMPT        ;Table of prompts and responses STRUCTURE --> Description;;Field;Old Value;New Value;Response Code
        ;;ALL;NULL;UPCAR;REPEAT
        ;;ALL;NULL;DELETE;QUES
        ;;ALL;NULL;VALUE;OK
        ;;ALL;VALUE;UPCAR;REPEAT
        ;;ALL;VALUE;NULL;OK
        ;;ALL;VALUE;VALUE;OK
        ;;FSLINE1;NULL;NULL;REVERSE
        ;;FSLINE2;NULL;NULL;OK
        ;;FSLINE3;NULL;NULL;OK
        ;;FCITY;NULL;NULL;REVERSE
        ;;FSTATE;NULL;NULL;REVERSE
        ;;FZIP;NULL;NULL;REVERSE
        ;;FCOUNTY;NULL;NULL;REVERSE
        ;;FPROV;NULL;NULL;OK
        ;;FPSTAL;NULL;NULL;OK
        ;;FCNTRY;NULL;NULL;REVERSE
        ;;FSLINE1;VALUE;DELETE;INSTRUCT
        ;;FSLINE2;VALUE;DELETE;CONFIRM
        ;;FSLINE3;VALUE;DELETE;CONFIRM
        ;;FCITY;VALUE;DELETE;INSTRUCT
        ;;FSTATE;VALUE;DELETE;INSTRUCT
        ;;FZIP;VALUE;DELETE;INSTRUCT
        ;;FCOUNTY;VALUE;DELETE;INSTRUCT
        ;;FPROV;VALUE;DELETE;CONFIRM
        ;;FPSTAL;VALUE;DELETE;CONFIRM
        ;;FCNTRY;VALUE;DELETE;REVERSE
        ;;QUIT
        ;;
