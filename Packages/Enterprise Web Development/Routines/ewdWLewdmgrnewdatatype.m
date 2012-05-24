 ;GT.M version of page newDataType (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="initDataTypeDetails^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="newDataType"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("newDataType")=$$setNextPageToken^%zewdGTMRuntime("newDataType")
 s formInfo="cancel|button`dataType|text`dataTypeNotes|textarea`ewd_pressed|hidden`inputMethod|text`outputMethod|text`tagSubmit|submit`"
 d setMethodAndNextPage^%zewdCompiler20("tagSubmit","saveDataType^%zewdMgrAjax","reloadDataTypes",formInfo,.sessionArray)
 s Error=$$startSession^%zewdPHP("newDataType",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <h5 align=""center"">"_$c(13,10)
 .w "New Data Type Registration Details"_""
 .w "      </h5>"_$c(13,10)
 .w "      <div class=""applicationPanel"" style=""height:320px; width:97%"">"_$c(13,10)
 .w "         <form action='/vista/ewdMgr/newDataType.mgwsi?ewd_token="_$$getSessionValue^%zewdAPI("ewd_token",sessid)_"' method=""post"" name=""ewdForm1"">"_$c(13,10)
 .w "            <table border=""0"" class=""propsTable"" style=""table-layout:fixed"" width=""100%"">"_$c(13,10)
 .w "               <tr>"_$c(13,10)
 .w "                  <td class=""configRow"" width=""20%"">"_$c(13,10)
 .w "Data Type Name:"_""
 .w "                  </td>"_$c(13,10)
 .w "                  <td class=""configRow"">"_$c(13,10)
 .s idList("dataType")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                     <input id=""dataType"" name=""dataType"" size=""40"" type=""text"" value='"_$$getSessionValue^%zewdAPI("dataType",sessid)_"' />"_$c(13,10)
 .w "                  </td>"_$c(13,10)
 .w "               </tr>"_$c(13,10)
 .w "               <tr>"_$c(13,10)
 .w "                  <td class=""configRow"" width=""20%"">"_$c(13,10)
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'dt_input','420px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Input Method:"_""
 .w "                  </td>"_$c(13,10)
 .w "                  <td class=""configRow"">"_$c(13,10)
 .s idList("inputMethod")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                     <input id=""inputMethod"" name=""inputMethod"" size=""40"" type=""text"" value='"_$$getSessionValue^%zewdAPI("inputMethod",sessid)_"' />"_$c(13,10)
 .w "                  </td>"_$c(13,10)
 .w "               </tr>"_$c(13,10)
 .w "               <tr>"_$c(13,10)
 .w "                  <td class=""configRow"" width=""20%"">"_$c(13,10)
 .w "                     <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'dt_output','420px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Output Method:"_""
 .w "                  </td>"_$c(13,10)
 .w "                  <td class=""configRow"">"_$c(13,10)
 .s idList("outputMethod")=""
 .d mergeArrayToSession^%zewdAPI(.idList,"ewd_idList",sessid)
 .w "                     <input id=""outputMethod"" name=""outputMethod"" size=""40"" type=""text"" value='"_$$getSessionValue^%zewdAPI("outputMethod",sessid)_"' />"_$c(13,10)
 .w "                  </td>"_$c(13,10)
 .w "               </tr>"_$c(13,10)
 .w "               <tr>"_$c(13,10)
 .w "                  <td class=""configRow"" width=""20%"">"_$c(13,10)
 .w "Notes:"_""
 .w "                  </td>"_$c(13,10)
 .w "                  <td class=""configRow"">"_$c(13,10)
 .w "                     <textarea cols=""40"" id=""dataTypeNotes"" name=""dataTypeNotes"" rows=""8"">"_$c(13,10)
 .d displayTextArea^%zewdAPI("dataTypeNotes")
 .w "</textarea>"_$c(13,10)
 .w "                  </td>"_$c(13,10)
 .w "               </tr>"_$c(13,10)
 .w "               <tr>"_$c(13,10)
 .w "                  <td colspan=""2"">"_$c(13,10)
 .w "                     <input class=""actionButton"" id=""tagSubmit"" name=""tagSubmit"" onClick=""this.form.ewd_action.value=this.name ; this.form.ewd_pressed.value=this.name ; EWD.ajax.submit(this.name,this.form,'reloadDataTypes','/vista/ewdMgr/newDataType.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("newDataType")_"&ewd_urlNo=newDataType1','customTagsNullid','') ;"" type=""button"" value=""Save"" />"_$c(13,10)
 .w "                     <input class=""actionButton"" id=""cancel"" name=""cancel"" onclick=""document.getElementById('listingPanel').innerHTML = ''"" type=""button"" value=""Cancel"" />"_$c(13,10)
 .w "                  </td>"_$c(13,10)
 .w "               </tr>"_$c(13,10)
 .w "            </table>"_$c(13,10)
 .w "            <input name=""ewd_action"" type=""hidden"" value="""" />"_$c(13,10)
 .w "            <input name=""ewd_pressed"" type=""hidden"" value="""" />"_$c(13,10)
 .w "         </form>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""alertPanel"">"_$c(13,10)
 .w "Data Type details saved"_""
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""dt_input"">"_$c(13,10)
 .w "Specify the input/decode function name here, without any input parameters, eg:"_""
 .w "         <p>"_$c(13,10)
 .w "            <i>"_$c(13,10)
 .w "$$decodeFunction^myRoutine"_""
 .w "            </i>"_$c(13,10)
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "The input/decode function is used to convert the raw value (ie as extracted from your database)    to its display format, for presentation within the browser page. Its structure should be of the form:"_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "            <i>"_$c(13,10)
 .w "decodedValue=$$decodeFunction^myRoutine(rawValue,sessid))"_""
 .w "            </i>"_$c(13,10)
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "For example:"_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "decodeDate(rawDate,sessid)"_""
 .w "            <br />"_$c(13,10)
 .w "QUIT $zd(rawDate,2)"_""
 .w "         </p>"_$c(13,10)
 .w "      </div>"_$c(13,10)
 .w "      <div class=""alertPanelOff"" id=""dt_output"">"_$c(13,10)
 .w "Specify the output/encode function name here, without any input parameters, eg:"_""
 .w "         <p>"_$c(13,10)
 .w "            <i>"_$c(13,10)
 .w "$$encodeFunction^myRoutine"_""
 .w "            </i>"_$c(13,10)
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "The output/encode function is used to validate and then convert the display value (ie as sent from the browser)    to its raw format, for storage in your database.  Its structure should be of the form:"_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "            <i>"_$c(13,10)
 .w "encodedValue=$$encodeFunction^myRoutine(displayValue,.errorMessage,sessid)"_""
 .w "            </i>"_$c(13,10)
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "Any validation error is returned by reference, eg:"_""
 .w "         </p>"_$c(13,10)
 .w "         <p>"_$c(13,10)
 .w "encodeDate(textDate,error,sessid)"_""
 .w "            <br />"_$c(13,10)
 .w "n dh"_""
 .w "            <br />"_$c(13,10)
 .w "s error="""""_""
 .w "            <br />"_$c(13,10)
 .w "s $zt=""encodeDateError"""_""
 .w "            <br />"_$c(13,10)
 .w "s dh=$zdh(textDate,2)"_""
 .w "            <br />"_$c(13,10)
 .w "i $g(dh)="""" s error=”Invalid Date” QUIT textDate"_""
 .w "            <br />"_$c(13,10)
 .w "QUIT $g(dh)"_""
 .w "            <br />"_$c(13,10)
 .w ";"_""
 .w "            <br />"_$c(13,10)
 .w "encodeDateError ;"_""
 .w "            <br />"_$c(13,10)
 .w "s error=""Invalid Date"""_""
 .w "            <br />"_$c(13,10)
 .w "s $zt="""""_""
 .w "            <br />"_$c(13,10)
 .w "QUIT textDate"_""
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
