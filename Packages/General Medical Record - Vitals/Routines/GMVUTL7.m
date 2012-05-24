GMVUTL7 ;HIOFO/DS,FT-RPC API TO RETURN ALL VITALS/CATEGORIES/QUALIFIERS ;7/17/02  14:52
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10035 - FILE 2 references      (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
 ; This routine supports the following IAs:
 ; #4355 - GMV GET CURRENT TIME RPC is called at TIME  (private)
 ; #4359 - GMV VITALS/CAT/QUAL RPC is called at GETVITAL (private)
 ;
GETVITAL(RESULT,GMVLIST)        ; GMV VITALS/CAT/QUAL [RPC entry point]
 ; Returns all vital qual info in RESULT
 ;GMVLIST is either "" for all vitals or a list of required eg 1^2^
 N GMVNUM,GMVDATA,GMVDO,GMVLOOP
 S GMVNUM=1
 I GMVLIST'="" D
 . F GMVLOOP=1:1:$L(GMVLIST,"^") D
 .. S GMVDO=$P(GMVLIST,"^",GMVLOOP)
 .. Q:GMVDO=""
 .. S GMVDO=$$GETIEN(GMVDO)
 .. Q:GMVDO=""
 .. S RESULT(GMVNUM)=$$GETDATA(GMVDO)_"^"_$$ABBVAL(GMVDO)
 .. D GETALL(GMVNUM,.RESULT)
 .. S GMVNUM=GMVNUM+1
 .. Q
 . Q
 E  D
 . S GMVLOOP=0
 . F  S GMVLOOP=$O(^GMRD(120.51,GMVLOOP)) Q:GMVLOOP'>0  D
 .. S RESULT(GMVNUM)=$$GETDATA(GMVLOOP)_"^"_$$ABBVAL(GMVLOOP)
 .. D GETALL(GMVNUM,.RESULT)
 .. S GMVNUM=GMVNUM+1
 .. Q
 . Q
 Q
GETALL(GMVLOOP,RESULT)  ;
 S GMVCNT=0
 ;S GMVLOOP="" F  S GMVLOOP=$O(RESULT(GMVLOOP)) Q:GMVLOOP=""  D
 Q:$G(RESULT(GMVLOOP))=""
 Q:$P(RESULT(GMVLOOP),"^",1)'="V"
 S GMVITTYP=$P(RESULT(GMVLOOP),"^",2)
 S GMVD2=""
 S GMVCNT=GMVLOOP+.001
 F  S GMVD2=$O(^GMRD(120.53,"C",GMVITTYP,GMVD2)) Q:GMVD2'>0  D
 . S GMVD1=0
 . F  S GMVD1=$O(^GMRD(120.53,"C",GMVITTYP,GMVD2,GMVD1)) Q:GMVD1'>0  D
 .. S GMVDATA=$P($G(^GMRD(120.53,GMVD2,0)),U)
 .. I GMVDATA]"" D
 ... S GMVITTYP(0)=$G(^GMRD(120.51,+GMVITTYP,0))
 ... S GMVITTYP(1)=GMVITTYP,GMVITTYP(2)=$P(GMVITTYP(0),U,2)
 ... S GMVITTYP(3)=$P(GMVITTYP(0),U)
 ... S GMVDEFQ=$P($G(^GMRD(120.53,GMVD2,1,GMVD1,0)),U,7)
 ... S GMVDEFQ(0)=$G(^GMRD(120.52,+GMVDEFQ,0))
 ... S GMVDEFQ(1)=GMVDEFQ,GMVDEFQ(2)=$P(GMVDEFQ(0),U,2)
 ... S GMVDEFQ(3)=$P(GMVDEFQ(0),U)
 ... S RESULT(GMVCNT)="C"_U_GMVD2_U_GMVDATA
 ... D GETCAT(GMVITTYP,GMVD2,.RESULT,.GMVCNT)
 ... S GMVCNT=GMVCNT+.001
 ... Q
 .. Q
 . Q
 Q
GETDATA(GMVVITAL)       ;
 N GMVDATA,GMVD0,GMVD1
 I $G(^GMRD(120.51,GMVVITAL,0))="" D   Q GMVRES
 . S GMVRES="V^"_GMVVITAL_"^ERROR"
 . Q
 S GMVDATA=$G(^GMRD(120.51,GMVVITAL,0))
 I GMVDATA]"" S GMVRES="V"_U_GMVVITAL_U_$P(GMVDATA,U)_U_$P(GMVDATA,U,2)_U_$P(GMVDATA,U,7)
 Q GMVRES
