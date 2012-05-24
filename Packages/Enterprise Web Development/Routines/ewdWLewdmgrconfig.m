 ;GT.M version of page config (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="configPrepage^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="config"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("config")=$$setNextPageToken^%zewdGTMRuntime("config")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("mapacheConfig")=$$setNextPageToken^%zewdGTMRuntime("mapacheConfig")
 s formInfo="appRootPath|text`backEndTechnology|select`configUpdate|submit`ewd_pressed|hidden`format|select`frontEndTechnology|select`persistenceDB|select`"
 d setMethodAndNextPage^%zewdCompiler20("configUpdate","saveMainConfig^%zewdMgrAjax","configSettingsSaved",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("config",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "Compiler Settings"_""
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'compiler_settings','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "                  </h4>"_$c(13,10)
 .w "                  <div class=""applicationPanel"">"_$c(13,10)
 .w "                     <form action='/vista/ewdMgr/config.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "                        <br />"_$c(13,10)
 .w "                        <table class=""configTable"">"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'app_src_path','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Application source path:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .s idList("appRootPath")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                                 <input id=""appRootPath"" name=""appRootPath"" type=""text"" value='"_$$getSessionValue^%zewdAPI("appRootPath",sessid)_"' />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'web_tech','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Web technology:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <select id=""frontEndTechnology"" name=""frontEndTechnology"">"_$c(13,10)
 .d displayOptions^%zewdAPI("frontEndTechnology","frontEndTechnology",0)
 .w "                                 </select>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'script_tech','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Scripting technology:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <select id=""backEndTechnology"" name=""backEndTechnology"">"_$c(13,10)
 .d displayOptions^%zewdAPI("backEndTechnology","backEndTechnology",0)
 .w "                                 </select>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr class=""configRow"">"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'persist_db','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Persistence Database:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <select id=""persistenceDB"" name=""persistenceDB"">"_$c(13,10)
 .d displayOptions^%zewdAPI("persistenceDB","persistenceDB",0)
 .w "                                 </select>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'page_markup','300px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Compiled page markup layout:"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td>"_$c(13,10)
 .w "                                 <select id=""format"" name=""format"">"_$c(13,10)
 .d displayOptions^%zewdAPI("format","format",0)
 .w "                                 </select>"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .w "                        </table>"_$c(13,10)
 .w "                        <div>"_$c(13,10)
 .w "                           <br />"_$c(13,10)
 .w "                           <input class=""actionButton"" id=""configUpdate"" name=""configUpdate"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'configSettingsSaved','/vista/ewdMgr/config.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("config")_"&ewd_urlNo=config2','nullId','') ;"" type=""button"" value=""Update"" />"_$c(13,10)
 .w "                        </div>"_$c(13,10)
 .w "                        <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                        <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "                     </form>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "               <td class=""selectorPanel"">"_$c(13,10)
 .w "                  <h4 align=""center"">"_$c(13,10)
 .w "Web Technologies"_""
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'web_tech_head','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "                  </h4>"_$c(13,10)
 .w "                  <table border=""0"" width=""98%"">"_$c(13,10)
 .w "                     <tr>"_$c(13,10)
 .w "                        <td>"_$c(13,10)
 .w "                           <table class=""innerTabs"" id=""webTechnologiesMenuMenu"">"_$c(13,10)
 .w "                              <tr>"_$c(13,10)
 .w "                                 <td id=""mapacheConfigTab"" onClick=""EWD.page.fetchmapacheConfig(); EWD.page.setInnerTabPage(this)"" onMouseOut=""EWD.page.deSelectInnerTab(this)"" onMouseOver=""EWD.page.selectInnerTab(this)"">"_$c(13,10)
 .w "GT.M / m_apache"_""
 .w "                                 </td>"_$c(13,10)
 .w "                              </tr>"_$c(13,10)
 .w "                           </table>"_$c(13,10)
 .w "                           <div class=""innerPanel"" id=""webTechnologiesMenu"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                           </div>"_$c(13,10)
 .w "                        </td>"_$c(13,10)
 .w "                     </tr>"_$c(13,10)
 .w "                  </table>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""alertPanel"">"_$c(13,10)
 .w "Configuration settings saved"_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""compiler_settings"">"_$c(13,10)
 .w "This section tells EWD where to find the source page directories, and defines     the default compiler settings.  It is recommended that you do not change these settings     unless you are an advanced user and fully familiar with EWD, GT.M and MGWSI/"_""
 .w "            <i>"_$c(13,10)
 .w "m_apache"_""
 .w "            </i>"_$c(13,10)
 .w "."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""app_src_path"">"_$c(13,10)
 .w "The file path/ directory under which all your source EWD application directories reside.     This parameter is essential for EWD to be able to locate where your EWD source files are held."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""web_tech"">"_$c(13,10)
 .w "The run-time web technology to which EWD will compile your pages by default."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""script_tech"">"_$c(13,10)
 .w "The pre-page and action scripts in your EWD pages can be written in a variety of languages.  This     parameter defines the default that EWD's compiler will expect to find in your source pages."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""persist_db"">"_$c(13,10)
 .w "EWD can use a variety of databases for its session persistence.  This parameter allows you to define     the default database technology that will be used for session persistence."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""page_markup"">"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "During development and testing, it is best to set this default parameter to ""indented"".  The markup in the     compiled versions of your pages will be laid out in a clearly readable format, indented where possible to reflect the XML     tag hierarchy within the page."_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "Applications that are ready for production deployment should be compiled in collapsed mode which removes     white space wherever possible, both within your markup and Javascript code.  This makes the application use     network bandwidth more efficiently, helps to obfuscate your page logic, and also may help to rectify some fine detail     related to styling."_""
 .w "            </p>"_$c(13,10)
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""web_tech_head"">"_$c(13,10)
 .w "This section allows you to configure EWD for each run-time web technology that you wish to use.  These settings     determine where EWD saves the compiled versions of your pages, and how it structures certain file references.     You only need to configure those technologies that you'll actually use.  It is recommended that you do not change these settings     unless you are an advanced user and fully familiar with EWD, GT.M and MGWSI/"_""
 .w "            <i>"_$c(13,10)
 .w "m_apache"_""
 .w "            </i>"_$c(13,10)
 .w "."_""
 .w "         </div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""pers_dbs"">"_$c(13,10)
 .w "EWD can use a variety of databases for its session persistence.  This section allows you to define the relevant connection     between your run-time web technology and the database.  In the case of Cach&eacute; or GT.M in conjunction with PHP,     this involves defining the"_""
 .w "            <i>"_$c(13,10)
 .w "server name"_""
 .w "            </i>"_$c(13,10)
 .w "connection used by the"_""
 .w "            <i>"_$c(13,10)
 .w "MGWSI"_""
 .w "            </i>"_$c(13,10)
 .w "gateway.  In the case of mySQL, you need to     specify the IP address of the mySQL server and the mySQL username and password.  If you are using GT.M/MGWSI (ie using"_""
 .w "            <i>"_$c(13,10)
 .w "m_apache"_""
 .w "            </i>"_$c(13,10)
 .w "), this section is not relevant, since session persistence automatically occurs within the GT.M    database.  It is recommended that you do not change these settings     unless you are an advanced user and fully familiar with EWD, GT.M and MGWSI/"_""
 .w "            <i>"_$c(13,10)
 .w "m_apache"_""
 .w "            </i>"_$c(13,10)
 .w "."_""
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
 w ""_""
 w "EWD.page.defineInnerTab('webTechnologiesMenu','mapacheConfigTab',true) ;"_$c(13,10)
 w "EWD.page.fetchmapacheConfig = function () {"_$c(13,10)
 w "  EWD.ajax.makeRequest('/vista/ewdMgr/mapacheConfig.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("mapacheConfig")_"&ewd_urlNo=config1','webTechnologiesMenu','get','','') ;"_$c(13,10)
 w "} ;"_$c(13,10)
 w "EWD.page.fetchmapacheConfig() ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
