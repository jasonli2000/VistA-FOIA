 ;GT.M version of page compilePage (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getPageList^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="compilePage"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("compilePageResults")=$$setNextPageToken^%zewdGTMRuntime("compilePageResults")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("listPage")=$$setNextPageToken^%zewdGTMRuntime("listPage")
 s Error=$$startSession^%zewdPHP("compilePage",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .if ($$existsInSession^%zewdAPI("fileList",sessid)) d
 ..w "            <div class=""listPagePanelOff"" id=""listPagePanel"">"_$c(13,10)
 ..w "</div>"_$c(13,10)
 ..w "            <div class=""applicationPanelx"">"_$c(13,10)
 ..w "               <center>"_$c(13,10)
 ..w "                  <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 ..w "                     <tr>"_$c(13,10)
 ..w "                        <td>"_$c(13,10)
 ..w "                           <table border=""0"" width=""100%"">"_$c(13,10)
 ..w "                              <tr>"_$c(13,10)
 ..w "                                 <td align=""center"" class=""listingCol"" width=""35%"">"_$c(13,10)
 ..w "Filename"_""
 ..w "                                 </td>"_$c(13,10)
 ..w "                                 <td align=""center"" class=""listingColTiny"" width=""12%"">"_$c(13,10)
 ..w "Compiled"_""
 ..w "                                    <br />"_$c(13,10)
 ..w "Size (bytes)"_""
 ..w "                                 </td>"_$c(13,10)
 ..w "                                 <td align=""center"" class=""listingCol"" width=""25%"">"_$c(13,10)
 ..w "Last"_""
 ..w "                                    <br />"_$c(13,10)
 ..w "Compiled"_""
 ..w "                                 </td>"_$c(13,10)
 ..w "                                 <td align=""right"" class=""listingCol"" valign=""top"">"_$c(13,10)
 ..w "                                    <input id=""x"" name=""x"" onclick=""MGW.page.clearPanel('section2')"" style=""font-size:10px; font-weight:bold; padding: 0px"" type=""button"" value=""X"" />"_$c(13,10)
 ..w "                                 </td>"_$c(13,10)
 ..w "                              </tr>"_$c(13,10)
 ..w "                           </table>"_$c(13,10)
 ..w "                        </td>"_$c(13,10)
 ..w "                     </tr>"_$c(13,10)
 ..s recNo=""
 ..i recNo?1N.N s recNo=recNo-1
 ..i recNo?1AP.ANP d
 ... s p1=$e(recNo,1,$l(recNo)-1)
 ... s p2=$e(recNo,$l(recNo))
 ... s p2=$c($a(p2)-1)
 ... s recNo=p1_p2
 ..s nul=""
 ..s endValue89=""
 ..i endValue89?1N.N s endValue89=endValue89+1
 ..f  q:'(($o(^%zewdSession("session",sessid,"file",recNo))'=endValue89)&($o(^%zewdSession("session",sessid,"file",recNo))'=nul))  d
 ...s recNo=$o(^%zewdSession("session",sessid,"file",recNo))
 ...s dummy=$g(^%zewdSession("session",sessid,"file",recNo))
 ...s pageName=$$getResultSetValue^%zewdAPI("file",recNo,"name",sessid)
 ...w "                        <tr>"_$c(13,10)
 ...w "                           <td id="""_$$getResultSetValue^%zewdAPI("file",recNo,"name",sessid)_""">"_$c(13,10)
 ...w "                              <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 ...w "                                 <tr>"_$c(13,10)
 ...w "                                    <td class=""listingCol"" width=""35%"">"_$c(13,10)
 ...w $$getResultSetValue^%zewdAPI("file",recNo,"name",sessid)
 ...w "                                    </td>"_$c(13,10)
 ...w "                                    <td align=""right"" class=""listingCol"" width=""12%"">"_$c(13,10)
 ...w $$getResultSetValue^%zewdAPI("file",recNo,"size",sessid)
 ...w "                                    </td>"_$c(13,10)
 ...w "                                    <td align=""center"" class=""listingCol"" width=""25%"">"_$c(13,10)
 ...w $$getResultSetValue^%zewdAPI("file",recNo,"dateModified",sessid)
 ...w "                                    </td>"_$c(13,10)
 ...w "                                    <td class=""listingCol"">"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""recomp"" name=""recomp"" onclick=""MGW.page.compilePage('"_$$getResultSetValue^%zewdAPI("file",recNo,"name",sessid)_"')"" type=""button"" value=""Compile"" />"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""list"" name=""list"" onclick=""MGW.page.listPage('"_$$getResultSetValue^%zewdAPI("file",recNo,"name",sessid)_"')"" type=""button"" value=""List"" />"_$c(13,10)
 ...w "                                    </td>"_$c(13,10)
 ...w "                                 </tr>"_$c(13,10)
 ...w "                              </table>"_$c(13,10)
 ...w "                           </td>"_$c(13,10)
 ...w "                        </tr>"_$c(13,10)
 ...
 ..w "                  </table>"_$c(13,10)
 ..w "               </center>"_$c(13,10)
 ..w "            </div>"_$c(13,10)
 ..
 .else  d
 ..w "            <p>"_$c(13,10)
 ..w "No .ewd design pages found in this path"_""
 ..w "            </p>"_$c(13,10)
 ..
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
 w "  MGW.page.compilePage = function(pageName) {    var technology = EWD.utils.getOption(""frontEndTechnology"") ;    var backend = EWD.utils.getOption(""backEndTechnology"") ;"_$c(13,10)
 w "    var pdb = EWD.utils.getOption(""persistenceDB"") ;"_$c(13,10)
 w "    var format = EWD.utils.getOption(""format"") ;"_$c(13,10)
 w "    var nvp=""pageName="" + pageName + ""&technology="" + technology + ""&backend="" + backend + ""&pdb="" + pdb + ""&format="" + format ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/compilePageResults.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("compilePageResults")_"&ewd_urlNo=compilePage1&' + nvp,pageName,'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.listPage = function(pageName) {"_$c(13,10)
 w "    var nvp=""pageName="" + pageName ;"_$c(13,10)
 w "    document.getElementById('listPagePanel').className = 'listPagePanelOn' ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/listPage.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("listPage")_"&ewd_urlNo=compilePage2&' + nvp,""listPagePanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
