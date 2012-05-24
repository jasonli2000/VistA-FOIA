 ;GT.M version of page applianceAbout (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="gtmAbout^%zewdMgr2"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="applianceAbout"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("applianceAbout",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <div>"_$c(13,10)
 .w "      <center>"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "         <table border=""1"" width=""80%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "EWD Virtual Appliance Version:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("ewdva_version",sessid)_" ; "_$$getSessionValue^%zewdAPI("ewdva_date",sessid)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Operating Environment:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Ubuntu 7.10 JEOS Linux"_""
 .w "                  <br />"_$c(13,10)
 .w "running as a VMWare Virtual Machine"_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Powered by:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("gtm_version",sessid)
 .w "                  <br />"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("ewdVersion",sessid)_" (FOSS Version)"_""
 .w "                  <br />"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "                  <i>"_$c(13,10)
 .w "m_apache"_""
 .w "                  </i>"_$c(13,10)
 .w "Gateway version:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("mgwsi_version",sessid)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Current date and time:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("gtm_dateTime",sessid)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "IP Address:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("ewd_ip",sessid)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "EWD Session ID of this application:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w $$getSessionValue^%zewdAPI("ewd_sessid",sessid)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Copyright:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "&copy; 2006-9, M/Gateway Developments Ltd. (All Rights Reserved)"_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Licensing:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Enterprise Web Developer,"_""
 .w "                  <i>"_$c(13,10)
 .w "m_apache"_""
 .w "                  </i>"_$c(13,10)
 .w "and the"_""
 .w "                  <i>"_$c(13,10)
 .w "ewdMgr"_""
 .w "                  </i>"_$c(13,10)
 .w "application are licensed under the  GNU Affero General Public License, as published by the Free Software Foundation,  either version 3 of the License, or (at your option) any later version.  See &lt;http://www.gnu.org/licenses/&gt;"_""
 .w "                  <br />"_$c(13,10)
 .w "                  <br />"_$c(13,10)
 .w "For licensing of other components included in this Virtual Appliance, please refer to the relevant documentation."_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Warranty:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "This Virtual Appliance (and all components contained in it) is distributed in the hope that it will be useful,  but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU Affero General Public License for more details."_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Support:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "None provided except by negotiated contract"_""
 .w "                  <br />"_$c(13,10)
 .w "Contact Rob Tweed at rtweed@mgateway.com for details"_""
 .w "                  <br />"_$c(13,10)
 .w "                  <br />"_$c(13,10)
 .w "                  <a href=""http://groups.google.co.uk/group/enterprise-web-developer-community"">"_$c(13,10)
 .w "Online Community:"_""
 .w "                  </a>"_$c(13,10)
 .w "http://groups.google.co.uk/group/enterprise-web-developer-community"_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "Special thanks to:"_""
 .w "               </td>"_$c(13,10)
 .w "               <td>"_$c(13,10)
 .w "George James Software for providing the Serenji server code"_""
 .w "                  <br />"_$c(13,10)
 .w "Jon Diamond and CAMTA for the Standard MUMPS Pocket Guide"_""
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "      </center>"_$c(13,10)
 .w "   </div>"_$c(13,10)
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
