RCXVDC3 ;DAOU/ALA-AR Data Extraction Data Creation ; 23 Jul 2007  10:32 AM
 ;;4.5;Accounts Receivable;**201,227,228,232,248,251**;Mar 20, 1995;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; CLAIMS (# 399)
 Q
D399 ;
 NEW RCXVD,RCXVBC,RCXVDT,RCXVD1,RCXVD2,RCXVD3
 NEW RCXVD4,RCXVD5,RCXVD6,RCXVD7,RCXVDA,RCXVDB,RCXVDC,RCXVDD
 NEW RCXVP1,RCXVP2,RCXVD0C,RCXVP3,RCXVP4,RCXVP5,RCXVCFL,RCXVPAY
 NEW RCXVINS,RCXVVAN,RCXVDRG,RCXVCAN,RCXVSNR,IBD,X1,X2,RCXVNPI
 ;
 I $P(RCXVBLNA,"-",2)="" Q
 S RCXVD0=$O(^DGCR(399,"B",$P(RCXVBLNA,"-",2),""))
 I RCXVD0="" Q
 S RCXVD1=$G(^DGCR(399,RCXVD0,0))
 I $G(DFN)="" S DFN=$P(RCXVD1,U,2)
 S RCXVD2=$G(^DGCR(399,RCXVD0,"S"))
 S RCXVD3=$G(^DGCR(399,RCXVD0,"U"))
 S RCXVD7=$G(^DGCR(399,RCXVD0,"TX"))
 S RCXVDA=$P(RCXVD1,U,1) ; BILL #
 S (RCXVEVDT,RCXVDT)=$P($P(RCXVD1,U,3),".",1)
 ;S RCXVDA=RCXVBLNB_RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; EVNT DT
 S RCXVDA=RCXVBLNA_RCXVU_$P(^DPT(DFN,0),U,9) ; SSN
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; EVNT DT
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD1,U,5) ; BILL CLASS
 S RCXVP1=$P(RCXVD1,U,7),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^DGCR(399.3,RCXVP1,0)),U,1)
 S RCXVDA=RCXVDA_RCXVU_RCXVP2 ; RATE TYPE (P)
 S RCXVP1=$P(RCXVD2,U,11),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^VA(200,RCXVP1,2,0)),U,1)_RCXVP1 ; SITE_IEN
 S RCXVDA=RCXVDA_RCXVU_RCXVSITE_RCXVP2 ; Authorizer (P)
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD1,U,13) ; Stat
 S RCXVDT=$P(RCXVD1,U,14)
 S RCXVDA=RCXVDA_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; Stat DT
 S RCXVP1=$P(RCXVD1,U,22),RCXVP2="",RCXVNPI=""
 I RCXVP1'="" S RCXVP2=$$GET1^DIQ(40.8,RCXVP1,1)  ;$P($G(^DG(40.8,RCXVP1,0)),U,2)
 S:$G(RCXVP1)'="" RCXVNPI=$P($$NPI^XUSNPI("Organization_ID",$$GET1^DIQ(40.8,RCXVP1,.07,"I")),RCXVU,1) S:+RCXVNPI<1 RCXVNPI=""  ;Default Division NPI
 S RCXVDA=RCXVDA_RCXVU_RCXVP2_RCXVU_RCXVNPI ; Default division^Default division NPI
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD1,U,24) ; UB92 Location
 S RCXVDA=RCXVDA_RCXVU_$P(RCXVD1,U,27) ; Bill Chrg type
 S RCXVDT=$P(RCXVD2,U,10)
 S RCXVDB=$E($$HLDATE^HLFNC(RCXVDT),1,8) ; Auth. DT
 S RCXVDT=$P(RCXVD2,U,12)
 S RCXVDB=RCXVDB_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ; DT 1st printed
 S (RCXVP1,RCXVD0C)=$P($G(^DGCR(399,RCXVD0,"M")),U,1),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^DIC(36,RCXVP1,0)),U,1)
 S RCXVDB=RCXVDB_RCXVU_RCXVP2 ; PRIM. INSR (P)
 ;
 ; Type of Plan
 S RCXVP2="",RCXVI=0,RCXVP3="",RCXVP4="",RCXVP5=""
 S IBD=$$IBAREXT^IBRFN4(RCXVD0,.IBD)
 S RCXVP2=$P(IBD("IN"),U),RCXVP5=$P(IBD("IN"),U,2),RCXVP3=$P(IBD("IN"),U,3),RCXVP4=$P(IBD("IN"),U,4)
 S RCXVDB=RCXVDB_RCXVU_RCXVP2_RCXVU_RCXVP5_RCXVU_RCXVP3_RCXVU_RCXVP4,RCXVD5="",RCXVD6=""
 ;
 ; 36, 36.3 ADDRESS/EDI
 I RCXVD0C S RCXVD5=$G(^DIC(36,RCXVD0C,.11))
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD5,U,1) ; STRT ADD 1
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD5,U,2) ; STRT ADD 2
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD5,U,4) ; CITY
 S RCXVP1=$P(RCXVD5,U,5),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^DIC(5,RCXVP1,0)),U,1)
 S RCXVDB=RCXVDB_RCXVU_RCXVP2 ; STATE (P)
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD5,U,6) ; ZIP
 I RCXVD0C'="" S RCXVD6=$G(^DIC(36,RCXVD0C,3))
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD6,U,2) ; EDI - PROF
 S RCXVDB=RCXVDB_RCXVU_$P(RCXVD6,U,4) ; EDI - INST
 S RCXVDB=RCXVDB_RCXVU_$$GET1^DIQ(36,RCXVD0C_",",1,"I") ; REIMBURSE?
 ;
 S RCXVPFDT=$P(RCXVD3,U,1)
 S RCXVDC=$$HLDATE^HLFNC(RCXVPFDT) ; STMT COVERS FROM
 S RCXVPTDT=$P(RCXVD3,U,2)
 S RCXVDC=RCXVDC_RCXVU_$$HLDATE^HLFNC(RCXVPTDT) ; STMT COVERS TO
 S RCXVP1=$P(RCXVD3,U,11),RCXVP2=""
 I RCXVP1'="" S RCXVP2=$P($G(^DGCR(399.1,RCXVP1,0)),U,1)
 S RCXVDC=RCXVDC_RCXVU_RCXVP2 ; DISCH. BED SEC.
 S RCXVD4=$G(^DGCR(399,RCXVD0,"U1"))
 S RCXVDC=RCXVDC_RCXVU_$P(RCXVD4,U,1) ; TOT CHRG
 ;
 S RCXVP1=$P($G(^DGCR(399,RCXVD0,"U2")),U,10),RCXVP2="",RCXVNPI=""
 I RCXVP1'="" S RCXVP2=$P($G(^IBA(355.93,RCXVP1,0)),U,1)
 S:$G(RCXVP2)'="" RCXVNPI=$P($$NPI^XUSNPI("Non_VA_Provider_ID",RCXVP1),RCXVU,1) S:+RCXVNPI<1 RCXVNPI=""
 I RCXVNPI="",$G(RCXVP2)'="" S RCXVNPI=$$GET1^DIQ(355.93,RCXVP1,41.01,"I")  ;This line is used if the XUSNPI API does not work
 S RCXVDC=RCXVDC_RCXVU_RCXVP2_RCXVU_RCXVNPI ; NON VA FAC (P)^NON VA FAC NPI
 ;
 ;  Get VACARE or NONVACARE flag
 NEW RCXVIEN
 D CARE^RCXVUTIL(RCXVD0)
 S RCXVDC=RCXVDC_RCXVU_$S(RCXVCFL=1:"VACARE",1:"NONVACARE")
 ;  MRA data
 S RCXVDT=$P(IBD,U,2)
 S RCXVDD=$E($$HLDATE^HLFNC(RCXVDT),1,8) ; MRA Requested DT
 S RCXVDT=$P(IBD,U,3)
 S RCXVDD=RCXVDD_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ;Last Electronic Extract Date
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,4) ;Printed VIA EDI
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,5) ;Force Claim To Print
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,6) ;Claim MRA Status
 S RCXVDT=$P(IBD,U,7)
 S RCXVDD=RCXVDD_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ;MRA Recorded Date
 S RCXVDT=$P(IBD,U,8)
 S RCXVDD=RCXVDD_RCXVU_$E($$HLDATE^HLFNC(RCXVDT),1,8) ;Date Cancelled
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,9) ;Form Type
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,16)_RCXVU_$P(IBD,U,15) ;PAYER&VA NAT.ID #
 S RCXVDRG=$P(IBD,U,11)
 S RCXVDD=RCXVDD_RCXVU_RCXVDRG ;DRG
 S RCXVSNR=$P(IBD,U,14) ;Days site not responsible for MRA request
 S RCXVDD=RCXVDD_RCXVU_RCXVSNR
 S RCXVDD=RCXVDD_RCXVU_$P($P(IBD,U,12),";") ;ECME #
 S RCXVDD=RCXVDD_RCXVU_$P(IBD,U,17) ;Offset Amount
 S ^TMP($J,RCXVBLN,"3-399A")=RCXVDA
 S ^TMP($J,RCXVBLN,"3-399B")=RCXVDB
 S ^TMP($J,RCXVBLN,"3-399C")=RCXVDC
 S ^TMP($J,RCXVBLN,"3-399D")=RCXVDD
 Q
 ;
REJ() ;Checks for reject on a claim
 S X="NO"
 S X1=$P(RCXVD1,U,15) S D0=RCXVD0
 F  D  G REJQ:'D0
 . S I=0 F  S I=$O(^IBM(361,"B",D0,I)) Q:'I  D  Q:'D0
   ..S X2=$P($G(^IBM(361,I,0)),U,3)
   ..I X2="R" S X="YES",D0=""
   ..Q
 .I X="YES" Q
 .I X1=D0 S D0="" Q
 .S D0=X1 Q:'D0  S X1=$P($G(^DGCR(399,X1,0)),U,15)
 .Q
 K I
REJQ Q X
 ;
