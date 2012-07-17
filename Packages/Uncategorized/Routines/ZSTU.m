ZSTU ;OpenM calls this routine at boot time to perform all commands listed
 ; in this file.  E.G. start taskman, start broker, etc.
 S $ZT="ERR"
 ;  Start TaskMan, Broker for Camp Account CAA
 J ^ZTMB:"CAA"
 J STRT^XWBTCP(9010):"CAA"
ERR Q
