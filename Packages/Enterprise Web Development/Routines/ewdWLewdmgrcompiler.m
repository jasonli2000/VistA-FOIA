 ;GT.M version of page compiler (ewdMgr application)
 ;Compiled on Tue, 24 Jan 2012 16:51:27
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
 s sessionArray("ewd_prePageScript")="compileSelectPrepage^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="compiler"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("compiler")=$$setNextPageToken^%zewdGTMRuntime("compiler")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s ebToken("setApplication^%zewdMgrAjax")=$$createEBToken^%zewdGTMRuntime("setApplication^%zewdMgrAjax",.sessionArray)
 s formInfo="appName|select`backEndTechnology|select`compileAll|submit`displayPages|submit`ewd_pressed|hidden`format|select`frontEndTechnology|select`persistenceDB|select`xref|submit`"
 d setMethodAndNextPage^%zewdCompiler20("compileAll","compileAll^%zewdMgrAjax","compilerResults",formInfo,.sessionArray)
 s formInfo="appName|select`backEndTechnology|select`compileAll|button`displayPages|submit`ewd_pressed|hidden`format|select`frontEndTechnology|select`persistenceDB|select`xref|submit`"
 d setMethodAndNextPage^%zewdCompiler20("displayPages","","compilePage",formInfo,.sessionArray)
 s formInfo="appName|select`backEndTechnology|select`compileAll|button`displayPages|button`ewd_pressed|hidden`format|select`frontEndTechnology|select`persistenceDB|select`xref|submit`"
 d setMethodAndNextPage^%zewdCompiler20("xref","","xref",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("compiler",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <span>"_$c(13,10)
 .if ($$getSessionValue^%zewdAPI("noOfApps",sessid)>"0") d
 ..w "            <div class=""propsText"">"_$c(13,10)
 ..w "               <form action='/vista/ewdMgr/compiler.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 ..w "                  <table border=""0"" class=""propsText"" width=""99%"">"_$c(13,10)
 ..w "                     <tr>"_$c(13,10)
 ..w "                        <td align=""left"" class=""selectorPanel"" style=""width:66%;"">"_$c(13,10)
 ..w "                           <h4 align=""center"">"_$c(13,10)
 ..w "EWD Applications"_""
 ..w "                              <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'apps_list','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 ..w "                           </h4>"_$c(13,10)
 ..w "                           <div class=""applicationPanel"">"_$c(13,10)
 ..w "                              <select id=""appName"" name=""appName"" onchange=""MGW.page.clearPanel('section2') ; MGW.page.selApp()"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("appName","appName",0)
 ..w "                              </select>"_$c(13,10)
 ..w "                              <input class=""actionButton"" id=""compileAll"" name=""compileAll"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'compilerResults','/vista/ewdMgr/compiler.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("compiler")_"&ewd_urlNo=compiler1','section2','') ;"" type=""button"" value=""Compile Application"" />"_$c(13,10)
 ..w "                              <input class=""actionButton"" id=""displayPages"" name=""displayPages"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'compilePage','/vista/ewdMgr/compiler.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("compiler")_"&ewd_urlNo=compiler2','section2','') ;"" type=""button"" value=""List/Compile pages"" />"_$c(13,10)
 ..w "                              <input class=""actionButton"" id=""xref"" name=""xref"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'xref','/vista/ewdMgr/compiler.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("compiler")_"&ewd_urlNo=compiler3','section2','') ;"" type=""button"" value=""Cross Refs"" />"_$c(13,10)
 ..w "                              <div class=""propsText"" id=""section2"">"_$c(13,10)
 ..w "</div>"_$c(13,10)
 ..w "                           </div>"_$c(13,10)
 ..w "                        </td>"_$c(13,10)
 ..w "                        <td class=""selectorPanel"" style=""width:34%;"">"_$c(13,10)
 ..w "                           <h4 align=""center"">"_$c(13,10)
 ..w "                              <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'comp_props','150px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 ..w "Compilation Properties"_""
 ..w "                           </h4>"_$c(13,10)
 ..w "                           <div class=""applicationPanel"" style=""height:auto"">"_$c(13,10)
 ..w "                              <table border=""0"" class=""propsTable"">"_$c(13,10)
 ..w "                                 <tr class=""configRow"">"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Web technology:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "                                       <select id=""frontEndTechnology"" name=""frontEndTechnology"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("frontEndTechnology","frontEndTechnology",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..w "                                 <tr class=""configRow"">"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Scripting technology:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td align=""right"">"_$c(13,10)
 ..w "                                       <select id=""backEndTechnology"" name=""backEndTechnology"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("backEndTechnology","backEndTechnology",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..w "                                 <tr class=""configRow"">"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Persistence Database:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td align=""right"">"_$c(13,10)
 ..w "                                       <select id=""persistenceDB"" name=""persistenceDB"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("persistenceDB","persistenceDB",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..w "                                 <tr>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Compiled page markup layout:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td align=""right"">"_$c(13,10)
 ..w "                                       <select id=""format"" name=""format"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("format","format",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..w "                              </table>"_$c(13,10)
 ..w "                           </div>"_$c(13,10)
 ..w "                        </td>"_$c(13,10)
 ..w "                     </tr>"_$c(13,10)
 ..w "                  </table>"_$c(13,10)
 ..w "                  <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 ..w "                  <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 ..w "               </form>"_$c(13,10)
 ..w "            </div>"_$c(13,10)
 ..
 .else  d
 ..w "            <br />"_$c(13,10)
 ..w "            <h4 align=""center"">"_$c(13,10)
 ..w "No EWD applications were found in your Application Root Directory"_""
 ..w "            </h4>"_$c(13,10)
 ..w "            <br />"_$c(13,10)
 ..
 .w "         <div class=""alertPanelOff"" id=""comp_props"">"_$c(13,10)
 .w "This panel shows the current settings that will be used if you compile an application or any page within     an application.  You can change the settings temporarily here, but if you want to change the default settings     permanently, click the"_""
 .w "            <i>"_$c(13,10)
 .w "Configuration"_""
 .w "            </i>"_$c(13,10)
 .w "tab."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""apps_list"">"_$c(13,10)
 .w "The list of EWD applications equates to the sub-directories in your EWD Application Root Path."_""
 .w "         </div>"_$c(13,10)
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
 w "  EWD.page.setTitle('enterprise web developer') ;"_$c(13,10)
 w "  MGW.page.selApp = function() {     var appField = document.getElementById(""appName"") ;     for (var i = 0; i < appField.length; i++) {"_$c(13,10)
 w "        if (appField.options[i].selected == true) {"_$c(13,10)
 w "           var fieldValue = appField.options[i].value ;"_$c(13,10)
 w "           EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("setApplication^%zewdMgrAjax")_"&px1=' + fieldValue + '','','synch','','') ;"_$c(13,10)
 w "        }"_$c(13,10)
 w "     }"_$c(13,10)
 w "  };"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
