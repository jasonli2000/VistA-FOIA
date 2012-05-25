 ;GT.M version of page display (VistACom application)
 ;Compiled on Fri, 03 Feb 2012 16:50:05
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
 s sessionArray("ewd_prePageScript")="DISPLAY^C0EMAIL"
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="VistACom"
 s sessionArray("ewd_pageName")="display"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("display",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <pre id=""ewdscript"">"_$c(13,10)
 .D STREAM^C0EVCOM("displayCCR",sessid)
 .w "EWD.sencha.widget.zewdSTdisplay24=new Ext.Panel({id:""displayPanel"",layout:""card"",transition:""slide"",items:[{contentEl:""displayBody"",id:""display"",scroll:""vertical"",title:""Document"",xtype:""panel""}"_""
 .w "]});"_""
 .w "Ext.getCmp('mailBackBtn').hide();  EWD.sencha.mailBtn = false;  Ext.getCmp('attachBtn').hide();  Ext.getCmp('msgBackBtn').show();  Ext.getCmp('savePatBtn').show();  EWD.sencha.msgBtn = true;    Ext.getCmp('savePatBtn').show();  Ext.getCmp('botToolBar').setTitle('');  var mailPanel = Ext.getCmp('mailPanel');  var displayPanel = Ext.getCmp('displayPanel');  mailPanel.setActiveItem(displayPanel, 'slide');  EWD.sencha.loadCardPanel('mail', 'mailPanel');  transform(xml, xslt, 'displayCode');  xml = '';  xslt = '';  Ext.getCmp('attachBtn').setDisabled(false);"_""
 .w "Ext.getCmp('mailPanel').add(Ext.getCmp('displayPanel'));Ext.getCmp('mailPanel').doLayout();Ext.getCmp('mailPanel').setActiveItem(Ext.getCmp('displayPanel'),'slide');"_""
 .w "EWD.sencha.loadCardPanel('display','displayPanel');"_""
 .w "   </pre>"_$c(13,10)
 .w "   <span id=""displayBody"">"_$c(13,10)
 .w "      <div class=""x-form-fieldset-title"" style=""margin-left:20px;"">"_$c(13,10)
 .w "Attachment"_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""stShadowBox"" style=""padding-bottom:14px"">"_$c(13,10)
 .w "         <div id=""displayCode"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "   </span>"_$c(13,10)
 .
 i $g(sessid)="" s sessid="unknown"
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
