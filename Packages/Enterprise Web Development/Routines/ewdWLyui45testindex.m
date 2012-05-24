 ;GT.M version of page index (yui-test application) ; 1/31/12 4:25pm
 ;Compiled on Tue, 31 Jan 2012 16:22:21
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
 s sessionArray("ewd_sessid_timeout")="1200"
 s sessionArray("ewd_prePageScript")=""
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="yui-test"
 s sessionArray("ewd_pageName")="index"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_header","Expires")=0
 s sessionArray("ewd_header","Cache-Control")="no-cache"
 s sessionArray("ewd_header","Pragma")="no-cache"
 s sessionArray("ewd_pageType")=""
 s ebToken("setErrorClasses^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("setErrorClasses^%zewdAPI",.sessionArray)
 s ebToken("saveJSON^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("saveJSON^%zewdAPI",.sessionArray)
 s ebToken("getJSON^%zewdCompiler13")=$$createEBToken^%zewdGTMRuntime("getJSON^%zewdCompiler13",.sessionArray)
 s ebToken("mergeToJSObject^%zewdAPI")=$$createEBToken^%zewdGTMRuntime("mergeToJSObject^%zewdAPI",.sessionArray)
 s Error=$$startSession^%zewdPHP("index",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 d loadFiles^%zewdCustomTags("yui-test","css",sessid)
 w "      <script src=""/vista/resources/ewdScripts.js"">"_$c(13,10)
 w "</script>"_$c(13,10)
 d writePageLinks^%zewdCompiler20("yui-test",sessid)
 w "      <title>"_$c(13,10)
 w "YUI Test"_""
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
 w "      <pre id=""ewdscript"">"_$c(13,10)
 w "EWD.page.yuiResourcePath = """_$$getSessionValue^%zewdAPI("yui.resourcePath",sessid)_""" ;"_""
 w "if (EWD.page.yuiResourcePath == '') {"_""
 w " alert('Unable to determine path to YUI resource file.  Did you run d install^%zewdYUIConf()?') ;"_""
 w "}"_""
 w "EWD.page.loadResource("""_$$getSessionValue^%zewdAPI("yui.resourceLoaderPath",sessid)_$$getSessionValue^%zewdAPI("yui.resourceLoader",sessid)_""",""js"") ;"_""
 w "if (!EWD.yui) alert('YUI Javascript resource file ewdYUIResources.js was not found in the web server root path');"_""
 w "if (!EWD.yui.build) alert('YUI Javascript resource file ewdYUIResources.js is out of date.  You must be using build 894');"_""
 w "if (EWD.yui.build != 894) alert('YUI Javascript resource file ewdYUIResources.js is out of date.  You are using build ' + EWD.yui.build + ' but you should be using build 894');"_""
 w "EWD.yui.version = """_$$getSessionValue^%zewdAPI("yui.resourcePath",sessid)_""" ;"_""
 w "EWD.yui.resourceLoader.Calendar() ;"_""
 w "document.getElementsByTagName('body')[0].className = 'yui-skin-sam' ;"_""
 w "EWD.yui.widget.Calendar.Opener['dateFieldBtnindex20'] = '';"_""
 w "      </pre>"_$c(13,10)
 w "   </head>"_$c(13,10)
 w "   <body onload=""EWD.page.setErrorClass() ; EWD.page.errorMessage('"_$$htmlEscape^%zewdGTMRuntime($$jsEscape^%zewdGTMRuntime(Error))_"')"">"_$c(13,10)
 w "      <div id=""top"">"_$c(13,10)
 w "         <p>"_$c(13,10)
 w "            <label for=""apptdate"">"_$c(13,10)
 w "Appointment Date"_""
 w "            </label>"_$c(13,10)
 w "            <input id=""apptdate"" name=""apptdate"" type=""text"" value='"_$$getSessionValue^%zewdAPI("apptdate",sessid)_"'>"_$c(13,10)
 w "               <img alt=""Calendar"" height=""18"" id=""dateFieldBtnindex20"" onclick=""EWD.yui.calendarEventHandler(this,'apptdate') ;"" src=""/vista/yui/build/calendar/assets/calbtn.gif"" title=""Show Calendar"" width=""18"" />"_$c(13,10)
 w "            </input>"_$c(13,10)
 w "         </p>"_$c(13,10)
 w "      </div>"_$c(13,10)
 w "   </body>"_$c(13,10)
 w "</html>"_$c(13,10)
 QUIT
