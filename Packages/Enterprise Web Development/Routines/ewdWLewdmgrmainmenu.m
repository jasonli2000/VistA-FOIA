 ;GT.M version of page mainMenu (ewdMgr application)
 ;Compiled on Tue, 24 Jan 2012 16:51:29
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
 s sessionArray("ewd_pageName")="mainMenu"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("about")=$$setNextPageToken^%zewdGTMRuntime("about")
 s tokens("compiler")=$$setNextPageToken^%zewdGTMRuntime("compiler")
 s tokens("configMenu")=$$setNextPageToken^%zewdGTMRuntime("configMenu")
 s tokens("customTags")=$$setNextPageToken^%zewdGTMRuntime("customTags")
 s tokens("dataTypes")=$$setNextPageToken^%zewdGTMRuntime("dataTypes")
 s tokens("documentation")=$$setNextPageToken^%zewdGTMRuntime("documentation")
 s tokens("errors")=$$setNextPageToken^%zewdGTMRuntime("errors")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("security")=$$setNextPageToken^%zewdGTMRuntime("security")
 s tokens("sessions")=$$setNextPageToken^%zewdGTMRuntime("sessions")
 s Error=$$startSession^%zewdPHP("mainMenu",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "                  <table class=""innerTabs"" id=""mainmenuMenu"" style=""top: -55px;"">"_$c(13,10)
 .w "                     <tr>"_$c(13,10)
 .w "                        <td id=""compilerTab"" onClick=""EWD.page.fetchcompiler(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Compile applications and pages"">"_$c(13,10)
 .w "Compiler"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""configMenuTab"" onClick=""EWD.page.fetchconfigMenu(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Configure Enterprise Web Developer"">"_$c(13,10)
 .w "Configuration"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""customTagsTab"" onClick=""EWD.page.fetchcustomTags(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Custom Tags"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""dataTypesTab"" onClick=""EWD.page.fetchdataTypes(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Data Types"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""sessionsTab"" onClick=""EWD.page.fetchsessions(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Sessions"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""securityTab"" onClick=""EWD.page.fetchsecurity(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Security"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""errorsTab"" onClick=""EWD.page.fetcherrors(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Errors"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""documentationTab"" onClick=""EWD.page.fetchdocumentation(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "Documentation"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""aboutTab"" onClick=""EWD.page.fetchabout(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "About"_""
 .w "                        </td>"_$c(13,10)
 .w "                     </tr>"_$c(13,10)
 .w "                  </table>"_$c(13,10)
 .w "                  <div class=""innerPanel"" id=""mainmenu"" style=""top: -58px;width:100%"">"_$c(13,10)
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
 w "EWD.page.defineInnerTab('mainmenu','compilerTab',true) ;"_$c(13,10)
 w "EWD.page.fetchcompiler = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/compiler.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("compiler")_"&ewd_urlNo=mainMenu1','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchcompiler() ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','configMenuTab',false) ;"_$c(13,10)
 w "EWD.page.fetchconfigMenu = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/configMenu.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("configMenu")_"&ewd_urlNo=mainMenu2','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','customTagsTab',false) ;"_$c(13,10)
 w "EWD.page.fetchcustomTags = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/customTags.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("customTags")_"&ewd_urlNo=mainMenu3','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','dataTypesTab',false) ;"_$c(13,10)
 w "EWD.page.fetchdataTypes = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/dataTypes.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("dataTypes")_"&ewd_urlNo=mainMenu4','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','sessionsTab',false) ;"_$c(13,10)
 w "EWD.page.fetchsessions = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/sessions.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("sessions")_"&ewd_urlNo=mainMenu5','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','securityTab',false) ;"_$c(13,10)
 w "EWD.page.fetchsecurity = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=mainMenu6','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','errorsTab',false) ;"_$c(13,10)
 w "EWD.page.fetcherrors = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/errors.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("errors")_"&ewd_urlNo=mainMenu7','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','documentationTab',false) ;"_$c(13,10)
 w "EWD.page.fetchdocumentation = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/documentation.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("documentation")_"&ewd_urlNo=mainMenu8','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','aboutTab',false) ;"_$c(13,10)
 w "EWD.page.fetchabout = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/about.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("about")_"&ewd_urlNo=mainMenu9','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
