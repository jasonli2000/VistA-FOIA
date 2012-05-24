SPNLGUSN ; ISC-SF/GMB - SCD GATHER LAST SEEN; 3 JUL 94 [ 07/12/94  7:03 AM ] ;6/23/95  11:50
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
SEEN(DFN,FDATE,TDATE,SEEN,LASTSEEN,SEENIP,SEENOP,SEENCH,SEENRX,SEENRA) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; During the time period FDATE thru TDATE,
 ; SEEN      (1/0) patient was (not) seen
 ; LASTSEEN  Date patient was last seen
 ; SEENIP    (1/0) patient was (not) seen as an inpatient
 ; SEENOP    (1/0) patient was (not) seen as an outpatient
 ; SEENCH    (1/0) patient was (not) seen for a lab test
 ; SEENRX    (1/0) patient was (not) seen in pharmacy
 ; SEENRA    (1/0) patient was (not) seen in radiology
 N LASTIP,LASTOP,LASTCH,LASTRX,LASTRA
 I '$D(TDATE) S TDATE=DT
 S LASTSEEN=0
 D IP(.SEENIP,.LASTIP)
 I SEENIP,(LASTIP>LASTSEEN) S LASTSEEN=LASTIP
 D OP(.SEENOP,.LASTOP)
 I SEENOP,(LASTOP>LASTSEEN) S LASTSEEN=LASTOP
 D CH(.SEENCH,.LASTCH)
 I SEENCH,(LASTCH>LASTSEEN) S LASTSEEN=LASTCH
 D RX(.SEENRX,.LASTRX)
 I SEENRX,(LASTRX>LASTSEEN) S LASTSEEN=LASTRX
 D RA(.SEENRA,.LASTRA)
 I SEENRA,(LASTRA>LASTSEEN) S LASTSEEN=LASTRA
 S SEEN=(SEENIP)!(SEENOP)!(SEENCH)!(SEENRX)!(SEENRA)
 Q
IP(SEEN,LASTSEEN)  ;
 N RECNR,NODE0,NODE70,ZDD,ZAD
 S LASTSEEN=0
 ; We will take all admissions which overlap the desired range, and adjust
 ; the admit and/or discharge dates to conform with the desired range.
 S RECNR=0 ; for each inpatient record
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S NODE0=$G(^DGPT(RECNR,0))
 . Q:$P(NODE0,U,11)'=1  ; 1=PTF record, 2=census record
 . S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$P(NODE70,U,1)\1 ; Discharge date
 . Q:ZDD'=0&(ZDD<FDATE)
 . S ZAD=$P(NODE0,U,2)\1 Q:ZAD>TDATE  ; Admit date
 . S LASTSEEN=$S(ZDD>TDATE:TDATE,ZDD=0:TDATE,1:ZDD)
 S SEEN=$S(LASTSEEN=0:0,1:1)
 Q
OP(SEEN,LASTSEEN)  ;
 N VASD,APPT,LASTAPPT
 S VASD("F")=FDATE,VASD("T")=TDATE D SDA^VADPT
 S (APPT,LASTAPPT)=0
 F  S APPT=$O(^UTILITY("VASD",$J,APPT)) Q:APPT=""  D
 . S LASTAPPT=APPT
 I LASTAPPT=0 D
 . S (SEEN,LASTSEEN)=0
 E  D
 . S LASTSEEN=+^UTILITY("VASD",$J,LASTAPPT,"I")\1
 . S SEEN=1
 Q
CH(SEEN,LASTSEEN) ;
 N LFN,LASTDATE,TESTDATE
 S (SEEN,LASTSEEN)=0
 S LFN=+$P($G(^DPT(DFN,"LR")),U,1)
 Q:'LFN
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1)
 S TESTDATE=$O(^LR(LFN,"CH",TESTDATE))
 Q:TESTDATE'>0!(TESTDATE>LASTDATE)
 S LASTSEEN=9999999-TESTDATE\1
 S SEEN=1
 Q
RX(SEEN,LASTSEEN)  ;
 N EXPDATE,RECNR,FILLDATE,SUBRECNR
 S LASTSEEN=0
 S EXPDATE=FDATE-.000001 ; For each expiration date
 F  S EXPDATE=$O(^PS(55,DFN,"P","A",EXPDATE)) Q:EXPDATE'>0  D
 . S RECNR=0 ; For each prescription on that date
 . F  S RECNR=$O(^PS(55,DFN,"P","A",EXPDATE,RECNR)) Q:RECNR'>0  D
 . . S FILLDATE=$P($G(^PSRX(RECNR,2)),U,2)
 . . Q:FILLDATE>TDATE
 . . S:FILLDATE'<FDATE LASTSEEN=FILLDATE ; original fill
 . . S SUBRECNR=0 ; For each refill
 . . F  S SUBRECNR=$O(^PSRX(RECNR,1,SUBRECNR)) Q:SUBRECNR'>0  D  Q:FILLDATE>TDATE
 . . . S FILLDATE=$P($G(^PSRX(RECNR,1,SUBRECNR,0)),U,1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . S:FILLDATE>LASTSEEN LASTSEEN=FILLDATE
 S SEEN=$S(LASTSEEN=0:0,1:1)
 Q
RA(SEEN,LASTSEEN)  ;
 N LASTDATE,EXAMDATE
 S (SEEN,LASTSEEN)=0
 S LASTDATE=9999999.9999-FDATE
 S EXAMDATE=9999999.9999-(TDATE+1)
 S EXAMDATE=$O(^RADPT(DFN,"DT",EXAMDATE))
 Q:EXAMDATE'>0!(EXAMDATE>LASTDATE)
 S LASTSEEN=9999999.9999-EXAMDATE\1
 S SEEN=1
 Q
