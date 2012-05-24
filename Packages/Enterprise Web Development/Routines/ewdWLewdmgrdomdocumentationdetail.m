 ;GT.M version of page domDocumentationDetail (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getDOMMethodDetails^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="domDocumentationDetail"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("docParams")=$$setNextPageToken^%zewdGTMRuntime("docParams")
 s tokens("docPurpose")=$$setNextPageToken^%zewdGTMRuntime("docPurpose")
 s tokens("docRetVal")=$$setNextPageToken^%zewdGTMRuntime("docRetVal")
 s tokens("docTypCall")=$$setNextPageToken^%zewdGTMRuntime("docTypCall")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("domDocumentationDetail",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "         <h5 align=""center"">"_$c(13,10)
 .w "Method: "_$$getSessionValue^%zewdAPI("method",sessid)
 .w "         </h5>"_$c(13,10)
 .w "         <table border=""0"" width=""98%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <table class=""innerTabs"" id=""docMenuMenu"">"_$c(13,10)
 .w "                     <tr>"_$c(13,10)
 .w "                        <td id=""docPurposeTab"" onClick=""EWD.page.fetchdocPurpose(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Purpose"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""docTypCallTab"" onClick=""EWD.page.fetchdocTypCall(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Typical Call"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""docParamsTab"" onClick=""EWD.page.fetchdocParams(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Parameters"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""docRetValTab"" onClick=""EWD.page.fetchdocRetVal(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Return Value"_""
 .w "                        </td>"_$c(13,10)
 .w "                     </tr>"_$c(13,10)
 .w "                  </table>"_$c(13,10)
 .w "                  <div class=""innerPanel"" id=""docMenu"">"_$c(13,10)
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
 w " } else {document.getElementById(""listingColumn"").style.visibility = ""visible"" ; }"_""
 w "   </span>"_$c(13,10)
 w "   <pre id=""ewdscript"" style=""visibility : hidden"">"_$c(13,10)
 w "EWD.page.defineInnerTab('docMenu','docPurposeTab',true) ;"_$c(13,10)
 w "EWD.page.fetchdocPurpose = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/docPurpose.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("docPurpose")_"&ewd_urlNo=domDocumentationDetail1','docMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchdocPurpose() ;"_$c(13,10)
 w "EWD.page.defineInnerTab('docMenu','docTypCallTab',false) ;"_$c(13,10)
 w "EWD.page.fetchdocTypCall = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/docTypCall.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("docTypCall")_"&ewd_urlNo=domDocumentationDetail2','docMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('docMenu','docParamsTab',false) ;"_$c(13,10)
 w "EWD.page.fetchdocParams = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/docParams.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("docParams")_"&ewd_urlNo=domDocumentationDetail3','docMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('docMenu','docRetValTab',false) ;"_$c(13,10)
 w "EWD.page.fetchdocRetVal = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/docRetVal.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("docRetVal")_"&ewd_urlNo=domDocumentationDetail4','docMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
