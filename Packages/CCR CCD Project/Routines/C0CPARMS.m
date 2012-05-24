C0CPARMS ; CCDCCR/GPL - CCR/CCD PARAMETER PROCESSING ; 1/29/09
 ;;1.0;C0C;;May 19, 2009;Build 2
 ;Copyright 2008 WorldVistA.  Licensed under the terms of the GNU
 ;General Public License See attached copy of the License.
 ;
 ;This program is free software; you can redistribute it and/or modify
 ;it under the terms of the GNU General Public License as published by
 ;the Free Software Foundation; either version 2 of the License, or
 ;(at your option) any later version.
 ;
 ;This program is distributed in the hope that it will be useful,
 ;but WITHOUT ANY WARRANTY; without even the implied warranty of
 ;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ;GNU General Public License for more details.
 ;
 ;You should have received a copy of the GNU General Public License along
 ;with this program; if not, write to the Free Software Foundation, Inc.,
 ;51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ;
SET(INPARMS) ;INITIALIZE RUNTIME PARMS USING INPARMS TO OVERRIDE DEFAULTS
 ; PARAMETERS ARE PASSED AS A STRING: "PARM1:VALUE1^PARM2:VALUE2^ETC"
 ; THE SAME FORMAT IS USED BY RPC AND COMMAND LINE ENTRY POINTS
 ;
 N PTMP ;
 S C0CPARMS=$NA(^TMP("C0CPARMS",$J)) ;BASE FOR THIS RUN
 K @C0CPARMS ;START WITH EMPTY PARMS; MAY NOT WANT TO DO THIS KILL
 I $G(INPARMS)'="" D  ; OVERRIDES PROVIDED
 . N C0CI S C0CI=""
 . N C0CN S C0CN=1
 . F  S C0CI=$P(INPARMS,"^",C0CN) Q:C0CI=""  D  ;
 . . S C0CN=C0CN+1 ;NEXT PARM
 . . N C1,C2
 . . S C1=$P(C0CI,":",1) ; PARAMETER
 . . S C2=$P(C0CI,":",2) ; VALUE
 . . I C2="" S C2=1
 . . S @C0CPARMS@(C1)=C2
 . I C0CN=1 S @C0CPARMS@($P(INPARMS,":",1))=$P(C0CI,":",2) ; ONLY ONE
 ; THIS IS WHERE WE WILL INSERT CALLS TO THE PARAMETER FILE FOR DEFAULTS
 ; IF THEY FAIL, THE FOLLOWING WILL BE HARDCODED DEFAULTS
 ;OHUM/RUT commented the hardcoded limits
 ;I '$D(@C0CPARMS@("LABLIMIT")) S @C0CPARMS@("LABLIMIT")="T-360" ;ONE YR WORTH
 ;I '$D(@C0CPARMS@("LABSTART")) S @C0CPARMS@("LABSTART")="T" ;TODAY
 ;I '$D(@C0CPARMS@("VITLIMIT")) S @C0CPARMS@("VITLIMIT")="T-360" ;ONE YR VITALS
 ;I '$D(@C0CPARMS@("VITSTART")) S @C0CPARMS@("VITSTART")="T" ;TODAY
 ;I '$D(@C0CPARMS@("MEDSTART")) S @C0CPARMS@("MEDSTART")="T" ; TODAY
 ;I '$D(@C0CPARMS@("MEDSLIMIT")) S @C0CPARMS@("MEDLIMIT")="T-360" ; ONE YR MEDS
 ;I '$D(@C0CPARMS@("MEDACTIVE")) S @C0CPARMS@("MEDACTIVE")=1 ; YES
 ;I '$D(@C0CPARMS@("MEDPENDING")) S @C0CPARMS@("MEDPENDING")=0 ; NO
 ;I '$D(@C0CPARMS@("MEDALL")) S @C0CPARMS@("MEDALL")=0 ; NON-PENDING NON-ACTIVE
 ;OHUM/RUT 3120109 ; commented all limits
 ;S @C0CPARMS@("LABLIMIT")=^TMP("C0CCCR","LABLIMIT"),@C0CPARMS@("VITLIMIT")=^TMP("C0CCCR","VITLIMIT"),@C0CPARMS@("TIULIMIT")=^TMP("C0CCCR","TIULIMIT"),@C0CPARMS@("MEDLIMIT")=^TMP("C0CCCR","MEDLIMIT")
 ;I '$D(@C0CPARMS@("LABSTART")) S @C0CPARMS@("LABSTART")="T" ;TODAY
 ;I '$D(@C0CPARMS@("VITSTART")) S @C0CPARMS@("VITSTART")="T" ;TODAY
 ;I '$D(@C0CPARMS@("MEDSTART")) S @C0CPARMS@("MEDSTART")="T" ; TODAY
 ;I '$D(@C0CPARMS@("MEDACTIVE")) S @C0CPARMS@("MEDACTIVE")=1 ; YES
 ;I '$D(@C0CPARMS@("MEDPENDING")) S @C0CPARMS@("MEDPENDING")=0 ; NO
 ;I '$D(@C0CPARMS@("MEDALL")) S @C0CPARMS@("MEDALL")=1 ; NON-PENDING NON-ACTIVE
 ;;I '$D(@C0CPARMS@("RALIMIT")) S @C0CPARMS@("RALIMIT")="T-36500" ;ONE YR WORTH
 ;;I '$D(@C0CPARMS@("RASTART")) S @C0CPARMS@("RASTART")="T" ;TODAY
 ;I '$D(@C0CPARMS@("TIUSTART")) S @C0CPARMS@("TIUSTART")="T" ;TODAY
 ;;OHUM/RUT
 S @C0CPARMS@("LABLIMIT")=$P(^C0CPARM(1,0),"^",2),@C0CPARMS@("LABSTART")=$P(^C0CPARM(1,0),"^",3),@C0CPARMS@("VITLIMIT")=$P(^C0CPARM(1,0),"^",4),@C0CPARMS@("VITSTART")=$P(^C0CPARM(1,1),"^",1),@C0CPARMS@("MEDLIMIT")=$P(^C0CPARM(1,1),"^",2),@C0CPARMS@("MEDSTART")=$P(^C0CPARM(1,1),"^",3)
 I $P(^C0CPARM(1,1),"^",4)="ACT" S @C0CPARMS@("MEDACTIVE")=1
 I $P(^C0CPARM(1,1),"^",4)="PEN" S @C0CPARMS@("MEDPENDING")=1
 I $P(^C0CPARM(1,1),"^",4)="ALL" S @C0CPARMS@("MEDALL")=1
 ;S ^TMP("C0CCCR","TIULIMIT")="",^TMP("C0CCCR","TIUSTART")=""
 I $P(^C0CPARM(1,2),"^",3)=1 S @C0CPARMS@("TIULIMIT")=$P(^C0CPARM(1,2),"^",1),@C0CPARMS@("TIUSTART")=$P(^C0CPARM(1,2),"^",2)
 ;OHUM/RUT
 Q
 ;
CHECK ; CHECK TO SEE IF PARMS ARE PRESENT, ELSE RUN SET
 ;
 I '$D(C0CPARMS) S C0CPARMS=$NA(^TMP("C0CPARMS",$J)) ;SHOULDN'T HAPPEN
 I '$D(@C0CPARMS) D SET("SETWITHCHECK:1")
 Q
 ;
GET(WHICHP) ;EXTRINSIC TO RETURN THE VALUE OF PARAMETER WHICHP
 ;
 D CHECK ; SHOULDN'T HAPPEN BUT TO BE SAFE
 N GTMP
 Q $G(@C0CPARMS@(WHICHP)) ;PULL THE PARM FROM THE TABLE
 ;