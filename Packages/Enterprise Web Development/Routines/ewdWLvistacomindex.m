 ;GT.M version of page index (VistACom application)
 ;Compiled on Fri, 03 Feb 2012 16:50:05
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
 s sessionArray("ewd_prePageScript")="INIT^KBAWEWD"
 s sessionArray("ewd_default_timeout")="1200"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="VistACom"
 s sessionArray("ewd_pageName")="index"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_header","Expires")=0
 s sessionArray("ewd_header","Cache-Control")="no-cache"
 s sessionArray("ewd_header","Pragma")="no-cache"
 s sessionArray("ewd_pageType")=""
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
 w "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Strict//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"">"_$c(13,10)
 w "<html xml:lang=""en"" xmlns=""http://www.w3.org/1999/xhtml"">"_$c(13,10)
 w "   <head>"_$c(13,10)
 w "      <link href=""/vista/resources/ewd.css"" rel=""stylesheet"" type=""text/css"" />"_$c(13,10)
 d loadFiles^%zewdCustomTags("vistacom","css",sessid)
 w "      <script src=""/vista/resources/ewdScripts.js"">"_$c(13,10)
 w "</script>"_$c(13,10)
 d writePageLinks^%zewdCompiler20("vistacom",sessid)
 w "      <meta content=""text/html"" http-equiv=""Content-Type"" />"_$c(13,10)
 w "      <title>"_$c(13,10)
 w "VistACom"_""
 w "      </title>"_$c(13,10)
 w "      <script type=""text/javascript"">"_$c(13,10)
 w "Ext.setup({"_$c(13,10)
 w "tabletStartupScreen:'/vista/images/tablet_startup.png',"_$c(13,10)
 w "phoneStartupScreen:'/vista/images/phone_startup.png',"_$c(13,10)
 w "icon:'/vista/images/icon.png',"_$c(13,10)
 w "addGlossToIcon:true,"_$c(13,10)
 w "onReady:function(){"_$c(13,10)
 w "EWD.ajax.getPage({page:'content',targetId:'ewdContent'});"_$c(13,10)
 w "if (EWD.sencha.combo) EWD.sencha.combo.init();"_$c(13,10)
 w "}"_$c(13,10)
 w "});"_$c(13,10)
 w "EWD.sencha.timer("_$$getSessionValue^%zewdAPI("ewd_sessid_timeout",sessid)_",'reload');"_$c(13,10)
 w ""_""
 w "      </script>"_$c(13,10)
 d startupImage^%zewdCustomTags("/vista/images/phone_startup.png","/vista/images/tablet_startup.png",$$getSessionValue^%zewdAPI("ewd_sessid",sessid))
 w "   </head>"_$c(13,10)
 w "   <body style=""background-image: url("_$$getSessionValue^%zewdAPI("ewd_startupImage",sessid)_");background-repeat: no-repeat"">"_$c(13,10)
 w "      <div id=""ewdNullId"" style=""display:none"">"_$c(13,10)
 w "&nbsp;"_""
 w "      </div>"_$c(13,10)
 w "      <div id=""ewdContent"">"_$c(13,10)
 w "&nbsp;"_""
 w "      </div>"_$c(13,10)
 w "   </body>"_$c(13,10)
 w "</html>"_$c(13,10)
 QUIT
