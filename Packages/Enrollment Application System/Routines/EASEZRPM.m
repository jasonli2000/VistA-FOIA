EASEZRPM ;ALB/AMA - Print 1010EZR, Cont., Other Dependent Financial Pages
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 Q
 ;
EN(EALNE,EAINFO,EASDG) ;Print multiple dependent financial information
 ;Called from EN^EASEZRPF
 ;  Input
 ;     EALNE  - Array of line formats for output
 ;     EAINFO - Application Data array, see SETUP^EASEZRPF
 ;     EASDG  - Flag variable to signify request to print from DG options
 ;
 N FNP,GNP        ;MAX NO. ENTRIES PER PAGE FOR EACH SECTION
 N EASF,EASG      ;VARS FOR INDIRECT ^TMP GLOBAL REFERENCE
 N DEPF,DEPG      ;VARS TO LOOP THROUGH ^TMP GLOBALS
 N DFCNT,DGCNT    ;COUNTERS FOR NO. DEPENDENTS
 N NEWPG,SECOND   ;VARS TO DETERMINE WHEN A NEW PAGE SHOULD OCCUR
 ;
 ;Assuming 55 print lines per page, 5 lines per IIF entry, 6 lines
 ;per IIG entry, plus lines for titles and blank dividing lines:
 S FNP=9   ;can fit 9 dependents on one page for Section IIF
 S GNP=7   ;can fit 7 dependents on one page for Section IIG
 ;
 ;Find additional dependents from Section IIF
 S EASF=$NA(^TMP("EASEZR",$J,"DFF"))
 I $O(@EASF@(1)) D BEGINF
 ;
 ;Start printing with 2nd dependent
 S DEPF=1,DFCNT=0 F  S DEPF=$O(@EASF@(DEPF)) Q:'DEPF  D
 . S DFCNT=DFCNT+1
 . ;Check to see if a new page is needed
 . I (DFCNT>1),'((DFCNT-1)#FNP) D
 . . D FT^EASEZRPF(.EALNE,.EAINFO)
 . . D BEGINF
 . I (DFCNT#FNP)'=1 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . D ADFF
 ;
 ;Find additional dependents from Section IIG
 S EASG=$NA(^TMP("EASEZR",$J,"DFG"))
 I $O(@EASG@(1)) D
 . I $O(@EASF@(1)) D  I 1
 . . I ((DFCNT#FNP)'=0),((DFCNT#FNP)'=GNP) W !!,?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . . ;At the end of IIF, to find when to jump to the next page,
 . . ;55 print lines, minus 3 lines for Section IIG title header,
 . . ;minus the number of lines already used on current page,
 . . ;divided by the number of lines for a Section IIG entry
 . . S NEWPG=(51-((DFCNT#FNP)*6))\7
 . . I '(DFCNT#FNP)!'NEWPG!(NEWPG=GNP) S NEWPG=GNP D FT^EASEZRPF(.EALNE,.EAINFO)
 . E  S NEWPG=GNP
 . D BEGING
 ;
 ;Start printing with 2nd dependent
 S DEPG=1,DGCNT=0 F  S DEPG=$O(@EASG@(DEPG)) Q:'DEPG  D
 . S DGCNT=DGCNT+1
 . ;Check to see if a new page is needed
 . I (DGCNT>1),'((DGCNT-$G(SECOND)-1)#NEWPG) D
 . . D FT^EASEZRPF(.EALNE,.EAINFO)
 . . I NEWPG'=GNP S SECOND=NEWPG,NEWPG=GNP
 . . D BEGING
 . I (DGCNT-$G(SECOND))#GNP'=1 W !?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 . D ADFG
 ;
 D FT^EASEZRPF(.EALNE,.EAINFO)
 Q
 ;
BEGINF ; Print page header info
 ;
 D HDR^EASEZRPF(.EALNE,.EAINFO)
 I $G(EASDG) D  I 1
 . N EZINYR
 . S EZINYR=^TMP("EASEZR",$J,2,999)
 . W !!?9,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF ADDITIONAL DEPENDENT CHILD(REN)  (INCOME YEAR:  ",EZINYR,")"
 E  W !!?20,"SECTION VII - PREVIOUS CALENDAR YEAR GROSS ANNUAL INCOME OF ADDITIONAL DEPENDENT CHILD(REN)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
BEGING ; Print page header info
 ;
 I NEWPG=GNP D HDR^EASEZRPF(.EALNE,.EAINFO)
 I $G(EASDG) D  I 1
 . N EZINYR
 . S EZINYR=^TMP("EASEZR",$J,2,999)
 . W !!?14,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH FOR ADDITIONAL DEPENDENT CHILD(REN)  (INCOME YEAR:  ",EZINYR,")"
 E  W !!?25,"SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH FOR ADDITIONAL DEPENDENT CHILD(REN)"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
ADFF ; Print out VA 10-10EZ Section VII, Gross Annual Income information - Additional Dependents
 ;
 W !,"1. GROSS ANNUAL INCOME FROM EMPLOYMENT (e.g., wages, bonuses, tips)",?90,"|  $ ",$P(@EASF@(DEPF,7),U,2)
 W !,"EXCLUDING INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS -- ",$P(@EASF@(DEPF,7),U),?90,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. NET INCOME FROM YOUR FARM, RANCH, PROPERTY OR BUSINESS -- ",$P(@EASF@(DEPF,7),U),?90,"|  $ ",$P(@EASF@(DEPF,7),U,3)
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. LIST OTHER INCOME AMOUNTS (e.g., Social Security, compensation,",?90,"|  $ ",$P(@EASF@(DEPF,7),U,4)
 W !,"pension, interest, dividends).  EXCLUDING WELFARE -- ",$P(@EASF@(DEPF,7),U),?90,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
ADFG ;  Print SECTION IX - PREVIOUS CALENDAR YEAR NET WORTH - ADDITIONAL DEPENDENTS
 ;
 W !,"1. CASH, AMOUNT IN BANK ACCOUNTS (e.g., checking and savings accounts,",?116,"|  $ ",$P(@EASG@(DEPG,9),U,2)
 W !,"certificates of deposit, individual retirement accounts, stocks and bonds)  -- ",$P(@EASG@(DEPG,9),U),?116,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"2. MARKET VALUE OF LAND AND BUILDINGS MINUS MORTGAGES AND LIENS (e.g., second",?116,"|  $ ",$P(@EASG@(DEPG,9),U,3)
 W !,"homes and non-income-producing property).  DO NOT INCLUDE YOUR PRIMARY HOME.  -- ",$P(@EASG@(DEPG,9),U),?116,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,"3. VALUE OF OTHER PROPERTY OR ASSETS (e.g., art, rare coins, collectibles) MINUS THE AMOUNT YOU OWE ON THESE ITEMS.",?116,"|  $ ",$P(@EASG@(DEPG,9),U,4)
 W !,"INCLUDE VALUE OF FARM, RANCH, OR BUSINESS ASSETS.  Exclude household effects and family vehicles.  -- ",$P(@EASG@(DEPG,9),U),?116,"|"
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
