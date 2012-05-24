ExtJS ; Ext-JS tag processors
 ;
 ; ----------------------------------------------------------------------------
 ; | ExtJS Custom Tags for EWD FOSS/GT.M                                      |
 ; |                                                                          |
 ; | This program is free software: you can redistribute it and/or modify     |
 ; | it under the terms of the GNU Affero General Public License as           |
 ; | published by the Free Software Foundation, either version 3 of the       |
 ; | License, or (at your option) any later version.                          |
 ; |                                                                          |
 ; | This program is distributed in the hope that it will be useful,          |
 ; | but WITHOUT ANY WARRANTY; without even the implied warranty of           |
 ; | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
 ; | GNU Affero General Public License for more details.                      |
 ; |                                                                          |
 ; | You should have received a copy of the GNU Affero General Public License |
 ; | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
 ; ----------------------------------------------------------------------------
 ;
 QUIT
 ;
 ;
extConfig(nodeOID,attrValues,docOID,technology)
 ;
 ; <ext:config path="/ext-2.0.1" debug="true"/>
 ;
 ;    <script type="text/javascript" src="/ext-2.0.1/adapter/ext/ext-base.js"></script>
 ;    <script type="text/javascript" src="/ext-2.0.1/ext-all-debug.js"></script>
 ;    <link rel="stylesheet" type="text/css" href="/ext-2.0.1/resources/css/ext-all.css">
 ;
 n attr,attrs,biURL,cr,dtOID,fileName,filePath,headOID,io,js,jsText
 n line,lineNo,path,scriptOID,style,x
 ;
 d getAttributeValues^%zewdCustomTags(nodeOID,.attrs)
 ;
 s headOID=$$getTagOID^%zewdDOM("head",docName)
 s style=$$zcvt^%zewdAPI($g(attrs("style")),"l")
 i style="grey"!(style="gray") d
 . s attr("rel")="stylesheet"
 . s attr("type")="text/css"
 . s attr("href")=attrs("path")_"/resources/css/xtheme-gray.css"
 . s scriptOID=$$addElementToDOM^%zewdDOM("link",headOID,,.attr,,1)
 s attr("rel")="stylesheet"
 s attr("type")="text/css"
 s attr("href")=attrs("path")_"/resources/css/ext-all.css"
 s scriptOID=$$addElementToDOM^%zewdDOM("link",headOID,,.attr,,1)
 s js="/ext-all"
 i $$zcvt^%zewdAPI($g(attrs("debug")),"l")="true" s js=js_"-debug"
 s js=js_".js"
 s attr("type")="text/javascript"
 s attr("src")=attrs("path")_js
 s scriptOID=$$addElementToDOM^%zewdDOM("script",headOID,,.attr,,1)
 s attr("type")="text/javascript"
 s attr("src")=attrs("path")_"/adapter/ext/ext-base.js"
 s scriptOID=$$addElementToDOM^%zewdDOM("script",headOID,,.attr,,1)
 s path=$g(^zewd("config","jsScriptPath","gtm","path"))
 i $e(path,$l(path))'="/" s path=path_"/"
 s path=path_"ExtScripts.js"
 s attr("src")=path
 s attr("type")="text/javascript"
 s scriptOID=$$addElementToDOM^%zewdDOM("script",headOID,,.attr,,1)
 ;
 s cr=$c(13,10)
 s attr("language")="javascript"
 s attr("id")="extjs"
 s jsText=""
 s biURL=$g(attrs("blankImageURL"))
 i biURL="" s biURL=attrs("path")_"/resources/images/default/s.gif"
 s jsText=jsText_"Ext.BLANK_IMAGE_URL='"_biURL_"';"_cr
 s jsText=jsText_"Ext.onReady(function() {"_cr
 s jsText=jsText_"/*ext*/"_cr
 s jsText=jsText_"/*ext*/"_cr
 s jsText=jsText_"});"_cr
 s jsText=jsText_"EWD.ext.loadWindowFragment = function(fragmentName,targetId,dataStoreName,treeValue,currentPageName,nvp) {"_cr
 ;s jsText=jsText_"  var targetId = id + 'Content' ;"_cr
    s jsText=jsText_"  if (!dataStoreName) dataStoreName='';"_cr
    s jsText=jsText_"  if (!treeValue) treeValue='';"_cr
 s jsText=jsText_"  if (document.getElementById(targetId).innerHTML=='Please wait...'){"_cr
 s jsText=jsText_"  if (typeof(nvp)!='undefined') {"_cr
 s jsText=jsText_"    if (nvp != '') nvp = nvp + '&' ;"_cr
 s jsText=jsText_"  }"_cr
 s jsText=jsText_"  else {"_cr
 s jsText=jsText_"    nvp='' ;"_cr
 s jsText=jsText_"  }"_cr
 s jsText=jsText_"  nvp = nvp + 'frag=' + fragmentName + '&ds=' + dataStoreName + '&tv=' + treeValue + '&cp=' + currentPageName ;"_cr
 s jsText=jsText_"  ewd.ajaxRequest(""zextDesktopWindowLoader"",targetId,nvp) ;"_cr
 s jsText=jsText_"  }"_cr
 s jsText=jsText_"  };"_cr
 s scriptOID=$$addElementToDOM^%zewdDOM("script",headOID,,.attr,jsText)
 ;
 s dtOID=$$getTagOID^%zewdDOM("ext:desktop",docName)
 i dtOID'="" d setAttribute^%zewdDOM("path",$g(attrs("path")),dtOID)
 ;
 d removeIntermediateNode^%zewdAPI(nodeOID)
 ;
 s io=$io
 s fileName="zextDesktopWindowLoader"
 s filePath=inputPath_fileName_".ewd"
 i '$$openNewFile^%zewdCompiler(filePath) QUIT
 u filePath
 f lineNo=1:1 s x="s line=$t("_fileName_"+lineNo^ExtJSCode)" x x q:line["***END***"  d
 . w $p(line,";;",2,1000),!
 c filePath
 s files(fileName_".ewd")=""
 ;
 s fileName="ExtScripts.js"
 s filePath=$g(^zewd("config","jsScriptPath","gtm","outputPath"))
 i $e(filePath,$l(filePath))'="/" s filePath=filePath_"/"
 s filePath=filePath_fileName
 i '$$openNewFile^%zewdCompiler(filePath) QUIT
 u filePath
 f lineNo=1:1 s line=$t(EWDext+lineNo^ExtJSCode) q:line["***END***"  d
 . w $p(line,";;",2,1000),!
 c filePath
 ;
 u io
 ;
 QUIT
 ;
updateExtJS(startText,endText,objectList,docOID,preText,postText,insertAtTop,moveFromOnReady)
 ;
 n array,cr,d,dlim,jsText,jsTextArr,newJSText,objectNo
 n p0,p1,p2,p3,scriptOID,textOID,var,varText
 ;
 s cr=$c(13,10)
 s scriptOID=$$getElementById^%zewdDOM("extjs",docOID)
 i scriptOID="" d
 . i 'isAjax q
 . ; use <script language="javascript"> tag as target
 . ; create script tag if necessary
 . n hasText,language,ntags,OIDArray,stop
 . s ntags=$$getTagsByName^%zewdCompiler("script",docName,.OIDArray)
 . s scriptOID="",stop=0
 . f  s scriptOID=$o(OIDArray(scriptOID)) q:scriptOID=""  d  q:stop
 . . s language=$$getAttribute^%zewdDOM("language",scriptOID)
 . . i $$zcvt^%zewdAPI(language,"l")="javascript" s stop=1
 . i scriptOID="" s scriptOID=$$addJavascriptFunction^%zewdAPI(docName,.jsArray)
 . s jsText=$$getElementText^%zewdDOM(scriptOID,.jsTextArr)
 . i $g(preText)'="",jsText[preText q
 . s hasText=1
 . i jsText="" s hasText=0
 . i jsText'["/*ext*/" d
 . . s jsText=jsText_"Ext.onReady(function() {"_cr
 . . s jsText=jsText_"/*ext*/"_cr
 . . s jsText=jsText_"/*ext*/"_cr
 . . s jsText=jsText_"});"_cr
 . . i hasText d
 . . . s textOID=$$modifyElementText^%zewdDOM(scriptOID,jsText)
 . . e  d
 . . . s textOID=$$createTextNode^%zewdDOM(jsText,docOID)
 . . . s textOID=$$appendChild^%zewdDOM(textOID,scriptOID)
 ;
 s newJSText=""
 i $g(startText)'="" s newJSText=startText_cr
 ;
 s objectNo=""
 f  s objectNo=$o(objectList(objectNo)) q:objectNo=""  d
 . s d=objectList(objectNo)
 . s varText=$p(d,"^",1)
 . i varText'="" s varText=varText_" "
 . s array=$p(d,"^",2)
 . s var=$p(d,"^",3)
 . i var'="" s newJSText=newJSText_varText_var_"="
 . s newJSText=newJSText_$$convertToJSON^%zewdAPI(array,1)_";"_cr
 i $g(endText)'="" s newJSText=newJSText_endText_cr
 ;
 s jsText=$$getElementText^%zewdDOM(scriptOID,.jsTextArr)
 s dlim="/*ext*/"
 s p1=$p(jsText,dlim,1)
 s p2=$p(jsText,dlim,2)
 s p3=$p(jsText,dlim,3)
 i $g(moveFromOnReady)=1 d  QUIT textOID
 . s p0=$p(p1,"Ext.onReady",1)
 . s p1="Ext.onReady"_$p(p1,"Ext.onReady",2,200)
 . s jsText=p0_p2_p1_dlim_$c(13,10)_dlim_p3
 . s textOID=$$modifyElementText^%zewdDOM(scriptOID,jsText)
 i newJSText'="" d
 . i $g(insertAtTop)=1 s p2=$c(13,10)_newJSText_p2
 . e  s p2=p2_newJSText
 i $g(preText)'="" d
 . n a1,a2,sig
 . q:jsText[preText
 . s sig="Ext.onReady("
 . s a1=$p(p1,sig,1)
 . s a2=$p(p1,sig,2,200)
 . s p1=a1_preText_sig_a2
 s jsText=p1_dlim_p2_dlim
 i $g(postText)'="" s p3=cr_postText_p3
 s jsText=jsText_p3
 s textOID=$$modifyElementText^%zewdDOM(scriptOID,jsText)
 QUIT textOID
 ;
widget(thisOID,attrValues,docOID,technology)
 ;
 n nodeOID
 ;
 s nodeOID=$$getOuterExtTag(thisOID)
 i $$widget^ExtJS2(nodeOID,docOID)
 QUIT
 ;
getOuterExtTag(nodeOID)
 ;
 n parentOID,stop,tagName,thisOID
 ;
 s thisOID=nodeOID
 s stop=0
 f  d  q:stop
 . s parentOID=$$getParentNode^%zewdDOM(thisOID)
 . s tagName=$$getTagName^%zewdDOM(parentOID)
 . i tagName["ext:" s thisOID=parentOID q
 . s stop=1
 QUIT thisOID
 ;
desktop(nodeOID,attrValues,docOID,technology)
 ;
 ; <ext:desktop>
 ;
 n appObject,attr,attrs,bgImage,bodyOID,divOID,endText,extPath
 n fileName,filePath,fn,funcStr
 n id,io,lib,line,lineNo,mainAttrs,noOfWindows,objectList
 n path,shortcutOID,scriptOID,sOID,textOID,tmpOID,toolbar,toolbarObject
 n varName,widgetAttribs,x,xOID
 ;
 d getAttributeValues^%zewdCustomTags(nodeOID,.mainAttrs)
 ;
 s bgImage=$g(mainAttrs("backgroundimage"))
 i bgImage'="" d
 . n bodyOID
 . s bodyOID=$$getTagOID^%zewdDOM("body",docName)
 . d setAttribute^%zewdDOM("style","background:url("_bgImage_");background-position:bottom right",bodyOID)
 ;
 s sOID=$$getElementById^%zewdDOM("extjs",docOID)
 s tmpOID=$$createElement^%zewdDOM("temp",docOID)
 s tmpOID=$$insertBefore^%zewdDOM(tmpOID,sOID)
 s path=mainAttrs("path")
 s extPath=path
 i $e(path,$l(path))'="/" s path=path_"/"
 s path=path_"desktop/"
 f lib="Module","App","Desktop","TaskBar","StartMenu" d
 f lib="StartMenu","TaskBar","Desktop","App","Module" d
 . s attr("type")="text/javascript"
 . s attr("src")=path_lib_".js"
 . s scriptOID=$$addElementToDOM^%zewdDOM("script",tmpOID,,.attr)
 s attr("rel")="stylesheet"
 s attr("type")="text/css"
 s attr("href")=path_"desktop.css"
 s scriptOID=$$addElementToDOM^%zewdDOM("link",tmpOID,,.attr)
 s attr("type")="text/css"
 s attr("id")="dtStyles"
 s scriptOID=$$addElementToDOM^%zewdDOM("style",tmpOID,,.attr)
 d removeIntermediateNode^%zewdDOM(tmpOID)
 ;
 s bodyOID=$$getTagOID^%zewdDOM("body",docName)
 d setAttribute^%zewdDOM("scroll","no",bodyOID)
 ;
 s attr("id")="x-desktop"
 s divOID=$$addElementToDOM^%zewdDOM("div",nodeOID,,.attr)
 s attr("id")="x-shortcuts"
 s shortcutOID=$$addElementToDOM^%zewdDOM("dl",divOID,,.attr)
 ;
 s attr("id")="ux-taskbar"
 s divOID=$$addElementToDOM^%zewdDOM("div",nodeOID,,.attr)
 s attr("id")="ux-taskbar-start"
 s xOID=$$addElementToDOM^%zewdDOM("div",divOID,,.attr)
 s attr("id")="ux-taskbuttons-panel"
 s xOID=$$addElementToDOM^%zewdDOM("div",divOID,,.attr)
 s attr("class")="x-clear"
 s xOID=$$addElementToDOM^%zewdDOM("div",divOID,,.attr)
 ;
 s noOfWindows=$$getdesktopChildren(nodeOID,docOID,shortcutOID)
 ;
 s fn="return ["
 f i=1:1:noOfWindows d
 . s fn=fn_"new theDesktop.window"_i_"(),"
 s fn=fn_"new theDesktop.adhocModule()];"
 ;s fn=$e(fn,1,$l(fn)-1)_"];"
 s fn="function(){"_fn_"}"
 s app("getModules")="<?= "_fn_" ?>"
 s config("title")=$g(mainAttrs("title"))
 s config("iconCls")=$g(mainAttrs("iconclass"))
 i config("iconCls")="" s config("iconCls")="user"
 s config("toolItems",1,"zobj1","text")="Logout"
 s config("toolItems",1,"zobj1","iconCls")="logout"
 s config("toolItems",1,"zobj1","scope")="<?= this ?>"
 s funcStr="{fn:function(e){document.location.href='ewdLogout.ewd' ;}}"
 s config("toolItems",1,"zobj1","listeners","zobj3","click")="<?= "_funcStr_" ?>"
 s funcStr=$$convertToJSON^%zewdAPI("config",1)
 s funcStr="return "_funcStr_";"
 s funcStr="function(){"_funcStr_"}"
 s app("getStartConfig")="<?= "_funcStr_" ?>"
 s appObject="new Ext.app.App>app"
 s objectList(1)="^appObject^theDesktop"
 s textOID=$$updateExtJS(,,.objectList,docOID,,,1)
 ;
 s endText="var windowIndex = "_noOfWindows_";"_$c(13,10)
 f lineNo=1:1 s line=$t(desktop+lineNo^ExtJSCode) q:line["***END***"  d
 . s endText=endText_$p(line,";;",2,200)_$c(13,10)
 s textOID=$$updateExtJS(,endText,,docOID)
 d removeIntermediateNode^%zewdDOM(nodeOID)
 ;
 q:'$d(files)
 s io=$io
 f fileName="zextDesktopWindowLoader" d
 . s filePath=inputPath_fileName_".ewd"
 . i '$$openNewFile^%zewdCompiler(filePath) QUIT
 . u filePath
 . f lineNo=1:1 s x="s line=$t("_fileName_"+lineNo^ExtJSCode)" x x q:line["***END***"  d
 . . w $p(line,";;",2,1000),!
 . c filePath
 . u io
 . s files(fileName_".ewd")=""
 ;
 s textOID=$$updateExtJS(,,,docOID,,,,1)
 ;
 QUIT
 ;
getdesktopChildren(nodeOID,docOID,shortcutOID)
 ;
 n childNo,childOID,no,OIDArray,tagName
 ;
 d getChildrenInOrder^%zewdDOM(nodeOID,.OIDArray)
 s childNo="",no=0
 f  s childNo=$o(OIDArray(childNo)) q:childNo=""  d
 . s childOID=OIDArray(childNo)
 . s tagName=$$getTagName^%zewdDOM(childOID)
 . i tagName="ext:window" d
 . . s no=no+1
 . . ;d dtWindow(childOID,childNo,docOID,shortcutOID)
 . . d dtWindow(childOID,no,docOID,shortcutOID)
 . . d removeIntermediateNode^%zewdDOM(childOID)
 . . ;s no=no+1
 . i tagName="ext:login" d
 . . d dtLogin(childOID,docOID)
 . . d removeIntermediateNode^%zewdDOM(childOID)
 ;
 QUIT no
 ;
dtLogin(nodeOID,docOID)
 ;
 n action,attr,bodyOID,fileName,filePath,headOID,io,line,lineNo
 n mainAttrs,onload,str,x,xOID
 ;
 s bodyOID=$$getTagOID^%zewdDOM("body",docName)
 s headOID=$$getTagOID^%zewdDOM("head",docName)
 s attr("name")="zextDesktopLoginForm"
 s xOID=$$addElementToDOM^%zewdDOM("ext:allowchildwindow",bodyOID,,.attr)
 s attr("id")="nullId"
 s attr("style")="display:none"
 s xOID=$$addElementToDOM^%zewdDOM("div",bodyOID,,.attr)
 s xOID=$$addElementToDOM^%zewdDOM("ewd:helpPanel",bodyOID)
 ;
 s str="EWD.ext.loadModalWindow = function() {EWD.ext.openWindow({id: 'loginWindow',title: 'Login',height: 110,width: 270,modal:true,closable:false,currentPageName:'"_$p(filename,".ewd",1)_"'},'zextDesktopLoginForm');};"
 s attr("language")="javascript"
 s xOID=$$addElementToDOM^%zewdDOM("script",headOID,,.attr,str)
 ;
 s onload=$$getAttribute^%zewdDOM("onload",bodyOID)
 s onload="EWD.ext.loadModalWindow();"_onload
 d setAttribute^%zewdDOM("onload",onload,bodyOID)
 ;
 d getAttributeValues^%zewdCustomTags(nodeOID,.mainAttrs)
 s action=$g(mainAttrs("action"))
 q:'$d(files)
 s io=$io
 f fileName="zextDesktopLoginForm","zextDesktopDestroyWindow" d
 . s filePath=inputPath_fileName_".ewd"
 . i '$$openNewFile^%zewdCompiler(filePath) QUIT
 . u filePath
 . f lineNo=1:1 s x="s line=$t("_fileName_"+lineNo^ExtJSCode)" x x q:line["***END***"  d
 . . i line["zActionz" d
 . . . s line=$$replace^%zewdAPI(line,"zActionz",action)
 . . w $p(line,";;",2,1000),!
 . c filePath
 . u io
 . s files(fileName_".ewd")=""
 ;
 QUIT
 ;
dtWindow(nodeOID,winNo,docOID,shortcutOID)
 ;
 n actStr,aOID,attr,attrs,css,cssText,cssTextArr,cw,dtOID,endText
 n fn,func,funcStr,hasText,objectList,src
 n styleOID,textOID,widgetAttribs,win,winObject,xOID
 ;
 d getAttributeValues^%zewdCustomTags(nodeOID,.attrs)
 ;
 s winObject="Ext.extend>win"
 s win="<mixed>"
 s win(1)="<?= Ext.app.Module ?>"
 s win(2,"zobj1","id")="ewdwin"_winNo
 s func("text")=$g(attrs("title"))
 s func("iconCls")=$g(attrs("iconclass"))
 s func("handler")="<?= this.createWindow ?>"
 s func("scope")="<?= this ?>"
 s funcStr="this.launcher="_$$convertToJSON^%zewdAPI("func",1)
 s funcStr="function(){"_funcStr_"}"
 s win(2,"zobj1","init")="<?= "_funcStr_" ?>"
 ;
 d getAttribs("Window",.widgetAttribs)
 d setAttribs(.cw,.widgetAttribs,.attrs)
 ;
 s cw("id")="ewdwin"_winNo
 ;s cw("title")=$g(attrs("title"))
 ;s cw("width")=$g(attrs("width"))
 ;s cw("height")=$g(attrs("height"))
 i $g(cw("iconCls"))'="" s cw("iconCls")=$g(attrs("iconclass"))
 i $g(attrs("backgroundcolor"))'="" d
 . s cw("bodyStyle")="background-color:#"_attrs("backgroundcolor")
 s cw("shim")="<?= false ?>"
 s cw("animCollapse")="<?= false ?>"
 s cw("constrainHeader")="<?= true ?>"
 s cw("border")="<?= false ?>"
 ;s cw("html")="&lt;div id='window"_winNo_"'&gt;Please wait...&lt;/div&gt;"
 s cw("html")="<div id='window"_winNo_"'>Please wait...</div>"
 s actStr="fn:function(e){EWD.ext.populateWindow"_winNo_"('window"_winNo_"');}"
 s actStr="{"_actStr_"}"
 s cw("listeners","zobj1","activate")="<?= "_actStr_" ?>"
 s funcStr="win=desktop.createWindow("_$$convertToJSON^%zewdAPI("cw",1)_");"
 s funcStr=funcStr_$c(13,10)_"EWD.ext.desktopWindow"_winNo_"=win;"
 s funcStr="if(!win){"_funcStr_"}"
 s fn="var desktop=this.app.getDesktop();"_$c(13,10)
 s fn=fn_"var win=desktop.getWindow('ewdwin"_winNo_"');"_$c(13,10)
 s fn=fn_funcStr_$c(13,10)
 s fn=fn_"win.show();"
 s fn="function(){"_fn_"}"
 s win(2,"zobj1","createWindow")="<?= "_fn_" ?>"
 ;
 s objectList(1)="^winObject^theDesktop.window"_winNo
 s endText="EWD.ext.populateWindow"_winNo_"=function(targetId){"_$c(13,10)
 s endText=endText_"if (document.getElementById(targetId).innerHTML=='Please wait...'){"_$c(13,10)
 s src=$g(attrs("src"))
 s src=$p(src,".ewd",1)
 s endText=endText_"ewd.ajaxRequest('"_src_"',targetId);"_$c(13,10)
 s endText=endText_"}};"
 s textOID=$$updateExtJS(,endText,.objectList,docOID)
 ;
 QUIT:$g(attrs("showondesktop"))="false"
 ;
 s attr("id")="ewdwin"_winNo_"-shortcut"
 s dtOID=$$addElementToDOM^%zewdDOM("dt",shortcutOID,,.attr)
 s attr("href")="#"
 s aOID=$$addElementToDOM^%zewdDOM("a",dtOID,,.attr)
 s attr("src")=extPath_"/resources/images/default/s.gif"
 s xOID=$$addElementToDOM^%zewdDOM("img",aOID,,.attr)
 s xOID=$$addElementToDOM^%zewdDOM("div",aOID,,,$g(attrs("title")))
 ;
 s styleOID=$$getElementById^%zewdDOM("dtStyles",docOID)
 s hasText=0
 s cssText=$$getElementText^%zewdDOM(styleOID,.cssTextArr)
 i cssText'="" s hasText=1
 s css=cssText_"#ewdwin"_winNo_"-shortcut img {width:48px;height:48px;"
 s css=css_"background-image:url("_$g(attrs("desktopicon"))_");"
 s css=css_"filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"_$g(attrs("desktopicon"))_"', sizingMethod='scale');}"_$c(13,10)
 i hasText d
 . s textOID=$$modifyElementText^%zewdDOM(styleOID,css)
 e  d
 . s textOID=$$createTextNode^%zewdDOM(css,docOID)
 . s textOID=$$appendChild^%zewdDOM(textOID,styleOID)
 ;
 QUIT
 ;
createGridDatastore(array,sessionName,access,sessid)
 s access=$g(access)
 i access="" s access="r"
 i access'="r",access'="rw" s access="r"
 d deleteFromSession^%zewdAPI(sessionName,sessid)
 d mergeArrayToSession^%zewdAPI(.array,sessionName,sessid)
 d allowJSONAccess^%zewdAPI(sessionName,access,sessid)
 QUIT
 ;
createItemSelectorDatastore(array,sessionName,access,sessid)
 n no,storeArray
 s access=$g(access)
 i access="" s access="r"
 i access'="r",access'="rw" s access="r"
 s no=""
 f  s no=$o(array(no)) q:no=""  d
 . s storeArray(no,1)=no
 . s storeArray(no,2)=array(no)
 i '$d(array) s storeArray="[]"
 d deleteFromSession^%zewdAPI(sessionName,sessid)
 d mergeArrayToSession^%zewdAPI(.storeArray,sessionName,sessid)
 d allowJSONAccess^%zewdAPI(sessionName,access,sessid)
 QUIT
 ;
createTreeDatastore(array,sessionName,sessid)
 ;
 n asubscr,cls,currentPage,data,ds,dsubscr,leaf,no,onclickAllLevels,optNo,page
 ;
 s currentPage=$$getSessionValue^%zewdAPI("ewd.pageName",sessid)
 ;d trace^%zewdAPI("** currentPage="_currentPage)
 d deleteFromSession^%zewdAPI(sessionName_"PageMap",sessid)
 s onclickAllLevels=0
 i $g(array)'="" d
 . n directive,i,name,nd,nvp,value
 . s directive=array
 . s nd=$l(directive,"&")
 . f i=1:1:nd d
 . . s nvp=$p(directive,"&",i)
 . . s name=$p(nvp,"=",1)
 . . s value=$p(nvp,"=",2,200)
 . . i $$zcvt^%zewdAPI(name,"l")="onclickalllevels" d
 . . . i value=1 s onclickAllLevels=1
 s optNo="",no=0
 f  s optNo=$o(array(optNo)) q:optNo=""  d
 . s no=no+1
 . s data=$p($g(array(optNo)),$c(1),1)
 . s ds(no,"zobj1","text")=data
 . s ds(no,"zobj1","id")="extTreeData"_no
 . s leaf="false",cls="folder"
 . i $d(array(optNo))=1 d
 . . n allowed,map
 . . s leaf="true",cls=$p(array(optNo),$c(1),3)
 . . s page=$p(array(optNo),$c(1),2)
 . . i page'="" d
 . . . s allowed(currentPage,page)="" d mergeArrayToSession^%zewdAPI(.allowed,"ext_allowPage",sessid)
 . . . s map($$zcvt^%zewdAPI($p(data,$c(1),1),"I","URL"))=page
 . . . d mergeArrayToSession^%zewdAPI(.map,sessionName_"PageMap",sessid)
 . . i cls="" s cls="file"
 . . s click="{click:function(){EWD.ext.treeClickHandler['"_sessionName_"']('extTreeData"_no_"','"_data_"')}}"
 . . s ds(no,"zobj1","listeners")=click
 . ;**************************************
 . e  d
 . . i onclickAllLevels d
 . . . s click="{click:function(){EWD.ext.treeClickHandler['"_sessionName_"']('extTreeData"_no_"','"_data_"')}}"
 . . . s ds(no,"zobj1","listeners")=click
 . ; ***************************************
 . s ds(no,"zobj1","leaf")=leaf
 . s ds(no,"zobj1","cls")=cls
 . s asubscr="array("_optNo_","
 . s dsubscr="ds("_no_",""zobj1"",""children"","
 . d treeDSLevel(asubscr,dsubscr,"extTreeData"_no)
 d deleteFromSession^%zewdAPI(sessionName,sessid)
 d mergeArrayToSession^%zewdAPI(.ds,sessionName,sessid)
 d allowJSONAccess^%zewdAPI(sessionName,"r",sessid)
 QUIT
 ;
treeDSLevel(asubscr,dsubscr,level)
 ;
 n asubscr2,cls,data,dd,dsubscr2,id,leaf,no,optNo,stop,str,x
 ;
 s optNo="",no=0,stop=0
 f  d  q:stop
 . s x="s optNo=$o("_asubscr_"optNo))" x x
 . i optNo="" s stop=1 q
 . s x="s data=$g("_asubscr_"optNo))"
 . x x
 . i data="" s data="Missing Option"
 . s x="s dd=$d("_asubscr_"optNo))" x x
 . s no=no+1
 . s str="s "_dsubscr_no_",""zobj1"","
 . s x=str_"""text"")="""_$p(data,$c(1),1)_"""" x x
 . ;s id=level_"x"_no
 . s id=level_"x"_optNo
 . s x=str_"""id"")="""_id_"""" x x
 . s leaf="false",cls="folder",click=""
 . i dd=1 d
 . . n allowed,map,page
 . . s leaf="true",cls=$p(data,$c(1),3)
 . . i cls="" s cls="file"
 . . s page=$p(data,$c(1),2)
 . . i page'="" d
 . . . s allowed(currentPage,page)=""
 . . . d mergeArrayToSession^%zewdAPI(.allowed,"ext_allowPage",sessid)
 . . . s map($$zcvt^%zewdAPI($p(data,$c(1),1),"I","URL"))=page
 . . . d mergeArrayToSession^%zewdAPI(.map,sessionName_"PageMap",sessid)
 . . s click="{click:function(){EWD.ext.treeClickHandler['"_sessionName_"']('"_id_"','"_$p(data,$c(1),1)_"')}}"
 . s x=str_"""leaf"")="""_leaf_"""" x x
 . s x=str_"""cls"")="""_cls_"""" x x
 . ;****************
 . i onclickAllLevels d
 . . s click="{click:function(){EWD.ext.treeClickHandler['"_sessionName_"']('"_id_"','"_$p(data,$c(1),1)_"')}}"
 . ;****************
 . i click'="" s x=str_"""listeners"")="""_click_"""" x x
 . s asubscr2=asubscr_optNo_","
 . s dsubscr2=dsubscr_no_",""zobj1"",""children"","
 . d treeDSLevel(asubscr2,dsubscr2,id)
 QUIT
 ;
setAttribs(array,widgetAttribs,mainAttrs)
 ;
 n d,name,p1,p2,type,xname
 ;
 s name=""
 f  s name=$o(widgetAttribs(name)) q:name=""  d
 . i $g(mainAttrs(name))="" q
 . s d=widgetAttribs(name)
 . s xname=$p(d,":",1)
 . s type=$p(d,":",2)
 . s p1="",p2=""
 . i type["bool"!(type["ref") s p1="<?= ",p2=" ?>"
 . i type="array" s p1="<?= [",p2="] ?>"
 . i type["function" s p1="<?= "_type_" {",p2="} ?>"
 . s array(xname)=p1_mainAttrs(name)_p2
 QUIT
 ;
getAttribs(widgetName,widgetAttribs)
 ;
 n line,lineNo,x
 ;
 s x="f lineNo=1:1 s line=$t("_widgetName_"+lineNo^ExtJSData) q:line[""***END***""  d addAttrib("""_widgetName_""",line,.widgetAttribs)"
 x x
 QUIT
 ;
addAttrib(widgetName,line,widgetAttribs)
 ;
 n attribName,lcName,type
 ;
 s attribName=$p(line,";;",2)
 s type=$p(attribName,":",2)
 s attribName=$p(attribName,":",1)
 s lcName=$$zcvt^%zewdAPI(attribName,"l")
 s widgetAttribs(lcName)=attribName_":"_type
 QUIT
 ;
writeTextArea(fieldName,sessid)
 n text
 w "<div style=""display:none"" id=""zewdTextarea"_fieldName_""">"
 s text=$$getSessionValue^%zewdAPI(fieldName,sessid)
 i text'="" d
 . w text
 e  d
 . d displayTextArea(fieldName)
 w "&nbsp;"
 w "</div>"_$c(13,10)
 QUIT
 ;
 ;
displayTextArea(fieldName)
 n lineNo,text,lastLineNo
 ;
 s fieldName=$tr(fieldName,".","_")
 d
 . s lastLineNo=$o(^%zewdSession("session",sessid,"ewd_textarea",fieldName,""),-1)
 . s lineNo=0
 . f  s lineNo=$o(^%zewdSession("session",sessid,"ewd_textarea",fieldName,lineNo)) q:lineNo=""  d
 . . k text
 . . s text=^%zewdSession("session",sessid,"ewd_textarea",fieldName,lineNo)
 . . s text=$$replaceAll^%zewdHTMLParser(text,"&#39;","'")
 . . w $$zcvt^%zewdAPI(text,"o","JS")
 . . i lineNo'=lastLineNo w "\r\n"
 QUIT
 ;
updateSession(sessionName,row,column,value)
 ;
 n array,browser,error,oldValue,rou
 ;
 d setSessionValue^%zewdAPI("extGridDatastore",sessionName,sessid)
 d setSessionValue^%zewdAPI("extGridRow",row+1,sessid)
 d setSessionValue^%zewdAPI("extGridColumn",column,sessid)
 s browser=$$getSessionValue^%zewdAPI("ewd.browserType",sessid)
 i browser="ie6"!(browser="ie7") d
 . i value?3A1" "3A1" "1N.E,value["00:00:00" d
 . . ;d trace^%zewdAPI("converting date..")
 . . s value=$$convertToHDate(value,1)
 . . ;d trace^%zewdAPI("ie6: "_value)
 e  d
 . i value?3A1" "3A1" "1N.E,value["00:00:00" d
 . . ;d trace^%zewdAPI("non-IE converting date...")
 . . s value=$$convertToHDate(value,0)
 . . ;d trace^%zewdAPI("others: "_value)
 d setSessionValue^%zewdAPI("extGridValue",value,sessid)
 i $$JSONAccess^%zewdAPI(sessionName,sessid)'="rw" QUIT "EWD.ext.error='Unauthorised access';"
 d mergeArrayFromSession^%zewdAPI(.array,sessionName,sessid)
 s oldValue=$g(array(row+1,column))
 d setSessionValue^%zewdAPI("extGridOriginalValue",oldValue,sessid)
 s array(row+1,column)=value
 d mergeArrayToSession^%zewdAPI(.array,sessionName,sessid)
 s rou=$$getSessionArrayValue^%zewdAPI("ext.GridEditFunc",sessionName,sessid)
 s error=""
 i rou'="" d
 . i rou["class(" d
 . . s rou="s error=##"_rou
 . e  d
 . . s rou="s error=$$"_rou
 . i rou'["(sessid)" s rou=rou_"(sessid)"
 . x rou
 ;
 i error["'" d
 . s error=$$replaceAll^%zewdAPI(error,"'",$c(1))
 . s error=$$replaceAll^%zewdAPI(error,$c(1),"\'")
 i error'="" d
 . s array(row+1,column)=oldValue
 . d mergeArrayToSession^%zewdAPI(.array,sessionName,sessid)
 QUIT "EWD.ext.error='"_error_"';"
 ;
convertToHDate(extjsDate,isIE)
 ;
 n dd,mmm,yyyy
 ;
 s dd=$p(extjsDate," ",3)
 s mmm=$p(extjsDate," ",2)
 i isIE d
 . n np
 . s np=$l(extjsDate," ")
 . s yyyy=$p(extjsDate," ",np)
 e  d
 . s yyyy=$p(extjsDate," ",4)
 s date=dd_" "_mmm_" "_yyyy
 s date=$$encodeDate^%zewdGTM(date)
 QUIT date
 ;
 ;
allowChildWindow(nodeOID,attrValues,docOID,technology)
 ;
 ;  <ext:allowChildWindow name="loginForm" />
 ;
 n allowedString,currentPage,mainAttrs,toPage
 ;
 d getAttributeValues^%zewdCustomTags(nodeOID,.mainAttrs)
 s toPage=$g(mainAttrs("name"))
 s currentPage=$p(filename,".ewd",1)
 s currentPage=$$zcvt^%zewdAPI(currentPage,"l")
 ;
 n appDeclared,arrayDeclared,lastLineNo,line,lineNo
 ;
 s allowedString=" s sessionArray(""ext_allowPage"","""_currentPage_""","
 s lineNo="",lastLineNo=0,arrayDeclared=0,appDeclared=0
 f  s lineNo=$o(phpHeaderArray(1,lineNo)) q:lineNo=""  d
 . s lastLineNo=lineNo
 s lineNo=lastLineNo+1
 s phpHeaderArray(1,lineNo)=allowedString_""""_toPage_""")="""""
 d removeIntermediateNode^%zewdDOM(nodeOID)
 QUIT
 ;
