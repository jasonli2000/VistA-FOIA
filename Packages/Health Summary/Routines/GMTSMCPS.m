GMTSMCPS ; WISC/DCB - Medicine 2.2 Health Summary Component ; 08/27/2002
 ;;2.7;Health Summary;**16,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10061  KVAR^VADPT
 ;   DBIA    80  ^MCAR(690
 ;   DBIA 10011  ^DIWP
 ;
BEG ; One Line summary only
 D START(0,"B") Q
BRIEF ; Brief Summary
 D START(1,"B") Q
ABN ; Print Brief summary for only abnormal or Null
 D START(2,"B") Q
FULL ; Full Summary
 D START(1,"F") Q
CAP ; Capture
 D START(1,"C") Q
ADBF ; Print Full Summary for only abnormal or null
 D START(2,"F") Q
 ;
START(BRIEF,MCTYPE) ; Get the record and display the record
 N TV,VV,SP,MAX
 K ^TMP("MCAR",$J)
 S RMAR=$S($D(IOM):IOM,1:IOM)
 S TV=(.25*RMAR+.5)\1
 S VV=(.70*RMAR+.5)\1
 S SP=(RMAR-(TV+VV))-1
 D KVAR^VADPT
 I '$D(^MCAR(690,"AC",DFN)) D EXIT Q
 D SEARCH
 I '$D(^TMP("MCAR",$J)) D EXIT Q
 F MCL=1:1 Q:$D(GMTSQIT)  Q:'$D(^TMP("MCAR",$J,MCL))  D GETREC(MCL,RMAR,TV,VV,SP)
 D EXIT
 Q
SEARCH ; Search for Selected Patient
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D HSUM^GMTSMCMA(DFN,GMTSEND,GMTSBEG,MAX,"",MCTYPE)
 Q
GETREC(MCL,RMAR,TV,VV,SP) ; Return Single Record
 N MCDATE,MCPROC,MCSUM,MCPSUM,LOOP,LINE,BLINE
 S (LOOP,BLINE)="",$P(BLINE,"-",80)="-"
 S MCDATE=$$RETURN("DATE/TIME",MCL)
 S MCPROC=$$RETURN("PROCEDURE",MCL)
 S MCSUM=$$RETURN("SUMMARY",MCL)
 I BRIEF=2,("NBT"[$E(MCSUM,1)),(MCSUM'="") Q
 S MCPSUM=$$RETURN("PROCEDURE SUMMARY",MCL)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,MCDATE,?(TV+SP),MCPROC
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,BLINE
 D:MCSUM'="" PRINT(MCSUM,VV,"Summary:",TV,SP)
 D:MCPSUM'="" PRINT(MCPSUM,VV,"Procedure Summary:",TV,SP)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q:+$G(BRIEF)=0
 F  S LOOP=+$O(^TMP("MCAR",$J,MCL,LOOP)) Q:LOOP=0!$D(GMTSQIT)  D REPORT(LOOP,MCL,RMAR,BLINE,TV,VV,SP)
 Q
REPORT(LOOP,MCL,RMAR,BLINE,TV,VV,SP) ; Report for Procedure
 N LINE,TEMP,HOLD,TITLE,VALUE,UNITS,MLEN,RANGE
 N TARRAY,VARRY,LARRAY,TMAX,VMAX,MAX,LOOP2
 S LINE=^TMP("MCAR",$J,MCL,LOOP,1)
 S TEMP=$P(LINE,U,1),TITLE=$P(TEMP,";",1)_":"
 S VALUE=$P(LINE,U,3,255),UNITS=$P(LINE,U,2)
 Q:(VALUE="")&(MCTYPE="C")
 I $P(TEMP,";",2)="W" D WORD(MCL,LOOP,TITLE,RMAR,TV,VV,SP) Q
 S VALUE=VALUE_$S(UNITS="":"",1:" "_UNITS)
 D PRINT(VALUE,VV,TITLE,TV,SP)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WARP(VALUE,LENGTH,TEMP,MAX) ; Warp a field
 N DIWL,DIWR,DIWF,X,LOOP3,TEMP1 S LOOP3=""
 K ^UTILITY($J,"W")
 S DIWL=0,DIWR=LENGTH,X=VALUE D ^DIWP
 F MAX=1:1 S LOOP3=+$O(^UTILITY($J,"W",DIWL,LOOP3)) Q:LOOP3=0  D
 . S TEMP1=^UTILITY($J,"W",DIWL,LOOP3,0)
 . S:$E(TEMP1,$L(TEMP1))=" " TEMP1=$E(TEMP1,1,$L(TEMP1)-1)
 . S TEMP(LOOP3)=TEMP1
 S MAX=MAX-1
 Q
WORD(MCL,LOOP,TITLE,RMAR,TV,VV,SP) ; Display Word Processing
 N SLOOP,X,DIWR,DIWL,DIWF,TARRAY,TMAX,LOOP3,SPAC
 D WARP(TITLE,TV,.TARRAY,.TMAX) K ^UTILITY($J,"W") S DIWR=VV,DIWL=0
 F SLOOP=0:0 S SLOOP=+$O(^TMP("MCAR",$J,MCL,LOOP,SLOOP)) Q:SLOOP=0  D
 . S X=$P(^TMP("MCAR",$J,MCL,LOOP,SLOOP),U,3) D ^DIWP
 S SLOOP=0
 F LOOP3=1:1 S SLOOP=+$O(^UTILITY($J,"W",DIWL,SLOOP)) Q:(SLOOP=0)!($D(GMTSQIT))  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !,$J($G(TARRAY(LOOP3)),TV),?(TV+SP),^UTILITY($J,"W",DIWL,SLOOP,0)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
CONVERT(TITLE) ; Convert to Mixed Case   TEMP = Temp
 N UPPER,LOWER,TEMP,LOOP,HOLD,HOLD2
 S UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LOWER="abcdefghijklmnopqrstuvwxyz"
 F LOOP=1:1:255 S HOLD=$P(TITLE," ",LOOP) Q:HOLD=""  D
 . S:$D(TEMP) TEMP=TEMP_" "
 . S HOLD2=$E(HOLD,2,$L(HOLD))
 . S TEMP=$G(TEMP)_$E(HOLD,1)_$TR(HOLD2,UPPER,LOWER)
 Q TEMP
PRINT(VALUE,VV,TITLE,TV,SP) ; Print a Field and its Value
 N VMAX,TMAX,TARRAY,VARRAY,SPAC,LOOP2
 S TITLE=$$CONVERT(TITLE)
 D WARP(VALUE,VV,.VARRAY,.VMAX)
 D WARP(TITLE,TV,.TARRAY,.TMAX)
 S MAX=$S(VMAX<TMAX:TMAX,VMAX>TMAX:VMAX,1:TMAX)
 S SPAC=TMAX-VMAX S SPAC=$S(SPAC'>0:0,1:SPAC)
 F LOOP2=1:1:MAX D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . W !,$J($G(TARRAY(LOOP2)),TV),?(TV+SP),$G(VARRAY(LOOP2-SPAC))
 Q:$D(GMTSQIT)
 Q
RETURN(TYPE,LINE) ; Return key Elements
 N MCHOLD,HOLD
 S MCHOLD=+$O(^TMP("MCAR",$J,LINE,"B",TYPE,""))
 S HOLD=$P($G(^TMP("MCAR",$J,LINE,MCHOLD,1)),U,3)
 K ^TMP("MCAR",$J,LINE,"B",TYPE,LINE)
 K ^TMP("MCAR",$J,LINE,MCHOLD,1)
 Q HOLD
EXIT ; Clean up and Quit
 K PR,OT,DA,MCARPPS,MCI,MCJ,R,MCL,S1,S2,S4,S5,S6,LL,LL1,MAX,VA
 K ^TMP("MCAR",$J),K,N,MCARDT,MCARNM,MCARPROC,M,RMAR
 Q
