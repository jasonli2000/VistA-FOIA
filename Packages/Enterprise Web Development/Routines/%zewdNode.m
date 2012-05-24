%zewdNode       ; Enterprise Web Developer global access APIs for Node.js
 ;
 ; Product: Enterprise Web Developer (Build 894)
 ; Build Date: Wed, 14 Dec 2011 08:43:22
 ;
 ; ----------------------------------------------------------------------------
 ; | Enterprise Web Developer for GT.M and m_apache                           |
 ; | Copyright (c) 2004-11 M/Gateway Developments Ltd,                        |
 ; | Reigate, Surrey UK.                                                      |
 ; | All rights reserved.                                                     |
 ; |                                                                          |
 ; | http://www.mgateway.com                                                  |
 ; | Email: rtweed@mgateway.com                                               |
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
 ; Thanks to Stephen Chadwick for enhancements and bug fixes
 ;
globalAccessMethod(message) ;
 ;
 n crlf,eor,global,method,requestNo,sor,subscripts,value
 ;
 s crlf=$c(13,10)
 s eor=$c(17,18,19,20,13,10)
 s sor=$c(20,19,18,17)
 ;
 s requestNo=$p(message,$c(1),1)
 w requestNo_$c(20,19,18,17)
 s method=$p(message,$c(1),3)
 ;
 ;r method
 i $g(^zewd("trace"))=1 d trace^%zewdAPI($j_": method="_method)
 i method="get" d
 . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . ;r global,subscripts
 . d get(global,subscripts)
 i method="set" d
 . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . s value=$p(message,$c(1),6)
 . ;r global,subscripts,value
 . d set(global,subscripts,value)
 i method="kill" d
 . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . ;r global,subscripts
 . d kill(global,subscripts)
 i method="getJSON" d
  . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . ;r global,subscripts
 . d getJSON(global,subscripts)
 i method="getSubscripts" d
 . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . s from=$p(message,$c(1),7)
 . s to=$p(message,$c(1),8)
 . ;r global,subscripts,from,to
 . d getSubscripts(global,subscripts,from,to)
 i method="increment" d
 . s global=$p(message,$c(1),4)
 . s subscripts=$p(message,$c(1),5)
 . ;r global,subscripts
 . d increment(global,subscripts)
 i method="halt" d
 . ;d trace^%zewdAPI("process "_$j_" has been instructed to halt now")
 . HALT
 i method="mFunction" d
 . ;
 . n functionName,parameters
 . ;
 . s functionName=$p(message,$c(1),4)
 . s parameters=$p(message,$c(1),5)
 . ;r functionName,parameters
 . d mFunction(functionName,parameters)
 QUIT
 ;
get(global,subscripts)
 ;
 ; error +
 ;
 n data,exists,gloRef,x
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("get global="_$g(global)_"; subscripts = "_$g(subscripts))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 ;
 s x="s exists=$d("_gloRef_")"
 s $zt=$$zt()
 x x
 s $zt=""
 i exists'=1,exists'=11 w sor_"undefined"_crlf_0_crlf_eor QUIT
 s x="s data="_gloRef
 s $zt=$$zt()
 x x
 s $zt=""
 ;
 w sor_crlf_exists_crlf_$$esc(data)_eor
 QUIT
 ;
