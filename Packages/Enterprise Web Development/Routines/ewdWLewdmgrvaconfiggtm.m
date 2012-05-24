 ;GT.M version of page vaConfigGTM (ewdMgr application)
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
 s sessionArray("ewd_pageName")="vaConfigGTM"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("vaConfigGTM",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "   <span>"_$c(13,10)
 .w "      <h3>"_$c(13,10)
 .w "Managing the GT.M MUMPS Environment"_""
 .w "      </h3>"_$c(13,10)
 .w "A fully working GT.M system has been included in this Virtual Appliance. It is set up as follows"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <table border=""1"">"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "GT.M installation directory"_""
 .w "            </td>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "/usr/local/gtm"_""
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "         <tr>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "EWD installation directory"_""
 .w "            </td>"_$c(13,10)
 .w "            <td>"_$c(13,10)
 .w "/usr/local/gtm/ewd"_""
 .w "            </td>"_$c(13,10)
 .w "         </tr>"_$c(13,10)
 .w "      </table>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "The GT.M profile is automatically set up for you.  This has been achieved by adding the following line to the"_""
 .w "      <i>"_$c(13,10)
 .w "/etc/profile"_""
 .w "      </i>"_$c(13,10)
 .w "file:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "source /usr/local/gtm/gtmprofile"_""
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "To get into the GT.M MUMPS environment, do the following:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "cd /usr/local/gtm/ewd"_""
 .w "         <br />"_$c(13,10)
 .w "mumps -direct"_""
 .w "         <br />"_$c(13,10)
 .w "GTM&gt;"_""
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "To logout and return to the Linux shell prompt:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "GTM&gt;H"_""
 .w "         <br />"_$c(13,10)
 .w "ewd@ubuntuJEOS:/usr/local/gtm/ewd$"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "The easiest location for your EWD applications' prepage/action script routines is the"_""
 .w "      <i>"_$c(13,10)
 .w "/usr/local/gtm/ewd"_""
 .w "      </i>"_$c(13,10)
 .w "directory.  In GT.M, your routines are simply text files with a file extension of"_""
 .w "      <i>"_$c(13,10)
 .w ".m"_""
 .w "      </i>"_$c(13,10)
 .w ", eg"_""
 .w "      <i>"_$c(13,10)
 .w "myRoutine.m"_""
 .w "      </i>"_$c(13,10)
 .w "."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "You can upload routine files to the EWD Virtual Appliance via SCP (eg using WinSCP) to the"_""
 .w "      <i>"_$c(13,10)
 .w "/usr/local/gtm/ewd"_""
 .w "      </i>"_$c(13,10)
 .w "directory.   In fact, WinSCP can also be used to create and edit your scripts, provided you are happy to develop them using a simple text editor.  If you want something more sophisticated, use the Serenji client (see the tab above for more information)."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Compile and link your routines as follows, first making sure you're in the"_""
 .w "      <i>"_$c(13,10)
 .w "/usr/local/gtm/ewd"_""
 .w "      </i>"_$c(13,10)
 .w "directory:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "cd /usr/local/gtm/ewd"_""
 .w "         <br />"_$c(13,10)
 .w "mumps myRoutine.m"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "If your routine compiled without any errors, you'll now find a corresponding file with a file extension of"_""
 .w "      <i>"_$c(13,10)
 .w ".o"_""
 .w "      </i>"_$c(13,10)
 .w ", eg"_""
 .w "      <i>"_$c(13,10)
 .w "myRoutine.o"_""
 .w "      </i>"_$c(13,10)
 .w ".  This is the executable object code routine."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <h4>"_$c(13,10)
 .w "Important Note:"_""
 .w "      </h4>"_$c(13,10)
 .w "If you edit a routine and recompile it, any running MGWSI processes that executed the previous version will still have the previous version in memory.  When you try to re-run your compiled modified EWD application, the previous version will still appear to run.  You must therefore close all the MGWSI gateway processes.  To do this, select the MGWSI Gateway tab and do the following:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <ul>"_$c(13,10)
 .w "         <li>"_$c(13,10)
 .w "In the second column, labelled"_""
 .w "            <i>"_$c(13,10)
 .w "Connections to Cach&eacute;"_""
 .w "            </i>"_$c(13,10)
 .w ", select"_""
 .w "            <i>"_$c(13,10)
 .w "Close Connections"_""
 .w "            </i>"_$c(13,10)
 .w "         </li>"_$c(13,10)
 .w "         <li>"_$c(13,10)
 .w "Select"_""
 .w "            <i>"_$c(13,10)
 .w "*"_""
 .w "            </i>"_$c(13,10)
 .w "in the drop-down box of server names"_""
 .w "         </li>"_$c(13,10)
 .w "         <li>"_$c(13,10)
 .w "Click the"_""
 .w "            <i>"_$c(13,10)
 .w "Close Connections"_""
 .w "            </i>"_$c(13,10)
 .w "button"_""
 .w "         </li>"_$c(13,10)
 .w "      </ul>"_$c(13,10)
 .w "You can now continue using your EWD application as normal: the MGWSI gateway will automatically re-open the connections it requires."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "For further information about GT.M, go to"_""
 .w "      <a href=""http://sourceforge.net/projects/fis-gtm"">"_$c(13,10)
 .w "http://sourceforge.net/projects/fis-gtm"_""
 .w "      </a>"_$c(13,10)
 .w "and download the documentation."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <hr />"_$c(13,10)
 .w "Note: If you build your own Ubuntu JEOS or LAMP Server-based system, you must open up the privileges to the"_""
 .w "      <i>"_$c(13,10)
 .w "/var"_""
 .w "      </i>"_$c(13,10)
 .w "path in order to get GT.M working, ie do the following:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "cd /"_""
 .w "         <br />"_$c(13,10)
 .w "sudo chmod 777 var"_""
 .w "      </i>"_$c(13,10)
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
