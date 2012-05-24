C0CNHIN   ; GPL - PROCESSING FOR OUTPUT OF NHINV ROUTINES;6/3/11  17:05
 ;;0.1;C0C;nopatch;noreleasedate;Build 2
 ;Copyright 2011 George Lilly.  Licensed under the terms of the GNU
 ;General Public License See attached copy of the License.
 ;
 ;This program is free software; you can redistribute it and/or modify
 ;it under the terms of the GNU General Public License as published by
 ;the Free Software Foundation; either version 2 of the License, or
 ;(at your option) any later version.
 ;
 ;This program is distributed in the hope that it will be useful,
 ;but WITHOUT ANY WARRANTY; without even the implied warranty of
 ;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ;GNU General Public License for more details.
 ;
 ;You should have received a copy of the GNU General Public License along
 ;with this program; if not, write to the Free Software Foundation, Inc.,
 ;51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ;
 Q
EN(ZRTN,ZDFN,ZPART,KEEP) ; GENERATE AN NHIN ARRAY FOR A PATIENT
 ;
 K GARY,GNARY,GIDX,C0CDOCID
 N GN
 K ^TMP("NHINV",$J) ; CLEAN UP FROM LAST CALL
 K ^TMP("MXMLDOM",$J) ; CLEAN UP DOM
 K ^TMP("MXMLERR",$J) ; CLEAN UP MXML ERRORS
 D GET^NHINV(.GN,ZDFN,ZPART) ; CALL NHINV ROUTINES TO PULL XML
 S GN=$P(GN,")",1)_")" ; CUT OFF THE REST OF LINE PROTOCOL
 S C0CDOCID=$$PARSE(GN,"NHINARRAY") ; PARSE WITH MXML
 D DOMO^C0CDOM(C0CDOCID,"/","ZRTN","GIDX","GARY",,"/results/") ; BLD ARRAYS
 I '$G(KEEP) K GIDX,GARY ; GET RID OF THE ARRAYS UNLESS KEEP=1
 ;D PROCESS("ZRTN",GN,"/result/",$G(KEEP))
 Q
 ;
PQRI(ZOUT,KEEP) ; RETURN THE NHIN ARRAY FOR THE PQRI XML TEMPLATE
 ;
 N ZG
 S ZG=$NA(^TMP("PQRIXML",$J))
 K @ZG
 D GETXML^C0CMXP(ZG,"PQRIXML") ; GET THE XML FROM C0C MISC XML
 N C0CDOCID
 S C0CDOCID=$$PARSE^C0CDOM(ZG,"PQRIXML") ; PARSE THE XML
 D DOMO^C0CDOM(C0CDOCID,"/","ZOUT","GIDX","GARY",,"//submission") ; BLD ARRAYS
 I '$G(KEEP) K GIDX,GARY ; GET RID OF THE ARRAYS UNLESS KEEP=1
 Q
 ;
PQRI2(ZRTN) ; RETURN THE NHIN ARRAY FOR PQRI ONE MEASURE
 ;
 ;N GG
 D GETXML^C0CMXP("GG","PQRI ONE MEASURE")
 D PROCESS(ZRTN,"GG","root",1)
 Q
 ;
PROCESS(ZRSLT,ZXML,ZREDUCE,KEEP) ; PARSE AND RUN DOMO ON XML
 ; ZRTN IS PASSED BY REFERENCE
 ; ZXML IS PASSED BY NAME
 ; IF KEEP IS 1, GARY AND GIDX ARE NOT KILLED
 ;
 N GN
 S GN=$NA(^TMP("C0CPROCESS",$J))
 K @GN
 M @GN=@ZXML
 S C0CDOCID=$$PARSE(GN,"NHINARRAY") ; PARSE WITH MXML
 K @GN
 D DOMO^C0CDOM(C0CDOCID,"/","ZRSLT","GIDX","GARY",,$G(ZREDUCE)) ; BLD ARRAYS
 I '$G(KEEP) K GIDX,GARY ; GET RID OF THE ARRAYS UNLESS KEEP=1
 Q
 ;
