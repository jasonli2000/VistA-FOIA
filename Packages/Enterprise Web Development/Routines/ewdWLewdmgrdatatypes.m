 ;GT.M version of page dataTypes (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getDataTypeList^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="dataTypes"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("deleteDataType")=$$setNextPageToken^%zewdGTMRuntime("deleteDataType")
 s tokens("editDataType")=$$setNextPageToken^%zewdGTMRuntime("editDataType")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("newdataType")=$$setNextPageToken^%zewdGTMRuntime("newdataType")
 s tokens("showDataTypeNotes")=$$setNextPageToken^%zewdGTMRuntime("showDataTypeNotes")
 s Error=$$startSession^%zewdPHP("dataTypes",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "      <span class=""propsText"">"_$c(13,10)
 .s path="/"
 .w "         <table border=""0"" style=""table-layout:fixed"" width=""99%"">"_$c(13,10)
 .w "            <tr>"_$c(13,10)
 .w "               <td width=""46%"">"_$c(13,10)
 .w "                  <div class=""selectorPanel"" style=""width:99%; height:auto"">"_$c(13,10)
 .w "                     <h5 align=""center"">"_$c(13,10)
 .w "                        <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'dt_help','240px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Registered Data Types"_""
 .w "                     </h5>"_$c(13,10)
 .w "                     <div class=""applicationPanel"" style=""left:-5px; height:320px; overflow:scroll"">"_$c(13,10)
 .w "                        <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td align=""left"" class=""configRow"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td class=""configRow"" width=""47%"">"_$c(13,10)
 .w "                                 <input class=""actionButton"" id=""new"" name=""new"" onclick=""MGW.page.newDataType()"" type=""button"" value=""Register New.."" />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .if ($$getSessionValue^%zewdAPI("hasDataTypes",sessid)'="0") d
 ..s name=""
 ..i name?1N.N s name=name-1
 ..i name?1AP.ANP d
 ... s p1=$e(name,1,$l(name)-1)
 ... s p2=$e(name,$l(name))
 ... s p2=$c($a(p2)-1)
 ... s name=p1_p2
 ..s nul=""
 ..s endValue88=""
 ..i endValue88?1N.N s endValue88=endValue88+1
 ..f  q:'(($o(^%zewdSession("session",sessid,"dataTypeList",name))'=endValue88)&($o(^%zewdSession("session",sessid,"dataTypeList",name))'=nul))  d
 ...s name=$o(^%zewdSession("session",sessid,"dataTypeList",name))
 ...s dummy=$g(^%zewdSession("session",sessid,"dataTypeList",name))
 ...w "                                 <tr>"_$c(13,10)
 ...w "                                    <td align=""left"" class=""configRow"">"_$c(13,10)
 ...w "                                       <img onmouseover=""MGW.page.displayNotes('"_name_"')"" src="""_path_"icn_help_blue.gif"" />"_$c(13,10)
 ...w "&nbsp;"_name
 ...w "                                    </td>"_$c(13,10)
 ...w "                                    <td class=""configRow"" width=""47%"">"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""list"_name_""" name=""list"_name_""" onclick=""MGW.page.editDataType('"_name_"')"" type=""button"" value=""Edit"" />"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""del"_name_""" name=""del"_name_""" onclick=""MGW.page.deleteDataType('"_name_"')"" type=""button"" value=""Delete"" />"_$c(13,10)
 ...w "                                    </td>"_$c(13,10)
 ...w "                                 </tr>"_$c(13,10)
 ...
 ..
 .w "                        </table>"_$c(13,10)
 .w "                     </div>"_$c(13,10)
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "               <td id=""listingColumn"" style=""visibility:hidden; height:auto"">"_$c(13,10)
 .w "                  <div class=""selectorPanel"" id=""listingPanel"" style=""width:99%; height:99%"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                  </div>"_$c(13,10)
 .w "               </td>"_$c(13,10)
 .w "            </tr>"_$c(13,10)
 .w "         </table>"_$c(13,10)
 .w "         <div id=""customTagsNullid"">"_$c(13,10)
 .w "</div>"_$c(13,10)
 .w "         <div class=""alertPanelOff"" id=""dt_help"">"_$c(13,10)
 .w "Data Types allow you to specify automatic encoding, decoding and field validation in text form fields, eg:"_""
 .w "            <p>"_$c(13,10)
 .w "&lt;input type=""text"" name=""endDate"" value=""*"" dataType=""myDateType""&gt;"_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "An EWD Data Type is defined by two functions:"_""
 .w "            </p>"_$c(13,10)
 .w "            <ul>"_$c(13,10)
 .w "               <li>"_$c(13,10)
 .w "The input/decode function is used to convert the raw value (ie as extracted from your database)    to its display format, for presentation within the browser page;"_""
 .w "               </li>"_$c(13,10)
 .w "               <li>"_$c(13,10)
 .w "The output/encode function is used to convert the display value (ie as sent from the browser)    to its raw format, for storage in your database."_""
 .w "               </li>"_$c(13,10)
 .w "            </ul>"_$c(13,10)
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
 w "  MGW.page.editDataType = function(name) {    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;    var nvp=""dataType="" + name ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/editDataType.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("editDataType")_"&ewd_urlNo=dataTypes1&' + nvp,""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.deleteDataType = function(name) {"_$c(13,10)
 w "    var ok=confirm(""Are you sure you want to delete the data type: "" + name + ""?"") ;"_$c(13,10)
 w "    if (ok) {"_$c(13,10)
 w "      var nvp=""dataType="" + name ;"_$c(13,10)
 w "      EWD.ajax.makeRequest('/vista/ewdMgr/deleteDataType.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("deleteDataType")_"&ewd_urlNo=dataTypes2&' + nvp,""customTagsNullid"",'get','','') ;"_$c(13,10)
 w "    }"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.newDataType = function() {"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/newdataType.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("newdataType")_"&ewd_urlNo=dataTypes3',""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.displayNotes = function(name) {"_$c(13,10)
 w "    var nvp=""dataType="" + name ;"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/showDataTypeNotes.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("showDataTypeNotes")_"&ewd_urlNo=dataTypes4&' + nvp,""listingPanel"",'get','','')    "_$c(13,10)
 w "  } ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
