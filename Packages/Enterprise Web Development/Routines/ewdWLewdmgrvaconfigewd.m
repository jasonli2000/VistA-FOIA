 ;GT.M version of page vaConfigEWD (ewdMgr application)
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
 s sessionArray("ewd_pageName")="vaConfigEWD"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("vaConfigEWD",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "Using and Managing EWD"_""
 .w "      </h3>"_$c(13,10)
 .w "The Enterprise Web Developer environment has already been configured for you as follows:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <table border=""1"">"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "Application Root Directory"_""
 .w "            </td>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "/usr/ewdapps"_""
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "EWD Compilation Technology"_""
 .w "            </td>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "gtm"_""
 .w "               <br />"_$c(13,10)
 .w "(ie compiles to native GT.M routines that use the MGWSI m_apache gateway)"_""
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "Apache alias to compiled EWD applications"_""
 .w "            </td>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "/ewd/"_""
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "      </table>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "You'll find one EWD application already installed on your Virtual Appliance:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <ul>"_$c(13,10)
 .w "         <li>"_$c(13,10)
 .w "ewdMgr: The EWD Management Portal"_""
 .w "         </li>"_$c(13,10)
 .w "      </ul>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "The source pages for this application have been provided.  Please use these as good examples of how to write EWD applications."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "You can upload new applications and their pages using an SCP client (eg WinSCP) to the"_""
 .w "      <i>"_$c(13,10)
 .w "/usr/ewdapps"_""
 .w "      </i>"_$c(13,10)
 .w "directory."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "To compile an application, you can either use the"_""
 .w "      <i>"_$c(13,10)
 .w "ewdMgr"_""
 .w "      </i>"_$c(13,10)
 .w "application by clicking the EWD tab at the top of the page, or from the command prompt within GT.M.  For example, to compile the entire ewdMgr application, you would do the following:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "cd /usr/local/gtm/ewd"_""
 .w "         <br />"_$c(13,10)
 .w "$gtm"_""
 .w "         <br />"_$c(13,10)
 .w "GTM&gt;d compileAll^%zewdAPI(""myApplicationName"",,""gtm"")"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "To compile just a single page within an application (eg the"_""
 .w "      <i>"_$c(13,10)
 .w "myPage"_""
 .w "      </i>"_$c(13,10)
 .w "page within the"_""
 .w "      <i>"_$c(13,10)
 .w "myApplicationName"_""
 .w "      </i>"_$c(13,10)
 .w "application), do the following within GT.M:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "GTM&gt;d compilePage^%zewdAPI(""myApplicationName"",""myPage"",,""gtm"")"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Compiled applications run as web applications within a browser.  The URL structure is:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "http://xx.xx.xx.xx/ewd/appName/pageName.mgwsi"_""
 .w "         <br />"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "where:"_""
 .w "      <br />"_$c(13,10)
 .w "xx.xx.xx.xx is the IP address (or domain name) of your EWD virtual server"_""
 .w "      <br />"_$c(13,10)
 .w "appName is the EWD application name"_""
 .w "      <br />"_$c(13,10)
 .w "pageName is the name of the EWD page (which must be configured in the &lt;ewd:config&gt; tag as a first page)"_""
 .w "      <br />"_$c(13,10)
 .w "For example:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "http://192.168.1.21/ewd/ewdMgr/index.mgwsi"_""
 .w "         <br />"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <p>"_$c(13,10)
 .w "For more information about EWD and the Virtual Appliance, click the Documentation tab in the top menu and study the Tutorial."_""
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
