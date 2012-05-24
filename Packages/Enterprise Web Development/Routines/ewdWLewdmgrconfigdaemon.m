 ;GT.M version of page configDaemon (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getDaemonData^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="configDaemon"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("configDaemon")=$$setNextPageToken^%zewdGTMRuntime("configDaemon")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s ebToken("stop^%zewdDaemon")=$$createEBToken^%zewdGTMRuntime("stop^%zewdDaemon",.sessionArray)
 s ebToken("start^%zewdDaemon")=$$createEBToken^%zewdGTMRuntime("start^%zewdDaemon",.sessionArray)
 s formInfo="activateDaemon|radio`configUpdate|submit`daemonStart|button`daemonStop|button`ewd_pressed|hidden`hangTime|text`"
 d setMethodAndNextPage^%zewdCompiler20("configUpdate","setDaemonData^%zewdMgrAjax","configDaemon",formInfo,.sessionArray)
 s formInfo="authType|radio`emailConfigUpdate|submit`ewd_pressed|hidden`password|password`serverDomain|text`username|text`"
 d setMethodAndNextPage^%zewdCompiler20("emailConfigUpdate","setEmailDaemonData^%zewdMgrAjax","configSettingsSaved",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("configDaemon",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .k ^%zewdSession("session","ewd_idList",sessid)
 .w "      <span class=""mediumText"">"_$c(13,10)
 .w "         <table border=""0"" width=""96%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td class=""selectorPanel"">"_$c(13,10)
 .w "                  <h4 align=""center"">"_$c(13,10)
 .w "Background Daemon Process Configuration"_""
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'daemon_info','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "                  </h4>"_$c(13,10)
 .w "                  <div class=""applicationPanel"">"_$c(13,10)
 .w "                     <form action='/vista/ewdMgr/configDaemon.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm2"">"_$c(13,10)
 .w "                        <br />"_$c(13,10)
 .w "                        <table class=""configTable"">"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "Daemon enabled?:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <input id=""activateDaemon"" "_$s($$getSessionValue^%zewdAPI("activateDaemon",sessid)="true":"checked='checked'",1:"")_" name=""activateDaemon"" type=""radio"" value=""true"" />"_$c(13,10)
 .w ": Yes"_""
 .w "                                 <br />"_$c(13,10)
 .w "                                 <input id=""activateDaemon"" "_$s($$getSessionValue^%zewdAPI("activateDaemon",sessid)="false":"checked='checked'",1:"")_" name=""activateDaemon"" type=""radio"" value=""false"" />"_$c(13,10)
 .w ": No"_""
 .w "                                 <br />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'hang_time','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Hang period (secs):"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .s idList("hangTime")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                 <input id=""hangTime"" name=""hangTime"" size=""5"" type=""text"" value='"_$$getSessionValue^%zewdAPI("hangTime",sessid)_"' />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "Daemon Status:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <span id=""daemonStatus"">"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("daemonStatus",sessid)
 .w "                                 </span>"_$c(13,10)
 .s startClass="alertPanelOff"
 .s stopClass="alertPanelOff"
 .if ($$getSessionValue^%zewdAPI("daemonStatus",sessid)="Running") d
 ..s stopClass="actionButton"
 ..
 .else  if ($$getSessionValue^%zewdAPI("daemonStatus",sessid)="Stopped")  d
 ..s startClass="actionButton"
 ..
 .w "                                 <input class="""_stopClass_""" id=""daemonStop"" name=""daemonStop"" onclick=""MGW.page.stopDaemon()"" type=""button"" value=""Stop"" />"_$c(13,10)
 .w "                                 <input class="""_startClass_""" id=""daemonStart"" name=""daemonStart"" onclick=""MGW.page.startDaemon()"" type=""button"" value=""Start"" />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                        </table>"_$c(13,10)
 .w "                        <div>"_$c(13,10)
 .w "                           <br />"_$c(13,10)
 .w "                           <input class=""actionButton"" id=""configUpdate"" name=""configUpdate"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'configDaemon','/vista/ewdMgr/configDaemon.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("configDaemon")_"&ewd_urlNo=configDaemon1','configMenu','') ;"" type=""button"" value=""Update"" />"_$c(13,10)
 .w "                        </div>"_$c(13,10)
 .w "                        <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                        <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                     </form>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "               <td class=""selectorPanel"">"_$c(13,10)
 .w "                  <h4 align=""center"">"_$c(13,10)
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'email_daemon','340')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Email Dispatcher Configuration"_""
 .w "                  </h4>"_$c(13,10)
 .w "                  <div class=""applicationPanel"">"_$c(13,10)
 .w "                     <form action='/vista/ewdMgr/configDaemon.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "                        <br />"_$c(13,10)
 .w "                        <table class=""configTable"">"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "SMTP Server domain name/IP address:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .s idList("serverDomain")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                 <input id=""serverDomain"" name=""serverDomain"" size=""20"" type=""text"" value='"_$$getSessionValue^%zewdAPI("serverDomain",sessid)_"' />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "Use SMTP Authentication?:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <input id=""authType"" "_$s($$getSessionValue^%zewdAPI("authType",sessid)="1":"checked='checked'",1:"")_" name=""authType"" onclick=""MGW.page.usernameOn()"" type=""radio"" value=""1"" />"_$c(13,10)
 .w ": Yes"_""
 .w "                                 <br />"_$c(13,10)
 .w "                                 <input id=""authType"" "_$s($$getSessionValue^%zewdAPI("authType",sessid)="0":"checked='checked'",1:"")_" name=""authType"" onclick=""MGW.page.usernameOff()"" type=""radio"" value=""0"" />"_$c(13,10)
 .w ": No"_""
 .w "                                 <br />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .s rowClass="alertPanelOff"
 .if ($$getSessionValue^%zewdAPI("authType",sessid)="1") d
 ..s rowClass="configRow"
 ..
 .w "                           <tr class="""_rowClass_""" id=""usernameRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "SMTP Server Username:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .s idList("username")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                 <input id=""username"" name=""username"" size=""30"" type=""text"" value='"_$$getSessionValue^%zewdAPI("username",sessid)_"' />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class="""_rowClass_""" id=""passwordRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "SMTP Server Password:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .s idList("password")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                 <input id=""password"" name=""password"" size=""30"" type=""password"" value='"_$$getSessionValue^%zewdAPI("password",sessid)_"' />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td colspan=""2"">"_$c(13,10)
 .w "                                 <input class=""actionButton"" id=""emailConfigUpdate"" name=""emailConfigUpdate"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'configSettingsSaved','/vista/ewdMgr/configDaemon.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("configDaemon")_"&ewd_urlNo=configDaemon2','nullId','') ;"" type=""button"" value=""Update"" />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "No of queued emails:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("noOfEmails",sessid)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "To queue an email:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <i>"_$c(13,10)
 .w "d queueMail^%zewdDaemon(from,to,.cc,subject,.text)"_""
 .w "                                 </i>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                        </table>"_$c(13,10)
 .w "                        <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                        <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                     </form>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "         <div id=""nullId"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""alertPanel"">"_$c(13,10)
 .w "Configuration settings saved"_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""daemon_info"">"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "The EWD Background Daemon is an optional background Cach&eacute; process that you can instruct EWD to     start for you (it is started automatically by anyone starting an EWD session).  The Daemon has two key     purposes:"_""
 .w "            </p>"_$c(13,10)
 .w "            <ul>"_$c(13,10)
 .w "               <li>"_$c(13,10)
 .w "It takes over responsibility for the garbage-collection of expired EWD sessions, making the instantiation of          new EWD sessions more efficient and faster"_""
 .w "               </li>"_$c(13,10)
 .w "               <li>"_$c(13,10)
 .w "It provides an offline, asynchronous service for dispatching Cach&eacute;-generated emails via SMTP"_""
 .w "               </li>"_$c(13,10)
 .w "            </ul>"_$c(13,10)
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""hang_time"">"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "You can set the polling time interval for the Daemon process using this parameter.  The smaller the value, the        more frequently the Daemon process will check for timed-out EWD sessions and unsent, queued emails."_""
 .w "            </p>"_$c(13,10)
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""email_daemon"">"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "Configure these details to asynchronously dispatch emails that you add to the queue.  Note that     the EWD Background Daemon process must be enabled and running to use this facility."_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "Emails can be added     to the queue using the command:"_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "d queueMail^%zewdDaemon(from,to,.cc,subject,.text)"_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "where:"_""
 .w "               <br />"_$c(13,10)
 .w "from=the email address of the sender"_""
 .w "               <br />"_$c(13,10)
 .w "to=the email address of the recipient"_""
 .w "               <br />"_$c(13,10)
 .w "subject=the email subject line"_""
 .w "               <br />"_$c(13,10)
 .w "cc= local array of Cc'd recipients, eg cc(""rtweed@example.com"")="""""_""
 .w "               <br />"_$c(13,10)
 .w "text= local array containing email message text, eg text(lineNo)=Line of text"_""
 .w "            </p>"_$c(13,10)
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
 w "  MGW.page.stopDaemon = function() {"_$c(13,10)
 w "    EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("stop^%zewdDaemon")_"','','synch','','') ;"_$c(13,10)
 w "    alert(""Daemon flagged to stop"") ;    document.getElementById(""daemonStatus"").innerHTML = ""Flagged to stop"" ;   document.getElementById(""daemonStop"").className = ""alertPanelOff"" ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.startDaemon = function() {"_$c(13,10)
 w "    EWD.ajax.makeRequest('"_$$getRootURL^%zewdCompiler("gtm")_"ewdeb/eb.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"&eb="_ebToken("start^%zewdDaemon")_"','','synch','','') ;"_$c(13,10)
 w "    alert(""Daemon process started"") ;"_$c(13,10)
 w "    document.getElementById(""daemonStatus"").innerHTML = ""Running"" ;"_$c(13,10)
 w "   document.getElementById(""daemonStart"").className = ""alertPanelOff"" ;"_$c(13,10)
 w "   document.getElementById(""daemonStop"").className = ""actionButton"" ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.usernameOff = function() {"_$c(13,10)
 w "   document.getElementById(""usernameRow"").className = ""invisible"" ;"_$c(13,10)
 w "   document.getElementById(""passwordRow"").className = ""invisible"" ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.usernameOn = function() {"_$c(13,10)
 w "   document.getElementById(""usernameRow"").className = ""configRow"" ;"_$c(13,10)
 w "   document.getElementById(""passwordRow"").className = ""configRow"" ;"_$c(13,10)
 w "  };"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
