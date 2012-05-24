 ;GT.M version of page gtmMenu (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")=""
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="gtmMenu"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("applianceAbout")=$$setNextPageToken^%zewdGTMRuntime("applianceAbout")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("ewdDocs")=$$setNextPageToken^%zewdGTMRuntime("ewdDocs")
 s tokens("ewdMgr")=$$setNextPageToken^%zewdGTMRuntime("ewdMgr")
 s tokens("vaConfig")=$$setNextPageToken^%zewdGTMRuntime("vaConfig")
 s Error=$$startSession^%zewdPHP("gtmMenu",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <div>"_$c(13,10)
 .w "         <table border=""0"" width=""100%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <table class=""innerTabs"" id=""gtmmenuMenu"" style=""top: -55px;"">"_$c(13,10)
 .w "                     <tr>"_$c(13,10)
 .w "                        <td id=""ewdMgrTab"" onClick=""EWD.page.fetchewdMgr(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Enterprise Web Developer Manager"">"_$c(13,10)
 .w "ewdMgr"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""ewdDocsTab"" onClick=""EWD.page.fetchewdDocs(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""EWD Documentation"">"_$c(13,10)
 .w "Documentation"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigTab"" onClick=""EWD.page.fetchvaConfig(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""EWD Virtual Appliance Configuration Notes"">"_$c(13,10)
 .w "VM Configuration"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""applianceAboutTab"" onClick=""EWD.page.fetchapplianceAbout(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""About Enterprise Web Developer"">"_$c(13,10)
 .w "About"_""
 .w "                        </td>"_$c(13,10)
 .w "                     </tr>"_$c(13,10)
 .w "                  </table>"_$c(13,10)
 .w "                  <div class=""innerPanel"" id=""gtmmenu"" style=""top: -58px;width:100%"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "      </div>"_$c(13,10)
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
 w "EWD.page.defineInnerTab('gtmmenu','ewdMgrTab',true) ;"_$c(13,10)
 w "EWD.page.fetchewdMgr = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/ewdMgr.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("ewdMgr")_"&ewd_urlNo=gtmMenu1','gtmmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchewdMgr() ;"_$c(13,10)
 w "EWD.page.defineInnerTab('gtmmenu','ewdDocsTab',false) ;"_$c(13,10)
 w "EWD.page.fetchewdDocs = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/ewdDocs.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("ewdDocs")_"&ewd_urlNo=gtmMenu2','gtmmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('gtmmenu','vaConfigTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfig = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfig.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfig")_"&ewd_urlNo=gtmMenu3','gtmmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('gtmmenu','applianceAboutTab',false) ;"_$c(13,10)
 w "EWD.page.fetchapplianceAbout = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/applianceAbout.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("applianceAbout")_"&ewd_urlNo=gtmMenu4','gtmmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
