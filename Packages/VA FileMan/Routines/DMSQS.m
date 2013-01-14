DMSQS ;SFISC/JHM-BUILD STANDARD SCHEMA ;7/31/97  13:55
 ;;22.0;VA FileMan;;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
SCHEMA ;BUILD OR REPLACE SQLI SCHEMA
 N SI,TT,IEN,FDA
 S SI=$O(^DMSQ("S","B","SQLI",""))
 S TT=1.521,IEN=$S(SI:SI,1:"+1")_","
 S FDA(TT,IEN,.01)="SQLI" ; SCHEMA NAME
 S FDA(TT,IEN,2)="FileMan SQL/ODBC interface tables" ; COMMENT
 S SI=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'SI D ERR^DMSQU(1.521,"","SCHEMA: RECORD INSERT FAILED")
 Q
ALLS Q:$G(DUZ(0))'["@"  N TI,@$$NEW^DMSQU D ENV^DMSQU S TI=0
 F  S TI=$O(^DMSQ("T",TI)) Q:'TI  D STEXE
 Q
STATS(TI) ;DO NODE STATISTICS FOR TABLE TI
 Q:$G(DUZ(0))'["@"  ;NOT FOR NON-PROGRAMMERS
 Q:'$D(^DMSQ("T",TI,0))  ;NO GLOBAL STRUCTURE ON FILE
 N @$$NEW^DMSQU D ENV^DMSQU
STEXE N T,MT,G,G0,CND,K,O,INI,C,MC,I,CT,TT,IEN,FDA,ERR,PI,PEI,F
 S T=^DMSQ("T",TI,0),MT=$P(T,U,4),(G0,G)=$G(^(1)) Q:G=""
 S CND=$S(MT:"K(OI)]""""",1:"K(OI)"),INI=$S(MT:"",1:0),MC=5000
 S (CT,O)=0,F="{K}" F  Q:G'[F  D
 . S O=O+1,K="K("_O_")"
 . S G(O)=$P(G,F)_K_")",C(O)=0,G=$P(G,F)_K_$P(G,F,2,9)
 S K(1)=INI D CNT(1)
 I CT=MC S OI=1 D
 . F I=2:1:O S C(I)=C(I)/C(1)
 . F  S K(1)=$O(@G(1)),@("K="_CND) Q:'K  S C(1)=C(1)+1
 . F I=2:1:O S C(I)=C(I)*C(1) I C(I)["." D
 . . S C(I)=$S(C(I)<10:+$J(C(I),"",2),C(I)<100:+$J(C(I),"",1),1:C(I)\1)
 K ^STATS(TI) M ^STATS(TI)=C ;REMOVE AFTER DEBUG
 ;STORE T_ROW_COUNT IN SQLI_TABLE
 S TT=1.5215,IEN=TI_"," K FDA
 S FDA(TT,IEN,5)=C(O) ;NUMBER OF ROWS IN TABLE
 S C=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'C D ERR^DMSQU(TT,"","STATS: RECORD INSERT FAILED")
 ;STORE P_ROW_COUNT IN SQLI_PRIMARY_KEY
 S TT=1.5218,PEI=$O(^DMSQ("E","D",TI,"")),PI=0
 F I=1:1 S PI=$O(^DMSQ("P","B",PEI,PI)) Q:'PI  D
 . S IEN=PI_"," K FDA
 . S FDA(TT,IEN,5)=C(I) ;ESTIMATED ROW COUNT FOR THIS LEVEL
 . S C=$$PUT^DMSQU(IEN,"FDA","ERR")
 . I $D(ERR)!'C D ERR^DMSQU(TT,5,"STATS: KEY COUNT INSERT FAILED")
 Q
CNT(OI) ;ACCUMULATE NODE COUNT
 F  S K(OI)=$O(@G(OI)) D  Q:'OI
 . I @CND D
 . . S CT=CT+1,C(OI)=C(OI)+1 I CT=MC S OI=0
 . . E  I OI<O S OI=OI+1,K(OI)=INI
 . E  S OI=OI-1
 Q
EP ;EDIT PROTECT ALL SQLI FILES
 Q:$G(DUZ(0))'="@"  N DMF,DMFI W !,"EDIT-PROTECTING SQLI FILES..."
 S DMF=1.520
 F  S DMF=$O(^DD(DMF)) Q:DMF>1.52192  S DMFI=0 W DMF D
 . F  S DMFI=$O(^DD(DMF,DMFI)) Q:'DMFI  D
 . . W ?10,DMFI,?20,$G(^DD(DMF,DMFI,9))
 . . S ^(9)="^" W "->^",!
 W "Done" Q
EU ;EDIT UNPPROTECT ALL SQLI FILES
 Q:$G(DUZ(0))'="@"  N DMF,DMFI W !,"EDIT-UNPROTECTING SQLI FILES..."
 S DMF=1.520
 F  S DMF=$O(^DD(DMF)) Q:DMF>1.52192  S DMFI=0 W DMF D
 . F  S DMFI=$O(^DD(DMF,DMFI)) Q:'DMFI  D
 . . W ?10,DMFI,?20,$G(^DD(DMF,DMFI,9))
 . . S ^(9)="@" W "->@",!
 W "Done" Q