LOADSMRT ;
 ;
 K ^GPL("SMART")
 S GN=$NA(^GPL("SMART",1))
 I $$FTG^%ZISH("/home/george/","alex-lewis2.xml",GN,2) W !,"SMART FILE LOADED"
 Q
 ;
SMART ; TRY IT WITH SMART
 ;
 S GN=$NA(^GPL("SMART"))
 ;K ^TMP("MXMLDOM",$J)
 K ^TMP("MXMLERR",$J)
 S C0CDOCID=$$PARSE(GN,"SMART")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"//rdf:RDF/")
 ;K ^TMP("MXMLDOM",$J) ;CLEAN UP... IT'S BIG
 Q
 ;
CCR ; TRY IT WITH A CCR
 ;
 S GN=$NA(^GPL("CCR"))
 ;K ^TMP("MXMLDOM",$J)
 K ^TMP("MXMLERR",$J)
 S C0CDOCID=$$PARSE(GN,"CCR")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"//ContinuityOfCareRecord/Body/")
 ;K ^TMP("MXMLDOM",$J) ;CLEAN UP... IT'S BIG
 Q
 ;
MED ; TRY IT WITH A CCR MED SECTION
 ;
 S GN=$NA(^GPL("MED"))
 K ^TMP("MXMLDOM",$J)
 K ^TMP("MXMLERR",$J)
 S C0CDOCID=$$PARSE(GN,"MED")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"//Medications/")
 ;K ^TMP("MXMLDOM",$J) ;CLEAN UP... IT'S BIG
 Q
 ;
CCD ; TRY IT WITH A CCD
 ;
 S GN=$NA(^GPL("CCD"))
 ;K ^TMP("MXMLDOM",$J)
 K ^TMP("MXMLERR",$J)
 S C0CDOCID=$$PARSE(GN,"CCD")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"//ClinicalDocument/component/structuredBody/")
 ;K ^TMP("MXMLDOM",$J) ;CLEAN UP... IT'S BIG
 Q
 ;
TEST1 ; TEST NHINV OUTPUT IN ^GPL("NIHIN")
 ; PARSED WITH MXML
 ; RUN THROUGH XPATH
 K GARY,GIDX,C0CDOCID
 S GN=$NA(^GPL("NHIN"))
 ;S GN=$NA(^GPL("DOMI"))
 S C0CDOCID=$$PARSE(GN,"GPLTEST")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"/results/")
 K ^GPL("GNARY")
 M ^GPL("GNARY")=GNARY
 Q
 ;
TEST2 ; PUT GNARY THROUGH DOMI AND STORE XML IN ^GPL("DOMI")
 ;
 S GN=$NA(^GPL("GNARY"))
 S C0CDOCID=$$DOMI^C0CDOM(GN,,"results")
 D OUTXML^C0CDOM("G",C0CDOCID)
 K ^GPL("DOMI")
 M ^GPL("DOMI")=G
 Q
 ;
TEST3 ; TEST NHINV OUTPUT IN ^GPL("NIHIN")
 ; PARSED WITH MXML
 ; RUN THROUGH XPATH
 K GARY,GIDX,C0CDOCID
 ;S GN=$NA(^GPL("NHIN"))
 S GN=$NA(^GPL("DOMI"))
 S C0CDOCID=$$PARSE(GN,"GPLTEST")
 D DOMO^C0CDOM(C0CDOCID,"/","GNARY","GIDX","GARY",,"/results/")
 Q
 ;
