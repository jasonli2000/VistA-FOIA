 ;GT.M version of page docParams (ewdMgr application)
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
 s sessionArray("ewd_pageName")="docParams"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("docParam")=$$setNextPageToken^%zewdGTMRuntime("docParam")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("docParams",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <span class=""propsText"">"_$c(13,10)
 .if ($$existsInSession^%zewdAPI("domParams",sessid)) d
 ..w "            <div style=""width:20%;height:200px;float:left"">"_$c(13,10)
 ..w "               <br />"_$c(13,10)
 ..s paramNo=""
 ..i paramNo?1N.N s paramNo=paramNo-1
 ..i paramNo?1AP.ANP d
 ... s p1=$e(paramNo,1,$l(paramNo)-1)
 ... s p2=$e(paramNo,$l(paramNo))
 ... s p2=$c($a(p2)-1)
 ... s paramNo=p1_p2
 ..s nul=""
 ..s endValue23=""
 ..i endValue23?1N.N s endValue23=endValue23+1
 ..f  q:'(($o(^%zewdSession("session",sessid,"domParams",paramNo))'=endValue23)&($o(^%zewdSession("session",sessid,"domParams",paramNo))'=nul))  d
 ...s paramNo=$o(^%zewdSession("session",sessid,"domParams",paramNo))
 ...s dummy=$g(^%zewdSession("session",sessid,"domParams",paramNo))
 ...w "                  <a href=""javascript:EWD.page.showParam("_paramNo_")"">"_$c(13,10)
 ...w $$getResultSetValue^%zewdAPI("domParams",paramNo,"name",sessid)
 ...w "                  </a>"_$c(13,10)
 ...w "                  <br />"_$c(13,10)
 ...
 ..w "               <br />"_$c(13,10)
 ..w "               <p class=""tinyText"">"_$c(13,10)
 ..w "* = mandatory"_""
 ..w "               </p>"_$c(13,10)
 ..w "            </div>"_$c(13,10)
 ..w "            <div id=""paramDetail"" style=""width:75%;height:200px;float:left;"">"_$c(13,10)
 ..s paramNo="1"
 ..w "               <h4 align=""center"" id=""paramTitle"">"_$c(13,10)
 ..w $$getResultSetValue^%zewdAPI("domParams",paramNo,"name",sessid)
 ..w "               </h4>"_$c(13,10)
 ..w "               <textarea cols=""40"" id=""missingName86"" name=""missingName86"" rows=""8"" style=""border:none"">"_$c(13,10)
 ..w $$getResultSetValue^%zewdAPI("domParams",paramNo,"desc",sessid)
 ..w "</textarea>"_$c(13,10)
 ..w "            </div>"_$c(13,10)
 ..
 .else  d
 ..w "Not applicable"_""
 ..
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
 w "  EWD.page.showParam = function(no) {"_$c(13,10)
 w "    var nvp = ""paramNo="" + no ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/docParam.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("docParam")_"&ewd_urlNo=docParams1&' + nvp,""paramDetail"",'get','','') ;"_$c(13,10)
 w "  }"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
