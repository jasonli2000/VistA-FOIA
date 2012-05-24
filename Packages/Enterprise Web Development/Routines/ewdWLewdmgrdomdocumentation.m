 ;GT.M version of page domDocumentation (ewdMgr application)
 ;Compiled on Tue, 24 Jan 2012 16:51:28
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
 s sessionArray("ewd_sessid_timeout")="3600"
 s sessionArray("ewd_prePageScript")="getDOMMethods^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="domDocumentation"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("domDocumentation")=$$setNextPageToken^%zewdGTMRuntime("domDocumentation")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s formInfo="docsel|submit`ewd_pressed|hidden`method|select`"
 d setMethodAndNextPage^%zewdCompiler20("docsel","","domDocumentationDetail",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("domDocumentation",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <span class=""propsText"">"_$c(13,10)
 .if ($$getSessionObject^%zewdAPI("ewd","technology",sessid)="wl") d
 ..s path="/"
 ..
 .else  d
 ..s path=""
 ..
 .w "      <table border=""0"" style=""table-layout:fixed"" width=""99%"">"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td width=""35%"">"_$c(13,10)
 .w "               <div class=""selectorPanel"" style=""width:99%; height:auto"">"_$c(13,10)
 .w "                  <h5 align=""center"">"_$c(13,10)
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'dom_doc','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "DOM API Methods"_""
 .w "                  </h5>"_$c(13,10)
 .w "                  <div class=""applicationPanel"" style=""left:-5px; height:230px; overflow:scroll"">"_$c(13,10)
 .w "                     <form action='/vista/ewdMgr/domDocumentation.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "                        <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <select id=""method"" name=""method"" onchange=""document.getElementById('docsel').click()"">"_$c(13,10)
 .d displayOptions^%zewdAPI("method","method",0)
 .w "                                 </select>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <input class=""actionButton"" id=""docsel"" name=""docsel"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'domDocumentationDetail','/vista/ewdMgr/domDocumentation.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("domDocumentation")_"&ewd_urlNo=domDocumentation1','listingPanel','') ;"" type=""button"" value=""Details"" />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                        </table>"_$c(13,10)
 .w "                        <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                        <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                     </form>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </div>"_$c(13,10)
 .w "            </td>"_$c(13,10)
 .w "            <td id=""listingColumn"" style=""visibility:hidden; height:auto"">"_$c(13,10)
 .w "               <div class=""selectorPanel"" id=""listingPanel"" style=""width:99%; height:99%"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "               </div>"_$c(13,10)
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "      </table>"_$c(13,10)
 .w "      <div id=""docNullid"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""dom_doc"">"_$c(13,10)
 .w "These methods are for use in your Custom Tag Processor/Compiler methods.  These methods allow you to     locate, access, manipulate and modify the contents of the XML DOM that represents your EWD page.  Your Custom Tag processor has     complete access to the entire page DOM and these methods allow you to modify it in any way you wish."_""
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
