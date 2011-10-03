TIUSRVE ; SLC/JER - Get Upload Events for Display ;21-OCT-1999 10:54:57
 ;;1.0;TEXT INTEGRATION UTILITIES;**56,81**;Jun 20, 1997
GET(TIUDA,HUSH) ; Build ^TMP("TIUEVENT",$J,
 N TIUI,TIUJ,TIUL,TIUREC,X S TIUI=0,HUSH=+$G(HUSH)
 N DA,DIC,DIQ,DR,TIUNAME K ^TMP("TIUEVENT",$J)
 I '$D(IOINORM) S X="IOINORM;IOIHI;IORVON;IORVOFF;IOUON;IOUOFF;IOBON;IOBOFF" D ENDR^%ZISS
 S:'$D(VALMAR) VALMAR="^TMP(""TIUEVENT"",$J)"
 S VALMEVL=+$G(VALMEVL)
 I '$D(^TIU(8925.4,+TIUDA,0)) S VALMQUIT=1 Q
 S DIC=8925.4,DIQ="TIUREC(",DA=TIUDA
 S DR=".01:.08"
 D EN^DIQ1
 S TIUI="" F  S TIUI=$O(TIUREC(8925.4,+TIUDA,TIUI)) Q:+TIUI'>0  D
 . I $G(TIUREC(8925.4,+TIUDA,TIUI))']"" S TIUREC(8925.4,+TIUDA,TIUI)="None"
 I $D(TIUREC)>9 D
 . S ^TMP("TIUEVENT",$J,0)=$G(TIUREC(8925.4,TIUDA,.08))
 . D EVENT(.TIUREC,HUSH),FIELDS(TIUDA,.VALMCNT),HEADER(TIUDA,.VALMCNT)
 ; The following line was Removed with TIU*1*56
 ;S:+$G(VALMCNT)<$G(VALM("LINES")) VALMCNT=$G(VALM("LINES"))
 Q
EVENT(TIUREC,HUSH) ; Load Source Information
 N OFFSET,START
 S OFFSET=2,START=1
 W:'+$G(HUSH) !!,"Opening "_TIUREC(8925.4,+TIUDA,.08)_" record for review..."
 D SET(START,OFFSET," Event Description ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,$G(TIUREC(8925.4,TIUDA,.04)))
 D SET(START+2,OFFSET,"  Event Date/time: "_$G(TIUREC(8925.4,TIUDA,.01)))
 D SET(START+3,OFFSET,"        User Name: "_$G(TIUREC(8925.4,TIUDA,.02)))
 D SET(START+4,OFFSET,"       Event Type: "_$G(TIUREC(8925.4,TIUDA,.08)))
 D SET(START+5,OFFSET,"    Document Type: "_$G(TIUREC(8925.4,TIUDA,.03)))
 D SET(START+6,OFFSET,"Resolution Status: "_$G(TIUREC(8925.4,TIUDA,.06)))
 D SET(START+7,OFFSET,"  Resolution Date: "_$G(TIUREC(8925.4,TIUDA,.07)))
 S VALMCNT=7
 Q
FIELDS(TIUDA,TIUJ) ; Get missing fields
 N TIUK,TIUFLD S TIUK=0
 S TIUJ=+$G(TIUJ)+1
 D BLANK(TIUJ) S TIUJ=+$G(TIUJ)+1
 D SET(TIUJ,2," Missing Fields ",IORVON,IORVOFF) S TIUJ=TIUJ+1
 D BLANK(TIUJ)
 F  S TIUK=$O(^TIU(8925.4,+TIUDA,1,TIUK)) Q:+TIUK'>0  D
 . N DIC,DIQ,DA,DR S DA=TIUK,DIC="^TIU(8925.4,"_+TIUDA_",1,"
 . S DR=".01:.04",DIQ="TIUFLD(" D EN^DIQ1 Q:$D(TIUFLD)'>9
 . I $$FIXED^TIUPEVN1(8925,+$G(TIUFLD(8925.42,DA,.02)),+$G(TIUFLD(8925.42,DA,.03)))=1 Q  ; P81, don't display fixed missing flds; moved from TIUPEVNT
 . S TIUJ=+$G(TIUJ)+1
 . D SET(TIUJ,2,"  File Number: "_$G(TIUFLD(8925.42,DA,.01)))
 . D SET(TIUJ,40,"Record Number: "_$G(TIUFLD(8925.42,DA,.02)))
 . S TIUJ=+$G(TIUJ)+1
 . D SET(TIUJ,2," Field Number: "_$G(TIUFLD(8925.42,DA,.03)))
 . D SET(TIUJ,40," Failed Value: "_$G(TIUFLD(8925.42,DA,.04)))
 Q
HEADER(TIUDA,TIUJ) ; Get body of document
 S TIUJ=+$G(TIUJ)+1
 D BLANK(TIUJ) S TIUJ=+$G(TIUJ)+1
 D SET(TIUJ,2," Header Text ",IORVON,IORVOFF)
 ; D BLANK(TIUJ) S TIUJ=TIUJ+1
 D HDRTEXT(TIUDA,.TIUJ)
 Q
HDRTEXT(TIUDA,TIUJ) ; Get Header Text for filing errors
 N TIUKID,TIUDADT,TIUI S TIUI=0
 F  S TIUI=$O(^TIU(8925.4,+TIUDA,"HEAD",TIUI)) Q:+TIUI'>0  D
 . S TIUJ=+$G(TIUJ)+1
 . D SET(TIUJ,2,$G(^TIU(8925.4,+TIUDA,"HEAD",+TIUI,0)))
 Q
SET(LINE,COL,TEXT,ON,OFF) ; -- set display info in array
 D:'$D(@VALMAR@(LINE,0)) BLANK(.LINE)
 D SET^VALM10(.LINE,$$SETSTR^VALM1(.TEXT,@VALMAR@(LINE,0),.COL,$L(TEXT)))
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(.LINE,.COL,$L(TEXT),$G(ON),$G(OFF))
 W:'(LINE#5)&'+$G(HUSH) "."
 Q
 ;
BLANK(LINE) ; -- build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q