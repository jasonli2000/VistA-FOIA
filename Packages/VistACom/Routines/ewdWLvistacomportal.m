 ;GT.M version of page portal (VistACom application)
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
 s sessionArray("ewd_prePageScript")="PORTAL^C0EVCOM"
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="VistACom"
 s sessionArray("ewd_pageName")="portal"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s formInfo="docFrom|text`docMessage|text`docSubject|text`docTo|text`"
 d setMethodAndNextPage^%zewdCompiler20("zewdSTFormportal237","","",formInfo,.sessionArray)
 s formInfo="patFrom|text`patMessage|text`patSubject|text`patTo|text`"
 d setMethodAndNextPage^%zewdCompiler20("zewdSTFormportal326","","",formInfo,.sessionArray)
 s formInfo="savePatient|text`"
 d setMethodAndNextPage^%zewdCompiler20("zewdSTFormportal413","","",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("portal",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <div class=""temp-panel"" id=""temp-xml"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .
 i $g(sessid)="" s sessid="unknown"
 w "<pre id=""ewdscript"">"_$c(13,10)
 w "Ext.regModel('mailMessages',{fields:['msgNum','text']});"_""
 w "zewdSTStoreportal126=new Ext.data.JsonStore({model:'mailMessages'});"_""
 w "Ext.regModel('patientFile',{fields:['text']});"_""
 w "zewdSTStoreportal158=new Ext.data.JsonStore({model:'patientFile'});"_""
 d writeRegModel^%zewdST2("qualityInfo","EWD.sencha.qualityGrid","qualityColDef",sessid)
 d writeRegModel^%zewdST2("meaningfulInfo","EWD.sencha.meaningfulGrid","meaningfulColDef",sessid)
 w "zewdSTHandlerportal1976=function() {"_""
 w "EWD.sencha.blurFields(document);"_$c(13,10)
 w "var nvp='docFrom=' + zewdSTFormportal232.getValues().docFrom + '&docMessage=' + zewdSTFormportal232.getValues().docMessage + '&docSubject=' + zewdSTFormportal232.getValues().docSubject + '&docTo=' + zewdSTFormportal232.getValues().docTo + '&ewd_action=' + zewdSTFormportal232.getValues().ewd_action;"_$c(13,10)
 w "EWD.ajax.getPage({page:'docemail',nvp:nvp});"_""
 w "};"_""
 w "zewdSTHandlerportal2106=function() {"_""
 w "EWD.sencha.blurFields(document);"_$c(13,10)
 w "var nvp='ewd_action=' + zewdSTFormportal321.getValues().ewd_action + '&patFrom=' + zewdSTFormportal321.getValues().patFrom + '&patMessage=' + zewdSTFormportal321.getValues().patMessage + '&patSubject=' + zewdSTFormportal321.getValues().patSubject + '&patTo=' + zewdSTFormportal321.getValues().patTo;"_$c(13,10)
 w "EWD.ajax.getPage({page:'patemail',nvp:nvp});"_""
 w "};"_""
 w "zewdSTHandlerportal2195=function() {"_""
 w "EWD.sencha.blurFields(document);"_$c(13,10)
 w "var nvp='ewd_action=' + zewdSTFormportal408.getValues().ewd_action + '&savePatient=' + zewdSTFormportal408.getValues().savePatient;"_$c(13,10)
 w "EWD.ajax.getPage({page:'save',nvp:nvp});"_""
 w "};"_""
 w "zewdSTFormportal408=new Ext.form.FormPanel({id:""savePatForm"",submitOnAction:false,items:[{title:""Please Select a Patient"",xtype:""fieldset"",items:[{id:""savePatient"",label:""Patient:"",labelWidth:""25%"",name:""savePatient"",value:"""_$$getSessionValue^%zewdAPI("savePatient",sessid)_""",xtype:""textfield"",listeners:{keyup:{fn: function(){EWD.sencha.combo.filter({seed:this.getValue(),id:'savePatient',width:400,height:400,phoneWidth:240,phoneHeight:60}"_""
 w "); }}}},{handler:zewdSTHandlerportal2195,id:""zewdSTFieldportal429"",name:""zewdSTFieldportal429"",targetid:""ewdNullId"",text:""Submit"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onSaveCancelBtnTapped,id:""zewdSTFieldportal440"",name:""zewdSTFieldportal440"",targetid:""ewdNullId"",text:""Cancel"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{id:""ewd_action"",name:""ewd_action"",value:""zewdSTFormportal413"",xtype:""hiddenfield""}]}]});"_""
 w "zewdSTFormportal321=new Ext.form.FormPanel({id:""patModalForm"",submitOnAction:false,items:[{title:""Send CCR to the Patient"",xtype:""fieldset"",items:[{id:""patTo"",label:""To:"",labelWidth:""25%"",name:""patTo"",placeHolder:""Patient's email address"",value:"""_$$getSessionValue^%zewdAPI("patTo",sessid)_""",xtype:""emailfield""}"_""
 w ",{disabled:true,id:""patFrom"",label:""From:"",labelWidth:""25%"",name:""patFrom"",value:"""_$$getSessionValue^%zewdAPI("patFrom",sessid)_""",xtype:""emailfield""}"_""
 w ",{id:""patSubject"",label:""Subject:"",labelWidth:""25%"",name:""patSubject"",value:"""_$$getSessionValue^%zewdAPI("patSubject",sessid)_""",xtype:""textfield""}"_""
 w ",{height:100,id:""patMessage"",label:""Message:"",labelWidth:""25%"",name:""patMessage"",value:"""_$$getSessionValue^%zewdAPI("patMessage",sessid)_""",xtype:""textareafield""}"_""
 w ",{handler:zewdSTHandlerportal2106,id:""zewdSTFieldportal371"",name:""zewdSTFieldportal371"",targetid:""ewdNullId"",text:""Send"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onPatCancelBtnTapped,id:""zewdSTFieldportal382"",name:""zewdSTFieldportal382"",targetid:""ewdNullId"",text:""Cancel"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{id:""ewd_action"",name:""ewd_action"",value:""zewdSTFormportal326"",xtype:""hiddenfield""}]}]});"_""
 w "zewdSTFormportal232=new Ext.form.FormPanel({id:""docModalForm"",submitOnAction:false,items:[{title:""Send CCR to the Doctor"",xtype:""fieldset"",items:[{id:""docTo"",label:""To:"",labelWidth:""25%"",name:""docTo"",value:"""_$$getSessionValue^%zewdAPI("docTo",sessid)_""",xtype:""textfield"",listeners:{keyup:{fn: function(){EWD.sencha.combo.filter({seed:this.getValue(),id:'docTo',width:400,height:400,phoneWidth:240,phoneHeight:60}"_""
 w "); }}}},{disabled:true,id:""docFrom"",label:""From:"",labelWidth:""25%"",name:""docFrom"",value:"""_$$getSessionValue^%zewdAPI("docFrom",sessid)_""",xtype:""emailfield""}"_""
 w ",{id:""docSubject"",label:""Subject:"",labelWidth:""25%"",name:""docSubject"",value:"""_$$getSessionValue^%zewdAPI("docSubject",sessid)_""",xtype:""textfield""}"_""
 w ",{height:100,id:""docMessage"",label:""Message:"",labelWidth:""25%"",name:""docMessage"",value:"""_$$getSessionValue^%zewdAPI("docMessage",sessid)_""",xtype:""textareafield""}"_""
 w ",{handler:zewdSTHandlerportal1976,id:""zewdSTFieldportal284"",name:""zewdSTFieldportal284"",targetid:""ewdNullId"",text:""Send"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onDocCancelBtnTapped,id:""zewdSTFieldportal295"",name:""zewdSTFieldportal295"",targetid:""ewdNullId"",text:""Cancel"",ui:""drastic_round"",xtype:""button""}"_""
 w ",{id:""ewd_action"",name:""ewd_action"",value:""zewdSTFormportal237"",xtype:""hiddenfield""}]}]});"_""
 w "EWD.sencha.widget.zewdSTportal158=new Ext.List({id:""patientFile"",itemTpl:""{text}"",store:zewdSTStoreportal158,listeners:{itemtap:function(view,index,item,e){if (EWD.sencha.listClicked) return;EWD.sencha.listClicked = true;var record = zewdSTStoreportal158.getAt(index);EWD.sencha.cardPanelAction['file']={transition:'slide',id:''}"_""
 w ";var nvp='listItemNo='+(index+1);var page='file';var synch=true;EWD.ajax.getPage({page:page,synch:synch,nvp:nvp}"_""
 w ");}}});"_""
 w "EWD.sencha.widget.zewdSTportal126=new Ext.List({id:""mailMessages"",itemTpl:""{text}"",store:zewdSTStoreportal126,listeners:{itemtap:function(view,index,item,e){if (EWD.sencha.listClicked) return;EWD.sencha.listClicked = true;var record = zewdSTStoreportal126.getAt(index);EWD.sencha.cardPanelAction['mail']={transition:'slide',id:''}"_""
 w ";var nvp='listItemNo='+(index+1);var page='mail';EWD.ajax.getPage({page:page,nvp:nvp});}}});"_""
 w "EWD.sencha.addWidget('portal','mailMessages');"_""
 w "EWD.sencha.addWidget('portal','patientFile');"_""
 w "EWD.sencha.widget.zewdSTportal17=new Ext.Panel({id:"""_$$getSessionValue^%zewdAPI("panel",sessid)_""",layout:""fit"",transition:""slide"",dockedItems:[{dock:""bottom"",id:""botToolBar"",xtype:""toolbar"",items:[{handler:EWD.sencha.onFilesBackBtnTapped,hidden:true,id:""filesBackBtn"",text:""Back to Files List"",ui:""back"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onMailBackBtnTapped,hidden:true,id:""mailBackBtn"",text:""Back to Mail Inbox"",ui:""back"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onMsgBackBtnTapped,hidden:true,id:""msgBackBtn"",text:""Back to Mail Message"",ui:""back"",xtype:""button""}"_""
 w ",{xtype:""spacer""},{handler:EWD.sencha.onAttachBtnTapped,hidden:true,id:""attachBtn"",text:""Display Attachment"",ui:""forward"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onDocEmailBtnTapped,hidden:true,id:""docEmailBtn"",text:""Doctor"",ui:""round"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onPatEmailBtnTapped,hidden:true,id:""patEmailBtn"",text:""Patient"",ui:""round"",xtype:""button""}"_""
 w ",{handler:EWD.sencha.onSavePatBtnTapped,hidden:true,id:""savePatBtn"",text:""Save to Patient"",ui:""round"",xtype:""button""}"_""
 w "]}],items:[{id:""tabPanel"",xtype:""tabpanel"",items:[{id:""mail"",layout:""card"",scroll:""vertical"",title:""Mail"",xtype:""panel"",items:[{id:""tempMail"",layout:""card"",xtype:""panel"",items:[EWD.sencha.widget.zewdSTportal126]}"_""
 w "]},{id:""files"",layout:""card"",scroll:""vertical"",title:""Files"",xtype:""panel"",items:[{id:""tempFiles"",layout:""card"",xtype:""panel"",items:[EWD.sencha.widget.zewdSTportal158]}"_""
 w "]},{contentEl:""temp-xml"",id:""ccr"",layout:""fit"",title:""CCR"",xtype:""panel""},{id:""quality"",layout:""fit"",title:""Quality"",xtype:""panel"",items:[{colModel:EWD.sencha.qualityColDef,id:""qualityGrid"",selModel:{singleSelect:true}"_""
 w ",store:EWD.sencha.qualityGrid,xtype:""touchgridpanel""}]},{id:""meaningful"",layout:""fit"",title:""MU"",xtype:""panel"",items:[{colModel:EWD.sencha.meaningfulColDef,id:""meaningfulGrid"",selModel:{singleSelect:true}"_""
 w ",store:EWD.sencha.meaningfulGrid,xtype:""touchgridpanel""}]}]}]});"_""
 w "EWD.sencha.widget.zewdSTportal217=new Ext.Panel({floating:true,height:400,hidden:true,hideOnMaskTap:false,id:""docModalPanel"",layout:""fit"",modal:true,width:500,items:[zewdSTFormportal232]}"_""
 w ");"_""
 w "EWD.sencha.widget.zewdSTportal306=new Ext.Panel({floating:true,height:400,hidden:true,hideOnMaskTap:false,id:""patModalPanel"",layout:""fit"",modal:true,width:500,items:[zewdSTFormportal321]}"_""
 w ");"_""
 w "EWD.sencha.widget.zewdSTportal393=new Ext.Panel({floating:true,height:200,hidden:true,hideOnMaskTap:false,id:""saveModalPanel"",layout:""fit"",modal:true,width:400,items:[zewdSTFormportal408]}"_""
 w ");"_""
 w "EWD.sencha.filesCnt = 'Imported CCR/CCD Files ("_$$getSessionValue^%zewdAPI("ptflCnt",sessid)_")';  EWD.sencha.DUZ = '"_$$getSessionValue^%zewdAPI("displayName",sessid)_"';  EWD.sencha.DUZDisp = EWD.sencha.DUZ + ' ("_$$getSessionValue^%zewdAPI("mailNum",sessid)_" "_$$getSessionValue^%zewdAPI("msgDisp",sessid)_")';  EWD.sencha.page('"_$$getSessionValue^%zewdAPI("page",sessid)_"');  Ext.getCmp('toolBar').setTitle('"_$$getSessionValue^%zewdAPI("patientName",sessid)_"');  Ext.getCmp('botToolBar').setTitle(EWD.sencha.DUZDisp);  EWD.sencha.renderPage();  if (! "_$$getSessionValue^%zewdAPI("CPRS",sessid)_")    Ext.getCmp('fPatsBtn').setDisabled(false);  EWD.ajax.getPage({page:'xml'});"_""
 d writeListData^%zewdST2("mailMsgList",1,sessid)
 w "EWD.sencha.loadListData(zewdSTStoreportal126,EWD.sencha.jsonData);"_""
 d writeListData^%zewdST2("ptFileList",1,sessid)
 w "EWD.sencha.loadListData(zewdSTStoreportal158,EWD.sencha.jsonData);"_""
 w "Ext.getCmp('"_$$getSessionValue^%zewdAPI("parentPanel",sessid)_"').add(Ext.getCmp('"_$$getSessionValue^%zewdAPI("panel",sessid)_"'));Ext.getCmp('"_$$getSessionValue^%zewdAPI("parentPanel",sessid)_"').doLayout();Ext.getCmp('"_$$getSessionValue^%zewdAPI("parentPanel",sessid)_"').setActiveItem(Ext.getCmp('"_$$getSessionValue^%zewdAPI("panel",sessid)_"'),'slide');"_""
 w "EWD.sencha.loadCardPanel('portal','"_$$getSessionValue^%zewdAPI("panel",sessid)_"');"_""
 w "EWD.sencha.loadCardPanel('portal','docModalPanel');"_""
 w "EWD.sencha.loadCardPanel('portal','patModalPanel');"_""
 w "EWD.sencha.loadCardPanel('portal','saveModalPanel');"_""
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
