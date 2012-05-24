 ;GT.M version of page listPage (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getPageDetails^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="listPage"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("listPage",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <table border=""0"" width=""100%"">"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td align=""center"" class=""header"" width=""98%"">"_$c(13,10)
 .w "Listing of "_$$getSessionValue^%zewdAPI("pageName",sessid)
 .w "            </td>"_$c(13,10)
 .w "            <td class=""header"" onclick=""document.getElementById('listPagePanel').className = 'listPagePanelOff' ;"" width=""2%"">"_$c(13,10)
 .w "               <input id=""x"" name=""x"" onclick=""document.getElementById('listPagePanel').className = 'listPagePanelOff' ;"" style=""font-size:10px; font-weight:bold; padding: 0px"" type=""button"" value=""X"" />"_$c(13,10)
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "      </table>"_$c(13,10)
 .w "      <div>"_$c(13,10)
 .w "         <textarea cols=""90"" id=""pageListing"" name=""pageListing"" rows=""24"" style=""border-width:0px"">"_$c(13,10)
 .d displayTextArea^%zewdAPI("pageListing")
 .w "</textarea>"_$c(13,10)
 .w "         <br />"_$c(13,10)
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
 w ""_$c(13,10)
 w "   MGW.page.grab = function(objid,e) {"_$c(13,10)
 w "     obj=document.getElementById(objid) ;     obj.className = ""dragging"" ;     startX = e.clientX ;"_$c(13,10)
 w "     startY = e.clientY ;"_$c(13,10)
 w "     divX = 20 ;"_$c(13,10)
 w "     divY = -18 ;"_$c(13,10)
 w "     if (obj.style.left != """") divX = parseInt(obj.style.left) ;"_$c(13,10)
 w "     if (obj.style.top != """") divY = parseInt(obj.style.top) ;"_$c(13,10)
 w "     grabbed = true ;"_$c(13,10)
 w "   };"_$c(13,10)
 w "   MGW.page.release = function(objid) {"_$c(13,10)
 w "     obj=document.getElementById(objid) ;"_$c(13,10)
 w "     obj.className = objid + ""On"" ;"_$c(13,10)
 w "     grabbed = false ;"_$c(13,10)
 w "   };"_$c(13,10)
 w "   MGW.page.moveDiv = function(objid,e) {"_$c(13,10)
 w "     if (grabbed) {"_$c(13,10)
 w "        obj=document.getElementById(objid) ;"_$c(13,10)
 w "        var newX = e.clientX ;"_$c(13,10)
 w "        var newY = e.clientY ;"_$c(13,10)
 w "        var diffX = startX - newX ;"_$c(13,10)
 w "        var diffY = startY - newY ;"_$c(13,10)
 w "        obj.style.left = (divX - diffX) +""px"" ;"_$c(13,10)
 w "        obj.style.top = (divY - diffY) + ""px"" ;"_$c(13,10)
 w "     }"_$c(13,10)
 w "   };"_$c(13,10)
 w "   grabbed = false ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
