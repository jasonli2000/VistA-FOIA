 ;GT.M version of page sessions (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getSessionList^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="sessions"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("listSession")=$$setNextPageToken^%zewdGTMRuntime("listSession")
 s tokens("sessions")=$$setNextPageToken^%zewdGTMRuntime("sessions")
 s ebToken("deleteSession^%zewdMgrAjax")=$$createEBToken^%zewdGTMRuntime("deleteSession^%zewdMgrAjax",.sessionArray)
 s Error=$$startSession^%zewdPHP("sessions",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <div class=""propsText"">"_$c(13,10)
 .if ($$getSessionObject^%zewdAPI("ewd","browserType",sessid)="firefox") d
 ..s top="top:-20px"
 ..
 .else  d
 ..s top=""
 ..
 .w "         <table border=""0"" style=""table-layout:fixed; position:relative;"_top_""" width=""99%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td width=""22%"">"_$c(13,10)
 .w "                  <div class=""selectorPanel"" style=""width:99%;height:99%"">"_$c(13,10)
 .w "                     <h5 align=""center"">"_$c(13,10)
 .w "                        <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'sess_doc','400px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Current Sessions"_""
 .w "                     </h5>"_$c(13,10)
 .w "                     <div class=""applicationPanel"" style=""left:-5px; height:320px; overflow:scroll"">"_$c(13,10)
 .w "                        <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 .s no=""
 .i no?1N.N s no=no-1
 .i no?1AP.ANP d
 .. s p1=$e(no,1,$l(no)-1)
 .. s p2=$e(no,$l(no))
 .. s p2=$c($a(p2)-1)
 .. s no=p1_p2
 .s nul=""
 .s endValue71=""
 .i endValue71?1N.N s endValue71=endValue71+1
 .f  q:'(($o(^%zewdSession("session",sessid,"sessionList",no))'=endValue71)&($o(^%zewdSession("session",sessid,"sessionList",no))'=nul))  d
 ..s no=$o(^%zewdSession("session",sessid,"sessionList",no))
 ..s dummy=$g(^%zewdSession("session",sessid,"sessionList",no))
 ..w "                              <tr>"_$c(13,10)
 ..w "                                 <td align=""left"" class=""configRow"">"_$c(13,10)
 ..if ($g(no)=$$getSessionValue^%zewdAPI("ewd_sessid",sessid)) d
 ...w "                                       <b>"_$c(13,10)
 ...w no
 ...w "                                       </b>"_$c(13,10)
 ...
 ..else  d
 ...w no
 ...
 ..w "                                 </td>"_$c(13,10)
 ..w "                                 <td class=""configRow"" width=""20%"">"_$c(13,10)
 ..w "                                    <input class=""actionButton"" id=""list"_no_""" name=""list"_no_""" onclick=""MGW.page.listSession('"_no_"')"" type=""button"" value=""Display"" />"_$c(13,10)
 ..w "                                 </td>"_$c(13,10)
 ..if ($g(no)'=$$getSessionValue^%zewdAPI("ewd_sessid",sessid)) d
 ...w "                                    <td class=""configRow"">"_$c(13,10)
 ...w "                                       <input class=""smallButton"" id=""del"_no_""" name=""del"_no_""" onclick=""MGW.page.deleteSession('"_no_"')"" type=""button"" value=""Delete"" />"_$c(13,10)
 ...w "                                    </td>"_$c(13,10)
 ...
 ..else  d
 ...w "&nbsp;"_""
 ...
 ..w "                              </tr>"_$c(13,10)
 ..
 .w "                        </table>"_$c(13,10)
 .w "                     </div>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "               <td id=""listingColumn"" style=""visibility:hidden;"">"_$c(13,10)
 .w "                  <div class=""selectorPanel"" id=""sessionListingPanel"" style=""width:99%; height:99%"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""sess_doc"">"_$c(13,10)
 .w "Currently active sessions are listed below.  By clicking on a Session, you can view the data being persisted for     that session within the back-end database.  You can also selectively delete sessions if you wish."_""
 .w "            <p>"_$c(13,10)
 .w "Note that if you are running the ewdMgr application within PHP, JSP or WebLink, you will be able to view the      session information for anyone running an EWD application in any of these technologies.  However you will be unable      to view Sessions for EWD applications running within CSP, because CSP uses its own built-in session data structure."_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "Conversely, if you are running the ewdMgr application within CSP, you will only be able to view the session data for      EWD applications running in CSP."_""
 .w "            </p>"_$c(13,10)
 .w "         </div>"_$c(13,10)
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
 w " } else {EWD.page.setTitle('enterprise web developer') ; }"_""
 w "   </span>"_$c(13,10)
 w "   <pre id=""ewdscript"" style=""visibility : hidden"">"_$c(13,10)
 w "  MGW.page.listSession = function(sessionNo) {    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    var nvp=""sessionNo="" + sessionNo ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/listSession.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("listSession")_"&ewd_urlNo=sessions1&' + nvp,""sessionListingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.deleteSession = function(sessionNo) {"_$c(13,10)
 w "    var ok=confirm(""Are you sure you want to delete session "" + sessionNo + ""?"") ;"_$c(13,10)
 w "    if (ok) {"_$c(13,10)
 w "      EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("deleteSession^%zewdMgrAjax")_"&px1=' + sessionNo + '','','synch','','') ;"_$c(13,10)
 w "      MGW.page.clearPanel(""sessionListingPanel"") ;"_$c(13,10)
 w "      EWD.ajax.makeRequest('/vista/ewdMgr/sessions.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("sessions")_"&ewd_urlNo=sessions2',""mainmenu"",'get','','') ;      "_$c(13,10)
 w "    }"_$c(13,10)
 w "  };"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
