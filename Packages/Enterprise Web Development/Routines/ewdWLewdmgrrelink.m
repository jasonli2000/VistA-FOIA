 ;GT.M version of page relink (ewdMgr application)
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
 s sessionArray("ewd_isFirstPage")="1"
 s sessionArray("ewd_sessid_timeout")="3600"
 s sessionArray("ewd_prePageScript")="relink^%zewdGTMRuntime"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="relink"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")=""
 s ebToken("setErrorClasses^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("setErrorClasses^%zewdAPI",.sessionArray)
 s ebToken("saveJSON^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("saveJSON^%zewdAPI",.sessionArray)
 s ebToken("getJSON^%zewdCompiler13")=$$createEBToken^%zewdGTMRuntime("getJSON^%zewdCompiler13",.sessionArray)
 s ebToken("mergeToJSObject^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("mergeToJSObject^%zewdAPI",.sessionArray)
 s Error=$$startSession^%zewdPHP("relink",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 w "<html>"_$c(13,10)
 w "   <head>"_$c(13,10)
 w "      <link href=""/vista/resources/ewd.css"" rel=""stylesheet"" type=""text/css"" />"_$c(13,10)
 d loadFiles^%zewdCustomTags("ewdmgr","css",sessid)
 w "      <script src=""/vista/resources/ewdScripts.js"">"_$c(13,10)
 w "</script>"_$c(13,10)
 d writePageLinks^%zewdCompiler20("ewdmgr",sessid)
 w "      <title>"_$c(13,10)
 w "M/Gateway Developments Ltd: Back-end routine Re-linker"_""
 w "      </title>"_$c(13,10)
 w "      <script language=""javascript"">"_$c(13,10)
 w "       EWD.page.confirmText='"_$$jsEscape^%zewdGTMRuntime(confirmText)_"' ;"_$c(13,10)
 w "  EWD.page.setOnSubmit =  function(obj,confirmText) { "_$c(13,10)
 w "                            str='return EWD.page.displayConfirm(""' + confirmText+ '"")' ;"_$c(13,10)
 w "                            obj.form.onsubmit=new Function(str) ;"_$c(13,10)
 w "                          } ;"_$c(13,10)
 w "  EWD.page.setErrorClass = function () { "_$c(13,10)
 w "                             if ('"_$$getSessionValue^%zewdAPI("ewd_hasErrors",sessid)_"' == '1') {"_$c(13,10)
 w "                               EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("setErrorClasses^%zewdAPI")_"','','synch','','') ;"_$c(13,10)
 w "                             }"_$c(13,10)
 w "                           } ;"_$c(13,10)
 w "  EWD.utils.putObjectToSession = function (objName) { "_$c(13,10)
 w "                           var json,x ;"_$c(13,10)
 w "                           if (typeof(dojo) != ""undefined"") {"_$c(13,10)
 w "                             x = ""json = dojo.toJson("" + objName + "")"" ;"_$c(13,10)
 w "                             eval(x) ;"_$c(13,10)
 w "                           }"_$c(13,10)
 w "                           else {"_$c(13,10)
 w "                             //x = ""json="" + objName + "".toJSONString()"" ;"_$c(13,10)
 w "                             //eval(x) ;"_$c(13,10)
 w "                             x = ""json=toJsonString("" + objName + "");"" ;"_$c(13,10)
 w "                             eval(x) ;"_$c(13,10)
 w "                             //json=toJsonString(objName);"_$c(13,10)
 w "                           }"_$c(13,10)
 w "                           EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("saveJSON^%zewdAPI")_"&px1=' + objName + '&px2=' + json + '','','synch','','') ;"_$c(13,10)
 w "                         } ;"_$c(13,10)
 w "  EWD.utils.getObjectFromSession = function (objName, refresh, addRefCol) { "_$c(13,10)
 w "                          if (refresh) {"_$c(13,10)
 w "                             eval(""delete("" + objName + "") ;"") ;"_$c(13,10)
 w "                             var objExists = ""undefined"" ;"_$c(13,10)
 w "                          }"_$c(13,10)
 w "                          else {"_$c(13,10)
 w "                             var x = ""var objExists = typeof("" + objName + "");"" ;"_$c(13,10)
 w "                             eval(x) ;"_$c(13,10)
 w "                          }"_$c(13,10)
 w "                          if (objExists == ""undefined"") {"_$c(13,10)
 w "                            var addRef = 0 ;"_$c(13,10)
 w "                            if (addRefCol) addRef = 1;"_$c(13,10)
 w "                            EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("getJSON^%zewdCompiler13")_"&px1=' + objName + '&px2=' + addRef + '','','synch','','') ;"_$c(13,10)
 w ""_""
 w "                          };"_$c(13,10)
 w "                        } ;"_$c(13,10)
 w "  EWD.utils.mergeObjectFromSession = function (sessionName,JSObjName) { "_$c(13,10)
 w "                            EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("mergeToJSObject^%zewdAPI")_"&px1=' + sessionName + '&px2=' + JSObjName + '','','synch','','') ;"_$c(13,10)
 w "                        } ;"_$c(13,10)
 w ""_""
 w "      </script>"_$c(13,10)
 w "   </head>"_$c(13,10)
 w "   <body onload=""EWD.page.setErrorClass() ; EWD.page.errorMessage('"_$$htmlEscape^%zewdGTMRuntime($$jsEscape^%zewdGTMRuntime(Error))_"')"">"_$c(13,10)
 w "      <h3>"_$c(13,10)
 w "m_apache Process Relinker"_""
 w "      </h3>"_$c(13,10)
 w "      <p>"_$c(13,10)
 w "The following routines were relinked:"_""
 w "      </p>"_$c(13,10)
 w "      <ul>"_$c(13,10)
 s rou=""
 i rou?1N.N s rou=rou-1
 i rou?1AP.ANP d
 . s p1=$e(rou,1,$l(rou)-1)
 . s p2=$e(rou,$l(rou))
 . s p2=$c($a(p2)-1)
 . s rou=p1_p2
 s nul=""
 s endValue19=""
 i endValue19?1N.N s endValue19=endValue19+1
 f  q:'(($o(^%zewdSession("session",sessid,"ewd_relinkList",rou))'=endValue19)&($o(^%zewdSession("session",sessid,"ewd_relinkList",rou))'=nul))  d
 .s rou=$o(^%zewdSession("session",sessid,"ewd_relinkList",rou))
 .s dummy=$g(^%zewdSession("session",sessid,"ewd_relinkList",rou))
 .w "            <li>"_$c(13,10)
 .w rou
 .w "            </li>"_$c(13,10)
 .
 w "      </ul>"_$c(13,10)
 w "   </body>"_$c(13,10)
 w "</html>"_$c(13,10)
 QUIT
