OCXOZ0A ;SLC/RJS,CLA - Order Check Scan ;NOV 3,2010 at 19:22
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,221,243**;Dec 17,1997;Build 242
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ; ***************************************************************
 ; ** Warning: This routine is automatically generated by the   **
 ; ** Rule Compiler (^OCXOCMP) and ANY changes to this routine  **
 ; ** will be lost the next time the rule compiler executes.    **
 ; ***************************************************************
 ;
 Q
 ;
CHK217 ; Look through the current environment for valid Event/Elements for this patient.
 ;  Called from CHK201+16^OCXOZ09.
 ;
 Q:$G(OCXOERR)
 ;
 ;    Local CHK217 Variables
 ; OCXDF(37) ---> Data Field: PATIENT IEN (NUMERIC)
 ; OCXDF(67) ---> Data Field: CONTRAST MEDIA CODE (FREE TEXT)
 ; OCXDF(70) ---> Data Field: RECENT BARIUM STUDY TEXT (FREE TEXT)
 ; OCXDF(121) --> Data Field: RECENT BARIUM STUDY ORDER STATUS (FREE TEXT)
 ;
 ;      Local Extrinsic Functions
 ; FILE(DFN,67, -----> FILE DATA IN PATIENT ACTIVE DATA FILE  (Event/Element: RECENT BARIUM STUDY ORDERED)
 ; RECBAR( ----------> RECENT BARIUM STUDY
 ; RECBARST( --------> RECENT BARIUM ORDER STATUS
 ;
 I $L(OCXDF(67)),(OCXDF(67)["B") S OCXDF(70)=$P($$RECBAR(OCXDF(37),48),"^",3),OCXDF(121)=$P($$RECBARST(OCXDF(37),48),"^",2),OCXOERR=$$FILE(DFN,67,"70,121") Q:OCXOERR 
 Q
 ;
CHK227 ; Look through the current environment for valid Event/Elements for this patient.
 ;  Called from CHK163+14^OCXOZ07.
 ;
 Q:$G(OCXOERR)
 ;
 ;    Local CHK227 Variables
 ; OCXDF(37) ---> Data Field: PATIENT IEN (NUMERIC)
 ; OCXDF(43) ---> Data Field: OI NATIONAL ID (FREE TEXT)
 ; OCXDF(74) ---> Data Field: VA DRUG CLASS (FREE TEXT)
 ;
 ;      Local Extrinsic Functions
 ;
 S OCXDF(74)=$P($$ENVAC^PSJORUT2(OCXDF(43)),"^",2) I $L(OCXDF(74)),(OCXDF(74)="AMINOGLYCOSIDES") S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) D CHK232
 Q
 ;
CHK232 ; Look through the current environment for valid Event/Elements for this patient.
 ;  Called from CHK227+12.
 ;
 Q:$G(OCXOERR)
 ;
 ;    Local CHK232 Variables
 ; OCXDF(37) ---> Data Field: PATIENT IEN (NUMERIC)
 ; OCXDF(64) ---> Data Field: FORMATTED RENAL LAB RESULTS (FREE TEXT)
 ; OCXDF(76) ---> Data Field: CREATININE CLEARANCE (ESTIM) VALUE (NUMERIC)
 ;
 ;      Local Extrinsic Functions
 ; CRCL( ------------> CREATININE CLEARANCE (ESTIMATED/CALCULATED)
 ; FILE(DFN,71, -----> FILE DATA IN PATIENT ACTIVE DATA FILE  (Event/Element: AMINOGLYCOSIDE ORDER SESSION)
 ; FLAB( ------------> FORMATTED LAB RESULTS
 ;
 S OCXDF(64)=$$FLAB(OCXDF(37),"SERUM CREATININE^SERUM UREA NITROGEN","SERUM SPECIMEN"),OCXDF(76)=$P($$CRCL(OCXDF(37)),"^",2),OCXOERR=$$FILE(DFN,71,"64,76") Q:OCXOERR 
 Q
 ;
CHK236 ; Look through the current environment for valid Event/Elements for this patient.
 ;  Called from CHK199+10^OCXOZ09.
 ;
 Q:$G(OCXOERR)
 ;
 ;    Local CHK236 Variables
 ; OCXDF(37) ---> Data Field: PATIENT IEN (NUMERIC)
 ; OCXDF(67) ---> Data Field: CONTRAST MEDIA CODE (FREE TEXT)
 ; OCXDF(73) ---> Data Field: ORDERABLE ITEM IEN (NUMERIC)
 ; OCXDF(78) ---> Data Field: PATIENT TOO BIG FOR SCANNER FLAG (BOOLEAN)
 ;
 ;      Local Extrinsic Functions
 ; CLIST( -----------> STRING CONTAINS ONE OF A LIST OF VALUES
 ; CTMRI( -----------> CT MRI PHYSICAL LIMITS
 ; FILE(DFN,106, ----> FILE DATA IN PATIENT ACTIVE DATA FILE  (Event/Element: RADIOLOGY PROCEDURE CONTAINS NON-BARIUM CONTRAST MEDIA)
 ;
 S OCXDF(37)=$G(DFN) I $L(OCXDF(37)) S OCXDF(78)=$P($$CTMRI(OCXDF(37),OCXDF(73)),"^",1) I $L(OCXDF(78)),(OCXDF(78)) D CHK241^OCXOZ0B
 S OCXDF(67)=$$CM^ORQQRA(OCXDF(73)) I $L(OCXDF(67)),$$CLIST(OCXDF(67),"M,I,N") S OCXOERR=$$FILE(DFN,106,"") Q:OCXOERR 
 Q
 ;
CLIST(DATA,LIST) ;   DOES THE DATA FIELD CONTAIN AN ELEMENT IN THE LIST
 ;
 N PC F PC=1:1:$L(LIST,","),0 I PC,$L($P(LIST,",",PC)),(DATA[$P(LIST,",",PC)) Q
 Q ''PC
 ;
CRCL(DFN) ;  Compiler Function: CREATININE CLEARANCE (ESTIMATED/CALCULATED)
 ;
 N HT,AGE,SEX,SCR,SCRD,CRCL,LRWKLD,RSLT,ORW,ORH,PSCR
 N HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW
 S RSLT="0^<Unavailable>"
 S PSCR="^^^^^^0"
 D VITAL^ORQQVI("WEIGHT","WT",DFN,.ORW,0,"",$$NOW^XLFDT)
 Q:'$D(ORW) RSLT
 S ABW=$P(ORW(1),U,3) Q:+$G(ABW)<1 RSLT
 S ABW=ABW/2.2  ;ABW (actual body weight) in kg
 D VITAL^ORQQVI("HEIGHT","HT",DFN,.ORH,0,"",$$NOW^XLFDT)
 Q:'$D(ORH) RSLT
 S HT=$P(ORH(1),U,3) Q:+$G(HT)<1 RSLT
 S AGE=$$AGE^ORQPTQ4(DFN) Q:'AGE RSLT
 S SEX=$P($$SEX^ORQPTQ4(DFN),U,1) Q:'$L(SEX) RSLT
 S OCXTL="" Q:'$$TERMLKUP^ORB31(.OCXTL,"SERUM CREATININE") RSLT
 S OCXTLS="" Q:'$$TERMLKUP^ORB31(.OCXTLS,"SERUM SPECIMEN") RSLT
 S SCR="",OCXT=0 F  S OCXT=$O(OCXTL(OCXT)) Q:'OCXT  D
 .S OCXTS=0 F  S OCXTS=$O(OCXTLS(OCXTS)) Q:'OCXTS  D
 ..S SCR=$$LOCL^ORQQLR1(DFN,$P(OCXTL(OCXT),U),$P(OCXTLS(OCXTS),U))
 ..I $P(SCR,U,7)>$P(PSCR,U,7) S PSCR=SCR
 S SCR=PSCR,SCRV=$P(SCR,U,3) Q:+$G(SCRV)<.01 RSLT
 S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 ;
 S HTGT60=$S(HT>60:(HT-60)*2.3,1:0)  ;if ht > 60 inches
 I HTGT60>0 D
 .S IBW=$S(SEX="M":50+HTGT60,1:45.5+HTGT60)  ;Ideal Body Weight
 .S BWRATIO=(ABW/IBW)  ;body weight ratio
 .S BWDIFF=$S(ABW>IBW:ABW-IBW,1:0)
 .S LOWBW=$S(IBW<ABW:IBW,1:ABW)
 .I BWRATIO>1.3,(BWDIFF>0) S ADJBW=((0.3*BWDIFF)+IBW)
 .E  S ADJBW=LOWBW
 I +$G(ADJBW)<1 D
 .S ADJBW=ABW
 S CRCL=(((140-AGE)*ADJBW)/(SCRV*72))
 ;
 S:SEX="M" RSLT=SCRD_U_$J(CRCL,1,1)
 S:SEX="F" RSLT=SCRD_U_$J((CRCL*.85),1,1)
 Q RSLT
 ;
CTMRI(DFN,OCXOI) ;  Compiler Function: CT MRI PHYSICAL LIMITS
 ;
 N OCXDEV,OCXWTP,OCXHTP,OCXWTL,OCXHTL
 S OCXDEV=$$TYPE^ORKRA(OCXOI)
 Q:'((OCXDEV="MRI")!(OCXDEV="CT")) 0_U
 S OCXWTP=$P($$WT^ORQPTQ4(DFN),U,2),OCXHTP=$P($$HT^ORQPTQ4(DFN),U,2)
 I (OCXDEV="CT") S OCXWTL=$$GET^XPAR("ALL","ORK CT LIMIT WT",1,"Q"),OCXHTL=$$GET^XPAR("ALL","ORK CT LIMIT HT",1,"Q")
 I (OCXDEV="CT"),(OCXWTL),(OCXWTP>OCXWTL) Q 1_U_"too heavy"_U_"CT scanner"
 I (OCXDEV="CT"),(OCXHTL),(OCXHTP>OCXHTL) Q 1_U_"too tall"_U_"CT scanner"
 I (OCXDEV="MRI") S OCXWTL=$$GET^XPAR("ALL","ORK MRI LIMIT WT",1,"Q"),OCXHTL=$$GET^XPAR("ALL","ORK MRI LIMIT HT",1,"Q")
 I (OCXDEV="MRI"),(OCXWTL),(OCXWTP>OCXWTL) Q 1_U_"too heavy"_U_"MRI scanner"
 I (OCXDEV="MRI"),(OCXHTL),(OCXHTP>OCXHTL) Q 1_U_"too tall"_U_"MRI scanner"
 Q 0_U
 ;
FILE(DFN,OCXELE,OCXDFL) ;     This Local Extrinsic Function logs a validated event/element.
 ;
 N OCXTIMN,OCXTIML,OCXTIMT1,OCXTIMT2,OCXDATA,OCXPC,OCXPC,OCXVAL,OCXSUB,OCXDFI
 S DFN=+$G(DFN),OCXELE=+$G(OCXELE)
 ;
 Q:'DFN 1 Q:'OCXELE 1 K OCXDATA
 ;
 S OCXDATA(DFN,OCXELE)=1
 F OCXPC=1:1:$L(OCXDFL,",") S OCXDFI=$P(OCXDFL,",",OCXPC) I OCXDFI D
 .S OCXVAL=$G(OCXDF(+OCXDFI)),OCXDATA(DFN,OCXELE,+OCXDFI)=OCXVAL
 ;
 M ^TMP("OCXCHK",$J,DFN)=OCXDATA(DFN)
 ;
 Q 0
 ;
FLAB(DFN,OCXLIST,OCXSPEC) ;  Compiler Function: FORMATTED LAB RESULTS
 ;
 Q:'$G(DFN) "<Patient Not Specified>"
 Q:'$L($G(OCXLIST)) "<Lab Tests Not Specified>"
 N OCXLAB,OCXOUT,OCXPC,OCXSL,SPEC S OCXOUT="",SPEC=""
 I $L($G(OCXSPEC)) S OCXSL=$$TERMLKUP(OCXSPEC,.OCXSL)
 F OCXPC=1:1:$L(OCXLIST,U) S OCXLAB=$P(OCXLIST,U,OCXPC) I $L(OCXLAB) D
 .N OCXX,OCXY,X,Y,DIC,TEST,SPEC,OCXTL,OCXA,OCXR
 .S OCXTL="" Q:'$$TERMLKUP(OCXLAB,.OCXTL)
 .S OCXX="",TEST=0 F  S TEST=$O(OCXTL(TEST)) Q:'TEST  D
 ..I $L($G(OCXSL)) D
 ...S SPEC=0 F  S SPEC=$O(OCXSL(SPEC)) Q:'SPEC  D
 ....S OCXX=$$LOCL^ORQQLR1(DFN,TEST,SPEC) I $L(OCXX) D
 .....S OCXA($P(OCXX,U,7))=OCXX
 ..I '$L($G(OCXSL)) S OCXX=$$LOCL^ORQQLR1(DFN,TEST,"")
 ..Q:'$L(OCXX)
 .I $D(OCXA) S OCXR="",OCXR=$O(OCXA(OCXR),-1),OCXX=OCXA(OCXR)
 .I $L(OCXX) D
 ..S OCXY=$P(OCXX,U,2)_": "_$P(OCXX,U,3)_" "_$P(OCXX,U,4)
 ..S OCXY=OCXY_" "_$S($L($P(OCXX,U,5)):"["_$P(OCXX,U,5)_"]",1:"")
 ..I $L($P(OCXX,U,7)) S OCXY=OCXY_" "_$$FMTE^XLFDT($P(OCXX,U,7),"2P")
 .S:$L(OCXOUT) OCXOUT=OCXOUT_"   " S OCXOUT=OCXOUT_$G(OCXY)
 Q:'$L(OCXOUT) "<Results Not Found>" Q OCXOUT
 ;
RECBAR(DFN,HOURS) ;  Compiler Function: RECENT BARIUM STUDY
 ;
 Q:'$G(DFN) 0 Q:'$G(HOURS) 0 N OUT S OUT=$$RECENTBA^ORKRA(DFN,HOURS) Q:'$L(OUT) 0 Q 1_U_OUT
 ;  
 ;
RECBARST(DFN,HOURS)    ;  Compiler Function: RECENT BARIUM ORDER STATUS
 ;
 Q:'$G(DFN) 0 Q:'$G(HOURS) 0
 N ORDER S ORDER=$P($$RECENTBA^ORKRA(DFN,HOURS),U) Q:'$L(ORDER) 0
 N STATUS S STATUS=$P($$STATUS^ORQOR2(ORDER),U,2) Q:'$L(STATUS) 0
 Q 1_U_STATUS
 ;
TERMLKUP(OCXTERM,OCXLIST) ;
 Q $$TERM^OCXOZ01(OCXTERM,.OCXLIST)
 ;
