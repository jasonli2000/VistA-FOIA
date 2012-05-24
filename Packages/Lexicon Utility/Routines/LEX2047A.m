LEX2047A ; ISL/KER - Post Install LEX*2.0*47  ; 02/05/2007
 ;;2.0;LEXICON UTILITY;**47**;Sep 23, 1996;Build 5
 ;
 ; Global Variables
 ;    ^ICPT(           DBIA 4489
 ;    ^DIC(81.3,       DBIA 4492
 ;
 ; External References
 ;    FILE^DIE         DBIA 2053
 ;    UPDATE^DIE       DBIA 2053
 ;    IX1^DIK          DBIA 10013
 ;    $$IENS^DILF      DBIA 2054
 ;    $$CODEN^ICPTCOD  DBIA 1995
 ;    $$CPT^ICPTCOD    DBIA 1995
 ;    $$MOD^ICPTMOD    DBIA 1996
 ;    $$DT^XLFDT       DBIA 10103
 ;    $$FMADD^XLFDT    DBIA 10103
 ;    MES^XPDUTL       DBIA 10141
 ;
EN ; Main Entry Point
 D C1,C2,C3,C4,C5,EN^LEX2047B
 Q
 ;
 ; Changes
C1 ;   123616 - 99212/G0245 with A8, AA, QY and 57
 D IND(" "),REMI("CPT Modifier Ranges Added for A8/AA/QY/57","HD0000000 123616")
 N CODE,PRO,MOD,MT,VDT K SHOWSTA
 S CODE="99212",VDT=3050101,PRO=$P($$CPT^ICPTCOD(CODE,(VDT+1)),"^",3)
 F MOD="A8","AA","QY","57" D
 . D:MOD="A8" IND(("    CPT Range "_CODE))
 . N ACR,PRO,MT,ND,NN,DA,DIK,MIEN S ACR=$$ACR(CODE,MOD,VDT) Q:+ACR>0
 . S MT=$$MOD^ICPTMOD(MOD,"E",(VDT+1))
 . S MIEN=+MT,MT=$P(MT,"^",3) Q:+MIEN'>0  S DA=$O(^DIC(81.3,+MIEN,10," "),-1)+1 Q:+DA'>1
 . S DA(1)=MIEN,DIK="^DIC(81.3,"_DA(1)_",10,"
 . S NN=CODE_"^"_CODE_"^"_VDT_"^",ND=DIK_DA_",0)"
 . S @ND=NN D IX1^DIK
 S CODE="G0245",PRO=$P($$CPT^ICPTCOD(CODE,(VDT+1)),"^",3)
 F MOD="A8","AA","QY","57" D
 . D:MOD="A8" IND(("    CPT Range "_CODE))
 . N ACR,PRO,MT,ND,NN,DA,DIK,MIEN S ACR=$$ACR(CODE,MOD,VDT) Q:+ACR>0
 . S MT=$$MOD^ICPTMOD(MOD,"E",(VDT+1))
 . S MIEN=+MT,MT=$P(MT,"^",3) Q:+MIEN'>0  S DA=$O(^DIC(81.3,+MIEN,10," "),-1)+1 Q:+DA'>1
 . S DA(1)=MIEN,DIK="^DIC(81.3,"_DA(1)_",10,"
 . S NN=CODE_"^"_CODE_"^"_VDT_"^",ND=DIK_DA_",0)"
 . S @ND=NN D IX1^DIK
 Q
C2 ;   174408 CPT Modifier Ranges Added for TC/26
 D IND(" "),REMI("CPT Modifier Ranges Added for TC/26","HD0000000 174408")
 N I,VDT,RANGE
 S I=0,VDT=3070101,RANGE=""
 F  D  Q:'$L($G(RANGE))
 . N EXEC,CODE,END,MIEN1,MIEN2,MOD,DA,DIK,ND,NN,ACR
 . S I=I+1,EXEC="S RANGE=$T(TC26+"_I_")" X EXEC
 . S RANGE=$P(RANGE,";;",2,299) Q:'$L(RANGE)  I '$L($TR($TR(RANGE,";","")," ","")) S RANGE="" Q
 . S CODE=$P(RANGE,";",1),END=$P(RANGE,";",2) Q:$L(CODE)'=5!($L(END)'=5)
 . S MIEN1=$P(RANGE,";",3),MIEN2=$P(RANGE,";",4) Q:+MIEN1'>0  Q:+MIEN2'>0
 . D IND(("    CPT Range "_CODE))
 . S MOD="TC",DA(1)=35,DA=MIEN1,DIK="^DIC(81.3,"_DA(1)_",10,",ND=DIK_DA_",0)",NN=CODE_"^"_END_"^"_VDT_"^"
 . S ACR=$$ACR(CODE,MOD,(VDT+1)) I +ACR'>0 S @ND=NN D IX1^DIK
 . S MOD="26",DA(1)=7,DA=MIEN2,DIK="^DIC(81.3,"_DA(1)_",10,",ND=DIK_DA_",0)",NN=CODE_"^"_END_"^"_VDT_"^"
 . S ACR=$$ACR(CODE,MOD,(VDT+1)) I +ACR'>0 S @ND=NN D IX1^DIK
 Q
 ;
C3 ;   134531 - CPT Descriptions for 83519 and 83520
 D IND(" "),REMI("CPT Descriptions for 83519 and 83520","HD0000000 134531")
 D IND("    83519 - IMMUNOASSAY, RIA")
 D IND("    83520 - IMMUNOASSAY, NONANTIBODY")
 N IENS,IENA,IENB,IEN,LEXDA,DA,DIK,DIE S IENA=$O(^ICPT(83519,61,"B",2940601,0)),IENB=$O(^ICPT(83520,61,"B",2940601,0)) Q:IENA'>0  Q:IENB'>0
 K IENS,FDA S (IEN,LEXDA(1),DA(1))=83519,(LEXDA,DA)=IENA
 S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="IMMUNOASSAY, RIA" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 K FDA S FDA(81,IEN_",",2)="IMMUNOASSAY, RIA" D FILE^DIE("","FDA") S DA=IEN,DIK="^ICPT(" D IX1^DIK
 K IENS,FDA S (IEN,LEXDA(1),DA(1))=83520,(LEXDA,DA)=IENB
 S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="IMMUNOASSAY, NONANTIBODY" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 K FDA S FDA(81,IEN_",",2)="IMMUNOASSAY, NONANTIBODY" D FILE^DIE("","FDA") S DA=IEN,DIK="^ICPT(" D IX1^DIK
 K IENS,FDA S (IEN,LEXDA,DA)=301847
 S FDA(757.01,IEN_",",.01)="Immunoassay, Analyte, Quantitative; by Radiopharmaceutical Technique (eg, RIA)"
 D FILE^DIE("","FDA") S DA=IEN,DIK="^LEX(757.01," D IX1^DIK
 Q
C4 ;   134531 - CPT Descriptions for 82270 and 82271
 D IND(" "),REMI("CPT Descriptions for 82270 and 82271","HD0000000 134531")
 D IND("    82270 - OCCULT BLOOD, FECES, SINGLE")
 D IND("    82271 - OCCULT BLOOD, OTHER SOURCES")
 N IENS,IENA,IENB,IEN,LEXDA,DA,DIK,DIE S IENA=$O(^ICPT(82270,61,"B",3060101,0)),IENB=$O(^ICPT(82271,61,"B",3060101,0)) Q:IENA'>0  Q:IENB'>0
 K IENS,FDA S (IEN,LEXDA(1),DA(1))=82270,(LEXDA,DA)=IENA
 S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="OCCULT BLOOD, FECES, SINGLE" K IENR,MSG
 D UPDATE^DIE("","FDA","IENR","MSG") K FDA S FDA(81,IEN_",",2)="OCCULT BLOOD, FECES, SINGLE" D FILE^DIE("","FDA") S DA=IEN,DIK="^ICPT(" D IX1^DIK
 K IENS,FDA S (IEN,LEXDA,DA)=333338
 S FDA(757.01,(IEN_","),.01)="Blood, Occult, by Peroxidase Activity (Eg, Guaiac), Qualitative; Feces, consec collected specimens w/ Single Determination, for Colorectal Neoplasm Screening"
 S FDA(757.01,(IEN_","),.01)=FDA(757.01,(IEN_","),.01)_" (ie, patient was provided 3 cards or single triple card for consec collection)"
 D FILE^DIE("","FDA") S DA=IEN,DIK="^LEX(757.01," D IX1^DIK
 K IENS,FDA S (IEN,LEXDA(1),DA(1))=82271,(LEXDA,DA)=IENB
 S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="OCCULT BLOOD, OTHER SOURCES" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 K FDA S FDA(81,IEN_",",2)="OCCULT BLOOD, OTHER SOURCES" D FILE^DIE("","FDA") S DA=IEN,DIK="^ICPT(" D IX1^DIK
 Q
C5 ;   138905 - CPT Descriptions for 96101-96103
 D IND(" "),REMI("CPT Descriptions for 96101-96103","HD0000000 138905")
 D IND("    96101 - PSYCH TESTING BY PSYCH/PHYS")
 D IND("    96102 - PSYCH TESTING BY TECHNICIAN")
 D IND("    96103 - PSYCH TESTING ADMIN BY COMP")
 N IENS,IENA,IENB,IEN,LEXDA,DA,DIK,DIE
 S (IEN,DA(1),LEXDA(1))=96101,(IENA,LEXDA,DA)=$O(^ICPT(IEN,61,"B",3060101,0)) I +IEN>0,+IENA>0 D
 . K IENS,FDA S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="PSYCH TESTING BY PSYCH/PHYS" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 . K IENS,DA,FDA S DA=IEN S FDA(81,IEN_",",2)="PSYCH TESTING BY PSYCH/PHYS" D FILE^DIE("","FDA")
 . K DA S DA=IEN,DIK="^ICPT(" D IX1^DIK
 S (IEN,DA(1),LEXDA(1))=96102,(IENA,LEXDA,DA)=$O(^ICPT(IEN,61,"B",3060101,0)) I +IEN>0,+IENA>0 D
 . K IENS,FDA S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="PSYCH TESTING BY TECHNICIAN" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 . K IENS,DA,FDA S DA=IEN S FDA(81,IEN_",",2)="PSYCH TESTING BY TECHNICIAN" D FILE^DIE("","FDA")
 . K DA S DA=IEN,DIK="^ICPT(" D IX1^DIK
 S (IEN,DA(1),LEXDA(1))=96103,(IENA,LEXDA,DA)=$O(^ICPT(IEN,61,"B",3060101,0)) I +IEN>0,+IENA>0 D
 . K IENS,FDA S IENS=$$IENS^DILF(.LEXDA),FDA(81.061,IENS,1)="PSYCH TESTING ADMIN BY COMP" K IENR,MSG D UPDATE^DIE("","FDA","IENR","MSG")
 . K IENS,DA,FDA S DA=IEN S FDA(81,IEN_",",2)="PSYCH TESTING ADMIN BY COMP" D FILE^DIE("","FDA")
 . K DA S DA=IEN,DIK="^ICPT(" D IX1^DIK
 Q
 ;
 ; Miscellaneous
TC26 ;   Modifiers TC and 26 Ranges
 ;;76998;76998;248;163
 ;;77001;77003;249;164
 ;;77011;77014;250;165
 ;;77021;77022;251;166
 ;;77031;77032;252;167
 ;;77051;77059;253;168
 ;;77072;77084;254;169
 ;;92025;92025;255;170
 ;;96020;96020;256;171
 ;;G0389;G0389;257;172
 ;;
 Q
ACR(X,MOD,EFF) ;   Code contained in Active Modifier Code Range
 N CODE S CODE=$G(X),MOD=$G(MOD),EFF=$G(EFF)
 N TD,CIEN,MIEN,RIEN,IEN,IEN2,BEG,END,BN,EN,CN,ACT,INA,IN,OK,NIEN,ND,NN S TD=$$FMADD^XLFDT($$DT^XLFDT,91)
 Q:'$D(^ICPT("BA",(CODE_" "))) -1  Q:'$D(^DIC(81.3,"BA",(MOD_" "))) -1  Q:EFF'?7N -1  Q:EFF'<TD -1
 S CIEN=$$CODEN^ICPTCOD(CODE),MIEN=0,IEN=0 F  S IEN=$O(^DIC(81.3,"BA",(MOD_" "),IEN)) Q:+IEN'>0  D
 . N IEN2,STA,ND S IEN2=$O(^DIC(81.3,IEN,60,"B"," "),-1),IEN2=$O(^DIC(81.3,IEN,60,"B",+IEN2," "),-1)
 . S ND=$G(^DIC(81.3,IEN,60,IEN2,0)),STA=$P(ND,"^",2) Q:+STA'>0  S MIEN=IEN
 Q:CIEN'>0 -1  Q:'$D(^ICPT(CIEN,0)) -1  Q:MIEN'>0 -1  Q:'$D(^DIC(81.3,MIEN,0)) -1
 S (OK,IEN,IN)=0 F  S IEN=$O(^DIC(81.3,MIEN,10,IEN)) Q:+IEN=0  D  Q:OK
 . N ND S ND=$G(^DIC(81.3,MIEN,10,IEN,0)),BEG=$P(ND,"^",1),END=$P(ND,"^",2),ACT=$P(ND,"^",3),INA=$P(ND,"^",4)
 . S:$L(BEG)=5&('$L(END)) END=BEG Q:$L(END)'=5  Q:$L(BEG)'=5
 . S BN=$S(BEG?1.N:+BEG,BEG?4N1A:$A($E(BEG,5))*10_$E(BEG,1,4),1:$A(BEG)_$E(BEG,2,5))
 . S EN=$S(END?1.N:+END,END?4N1A:$A($E(END,5))*10_$E(END,1,4),1:$A(END)_$E(END,2,5))
 . S CN=$S(CODE?1.N:+CODE,CODE?4N1A:$A($E(CODE,5))*10_$E(CODE,1,4),1:$A(CODE)_$E(CODE,2,5))
 . Q:CN<BN!(CN>EN)  S:+INA>0 IN=1 Q:+INA>0  S:CN'<BN&(CN'>EN) OK=1
 S X=OK
 Q X
REMI(X,Y) ;   Remedy Ticket - Indented
 N I S X=$G(X),Y=$G(Y) Q:'$L(X)
 I $L(Y) S X="    "_X F  Q:$L(X)>54  S X=X_" "
 S X=X_" "_Y S:$E(X,1)'=" " X="    "_X D MES^XPDUTL(X) Q
IND(X) ;   Indent Text
 N I S X=$G(X) Q:'$L(X)  S X="    "_X D MES^XPDUTL(X)
 Q
