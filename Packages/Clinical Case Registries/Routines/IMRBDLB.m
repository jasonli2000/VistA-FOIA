IMRBDLB ; HCIOFO/FAI - BACK PULL OF LAB DATA; 03/23/01  10:51
 ;;2.1;IMMUNOLOGY CASE REGISTRY;**13**;Feb 09, 1998
 ;
START S GRP=""
 F  S GRP=$O(^IMR(158.9,1,3,GRP)) Q:GRP=""  S GROUP=$P($G(^IMR(158.9,1,3,GRP,0)),U,1) D CD4,VIRAL,LIPIDS,SEROLH,CHLIV,BLOCN
 Q
CD4 Q:GROUP'=1
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
VIRAL Q:GROUP'=8
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
LIPIDS Q:GROUP'=7
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
SEROLH Q:GROUP'=5
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
CHLIV Q:GROUP'=9
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
BLOCN Q:GROUP'=10
 S GRPNM=$P($G(^IMR(158.95,GROUP,0)),U,1)
 D LABS
 Q
LABS S B="" F  S B=$O(^IMR(158.9,1,3,GRP,B)),C="" Q:B=""  F  S C=$O(^IMR(158.9,1,3,GRP,B,C)),D="" Q:C=""  F  S D=$O(^IMR(158.9,1,3,GRP,B,C,D)),L="" Q:D=""  F  S L=$O(^IMR(158.9,1,3,GRP,B,C,D,"B",L)) Q:L=""  D MATCH
 Q
MATCH S LBNM=$P($G(^LAB(60,L,0)),U,1)
 S NODE=$P($G(^LAB(60,L,0)),U,5)
 Q:NODE=""
 S IMRDTNM=$P(NODE,";",2)
 S IMRVALS(IMRDTNM)=""
 Q
CLEAR ; Kill Variables
 K IMRT1,IMRT2,DFN,IMRLD,IMRLD1,IMRLD2
 Q
