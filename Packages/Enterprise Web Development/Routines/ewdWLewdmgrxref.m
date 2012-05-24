 ;GT.M version of page xref (ewdMgr application)
 ;Compiled on Tue, 24 Jan 2012 16:51:30
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
 s sessionArray("ewd_prePageScript")="getIndices^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="xref"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("xrefPageFromPage")=$$setNextPageToken^%zewdGTMRuntime("xrefPageFromPage")
 s tokens("xrefPageFromScript")=$$setNextPageToken^%zewdGTMRuntime("xrefPageFromScript")
 s tokens("xrefPageFromTag")=$$setNextPageToken^%zewdGTMRuntime("xrefPageFromTag")
 s tokens("xrefPageToPage")=$$setNextPageToken^%zewdGTMRuntime("xrefPageToPage")
 s tokens("xrefPageToScript")=$$setNextPageToken^%zewdGTMRuntime("xrefPageToScript")
 s tokens("xrefPageToTag")=$$setNextPageToken^%zewdGTMRuntime("xrefPageToTag")
 s Error=$$startSession^%zewdPHP("xref",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 w "<span>"_$c(13,10)
 if ($g(Error)="") d
 .w "      <span>"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "         <table border=""0"" width=""98%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <table class=""innerTabs"" id=""xrefMenuMenu"">"_$c(13,10)
 .w "                     <tr>"_$c(13,10)
 .w "                        <td id=""xrefPageToPageTab"" onClick=""EWD.page.fetchxrefPageToPage(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Page =&gt; Page"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""xrefPageFromPageTab"" onClick=""EWD.page.fetchxrefPageFromPage(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Page &lt;= Page"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""xrefPageToScriptTab"" onClick=""EWD.page.fetchxrefPageToScript(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Page =&gt; Script"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""xrefPageFromScriptTab"" onClick=""EWD.page.fetchxrefPageFromScript(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Script &lt;= Page"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""xrefPageToTagTab"" onClick=""EWD.page.fetchxrefPageToTag(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Page =&gt; Tag"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""xrefPageFromTagTab"" onClick=""EWD.page.fetchxrefPageFromTag(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Tag &lt;= Page"_""
 .w "                        </td>"_$c(13,10)
 .w "                     </tr>"_$c(13,10)
 .w "                  </table>"_$c(13,10)
 .w "                  <div class=""innerPanel"" id=""xrefMenu"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "      </span>"_$c(13,10)
 .
 i $g(sessid)="" s sessid="unknown"
 w "   <span id=""ewdajaxonload"">"_$c(13,10)
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
 w "   </span>"_$c(13,10)
 w "   <pre id=""ewdscript"" style=""visibility : hidden"">"_$c(13,10)
 w ""_$c(13,10)
 w "  EWD.page.setTitle('enterprise web developer') ;"_$c(13,10)
 w ""_""
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageToPageTab',true) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageToPage = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageToPage.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageToPage")_"&ewd_urlNo=xref1','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchxrefPageToPage() ;"_$c(13,10)
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageFromPageTab',false) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageFromPage = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageFromPage.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageFromPage")_"&ewd_urlNo=xref2','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageToScriptTab',false) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageToScript = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageToScript.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageToScript")_"&ewd_urlNo=xref3','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageFromScriptTab',false) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageFromScript = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageFromScript.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageFromScript")_"&ewd_urlNo=xref4','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageToTagTab',false) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageToTag = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageToTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageToTag")_"&ewd_urlNo=xref5','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('xrefMenu','xrefPageFromTagTab',false) ;"_$c(13,10)
 w "EWD.page.fetchxrefPageFromTag = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/xrefPageFromTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("xrefPageFromTag")_"&ewd_urlNo=xref6','xrefMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
