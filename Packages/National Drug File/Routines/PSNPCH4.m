PSNPCH4 ;BIR/WRT-PSN*3.18*4 patch routine; 07/10/98 13:26
 ;;3.18; NATIONAL DRUG FILE;**4**;12 Jan 98
 D NODE,NDEX,NDEXDI K DA,IFN,NM,DIK,PSNDEX D ^PSNCNT
 Q
NODE S ^PSNDF(893,5,17,0)="DEXTROMETHORPHAN 10MG/GUAIFENESIN 100MG/5ML (ALC-F) LIQUID^2^1^1^^^1034^44",^PSNDF(893,5,17,1)="2/100/MG/5ML,1/10/MG",^PSNDF(893,5,17,2)="DM 10/GUAIFENESIN 100MG/5ML (ALC-F) LIQ^D0318^1^ML"
 S ^PS(50.416,648,1,261,0)="893A17",^PS(50.416,744,1,449,0)="893A17"
 Q
NDEX S DIK="^PSNDF(",DA=893,DIK(0)="A" D IX^DIK K DA,DIK,DIAU
 S DIK="^PS(50.416,",DA=648,DIK(0)="A" D IX^DIK K DA,DIK,DIAU
 S DIK="^PS(50.416,",DA=744,DIK(0)="A" D IX^DIK K DA,DIK,DIAU
 Q
NDEXDI S NM="" F  S NM=$O(^PS(56,"B",NM)) Q:NM=""  D ONE,TWO,LOOP
 Q
ONE I NM["DEXTROMETHORPHAN" S IEN=$O(^PS(56,"B",NM,0)) S PSNDEX(IEN)=""
 Q
TWO I NM["GUAIFENESIN" S IEN=$O(^PS(56,"B",NM,0)) S PSNDEX(IEN)=""
 Q
LOOP F IFN=0:0 S IFN=$O(PSNDEX(IFN)) Q:'IFN  K DIAU S DIK="^PS(56,",DA=IFN D IX^DIK
 Q