DOMO(ZOID,ZPATH,ZNARY,ZXIDX,ZXPARY,ZNUM,ZREDUX) ; RECURSIVE ROUTINE TO POPULATE
 ; THE XPATH INDEX ZXIDX, PASSED BY NAME
 ; THE XPATH ARRAY XPARY, PASSED BY NAME
 ; ZOID IS THE STARTING OID
 ; ZPATH IS THE STARTING XPATH, USUALLY "/"
 ; ZNUM IS THE MULTIPLE NUMBER [x], USUALLY NULL WHEN ON THE TOP NODE
 ; ZREDUX IS THE XPATH REDUCTION STRING, TAKEN OUT OF EACH XPATH IF PRESENT
 I $G(ZREDUX)="" S ZREDUX=""
 N NEWPATH,NARY ; NEWPATH IS AN XPATH NARY IS AN NHIN MUMPS ARRAY
 N NEWNUM S NEWNUM=""
 I $G(ZNUM)>0 S NEWNUM="["_ZNUM_"]"
 S NEWPATH=ZPATH_"/"_$$TAG(ZOID)_NEWNUM ; CREATE THE XPATH FOR THIS NODE
 I $G(ZREDUX)'="" D  ; REDUX PROVIDED?
 . N GT S GT=$P(NEWPATH,ZREDUX,2)
 . I GT'="" S NEWPATH=GT
 S @ZXIDX@(NEWPATH)=ZOID ; ADD THE XPATH FOR THIS NODE TO THE XPATH INDEX
 N GA D ATT("GA",ZOID) ; GET ATTRIBUTES FOR THIS NODE
 I $D(GA) D  ; PROCESS THE ATTRIBUTES
 . N ZI S ZI=""
 . F  S ZI=$O(GA(ZI)) Q:ZI=""  D  ; FOR EACH ATTRIBUTE
 . . N ZP S ZP=NEWPATH_"/"_ZI ; PATH FOR ATTRIBUTE
 . . S @ZXPARY@(ZP)=GA(ZI) ; ADD THE ATTRIBUTE XPATH TO THE XP ARRAY
 . . I GA(ZI)'="" D ADDNARY(ZP,GA(ZI)) ; ADD THE NHIN ARRAY VALUE
 N GD D DATA("GD",ZOID) ; SEE IF THERE IS DATA FOR THIS NODE
 I $D(GD(2)) D  ;
 . M @ZXPARY@(NEWPATH)=GD ; IF MULITPLE DATA MERGE TO THE ARRAY
 E  I $D(GD(1)) D  ;
 . S @ZXPARY@(NEWPATH)=GD(1) ; IF SINGLE VALUE, ADD TO ARRAY
 . I GD(1)'="" D ADDNARY(NEWPATH,GD(1)) ; ADD TO NHIN ARRAY
 N ZFRST S ZFRST=$$FIRST(ZOID) ; SET FIRST CHILD
 I ZFRST'=0 D  ; THERE IS A CHILD
 . N ZNUM
 . N ZMULT S ZMULT=$$ISMULT(ZFRST) ; IS FIRST CHILD A MULTIPLE
 . D DOMO(ZFRST,NEWPATH,ZNARY,ZXIDX,ZXPARY,$S(ZMULT:1,1:""),ZREDUX) ; THE CHILD
 N GNXT S GNXT=$$NXTSIB(ZOID)
 I $$TAG(GNXT)'=$$TAG(ZOID) S ZNUM="" ; RESET COUNTING AFTER MULTIPLES
 I GNXT'=0 D  ;
 . N ZMULT S ZMULT=$$ISMULT(GNXT) ; IS THE SIBLING A MULTIPLE?
 . I (ZNUM="")&(ZMULT) D  ; SIBLING IS FIRST OF MULTIPLES
 . . N ZNUM S ZNUM=1 ;
 . . D DOMO(GNXT,ZPATH,ZNARY,ZXIDX,ZXPARY,ZNUM,ZREDUX) ; DO NEXT SIB
 . E  D DOMO(GNXT,ZPATH,ZNARY,ZXIDX,ZXPARY,$S(ZNUM>0:ZNUM+1,1:""),ZREDUX) ; SIB
 Q
 ;
