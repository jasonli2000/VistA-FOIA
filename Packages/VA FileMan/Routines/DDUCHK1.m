DDUCHK1 ;SFISC/RWF-CHECK DD part 2 ;8/28/94  06:48
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ID S DDUCRFE="" F DDUCZ=0:0 S DDUCRFE=$O(^DD(DDUCFI,0,"ID",DDUCRFE)) Q:DDUCRFE=""  S DDUCX=$S($D(^DD(DDUCFI,0,"ID",DDUCRFE))#2:^(DDUCRFE),1:"") I DDUCX="Q" W !?5,"'ID' node for field ",DDUCRFE," = 'Q'" D:DDUCFIX ID1
 Q
ID1 K ^DD(DDUCFI,0,"ID",DDUCRFE) D M1 W """ID"",",DDUCRFE D M2
 Q
IX S DDUCXREF="" F DDUCZ=0:0 S DDUCXREF=$O(^DD(DDUCFI,0,"IX",DDUCXREF)) Q:DDUCXREF=""  F DDUCRFI=0:0 S DDUCRFI=$O(^DD(DDUCFI,0,"IX",DDUCXREF,DDUCRFI)) Q:DDUCRFI'>0  D IX1
 Q
IX1 F DDUCRFE=0:0 S DDUCRFE=$O(^DD(DDUCFI,0,"IX",DDUCXREF,DDUCRFI,DDUCRFE)) Q:DDUCRFE'>0  D
 . I $D(^DD(DDUCRFI,DDUCRFE,0))[0 D WFI,WFE,WMS D:DDUCFIX IX2 Q
 . I $D(^DD(DDUCRFI,DDUCRFE,1,0))=0,$D(^DD(DDUCRFI,DDUCRFE,1))=10 S:DDUCFIX ^DD(DDUCRFI,DDUCRFE,1,0)="^.1"
 . S DDUCRFE1=0,DDUCRFEX="" F  S DDUCRFE1=$O(^DD(DDUCRFI,DDUCRFE,1,DDUCRFE1)) Q:DDUCRFE1'>0  S DDUCRFEX=$G(^(DDUCRFE1,0)) I $P(DDUCRFEX,U,2)=DDUCXREF K DDUCRFEX Q
 . I $D(DDUCRFEX) W !?5,"Cross-reference logic is missing for """,DDUCXREF,""" x-ref" D:DDUCFIX IX2 Q
 K DDUCRFE1 Q
IX2 K ^DD(DDUCFI,0,"IX",DDUCXREF,DDUCRFI,DDUCRFE) D M1 W """IX"",",DDUCXREF_","_DDUCRFI_","_DDUCRFE D M2
 Q
PT F DDUCRFI=0:0 S DDUCRFI=$O(^DD(DDUCFI,0,"PT",DDUCRFI)) Q:DDUCRFI'>0  F DDUCRFE=0:0 S DDUCRFE=$O(^DD(DDUCFI,0,"PT",DDUCRFI,DDUCRFE)) Q:DDUCRFE'>0  D PT1
 Q
PT1 I $D(^DD(DDUCRFI,0))[0 D WFI,WMS I DDUCFIX K ^DD(DDUCFI,0,"PT",DDUCRFI) D M1 W """PT"",",DDUCRFI D M2 Q
 I $D(^DD(DDUCRFI,DDUCRFE,0))[0 D WFI,WFE,WMS D:DDUCFIX PTM Q
 I ($P(^(0),U,2)'["P")&($P(^(0),U,2)'["V") D WFI,WFE W "is not a pointer." D:DDUCFIX PTM Q
 I $P(^(0),U,2)["P",+$P($P(^(0),U,2),"P",2)'=DDUCFI D WFI,WFE W "is not a pointer to file ",DDUCFI D:DDUCFIX PTM
 Q
PTM K ^DD(DDUCFI,0,"PT",DDUCRFI,DDUCRFE)
 D M1 W """PT"",",DDUCRFI,",",DDUCRFE D M2
 Q
AC F DDUCFE=0:0 S DDUCFE=$O(^DD("ACOMP",DDUCFI,DDUCFE)) Q:DDUCFE'>0  D AC1
 Q
AC1 F DDUCRFI=0:0 S DDUCRFI=$O(^DD("ACOMP",DDUCFI,DDUCFE,DDUCRFI)) Q:DDUCRFI'>0  F DDUCRFE=0:0 S DDUCRFE=$O(^DD("ACOMP",DDUCFI,DDUCFE,DDUCRFI,DDUCRFE)) Q:DDUCRFE'>0  D AC2
 Q
AC2 I $D(^DD(DDUCRFI,DDUCRFE,0))[0 D:DDUCFIX ACM Q
 S DDUCX=^(0) I $P(DDUCX,U,2)'["C" D:DDUCFIX ACM Q
 I $P(DDUCX,U,2)["C" S DDUCX1=$S($D(^(9.01)):^(9.01),1:""),DDUCF=0 D AC3
 Q
AC3 F DDUCZ=1:1 S DDUCX2=$P(DDUCX1,";",DDUCZ) Q:DDUCX2=""  I DDUCX2=DDUCFI_U_DDUCFE S DDUCF=1 Q
 I 'DDUCF D:DDUCFIX ACM
 Q
ACM K ^DD("ACOMP",DDUCFI,DDUCFE,DDUCRFI,DDUCRFE)
 Q
NM S DDUCRFI(1)=$S($D(^DIC(DDUCFI,0))#2:$P(^(0),U),1:$P(^DD(DDUCFI,0)," SUB-FIELD"))
 Q:DDUCRFI(1)']""  K ^DD(DDUCFI,0,"NM") S ^DD(DDUCFI,0,"NM",DDUCRFI(1))="" W !?10,"Duplicate ""NM"" node was deleted."
 Q
WHO W !?5,"Field: ",DDUCFE," (",$P(DDUCX,U),") " Q
WFI W !?5,"File: ",DDUCRFI," " Q
WFE W ?5,"Field: ",DDUCRFE," " Q
WMS W "is missing." Q
M1 W !?10,"^DD(",DDUCFI,",0," Q
M2 W ") was killed." Q
