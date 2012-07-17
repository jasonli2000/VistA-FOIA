DSIROIR3 ;AMC/EWL - Document Storage System;Year End FOIA Report ;09/22/2009 13:15
 ;;7.2;RELEASE OF INFORMATION - DSSI;;Sep 22, 2009;Build 35
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;Integration Agreements 10046
 Q
 ; THE FOLLOWING ARE SUPPORT ROUTINES FOR DSIROIR0
 ; THEY HAVE BEEN MOVED HERE TO REDUCE THE ROUTINE SIZE OF DSIROIR0
UC() ;Update counter
 S CNT=CNT+1
 Q CNT
TOTALS ;Add everything and set into return global
 N CNT,I S CNT=4
 ;EXEMPTION 3 STATUTES
 S ^TMP(AXYN,$J,$$UC)="EX35705^"_EX35705_"^EXEMPTION 3 38 USC 5705",DSIRLOG(145.01)=EX35705 ;145.01
 S ^TMP(AXYN,$J,$$UC)="EX37332^"_EX37332_"^EXEMPTION 3 38 USC 7332",DSIRLOG(146.01)=EX37332 ;146.01
 S ^TMP(AXYN,$J,$$UC)="EX35701^"_EX35701_"^EXEMPTION 3 38 USC 5701",DSIRLOG(147.01)=EX35701 ;147.01
 S ^TMP(AXYN,$J,$$UC)="EX3253B^"_EX3253B_"^EXEMPTION 3 41 USC 253b(m)",DSIRLOG(148.01)=EX3253B ;148.01
 S ^TMP(AXYN,$J,$$UC)="EX3APP3^"_EX3APP3_"^EXEMPTION 3 5 USC APP 3 (IG ACT)",DSIRLOG(149.01)=EX3APP3 ;149.01
 S ^TMP(AXYN,$J,$$UC)="EX3205^"_EX3205_"^EXEMPTION 3 35 USC 205",DSIRLOG(150.01)=EX3205 ;150.01
 ;RECEIVED PROCESSED AN PENDING REQUESTS
 S ^TMP(AXYN,$J,$$UC)="NBRPROCD^"_NBRPROCD_"^REQUESTS PROCESSED DURING FY",DSIRLOG(151.01)=NBRPROCD ;151.01
 S ^TMP(AXYN,$J,$$UC)="NBRPNDST^"_NBRPNDST_"^REQUESTS PENDING AT FY START",DSIRLOG(152.01)=NBRPNDST ;152.01
 S ^TMP(AXYN,$J,$$UC)="NBRRECVD^"_NBRRECVD_"^REQUESTS RECIEVED DURING FY",DSIRLOG(153.01)=NBRRECVD ;153.01
 ;BACKLOGGED
 S ^TMP(AXYN,$J,$$UC)="BACKLGCT^"_BACKLGCT_"^NUMBER BACKLOGGED (PENDING >20 DAYS)",DSIRLOG(154.01)=BACKLGCT ;154.01 BACKLOGGED
 ;DISPOSITION OF REQUESTS - ALL PROCESSED REQUESTS
 S NBRPNDED=NBRPNDST+NBRRECVD-NBRPROCD
 S ^TMP(AXYN,$J,$$UC)="NBRPNDED^"_NBRPNDED_"^REQUESTS PENDING AT FY END",DSIRLOG(155.01)=NBRPNDED ;155.01
 S ^TMP(AXYN,$J,$$UC)="NBRGRNTS^"_NBRGRNTS_"^NUMBER OF TOTAL GRANTS",DSIRLOG(156.01)=NBRGRNTS ;156.01
 S ^TMP(AXYN,$J,$$UC)="NBRPARTS^"_NBRPARTS_"^NUMBER OF PARTIAL GRANTS",DSIRLOG(157.01)=NBRPARTS ;157.01
 S ^TMP(AXYN,$J,$$UC)="NBRDENY^"_NBRDENY_"^NUMBER OF DENIALS",DSIRLOG(158.01)=NBRDENY ;158.01
 ;EXEMPTIONS
 S ^TMP(AXYN,$J,$$UC)="EXEMP1^"_EXEMP1_"^EXEMPTION 1 ",DSIRLOG(159.01)=EXEMP1 ;159.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP2^"_EXEMP2_"^EXEMPTION 2 ",DSIRLOG(160.01)=EXEMP2 ;160.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP3^"_EXEMP3_"^EXEMPTION 3 ",DSIRLOG(161.01)=EXEMP3 ;161.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP4^"_EXEMP4_"^EXEMPTION 4 ",DSIRLOG(162.01)=EXEMP4 ;162.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP5^"_EXEMP5_"^EXEMPTION 5 ",DSIRLOG(163.01)=EXEMP5 ;163.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP6^"_EXEMP6_"^EXEMPTION 6 ",DSIRLOG(164.01)=EXEMP6 ;164.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7A^"_EXEMP7A_"^EXEMPTION 7A ",DSIRLOG(165.01)=EXEMP7A ;165.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7B^"_EXEMP7B_"^EXEMPTION 7B ",DSIRLOG(166.01)=EXEMP7B ;166.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7C^"_EXEMP7C_"^EXEMPTION 7C ",DSIRLOG(167.01)=EXEMP7C ;167.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7D^"_EXEMP7D_"^EXEMPTION 7D ",DSIRLOG(168.01)=EXEMP7D ;168.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7E^"_EXEMP7E_"^EXEMPTION 7E ",DSIRLOG(169.01)=EXEMP7E ;169.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP7F^"_EXEMP7F_"^EXEMPTION 7F ",DSIRLOG(170.01)=EXEMP7F ;170.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP8^"_EXEMP8_"^EXEMPTION 8 ",DSIRLOG(171.01)=EXEMP8 ;171.01
 S ^TMP(AXYN,$J,$$UC)="EXEMP9^"_EXEMP9_"^EXEMPTION 9 ",DSIRLOG(172.01)=EXEMP9 ;172.01
 ;OTHER NONDISCLOSURE
 ;S ORNDTOT=ORNDA+ORNDB+ORNDC+ORNDD+ORNDE+ORNDF+ORNDG+ORNDH+ORNDI
 ;S ^TMP(AXYN,$J,$$UC)="ORNDTOT^"_ORNDTOT_"^NON DISCLOSURE TOTAL",DSIRLOG(173.01)=ORNDTOT ;173.01
 S ^TMP(AXYN,$J,$$UC)="ORNDA^"_ORNDA_"^NON DISCLOSURE NO RECORDS",DSIRLOG(174.01)=ORNDA ;174.01
 S ^TMP(AXYN,$J,$$UC)="ORNDB^"_ORNDB_"^NON DISCLOSURE REFERRALS",DSIRLOG(175.01)=ORNDB ;175.01
 S ^TMP(AXYN,$J,$$UC)="ORNDC^"_ORNDC_"^NON DISCLOSURE REQUEST WITHDRAWN",DSIRLOG(176.01)=ORNDC ;176.01
 S ^TMP(AXYN,$J,$$UC)="ORNDD^"_ORNDD_"^NON DISCLOSURE FEE-RELATED REASON",DSIRLOG(177.01)=ORNDD ;177.01
 S ^TMP(AXYN,$J,$$UC)="ORNDE^"_ORNDE_"^NON DISCLOSURE RECORD NOT DESCRIBED",DSIRLOG(178.01)=ORNDE ;178.01
 S ^TMP(AXYN,$J,$$UC)="ORNDF^"_ORNDF_"^NON DISCLOSURE NOT PROPER FOIA",DSIRLOG(179.01)=ORNDF ;179.01
 S ^TMP(AXYN,$J,$$UC)="ORNDG^"_ORNDG_"^NON DISCLOSURE NOT AN AGENCY RECORD",DSIRLOG(180.01)=ORNDG ;180.01
 S ^TMP(AXYN,$J,$$UC)="ORNDH^"_ORNDH_"^NON DISCLOSURE DUPLICATE REQUEST",DSIRLOG(181.01)=ORNDH ;181.01
 S ^TMP(AXYN,$J,$$UC)="ORNDI^"_ORNDI_"^NON DISCLOSURE OTHER",DSIRLOG(182.01)=ORNDI ;182.01
 ; NEW ORND FIELDS IN 7.1
 S ^TMP(AXYN,$J,$$UC)="ORNDJ^"_ORNDJ_"^NON DISCLOSURE MEDICALLY SENSITIVE",DSIRLOG(220.01)=ORNDJ ;220.01
 S ^TMP(AXYN,$J,$$UC)="ORNDK^"_ORNDK_"^NON DISCLOSURE PATIENT DIED BEFORE COMPLETION",DSIRLOG(221.01)=ORNDK ;221.01
 S ^TMP(AXYN,$J,$$UC)="ORNDL^"_ORNDL_"^NON DISCLOSURE PUBLICALLY AVAILABLE",DSIRLOG(222.01)=ORNDL ;222.01
 S ^TMP(AXYN,$J,$$UC)="ORNDM^"_ORNDM_"^NON DISCLOSURE GLOMAR",DSIRLOG(223.01)=ORNDM ;223.01
 S ^TMP(AXYN,$J,$$UC)="ORNDN^"_ORNDN_"^NON DISCLOSURE SUBSUMED BY LITIGATION",DSIRLOG(224.01)=ORNDN ;224.01
 ;PROCESSED REQUESTS
 I 'QUICK S GBL=$NA(^TMP("DSIRCLOSED",$J,"DAYS")),ALLCPXMD=$$MEDCALC^DSIROIR(GBL,ALLCPXCT,4)
 S ^TMP(AXYN,$J,$$UC)="ALLCPXCT^"_ALLCPXCT_"^# OF PERFECTED REQUESTS",DSIRLOG(218.01)=ALLCPXCT ;218.01
 S ^TMP(AXYN,$J,$$UC)="ALLCPXMD^"_ALLCPXMD_"^MEDIAN # OF DAYS COMPLEX REQUESTS",DSIRLOG(183.01)=ALLCPXMD ;183.01
 S:ALLCPXCT>0 ALLCPXAV=(WRKDYTOT/ALLCPXCT)\1
 S ^TMP(AXYN,$J,$$UC)="ALLCPXAV^"_ALLCPXAV_"^AVERAGE # OF DAYS COMPLEX REQUESTS",DSIRLOG(184.01)=ALLCPXAV ;184.01
 S ^TMP(AXYN,$J,$$UC)="ALLCPXLO^"_ALLCPXLO_"^LOWEST # OF DAYS COMPLEX REQUESTS",DSIRLOG(185.01)=ALLCPXLO ;185.01
 S ^TMP(AXYN,$J,$$UC)="ALLCPXHI^"_ALLCPXHI_"^HIGHEST # OF DAYS COMPLEX REQUESTS",DSIRLOG(186.01)=ALLCPXHI ;186.01
 ;GRANTED REQUESTS 
 I 'QUICK S GBL=$NA(^TMP("DSIRGRANT",$J,"DAYS")),GRTCPXMD=$$MEDCALC^DSIROIR(GBL,GRTCPXCT,4)
 S ^TMP(AXYN,$J,$$UC)="GRTCPXCT^"_GRTCPXCT_"^# OF GRANTED PERFECTED REQUESTS",DSIRLOG(219.01)=GRTCPXCT ;219.01
 S ^TMP(AXYN,$J,$$UC)="GRTCPXMD^"_GRTCPXMD_"^MEDIAN # OF DAYS GRANTED REQUESTS",DSIRLOG(187.01)=GRTCPXMD ;187.01
 S:GRTCPXCT>0 GRTCPXAV=(GRANTDYS/GRTCPXCT)\1
 S ^TMP(AXYN,$J,$$UC)="GRTCPXAV^"_GRTCPXAV_"^AVERAGE # OF DAYS GRANTED REQUESTS",DSIRLOG(188.01)=GRTCPXAV ;188.01
 S ^TMP(AXYN,$J,$$UC)="GRTCPXLO^"_GRTCPXLO_"^LOWEST # OF DAYS GRANTED REQUESTS",DSIRLOG(189.01)=GRTCPXLO ;189.01
 S ^TMP(AXYN,$J,$$UC)="GRTCPXHI^"_GRTCPXHI_"^HIGHEST # OF DAYS GRANTED REQUESTS",DSIRLOG(190.01)=GRTCPXHI ;190.01
 ;RESPONSE TIMES 
 S ^TMP(AXYN,$J,$$UC)="RSPTM020^"_RSPTM020_"^NUMBER PROCESSED OR PENDING IN < 21 DAYS",DSIRLOG(191.01)=RSPTM020 ;191.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM040^"_RSPTM040_"^NUMBER PROCESSED OR PENDING IN 21-40 DAYS",DSIRLOG(192.01)=RSPTM040 ;192.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM060^"_RSPTM060_"^NUMBER PROCESSED OR PENDING IN 41-60 DAYS",DSIRLOG(193.01)=RSPTM060 ;193.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM080^"_RSPTM080_"^NUMBER PROCESSED OR PENDING IN 61-80 DAYS",DSIRLOG(194.01)=RSPTM080 ;194.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM100^"_RSPTM100_"^NUMBER PROCESSED OR PENDING IN 81-100 DAYS",DSIRLOG(195.01)=RSPTM100 ;195.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM120^"_RSPTM120_"^NUMBER PROCESSED OR PENDING IN 101-120 DAYS",DSIRLOG(196.01)=RSPTM120 ;196.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM140^"_RSPTM140_"^NUMBER PROCESSED OR PENDING IN 120-140 DAYS",DSIRLOG(197.01)=RSPTM140 ;197.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM160^"_RSPTM160_"^NUMBER PROCESSED OR PENDING IN 141-160 DAYS",DSIRLOG(198.01)=RSPTM160 ;198.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM180^"_RSPTM180_"^NUMBER PROCESSED OR PENDING IN 161-180 DAYS",DSIRLOG(199.01)=RSPTM180 ;199.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM200^"_RSPTM200_"^NUMBER PROCESSED OR PENDING IN 181-200 DAYS",DSIRLOG(200.01)=RSPTM200 ;200.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM300^"_RSPTM300_"^NUMBER PROCESSED OR PENDING IN 201-300 DAYS",DSIRLOG(201.01)=RSPTM300 ;201.01
 S ^TMP(AXYN,$J,$$UC)="RSPTM400^"_RSPTM400_"^NUMBER PROCESSED OR PENDING IN 301-400 DAYS",DSIRLOG(202.01)=RSPTM400 ;202.01
 S ^TMP(AXYN,$J,$$UC)="RSPTMUNL^"_RSPTMUNL_"^NUMBER PROCESSED OR PENDING IN > 400 DAYS",DSIRLOG(203.01)=RSPTMUNL ;203.01
 ;PENDING REQUESTS
 S ^TMP(AXYN,$J,$$UC)="PNDPRFCT^"_PNDPRFCT_"^# OF PENDING REQUESTS",DSIRLOG(217.01)=PNDPRFCT ;217.01
 I 'QUICK S GBL=$NA(^TMP("DSIRPEND",$J,"DAYS")),PNDPRFMD=$$MEDCALC^DSIROIR(GBL,PNDPRFCT,4)
 S ^TMP(AXYN,$J,$$UC)="PNDPRFMD^"_PNDPRFMD_"^MEDIAN # OF DAYS COMPLEX REQUESTS",DSIRLOG(204.01)=PNDPRFMD ;204.01
 S:PNDPRFCT>0 PNDPRFAV=(PNDPRFDY/PNDPRFCT)\1
 S ^TMP(AXYN,$J,$$UC)="PNDPRFAV^"_PNDPRFAV_"^AVERAGE # OF DAYS COMPLEX REQUESTS",DSIRLOG(205.01)=PNDPRFAV ;205.01
 ;EXPEDITED PROCESSING
 S ^TMP(AXYN,$J,$$UC)="EXRQSDCT^"_EXRQSDCT_"^NUMBER REQUESTED EXPEDITED PROCESSING",DSIRLOG(206.01)=EXRQSDCT ;206.01
 S ^TMP(AXYN,$J,$$UC)="EXPRGRNT^"_EXPRGRNT_"^NUMBER GRANTED EXPEDITED PROCESSING",DSIRLOG(207.01)=EXPRGRNT ;207.01
 S ^TMP(AXYN,$J,$$UC)="EXPRDENY^"_EXPRDENY_"^NUMBER DENIED EXPEDITED PROCESSING",DSIRLOG(208.01)=EXPRDENY ;208.01
 I 'QUICK S GBL=$NA(^TMP("DSIREXPADJ",$J,"ADJ")),EXPADJMD=$$MEDCALC^DSIROIR(GBL,EXPADJCT,4)
 S ^TMP(AXYN,$J,$$UC)="EXPADJMD^"_EXPADJMD_"^MEDIAN DAYS TO ADJUDICATE",DSIRLOG(209.01)=EXPADJMD ;209.01
 S:EXPADJCT EXPADJAV=(EXPDAYCT/EXPADJCT)\1
 S ^TMP(AXYN,$J,$$UC)="EXPADJAV^"_EXPADJAV_"^AVERAGE DAYS TO ADJUDICATE EXP PROC",DSIRLOG(210.01)=EXPADJAV ;210.01
 S ^TMP(AXYN,$J,$$UC)="EXPADJ10^"_EXPADJ10_"^NUMBER ADJUDICATED IN < 10 DAYS",DSIRLOG(211.01)=EXPADJ10 ;211.01
 ;FEE WAIVERS
 S ^TMP(AXYN,$J,$$UC)="FWRQSDCT^"_FWRQSDCT_"^NUMBER REQUESTED FEE WAIVERS",DSIRLOG(212.01)=FWRQSDCT ;212.01
 S ^TMP(AXYN,$J,$$UC)="FWGRANT^"_FWGRANT_"^NUMBER GRANTED FEE WAIVERS",DSIRLOG(213.01)=FWGRANT ;213.01
 S ^TMP(AXYN,$J,$$UC)="FWDENY^"_FWDENY_"^NUMBER DENIED FEE WAIVERS",DSIRLOG(214.01)=FWDENY ;214.01
 I 'QUICK S GBL=$NA(^TMP("DSIRFWADJ",$J,"ADJ")),FWADJMED=$$MEDCALC^DSIROIR(GBL,FWADJCT,4)
 S ^TMP(AXYN,$J,$$UC)="FWADJMED^"_FWADJMED_"^MEDIAN DAYS TO ADJUDICATE FEE WAIVERS",DSIRLOG(215.01)=FWADJMED ;215.01
 S:FWADJCT FWADJAVG=(FWDAYCT/FWADJCT)\1
 S ^TMP(AXYN,$J,$$UC)="FWADJAVG^"_FWADJAVG_"^AVERAGE DAYS TO ADJUDICATE FEE WAIVERS",DSIRLOG(216.01)=FWADJAVG ;216.01
 S:'QUICK DSIRLOG=$$LOGFOIA^DSIROI8(STDT,ENDT,.DSIRLOG,DIV)
 Q