ADDNARY(ZXP,ZVALUE) ; ADD AN NHIN ARRAY VALUE TO ZNARY
 ;
 N ZZI,ZZJ,ZZN
 S ZZI=$P(ZXP,"/",1) ; FIRST PIECE OF XPATH ARRAY
 I ZZI="" Q  ; DON'T ADD THIS ONE .. PROBABLY THE //results NODE
 S ZZJ=$P(ZXP,ZZI_"/",2) ; REST OF XPATH ARRAY
 S ZZJ=$TR(ZZJ,"/",".") ; REPLACE / WITH .
 I ZZI'["]" D  ; A SINGLETON
 . S ZZN=1
 E  D  ; THERE IS AN [x] OCCURANCE
 . S ZZN=$P($P(ZZI,"[",2),"]",1) ; PULL OUT THE OCCURANCE
 . S ZZI=$P(ZZI,"[",1) ; TAKE OUT THE [X]
 I ZZJ'="" S @ZNARY@(ZZI,ZZN,ZZJ)=ZVALUE
 Q
 ;
PARSE(INXML,INDOC) ;CALL THE MXML PARSER ON INXML, PASSED BY NAME
 ; INDOC IS PASSED AS THE DOCUMENT NAME - DON'T KNOW WHERE TO STORE THIS NOW
 ; EXTRINSIC WHICH RETURNS THE DOCID ASSIGNED BY MXML
 ;Q $$EN^MXMLDOM(INXML)
 Q $$EN^MXMLDOM(INXML,"W")
 ;
