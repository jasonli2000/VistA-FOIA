DIARR3	;SFISC/DCM-ARCHIVING FUNCTION, FIGURE OUT FG ;3/15/93  7:55 AM
	;;22.2T1;VA FILEMAN;;Dec 14, 2012
	;Per VHA Directive 2004-038, this routine should not be modified.
	Q:'DIARFND  U IO(0) W !,"Formatting found records..."
	S (DIARTAB,DIAROREQ,DIAROM,DIAROZ,DIARZZ,DIAROIDF,DIAROFLD,DIAROLVL,DIAROBPT,DIAROBFN)=0,DIAROFLD(DIAROLVL)=0 K ^TMP("DIARO",$J)
	F  S DIAROREQ=$O(^TMP("DIAR",$J,DIAROREQ)) Q:DIAROREQ'>0  F  S DIAROM=$O(^TMP("DIAR",$J,DIAROREQ,DIAROM)) Q:DIAROM'>0  D CLEANUP^DIARR4 F  S DIAROZ=$O(^TMP("DIAR",$J,DIAROREQ,DIAROM,DIAROZ)) Q:DIAROZ'>0  S DIAROX=^(DIAROZ) D EN
	Q
EN	Q:DIAROX["$END DAT"!(DIAROX="")
	S DIAROX1=$P(DIAROX,":")
	I $P(DIAROX,U)="$DAT" S DIAROSF=$P(DIAROX,U,2),DIAROSFN=+$P(DIAROX,U,3),DIAROLNE="ARCHIVE FILE: "_DIAROSF_" (#"_DIAROSFN_")" D SET D SV Q
	Q:DIAROX["$END DAT"
EN1	I DIAROX1="BEGIN" D BEGIN D SV Q
	I DIAROX1="END" D END D SV Q
	I DIAROX1="IDENTIFIER"!(DIAROX1="SPECIFIER")!(DIAROX1="KEY") D ID D SV Q
	I $L(DIAROX,U)=3,"AMLD"[$P($P(DIAROX,U,3),"=") G:$P(DIAROX,"=",2)?1"@".N1"E" BE^DIARR4 D F1 I DIAROSFN=+$P(DIAROX,U,2) D SV Q
	I DIAROX="^"!(DIAROX=":") D POP^DIARR4 D SV Q
	I $E(DIAROX1)="""" S DIAROLNE=$E(DIAROX1,2,$L(DIAROX1)-1) D SET Q
	D FLDS
SV	S DIAROXPL=DIAROX
	Q
BEGIN	S DIAROBF=$P($P(DIAROX,U),":",2),DIAROBFN=+$P(DIAROX,U,2),DIARTAB=DIARTAB+2,DIAROLVL=DIAROLVL+1,DIAROSTK(DIAROLVL)=DIAROBF_U_DIAROBFN_U_DIARTAB,DIAROIDF(DIAROLVL)=0,DIAROFLD(DIAROLVL)=0
	S DIAROSUB="@"_$P(DIAROX,"@",2),DIAROAT(DIAROSUB)=$S(DIAROXPL["@":"@"_$P(DIAROXPL,"@",2),1:$P(DIAROXPL,"=",2)) I DIAROBPT D SUB Q
	I DIAROZ=3 G BEGLN1
	I $P(DIAROXPL,U,2)[":" S DIAROLNE="FILE: " D SUB G BEGLN
	I $P(DIAROXPL,":")="BEGIN" S DIAROLNE=".01 POINTER TO FILE: " G BEGLN
	I $L(DIAROXPL,U)=3,"AMLD"[$P($P(DIAROXPL,U,3),"=") S DIAROLNE="SUBFILE: " D SUB G BEGLN
	I $L(DIAROXPL,U)=2 S DIAROLNE="POINTER TO FILE: "
BEGLN	S DIAROLNE=DIAROLNE_DIAROBF_" (#"_DIAROBFN_")"
	D SET
BEGLN1	I $D(DIAROLUP(DIAROBF)) S DIARTAB=$P(DIAROSTK(DIAROLVL),U,3),DIAROLNE=$P(DIAROLUP(DIAROBF),U) D SET K DIAROLUP(DIAROBF)
	Q
SUB	S DIAROSUB(DIAROBFN)=1_U_DIARTAB
	Q
END	S (DIAROIDF(DIAROLVL),DIAROFLD(DIAROLVL))=0,DIAROBF=$P(DIAROSTK(DIAROLVL),U),DIAROBFN=$P(DIAROSTK(DIAROLVL),U,2)
	I $D(DIAROSUB(DIAROBFN)) S DIARTAB=DIARTAB-2 Q
	S:DIAROLVL'=1 DIAROLVL=DIAROLVL-1
	Q
ID	I DIAROIDF(DIAROLVL)=0 S DIAROLNE="IDENTIFIERS: ",DIARTAB=+$P(DIAROSTK(DIAROLVL),U,3)+2 D SET S DIAROIDF(DIAROLVL)=1
	S DIAROLNE=$P($P(DIAROX,U),":",2)_" (#"_+$P(DIAROX,U,2)_") = "_$P(DIAROX,"=",2),DIARTAB=+$P(DIAROSTK(DIAROLVL),U,3)+4 D SET
	Q
FLDS	S DIAROBCK=0
	I DIAROLVL=1,DIAROFLD(DIAROLVL)=0 S DIAROLNE="FIELDS: ",DIARTAB=+$P(DIAROSTK(DIAROLVL),U,3)+2 D SET S DIAROFLD(DIAROLVL)=1
	S (DIAROVAL,DIAROLUP)=$P(DIAROX,"=",2),DIARTAB=$P(DIAROSTK(DIAROLVL),U,3)+4
	I $L(DIAROX,U)=3 S DIAROBF1=$P(DIAROX,U,2) I $E(DIAROBF1,$L(DIAROBF1))=":" D BKPTR^DIARR4 Q
	I +$P(DIAROX,U,2),DIAROVAL["" S DIAROLNE="FIELD NAME: "_$P(DIAROX,U)_" (#"_+$P(DIAROX,U,2)_") = " D LKUP^DIARR4:$E(DIAROVAL)="@" G:DIAROBCK FLDS
	I $D(DIAROSUB)=11 S DIARTAB=$P(DIAROSTK(DIAROLVL),U,3)+2
	S DIAROLNE=DIAROLNE_DIAROVAL D SET Q
	S:$D(DIAROXX) DIAROX=DIAROXX K DIAROXX
	Q
SET	S DIAROTAB="" S:DIARTAB $P(DIAROTAB," ",DIARTAB)=" "
	S DIARZZ=DIARZZ+1,DIAROLNE=DIAROTAB_DIAROLNE
	S ^TMP("DIARO",$J,DIAROREQ,DIAROM,DIARZZ)=DIAROLNE
	Q
F1	S DIAROLUP($P(DIAROX,U))="LOOKUP VALUE (#.01): "_$P(DIAROX,"=",2)
	Q
