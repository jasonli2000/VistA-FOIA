 ;GT.M version of page security (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="securityPrepage^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="security"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("security")=$$setNextPageToken^%zewdGTMRuntime("security")
 s formInfo="addSN|submit`addUser|submit`deleteSN|submit`deleteUser|submit`disable|submit`editUser|submit`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("addSN","addIPAddress^%zewdMgrAjax","reloadSecurity",formInfo,.sessionArray)
 s formInfo="addSN|button`addUser|submit`deleteSN|submit`deleteUser|submit`disable|submit`editUser|submit`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("editUser","","user",formInfo,.sessionArray)
 s formInfo="addSN|button`addUser|submit`deleteSN|submit`deleteUser|submit`disable|submit`editUser|button`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("deleteUser","deleteUser^%zewdMgrAjax","reloadSecurity",formInfo,.sessionArray)
 s formInfo="addSN|button`addUser|submit`deleteSN|submit`deleteUser|button`disable|submit`editUser|button`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("addUser","addUser^%zewdMgrAjax","user",formInfo,.sessionArray)
 s formInfo="addSN|button`addUser|button`deleteSN|submit`deleteUser|button`disable|submit`editUser|button`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("disable","disableEwdMgr^%zewdMgrAjax","logout",formInfo,.sessionArray)
 s formInfo="addSN|button`addUser|button`deleteSN|submit`deleteUser|button`disable|button`editUser|button`ewd_pressed|hidden`newSubnet|text`newUser|text`subnet|select`user|select`"
 d setMethodAndNextPage^%zewdCompiler20("deleteSN","deleteIPAddress^%zewdMgrAjax","reloadSecurity",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("security",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <div class=""propsText"">"_$c(13,10)
 .w "         <table border=""0"" class=""propsText"" style=""table-layout:fixed"" width=""99%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td align=""left"" class=""selectorPanel"">"_$c(13,10)
 .w "                  <div>"_$c(13,10)
 .w "                     <h4>"_$c(13,10)
 .w "&nbsp;&nbsp;&nbsp;Manage Access to this Application"_""
 .w "                        <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'about_security','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "                     </h4>"_$c(13,10)
 .w "                     <div class=""applicationPanel"">"_$c(13,10)
 .w "                        <form action='/vista/ewdMgr/security.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "                           <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 .if ($$getSessionValue^%zewdAPI("noOfIPs",sessid)>"0") d
 ..w "                                 <tr>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Authorised IP addresses or ranges:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "                                       <select id=""subnet"" name=""subnet"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("subnet","subnet",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                       <input class=""actionButton"" id=""deleteSN"" name=""deleteSN"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.page.showConfirmMessage=true ; EWD.page.confirmText='Click OK to delete address' ; EWD.ajax.confirmSubmit(EWD.page.confirmText) ; EWD.ajax.submit(this.name,this.form,'reloadSecurity','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security6','securityNullid','') ;"" type=""button"" value=""Delete"" />"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .w "                                    <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'about_ip','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Add an IP address or range:"_""
 .w "                                 </td>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .s idList("newSubnet")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                    <input id=""newSubnet"" name=""newSubnet"" type=""text"" value="""" />"_$c(13,10)
 .w "                                    <input class=""actionButton"" id=""addSN"" name=""addSN"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'reloadSecurity','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security1','securityNullid','') ;"" type=""button"" value=""Add"" />"_$c(13,10)
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td colspan=""2"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .if ($$getSessionValue^%zewdAPI("noOfUsers",sessid)>"0") d
 ..w "                                 <tr>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "Authorised usernames:"_""
 ..w "                                    </td>"_$c(13,10)
 ..w "                                    <td>"_$c(13,10)
 ..w "                                       <select id=""user"" name=""user"">"_$c(13,10)
 ..d displayOptions^%zewdAPI("user","user",0)
 ..w "                                       </select>"_$c(13,10)
 ..w "                                       <input class=""actionButton"" id=""editUser"" name=""editUser"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'user','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security2','securityEditPanel','') ;"" type=""button"" value=""Edit"" />"_$c(13,10)
 ..w "                                       <input class=""actionButton"" id=""deleteUser"" name=""deleteUser"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.page.showConfirmMessage=true ; EWD.page.confirmText='Click OK to delete user' ; EWD.ajax.confirmSubmit(EWD.page.confirmText) ; EWD.ajax.submit(this.name,this.form,'reloadSecurity','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security3','securityNullid','') ;"" type=""button"" value=""Delete"" />"_$c(13,10)
 ..w "                                    </td>"_$c(13,10)
 ..w "                                 </tr>"_$c(13,10)
 ..
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .w "                                    <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'about_user','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Add a user:"_""
 .w "                                 </td>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .s idList("newUser")="actionButton"
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                    <input class=""actionButton"" id=""newUser"" name=""newUser"" type=""text"" value="""" />"_$c(13,10)
 .w "                                    <input class=""actionButton"" id=""addUser"" name=""addUser"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'user','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security4','securityEditPanel','') ;"" type=""button"" value=""Add"" />"_$c(13,10)
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td colspan=""2"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .w "                                    <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'about_disable','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Disable ewdMgr:"_""
 .w "                                 </td>"_$c(13,10)
 .w "                                 <td>"_$c(13,10)
 .w "                                    <input class=""actionButton"" id=""disable"" name=""disable"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.page.showConfirmMessage=true ; EWD.page.confirmText='Are you sure you want to disable ewdMgr?' ; EWD.ajax.confirmSubmit(EWD.page.confirmText) ; EWD.ajax.submit(this.name,this.form,'logout','/vista/ewdMgr/security.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("security")_"&ewd_urlNo=security5','securityNullid','') ;"" type=""button"" value=""Disable"" />"_$c(13,10)
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .w "                           </table>"_$c(13,10)
 .w "                           <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                           <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                        </form>"_$c(13,10)
 .w "                     </div>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "               <td align=""left"" class=""selectorPanel"" id=""securityEditPanel"">"_$c(13,10)
 .w "</td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <div id=""securityNullid"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""about_disable"">"_$c(13,10)
 .w "If you click this, then this application (the ewdMgr application) will be flagged as disabled will not be able to be run unless you re-enable it using the command-line API: d enableEwdMgr^%zewdAPI."_""
 .w "         <p>"_$c(13,10)
 .w "It is recommended that ewdMgr is disabled or totally removed from production systems"_""
 .w "         </p>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""about_security"">"_$c(13,10)
 .w "This allows you to restrict access to the Enterprise Web Developer web interface (ewdMgr application) to only specifiedIP address ranges and/or IP addresses.  By default, the ewdMgr application is only accessible via the EWD server's localhost."_""
 .w "         <p>"_$c(13,10)
 .w "To ensure the security of the ewdMgr application, you may specify users who are authorised to use it.  Add and/or amend their details from the form below.  Users who are specified as administrators can modify the Enterprise Web Developer Configuration parameters and add/amend users."_""
 .w "         </p>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""about_ip"">"_$c(13,10)
 .w "Specify a full IP address or a partial IP address: for example, to allow access across the range 192.168.123.0 to 192.168.123.255, enter 192.168.123"_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""about_user"">"_$c(13,10)
 .w "To add a new user, enter a new username here and click Add.  You'll then be asked to enter the new user's profile details."_""
 .w "         <p>"_$c(13,10)
 .w "If you add one or more users, next time you start this application, you'll be asked to log in with one of    the valid usernames."_""
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