GETCAT(GMVVTP,GMVITCAT,RESULT,GMVNUM)        ;
 N GMVD0,GMVD1,GMVCNT
 S GMVD0=0,GMVCNT=0
 F  S GMVD0=$O(^GMRD(120.52,"C",GMVITTYP,GMVD0)) Q:GMVD0'>0  D
 . S GMVD1=0
 . F  S GMVD1=$O(^GMRD(120.52,"C",GMVITTYP,GMVD0,GMVD1)) Q:GMVD1'>0  D
 .. S GMVCATD0=$P($G(^GMRD(120.52,GMVD0,1,GMVD1,0)),U,2)
 .. I $G(GMVITCAT)>0,GMVITCAT'=GMVCATD0 Q
 .. S GMVDATA=$G(^GMRD(120.52,GMVD0,0))
 .. I GMVDATA]"" D
 ... S GMVITTYP(0)=$G(^GMRD(120.51,+GMVITTYP,0))
 ... S GMVITTYP(1)=GMVITTYP,GMVITTYP(2)=$P(GMVITTYP(0),U,2)
 ... S GMVITTYP(3)=$P(GMVITTYP(0),U)
 ... S GMVITCAT(0)=$G(^GMRD(120.53,+GMVCATD0,0))
 ... S GMVITCAT(1)=GMVCATD0,(GMVITCAT(2),GMVITCAT(3))=$P(GMVITCAT(0),U)
 ... S GMVNUM=GMVNUM+.001
 ... S RESULT(GMVNUM)="Q"_U_GMVD0_U_$P(GMVDATA,U)_U_$P(GMVDATA,U,2)
 ... Q
 .. Q
 . Q
 Q
ABBVAL(VITALTYP)       ;
 N RESULT,GMVDATA
 ; Gets high low values if they exist
 I $G(^GMRD(120.57,1,1))="" Q ""
 S RESULT=""
 S GMVDATA=$P($G(^GMRD(120.57,1,1)),U,1,13)
 I VITALTYP=1 D
 . ; BP
 . S RESULT=$P(GMVDATA,U,7,10)
 . Q
 I VITALTYP=2 D
 . ; Temprature
 . S RESULT=$P(GMVDATA,U,1,2)
 . Q
 I VITALTYP=5 D
 . ; Pulse
 . S RESULT=$P(GMVDATA,U,3,4)
 . Q
 I VITALTYP=3 D
 . ;Respirations
 . S RESULT=$P(GMVDATA,U,5,6)
 . Q
 I VITALTYP=19 D
 . ;CVP
 . S RESULT=$P(GMVDATA,U,11,13)
 . Q
 Q RESULT
GETIEN(GMVABB) ; Gets IEN from the Abbreviation code.
 Q $O(^GMRD(120.51,"C",GMVABB,""))
ROOMPT(RESULTS,GMVWRD,GMVRLST) ; GMV WARD/ROOM PATIENTS [RPC entry point]
 ; Returns a list of patients in the ward and rooms specified
 ; Input:
 ; RESULTS - name of the array to hold the patient list
 ; GMVWRD  - name of the ward (e.g., 2EAST)
 ; GMVRLST - the room numbers of the ward separated by comma
 ;           (e.g., 200,210,220)
 ; Output:
 ; RESULT(n)=patient name^DFN^DOB (external)^SSN (no hyphens)
 ;
 ; n is a sequential number beginning with 0 (zero)
 N GMRVROOM,GMRVLST,GMRVCNT,GMVT,GMVDF
 K RESULTS
 S GMVWARD(1)=GMVWRD
 I GMVRLST["," D
 . F GMVA=1:1:$L(GMVRLST)+1 D
 . . Q:$P(GMVRLST,",",GMVA)=""
 . . S GMVROOM($P($P(GMVRLST,",",GMVA),"-"))=""
 . . Q
 . Q
 E  D
 . S GMVROOM($P(GMVRLST,"-"))=""
 . Q
 S GMVEDB="S"
 K ^TMP($J)
 D WARD^GMVDS1
 S GMVT="",GMVCNT=0
 F  S GMVT=$O(^TMP($J,GMVT)) Q:GMVT=""  D
 . S GMVN=""
 . F  S GMVN=$O(^TMP($J,GMVT,GMVN)) Q:GMVN=""  D
 . . S GMVDF=""
 . . F  S GMVDF=$O(^TMP($J,GMVT,GMVN,GMVDF)) Q:GMVDF=""  D
 . . . S GMVDOB=$$FMTE^XLFDT($P(^DPT(GMVDF,0),"^",3))
 . . . S GMVSSN=$P(^DPT(GMVDF,0),"^",9)
 . . . S RESULTS(GMVCNT)=GMVN_"^"_GMVDF_"^"_GMVDOB_"^"_GMVSSN
 . . . S GMVCNT=GMVCNT+1
 . . . Q
 . . Q
 . Q
 Q
TIME(RESULT,P2) ;Gets current time
 S RESULT=$$NOW^XLFDT()
 Q
