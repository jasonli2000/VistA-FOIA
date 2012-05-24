 ;GT.M version of page vaConfigIP (ewdMgr application)
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
 s sessionArray("ewd_pageName")="vaConfigIP"
 s sessionArray("ewd_translationMode")="0"
 s sessionArray("ewd_technology")="gtm"
 s sessionArray("ewd_pageType")="ajax"
 s tokens("ewdAjaxError")=$$setNextPageToken^%zewdGTMRuntime("ewdAjaxError")
 s Error=$$startSession^%zewdPHP("vaConfigIP",.%KEY,.%CGIEVAR,.sessionArray,.filesArray)
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
 .w "Determining the IP address of the EWD Virtual Appliance"_""
 .w "      </h3>"_$c(13,10)
 .w "When you boot the EWD Virtual Appliance, provided Linux does not encounter any networking relating problems,  you will see a panel appear at the end of the boot sequence dialogue that will tell you  the IP address that has been allocated."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "You can also determine the allocated IP address at any other time by connecting to the Virtual Appliance using an SSH client (eg"_""
 .w "      <i>"_$c(13,10)
 .w "puTTY"_""
 .w "      </i>"_$c(13,10)
 .w "),   logging in and typing"_""
 .w "      <i>"_$c(13,10)
 .w "ifconfig"_""
 .w "      </i>"_$c(13,10)
 .w ".  Look for the"_""
 .w "      <i>"_$c(13,10)
 .w "inet addr:"_""
 .w "      </i>"_$c(13,10)
 .w "field in the following two lines:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <pre>"_$c(13,10)
 .w "eth0      Link encap:Ethernet  HWaddr 00:0C:29:A4:E9:E9"_""
 .w "         <br />"_$c(13,10)
 .w "inet addr:192.168.1.21  Bcast:192.168.1.255  Mask:255.255.255.0"_""
 .w "         <br />"_$c(13,10)
 .w "      </pre>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "So in the example above, the IP address is 192.168.1.21"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Alternatively, from within GT.M you can type:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "GTM&gt;w $$getIP^%zewdGTM()"_""
 .w "         <br />"_$c(13,10)
 .w "192.168.1.21"_""
 .w "         <br />"_$c(13,10)
 .w "GTM&gt;"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <h3>"_$c(13,10)
 .w "Changing the IP address of the Virtual Appliance"_""
 .w "      </h3>"_$c(13,10)
 .w "For convenience, to get you started, the Virtual Appliance is initially configured to acquire an IP address dynamically from your DHCP server.  In most situations you will want to fix its IP address.  Do this as follows:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Log in as"_""
 .w "      <i>"_$c(13,10)
 .w "root"_""
 .w "      </i>"_$c(13,10)
 .w "."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "cd /etc/network"_""
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Now edit the"_""
 .w "      <i>"_$c(13,10)
 .w "interfaces"_""
 .w "      </i>"_$c(13,10)
 .w "file, eg:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "pico interfaces"_""
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Find the lines:"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "auto eth0"_""
 .w "         <br />"_$c(13,10)
 .w "iface eth0 inet dhcp"_""
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "and change them to the following, save the file and exit"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "# The primary network interface"_""
 .w "         <br />"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "auto eth0"_""
 .w "         <br />"_$c(13,10)
 .w "iface eth0 inet static"_""
 .w "         <br />"_$c(13,10)
 .w "address 192.168.1.21"_""
 .w "         <br />"_$c(13,10)
 .w "netmask 255.255.255.0"_""
 .w "         <br />"_$c(13,10)
 .w "gateway 192.168.1.2"_""
 .w "         <br />"_$c(13,10)
 .w "broadcast 192.168.1.255"_""
 .w "         <br />"_$c(13,10)
 .w "         <br />"_$c(13,10)
 .w "      </i>"_$c(13,10)
 .w "[change the addresses according to your requirements]"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "Now you need to restart your network services using the following command"_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <i>"_$c(13,10)
 .w "/etc/init.d/networking restart"_""
 .w "      </i>"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
 .w "You can, of course, define a domain name for your EWD Virtual Appliance by editing the"_""
 .w "      <i>"_$c(13,10)
 .w "/etc/hosts"_""
 .w "      </i>"_$c(13,10)
 .w "file.  See"_""
 .w "      <a href=""http://www.howtoforge.com/perfect_setup_ubuntu_6.06_p3"">"_$c(13,10)
 .w "http://www.howtoforge.com/perfect_setup_ubuntu_6.06_p3"_""
 .w "      </a>"_$c(13,10)
 .w "for further details."_""
 .w "      <br />"_$c(13,10)
 .w "      <br />"_$c(13,10)
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
