 ;GT.M version of page remail (VistACom application)
 ;Compiled on Fri, 03 Feb 2012 16:50:06
 ;using Enterprise Web Developer (Build 894)
 QUIT
 ;
run ;
 n confirmText,ebToken,Error,formInfo,ok,sessid,sessionArray,tokens
 s ok=$$pre()
 i ok d body
 QUIT
 ;
pre() ;
 ;
 n ctype,ewdAction,headers,jump,quitStatus,pageTitle,stop,urlNo
 ;
 s confirmText="Click OK if you're sure you want to delete this record"
 s sessionArray("ewd_isFirstPage")="0"
 s sessionArray("ewd_sessid_timeout")="1200"
 s sessionArray("ewd_prePageScript")="IN^C0EMAIL"
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="VistACom"
 s sessionArray("ewd_pageName")="remail"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("remail",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
 s sessid=$g(sessionArray("ewd_sessid"))
 i Error["Enterprise Web Developer Error :",$g(sessionArray("ewd_pageType"))="ajax" d
 . s Error=$p(Error,":",2,200)
 . s Error=$$replaceAll^%zewdAPI(Error,"<br>",": ")
 . s Error="EWD runtime error: "_Error
 i $e(Error,1,32)="Enterprise Web Developer Error :" d  QUIT 0
 . n errorPage
 . s errorPage=$g(sessionArray("ewd_errorPage"))
 . i errorPage="" s errorPage="ewdError"
 . i $g(sessionArray("ewd_pageType"))="ajax" s errorPage="ewdAjaxErrorRedirect"
 . d writeHTTPHeader^%zewdGTMRuntime(sessionArray("ewd_appName"),errorPage,,,sessid,Error)
 s stop=0
 i Error="" d  i stop QUIT 0
 . n nextpage
 . s nextpage=$$getSessionValue^%zewdAPI("ewd_nextPage",sessid)
 . i nextpage'="" d
 . . n x
 . . d writeHTTPHeader^%zewdGTMRuntime(sessionArray("ewd_appName"),nextpage,$$getSessionValue^%zewdAPI("ewd_token",sessid),$$getSessionValue^%zewdAPI("ewd_pageToken",sessid))
 . . s stop=1
 i $$getSessionValue^%zewdAPI("ewd_warning",sessid)'="" d
 . s Error=$$getSessionValue^%zewdAPI("ewd_warning",sessid)
 . d deleteFromSession^%zewdAPI("ewd_warning",sessid)
 w "HTTP/1.1 200 OK"_$c(13,10)
 s ctype="text/html"
 d mergeArrayFromSession^%zewdAPI(.headers,"ewd.header",sessid)
 i $d(headers) d
 . n lcname,name
 . s name=""
 . f  s name=$o(headers(name)) q:name=""  d
 . . s lcname=$$zcvt^%zewdAPI(name,"l")
 . . i lcname="content-type" s ctype=headers(name) q
 . . w name_": "_headers(name)_$c(13,10)
 w "Content-type: "_ctype_$c(13,10)
 w $c(13,10)
 QUIT 1
 ;
body ;
 if ($g(Error)="") d
 .
 i $g(sessid)="" s sessid="unknown"
 w "<pre id=""ewdscript"">"_$c(13,10)
 w "Ext.getCmp('tempMail').destroy();"_""
 w "Ext.regModel('mailMessages',{fields:['msgNum','text']});"_""
 w "zewdSTStoreremail30=new Ext.data.JsonStore({model:'mailMessages'});"_""
 w "EWD.sencha.widget.zewdSTremail30=new Ext.List({id:""mailMessages"",itemTpl:""{text}"",store:zewdSTStoreremail30,listeners:{itemtap:function(view,index,item,e){if (EWD.sencha.listClicked) return;EWD.sencha.listClicked = true;var record = zewdSTStoreremail30.getAt(index);EWD.sencha.cardPanelAction['mail']={transition:'slide',id:''}"_""
 w ";var nvp='listItemNo='+(index+1);var page='mail';EWD.ajax.getPage({page:page,nvp:nvp});}}});"_""
 w "EWD.sencha.addWidget('remail','mailMessages');"_""
 w "EWD.sencha.widget.zewdSTremail21=new Ext.Panel({id:""tempMail"",layout:""card"",scroll:""vertical"",items:[EWD.sencha.widget.zewdSTremail30]}"_""
 w ");"_""
 w "Ext.getCmp('mail').add(Ext.getCmp('tempMail'));  EWD.sencha.DUZ = '"_$$getSessionValue^%zewdAPI("displayName",sessid)_"';  EWD.sencha.DUZDisp = EWD.sencha.DUZ + ' ("_$$getSessionValue^%zewdAPI("mailNum",sessid)_" "_$$getSessionValue^%zewdAPI("msgDisp",sessid)_")';  Ext.getCmp('botToolBar').setTitle(EWD.sencha.DUZDisp);"_""
 d writeListData^%zewdST2("mailMsgList",1,sessid)
 w "EWD.sencha.loadListData(zewdSTStoreremail30,EWD.sencha.jsonData);"_""
 w "Ext.getCmp('mail').add(Ext.getCmp('tempMail'));Ext.getCmp('mail').doLayout();"_""
 w "EWD.sencha.loadCardPanel('remail','tempMail');"_""
 w "</pre>"_$c(13,10)
 w "<span id=""ewdajaxonload"">"_$c(13,10)
 w " var ewdtext='"_$$jsEscape^%zewdGTMRuntime(Error)_"' ; if (ewdtext != '') {    if (ewdtext.substring(0,11) == 'javascript:') {       ewdtext=ewdtext.substring(11) ;       eval(ewdtext) ;    }    else {       EWD.ajax.alert('"_$$htmlEscape^%zewdGTMRuntime($$jsEscape^%zewdGTMRuntime(Error))_"')    }"_$c(13,10)
 s id=""
 f  s id=$o(^%zewdSession("session","ewd_idList",id)) q:id=""  d
 . w "idPointer = document.getElementById('"_id_"') ; "
 . w "if (idPointer != null) idPointer.className='"_$g(^%zewdSession("session","ewd_idList"))_"' ; "
 s id=""
 f  s id=$o(^%zewdSession("session","ewd_errorFields",id)) q:id=""  d
 . w "idPointer = document.getElementById('"_id_"') ; "
 . w "if (idPointer != null) idPointer.className='"_$g(^%zewdSession("session","ewd_errorClass"))_"' ; "
 k ^%zewdSession("session","ewd_hasErrors")
 k ^%zewdSession("session","ewd_errorFields")
 k ^%zewdSession("session","ewd_idList")
 w " }"_""
 w "</span>"_$c(13,10)
 QUIT
