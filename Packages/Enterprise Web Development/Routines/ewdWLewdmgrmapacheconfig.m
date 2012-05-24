 ;GT.M version of page mapacheConfig (ewdMgr application)
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
 s sessionArray("ewd_pageName")="mapacheConfig"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("mapacheConfig")=$$setNextPageToken^%zewdGTMRuntime("mapacheConfig")
 s formInfo="ewd_pressed|hidden`gtmJsURLRoot|text`gtmJsURLType|select`gtmOutputPath|text`gtmRootURL|text`gtmRoutinePath|text`wlUpdate|submit`"
 d setMethodAndNextPage^%zewdCompiler20("wlUpdate","saveMapacheConfig^%zewdMgrAjax","configSettingsSaved",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("mapacheConfig",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .k ^%zewdSession("session","ewd_idList",sessid)
 .w "   <span>"_$c(13,10)
 .w "      <form action='/vista/ewdMgr/mapacheConfig.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "         <table border=""0"" class=""configTable"">"_$c(13,10)
 .w "            <tr class=""configRow"">"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'routine_path','350px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Routine path:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .s idList("gtmRoutinePath")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                  <input id=""gtmRoutinePath"" name=""gtmRoutinePath"" type=""text"" value='"_$$getSessionValue^%zewdAPI("gtmRoutinePath",sessid)_"' />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr class=""configRow"">"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'op_root_path','350px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Output path:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .s idList("gtmOutputPath")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                  <input id=""gtmOutputPath"" name=""gtmOutputPath"" type=""text"" value='"_$$getSessionValue^%zewdAPI("gtmOutputPath",sessid)_"' />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr class=""configRow"">"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'root_url','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Root URL:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .s idList("gtmRootURL")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                  <input id=""gtmRootURL"" name=""gtmRootURL"" size=""25"" type=""text"" value='"_$$getSessionValue^%zewdAPI("gtmRootURL",sessid)_"' />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td colspan=""2"">"_$c(13,10)
 .w "                  <br />"_$c(13,10)
 .w "                  <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'js_url','400px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Javascript (.js) file URL references:"_""
 .w "                  <br />"_$c(13,10)
 .w "                  <br />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr class=""configRow"">"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Type of URL:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <select id=""gtmJsURLType"" name=""gtmJsURLType"">"_$c(13,10)
 .d displayOptions^%zewdAPI("gtmJsURLType","gtmJsURLType",0)
 .w "                  </select>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Path root:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .s idList("gtmJsURLRoot")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                  <input id=""gtmJsURLRoot"" name=""gtmJsURLRoot"" type=""text"" value='"_$$getSessionValue^%zewdAPI("gtmJsURLRoot",sessid)_"' />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "         <div>"_$c(13,10)
 .w "            <br />"_$c(13,10)
 .w "            <input class=""actionButton"" id=""wlUpdate"" name=""wlUpdate"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'configSettingsSaved','/vista/ewdMgr/mapacheConfig.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("mapacheConfig")_"&ewd_urlNo=mapacheConfig1','nullId','') ;"" type=""button"" value=""Update"" />"_$c(13,10)
 .w "         </div>"_$c(13,10)
 .w "         <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "         <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "      </form>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""routine_path"">"_$c(13,10)
 .w "When compiling using the ""gtm"" option, ie to use MGWSI/"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w ", EWD generates GT.M Mumps routines.   EWD needs to know where to save the routine source files.  This is determined by this parameter.   Specify the path/directory into which you want the GT.M routine files to be created."_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""op_root_path"">"_$c(13,10)
 .w "When compiling to GT.M/"_""
 .w "         <i>"_$c(13,10)
 .w "m_apache"_""
 .w "         </i>"_$c(13,10)
 .w "routines, EWD needs to know where to save its automatically generated Javascript and CSS files.   This is determined by this parameter.  Specify the path/directory into which you want these files to be created."_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""web_server"">"_$c(13,10)
 .w "Click this to generate the suggested WebLink Root URL for your web server."_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""root_url"">"_$c(13,10)
 .w "This defines the root part of the MGWSI/m_apache URL that EWD will add to the page URLs it generates."_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""js_url"">"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "The two parameters below are used to instruct EWD how to construct the URLs that will point to the Javascript and CSS  files that it generates automatically for you, eg"_""
 .w "            <b>"_$c(13,10)
 .w "ewdScripts.js"_""
 .w "            </b>"_$c(13,10)
 .w "and"_""
 .w "            <b>"_$c(13,10)
 .w "ewd.css"_""
 .w "            </b>"_$c(13,10)
 .w "."_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "The recommended setting is  to set the"_""
 .w "            <i>"_$c(13,10)
 .w "Type of URL"_""
 .w "            </i>"_$c(13,10)
 .w "to"_""
 .w "            <b>"_$c(13,10)
 .w "Absolute"_""
 .w "            </b>"_$c(13,10)
 .w "and leave the"_""
 .w "            <i>"_$c(13,10)
 .w "Path Root"_""
 .w "            </i>"_$c(13,10)
 .w "as"_""
 .w "            <b>"_$c(13,10)
 .w "blank (ie null)"_""
 .w "            </b>"_$c(13,10)
 .w ", in which case  EWD will generate URLs that expect the JS and CSS files to be in the same path as your compiled CSP pages."_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "If you wanted ewdScripts.js to be fetched from"_""
 .w "            <b>"_$c(13,10)
 .w "src=""myJSFiles/ewdScripts.js"""_""
 .w "            </b>"_$c(13,10)
 .w ", then set  the"_""
 .w "            <i>"_$c(13,10)
 .w "Type of URL"_""
 .w "            </i>"_$c(13,10)
 .w "to"_""
 .w "            <b>"_$c(13,10)
 .w "Relative"_""
 .w "            </b>"_$c(13,10)
 .w "and set the"_""
 .w "            <i>"_$c(13,10)
 .w "Path Root"_""
 .w "            </i>"_$c(13,10)
 .w "to"_""
 .w "            <b>"_$c(13,10)
 .w "myJSFiles"_""
 .w "            </b>"_$c(13,10)
 .w "."_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "If you wanted ewdScripts.js to be fetched from"_""
 .w "            <b>"_$c(13,10)
 .w "src=""/myJSFiles/ewdScripts.js"""_""
 .w "            </b>"_$c(13,10)
 .w ", then set  the"_""
 .w "            <i>"_$c(13,10)
 .w "Type of URL"_""
 .w "            </i>"_$c(13,10)
 .w "to"_""
 .w "            <b>"_$c(13,10)
 .w "Absolute"_""
 .w "            </b>"_$c(13,10)
 .w "and set the"_""
 .w "            <i>"_$c(13,10)
 .w "Path Root"_""
 .w "            </i>"_$c(13,10)
 .w "to"_""
 .w "            <b>"_$c(13,10)
 .w "myJSFiles"_""
 .w "            </b>"_$c(13,10)
 .w "."_""
 .w "         </p>"_$c(13,10)
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
