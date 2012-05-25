 ;GT.M version of page patients (VistACom application)
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
 s sessionArray("ewd_prePageScript")="LOGIN^KBAWEWD"
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="VistACom"
 s sessionArray("ewd_pageName")="patients"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s formInfo="patient|text`"
 d setMethodAndNextPage^%zewdCompiler20("zewdSTFormpatients33","","",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("patients",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 w "zewdSTHandlerpatients239=function() {"_""
 w "EWD.sencha.blurFields(document);"_$c(13,10)
 w "var nvp='ewd_action=' + zewdSTFormpatients28.getValues().ewd_action + '&fPatsBtn=' + zewdSTFormpatients28.getValues().fPatsBtn + '&patient=' + zewdSTFormpatients28.getValues().patient + '&patsBtn=' + zewdSTFormpatients28.getValues().patsBtn;"_$c(13,10)
 w "EWD.ajax.getPage({page:'portal',nvp:nvp});"_""
 w "};"_""
 w "zewdSTFormpatients28=new Ext.form.FormPanel({id:""patientForm"",submitOnAction:false,items:[{title:""Please Select a Patient"",xtype:""fieldset"",items:[{id:""patient"",label:""Patient:"",labelWidth:""25%"",name:""patient"",phonepanelheight:200,value:"""_$$getSessionValue^%zewdAPI("patient",sessid)_""",xtype:""textfield"",listeners:{keyup:{fn: function(){EWD.sencha.combo.filter({seed:this.getValue(),id:'patient',width:400,height:400,phoneWidth:240,phoneHeight:200}"_""
 w "); }}}},{handler:EWD.sencha.onPatsSubmitBtnTapped,id:""fPatsBtn"",name:""fPatsBtn"",targetid:""ewdNullId"",text:""Submit"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{handler:zewdSTHandlerpatients239,id:""patsBtn"",name:""patsBtn"",targetid:""ewdNullId"",text:""Submit"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{id:""ewd_action"",name:""ewd_action"",value:""zewdSTFormpatients33"",xtype:""hiddenfield""}]}]});"_""
 w "EWD.sencha.widget.zewdSTpatients17=new Ext.Panel({id:""patsPanel"",layout:""card"",transition:""slide"",items:[zewdSTFormpatients28]}"_""
 w ");"_""
 w "if (! "_$$getSessionValue^%zewdAPI("CPRS",sessid)_")    Ext.getCmp('fLoginBtn').setDisabled(false);"_""
 w "Ext.getCmp('cardPanel').add(Ext.getCmp('patsPanel'));Ext.getCmp('cardPanel').doLayout();Ext.getCmp('cardPanel').setActiveItem(Ext.getCmp('patsPanel'),'slide');"_""
 w "EWD.sencha.loadCardPanel('patients','patsPanel');"_""
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
