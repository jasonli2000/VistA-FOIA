 ;GT.M version of page vaConfigMenu (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")=""
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="vaConfigMenu"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("vaConfigApache")=$$setNextPageToken^%zewdGTMRuntime("vaConfigApache")
 s tokens("vaConfigArchitecture")=$$setNextPageToken^%zewdGTMRuntime("vaConfigArchitecture")
 s tokens("vaConfigEWD")=$$setNextPageToken^%zewdGTMRuntime("vaConfigEWD")
 s tokens("vaConfigExit")=$$setNextPageToken^%zewdGTMRuntime("vaConfigExit")
 s tokens("vaConfigGTM")=$$setNextPageToken^%zewdGTMRuntime("vaConfigGTM")
 s tokens("vaConfigIP")=$$setNextPageToken^%zewdGTMRuntime("vaConfigIP")
 s tokens("vaConfigKB")=$$setNextPageToken^%zewdGTMRuntime("vaConfigKB")
 s tokens("vaConfigLinuxGTM")=$$setNextPageToken^%zewdGTMRuntime("vaConfigLinuxGTM")
 s tokens("vaConfigMGWSI")=$$setNextPageToken^%zewdGTMRuntime("vaConfigMGWSI")
 s tokens("vaConfigUsernames")=$$setNextPageToken^%zewdGTMRuntime("vaConfigUsernames")
 s Error=$$startSession^%zewdPHP("vaConfigMenu",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "                        <td id=""vaConfigArchitectureTab"" onClick=""EWD.page.fetchvaConfigArchitecture(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""EWD Virtual Appliance Architecture"">"_$c(13,10)
 .w "Architecture"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigUsernamesTab"" onClick=""EWD.page.fetchvaConfigUsernames(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Configured Usernames for the Virtual Appliance"">"_$c(13,10)
 .w "Usernames"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigIPTab"" onClick=""EWD.page.fetchvaConfigIP(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Configuring the Virtual Appliance's IP Address"">"_$c(13,10)
 .w "Network"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigKBTab"" onClick=""EWD.page.fetchvaConfigKB(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Reconfiguring the keyboard"">"_$c(13,10)
 .w "Keyboard"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigApacheTab"" onClick=""EWD.page.fetchvaConfigApache(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Configuring Apache"">"_$c(13,10)
 .w "Apache"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigGTMTab"" onClick=""EWD.page.fetchvaConfigGTM(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""GT.M's configuration in the Virtual Appliance"">"_$c(13,10)
 .w "GT.M"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigLinuxGTMTab"" onClick=""EWD.page.fetchvaConfigLinuxGTM(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Memory and Global configuration"">"_$c(13,10)
 .w "Memory & Globals"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigMGWSITab"" onClick=""EWD.page.fetchvaConfigMGWSI(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""The m_apache Gateway"">"_$c(13,10)
 .w "m_apache"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigEWDTab"" onClick=""EWD.page.fetchvaConfigEWD(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""EWD: using and configuration"">"_$c(13,10)
 .w "EWD"_""
 .w "                        </td>"_$c(13,10)
 .w "                        <td id=""vaConfigExitTab"" onClick=""EWD.page.fetchvaConfigExit(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"" title=""Shutting down and re-booting the Virtual Appliance"">"_$c(13,10)
 .w "Shutdown"_""
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
 w "EWD.page.defineInnerTab('mainmenu','vaConfigArchitectureTab',true) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigArchitecture = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigArchitecture.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigArchitecture")_"&ewd_urlNo=vaConfigMenu1','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchvaConfigArchitecture() ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigUsernamesTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigUsernames = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigUsernames.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigUsernames")_"&ewd_urlNo=vaConfigMenu2','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigIPTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigIP = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigIP.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigIP")_"&ewd_urlNo=vaConfigMenu3','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigKBTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigKB = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigKB.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigKB")_"&ewd_urlNo=vaConfigMenu4','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigApacheTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigApache = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigApache.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigApache")_"&ewd_urlNo=vaConfigMenu5','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigGTMTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigGTM = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigGTM.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigGTM")_"&ewd_urlNo=vaConfigMenu6','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigLinuxGTMTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigLinuxGTM = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigLinuxGTM.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigLinuxGTM")_"&ewd_urlNo=vaConfigMenu7','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigMGWSITab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigMGWSI = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigMGWSI.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigMGWSI")_"&ewd_urlNo=vaConfigMenu8','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigEWDTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigEWD = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigEWD.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigEWD")_"&ewd_urlNo=vaConfigMenu9','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.defineInnerTab('mainmenu','vaConfigExitTab',false) ;"_$c(13,10)
 w "EWD.page.fetchvaConfigExit = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/vaConfigExit.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("vaConfigExit")_"&ewd_urlNo=vaConfigMenu10','mainmenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
