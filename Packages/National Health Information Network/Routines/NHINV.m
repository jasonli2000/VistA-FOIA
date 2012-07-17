NHINV ;SLC/MKB - Serve VistA data as XML via RPC
 ;;1.0;NHIN;;Oct 25, 2010;Build 14
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^SC                          10040
 ; DIQ                           2056
 ; MPIF001                       2701
 ; VASITE                       10112
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ;
GET(NHIN,DFN,TYPE,START,STOP,MAX,ID) ; -- Return search results as XML in @NHIN@(n)
 ; RPC = NHIN GET VISTA DATA
 N ICN,NHINI
 S NHIN=$NA(^TMP($J,"NHINV")) K @NHIN
 ;
 ; parse & validate input parameters
 S ICN=+$P(DFN,";",2),DFN=+$G(DFN)
 I 'DFN S DFN=+$$GETDFN^MPIF001(ICN)
 I DFN<1!'$D(^DPT(DFN)) D ERR(1,DFN) G GTQ
 S TYPE=$G(TYPE) I TYPE="" S TYPE=$$ALL
 S START=$G(START),STOP=$G(STOP),MAX=$G(MAX),ID=$G(ID)
 S:'START START=1410101 S:'STOP STOP=9999998 S:'MAX MAX=999999
 I START,STOP,STOP<START N X S X=START,START=STOP,STOP=X  ;switch
 I STOP,$L(STOP,".")<2 S STOP=STOP_".24"
 ;
 ; extract data
 N NHINTYPE,NHINP,RTN
 S NHINTYPE=TYPE D ADD("<results>")
 F NHINP=1:1:$L(NHINTYPE,";") S TYPE=$P(NHINTYPE,";",NHINP) I $L(TYPE) D
 . S RTN="EN^"_$$RTN(TYPE) Q:'$L($T(@RTN))  ;D ERR(2) Q
 . D @(RTN_"(DFN,START,STOP,MAX,ID)")
 D ADD("</results>")
 ;
GTQ ; end
 Q
 ;
UPD(DFN,TYPE,ID) ; -- send message that TYPE/ID has been updated
 Q
 ;
RTN(X) ; -- Return name of NHINVxxx routine for clinical type X
 S X=$$UP^XLFSTR(X),Y=""
 I X="ALLERGY"      S Y="NHINVART"
 I X="CONSULT"      S Y="NHINVCON"
 I X="DOCUMENT"     S Y="NHINVTIU"
 I X="IMMUNIZATION" S Y="NHINVIMM"
 I X="LAB"          S Y="NHINVLR"
 I X="MED"          S Y="NHINVPS"
 I X="RX"           S Y="NHINVPSO"
 I X="ORDER"        S Y="NHINVOR"
 I X="PATIENT"      S Y="NHINVPT"
 I X="PROBLEM"      S Y="NHINVPL"
 I X="PROCEDURE"    S Y="NHINVMC"
 I X="SURGERY"      S Y="NHINVSR"
 I X="VISIT"        S Y="NHINVSIT"
 ; X="VISITDATA"    S Y="NHINVPCE"
 I X="VITAL"        S Y="NHINVIT"
 I X="XRAY"         S Y="NHINVRA"
 Q Y
 ;
ALL() ; -- return string for all types of data
 Q "patient;allergy;problem;vital;lab;med;immunization;visit;document"
 ;
ERR(X,VAL) ; -- return error message
 N MSG
 I X=1  S MSG="Patient with dfn '"_$G(VAL)_"' not found"
 I X=2  S MSG="Requested data type '"_$G(VAL)_"' not found"
 I X=99 S MSG="Unknown request"
 ;
 D ADD("<error>")
 D ADD("<message>"_MSG_"</message>")
 D ADD("</error>")
 Q
 ;
ESC(X) ; -- escape outgoing XML
 ; Q $ZCONVERT(X,"O","HTML")  ; uncomment for fastest performance on Cache
 ;
 N I,Y,QOT S QOT=""""
 S Y=$P(X,"&") F I=2:1:$L(X,"&") S Y=Y_"&amp;"_$P(X,"&",I)
 S X=Y,Y=$P(X,"<") F I=2:1:$L(X,"<") S Y=Y_"&lt;"_$P(X,"<",I)
 S X=Y,Y=$P(X,">") F I=2:1:$L(X,">") S Y=Y_"&gt;"_$P(X,">",I)
 S X=Y,Y=$P(X,"'") F I=2:1:$L(X,"'") S Y=Y_"&apos;"_$P(X,"'",I)
 S X=Y,Y=$P(X,QOT) F I=2:1:$L(X,QOT) S Y=Y_"&quot;"_$P(X,QOT,I)
 Q Y
 ;
ADD(X) ; Add a line @NHIN@(n)=X
 S NHINI=$G(NHINI)+1
 S @NHIN@(NHINI)=X
 Q
 ;
STRING(ARRAY) ; -- Return text in ARRAY(n) or ARRAY(n,0) as a string
 N I,X,Y S Y=""
 S I=+$O(ARRAY("")) I I=0 S I=+$O(ARRAY(0))
 S Y=$S($D(ARRAY(I,0)):ARRAY(I,0),1:$G(ARRAY(I)))
 F  S I=$O(ARRAY(I)) Q:I<1  D
 . S X=$S($D(ARRAY(I,0)):ARRAY(I,0),1:ARRAY(I))
 . S Y=Y_$C(13,10)_X
 Q Y
 ;
FAC(X) ; -- return Institution file station# for location X
 N HLOC,FAC,Y0,Y S Y=""
 S HLOC=$G(^SC(+$G(X),0)),FAC=$P(HLOC,U,4) ;Institution ien
 ; Get P4 via Med Ctr Div, if not directly linked
 I 'FAC,$P(HLOC,U,15) S FAC=$$GET1^DIQ(40.8,+$P(HLOC,U,15)_",",.07,"I")
 S Y0=$S(FAC:$$NS^XUAF4(FAC),1:$P($$SITE^VASITE,U,2,3)) ;name^stn#
 S:$L(Y0) Y=$P(Y0,U,2)_U_$P(Y0,U) ;switch to stn#^name
 I $L(Y),'Y S $P(Y,U)=FAC
 Q Y
 ;
VUID(IEN,FILE) ; -- Return VUID for item
 Q $$GET1^DIQ(FILE,IEN_",",99.99)
