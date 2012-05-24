 ;GT.M version of page ewdDocs (ewdMgr application)
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
 s sessionArray("ewd_pageName")="ewdDocs"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("ewdDocs",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "Enterprise Web Developer: Documentation"_""
 .w "      </h3>"_$c(13,10)
 .w "      <div align=""left"">"_$c(13,10)
 .w "         <ul>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/overview755.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD Overview Guide"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_tutorial_755.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD Virtual Appliance Tutorial"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_Ajax_748.pdf"" target=""pdf"">"_$c(13,10)
 .w "The EWD Ajax Framework"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_APIGuide748.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD API Reference"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_Troubleshooting_690.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD Troubleshooting Reference"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_dataTypes_690.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD Data Types Reference"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/ewd/ewdva_customTags_748.pdf"" target=""pdf"">"_$c(13,10)
 .w "EWD Custom Tag Reference"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "         </ul>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <h3>"_$c(13,10)
 .w "GT.M and MUMPS Reference Documentation"_""
 .w "      </h3>"_$c(13,10)
 .w "      <div align=""left"">"_$c(13,10)
 .w "         <ul>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/gtm/GTM_UNIX-Prog-Manual-4.4.pdf"" target=""pdf"">"_$c(13,10)
 .w "GT.M Programmer's Guide"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/gtm/AdminOperationsManGTM.pdf"" target=""pdf"">"_$c(13,10)
 .w "GT.M Administration and Operations Guide"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "            <li>"_$c(13,10)
 .w "               <a href=""/gtm/pocket_guide_61_no_printing.pdf"" target=""pdf"">"_$c(13,10)
 .w "Standard M Pocket Guide"_""
 .w "               </a>"_$c(13,10)
 .w "            </li>"_$c(13,10)
 .w "         </ul>"_$c(13,10)
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
