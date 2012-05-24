ORORDDSC        ; SLC/AGP - API for returning Order Dialogs Structure; 03/18/09
        ;;3.0;ORDER ENTRY/RESULTS REPORTING;**301,295**;Dec 17, 1997;Build 63
        ;
BEG(OUTPUT,IEN,TYPE,CNT)        ;
        N DTYPE,NODE
        S NODE=$G(^ORD(101.41,IEN,0))
        S DTYPE=$S(TYPE="Q":"Quick Order",TYPE="M":"Menu",TYPE="D":"Dialog",TYPE="O":"Order Set",TYPE="A":"Action",1:"")
        S CNT=CNT+1 S @OUTPUT@(CNT)=$$REPEAT^XLFSTR("-",79)
        S CNT=CNT+1 S @OUTPUT@(CNT)=$J(" ",24)_"Name: "_$P(NODE,U)
        S CNT=CNT+1 S @OUTPUT@(CNT)=$J(" ",24)_"Type: "_DTYPE
        I $P(NODE,U,2)'="" S CNT=CNT+1 S @OUTPUT@(CNT)=$J(" ",16)_"Display Text: "_$P(NODE,U,2)
        I TYPE="Q" D  Q
        .S CNT=CNT+1 S @OUTPUT@(CNT)=$J(" ",15)_"Display Group: "_$$GETDISGP($P(NODE,U,5))
        .S CNT=CNT+1 S @OUTPUT@(CNT)=$J(" ",21)_"Package: "_$$NMSP($P(NODE,U,7))
        Q
        ;
DIALOG(OUTPUT,IEN,TYPE,CNT)     ;
        D BEG(.OUTPUT,IEN,TYPE,.CNT)
        S CNT=CNT+1,@OUTPUT@(CNT)=$$REPEAT^XLFSTR("-",79)
        Q
        ;
EN(IEN,SUB)     ;
        I $D(^TMP($J,SUB,IEN))>0 Q
        N CNT,OUTPUT
        S CNT=0
        S OUTPUT=$NA(^TMP($J,SUB,IEN))
        D DIRECT(.OUTPUT,IEN,.CNT)
        Q
        ;
DIRECT(OUTPUT,IEN,CNT)  ;
        N ORDIALOG,SAFEIEN,TYPE
        S TYPE=$P($G(^ORD(101.41,IEN,0)),U,4)
        I TYPE="Q" D  Q
        .;done to prevent a problem with TIU Active Medication Objects
        .;killing the variable IEN
        .S SAFEIEN=IEN
        .D GETQDLG^ORCD(IEN)
        .D QO(.ORDIALOG,SAFEIEN,.OUTPUT,.CNT)
        I TYPE="M"!(TYPE="O") D MENU(.OUTPUT,IEN,TYPE,.CNT) Q
        I TYPE="D"!(TYPE="A") D DIALOG(.OUTPUT,IEN,TYPE,.CNT) Q
        Q
        ;
GETDISGP(IEN)   ;
        N RESULT
        S RESULT=$P($G(^ORD(100.98,IEN,0)),U)
        Q RESULT
        ;
MENU(OUTPUT,IEN,TYPE,CNT)       ;
        D BEG(.OUTPUT,IEN,TYPE,.CNT)
        N NODE,NUM,SEQ,ITEM
        S SEQ="" F  S SEQ=$O(^ORD(101.41,IEN,10,"B",SEQ)) Q:SEQ=""  D
        .S NUM=$O(^ORD(101.41,IEN,10,"B",SEQ,"")) Q:NUM=""
        .S ITEM=+$P($G(^ORD(101.41,IEN,10,NUM,0)),U,2) I ITEM'>0 Q
        .S CNT=CNT+1,@OUTPUT@(CNT)=$J(" ",25)_"SEQ: "_SEQ
        .D DIRECT(.OUTPUT,ITEM,.CNT)
        S CNT=CNT+1,@OUTPUT@(CNT)=$$REPEAT^XLFSTR("-",79)
        Q
        ;
NMSP(PKG)       ;
        Q $$GET1^DIQ(9.4,+PKG_",",.01)
        ;
QO(ORDIALOG,IEN,OUTPUT,CNT)     ; -- Display new order on screen
        N SEQ,DA,X,PROMPT,MULT,I,TITLE,LEN
        D BEG(.OUTPUT,IEN,"Q",.CNT)
        S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:SEQ'>0  D
        . S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D
        .. S X=$G(^ORD(101.41,+ORDIALOG,10,DA,0)) Q:$P(X,U,11)  ;child
        .. S PROMPT=$P(X,U,2),MULT=$P(X,U,7) Q:$P(X,U,9)["*"  ;hide
        .. Q:'PROMPT  S I=$O(ORDIALOG(PROMPT,0)) Q:'I  ; no values
        .. S TITLE=$S($L($G(ORDIALOG(PROMPT,"TTL"))):ORDIALOG(PROMPT,"TTL"),1:ORDIALOG(PROMPT,"A"))
        .. S CNT=CNT+1,@OUTPUT@(CNT)=$J(TITLE,30)
        .. I $E(ORDIALOG(PROMPT,0))="W" D
        ... S @OUTPUT@(CNT)=@OUTPUT@(CNT)_$E($G(^TMP("ORWORD",$J,PROMPT,I,1,0)),1,40)_$S($L($G(^(0)))>40:" ...",$O(^TMP("ORWORD",$J,PROMPT,I,1)):" ...",1:"") Q
        .. I $E(ORDIALOG(PROMPT,0))'="W" D
        ... S @OUTPUT@(CNT)=@OUTPUT@(CNT)_$$ITEM^ORCDLG(PROMPT,I) Q:'MULT  Q:'$O(ORDIALOG(PROMPT,I))  ; done
        .. F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  D
        ... S CNT=CNT+1,@OUTPUT@(CNT)=$J(" ",30)_$$ITEM^ORCDLG(PROMPT,I)
        S CNT=CNT+1,@OUTPUT@(CNT)=$$REPEAT^XLFSTR("-",79)
        Q
        ;
