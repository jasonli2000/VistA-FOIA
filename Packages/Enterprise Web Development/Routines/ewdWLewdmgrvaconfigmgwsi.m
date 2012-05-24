 ;GT.M version of page vaConfigMGWSI (ewdMgr application)
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
 s sessionArray("ewd_pageName")="vaConfigMGWSI"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("vaConfigMGWSI",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <span>"_$c(13,10)
 .w "      <h3>"_$c(13,10)
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "Gateway"_""
 .w "      </h3>"_$c(13,10)
 .w "The"_""
 .w "      <i>"_$c(13,10)
 .w "m_apache"_""
 .w "      </i>"_$c(13,10)
 .w "gateway automatically starts when the EWD Virtual Appliance is booted up and the Apache Web Server starts."_""
 .w "      <p>"_$c(13,10)
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "has been configured such that any URL that ends with the file extension"_""
 .w "         <i>"_$c(13,10)
 .w ".mgwsi"_""
 .w "         </i>"_$c(13,10)
 .w "will automatically invoke the EWD routine/page loader.  See the file"_""
 .w "         <i>"_$c(13,10)
 .w "/etc/apache2/sites-available/default"_""
 .w "         </i>"_$c(13,10)
 .w "to examine  and/or change this configuration."_""
 .w "      </p>"_$c(13,10)
 .w "      <p>"_$c(13,10)
 .w "To stop, start or restart"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w ", simply stop, start or restart Apache, eg:"_""
 .w "      </p>"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "sudo /etc/init.d/apache2 restart"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <p>"_$c(13,10)
 .w "Note: whenever you edit and recompile an EWD application, page or fragment, there's no need to restart"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "in order to ensure that the latest version of the compiled GT.M Mumps routines are used by the back-end"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "processes. EWD's run-time engine is automatically notified of changes to your pages and relinks  any routines that it is using."_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "restarts should therefore be rarely required."_""
 .w "      </p>"_$c(13,10)
 .w "      <p>"_$c(13,10)
 .w "If you make any changes to pre-page or action scripts, you can force m_apache to relink them automatically by  invoking:"_""
 .w "      </p>"_$c(13,10)
 .w "      <ul>"_$c(13,10)
 .w "         <li>"_$c(13,10)
 .w "            <i>"_$c(13,10)
 .w "d relink^%zewdGTM"_""
 .w "            </i>"_$c(13,10)
 .w "         </li>"_$c(13,10)
 .w "      </ul>"_$c(13,10)
 .w "      <p>"_$c(13,10)
 .w "For further details regarding"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "see the documentation that is included in its source file"_""
 .w "         <i>"_$c(13,10)
 .w "/usr/mgwsi/bin/m_apache.c"_""
 .w "         </i>"_$c(13,10)
 .w "."_""
 .w "      </p>"_$c(13,10)
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