set(global,subscripts,value)
 ;
 n x
 ;
 ; error + ok
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("set global="_$g(global)_"; subscripts = "_$g(subscripts)_"; value="_$g(value))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 s value=$$unesc($g(value))
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("value unescaped to "_value)
 ;
 s x="s "_gloRef_"="""_value_""""
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("set: "_x)
 s $zt=$$zt()
 x x
 s $zt=""
 w sor_crlf_1_eor
 QUIT
 ;
kill(global,subscripts)
 ;
 ; error +
 ;
 n data,exists,gloRef,x
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("kill global="_$g(global)_"; subscripts = "_$g(subscripts))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 ;
 s x="k "_gloRef
 s $zt=$$zt()
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("kill: x="_x)
 x x
 s $zt=""
 ;
 w sor_crlf_1_eor
 QUIT
 ;
getJSON(global,subscripts)
 ;
 n arr,gloRef,json,x
 ;
 ;  error + json
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("getJSON global="_$g(global)_"; subscripts = "_$g(subscripts))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 ;
 m arr=@gloRef
 ;
 i '$d(arr) w sor_crlf_"{}"_eor
 e  w sor_crlf_$$arrayToJSON("arr")_eor
 QUIT
 ;
getSubscripts(global,subscripts,from,to)
 ;
 ; error + array of subscripts
 ;
 n comma,exists,gloRef,numericEnd,response,stop,subs,x
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("getSubscripts global="_$g(global)_"; subscripts = "_$g(subscripts)_"; from="_$g(from)_"; to="_$g(to))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 s from=$g(from)
 s to=$g(to)
 ;
 s numericEnd=$$numeric(to)
 ;
 i $e(gloRef,$l(gloRef))=")" d
 . s x="s exists=$d("_gloRef_")"
 . s gloRef=$e(gloRef,1,$l(gloRef)-1)_","
 e  d
 . s x="s exists=$d("_gloRef_")"
 . s gloRef=gloRef_"("
 s $zt=$$zt()
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("x="_x)
 x x
 s $zt=""
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("exists="_exists)
 i 'exists!(exists=1)  w sor_crlf_"[]"_eor QUIT
 ;
 s subs=from
 s subs1=subs i subs1["""" s subs1=$$replaceAll^%zewdAPI(subs1,"""","""""")
 i from'="" d
 . s x="s subs1=$o("_gloRef_""""_subs1_"""),-1)"
 . ;d trace^%zewdAPI("1 x="_x)
 . x x
 s x="s subs=$o("_gloRef_""""_subs1_"""))"
 ;d trace^%zewdAPI("4 x="_x)
 ;d trace("xx to="_to)
 x x
 s response="["""_$$esc2(subs)_""""
 ;d trace^%zewdAPI("aa response = "_response)
 ;
 s comma=","
 i subs'="" d
 . s stop=0
 . f  s subs=$o(^(subs)) q:stop  d
 . . i subs="" s stop=1 q
 . . i to'="" d  q:stop
 . . . i numericEnd d
 . . . . ;d trace("numeric: subs="_subs_": to="_to)
 . . . . i $$numeric(subs),subs>to s stop=1
 . . . e  d
 . . . . i subs]to s stop=1
 . . s response=response_comma_""""_$$esc2(subs)_""""
 ;
 s response=response_"]"
 ;
 w sor_crlf_response_eor
 ;
 QUIT
 ;
increment(global,subscripts)
 ;
 ; error + value
 ;
 n data,gloRef,x,value
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("increment global="_$g(global)_"; subscripts = "_$g(subscripts))
 s gloRef=$$checkGlobalRef(global,subscripts)
 i gloRef="" QUIT
 ;
 s x="s value=$increment("_gloRef_")"
 s $zt=$$zt()
 ;d trace^%zewdAPI("increment: x="_x)
 x x
 s $zt=""
 ;
 w sor_crlf_value_eor
 ;d trace^%zewdAPI("increment: sent value="_value)
 QUIT
 ;
mFunction(functionName,parameters)
 ;
 ; functionName, eg: "label^routine" or "##class(x,y).func"
 ; parameters, eg: '"a","b","c"'
 ;
 ; returns: error + value
 ;
 n func,x,value
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("mFunction: functionName="_$g(functionName)_"; parameters = "_$g(parameters))
 s functionName=$g(functionName)
 s parameters=$g(parameters)
 i $e(parameters,1)="[" s parameters=$e(parameters,2,$l(parameters)-1)
 i functionName="" w sor_"Missing Function Name"_crlf_0_crlf_eor QUIT
 i functionName'["^" w sor_"Invalid Function Name: "_functionName_crlf_0_crlf_eor QUIT
 i functionName["^",$e(functionName,1,2)'="$$" s functionName="$$"_functionName
 s x="s value="_functionName_"("_parameters_")"
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("mFunction: x="_x)
 s $zt=$$zt()
 x x
 s $zt=""
 ;
 w sor_crlf_value_eor
 QUIT
 ;
unesc(string)
 s string=$$utfConvert(string)
 i string["\\" s string=$$replaceAll^%zewdAPI(string,"\\",$c(1))
 i string["\""" s string=$$replaceAll^%zewdAPI(string,"\""","""""")
 i string[$c(1) s string=$$replaceAll^%zewdAPI(string,$c(1),"\")
 QUIT string
 ;
zt() ;
 i $zv["GT.M" QUIT "g executeError^%zewdNode"
 QUIT "executeError^%zewdNode"
 ;
executeError
 w sor_"Process "_$j_": Invalid command: "_x_crlf_crlf_crlf_eor
 s $zt=""
 QUIT
 ;
utfConvert(input)
 ; Unescape UTF-8 characters
 i input[$c(195) d
 . n buf,c1,i,no,p
 . s buf=$p(input,$c(195),1)
 . s no=$l(input,$c(195))
 . f i=2:1:no d
 . . s p=$p(input,$c(195),i)
 . . s c1=$e(p,1)
 . . s c1=$c($a(c1)+64)
 . . s buf=buf_c1_$e(p,2,$l(p))
 . s input=buf
 s input=$tr(input,$c(194),"")
 QUIT input
 ;
esc2(string)
 ;
 n c123,i
 ;
 ;d trace^%zewdAPI("string = "_string)
 s string=$$replaceAll^%zewdAPI(string,"\",$c(2))
 s string=$$replaceAll^%zewdAPI(string,"""",$c(3))
 s string=$$replaceAll^%zewdAPI(string,"'",$c(4))
 s string=$$replaceAll^%zewdAPI(string,$c(2),"\\")
 s string=$$replaceAll^%zewdAPI(string,$c(3),"\""")
 s string=$$replaceAll^%zewdAPI(string,$c(4),"'")
 ;d trace^%zewdAPI("** string="_string)
 QUIT string
 ;
esc(string)
 ; Encode UTF-8 characters
 QUIT string
 n a,buff,c,i
 s buff=""
 f i=1:1:$l(string) d
 . s c=$e(string,i)
 . s a=$a(c)
 . i a>160 d
 . . s buff=buff_"\x"_$$hex(a) q
 . . i a<192 d
 . . . ;s buff=buff_$c(194)_c
 . . . s buff=buff_"%C2%"_$$hex(a)_c
 . . e  d
 . . . ;s buff=buff_$c(195)_$c(a-64)
 . . . s buff=buff_"%C3%"_$$hex(a-64)
 . e  d
 . . s buff=buff_c
 QUIT buff
 ;
hex(number)
 n hex,no,str
 s hex=""
 s str="123456789ABCDEF"
 f  d  q:number=0
 . s no=number#16
 . s number=number\16
 . i no s no=$e(str,no)
 . s hex=no_hex
 QUIT hex
 ;
arrayToJSON(name)
 n a,buff,c,json,subscripts
 i '$d(@name) QUIT "[]"
 s json=$$walkArray("",name)
 QUIT json
 ;
 ; Encode UTF-8 characters
 s buff=""
 f i=1:1:$l(json) d
 . s c=$e(json,i)
 . s a=$a(c)
 . i a>160 d
 . . i a<192 d
 . . . s buff=buff_$c(194)_c
 . . e  d
 . . . s buff=buff_$c(195)_$c(a-64)
 . e  d
 . . s buff=buff_c
 QUIT buff
 ;
walkArray(json,name,subscripts)
 ;
 n allNumeric,arrComma,brace,comma,count,cr,dd,i,no,numsub,dblquot,quot
 n ref,sub,subNo,subscripts1,type,valquot,value,xref,zobj
 ;
 s cr=$c(13,10),comma=","
 s (quot,dblquot,valquot)=""""
 s dd=$d(@name)
 i dd=1!(dd=11) d  i dd=1 QUIT json
 . s value=@name
 . i value'[">" q
 . s json=$$walkArray(json,value,.subscripts)
 s ref=name_"("
 s no=$o(subscripts(""),-1)
 i no>0 f i=1:1:no d
 . i subscripts(i)[quot s subscripts(i)=$$replaceAll^%zewdAPI(subscripts(i),quot,quot_quot)
 . i subscripts(i)?."-"1N.N s quot=""
 . s ref=ref_quot_subscripts(i)_quot_","
 . s quot=dblquot
 s ref=ref_"sub)"
 s sub="",numsub=0,subNo=0,count=0
 s allNumeric=1
 f  s sub=$o(@ref) q:sub=""  d  q:'allNumeric
 . i sub'?1N.N s allNumeric=0
 . s count=count+1
 . i sub'=count s allNumeric=0
 ;i allNumeric,count=1 s allNumeric=0
 s allNumeric=0
 i allNumeric d
 . s json=json_"["
 e  d
 . s json=json_"{"
 s sub=""
 f  s sub=$o(@ref) q:sub=""  d
 . s subscripts(no+1)=sub
 . s subNo=subNo+1
 . s dd=$d(@ref)
 . i dd=1 d
 . . s value=@ref
 . . ;i value["\" s value=$$replaceAll^%zewdAPI(value,"\","\\")
 . . s value=$$removeControlChars(value)
 . . i 'allNumeric d
 . . . ;i sub["\",sub'["\\",sub'["\"""  s sub=$$replaceAll^%zewdAPI(sub,"\","\\")
 . . . i sub["\" s sub=$$replaceAll^%zewdAPI(sub,"\","\\")
 . . . s sub=$$removeControlChars(sub)
 . . . s json=json_""""_sub_""":"
 . . s type="literal"
 . . i $$numeric(value) s type="numeric"
 . . i value="true"!(value="false") s type="boolean"
 . . i $e(value,1)="{",$e(value,$l(value))="}" s type="variable"
 . . i type="literal" d
 . . . ;i value[quot s value=$$replaceAll^%zewdAPI(value,quot,"\"_quot)
 . . . ;i value["\",value'["\\",value'["\"""  s value=$$replaceAll^%zewdAPI(value,"\","\\")
 . . . i value["\" s value=$$replaceAll^%zewdAPI(value,"\","\\")
 . . . i value[quot s value=$$replaceAll^%zewdAPI(value,quot,"\""")
 . . . s value=valquot_value_valquot
 . . d
 . . . s json=json_value_","
 . k subscripts1
 . m subscripts1=subscripts
 . i dd>9 d
 . . n subx
 . . ;i sub?1N.N d
 . . ;. i subNo=1 d
 . . ;. . s numsub=1
 . . ;. . s json=$e(json,1,$l(json)-1)_"["
 . . ;e  d
 . . ;. s json=json_""""_sub_""":"
 . . ;i sub["\",sub'["\\",sub'["\""" s sub=$$replaceAll^%zewdAPI(sub,"\","\\")
 . . s subx=sub
 . . i subx["\" s subx=$$replaceAll^%zewdAPI(sub,"\","\\")
 . . i subx[quot s subx=$$replaceAll^%zewdAPI(subx,quot,"\""")
 . . s subx=$$removeControlChars(subx)
 . . s json=json_""""_subx_""":"
 . . s json=$$walkArray(json,name,.subscripts1)
 . . d
 . . . s json=json_","
 ;
 s json=$e(json,1,$l(json)-1)
 i allNumeric d
 . s json=json_"]"
 e  d
 . s json=json_"}"
 QUIT json ; exit!
 ;
numeric(value)
 i $e(value,1)=0,$l(value)>1 QUIT 0
 i $e(value,1,2)="-0",$l(value)>2,$e(value,1,3)'="-0." QUIT 0
 i value?1N.N QUIT 1
 i value?1"-"1N.N QUIT 1
 i value?1N.N1"."1N.N QUIT 1
 i value?1"-"1N.N1"."1N.N QUIT 1
 i value?1"."1N.N QUIT 1
 i value?1"-."1N.N QUIT 1
 QUIT 0
 ;
removeControlChars(string)
 n c,i,newString
 s newString=""
 f i=1:1:$l(string) d
 . s c=$e(string,i)
 . i $a(c)<32 s c="~"
 . s newString=newString_c
 QUIT newString
 ;
checkGlobalRef(global,subscripts)
 ;
 n gloRef
 ;
 s subscripts=$$unesc($g(subscripts))
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("subscripts unescaped to "_subscripts)
 s global=$g(global)
 i global="" w sor_"Missing global"_crlf_0_crlf_eor QUIT ""
 i global["^zmwire" w sor_"No access allowed to this global"_crlf_0_crlf_eor QUIT ""
 i subscripts="" QUIT "^"_global
 i subscripts="[]" QUIT "^"_global
 i subscripts="""""" QUIT "^"_global
 s gloRef="^"_global_"("_$e(subscripts,2,$l(subscripts)-1)_")"
 QUIT gloRef
 ;
 ;
 ;  Node.js gateway and WebSockets Support Code
 ;
nodeInit ;
 ;
 n j
 ;
 k ^zewd("stopProcess")
 s j=""
 f  s j=$o(^zewd("nodeProcesses",j)) q:j=""  d
 . zsy "mupip stop "_j
 k ^zewd("nodeProcesses")
 QUIT
 ;
nodeListener ;
 ;
 ; Back-end listener for ewdGTMGateway.js
 ;   this is a queueing-capable gateway and an improvement on the basic
 ;   m_apache gateway substitute
 ;
 n eor,input,isFirstListener,isNode,message,no,noOfMessages,type
 ;
 s isFirstListener=1
 l +^zewd("nodeListener")
 l +^zewd("nodeRunning"):0 e  d
 . s isFirstListener=0
 i isFirstListener d
 . ;d nodeInit
 . k ^zewd("nodeProcesses")
 . ; the nodeRunning lock will tell the serverListener whether or not to halt
 . ; when Node process stops, this lock will be released.
 l -^zewd("nodeListener")
 ;
 s isNode=1
 s eor=$c(17,18,19,20)
 ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("NodeListener started: "_$j)
nodeLoop ;
 ;
 s $zt="g nodeError"
 s ^zewd("nodeProcesses",$j)=1 ; available
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("NodeListener "_$j_" awaiting read")
 ;s input=""
 ;f i=1:1 r *x d trace^%zewdAPI("x="_x)
 r input:60 e  d  g nodeLoop
 . i $g(^zewd("stopProcess",$j))'="" HALT
 s ^zewd("nodeProcesses",$j)=0 ; busy
 i $g(^zewd("trace"))=1 d
 . d trace^%zewdAPI($j_": input length ="_$l(input))
 . d trace^%zewdAPI($j_": input="_input)
 i input="" g nodeLoop
 s noOfMessages=$l(input,$c(2))-1
 f no=1:1:noOfMessages d
 . s message=$p(input,$c(2),no)
 . s type=$p(message,$c(1),2)
 . i type="http" d nodeHTTP(message)
 . i type="globalAccess" d globalAccessMethod(message)
 . i type="socket" d nodeSocket(message)
 g nodeLoop
 ;
 ;s type=$$removeCR(type)
 ;i $g(^%zewd("relink"))=1,'$d(^%zewd("relink","process",$j)) i $$relink^%zewdGTMRuntime()
 ;i type="http" g nodeHTTP
 ;i type="socket" g nodeSocket
 ;i type="globalAccess" d globalAccessMethod
 ;g nodeLoop
 ;
nodeHTTP(message) ;
 ;
 n %CGIEVAR,%KEY
 n content,ext,headers,method,p1,p2,p3,query,requestNo
 ;
 i $g(^%zewd("relink"))=1,'$d(^%zewd("relink","process",$j)) i $$relink^%zewdGTMRuntime()
 ;r query,headers,method,content
 s requestNo=$p(message,$c(1),1)
 s query=$p(message,$c(1),3)
 s headers=$p(message,$c(1),4)
 s method=$p(message,$c(1),5)
 s content=$p(message,$c(1),6)
 ;
 ; remove trailing CR
 ;s query=$$removeCR(query)
 ;s headers=$$removeCR(headers)
 ;s method=$$removeCR(method)
 ;s content=$$removeCR(content)
 ;
 s query=$$urlUnescape(query)
 ;
 s query=$$replaceAll^%zewdAPI(query,""""":"""",","")
 i query="{"""":""""}" s query="undefined"
 f  q:query'[""""":["  d
 . s p1=$p(query,""""":[",1)
 . s p2=$p(query,""""":[",2,$l(query))
 . s p3=$p(p2,"],",2,$l(p2))
 . s query=p1_p3
 s headers=$$urlUnescape(headers)
 s content=$$urlUnescape(content)
 ;d trace^%zewdAPI("headers="_headers)
 ;d trace^%zewdAPI("method="_method)
 ;d trace^%zewdAPI("content="_content)
 i query'="undefined" s ok=$$parseJSON^%zewdJSON(query,.%KEY,1)
 i content'="" d
 . s np=$l(content,"&")
 . f i=1:1:np d
 . . s nvp=$p(content,"&",i)
 . . s name=$p(nvp,"=",1)
 . . s value=$p(nvp,"=",2,$l(nvp))
 . . i '$d(%KEY(name)) d
 . . . s %KEY(name)=$$urlUnescape(value)
 . . e  d
 . . . n index
 . . . i '$d(%KEY(name,1)) d
 . . . . n value
 . . . . s value=%KEY(name)
 . . . . k %KEY(name)
 . . . . s %KEY(name,1)=value
 . . . s index=$o(%KEY(name,""),-1)+1
 . . . s %KEY(name,index)=$$urlUnescape(value)
 ;k ^rltkey m ^rltkey=%KEY
 i $$parseJSON^%zewdJSON(headers,.headArray,1)
 ;d trace^%zewdAPI("headers parsed")
 ;k ^rltheaders m ^rltheaders=headArray
 s name=""
 f  s name=$o(headArray(name)) q:name=""  d
 . q:name="headers"
 . q:name="response-headers"
 . ;d trace^%zewdAPI("name="_name)
 . s hname=$zconvert(name,"U")
 . ;d trace^%zewdAPI("hname="_hname)
 . s hname=$tr(hname,"-","_")
 . s %CGIEVAR(hname)=headArray(name)
 ;d trace^%zewdAPI(1111)
 s name=""
 f  s name=$o(headArray("headers",name)) q:name=""  d
 . s hname="HTTP_"_$zconvert(name,"U")
 . s hname=$tr(hname,"-","_")
 . s %CGIEVAR(hname)=headArray("headers",name)
 ;d trace^%zewdAPI(222)
 s %CGIEVAR("SERVER_SOFTWARE")="Node.js"
 s host=$G(%CGIEVAR("HTTP_HOST"))
 s port=$p(host,":",2)
 i port="" s port=$g(^zewd("defaultWebPort"))
 i port="" s port=80
 s host=$p(host,":",1)
 k %CGIEVAR("HTTP_HOST")
 s %CGIEVAR("SERVER_PORT")=port
 s %CGIEVAR("REMOTE_HOST")=$g(%CGIEVAR("REMOTE_ADDR"))
 s %CGIEVAR("SERVER_NAME")=host
 S %CGIEVAR("REQUEST_METHOD")=method
 ;
 ;d trace^%zewdAPI(3333)
 ;k ^robCGI m ^robCGI=%CGIEVAR
 s %KEY("app")=$p(%CGIEVAR("SCRIPT_NAME"),"/",3)
 s %KEY("page")=$p(%CGIEVAR("SCRIPT_NAME"),"/",4)
 s ext=".ewd"
 i %KEY("page")[".mgwsi" s ext=".mgwsi"
 s %KEY("page")=$p(%KEY("page"),ext,1)
 ;
 ;d trace^%zewdAPI("invoking nodeEntry")
 ; write back requestNo so response can be associated with request object in Node
 w requestNo_$c(20,19,18,17)
 d nodeEntry^%zewdGTMRuntime
 ;d trace^%zewdAPI("returned from nodeEntry")
 ;
 w $c(17,18,19,20)
 i $g(^zewd("nodeModules","updated"))=1 d
 . w "refresh=true"
 . k ^zewd("nodeModules","updated")
 w $c(13,10)
 ;d trace^%zewdAPI("returning to nodeLoop start")
 QUIT
 ;
nodeError ;
 i $g(^zewd("trace")) d trace^%zewdAPI("Error: "_$j_"; ze="_$ze)
 QUIT
 ;
nodeSocket(socketMessage) ;
 ;
 n message,messageType,requestNo,token
 ;
 s requestNo=$p(socketMessage,$c(1),1)
 w requestNo_$c(20,19,18,17)
 s messageType=$p(socketMessage,$c(1),3)
 s token=$p(socketMessage,$c(1),4)
 s message=$p(socketMessage,$c(1),5)
 ;r messageType,token,message
 ;s token=$$removeCR(token)
 ;s message=$$removeCR(message)
 ;s messageType=$$removeCR(messageType)
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("messageType: "_messageType_": token="_token_"; message="_message)
 s sessid=$$getSessid^%zewdPHP(token)
 i $$isTokenExpired^%zewdPHP(token) s sessid=""
 i sessid="" d
 . d sendSocketMessage("error","Invalid token or session expired")
 e  d
 . n rou
 . i messageType="test" d  q
 . . d updateSession(sessid)
 . . d sendSocketMessage("alert","$zv= "_$zv)
 . i messageType="ewdGetFragment" d  q
 . . n app,eor,json,%KEY,n,nvp,page,rouName,stop,targetId,x
 . . s eor=$c(17,18,19,20)
 . . s page=message
 . . s targetId=$p(socketMessage,$c(1),6)
 . . s nvp=$p(socketMessage,$c(1),7)
 . . ;r targetId,nvp
 . . ;s targetId=$$removeCR(targetId)
 . . ;s nvp=$$removeCR(nvp)
 . . i nvp'="" d
 . . . n i,name,np,value
 . . . s np=$l(nvp,"&")
 . . . f i=1:1:np d
 . . . . s name=$p(nvp,"&",i)
 . . . . s %KEY($p(name,"=",1))=$p(name,"=",2)
 . . w "ewdGetFragment:"_targetId_":"
 . . s app=$$getSessionValue^%zewdAPI("ewd_appName",sessid)
 . . s rouName=""
 . . i app'="",page'="" s rouName=$g(^zewd("routineMap",app,page))
 . . i rouName="" d
 . . . s rouName="ewdWL"_$$zcvt^%zewdAPI(app,"l")_$$zcvt^%zewdAPI(page,"l")
 . . . s rouName=$$replaceAll^%zewdAPI(rouName,"_","95")
 . . . s rouName=$$replaceAll^%zewdAPI(rouName,"-","45")
 . . . s rouName=$$replaceAll^%zewdAPI(rouName," ","")
 . . s %KEY("ewd_token")=token
 . . s n="",stop=0
 . . f  s n=$o(^%zewdSession("nextPageTokens",sessid,n)) q:n=""  d  q:stop
 . . . i $d(^%zewdSession("nextPageTokens",sessid,n,$$zcvt^%zewdAPI(page,"l"))) s stop=1
 . . s %KEY("n")=n
 . . s x="d run^"_rouName
 . . s zt=$zt
 . . s $zt="g wlRunErr"
 . . x x
 . . w eor
 . . s $zt=zt
 . ;
 . s rou=$g(^zewd("websocketHandler",messageType))
 . i rou'="" d
 . . n x
 . . d updateSession(sessid)
 . . s x="d "_rou_"("""_message_""","_sessid_")"
 . . i $g(^zewd("trace"))=1 d trace^%zewdAPI("socketHandler: x="_x)
 . . x x
 QUIT
 ;g nodeLoop
 ;
wlRunErr ;
 ;
 n errName,ze
 s app=$$zcvt^%zewdAPI(app,"l")
 s app=$$replaceAll^%zewdAPI(app,"_","95")
 s app=$$replaceAll^%zewdAPI(app,"-","45")
 s app=$$replaceAll^%zewdAPI(app," ","")
 s errName="ewdWL"_app_"ewderror"
 s x="d run^"_errName ;
 s ze=$$replaceAll^%zewdAPI($ze,"<","&lt;")
 s ze=$$replaceAll^%zewdAPI(ze,">","&gt;")
 s %KEY("error")="Enterprise Web Developer Error: There was a problem with page <i>"_page_"</i>:<br>"_ze_"<br><br>  Check that it exists in the <i>"_app_"</i> application and that it has been compiled"
 s $zt=""
 x x
 w eor
 ;
 g nodeLoop
 ;
sendSocketMessage(type,message)
 ;
 n eor,json
 ;
 s eor=$c(17,18,19,20)
 s message=$$replaceAll^%zewdAPI(message,"""","\""")
 s json="{""type"":"""_type_""",""message"":"""_message_"""}"
 w json_$c(17,17,17,17)_eor
 QUIT
 ;
removeCR(string)
 QUIT $e(string,1,$l(string)-1)
 ;
 ; WebSockets code for server-generated messages
 ;
server ;
 i $g(^zewd("trace"))=1 d trace^%zewdAPI("Node Sockets broadbast process starting on "_$j)
 ;
 ; GT.M interrupt mechanism
 ;
 n eor,token
 ;
 h 1
 l +^zewd("nodeProcess")
 l -^zewd("nodeProcess")
 s eor=$c(17,18,19,20)
 s $zint="d serverSend"
serverLoop
 s ^zewd("nodeProcesses",$j)=2 ; available
 h 5
 l +^zewd("nodeRunning"):0 i  d  halt
 . k ^zewd("nodeProcesses")
 . k ^zewd("stopProcess",$j)
 . l -^zewd("nodeRunning")
 i $g(^zewd("stopProcess",$j))=1 d  halt
 . k ^zewd("nodeProcesses",$j)
 . k ^zewd("stopProcess",$j)
 g serverLoop
 ;
serverSend ;
 n eor,no,token
 s eor=$c(17,18,19,20)
 ;d trace^%zewdAPI("serverSend invoked for "_$j)
 s ^zewd("nodeProcesses",$j)=0 ; busy
 w "-99"_$c(20,19,18,17)
 s no=""
 f  s no=$o(^zewd("message",no)) q:no=""  d
 . s sessid=$g(^zewd("message",no,"sessid"))
 . i sessid'="",$d(^%zewdSession("session",sessid)) d
 . . s token=$g(^zewd("message",no,"token"))
 . . i token'="" d
 . . . n json,type,token,message
 . . . s message=$g(^zewd("message",no,"message"))
 . . . ;w "serverSend:"_token_":"_message_eor
 . . . s type=$g(^zewd("message",no,"type"))
 . . . s token=$g(^zewd("message",no,"token"))
 . . . ;s message=$p(message,$c(1),4)
 . . . s json="{""type"":""serverSend"",""subType"":"""_type_""",""token"":"""_token_""",""message"":"""_message_"""}"
 . . . ;w "serverSend:"_type_":"_token_":"_message_eor
 . . . w json_$c(17,17,17,17)
 . k ^zewd("message",no)
 w eor
 s ^zewd("nodeProcesses",$j)=2 ; available
 QUIT
 ;
createServerMessage(type,message,sessid,trigger)
 ;
 n no,resourceName,token,value
 ;
 i $g(sessid)="" QUIT 0
 s token=$$getSessionValue^%zewdAPI("ewd_wstoken",sessid)
 i token="" QUIT 0
 i $$isTokenExpired^%zewdPHP(token) QUIT 0
 d updateSession(sessid)
 s no=$increment(^zewd("message"))
 s ^zewd("message",no,"token")=token
 s ^zewd("message",no,"type")=$g(type)
 s ^zewd("message",no,"message")=$g(message)
 s ^zewd("message",no,"sessid")=sessid
 s trigger=$g(trigger) i trigger="" s trigger=1
 i trigger=1 d triggerServerMessage
 QUIT 1
 ;
triggerServerMessage ;
 ;
 n cmd,pid,stop
 ;
 s pid=""
 s cmd=$g(^zewd("websocketTriggerCommand"))
 i cmd="" s cmd="kill -USR1"
 s stop=0
 f  s pid=$o(^zewd("nodeProcesses",pid)) q:pid=""  d  q:stop
 . i ^zewd("nodeProcesses",pid)=2 d
 . . s stop=1
 . . ;zsy "kill -USR1 "_pid
 . . zsy cmd_" "_pid
 QUIT
 ;
stopEventListener
 QUIT
 ;
hexDecode(hex)
 QUIT $f("0123456789ABCDEF",hex)-2
hexToDecimal(hex)
 ;
 n i,num
 s num=0
 f i=1:1:$l(hex) d
 . s num=num*16+$$hexDecode($e(hex,i))
 QUIT num
 ;
urlUnescape(esc)
 s esc=$tr(esc,"+"," ")
 i esc'["%" QUIT esc
 n a,c,string,i
 s string=""
 f i=1:1:$l(esc) d
 . s c=$e(esc,i)
 . i c'="%" s string=string_c q
 . s hex=$e(esc,i+1,i+2)
 . s a=$$hexToDecimal(hex)
 . s string=string_$c(a)
 . s i=i+2
 QUIT string
 ;
updateSession(sessid)
 ;
 n expires,now,timeout
 s timeout=$$getSessionValue^%zewdAPI("ewd_sessid_timeout",sessid)
 s now=$$convertDateToSeconds^%zewdPHP($h)
 s expires=now+timeout
 d setSessionValue^%zewdAPI("ewd_sessionExpiry",expires,sessid)
 QUIT
 ;
serverMessageTest(delay)
 ;
 n message,ok,sessid,trigger
 ;
 s trigger=$zv'["GT.M"
 s delay=$g(delay) i delay="" s delay=10
 f  d
 . h $g(delay)
 . s sessid=""
 . f  s sessid=$o(^%zewdSession("session",sessid)) q:sessid=""  d
 . . w "sessid="_sessid,!
 . . s message="Server message test for sessid "_sessid_" from "_$j_" at "_$$inetDate^%zewdAPI($h)
 . . s ok=$$createServerMessage^%zewdNode("alert",message,sessid,trigger)
 . i 'trigger d triggerServerMessage^%zewdNode
 . w "======",!
 QUIT
 ;