ISMULT(ZOID) ; RETURN TRUE IF ZOID IS ONE OF A MULTIPLE
 N ZN
 ;I $$TAG(ZOID)["entry" B
 S ZN=$$NXTSIB(ZOID)
 I ZN'="" Q $$TAG(ZOID)=$$TAG(ZN) ; IF TAG IS THE SAME AS NEXT SIB TAG
 Q 0
 ;
FIRST(ZOID) ;RETURNS THE OID OF THE FIRST CHILD OF ZOID
 Q $$CHILD^MXMLDOM(C0CDOCID,ZOID)
 ;
PARENT(ZOID) ;RETURNS THE OID OF THE PARENT OF ZOID
 Q $$PARENT^MXMLDOM(C0CDOCID,ZOID)
 ;
ATT(RTN,NODE) ;GET ATTRIBUTES FOR ZOID
 S HANDLE=C0CDOCID
 K @RTN
 D GETTXT^MXMLDOM("A")
 Q
 ;
TAG(ZOID) ; RETURNS THE XML TAG FOR THE NODE
 ;I ZOID=149 B ;GPLTEST
 N X,Y
 S Y=""
 S X=$G(C0CCBK("TAG")) ;IS THERE A CALLBACK FOR THIS ROUTINE
 I X'="" X X ; EXECUTE THE CALLBACK, SHOULD SET Y
 I Y="" S Y=$$NAME^MXMLDOM(C0CDOCID,ZOID)
 Q Y
 ;
NXTSIB(ZOID) ; RETURNS THE NEXT SIBLING
 Q $$SIBLING^MXMLDOM(C0CDOCID,ZOID)
 ;
DATA(ZT,ZOID) ; RETURNS DATA FOR THE NODE
 ;N ZT,ZN S ZT=""
 ;S C0CDOM=$NA(^TMP("MXMLDOM",$J,C0CDOCID))
 ;Q $G(@C0CDOM@(ZOID,"T",1))
 S ZN=$$TEXT^MXMLDOM(C0CDOCID,ZOID,ZT)
 Q
 ;
OUTXML(ZRTN,INID) ; USES C0CMXMLB (MXMLBLD) TO OUTPUT XML FROM AN MXMLDOM
 ;
 S C0CDOCID=INID
 D START^C0CMXMLB($$TAG(1),,"G")
 D NDOUT($$FIRST(1))
 D END^C0CMXMLB ;END THE DOCUMENT
 M @ZRTN=^TMP("MXMLBLD",$J)
 K ^TMP("MXMLBLD",$J)
 Q
 ;
NDOUT(ZOID) ;CALLBACK ROUTINE - IT IS RECURSIVE
 N ZI S ZI=$$FIRST(ZOID)
 I ZI'=0 D  ; THERE IS A CHILD
 . N ZATT D ATT("ZATT",ZOID) ; THESE ARE THE ATTRIBUTES MOVED TO ZATT
 . D MULTI^C0CMXMLB("",$$TAG(ZOID),.ZATT,"NDOUT^C0CMXML(ZI)") ;HAVE CHILDREN
 E  D  ; NO CHILD - IF NO CHILDREN, A NODE HAS DATA, IS AN ENDPOINT
 . ;W "DOING",ZOID,!
 . N ZD D DATA("ZD",ZOID) ;NODES WITHOUT CHILDREN HAVE DATA
 . N ZATT D ATT("ZATT",ZOID) ;ATTRIBUTES
 . D ITEM^C0CMXMLB("",$$TAG(ZOID),.ZATT,$G(ZD(1))) ;NO CHILDREN
 I $$NXTSIB(ZOID)'=0 D  ; THERE IS A SIBLING
 . D NDOUT($$NXTSIB(ZOID)) ;RECURSE FOR SIBLINGS
 Q
 ;
WNHIN(ZDFN) ; WRITES THE XML OUTPUT OF GET^NHINV TO AN XML FILE
 ;
 N GN,GN2
 D GET^NHINV(.GN,ZDFN) ; EXTRACT THE XML
 S GN2=$NA(@GN@(1))
 W $$OUTPUT^C0CXPATH(GN2,"nhin_"_ZDFN_".xml","/home/wvehr3-09/")
 Q
 ;
TESTNARY ; TEST MAKING A NHIN ARRAY
 N ZI S ZI=""
 N ZH ; DOM HANDLE
 D TEST1 ; PARSE AN NHIN RESULT INTO THE DOM
 S ZH=C0CDOCID ; SET THE HANDLE
 N ZD S ZD=$NA(^TMP("MXMLDOM",$J,ZH))
 F  S ZI=$O(@ZD@(ZI)) Q:ZI=""  D  ; FOR EACH NODE
 . N ZATT
 . D MNARY(.ZATT,ZH,ZI)
 . N ZPRE,ZN
 . S ZPRE=$$PRE(ZI)
 . S ZN=$P(ZPRE,",",2)
 . S ZPRE=$P(ZPRE,",",1)
 . ;I $D(ZATT) ZWR ZATT
 . N ZJ S ZJ=""
 . F  S ZJ=$O(ZATT(ZJ)) Q:ZJ=""  D  ; FOR EACH ATTRIBUTE
 . . W ZPRE_"["_ZN_"]"_$$TAG(ZI)_"."_ZJ_"="_ZATT(ZJ),!
 . . S GOUT(ZPRE,ZN,$$TAG(ZI)_"."_ZJ)=ZATT(ZJ)
 Q
 ;
PRE(ZNODE) ; EXTRINSIC WHICH RETURNS THE PREFIX FOR A NODE
 ;
 N GI,GI2,GPT,GJ,GN
 S GI=$$PARENT(ZNODE) ; PARENT NODE
 I GI=0 Q ""  ; NO PARENT
 S GPT=$$TAG(GI) ; TAG OF PARENT
 S GI2=$$PARENT(GI) ; PARENT OF PARENT
 I (GI2'=0)&($$TAG(GI2)'="results") S GPT=$$TAG(GI2)_"."_GPT
 S GJ=$$FIRST(GI) ; NODE OF FIRST SIB
 I GJ=ZNODE Q:$$TAG(GI)_",1"
 F GN=2:1 Q:GJ=ZNODE  D  ;
 . S GJ=$$NXTSIB(GJ) ; NEXT SIBLING
 Q GPT_","_GN
 ;
MNARY(ZRTN,ZHANDLE,ZOID) ; MAKE A NHIN ARRAY FROM A DOM NODE
 ; RETURNED IN ZRTN, PASSED BY REFERENCE
 ; ZHANDLE IS THE DOM DOCUMENT ID
 ; ZOID IS THE DOM NODE
 D ATT("ZRTN",ZOID)
 Q
 ;