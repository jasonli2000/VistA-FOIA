SWNHADD ;DLG/FARGO;ADD ENTRY TO NURSING HOME FILE;6/1/85
 ;VERSION 1.0;GET ENTRY NUMBER AND ADD FIELDS FOR NEW ENTRY NUMBER AND EDIT FIELDS FOR NEW ENTRY.
 S DIC=658,DIC(0)="ALEQM" K DIC("S") D ^DIC G:Y<0 DONE S (DFN,DA)=+Y S DIE="^SOWK(658,",DR="[SWNHADD]" D ^DIE
 G:'$D(Y) SWNHADD
DONE K DIE,DR,Y,DIC,DFN,DA,%DT,%X,%Y,DQ,I,X,D0,D Q
