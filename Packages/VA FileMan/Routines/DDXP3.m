DDXP3 ;SFISC/DPC-CREATE EXPORT TEMPLATE ;10/14/94  14:56
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;
 N DDXPNOUT
 N T,Q S T="~",Q="""" K ^TMP($J,"DIP")
 N Y,D,DICS D ^DICRW I Y=-1 G QUIT
 S DDXPFINO=+Y
FLDT ;
 D FLDTEMP^DDXP33 G:DDXPOUT QUIT
FRMT ;
 S DIC="^DIST(.44,",DIC(0)="QEAMZ" D ^DIC K DIC
 G:Y=-1 QUIT
 S DDXPFMNO=+Y,DDXPFMZO=Y(0)
XPTEMP ;
 D XPT^DDXP31 G:DDXPOUT QUIT
 D FLOAD,CAPDT^DDXP32 G:DDXPOUT QUIT
 I $P(DDXPFMZO,U,6) D LENGTH^DDXP31 G:DDXPOUT QUIT
 I $P(DDXPFMZO,U,7) D FLDNAME^DDXP31 G:DDXPOUT QUIT
 I $P(DDXPFMZO,U,11) D DTYPE^DDXP31 G:DDXPOUT QUIT
 D SETFLD^DDXP32
 I '$P(DDXPFMZO,U,8) D IOM^DDXP31 G:DDXPOUT QUIT S ^DIPT(DDXPXTNO,"IOM")=$G(DDXPIOM)
 D SETEMP^DDXP32
SETDELM ;
 I $TR($P(DDXPFMZO,U,2),"ask","ASK")="ASK" D ASKDELM^DDXP31 G:DDXPOUT QUIT
 S:'$D(DDXPDELM) DDXPDELM=$P(DDXPFMZO,U,2)
 I DDXPDELM]"" S DDXPDELM=$$BLDELIM(DDXPDELM)
TPROC ;
 S DDXPFONO=1,DDXPFOUT="",DDXPXPOS=1
 F DDXPFLD=1:1:DDXPTOTF D
 . S (DDXPNPC,DDXPRNPC)=^TMP($J,"TIN",DDXPFLD)
 . I $P(DDXPFMZO,U,10),'DDXPNOUT(DDXPFLD) D QUOT^DDXP32
 . I $P(DDXPFMZO,U,6) D FIXLEN
 . I '$P(DDXPFMZO,U,6),((DDXPFLD'=1)!(DDXPNPC'=DDXPRNPC)) D RUNON
 . I $P(DDXPFMZO,U,10),'DDXPNOUT(DDXPFLD) D QUOT^DDXP32
 . I DDXPDELM]"",'DDXPNOUT(DDXPFLD) D DELIM
 . D FPROC
 . Q
RECPROC ;
 I '$P(DDXPFMZO,U,12),DDXPDELM]"" S DDXPFOUT=$P(DDXPFOUT,T,1,($L(DDXPFOUT,T)-2))_T
 I $TR($P(DDXPFMZO,U,3),"ask","ASK")="ASK" D ASKRDLM^DDXP31 G:DDXPOUT QUIT
 S:'$D(DDXPRDLM) DDXPRDLM=$P(DDXPFMZO,U,3)
 I DDXPRDLM]"" S DDXPRDLM=$$BLDELIM(DDXPRDLM) D RECDELIM D FPROC
FINISH ;
 I DDXPFOUT]"" S ^DIPT(DDXPXTNO,"F",DDXPFONO)=DDXPFOUT
 S DIE="^DIST(.44,",DA=DDXPFMNO,DR="40///1" D ^DIE
 S DIE="^DIPT(",DA=DDXPFDTM,DR="110///1" D ^DIE K DIE,DA,DR
 W !!,?10,"Export Template created.",!
 I $G(DDXPTMDL) D
 . S DIK="^DIPT(",DA=DDXPFDTM D ^DIK K DIK,DA
 . W ?10,"Selected Fields template "_DDXPFDNM_" deleted.",!
 . Q
 G DONE
QUIT ;
 W !!,?10,"Export Template NOT created!!"
 I $G(DDXPTMDL) W !,?10,"Selected Fields template "_DDXPFDNM_" not deleted."
 I $D(DDXPXTNO) S DIK="^DIPT(",DA=DDXPXTNO D ^DIK K DIK,DA
DONE ;
 K X,Y,DDXPDELM,DDXPDT,DDXPFDTM,DDXPFCAP,DDXPFFNM,DDXPFIN,DDXPFINO,DDXPFLD,DDXPIOM,DDXPFLEN,DDXPFMNO,DDXPFMZO,DDXPFONO,DDXPTLEN,DDXPTMDL
 K DDXPFDNM,DDXPFOUT,DDXPLNMX,DDXPRNPC,DDXPNPC,DDXPOUT,DDXPTIN,DDXPATH,DDXPTOTF,DDXPXPOS,DDXPXTNM,DDXPXTNO,DDXPRDLM,Q,T,DTOUT,DUOUT,DIRUT
 K ^TMP($J,"DIP")
 Q
FLOAD ;
 S DDXPFLD=0
 F FIN=0:0 S FIN=$O(^DIPT(DDXPFDTM,"F",FIN)) Q:FIN=""  S DDXPFIN=^(FIN) D
 . F TCNT=1:1 S DDXPTIN=$P(DDXPFIN,T,TCNT) Q:DDXPTIN=""  D
 . . S DDXPFLD=DDXPFLD+1
 . . S ^TMP($J,"TIN",DDXPFLD)=DDXPTIN
 . . S DDXPNOUT(DDXPFLD)=$$NOUT(DDXPTIN)
 . . Q
 . Q
 S DDXPTOTF=DDXPFLD
 K FIN,TCNT Q
FIXLEN ;
 S DDXPLNMX=$S(+$P(DDXPFMZO,U,8):$P(DDXPFMZO,U,8),$G(DDXPIOM):DDXPIOM,1:80)
 I DDXPXPOS+DDXPFLEN(DDXPFLD)>(DDXPLNMX+1) S DDXPXPOS=1
 S DDXPNPC=DDXPNPC_";L"_DDXPFLEN(DDXPFLD)_";C"_DDXPXPOS
 S DDXPXPOS=DDXPXPOS+DDXPFLEN(DDXPFLD)
 Q
RUNON ;
 S DDXPNPC=DDXPNPC_";X"
 Q
DELIM ;
 S DDXPNPC=DDXPNPC_T_"W $C("_DDXPDELM_")"
 I '$P(DDXPFMZO,U,6) D RUNON
 Q
RECDELIM ;
 S DDXPNPC="W $C("_DDXPRDLM_")"
 I '$P(DDXPFMZO,U,6) D RUNON
 Q
BLDELIM(%) ;
 N CHAR,DELM
 I +% S DELM=% G BLDOUT
 S DELM=$A(%)
 F CHAR=2:1 Q:$E(%,CHAR)=""  S DELM=DELM_","_$A($E(%,CHAR))
BLDOUT Q DELM
FPROC ;
 I $L(DDXPFOUT)+$L(DDXPNPC)<220 S DDXPFOUT=DDXPFOUT_DDXPNPC_T Q
 S ^DIPT(DDXPXTNO,"F",DDXPFONO)=DDXPFOUT
 S DDXPFOUT=DDXPNPC_T,DDXPFONO=DDXPFONO+1
 Q
 ;
NOUT(DDXPTIN) ;
 I DDXPTIN["SETDATA"!(DDXPTIN["SETPARAM") Q 1
 Q 0
