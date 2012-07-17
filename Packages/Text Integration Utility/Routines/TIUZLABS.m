TIUZLABS ; SLC/JER - Lipid Profile Loader ;7/7/95  15:22;++IFC CLONED TIUZLABS ROUTINE; MOD LINE LABS+8,LABS+13
TIULIP ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;BOSTON/MEF ;Generic Profile Loader;;Dec 4,1997
PROF(DFN,EARLY,LATE,DISPLAY,TARGET,LINE,TIUTEST,MANY) ; Control branching
 ;If many=1 return latest result 
 N TIUI,TIUCNT,TIUDT,TIUY S TIUCNT=0
 S MANY=$S($G(MANY)>2:2,$G(MANY):MANY,1:1)
 K ^TMP("LRAPI",$J)
 I '$D(^DPT(DFN,"LR")) D NOLABS G LABX
 I $G(EARLY)]"" S X=EARLY D DATE S EARLY=Y
 I $G(LATE)]"" S X=LATE D DATE S LATE=Y
 S LRDFN=+^DPT(DFN,"LR") I '$D(^LR(LRDFN)) D NOLABS G LABX
 I +$G(DISPLAY) W !,"Gathering Laboratory Data."
 D LABPANEL(.TIUY,DFN,TIUTEST,$G(EARLY),$G(LATE),MANY)
 I '$D(TIURY)!($G(TIURY(1))="No Lab Data") D NOLABS G LABX
 D LATEST
 S TIUI="" F  S TIUI=$O(TIUY(TIUI)) Q:TIUI=""  D
 . N TIUX
 . S (TIUDT,TIUCNT)=0 F  S TIUDT=$O(TIUY(TIUI,TIUDT)) Q:+TIUDT'>0  Q:TIUCNT=MANY  D
 . .Q:TIUY(TIUI,TIUDT)=""
 . . S TIUCNT=TIUCNT+1 D LINE
LABX Q "~@"_$NA(@TARGET)
LABPANEL(TIUY,DFN,TIUTEST,TIUEDT,TIULDT,NUM) ; Get Lab Results for a panel
 ;;LIPIDS(TIUY,DFN,TIUEDT,TIULDT)      ; Get LIPID profile
 N TIUTST,TIUI,TIUDT
 K TIURY
 S NUM=$S($G(NUM)=1:NUM,1:"")
 S TIUTST=$O(^LAB(60,"B",TIUTEST,0))
 I '+$G(TIUTST) Q
 D TEST^LR7OR2(.TIUY,DFN,"",$G(TIUEDT),$G(TIULDT),"",TIUTST)
 I '$D(TIUY)!($G(TIUY(1))="No Lab Data") Q
 M TIURY=TIUY
 S TIUI=0 F  S TIUI=$O(@TIUY@(TIUI)) Q:+TIUI'>0  D
 . S TIUTST=$$MAPPER($P(@TIUY@(TIUI),U,17)),TIUDT=+@TIUY@(TIUI)
 .; S:TIUDT'=+$G(TIULDT) TIURY("*"_TIUTEST_" PROFILES",TIUDT)=$$DATE^TIULS(TIUDT,"MM/DD/YY")
 .; S TIURY(TIUTST,TIUDT)=$P(@TIUY@(TIUI),U,4)
 . S TIURY(TIUTST,9999999-TIUDT)=$P(@TIUY@(TIUI),U,4)
 ;F TIUI="CHYLOMI","TURBID","VLDL" K TIURY(TIUI) Use this line if you
 ;don't want to display a test from the profile
 K @TIUY
 ;I $D(TIURY) M TIUY=TIURY
 Q
