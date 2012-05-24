 ;GT.M version of page customTags (ewdMgr application)
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
 s sessionArray("ewd_prePageScript")="getCustomTagList^%zewdMgrAjax"
 s sessionArray("ewd_default_timeout")="3600"
 s sessionArray("ewd_persistRequest")="true"
 s sessionArray("ewd_pageTitle")=""
 s sessionArray("ewd_errorPage")="ewdError"
 s sessionArray("ewd_templatePrePageScript")=""
 s sessionArray("ewd_onErrorScript")=""
 s sessionArray("ewd_appName")="ewdMgr"
 s sessionArray("ewd_pageName")="customTags"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("deleteCustomTag")=$$setNextPageToken^%zewdGTMRuntime("deleteCustomTag")
 s tokens("editCustomTag")=$$setNextPageToken^%zewdGTMRuntime("editCustomTag")
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s tokens("exportCustomTag")=$$setNextPageToken^%zewdGTMRuntime("exportCustomTag")
 s tokens("importCustomTag")=$$setNextPageToken^%zewdGTMRuntime("importCustomTag")
 s tokens("newCustomTag")=$$setNextPageToken^%zewdGTMRuntime("newCustomTag")
 s tokens("showCustomTagNotes")=$$setNextPageToken^%zewdGTMRuntime("showCustomTagNotes")
 s Error=$$startSession^%zewdPHP("customTags",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "                        <img onmouseout=""MGW.page.helpOff()"" onmouseover=""MGW.page.help(this,'ct_doc','500px')"" src=""/vista/resources/icn_help_blue.gif"" />"_$c(13,10)
 .w "Registered Custom Tags"_""
 .w "                     </h5>"_$c(13,10)
 .w "                     <div class=""applicationPanel"" style=""left:-5px; height:320px; overflow:scroll"">"_$c(13,10)
 .w "                        <table border=""0"" class=""propsText"" width=""100%"">"_$c(13,10)
 .w "                           <tr>"_$c(13,10)
 .w "                              <td align=""left"" class=""configRow"">"_$c(13,10)
 .w "&nbsp;"_""
 .w "                              </td>"_$c(13,10)
 .w "                              <td class=""configRow"" width=""47%"">"_$c(13,10)
 .w "                                 <input class=""actionButton"" id=""new"" name=""new"" onclick=""MGW.page.newCustomTag()"" type=""button"" value=""Register New.."" />"_$c(13,10)
 .w "                              </td>"_$c(13,10)
 .w "                           </tr>"_$c(13,10)
 .if ($$getSessionValue^%zewdAPI("hasCustomTags",sessid)'="0") d
 ..s name=""
 ..i name?1N.N s name=name-1
 ..i name?1AP.ANP d
 ... s p1=$e(name,1,$l(name)-1)
 ... s p2=$e(name,$l(name))
 ... s p2=$c($a(p2)-1)
 ... s name=p1_p2
 ..s nul=""
 ..s endValue92=""
 ..i endValue92?1N.N s endValue92=endValue92+1
 ..f  q:'(($o(^%zewdSession("session",sessid,"customTagList",name))'=endValue92)&($o(^%zewdSession("session",sessid,"customTagList",name))'=nul))  d
 ...s name=$o(^%zewdSession("session",sessid,"customTagList",name))
 ...s dummy=$g(^%zewdSession("session",sessid,"customTagList",name))
 ...w "                                 <tr>"_$c(13,10)
 ...w "                                    <td align=""left"" class=""configRow"">"_$c(13,10)
 ...w "                                       <img onmouseover=""MGW.page.displayNotes('"_name_"')"" src="""_path_"icn_help_blue.gif"" />"_$c(13,10)
 ...w "&nbsp;"_name
 ...w "                                    </td>"_$c(13,10)
 ...w "                                    <td class=""configRow"" width=""47%"">"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""list"_name_""" name=""list"_name_""" onclick=""MGW.page.displayCustomTag('"_name_"')"" type=""button"" value=""Edit"" />"_$c(13,10)
 ...w "                                       <input class=""actionButton"" id=""del"_name_""" name=""del"_name_""" onclick=""MGW.page.deleteCustomTag('"_name_"')"" type=""button"" value=""Delete"" />"_$c(13,10)
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
 .w "         <div class=""alertPanelOff"" id=""ct_doc"">"_$c(13,10)
 .w "Custom Tags are an extremely powerful feature of EWD that allow you extend its capabilities by encapsulating functionality of any degree of     complexity into a single XML tag (or sometimes a group of related, interacting XML tags).  You have complete control     over the naming and structure of your custom tags, and complete control over how EWD's compiler transforms your custom     tags into the final markup and/or Javascript."_""
 .w "            <p>"_$c(13,10)
 .w "When a Custom Tag is registered, EWD's compiler will add it to the list of tags it searches for.  On locating an instance,      EWD will pass control to the associated"_""
 .w "               <i>"_$c(13,10)
 .w "Tag Processor Method"_""
 .w "               </i>"_$c(13,10)
 .w ".  This method is given complete access to the XML DOM      that represents the EWD page, and the tag processor manipulates and modifies the page DOM using EWD's DOM API methods."_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "Your custom tag processor can add other custom tags (either built-in ones, or others that you or others have created) to      the page DOM, so you can build complex custom tags from other, simpler ones, ultimately relying on EWD's built-in primitive custom tags      that will take care of any technology-specific in-page logic.  Provided you avoid self referencing loops, custom tags can be      layered to any depth you like."_""
 .w "            </p>"_$c(13,10)
 .w "            <p>"_$c(13,10)
 .w "By harnessing EWD's custom tags you can provide your page developers with complex gadgets and widgets that they can     simply drop into their pages as XML tags and that can interface with your back-end database via EWD's Session data structures."_""
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
 w " } else {EWD.page.setTitle('enterprise web developer') ; }"_""
 w "   </span>"_$c(13,10)
 w "   <pre id=""ewdscript"" style=""visibility : hidden"">"_$c(13,10)
 w "  MGW.page.displayCustomTag = function(tagName) {    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    var nvp=""tagName="" + tagName ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/editCustomTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("editCustomTag")_"&ewd_urlNo=customTags1&' + nvp,""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.deleteCustomTag = function(tagName) {"_$c(13,10)
 w "    var ok=confirm(""Are you sure you want to delete the custom tag: "" + tagName + ""?"") ;"_$c(13,10)
 w "    if (ok) {"_$c(13,10)
 w "      var nvp=""tagName="" + tagName ;"_$c(13,10)
 w "      EWD.ajax.makeRequest('/vista/ewdMgr/deleteCustomTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("deleteCustomTag")_"&ewd_urlNo=customTags2&' + nvp,""customTagsNullid"",'get','','') ;"_$c(13,10)
 w "    }"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.exportCustomTag = function(tagName) {"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    var nvp=""tagName="" + tagName ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/exportCustomTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("exportCustomTag")_"&ewd_urlNo=customTags3&' + nvp,""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.newCustomTag = function() {"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/newCustomTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("newCustomTag")_"&ewd_urlNo=customTags4',""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.importCustomTag = function() {"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/importCustomTag.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("importCustomTag")_"&ewd_urlNo=customTags5',""listingPanel"",'get','','') ;"_$c(13,10)
 w "  };"_$c(13,10)
 w "  MGW.page.displayNotes = function(tagName) {"_$c(13,10)
 w "    var nvp=""tagName="" + tagName ;"_$c(13,10)
 w "    document.getElementById(""listingColumn"").style.visibility = ""visible"" ;"_$c(13,10)
 w "    EWD.ajax.makeRequest('/vista/ewdMgr/showCustomTagNotes.mgwsi?ewd_token="_$g(^%zewdSession("session",sessid,"ewd_token"))_"&n="_tokens("showCustomTagNotes")_"&ewd_urlNo=customTags6&' + nvp,""listingPanel"",'get','','')    "_$c(13,10)
 w "  } ;"_$c(13,10)
 w ""_""
 w "   </pre>"_$c(13,10)
 w "</span>"_$c(13,10)
 QUIT
