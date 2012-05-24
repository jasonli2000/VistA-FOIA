 ;GT.M version of page xrefPageFromTag (ewdMgr application)
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
 s sessionArray("ewd_pageName")="xrefPageFromTag"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("xrefPageFromTag",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <h5>"_$c(13,10)
 .w "References to each Custom Tag in the "_$$getSessionValue^%zewdAPI("app",sessid)_" application"_""
 .w "   </h5>"_$c(13,10)
 .if ($$existsInSession^%zewdAPI("tagCalledBy",sessid)) d
 ..w "      <table border=""1"" class=""propsText"" width=""100%"">"_$c(13,10)
 ..w "         <tr>"_$c(13,10)
 ..w "            <td align=""center"" class=""listingCol"">"_$c(13,10)
 ..w "               <b>"_$c(13,10)
 ..w "Custom Tag"_""
 ..w "               </b>"_$c(13,10)
 ..w "            </td>"_$c(13,10)
 ..w "            <td align=""center"" class=""listingCol"">"_$c(13,10)
 ..w "               <b>"_$c(13,10)
 ..w "Referenced from Page"_""
 ..w "               </b>"_$c(13,10)
 ..w "            </td>"_$c(13,10)
 ..w "         </tr>"_$c(13,10)
 ..s tag=""
 ..i tag?1N.N s tag=tag-1
 ..i tag?1AP.ANP d
 ... s p1=$e(tag,1,$l(tag)-1)
 ... s p2=$e(tag,$l(tag))
 ... s p2=$c($a(p2)-1)
 ... s tag=p1_p2
 ..s nul=""
 ..s endValue36=""
 ..i endValue36?1N.N s endValue36=endValue36+1
 ..f  q:'(($o(^%zewdSession("session",sessid,"tagCalledBy",tag))'=endValue36)&($o(^%zewdSession("session",sessid,"tagCalledBy",tag))'=nul))  d
 ...s tag=$o(^%zewdSession("session",sessid,"tagCalledBy",tag))
 ...s data=$g(^%zewdSession("session",sessid,"tagCalledBy",tag))
 ...w "            <tr>"_$c(13,10)
 ...w "               <td align=""center"" class=""listingCol"">"_$c(13,10)
 ...w tag
 ...w "               </td>"_$c(13,10)
 ...w "               <td class=""listingCol"">"_$c(13,10)
 ...s pageFrom=""
 ...i pageFrom?1N.N s pageFrom=pageFrom-1
 ...i pageFrom?1AP.ANP d
 .... s p1=$e(pageFrom,1,$l(pageFrom)-1)
 .... s p2=$e(pageFrom,$l(pageFrom))
 .... s p2=$c($a(p2)-1)
 .... s pageFrom=p1_p2
 ...s nul=""
 ...s endValue53=""
 ...i endValue53?1N.N s endValue53=endValue53+1
 ...f  q:'(($o(^%zewdSession("session",sessid,"tagCalledBy",tag,pageFrom))'=endValue53)&($o(^%zewdSession("session",sessid,"tagCalledBy",tag,pageFrom))'=nul))  d
 ....s pageFrom=$o(^%zewdSession("session",sessid,"tagCalledBy",tag,pageFrom))
 ....s type=$g(^%zewdSession("session",sessid,"tagCalledBy",tag,pageFrom))
 ....w pageFrom
 ....w "                     <br />"_$c(13,10)
 ....
 ...w "               </td>"_$c(13,10)
 ...w "            </tr>"_$c(13,10)
 ...
 ..w "      </table>"_$c(13,10)
 ..
 .else  d
 ..w "      <div class=""propsText"">"_$c(13,10)
 ..w "No custom tags have been referenced"_""
 ..w "      </div>"_$c(13,10)
 ..
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