LATEST ;If MANY=2 returns last 2 results for each test in a panel
 ;If MANY=1 returns latest results for each test in a panel
 ;date is return with east test result
 N TIUDT,TIUI
 S TIUI="" F  S TIUI=$O(TIURY(TIUI)) Q:TIUI=""  D
 . S (COUNT,TIUDT)=0
 . F  S TIUDT=$O(TIURY(TIUI,TIUDT)) Q:TIUDT'>0  Q:COUNT'<2  D
 ..Q:TIURY(TIUI,TIUDT)["canc"
 ..Q:TIURY(TIUI,TIUDT)']""
 .. S TIUY(TIUI,TIUDT)=TIURY(TIUI,TIUDT)
 .. S COUNT=COUNT+1
 K TIURY
 Q
NOLABS ; Handles Case Where no Labs are found to satisfy criteria
 S LINE=$S(+$G(LINE):+$G(LINE),1:1),@TARGET@(LINE,0)="No data available"
 S LINE=+$G(LINE)+1,@TARGET@(LINE,0)=" "
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q
LINE ; Line-wrap with comma-delimited data
 N X,Y,TIUNXT
 I MANY>1,TIUCNT#2'>0 Q
 S:'$G(LINE) LINE=LINE+1,@TARGET@(LINE,0)=""
 ;S TIUX=$$SETSTR^VALM1(TIUI_":","",15,24)
 ;S TIUX=$$SETSTR^VALM1($G(TIUY(TIUI,TIUDT)),TIUX,47,8)
 ;S TIUX=TIUX_" ("_$$DATE^TIULS(TIUDT,"MM/YY/DD HR:MIN")_")"
 ;S TIUX=$$SETSTR^VALM1($G(TIUY(TIUI,+$O(TIUY(TIUI,TIUDT)))),TIUX,63,8)
 ;S TIUX=TIUX_" ("_$$DATE^TIULS(TIUDT,"MM/YY/DD HR:MIN")_")"
 S TIUX=$$SETSTR^VALM1(TIUI_":","",2,11)
 I MANY=1 D
 . S TIUX=$$SETSTR^VALM1($G(TIUY(TIUI,TIUDT)),TIUX,12,8)
 . S TIUX=TIUX_" ("_$$DATE^TIULS(9999999-$G(TIUDT),"MM/DD/YY HR:MIN")_")"
 E  D
 .;Q:'+$O(TIUY(TIUI,TIUDT))
 .Q:MANY'>1
 .S TIUNXT=+$O(TIUY(TIUI,TIUDT))
 .S TIUX=$$SETSTR^VALM1($G(TIUY(TIUI,+$O(TIUY(TIUI,TIUDT)))),TIUX,12,8)
 .S:+$O(TIUY(TIUI,TIUDT)) TIUX=TIUX_" ("_$$DATE^TIULS(9999999-$G(TIUNXT),"MM/DD/YY HR:MIN")_")"
 .S TIUX=$$SETSTR^VALM1($G(TIUY(TIUI,TIUDT)),TIUX,40,8)
 .S TIUX=TIUX_" ("_$$DATE^TIULS(9999999-$G(TIUDT),"MM/DD/YY HR:MIN")_")"
 S LINE=+$G(LINE)+1
 S @TARGET@(LINE,0)=TIUX
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 I +$G(DISPLAY) W "."
 Q
MAPPER(TIUX,TIUI) ; Remap test names  Use this if you need a diff prt name
 ; i.e print name is CHOL but we would like TOTAL CHOLESTEROL to print
 N TIUNM,Y ;S TIUNM("CHOL","TOTAL CHOLESTEROL")=""
 ;S (TIUNM("HDL","HDL CHOLESTEROL"),TIUNM("LDL","LDL CHOLESTEROL"))=""
 ;S TIUNM("TRIGLYC","TRIGLYCERIDES")=""
 S Y=$O(TIUNM(TIUX,"")) I Y']"" S Y=TIUX
 Q Y
 ;
DATE ;Put date into internal fileman form
 N %DT
 S %DT="" D ^%DT
 Q
LABS(DFN,TIUTEST,TIUEDT,TIULDT) ; Get Lab Results
 N TIUY,TIUTST,TIUX S TIUTST=+$O(^LAB(60,"B",TIUTEST,0))
 I '+$G(TIUTST) G LABQ
 I $G(TIUEDT)]"" S X=TIUEDT D DATE S TIUEDT=Y
 I $G(TIULDT)]"" S X=TIULDT D DATE S TIULDT=Y
 D TEST^LR7OR2(.TIUY,DFN,"",$G(TIUEDT),$G(TIULDT),"",TIUTST)
 ;S TIUX=$S($D(TIUY)#2:$G(@TIUY@(1)),1:"____")
 B
 I $G(TIUY(1))="No Lab Data" Q "    "  ;++IFC MOD; ORIG LINE NEXT
 ;I $G(TIUY(1))="No Lab Data" Q "____"  
 I $D(TIUY)#2 D
 . S TIUNXT=0
 . F  S TIUNXT=$O(@TIUY@(TIUNXT)) Q:'TIUNXT  Q:"canc"'[$P($G(@TIUY@(TIUNXT)),U,4)
 S TIUX=$S($G(TIUNXT):$G(@TIUY@(TIUNXT)),1:"    ")  ;++IFC CHANGED "____" TO "    "; ORIG LINE NEXT
 ;S TIUX=$S($G(TIUNXT):$G(@TIUY@(TIUNXT)),1:"____")
 I $L(TIUX,U)>1 D
 . S TIUTST=$P(TIUX,U,4)_" ("
 . S TIUTST=TIUTST_$$DATE^TIULS($P(TIUX,U),"MM/DD/YY HR:MIN")_")"
 E  S TIUTST=TIUX
 I $D(TIUY)#2 K @TIUY
LABQ Q $G(TIUTST)
